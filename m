Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268776AbUIAHUo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268776AbUIAHUo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 03:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267720AbUIAHUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 03:20:43 -0400
Received: from mail.mellanox.co.il ([194.90.237.34]:2272 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S267591AbUIAHUA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 03:20:00 -0400
Date: Wed, 1 Sep 2004 10:22:45 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: discuss@x86-64.org
Cc: linux-kernel@vger.kernel.org
Subject: f_ops flag to speed up compatible ioctls in linux kernel
Message-ID: <20040901072245.GF13749@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
Currently, on the x86_64 architecture, its quite tricky to make
a char device ioctl work for an x86 executables.
In particular,
   1. there is a requirement that ioctl number is unique -
      which is hard to guarantee especially for out of kernel modules
   2. there's a performance huge overhead for each compat call - there's
      a hash lookup in a global hash inside a lock_kernel -
      and I think compat performance *is* important.

Further, adding a command to the ioctl suddenly requires changing
two places - registration code and ioctl itself.
  
However, if all ioctl commands for a specific device
are not passing around pointers and long longs,
(relatively common case), and sometimes even
if they are, this ioctl is 64/32 bit compatible -
so why isnt there a simple way to declare this fact?

Here's a patch that simply adds a flag field to f_ops
that will cause all ioctls to get forwarded directly to the
64 bit call.

If all ioctls are compatible for a character device, a flag just
has to be set there, before the device is registered.

MST

diff -ruw linux-2.6.8.1/fs/compat.c linux-2.6.8.1-built/fs/compat.c
--- linux-2.6.8.1/fs/compat.c	2004-08-14 13:55:31.000000000 +0300
+++ linux-2.6.8.1-built/fs/compat.c	2004-09-01 09:52:10.126944256 +0300
@@ -392,7 +392,8 @@
 	if(!filp)
 		goto out2;
 
-	if (!filp->f_op || !filp->f_op->ioctl) {
+	if (!filp->f_op || !filp->f_op->ioctl ||
+          (filp->f_op->fops_flags & FOPS_IOCTL_COMPAT)) {
 		error = sys_ioctl (fd, cmd, arg);
 		goto out;
 	}
diff -ruw linux-2.6.8.1/include/linux/fs.h linux-2.6.8.1-built/include/linux/fs.h
--- linux-2.6.8.1/include/linux/fs.h	2004-08-14 13:55:09.000000000 +0300
+++ linux-2.6.8.1-built/include/linux/fs.h	2004-09-01 09:50:07.265622016 +0300
@@ -871,6 +871,7 @@
  */
 struct file_operations {
 	struct module *owner;
+	unsigned long fops_flags;		/* Flags, listed below. */
 	loff_t (*llseek) (struct file *, loff_t, int);
 	ssize_t (*read) (struct file *, char __user *, size_t, loff_t *);
 	ssize_t (*aio_read) (struct kiocb *, char __user *, size_t, loff_t);
@@ -896,6 +897,8 @@
 	int (*dir_notify)(struct file *filp, unsigned long arg);
 };
 
+#define FOPS_IOCTL_COMPAT 0x00000001 /* ioctl is 32/64 bit compatible */
+
 struct inode_operations {
 	int (*create) (struct inode *,struct dentry *,int, struct nameidata *);
 	struct dentry * (*lookup) (struct inode *,struct dentry *, struct nameidata *);
