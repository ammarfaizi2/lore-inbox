Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135820AbRD2QUH>; Sun, 29 Apr 2001 12:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135823AbRD2QT7>; Sun, 29 Apr 2001 12:19:59 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:5057 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S135820AbRD2QTi>;
	Sun, 29 Apr 2001 12:19:38 -0400
Message-Id: <200104291619.f3TGJSJo030474@acacia.rothwell.emu.id.au>
To: trovalds@tranmeta.com
cc: linux-kernel@vger.kernel.org, linux-laptop@vger.kernel.org
Subject: [PATCH] Allow ALLOW_INTS and broken BIOS to be selected at run time
From: Stephen Rothwell <sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <30472.988561167.1@rothwell.emu.id.au>
Date: Mon, 30 Apr 2001 02:19:27 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This patch (partially based on Alan's 2.4.3-ac14) allows both
CONFIG_ALLOW_INTS and the work around for BIOSs with a broken
APM_GET_POWER_STATUS call to be selected either on the kernel
boot command line or at module insert time.

Cheers,
Stephen
--
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.4.4/arch/i386/kernel/apm.c 2.4.4-APM/arch/i386/kernel/apm.c
--- 2.4.4/arch/i386/kernel/apm.c	Sun Apr 29 06:16:28 2001
+++ 2.4.4-APM/arch/i386/kernel/apm.c	Sun Apr 29 14:05:16 2001
@@ -347,6 +347,12 @@
 #endif
 static int			exit_kapmd;
 static int			kapmd_running;
+#ifdef CONFIG_APM_ALLOW_INTS
+static int			allow_ints = 1;
+#else
+static int			allow_ints;
+#endif
+static int			broken_psr;
 
 static DECLARE_WAIT_QUEUE_HEAD(apm_waitqueue);
 static DECLARE_WAIT_QUEUE_HEAD(apm_suspend_waitqueue);
@@ -413,11 +419,12 @@
  * Also, we KNOW that for the non error case of apm_bios_call, there
  * is no useful data returned in the low order 8 bits of eax.
  */
-#ifndef CONFIG_APM_ALLOW_INTS
-#	define APM_DO_CLI	__cli()
-#else
-#	define APM_DO_CLI	__sti()
-#endif
+#define APM_DO_CLI	\
+	if (apm_info.allow_ints) \
+		__sti(); \
+	else \
+		__cli();
+
 #ifdef APM_ZERO_SEGS
 #	define APM_DECL_SEGS \
 		unsigned int saved_fs; unsigned int saved_gs;
@@ -1552,6 +1559,9 @@
 			apm_disabled = 1;
 		if (strncmp(str, "on", 2) == 0)
 			apm_disabled = 0;
+		if ((strncmp(str, "allow-ints", 10) == 0) ||
+		    (strncmp(str, "allow_ints", 10) == 0))
+ 			apm_info.allow_ints = 1;
 		if ((strncmp(str, "broken-psr", 10) == 0) ||
 		    (strncmp(str, "broken_psr", 10) == 0))
 			apm_info.get_power_status_broken = 1;
@@ -1620,6 +1630,11 @@
 		return -ENODEV;
 	}
 
+	if (allow_ints)
+		apm_info.allow_ints = 1;
+	if (broken_psr)
+		apm_info.get_power_status_broken = 1;
+
 	/*
 	 * Fix for the Compaq Contura 3/25c which reports BIOS version 0.1
 	 * but is reportedly a 1.0 BIOS.
@@ -1747,5 +1762,9 @@
 MODULE_PARM_DESC(power_off, "Enable power off");
 MODULE_PARM(bounce_interval, "i");
 MODULE_PARM_DESC(bounce_interval, "Set the number of ticks to ignore suspend bounces");
+MODULE_PARM(allow_ints, "i");
+MODULE_PARM_DESC(allow_ints, "Allow interrupts during BIOS calls");
+MODULE_PARM(broken_psr, "i");
+MODULE_PARM_DESC(broken_psr, "BIOS has a broken GetPowerStatus call");
 
 EXPORT_NO_SYMBOLS;
diff -ruN 2.4.4/include/linux/apm_bios.h 2.4.4-APM/include/linux/apm_bios.h
--- 2.4.4/include/linux/apm_bios.h	Sun Apr 29 06:17:10 2001
+++ 2.4.4-APM/include/linux/apm_bios.h	Sun Apr 29 11:32:39 2001
@@ -52,6 +52,7 @@
 	struct apm_bios_info	bios;
 	unsigned short		connection_version;
 	int			get_power_status_broken;
+	int			allow_ints;
 };
 
 /*
