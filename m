Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbUCDAAt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 19:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbUCDAAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 19:00:48 -0500
Received: from gate.crashing.org ([63.228.1.57]:26310 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261296AbUCDAAg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 19:00:36 -0500
Subject: [PATCH] /proc/cpuinfo fixes for G5
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1078357712.15325.35.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 04 Mar 2004 10:48:34 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch adds a "timbase" entry in /proc/cpuinfo like
p/iSeries that provides the CPU timebase frequency. It
is using by a all sort of performance analysis tools we
are hacking in house.

It also remove a useless bit about the l2 cache that was
copied over from ppc32.

Ben.

===== arch/ppc64/kernel/pmac_time.c 1.1 vs edited =====
--- 1.1/arch/ppc64/kernel/pmac_time.c	Thu Feb 12 14:48:00 2004
+++ edited/arch/ppc64/kernel/pmac_time.c	Thu Mar  4 10:21:01 2004
@@ -39,6 +39,8 @@
 
 extern void setup_default_decr(void);
 
+extern unsigned long ppc_tb_freq;
+
 /* Apparently the RTC stores seconds since 1 Jan 1904 */
 #define RTC_OFFSET	2082844800
 
@@ -151,6 +153,7 @@
 	tb_to_us = mulhwu_scale_factor(freq, 1000000);
 	div128_by_32( 1024*1024, 0, tb_ticks_per_sec, &divres );
 	tb_to_xs = divres.result_low;
+	ppc_tb_freq = freq;
 
 	setup_default_decr();
 }
===== arch/ppc64/kernel/pmac_setup.c 1.5 vs edited =====
--- 1.5/arch/ppc64/kernel/pmac_setup.c	Mon Mar  1 11:50:37 2004
+++ edited/arch/ppc64/kernel/pmac_setup.c	Wed Mar  3 10:51:22 2004
@@ -95,6 +95,7 @@
 					PMAC_MB_INFO_MODEL, 0);
 	unsigned int mbflags = pmac_call_feature(PMAC_FTR_GET_MB_INFO, NULL,
 						 PMAC_MB_INFO_FLAGS, 0);
+	extern unsigned long ppc_tb_freq;
 
 	if (pmac_call_feature(PMAC_FTR_GET_MB_INFO, NULL, PMAC_MB_INFO_NAME,
 			      (long)&mbname) != 0)
@@ -127,20 +128,11 @@
 	seq_printf(m, "detected as\t: %d (%s)\n", mbmodel, mbname);
 	seq_printf(m, "pmac flags\t: %08x\n", mbflags);
 
-	/* Checks "l2cr-value" property in the registry */
-	np = find_devices("cpus");	
-	if (np == 0)
-		np = find_type_devices("cpu");	
-	if (np != 0) {
-		unsigned int *l2cr = (unsigned int *)
-			get_property(np, "l2cr-value", NULL);
-		if (l2cr != 0) {
-			seq_printf(m, "l2cr override\t: 0x%x\n", *l2cr);
-		}
-	}
-
 	/* Indicate newworld */
 	seq_printf(m, "pmac-generation\t: NewWorld\n");
+
+	/* Indicate timebase value */
+	seq_printf(m, "timebase\t: %lu\n", ppc_tb_freq);
 }
 
 


