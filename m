Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262510AbULDAeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262510AbULDAeW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 19:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262515AbULDAeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 19:34:22 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:24782 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id S262510AbULDAeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 19:34:08 -0500
Date: Sat, 4 Dec 2004 01:34:01 +0100
From: franz_pletz@t-online.de (Franz Pletz)
To: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       Ludwig Schmidt <ludoschmidt@web.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] loopback device can't act as its backing store
Message-ID: <20041204013401.692a3520@sgx.home>
In-Reply-To: <20041203145056.541308d1.akpm@osdl.org>
References: <Pine.LNX.4.61.0412032028220.10184@sgx.home>
	<20041203145056.541308d1.akpm@osdl.org>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ID: SgHOBQZeQeEj-trOEULtfKAHBL24fRuQALc5rZR6xzXPdJsUkr3m0N
X-TOI-MSGID: 602954ad-c2c0-4a55-baec-995439b55e04
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
> Your patch addresses direct loop0-on-loop0 recursion, but does it fix the
> more complex loop-stacks which Chris Spiegel identified?

No, it doesn't. I was unfortunately much too focused on the loop0-loop0 problem to realize those issues.

> I don't think there's any actual infinite recursion in Chris's example - in
> his case we simply stacked loop deveces too deep.  But a fix for Chris's
> scenario will also fix the one which you identify, I think.  Andries posted
> such a patch but I have not yet got around to looking at it.

Andries' patch addresses all issues Chris and I encountered although raising some minor problems.

In the while-loop only the inodes are being compared. But you can have more than one device node pointing to this specific device. Consequently, we need to compare the dev_t structures like in my initial patch.

Moreover, if the loopback device l is unbound, the while-loop shouldn't be terminated as this (unbound!) device file would therefore be set as the new backing file, which makes no sense in my opinion and which additionally could lead into problems while accessing the device. I would propose a goto out_putf to return -EINVAL instead.

Now, Chris' and my issues with mount and losetup are resolved properly. I attached the patch of Andries including the proposed changes.

--- linux-orig/drivers/block/loop.c	2004-11-25 19:56:32.000000000 +0100
+++ linux/drivers/block/loop.c	2004-12-04 00:58:09.897336912 +0100
@@ -622,10 +622,17 @@
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
@@ -636,15 +643,31 @@
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
+		if (f->f_mapping->host->i_rdev == lo_file->f_mapping->host->i_rdev)
+			goto out_putf;
+		
+		l = f->f_mapping->host->i_bdev->bd_disk->private_data;
+		if (l->lo_state == Lo_unbound) {
+			error = -EINVAL;
+			goto out_putf;
+		}
+		f = l->lo_backing_file;
+	}
+
 	mapping = file->f_mapping;
 	inode = mapping->host;
 
