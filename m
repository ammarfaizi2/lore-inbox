Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261373AbVDUHV3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbVDUHV3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 03:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbVDUHV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 03:21:29 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:27056 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261373AbVDUHVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 03:21:02 -0400
Subject: Re: [patch] fix race in __block_prepare_write (again)
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Andrea Arcangeli <andrea@suse.de>
In-Reply-To: <1114067401.11293.3.camel@imp.csi.cam.ac.uk>
References: <1114064046.5182.13.camel@npiggin-nld.site>
	 <Pine.LNX.4.60.0504210757220.3348@hermes-1.csi.cam.ac.uk>
	 <1114067401.11293.3.camel@imp.csi.cam.ac.uk>
Content-Type: multipart/mixed; boundary="=-EyMFt0KvBlwbwARxxuGj"
Date: Thu, 21 Apr 2005 17:20:57 +1000
Message-Id: <1114068058.5182.22.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-EyMFt0KvBlwbwARxxuGj
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2005-04-21 at 08:10 +0100, Anton Altaparmakov wrote:
> And one more thing...
> 
> On Thu, 2005-04-21 at 08:01 +0100, Anton Altaparmakov wrote:
> > On Thu, 21 Apr 2005, Nick Piggin wrote:
> > > ... I somehow didn't send it to Andrew last time.
> > > 
> > > Fix a race where __block_prepare_write can leak out an in-flight
> > > read against a bh if get_block returns an error. This can lead to
> > > the page becoming unlocked while the buffer is locked and the read
> > > still in flight. __mpage_writepage BUGs on this condition.
> > [snip]
> > > --- linux-2.6.orig/fs/buffer.c	2005-04-21 11:55:17.549614278 
> > +1000
> > > +++ linux-2.6/fs/buffer.c	2005-04-21 15:55:41.483826075 +1000
> > > @@ -1988,6 +1988,7 @@
> > >  			*wait_bh++=bh;
> > >  		}
> > >  	}
> > > +out:
> > >  	/*
> > >  	 * If we issued read requests - let them complete.
> > >  	 */
> > > @@ -1996,8 +1997,9 @@
> > >  		if (!buffer_uptodate(*wait_bh))
> > >  			return -EIO;
> 
> This return is now wrong after your patch.  It should be "err = -EIO;"
> otherwise you do not zero newly allocated blocks and thus risk exposing
> stale data on buffer i/o errors. 
> 

Hmm yeah I should have been more careful. But isn't that another bug? I
mean, wasn't that wrong *before* my patch as well?

It was, right? Because not only might it return without having waited
for all in-flight buffers, but it also didn't zero the blocks on errors?


--=-EyMFt0KvBlwbwARxxuGj
Content-Disposition: attachment; filename=__block_prepare_write-bug.patch
Content-Type: text/x-patch; name=__block_prepare_write-bug.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Fix a race where __block_prepare_write can leak out an in-flight
read against a bh if get_block returns an error. This can lead to
the page becoming unlocked while the buffer is locked and the read
still in flight. __mpage_writepage BUGs on this condition.

BUG sighted on a 2-way Itanium2 system with 16K PAGE_SIZE running

	fsstress -v -d $DIR/tmp -n 1000 -p 1000 -l 2
	
where $DIR is a new ext2 filesystem with 4K blocks that is quite
small (causing get_block to fail often with -ENOSPC).

Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>

Index: linux-2.6/fs/buffer.c
===================================================================
--- linux-2.6.orig/fs/buffer.c	2005-04-21 11:55:17.549614278 +1000
+++ linux-2.6/fs/buffer.c	2005-04-21 17:20:06.149176996 +1000
@@ -1952,7 +1952,7 @@
 		if (!buffer_mapped(bh)) {
 			err = get_block(inode, block, bh, 1);
 			if (err)
-				goto out;
+				break;
 			if (buffer_new(bh)) {
 				clear_buffer_new(bh);
 				unmap_underlying_metadata(bh->b_bdev,
@@ -1994,10 +1994,12 @@
 	while(wait_bh > wait) {
 		wait_on_buffer(*--wait_bh);
 		if (!buffer_uptodate(*wait_bh))
-			return -EIO;
+			err = -EIO;
 	}
-	return 0;
-out:
+	if (!err)
+		return err;
+
+	/* Error case: */
 	/*
 	 * Zero out any newly allocated blocks to avoid exposing stale
 	 * data.  If BH_New is set, we know that the block was newly

--=-EyMFt0KvBlwbwARxxuGj--


