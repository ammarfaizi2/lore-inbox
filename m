Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266081AbTABXDo>; Thu, 2 Jan 2003 18:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267300AbTABXDo>; Thu, 2 Jan 2003 18:03:44 -0500
Received: from air-2.osdl.org ([65.172.181.6]:58540 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S266081AbTABXDk>;
	Thu, 2 Jan 2003 18:03:40 -0500
Date: Thu, 2 Jan 2003 15:09:17 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: <linux-kernel@vger.kernel.org>
cc: <torvalds@transmeta.com>
Subject: [PATCH] configurable LOG_BUF_SIZE
Message-ID: <Pine.LNX.4.33L2.0301021501580.22868-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

This patch to 2.5.54 make LOG_BUF_LEN a configurable option.
Actually its shift value is configurable, and that keeps it
a power of 2.

Please apply.

Thanks,
-- 
~Randy



patch_name:	logbuf-config-2554.patch
patch_version:	2003.01.02
author:		Randy Dunlap <rddunlap@osdl.org>
description:	change LOG_BUF_LEN to a config option (LOG_BUF_SHIFT)
product:	linux
product_versions: 2.5.54
changelog:	(a) add in General Setup
		(b) use a SHIFT value (enforces power of 2, gives more choices)
URL:		http://www.osdl.org/archive/rddunlap/patches/
requires:	kconfig in 2.5.52 or later
conflicts:
diffstat:
 init/Kconfig    |   45 +++++++++++++++++++++++++++++++++++++++++++++
 kernel/printk.c |   11 +----------
 2 files changed, 46 insertions(+), 10 deletions(-)


--- ./kernel/printk.c%LOG	Wed Jan  1 19:23:19 2003
+++ ./kernel/printk.c	Thu Jan  2 14:48:59 2003
@@ -31,16 +31,7 @@

 #include <asm/uaccess.h>

-#if defined(CONFIG_X86_NUMAQ) || defined(CONFIG_IA64)
-#define LOG_BUF_LEN	(65536)
-#elif defined(CONFIG_ARCH_S390)
-#define LOG_BUF_LEN	(131072)
-#elif defined(CONFIG_SMP)
-#define LOG_BUF_LEN	(32768)
-#else
-#define LOG_BUF_LEN	(16384)			/* This must be a power of two */
-#endif
-
+#define LOG_BUF_LEN	(1 << CONFIG_LOG_BUF_SHIFT)	/* This must be a power of two */
 #define LOG_BUF_MASK	(LOG_BUF_LEN-1)

 /* printk's without a loglevel use this.. */
--- ./init/Kconfig%LOG	Thu Jan  2 14:34:27 2003
+++ ./init/Kconfig	Thu Jan  2 14:42:01 2003
@@ -98,6 +98,51 @@
 	  building a kernel for install/rescue disks or your system is very
 	  limited in memory.

+choice
+	prompt "Kernel log buffer size"
+	default LOG_BUF_SHIFT_17 if ARCH_S390
+	default LOG_BUF_SHIFT_16 if X86_NUMAQ || IA64
+	default LOG_BUF_SHIFT_15 if SMP
+	default LOG_BUF_SHIFT_14
+	help
+	  Select kernel log buffer size from this list (power of 2).
+	  Defaults:  17 (=> 128 KB for S/390)
+		     16 (=> 64 KB for x86 NUMAQ or IA-64)
+	             15 (=> 32 KB for SMP)
+	             14 (=> 16 KB for uniprocessor)
+
+config LOG_BUF_SHIFT_17
+	bool "128 KB"
+	default y if ARCH_S390
+
+config LOG_BUF_SHIFT_16
+	bool "64 KB"
+	default y if X86_NUMAQ || IA64
+
+config LOG_BUF_SHIFT_15
+	bool "32 KB"
+	default y if SMP
+
+config LOG_BUF_SHIFT_14
+	bool "16 KB"
+
+config LOG_BUF_SHIFT_13
+	bool "8 KB"
+
+config LOG_BUF_SHIFT_12
+	bool "4 KB"
+
+endchoice
+
+config LOG_BUF_SHIFT
+	int
+	default 17 if LOG_BUF_SHIFT_17=y
+	default 16 if LOG_BUF_SHIFT_16=y
+	default 15 if LOG_BUF_SHIFT_15=y
+	default 14 if LOG_BUF_SHIFT_14=y
+	default 13 if LOG_BUF_SHIFT_13=y
+	default 12 if LOG_BUF_SHIFT_12=y
+
 endmenu



