Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262046AbTCVGnW>; Sat, 22 Mar 2003 01:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262047AbTCVGnV>; Sat, 22 Mar 2003 01:43:21 -0500
Received: from out002pub.verizon.net ([206.46.170.141]:40068 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP
	id <S262046AbTCVGnS>; Sat, 22 Mar 2003 01:43:18 -0500
Message-ID: <3E7C0808.75B95FB7@verizon.net>
Date: Fri, 21 Mar 2003 22:51:52 -0800
From: "Randy.Dunlap" <randy.dunlap@verizon.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.65 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com, leo@netlabs.net
Subject: [PATCH] reduce stack in cdrom/optcd.c
Content-Type: multipart/mixed;
 boundary="------------1075FE351E48CFE76A68482B"
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [4.64.238.61] at Sat, 22 Mar 2003 00:54:16 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------1075FE351E48CFE76A68482B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

This reduces stack usage in drivers/cdrom/optcd.c by
dynamically allocating a large (> 2 KB) buffer.

Patch is to 2.5.65.  Please apply.

~Randy
--------------1075FE351E48CFE76A68482B
Content-Type: text/plain; charset=us-ascii;
 name="optcdrom-stack.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="optcdrom-stack.patch"

patch_name:	optcdrom-stack.patch
patch_version:	2003-03-21.22:31:24
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	reduce stack usage in drivers/cdrom/optcd::cdromread()
product:	Linux
product_versions: 2.5.65
changelog:	kmalloc() the large buffer
maintainer:	Leo Spiekman <leo@netlabs.net>
diffstat:	=
 drivers/cdrom/optcd.c |   22 +++++++++++++++++-----
 1 files changed, 17 insertions(+), 5 deletions(-)


diff -Naur ./drivers/cdrom/optcd.c%CDROM ./drivers/cdrom/optcd.c
--- ./drivers/cdrom/optcd.c%CDROM	Mon Mar 17 13:43:49 2003
+++ ./drivers/cdrom/optcd.c	Fri Mar 21 22:30:08 2003
@@ -1600,13 +1600,17 @@
 
 static int cdromread(unsigned long arg, int blocksize, int cmd)
 {
-	int status;
+	int status, ret = 0;
 	struct cdrom_msf msf;
-	char buf[CD_FRAMESIZE_RAWER];
+	char *buf;
 
 	if (copy_from_user(&msf, (void *) arg, sizeof msf))
 		return -EFAULT;
 
+	buf = kmalloc(CD_FRAMESIZE_RAWER, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
 	bin2bcd(&msf);
 	msf.cdmsf_min1 = 0;
 	msf.cdmsf_sec1 = 0;
@@ -1615,11 +1619,19 @@
 
 	DEBUG((DEBUG_VFS, "read cmd status 0x%x", status));
 
-	if (!sleep_flag_low(FL_DTEN, SLEEP_TIMEOUT))
-		return -EIO;
+	if (!sleep_flag_low(FL_DTEN, SLEEP_TIMEOUT)) {
+		ret = -EIO;
+		goto cdr_free;
+	}
+
 	fetch_data(buf, blocksize);
 
-	return copy_to_user((void *)arg, &buf, blocksize) ? -EFAULT : 0;
+	if (copy_to_user((void *)arg, &buf, blocksize))
+		ret = -EFAULT;
+
+cdr_free:
+	kfree(buf);
+	return ret;
 }
 
 

--------------1075FE351E48CFE76A68482B--

