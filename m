Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264940AbTBEVbs>; Wed, 5 Feb 2003 16:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264943AbTBEVbs>; Wed, 5 Feb 2003 16:31:48 -0500
Received: from pop015pub.verizon.net ([206.46.170.172]:44936 "EHLO
	pop015.verizon.net") by vger.kernel.org with ESMTP
	id <S264940AbTBEVbr>; Wed, 5 Feb 2003 16:31:47 -0500
Message-ID: <3E418492.A7039AB3@verizon.net>
Date: Wed, 05 Feb 2003 13:39:30 -0800
From: "Randy.Dunlap" <randy.dunlap@verizon.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.54 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] do_mounts memory leak
Content-Type: multipart/mixed;
 boundary="------------2F62E058EC51D62807BE2E5C"
X-Authentication-Info: Submitted using SMTP AUTH at pop015.verizon.net from [4.64.238.61] at Wed, 5 Feb 2003 15:41:17 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------2F62E058EC51D62807BE2E5C
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

The Stanford Checker identified a memory leak in
init/do_mounts.c.  This patch to 2.5.59 corrects it.
Please apply.

Thanks,
~Randy
--------------2F62E058EC51D62807BE2E5C
Content-Type: text/plain; charset=us-ascii;
 name="mounts-memleak.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mounts-memleak.patch"

diff -Naur ./init/do_mounts.c%LEAK ./init/do_mounts.c
--- ./init/do_mounts.c%LEAK	Thu Jan 16 18:22:02 2003
+++ ./init/do_mounts.c	Tue Feb  4 21:46:58 2003
@@ -653,12 +653,6 @@
 	/*
 	 * OK, time to copy in the data
 	 */
-	buf = kmalloc(BLOCK_SIZE, GFP_KERNEL);
-	if (buf == 0) {
-		printk(KERN_ERR "RAMDISK: could not allocate buffer\n");
-		goto done;
-	}
-
 	if (sys_ioctl(in_fd, BLKGETSIZE, (unsigned long)&devblocks) < 0)
 		devblocks = 0;
 	else
@@ -669,6 +663,12 @@
 
 	if (devblocks == 0) {
 		printk(KERN_ERR "RAMDISK: could not determine device size\n");
+		goto done;
+	}
+
+	buf = kmalloc(BLOCK_SIZE, GFP_KERNEL);
+	if (buf == 0) {
+		printk(KERN_ERR "RAMDISK: could not allocate buffer\n");
 		goto done;
 	}
 

--------------2F62E058EC51D62807BE2E5C--

