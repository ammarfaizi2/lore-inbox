Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751488AbWIFQ1T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbWIFQ1T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 12:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbWIFQ1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 12:27:19 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:52662 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751480AbWIFQ1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 12:27:17 -0400
Date: Wed, 6 Sep 2006 18:27:23 +0200
From: Jan Kara <jack@suse.cz>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Anton Altaparmakov <aia21@cam.ac.uk>,
       sct@redhat.com, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>, ext4 <linux-ext4@vger.kernel.org>
Subject: Re: [RFC][PATCH] set_page_buffer_dirty should skip unmapped buffers
Message-ID: <20060906162723.GA14345@atrey.karlin.mff.cuni.cz>
References: <1157125829.30578.6.camel@dyn9047017100.beaverton.ibm.com> <Pine.LNX.4.64.0609011652420.24650@hermes-2.csi.cam.ac.uk> <1157128342.30578.14.camel@dyn9047017100.beaverton.ibm.com> <20060901101801.7845bca2.akpm@osdl.org> <1157472702.23501.12.camel@dyn9047017100.beaverton.ibm.com> <20060906124719.GA11868@atrey.karlin.mff.cuni.cz> <1157555559.23501.25.camel@dyn9047017100.beaverton.ibm.com> <20060906153449.GC18281@atrey.karlin.mff.cuni.cz> <1157559545.23501.30.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157559545.23501.30.camel@dyn9047017100.beaverton.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 2006-09-06 at 17:34 +0200, Jan Kara wrote:
> > > On Wed, 2006-09-06 at 14:47 +0200, Jan Kara wrote:
> > > 
> > > > > Andrew, what should we do ? Do you suggest handling this in jbd
> > > > > itself (like this patch) ?
> > > >   Actually that part of commit code needs rewrite anyway (and after that
> > > > rewrite you get rid of ll_rw_block()) because of other problems - the
> > > > code assumes that whenever buffer is locked, it is being written to disk
> > > > which is not true... I have some preliminary patches for that but they
> > > > are not very nice and so far I didn't have enough time to find a nice
> > > > solution.
> > > 
> > > Are you okay with current not-so-elegant fix ? 
> >   Actually I don't quite understand how it can happen what you describe
> > (so probably I missed something). How it can happen that some buffers
> > are unmapped while we are committing them?  journal_unmap_buffers()
> > checks whether we are not committing truncated buffers and if so, it
> > does not do anything to such buffers...
> > 							Bye
> > 								Honza
> 
> Yep. I spent lot of time trying to understand - why they are not
> getting skipped :(
> 
> But my debug clearly shows that we are clearing the buffer, while
> we haven't actually submitted to ll_rw_block() code. (I added "track"
> flag to bh and set it in journal_commit_transaction() when we add
> them to wbuf[] and clear it in ll_rw_block() after submit. I checked
> for this flag in journal_unmap_buffer() while clearing the buffer).
> Here is what my debug shows:
> 
> buffer is tracked bh ffff8101686ea850 size 1024 
> 
> Call Trace:
>  [<ffffffff8020b395>] show_trace+0xb5/0x370
>  [<ffffffff8020b665>] dump_stack+0x15/0x20
>  [<ffffffff8030d474>] journal_invalidatepage+0x314/0x3b0
  I see just journal_invalidatepage() here. That is fine. It calls
journal_unmap_buffer() which should do nothing return 0. If it does
not it would be IMO bug.. If the buffer is really unmapped here, in what
state it is (i.e. which list is it on?).

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
