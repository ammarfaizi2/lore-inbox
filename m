Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751240AbWC1FGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbWC1FGM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 00:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbWC1FGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 00:06:12 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:34950 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751241AbWC1FGM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 00:06:12 -0500
Date: Tue, 28 Mar 2006 16:01:35 +1100
From: Nathan Scott <nathans@sgi.com>
To: Badari Pulavarty <pbadari@us.ibm.com>,
       Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: kernel BUG at fs/direct-io.c:916!
Message-ID: <20060328050135.GA2177@frodo>
References: <20060326230206.06C1EE083AAB@knarzkiste.dyndns.org> <20060326180440.GA4776@charite.de> <20060326184644.GC4776@charite.de> <20060327080811.D753448@wobbly.melbourne.sgi.com> <20060326230358.GG4776@charite.de> <20060327060436.GC2481@frodo> <20060327110342.GX21946@charite.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060327110342.GX21946@charite.de>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2006 at 01:03:42PM +0200, Ralf Hildebrandt wrote:
> * Nathan Scott <nathans@sgi.com>:
> > On Mon, Mar 27, 2006 at 01:03:59AM +0200, Ralf Hildebrandt wrote:
> > > * Nathan Scott <nathans@sgi.com>:
> > > 
> > > > Hmm, there were XFS patches in -mm last week, but they also got
> > > > merged to mainline last week, not clear whether your git kernel
> > > > had those changes or not.  I think there's probably some direct
> > > > I/O (generic) changes in -mm too based on list traffic from the
> > > > last couple of weeks (I'm an -mm lamer, sorry, couldn't easily
> > > > tell you exactly what patches those might be) - could you retry
> > > > with todays git snapshot and see if mainline is affected?  Else
> > > > we'll need to find and analyse any -mm fs/direct-io.c patches.
> > > 
> > > 2.6.16-git12 also fails utterly:
> > 
> > Could you also try reverting this patch:
> > 
> > http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=1d8fa7a2b9a39d18727acc5c468e870df606c852
> > 
> > and let me know if the problem still happens?
> 
> Reverting this particular patch does ELIMINATE the problem.
> Excellent!

OK, I think I see whats gone wrong here now.  Ralf, could you try
the patch below and check that it fixes your test case?

Badari, it looks like a regression from the "remove ->get_blocks()
support" patch - can you look over the fix below and confirm/deny
please?  

I'm definately seeing block mapping requests that are smaller than
the filesystem block size coming into XFS from direct-io.c - and it
looks like that eventually blows up in do_direct_IO if dio_remainder
becomes set and we could only map one block (if dio->blocks_available
was 1 after get_more_blocks).  We'll reduce that to zero right at the
end of the branch that calls get_more_blocks in do_direct_IO... and
mayhem ensues further on.

I have a couple of other .17 changes pending, if you could ACK this
I'll get it merged in for ya.

cheers.

-- 
Nathan


Index: xfs-linux-2.6/fs/direct-io.c
===================================================================
--- xfs-linux-2.6.orig/fs/direct-io.c
+++ xfs-linux-2.6/fs/direct-io.c
@@ -524,8 +524,6 @@ static int get_more_blocks(struct dio *d
 	 */
 	ret = dio->page_errors;
 	if (ret == 0) {
-		map_bh->b_state = 0;
-		map_bh->b_size = 0;
 		BUG_ON(dio->block_in_file >= dio->final_block_in_request);
 		fs_startblk = dio->block_in_file >> dio->blkfactor;
 		dio_count = dio->final_block_in_request - dio->block_in_file;
@@ -534,6 +532,9 @@ static int get_more_blocks(struct dio *d
 		if (dio_count & blkmask)	
 			fs_count++;
 
+		map_bh->b_state = 0;
+		map_bh->b_size = fs_count << dio->inode->i_blkbits;
+
 		create = dio->rw == WRITE;
 		if (dio->lock_type == DIO_LOCKING) {
 			if (dio->block_in_file < (i_size_read(dio->inode) >>
@@ -542,13 +543,13 @@ static int get_more_blocks(struct dio *d
 		} else if (dio->lock_type == DIO_NO_LOCKING) {
 			create = 0;
 		}
+
 		/*
 		 * For writes inside i_size we forbid block creations: only
 		 * overwrites are permitted.  We fall back to buffered writes
 		 * at a higher level for inside-i_size block-instantiating
 		 * writes.
 		 */
-		map_bh->b_size = fs_count << dio->blkbits;
 		ret = (*dio->get_block)(dio->inode, fs_startblk,
 						map_bh, create);
 	}
