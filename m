Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262078AbTCZUGC>; Wed, 26 Mar 2003 15:06:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262080AbTCZUGC>; Wed, 26 Mar 2003 15:06:02 -0500
Received: from air-2.osdl.org ([65.172.181.6]:56539 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262078AbTCZUF7>;
	Wed, 26 Mar 2003 15:05:59 -0500
Date: Wed, 26 Mar 2003 12:12:50 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: alan@lxorguk.ukuu.org.uk, axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] reduce stack in cdrom/optcd.c
Message-Id: <20030326121250.56b4d62a.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(resend; was lost last night)


> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> 
> On Sat, 2003-03-22 at 06:51, Randy.Dunlap wrote:
> > Hi,
> > 
> > This reduces stack usage in drivers/cdrom/optcd.c by
> > dynamically allocating a large (> 2 KB) buffer.
> > 
> > Patch is to 2.5.65.  Please apply.
> 
> This loosk broken. You are using GFP_KERNEL memory allocations on the
> read path of a block device. What happens if the allocation fails 
> because we need memory
> 
> Surely that buffer needs to be allocated once at open and freed on close
> ?
> --


Alan, Jens, anybody else-

Does this pass?

Patch is now to 2.5.66.

Thanks,
~Randy


patch_name:	optcd-stackbuf.patch
patch_version:	2003-03-25.19:02:22
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	pre-allocate readbuf instead of kmalloc() in cdromread();
		(previously modified for stack reduction)
product:	Linux
product_versions: 2.5.66
maintainer:	unknown (email bounces)
diffstat:	=
 drivers/cdrom/optcd.c |   37 +++++++++++++++++++------------------
 1 files changed, 19 insertions(+), 18 deletions(-)


diff -Naur ./drivers/cdrom/optcd.c%OPTCD ./drivers/cdrom/optcd.c
--- ./drivers/cdrom/optcd.c%OPTCD	2003-03-24 14:00:10.000000000 -0800
+++ ./drivers/cdrom/optcd.c	2003-03-25 19:01:06.000000000 -0800
@@ -1598,19 +1598,17 @@
 }
 
 
+static struct gendisk *optcd_disk;
+
+
 static int cdromread(unsigned long arg, int blocksize, int cmd)
 {
-	int status, ret = 0;
+	int status;
 	struct cdrom_msf msf;
-	char *buf;
 
 	if (copy_from_user(&msf, (void *) arg, sizeof msf))
 		return -EFAULT;
 
-	buf = kmalloc(CD_FRAMESIZE_RAWER, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
 	bin2bcd(&msf);
 	msf.cdmsf_min1 = 0;
 	msf.cdmsf_sec1 = 0;
@@ -1619,19 +1617,15 @@
 
 	DEBUG((DEBUG_VFS, "read cmd status 0x%x", status));
 
-	if (!sleep_flag_low(FL_DTEN, SLEEP_TIMEOUT)) {
-		ret = -EIO;
-		goto cdr_free;
-	}
+	if (!sleep_flag_low(FL_DTEN, SLEEP_TIMEOUT))
+		return -EIO;
 
-	fetch_data(buf, blocksize);
+	fetch_data(optcd_disk->private_data, blocksize);
 
-	if (copy_to_user((void *)arg, &buf, blocksize))
-		ret = -EFAULT;
+	if (copy_to_user((void *)arg, optcd_disk->private_data, blocksize))
+		return -EFAULT;
 
-cdr_free:
-	kfree(buf);
-	return ret;
+	return 0;
 }
 
 
@@ -1857,6 +1851,14 @@
 
 	if (!open_count && state == S_IDLE) {
 		int status;
+		char *buf;
+
+		buf = kmalloc(CD_FRAMESIZE_RAWER, GFP_KERNEL);
+		if (!buf) {
+			printk(KERN_INFO "optcd: cannot allocate read buffer\n");
+			return -ENOMEM;
+		}
+		optcd_disk->private_data = buf;		/* save read buffer */
 
 		toc_uptodate = 0;
 		opt_invalidate_buffers();
@@ -1922,6 +1924,7 @@
 			status = exec_cmd(COMOPEN);
 			DEBUG((DEBUG_VFS, "exec_cmd COMOPEN: %02x", -status));
 		}
+		kfree(optcd_disk->private_data);
 		del_timer(&delay_timer);
 		del_timer(&req_timer);
 	}
@@ -2010,8 +2013,6 @@
 
 #endif /* MODULE */
 
-static struct gendisk *optcd_disk;
-
 /* Test for presence of drive and initialize it. Called at boot time
    or during module initialisation. */
 static int __init optcd_init(void)


--
~Randy
