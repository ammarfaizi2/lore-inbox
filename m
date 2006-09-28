Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932095AbWI1VgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbWI1VgZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 17:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbWI1VgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 17:36:25 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:48035 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S932095AbWI1VgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 17:36:24 -0400
Date: Thu, 28 Sep 2006 23:35:58 +0200
From: Jan Kara <jack@suse.cz>
To: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
Cc: Jan Kara <jack@suse.cz>, akpm@osdl.org,
       LKML <linux-kernel@vger.kernel.org>,
       Badari Pulavarty <pbadari@us.ibm.com>, fedora-ia64-list@redhat.com
Subject: Re: [PATCH] Fix commit of ordered data buffers
Message-ID: <20060928213558.GC15478@atrey.karlin.mff.cuni.cz>
References: <20060911210530.GA28445@atrey.karlin.mff.cuni.cz> <1159432266.20092.700.camel@ymzhang-perf.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159432266.20092.700.camel@ymzhang-perf.sh.intel.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

> On Tue, 2006-09-12 at 05:05, Jan Kara wrote:
> >   Hi Andrew,
> > 
> >   here is the patch that came out of the thread "set_page_buffer_dirty
> > should skip unmapped buffers". It fixes several flaws in the code
> > writing out ordered data buffers during commit. It definitely fixed the
> > problem Badari was seeing with fsx-linux test.  Could you include it
> > into -mm? Since there are quite complex interactions with other JBD code
> > and the locking is kind of ugly, I'd leave it in -mm for a while whether
> > some bug does not emerge ;). Thanks.
> > 
> > 								Honza
> I also worked on it because I didn't know you were working on it until I
> located the root cause and tried to check bugzilla.
> 
> I reviewed your patch.
> 
> +		if (!inverted_lock(journal, bh)) {
> +			jbd_lock_bh_state(bh);
> +			spin_lock(&journal->j_list_lock);
> +		}
> Should journal->j_list_lock be unlocked before jbd_lock_bh_state(bh)?
  It does not matter... The ordering of locking matters, ordering of
unlocking does not.

> The fsx-linux test issue is a race between journal_commit_transaction
> and journal_dirty_data. After journal_commit_transaction adds buffer_head pointers
> to wbuf, it might unlock journal->j_list_lock. Although all buffer head in wbuf are locked,
> does that prevent journal_dirty_data from unlinking the buffer head from the transaction
> and fsx-linux from truncating it?
  Yes, it does. Because the buffers are locked *and dirty*. Nothing can
clear the dirty bit while we are holding the lock and
journal_dirty_data() also waits until it can safely write out the buffer
- which is after we release the buffer lock.

> I'm not a journal expert. But I want to discuss it.
> 
> My investigation is below (Scenario):
> 
> fsx-linux starts journal_dirty_data and journal_dirty_data links a jh to
> journal->j_running_transaction's t_sync_datalist, kjournald might not
> write the buffer to disk quickly, but saves it to array wbuf.
> Then, fsx-linux starts the second journal_dirty_data of a new transaction
> might submit the same buffer head and move the jh to the new transaction's
> t_sync_datalist.
  Yes, but this happens only after the buffer is removed from wbuf[] as
I explain above.

> Then, fsx-linux truncates the last a couple of buffers of a page.
> Then, block_write_full_page calls invalidatepage to invalidate the last a couple
> of buffers of the page, so the journal_heads of the buffer_head are unlinked and
> are marked as unmapped.
> Then, fsx-linux extend the file and does a msync after changing the page content
> by mmaping the page, so the page (inclduing the last buffer head) is marked dirty
> again.
> Then, kjournald's journal_commit_transaction goes through wbuf to submit_bh all
> dirty buffers, but one buffer head is already marked as unmapped. A bug check is
> triggerred.
> 
> >From above scenario, as long as the late calls doesn't try to lock the buffer head,
> the race condition still exists.
> 
> I think the right way is to let journal_dirty_data to wait till wbuf is flushed.
  This actually happens in my fix too. And my fix has also a bonus of
fixing a few other flaws... Otherwise your patch seems to be right.

									Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
