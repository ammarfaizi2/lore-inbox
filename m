Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751031AbWJLM2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031AbWJLM2f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 08:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbWJLM2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 08:28:35 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:47055 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751031AbWJLM2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 08:28:34 -0400
Date: Thu, 12 Oct 2006 14:28:20 +0200
From: Jan Kara <jack@suse.cz>
To: Eric Sandeen <esandeen@redhat.com>
Cc: Badari Pulavarty <pbadari@us.ibm.com>, Eric Sandeen <sandeen@sandeen.net>,
       Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18 ext3 panic.
Message-ID: <20061012122820.GK9495@atrey.karlin.mff.cuni.cz>
References: <20061009225036.GC26728@redhat.com> <20061010141145.GM23622@atrey.karlin.mff.cuni.cz> <452C18A6.3070607@redhat.com> <1160519106.28299.4.camel@dyn9047017100.beaverton.ibm.com> <452C4C47.2000107@sandeen.net> <20061011103325.GC6865@atrey.karlin.mff.cuni.cz> <452CF523.5090708@sandeen.net> <20061011142205.GB24508@atrey.karlin.mff.cuni.cz> <1160589284.1447.19.camel@dyn9047017100.beaverton.ibm.com> <452DAA26.6080200@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <452DAA26.6080200@redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Badari Pulavarty wrote:
> 
> >Here is what I think is happening..
> >
> >journal_unmap_buffer() - cleaned the buffer, since its outside EOF, but
> >its a part of the same page. So it remained on the page->buffers
> >list. (at this time its not part of any transaction).
> >
> >Then, ordererd_commit_write() called journal_dirty_data() and we added
> >all these buffers to BJ_SyncData list. (at this time buffer is clean -
> >not dirty).
> >
> >Now msync() called __set_page_dirty_buffers() and dirtied *all* the
> >buffers attached to this page.
> >
> >journal_submit_data_buffers() got around to this buffer and tried to
> >submit the buffer...
  Yes, this is certainly one we need to fix.

> This seems about right, but one thing bothers me in the traces; it seems 
> like there is some locking that is missing.  In
> http://people.redhat.com/esandeen/traces/eric_ext3_oops1.txt
> for example, it looks like journal_dirty_data gets started, but then the 
> buffer_head is acted on by journal_unmap_buffer, which decides this buffer 
> is part of the running transaction, past EOF, and clears mapped, dirty, 
  It's part of the committing transaction.

> etc.  Then journal_dirty_data picks up again, decides that the buffer is 
> not on the right list (now BJ_None) and puts it back on BJ_SyncData.  Then 
> it gets picked up by journal_submit_data_buffers and submitted, and oops.
  Now it is put on the running transaction's BJ_SyncData list. But
otherwise you're right.

> Talking with Stephen, it seemed like the page lock should synchronize these 
> threads, but I've found that we can get to journal_dirty_data acting on the 
> buffer heads w/o having the page locked...
  Yes, PageLock should protect us. Where can we call
journal_dirty_data() without PageLock? I see the following callers:
  ext3_ordered_commit_write - should have PageLock
  ext3_ordered_writepage - has PageLock
  ext3_block_truncate_page - has PageLock

  And that are all callers from ext3. Am I missing something?

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
