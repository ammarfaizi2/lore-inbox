Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261297AbULKQic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbULKQic (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 11:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261964AbULKQic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 11:38:32 -0500
Received: from eth13.com-link.com ([208.242.241.164]:43906 "EHLO
	real.realitydiluted.com") by vger.kernel.org with ESMTP
	id S261297AbULKQiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 11:38:24 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Speedstep for 2.0GHz Centrino (Dothan Core)...
Cc: sjhill@realitydiluted.com
Message-Id: <E1CdAGG-0000ZL-9T@real.realitydiluted.com>
From: sjhill@realitydiluted.com
Date: Sat, 11 Dec 2004 10:38:24 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the 2GHz Dothan based core to the speedstep infrastructure
for Linux. I have been able to utilize 600MHz and 2GHz with no troubles,
but the intermediate V/f pairs do not work. When I attempt to change the
frequency in /proc, the command hangs. I then have to kill the process
from a different terminal. If anyone else is utilizing this core and has
different experiences, I would be interested. Also, I am not on LKML, so
kindly CC: on replies. Cheers.

-Steve

--- linux-2.6.9/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c.orig	2004-12-01 08:27:00.000000000 -0600
+++ linux-2.6.9/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c	2004-12-01 09:13:33.000000000 -0600
@@ -197,7 +197,25 @@
 	OP(1700, 1484),
 	{ .frequency = CPUFREQ_TABLE_END }
 };
-#undef OP
+
+/*
+ * These voltage tables were derived from the Intel Pentium M on 90-nm
+ * Process with 2-MB L2 Cache, document 30218904.pdf, Table 5, VID#C.
+ */
+
+/* Intel Pentium M processor 2.00GHz (Dothan) */
+static struct cpufreq_frequency_table dothan_2000[] =
+{
+	OP( 600,  988),
+	OP( 800, 1036),
+	OP(1000, 1084),
+	OP(1200, 1132),
+	OP(1400, 1180),
+	OP(1600, 1228),
+	OP(1800, 1276),
+	OP(2000, 1308),
+	{ .frequency = CPUFREQ_TABLE_END }
+};
 
 #define _BANIAS(cpuid, max, name)	\
 {	.cpu_id		= cpuid,	\
@@ -207,6 +225,13 @@
 }
 #define BANIAS(max)	_BANIAS(&cpu_ids[CPU_BANIAS], max, #max)
 
+#define _DOTHAN(cpuid, max_khz, max_ghz)	\
+{	.cpu_id		= cpuid,		\
+	.model_name	= "Intel(R) Pentium(R) M processor" max_ghz "GHz", \
+	.max_freq	= (max_khz)*1000,	\
+	.op_points	= dothan_##max_khz,	\
+}
+
 /* CPU models, their operating frequency range, and freq/voltage
    operating points */
 static struct cpu_model models[] =
@@ -224,12 +249,15 @@
 	/* NULL model_name is a wildcard */
 	{ &cpu_ids[CPU_DOTHAN_A1], NULL, 0, NULL },
 	{ &cpu_ids[CPU_DOTHAN_A2], NULL, 0, NULL },
-	{ &cpu_ids[CPU_DOTHAN_B0], NULL, 0, NULL },
+
+	_DOTHAN(&cpu_ids[CPU_DOTHAN_B0], 2000, " 2.00"),
 
 	{ NULL, }
 };
 #undef _BANIAS
 #undef BANIAS
+#undef _DOTHAN
+#undef OP
 
 static int centrino_cpu_init_table(struct cpufreq_policy *policy)
 {
