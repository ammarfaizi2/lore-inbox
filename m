Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267712AbTAMBCm>; Sun, 12 Jan 2003 20:02:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267709AbTAMBCm>; Sun, 12 Jan 2003 20:02:42 -0500
Received: from dp.samba.org ([66.70.73.150]:19881 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267701AbTAMBCi>;
	Sun, 12 Jan 2003 20:02:38 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: Re: [PATCH] fixup loop blkdev, add module_get 
In-reply-to: Your message of "Sat, 11 Jan 2003 22:56:20 CDT."
             <20030112035620.GA25648@gtf.org> 
Date: Mon, 13 Jan 2003 11:55:47 +1100
Message-Id: <20030113011128.8150C2C05A@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030112035620.GA25648@gtf.org> you write:
> Sometimes, we are absolutely certain that we have at least one module
> reference "locked open" for us.  Loop is an example of such a case:  the
> set-fd and clear-fd struct block_device_operations ioctls already have a
> module reference from simply the block device being opened.
> 
> Therefore, we can just unconditionally increment the module refcount.
> I added module_get to do this.

Hi Jeff,

	We may yet want such a primitive, but I've been resisting it
for the moment.

	Firstly, because it's a very specialized and rare case which
lends itself to being abused, and secondly because if I "rmmod --wait"
the module, then such operations which try to hold the module in place
*should* fail.  Not doing so is impolite, at least.

	Sure, it's a fairly strange corner case, but that argument
cuts both ways.

I prefer this patch (-EBUSY is a little unusual, but as clear as any).

Thoughts?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5-bk/drivers/block/loop.c working-2.5-bk-loop/drivers/block/loop.c
--- linux-2.5-bk/drivers/block/loop.c	2003-01-02 12:45:18.000000000 +1100
+++ working-2.5-bk-loop/drivers/block/loop.c	2003-01-13 11:49:21.000000000 +1100
@@ -642,7 +642,9 @@ static int loop_set_fd(struct loop_devic
 	int		lo_flags = 0;
 	int		error;
 
-	MOD_INC_USE_COUNT;
+	if (!try_module_get(THIS_MODULE))
+		/* I'm going away: pretend I'm not here. */
+		return -EBUSY;
 
 	error = -EBUSY;
 	if (lo->lo_state != Lo_unbound)
@@ -742,7 +744,7 @@ static int loop_set_fd(struct loop_devic
  out_putf:
 	fput(file);
  out:
-	MOD_DEC_USE_COUNT;
+	module_put(THIS_MODULE);
 	return error;
 }
 
@@ -814,7 +816,9 @@ static int loop_clr_fd(struct loop_devic
 	filp->f_dentry->d_inode->i_mapping->gfp_mask = gfp;
 	lo->lo_state = Lo_unbound;
 	fput(filp);
-	MOD_DEC_USE_COUNT;
+
+	/* This won't drop to zero, since we're inside an ioctl. */
+	module_put(THIS_MODULE);
 	return 0;
 }
 
