Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261357AbUKNWcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbUKNWcg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 17:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbUKNWcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 17:32:35 -0500
Received: from hera.cwi.nl ([192.16.191.8]:42493 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261357AbUKNWbl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 17:31:41 -0500
Date: Sun, 14 Nov 2004 23:31:21 +0100 (MET)
From: <Andries.Brouwer@cwi.nl>
Message-Id: <200411142231.iAEMVLh20517@apps.cwi.nl>
To: akpm@osdl.org, lkml@happyjack.org, torvalds@osdl.org
Subject: [PATCH?] prevent loop infinite recursion
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After "losetup /dev/loop0 /dev/loop0" I see a hard crash upon
access of /dev/loop0. And of course the same happens after
"losetup /dev/loop0 /dev/loop1; "losetup /dev/loop1 /dev/loop0"

Chris Spiegel reports a slightly different crash doing similar things.

The easiest fix is saying "don't do that then".

The patch below adds a (somewhat ugly) test for recursion.
Maybe someone can think of a nicer version.

Andries

diff -uprN -X /linux/dontdiff a/drivers/block/loop.c b/drivers/block/loop.c
--- a/drivers/block/loop.c	2004-08-26 22:05:15.000000000 +0200
+++ b/drivers/block/loop.c	2004-11-14 22:43:31.000000000 +0100
@@ -622,10 +622,17 @@ static int loop_change_fd(struct loop_de
 	return error;
 }
 
+static inline int is_loop_device(struct file *file)
+{
+	struct inode *i = file->f_mapping->host;
+
+	return i && S_ISBLK(i->i_mode) && MAJOR(i->i_rdev) == LOOP_MAJOR;
+}
+
 static int loop_set_fd(struct loop_device *lo, struct file *lo_file,
 		       struct block_device *bdev, unsigned int arg)
 {
-	struct file	*file;
+	struct file	*file, *f;
 	struct inode	*inode;
 	struct address_space *mapping;
 	unsigned lo_blocksize;
@@ -636,15 +643,28 @@ static int loop_set_fd(struct loop_devic
 	/* This is safe, since we have a reference from open(). */
 	__module_get(THIS_MODULE);
 
-	error = -EBUSY;
-	if (lo->lo_state != Lo_unbound)
-		goto out;
-
 	error = -EBADF;
 	file = fget(arg);
 	if (!file)
 		goto out;
 
+	error = -EBUSY;
+	if (lo->lo_state != Lo_unbound)
+		goto out_putf;
+
+	/* Avoid recursion */
+	f = file;
+	while (is_loop_device(f)) {
+		struct loop_device *l;
+
+		if (f->f_mapping->host == lo_file->f_mapping->host)
+			goto out_putf;
+		l = f->f_mapping->host->i_bdev->bd_disk->private_data;
+		if (l->lo_state == Lo_unbound)
+			break;
+		f = l->lo_backing_file;
+	}
+
 	mapping = file->f_mapping;
 	inode = mapping->host;
 
