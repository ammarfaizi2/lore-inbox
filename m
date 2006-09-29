Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750826AbWI2JWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbWI2JWT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 05:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbWI2JWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 05:22:19 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:35037 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1750826AbWI2JWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 05:22:18 -0400
Date: Fri, 29 Sep 2006 11:21:54 +0200
From: Jan Kara <jack@suse.cz>
To: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
Cc: akpm@osdl.org, LKML <linux-kernel@vger.kernel.org>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       ia64 Fedora Core Development <fedora-ia64-list@redhat.com>
Subject: Re: [PATCH] Fix commit of ordered data buffers
Message-ID: <20060929092154.GC17124@atrey.karlin.mff.cuni.cz>
References: <20060911210530.GA28445@atrey.karlin.mff.cuni.cz> <1159432266.20092.700.camel@ymzhang-perf.sh.intel.com> <20060928213558.GC15478@atrey.karlin.mff.cuni.cz> <1159493244.20092.718.camel@ymzhang-perf.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159493244.20092.718.camel@ymzhang-perf.sh.intel.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

> On Fri, 2006-09-29 at 05:35, Jan Kara wrote:
> > > The fsx-linux test issue is a race between journal_commit_transaction
> > > and journal_dirty_data. After journal_commit_transaction adds buffer_head pointers
> > > to wbuf, it might unlock journal->j_list_lock. Although all buffer head in wbuf are locked,
> > > does that prevent journal_dirty_data from unlinking the buffer head from the transaction
> > > and fsx-linux from truncating it?
> >   Yes, it does. Because the buffers are locked *and dirty*. Nothing can
> > clear the dirty bit while we are holding the lock and
> > journal_dirty_data() also waits until it can safely write out the buffer
> > - which is after we release the buffer lock.
> With your patch, it's not true because journal_submit_data_buffers clear the dirty
> flag, so later journal_dirty_data won't try to lock/flush the buffer. journal_dirty_data
> would just move the jh to the t_sync_datalist of a new transaction.
  Umm, yes. You're right, my previous explanation was bogus. But that
should do no harm as we do not touch the journal_head of the buffer in
wbuf array. We just eventually send it to disk. We are guarded against
truncate/memory pressure because we hold the buffer lock so that should
be fine too.

> > > I'm not a journal expert. But I want to discuss it.
> > > 
> > > My investigation is below (Scenario):
> > > 
> > > fsx-linux starts journal_dirty_data and journal_dirty_data links a jh to
> > > journal->j_running_transaction's t_sync_datalist, kjournald might not
> > > write the buffer to disk quickly, but saves it to array wbuf.
> > > Then, fsx-linux starts the second journal_dirty_data of a new transaction
> > > might submit the same buffer head and move the jh to the new transaction's
> > > t_sync_datalist.
> >   Yes, but this happens only after the buffer is removed from wbuf[] as
> > I explain above.
> > 
> > > Then, fsx-linux truncates the last a couple of buffers of a page.
> > > Then, block_write_full_page calls invalidatepage to invalidate the last a couple
> > > of buffers of the page, so the journal_heads of the buffer_head are unlinked and
> > > are marked as unmapped.
> > > Then, fsx-linux extend the file and does a msync after changing the page content
> > > by mmaping the page, so the page (inclduing the last buffer head) is marked dirty
> > > again.
> > > Then, kjournald's journal_commit_transaction goes through wbuf to submit_bh all
> > > dirty buffers, but one buffer head is already marked as unmapped. A bug check is
> > > triggerred.
> I think the reason that your patch fixes it is that journal_invalidatepage
> will lock the buffer before calling journal_unmap_buffer. So the last step to trigger
> the bug will be synced with journal_commit_transaction.
> 
> > I think the right way is to let journal_dirty_data to wait till wbuf is flushed.
> >   This actually happens in my fix too. And my fix has also a bonus of
> > fixing a few other flaws... Otherwise your patch seems to be right.
> Other flaws could be fixed by other small patches to make it clearer.
  Actually not quite - I've been thinking about the other problems for
quite some while and I did not find a way to fix other flaws in a
non-intrusive way. I also like small and clean fixes but sometimes one
has to simply rewrite the code...

							Bye
								Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
