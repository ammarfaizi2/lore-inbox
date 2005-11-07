Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932389AbVKGEB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389AbVKGEB2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 23:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbVKGEB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 23:01:27 -0500
Received: from verein.lst.de ([213.95.11.210]:48862 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S932389AbVKGEB1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 23:01:27 -0500
Date: Mon, 7 Nov 2005 05:01:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@lst.de>, akpm@osdl.org, schwidefsky@de.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] ->compat_ioctl for 390 tape_char
Message-ID: <20051107040118.GA16331@lst.de>
References: <20051104221816.GD9384@lst.de> <200511050010.47138.arnd@arndb.de> <20051104235148.GA10604@lst.de> <200511050217.02547.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511050217.02547.arnd@arndb.de>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2005 at 02:16:56AM +0100, Arnd Bergmann wrote:
> On S?nnavend 05 November 2005 00:51, Christoph Hellwig wrote:
> > we return -ENOIOCTLCMD if we didn't have a valid compat ioctl, and in
> > that case the vfs code will try to find it in the core translation
> > table.
> 
> No, the function you wrote returns -ENOIOCTLCMD only if
> device->discipline->ioctl_fn is NULL, otherwise it returns the
> code it gets from that function, which is -EINVAL.

indeed.  updated patch below that handles that case.  I couldn't find
a problem like that in the other patches.


Index: linux-2.6/drivers/s390/char/tape_char.c
===================================================================
--- linux-2.6.orig/drivers/s390/char/tape_char.c	2005-11-06 20:06:55.000000000 +0100
+++ linux-2.6/drivers/s390/char/tape_char.c	2005-11-06 20:19:11.000000000 +0100
@@ -37,6 +37,8 @@
 static int tapechar_release(struct inode *,struct file *);
 static int tapechar_ioctl(struct inode *, struct file *, unsigned int,
 			  unsigned long);
+static long tapechar_compat_ioctl(struct file *, unsigned int,
+			  unsigned long);
 
 static struct file_operations tape_fops =
 {
@@ -44,6 +46,7 @@
 	.read = tapechar_read,
 	.write = tapechar_write,
 	.ioctl = tapechar_ioctl,
+	.compat_ioctl = tapechar_compat_ioctl,
 	.open = tapechar_open,
 	.release = tapechar_release,
 };
@@ -463,6 +466,23 @@
 	return device->discipline->ioctl_fn(device, no, data);
 }
 
+static long
+tapechar_compat_ioctl(struct file *filp, unsigned int no, unsigned long data)
+{
+	struct tape_device *device = filp->private_data;
+	int rval = -ENOIOCTLCMD;
+
+	if (device->discipline->ioctl_fn) {
+		lock_kernel();
+		rval = device->discipline->ioctl_fn(device, no, data);
+		unlock_kernel();
+		if (rval == -EINVAL)
+			rval = -ENOIOCTLCMD;
+	}
+
+	return rval;
+}
+
 /*
  * Initialize character device frontend.
  */
Index: linux-2.6/arch/s390/kernel/compat_ioctl.c
===================================================================
--- linux-2.6.orig/arch/s390/kernel/compat_ioctl.c	2005-11-06 20:17:52.000000000 +0100
+++ linux-2.6/arch/s390/kernel/compat_ioctl.c	2005-11-06 20:17:58.000000000 +0100
@@ -42,9 +42,6 @@
 #include <linux/compat_ioctl.h>
 #define DECLARES
 #include "../../../fs/compat_ioctl.c"
-
-/* s390 only ioctls */
-COMPATIBLE_IOCTL(TAPE390_DISPLAY)
 };
 
 int ioctl_table_size = ARRAY_SIZE(ioctl_start);
