Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262392AbVAVBnK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262392AbVAVBnK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 20:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262394AbVAVBnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 20:43:09 -0500
Received: from ozlabs.org ([203.10.76.45]:26347 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262392AbVAVBnD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 20:43:03 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16881.44964.715531.502428@cargo.ozlabs.ibm.com>
Date: Sat, 22 Jan 2005 12:43:00 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Cc: anton@samba.org, moilanen@austin.ibm.com
Subject: [PATCH] PPC64 xmon data breakpoints on partitioned systems
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is originally from Jake Moilanen <moilanen@austin.ibm.com>,
substantially modified by me.

On PPC64 systems with a hypervisor, we can't set the Data Address
Breakpoint Register (DABR) directly, we have to do it through a
hypervisor call.

Signed-off-by: Jake Moilanen <moilanen@austin.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc64/xmon/xmon.c test/arch/ppc64/xmon/xmon.c
--- linux-2.5/arch/ppc64/xmon/xmon.c	2005-01-12 18:20:48.000000000 +1100
+++ test/arch/ppc64/xmon/xmon.c	2005-01-22 10:55:46.664345064 +1100
@@ -624,6 +624,17 @@
 	return 0;
 }
 
+/* On systems with a hypervisor, we can't set the DABR
+   (data address breakpoint register) directly. */
+static void set_controlled_dabr(unsigned long val)
+{
+	if (systemcfg->platform == PLATFORM_PSERIES_LPAR) {
+		int rc = plpar_hcall_norets(H_SET_DABR, val);
+		if (rc != H_Success)
+			xmon_printf("Warning: setting DABR failed (%d)\n", rc);
+	} else
+		set_dabr(val);
+}
 
 static struct bpt *at_breakpoint(unsigned long pc)
 {
@@ -711,7 +722,7 @@
 static void insert_cpu_bpts(void)
 {
 	if (dabr.enabled)
-		set_dabr(dabr.address | (dabr.enabled & 7));
+		set_controlled_dabr(dabr.address | (dabr.enabled & 7));
 	if (iabr && (cur_cpu_spec->cpu_features & CPU_FTR_IABR))
 		set_iabr(iabr->address
 			 | (iabr->enabled & (BP_IABR|BP_IABR_TE)));
@@ -739,7 +750,7 @@
 
 static void remove_cpu_bpts(void)
 {
-	set_dabr(0);
+	set_controlled_dabr(0);
 	if ((cur_cpu_spec->cpu_features & CPU_FTR_IABR))
 		set_iabr(0);
 }
@@ -1049,8 +1060,8 @@
     "b <addr> [cnt]   set breakpoint at given instr addr\n"
     "bc               clear all breakpoints\n"
     "bc <n/addr>      clear breakpoint number n or at addr\n"
-    "bi <addr> [cnt]  set hardware instr breakpoint (broken?)\n"
-    "bd <addr> [cnt]  set hardware data breakpoint (broken?)\n"
+    "bi <addr> [cnt]  set hardware instr breakpoint (POWER3/RS64 only)\n"
+    "bd <addr> [cnt]  set hardware data breakpoint\n"
     "";
 
 static void
