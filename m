Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263366AbTEMHWK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 03:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263373AbTEMHWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 03:22:10 -0400
Received: from dp.samba.org ([66.70.73.150]:24461 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263366AbTEMHWH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 03:22:07 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com, viro@math.psu.edu
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] loop.c warning removal
Date: Tue, 13 May 2003 16:03:59 +1000
Message-Id: <20030513073453.0E45C2C074@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

loop.c has one of those places where maniping own refcounts is safe:
to get into the ioctl handler you need to have the device open, so
that holds a refcount already (verified that this actually happens).

The compile warning is irritating.
Rusty.

diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.69-bk7/drivers/block/loop.c working-2.5.69-bk7-mingo/drivers/block/loop.c
--- linux-2.5.69-bk7/drivers/block/loop.c	2003-05-05 12:36:58.000000000 +1000
+++ working-2.5.69-bk7-mingo/drivers/block/loop.c	2003-05-13 15:59:02.000000000 +1000
@@ -651,7 +651,8 @@ static int loop_set_fd(struct loop_devic
 	int		lo_flags = 0;
 	int		error;
 
-	MOD_INC_USE_COUNT;
+	/* This is safe, since we have a reference from open(). */
+	__module_get(THIS_MODULE);
 
 	error = -EBUSY;
 	if (lo->lo_state != Lo_unbound)
@@ -751,7 +752,8 @@ static int loop_set_fd(struct loop_devic
  out_putf:
 	fput(file);
  out:
-	MOD_DEC_USE_COUNT;
+	/* This is safe: open() is still holding a reference. */
+	module_put(THIS_MODULE);
 	return error;
 }
 
@@ -824,7 +826,8 @@ static int loop_clr_fd(struct loop_devic
 	filp->f_dentry->d_inode->i_mapping->gfp_mask = gfp;
 	lo->lo_state = Lo_unbound;
 	fput(filp);
-	MOD_DEC_USE_COUNT;
+	/* This is safe: open() is still holding a reference. */
+	module_put(THIS_MODULE);
 	return 0;
 }
 

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
