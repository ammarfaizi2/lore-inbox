Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267320AbSLEN1o>; Thu, 5 Dec 2002 08:27:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267321AbSLEN1o>; Thu, 5 Dec 2002 08:27:44 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:6243 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S267320AbSLEN1n>; Thu, 5 Dec 2002 08:27:43 -0500
Date: Thu, 5 Dec 2002 13:36:27 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Michael <soppscum@online.no>
cc: Christoph Hellwig <hch@lst.de>, <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.5.47-xfs[cvs] Oops when mounting ISO image.
In-Reply-To: <20021205132649.5be6fded.soppscum@online.no>
Message-ID: <Pine.LNX.4.44.0212051316550.1405-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Dec 2002, Michael wrote:
> Firstly, this is truly a terrific kernel(for me), fixed alot of stability issues I had.
> Have to wonder why keyboard/mouse support is so well "hidden" though =)
> Anyway, my issue is a 'oops' whenever I mount a ISO image file.
> (I have compiled the loop device as a module)
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
> Code:  Bad EIP value.
> 
> Trace; c01cea8c <pagebuf_offset+1f8c/eb00>
> Trace; ec9d4540 <[loop]lo_read_actor+0/100>
> Trace; ec9d46d2 <[loop]do_lo_receive+92/a0>
> Trace; ec9d4540 <[loop]lo_read_actor+0/100>

If your xfs[cvs] resembles the xfs source in 2.5.50-mm1, then it looks
to me like fs/xfs/linux has a .sendfile = linvfs_sendfile in xfs_file.c
(which assures the loop driver it can loop this file for reading), but
lacks a .vop_ioctl = xfs_sendfile (and its extern) in xfs_vnodeops.c.

But I've not delved into XFS, for all I know that code may not be ready
to use yet: Christoph can say.  And to get further with the 2.5.47 loop,
you'll also need this patch (in 2.5.48):

--- 2.5.47/drivers/block/loop.c	Mon Nov 11 12:34:14 2002
+++ linux/drivers/block/loop.c	Mon Nov 11 15:44:33 2002
@@ -304,21 +304,16 @@
 {
 	struct lo_read_data cookie;
 	struct file *file;
-	int error;
+	int retval;
 
 	cookie.lo = lo;
 	cookie.data = kmap(bvec->bv_page) + bvec->bv_offset;
 	cookie.bsize = bsize;
-
-	/* umm, what does this lock actually try to protect? */
-	spin_lock_irq(&lo->lo_lock);
 	file = lo->lo_backing_file;
-	spin_unlock_irq(&lo->lo_lock);
-
-	error = file->f_op->sendfile(file, &pos, bvec->bv_len,
+	retval = file->f_op->sendfile(file, &pos, bvec->bv_len,
 			lo_read_actor, &cookie);
 	kunmap(bvec->bv_page);
-	return error;
+	return (retval < 0)? retval: 0;
 }
 
 static int

