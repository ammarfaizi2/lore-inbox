Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267149AbSKMJ34>; Wed, 13 Nov 2002 04:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267150AbSKMJ3z>; Wed, 13 Nov 2002 04:29:55 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:19897 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id <S267149AbSKMJ3y>; Wed, 13 Nov 2002 04:29:54 -0500
Date: Wed, 13 Nov 2002 09:37:44 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: "Tomasz Torcz, BG" <zdzichu@irc.pl>
cc: linux-kernel@vger.kernel.org
Subject: Re: Uninitialised timer in 2.5.47
In-Reply-To: <20021113061147.GB19447@irc.pl>
Message-ID: <Pine.LNX.4.44.0211130933550.1512-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Nov 2002, Tomasz Torcz, BG wrote:
> 
> today I've booted 2.5.47 and got some unpleasant, oopslooking
> messages. It's looks like some debugging info.
> I'm including dmegs output, as it seems to contain enough info.
> If any more info is needed, I will happily provide it.
> ...
> Buffer I/O error on device loop(7,0), logical block 0
> Buffer I/O error on device loop(7,0), logical block 1
> Buffer I/O error on device loop(7,0), logical block 2
> (buffer errors till the end).

These messages are not related to the uninitialized timers you showed,
but to loop slightly broken in 2.5.47: Linus already took patch below.

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

