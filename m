Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266557AbRGQPKG>; Tue, 17 Jul 2001 11:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266551AbRGQPJr>; Tue, 17 Jul 2001 11:09:47 -0400
Received: from mta05-svc.ntlworld.com ([62.253.162.45]:20698 "EHLO
	mta05-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S265443AbRGQPJf>; Tue, 17 Jul 2001 11:09:35 -0400
Message-ID: <35721.193.133.92.239.995382564.squirrel@lbbrown.homeip.net>
Date: Tue, 17 Jul 2001 16:09:24 +0100 (BST)
Subject: [RFC][PATCH] Allow compressed initial ramdisks to span multiple floppies
From: "Leigh Brown" <leigh@solinno.co.uk>
To: linux-kernel@vger.kernel.org
Cc: leigh@solinno.co.uk
Reply-To: leigh@solinno.co.uk
X-Mailer: SquirrelMail (version 1.0.4)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is my first patch (and possibly post) to lkml, although I browse
the archives quite often.  The patch allows a compressed ramdisk to
span multiple floppies.  This is handy for installing modern distros
(YDL in my case) on a machine that can't boot from CD-ROM, where the
initial ramdisks are several meg in size.  Obviously, I could
uncompress the ramdisk (which I have actually done) but writing 12 or
more floppies in this day and age make my toes curl.

Please CC me in any replies for a speedy response.

Cheers,

Leigh.
---
--- drivers/block/rd.c.orig	Sun Apr  8 23:22:17 2001
+++ drivers/block/rd.c	Mon Jul 16 16:27:56 2001
@@ -85,7 +85,7 @@
 #define BUILD_CRAMDISK
 
 void rd_load(void);
-static int crd_load(struct file *fp, struct file *outfp);
+static int crd_load(struct file *fp, struct file *outfp, kdev_t device, struct inode *inode);
 
 #ifdef CONFIG_BLK_DEV_INITRD
 static int initrd_users;
@@ -608,7 +608,7 @@
 
 	if (nblocks == 0) {
 #ifdef BUILD_CRAMDISK
-		if (crd_load(&infile, &outfile) == 0)
+		if (crd_load(&infile, &outfile, device, inode) == 0)
 			goto successful_load;
 #else
 		printk(KERN_NOTICE
@@ -787,6 +786,8 @@
 static int exit_code;
 static long bytes_out;
 static struct file *crd_infp, *crd_outfp;
+static kdev_t crd_device;
+static struct inode *crd_inode;
 
 #define get_byte()  (inptr < insize ? inbuf[inptr++] : fill_inbuf())
 		
@@ -839,7 +840,23 @@
 	
 	insize = crd_infp->f_op->read(crd_infp, inbuf, INBUFSIZ,
 				      &crd_infp->f_pos);
-	if (insize == 0) return -1;
+	if (insize == 0) {
+		invalidate_buffers(crd_device);
+		if (crd_infp->f_op->release)
+			crd_infp->f_op->release(crd_inode, crd_infp);
+		printk("Please insert next disk and press ENTER\n");
+		wait_for_keypress();
+		if (blkdev_open(crd_inode, crd_infp) != 0) {
+			printk("Error opening disk.\n");
+			return -1;
+		}
+		crd_infp->f_pos = 0;
+		printk("Loading disk... ");
+		insize = crd_infp->f_op->read(crd_infp, inbuf, INBUFSIZ,
+					      &crd_infp->f_pos);
+	}
+	if (insize == 0)
+		return -1;
 
 	inptr = 1;
 
@@ -874,7 +891,7 @@
 }
 
 static int __init 
-crd_load(struct file * fp, struct file *outfp)
+crd_load(struct file * fp, struct file *outfp, kdev_t device, struct inode *inode)
 {
 	int result;
 
@@ -887,6 +904,8 @@
 
 	crd_infp = fp;
 	crd_outfp = outfp;
+	crd_device = device;
+	crd_inode = inode;
 	inbuf = kmalloc(INBUFSIZ, GFP_KERNEL);
 	if (inbuf == 0) {
 		printk(KERN_ERR "RAMDISK: Couldn't allocate gzip buffer\n");

