Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751434AbWIFQPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbWIFQPs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 12:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbWIFQPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 12:15:48 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:34537 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751385AbWIFQPq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 12:15:46 -0400
Subject: Re: [RFC][PATCH] set_page_buffer_dirty should skip unmapped buffers
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Jan Kara <jack@suse.cz>
Cc: Andrew Morton <akpm@osdl.org>, Anton Altaparmakov <aia21@cam.ac.uk>,
       sct@redhat.com, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>, ext4 <linux-ext4@vger.kernel.org>
In-Reply-To: <20060906153449.GC18281@atrey.karlin.mff.cuni.cz>
References: <1157125829.30578.6.camel@dyn9047017100.beaverton.ibm.com>
	 <Pine.LNX.4.64.0609011652420.24650@hermes-2.csi.cam.ac.uk>
	 <1157128342.30578.14.camel@dyn9047017100.beaverton.ibm.com>
	 <20060901101801.7845bca2.akpm@osdl.org>
	 <1157472702.23501.12.camel@dyn9047017100.beaverton.ibm.com>
	 <20060906124719.GA11868@atrey.karlin.mff.cuni.cz>
	 <1157555559.23501.25.camel@dyn9047017100.beaverton.ibm.com>
	 <20060906153449.GC18281@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain
Date: Wed, 06 Sep 2006 09:19:05 -0700
Message-Id: <1157559545.23501.30.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-06 at 17:34 +0200, Jan Kara wrote:
> > On Wed, 2006-09-06 at 14:47 +0200, Jan Kara wrote:
> > 
> > > > Andrew, what should we do ? Do you suggest handling this in jbd
> > > > itself (like this patch) ?
> > >   Actually that part of commit code needs rewrite anyway (and after that
> > > rewrite you get rid of ll_rw_block()) because of other problems - the
> > > code assumes that whenever buffer is locked, it is being written to disk
> > > which is not true... I have some preliminary patches for that but they
> > > are not very nice and so far I didn't have enough time to find a nice
> > > solution.
> > 
> > Are you okay with current not-so-elegant fix ? 
>   Actually I don't quite understand how it can happen what you describe
> (so probably I missed something). How it can happen that some buffers
> are unmapped while we are committing them?  journal_unmap_buffers()
> checks whether we are not committing truncated buffers and if so, it
> does not do anything to such buffers...
> 							Bye
> 								Honza

Yep. I spent lot of time trying to understand - why they are not
getting skipped :(

But my debug clearly shows that we are clearing the buffer, while
we haven't actually submitted to ll_rw_block() code. (I added "track"
flag to bh and set it in journal_commit_transaction() when we add
them to wbuf[] and clear it in ll_rw_block() after submit. I checked
for this flag in journal_unmap_buffer() while clearing the buffer).
Here is what my debug shows:

buffer is tracked bh ffff8101686ea850 size 1024 

Call Trace:
 [<ffffffff8020b395>] show_trace+0xb5/0x370
 [<ffffffff8020b665>] dump_stack+0x15/0x20
 [<ffffffff8030d474>] journal_invalidatepage+0x314/0x3b0
 [<ffffffff802fe948>] ext3_invalidatepage+0x38/0x40
 [<ffffffff80282750>] do_invalidatepage+0x20/0x30
 [<ffffffff80260613>] truncate_complete_page+0x23/0x50
 [<ffffffff8026070d>] truncate_inode_pages_range+0xcd/0x300
 [<ffffffff80260950>] truncate_inode_pages+0x10/0x20
 [<ffffffff802686ff>] vmtruncate+0x5f/0x100
 [<ffffffff8029d880>] inode_setattr+0x30/0x140
 [<ffffffff802ff8cb>] ext3_setattr+0x1bb/0x230
 [<ffffffff8029daee>] notify_change+0x15e/0x320
 [<ffffffff8027f973>] do_truncate+0x53/0x80
 [<ffffffff802800f8>] sys_ftruncate+0xf8/0x130
 [<ffffffff80209d5a>] system_call+0x7e/0x83

Thanks,
Badari

