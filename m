Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267562AbTAXGLY>; Fri, 24 Jan 2003 01:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267560AbTAXGLY>; Fri, 24 Jan 2003 01:11:24 -0500
Received: from smtp4.us.dell.com ([143.166.148.135]:29322 "EHLO
	smtp4.us.dell.com") by vger.kernel.org with ESMTP
	id <S267562AbTAXGLV>; Fri, 24 Jan 2003 01:11:21 -0500
Date: Fri, 24 Jan 2003 00:20:31 -0600 (CST)
From: Matt Domsch <Matt_Domsch@Dell.com>
X-X-Sender: mdomsch@humbolt.us.dell.com
Reply-To: Matt Domsch <Matt_Domsch@Dell.com>
To: alan@redhat.com, <linux-kernel@vger.kernel.org>
cc: Kevin Lawton <kevinlawton2001@yahoo.com>
Subject: Re: EDD bug find: wrong #define is used to declare edd[] area.
In-Reply-To: <20030121004610.45288.qmail@web80311.mail.yahoo.com>
Message-ID: <Pine.LNX.4.44.0301240017300.4944-100000@humbolt.us.dell.com>
X-GPG-Fingerprint: 17A4 17D0 81F5 4B5F DB1C  AEF8 21AB EEF7 92F0 FC09
X-GPG-Key: http://domsch.com/mdomsch_pub.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It appears to me that the wrong #define is being used to declare the
> size of the EDD (BIOS Enhanced Disk Drive Services) area of the setup
> parameter page.  The following lines use 'EDDNR', but I believe they
> meant to use 'EDDMAXNR':  (src @ 2.5.59)

Kevin, thanks for finding this, you're absolutely right.

Alan, please apply the patch below to your 2.4.x-ac tree.  I'll submit the 
corresponding patch for 2.5.x as well.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer, Architect
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

===== arch/i386/kernel/edd.c 1.2 vs edited =====
--- 1.2/arch/i386/kernel/edd.c	Mon Jan  6 15:22:36 2003
+++ edited/arch/i386/kernel/edd.c	Wed Jan 22 21:35:52 2003
@@ -11,7 +11,7 @@
  * fn41 - Check Extensions Present and
  * fn48 - Get Device Parametes with EDD extensions
  * made in setup.S, copied to safe structures in setup.c,
- * and presents it in driverfs.
+ * and presents it in /proc.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License v2.0 as published by
@@ -26,7 +26,6 @@
 
 /*
  * TODO:
- * - Convert to using /proc instead of driverfs
  * - move edd.[ch] to better locations if/when one is decided
  * - keep current with 2.5 EDD code changes
  */
@@ -47,7 +46,7 @@
 MODULE_DESCRIPTION("proc interface to BIOS EDD information");
 MODULE_LICENSE("GPL");
 
-#define EDD_VERSION "0.08 2003-Jan-05"
+#define EDD_VERSION "0.09 2003-Jan-22"
 #define EDD_DEVICE_NAME_SIZE 16
 #define REPORT_URL "http://domsch.com/linux/edd30/results.html"
 
@@ -601,7 +600,7 @@
 }
 
 /**
- * edd_init() - creates driverfs tree of EDD data
+ * edd_init() - creates /proc tree of EDD data
  *
  * This assumes that eddnr and edd were
  * assigned in setup.c already.
===== arch/i386/kernel/setup.c 1.59 vs edited =====
--- 1.59/arch/i386/kernel/setup.c	Tue Jan 14 09:39:13 2003
+++ edited/arch/i386/kernel/setup.c	Wed Jan 22 21:32:29 2003
@@ -705,7 +705,7 @@
 
 #if defined(CONFIG_EDD) || defined(CONFIG_EDD_MODULE)
 unsigned char eddnr;
-struct edd_info edd[EDDNR];
+struct edd_info edd[EDDMAXNR];
 /**
  * copy_edd() - Copy the BIOS EDD information
  *              from empty_zero_page into a safe place.
===== include/asm-i386/edd.h 1.1 vs edited =====
--- 1.1/include/asm-i386/edd.h	Thu Oct 24 15:44:10 2002
+++ edited/include/asm-i386/edd.h	Wed Jan 22 21:32:51 2003
@@ -165,7 +165,7 @@
 	struct edd_device_params params;
 } __attribute__ ((packed));
 
-extern struct edd_info edd[EDDNR];
+extern struct edd_info edd[EDDMAXNR];
 extern unsigned char eddnr;
 #endif				/*!__ASSEMBLY__ */
 

