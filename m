Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265966AbUHMPYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265966AbUHMPYs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 11:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265970AbUHMPYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 11:24:48 -0400
Received: from delta.ds3.agh.edu.pl ([149.156.124.3]:36876 "EHLO
	pluto.ds14.agh.edu.pl") by vger.kernel.org with ESMTP
	id S265966AbUHMPYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 11:24:43 -0400
From: =?utf-8?q?Pawe=C5=82_Sikora?= <pluto@pld-linux.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] [ix86,x86_64] cpu features.
Date: Fri, 13 Aug 2004 17:24:34 +0200
User-Agent: KMail/1.7
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_z0NHBKf3LNnIjvX"
Message-Id: <200408131724.35573.pluto@pld-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_z0NHBKf3LNnIjvX
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

Attached patch fix/add several cpu features.

refs:

[1] Intel Processor Identification and the CPUID instruction
    Application Note 485.
    http://developer.intel.ru/download/design/Xeon/applnots/24161826.pdf

[2] http://www.sandpile.org/ia32/cpuid.htm

-- 
/* Copyright (C) 2003, SCO, Inc. This is valuable Intellectual Property. */

                           #define say(x) lie(x)

--Boundary-00=_z0NHBKf3LNnIjvX
Content-Type: text/x-diff;
  charset="utf-8";
  name="cpu_feature.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="cpu_feature.patch"

--- linux-2.6.8-rc4/arch/i386/kernel/cpu/proc.c.orig	2004-08-10 04:23:46.000000000 +0200
+++ linux-2.6.8-rc4/arch/i386/kernel/cpu/proc.c	2004-08-13 16:48:53.971370504 +0200
@@ -44,8 +44,8 @@
 		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
 
 		/* Intel-defined (#2) */
-		"pni", NULL, NULL, "monitor", "ds_cpl", NULL, NULL, "tm2",
-		"est", NULL, "cid", NULL, NULL, NULL, NULL, NULL,
+		"sse3", NULL, NULL, "monitor", "ds_cpl", NULL, NULL, "est",
+		"tm2", NULL, "cid", NULL, NULL, NULL, "xtpr", NULL,
 		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
 		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
 
--- linux-2.6.8-rc4/arch/x86_64/kernel/setup.c.orig	2004-08-10 04:22:11.000000000 +0200
+++ linux-2.6.8-rc4/arch/x86_64/kernel/setup.c	2004-08-13 16:59:14.729001000 +0200
@@ -1042,8 +1042,8 @@
 		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
 
 		/* Intel-defined (#2) */
-		"pni", NULL, NULL, "monitor", "ds_cpl", NULL, NULL, "tm2",
-		"est", NULL, "cid", NULL, NULL, "cmpxchg16b", NULL, NULL,
+		"sse3", NULL, NULL, "monitor", "ds_cpl", NULL, NULL, "est",
+		"tm2", NULL, "cid", NULL, NULL, "cx16", "xtpr", NULL,
 		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
 		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
 	};
--- linux-2.6.8-rc4/include/asm-i386/cpufeature.h.orig	2004-08-10 04:23:22.000000000 +0200
+++ linux-2.6.8-rc4/include/asm-i386/cpufeature.h	2004-08-13 16:49:19.439498760 +0200
@@ -71,9 +71,13 @@
 #define X86_FEATURE_P4		(3*32+ 7) /* P4 */
 
 /* Intel-defined CPU features, CPUID level 0x00000001 (ecx), word 4 */
-#define X86_FEATURE_EST		(4*32+ 7) /* Enhanced SpeedStep */
+#define X86_FEATURE_XMM3	(4*32+ 0) /* Streaming SIMD Extensions-3 */
 #define X86_FEATURE_MWAIT	(4*32+ 3) /* Monitor/Mwait support */
-
+#define X86_FEATURE_DSCPL	(4*32+ 4) /* CPL Qualified Debug Store */
+#define X86_FEATURE_EST		(4*32+ 7) /* Enhanced SpeedStep */
+#define X86_FEATURE_TM2		(4*32+ 8) /* Thermal Monitor 2 */
+#define X86_FEATURE_CID		(4*32+10) /* Context ID */
+#define X86_FEATURE_XTPR	(4*32+14) /* Send Task Priority Messages */
 
 /* VIA/Cyrix/Centaur-defined CPU features, CPUID level 0xC0000001, word 5 */
 #define X86_FEATURE_XSTORE	(5*32+ 2) /* on-CPU RNG present (xstore insn) */
--- linux-2.6.8-rc4/include/asm-x86_64/cpufeature.h.orig	2004-08-10 04:23:13.000000000 +0200
+++ linux-2.6.8-rc4/include/asm-x86_64/cpufeature.h	2004-08-13 16:53:48.776553304 +0200
@@ -63,8 +63,14 @@
 #define X86_FEATURE_K8_C	(3*32+ 4) /* C stepping K8 */
 
 /* Intel-defined CPU features, CPUID level 0x00000001 (ecx), word 4 */
-#define X86_FEATURE_EST		(4*32+ 7) /* Enhanced SpeedStep */
+#define X86_FEATURE_XMM3	(4*32+ 0) /* Streaming SIMD Extensions-3 */
 #define X86_FEATURE_MWAIT	(4*32+ 3) /* Monitor/Mwait support */
+#define X86_FEATURE_DSCPL	(4*32+ 4) /* CPL Qualified Debug Store */
+#define X86_FEATURE_EST		(4*32+ 7) /* Enhanced SpeedStep */
+#define X86_FEATURE_TM2		(4*32+ 8) /* Thermal Monitor 2 */
+#define X86_FEATURE_CID		(4*32+10) /* Context ID */
+#define X86_FEATURE_CX16	(4*32+13) /* CMPXCHG16B */
+#define X86_FEATURE_XTPR	(4*32+14) /* Send Task Priority Messages */
 
 #define cpu_has(c, bit)                test_bit(bit, (c)->x86_capability)
 #define boot_cpu_has(bit)      test_bit(bit, boot_cpu_data.x86_capability)

--Boundary-00=_z0NHBKf3LNnIjvX--
