Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262022AbVCaWPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262022AbVCaWPU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 17:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262026AbVCaWPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 17:15:19 -0500
Received: from aun.it.uu.se ([130.238.12.36]:3774 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262022AbVCaWJR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 17:09:17 -0500
Date: Fri, 1 Apr 2005 00:09:04 +0200 (MEST)
Message-Id: <200503312209.j2VM94QH011932@alkaid.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH 2.6.12-rc1-mm5 2/3] perfctr: common updates for ppc64
Cc: anton@samba.org, linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ppc64 perfctr driver from David Gibson <david@gibson.dropbear.id.au>:
- perfctr common updates: Makefile, version
- perfctr virtual quirk: the ppc64 low-level driver is unable to
  prevent all stray overflow interrupts, on ppc64 (and only ppc64)
  the right action in this case is to ignore the interrupt and resume

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 drivers/perfctr/Makefile  |    5 ++++-
 drivers/perfctr/version.h |    2 +-
 drivers/perfctr/virtual.c |   11 ++++++++++-
 3 files changed, 15 insertions(+), 3 deletions(-)

diff -rupN linux-2.6.12-rc1-mm4/drivers/perfctr/Makefile linux-2.6.12-rc1-mm4.perfctr-ppc64-common-update/drivers/perfctr/Makefile
--- linux-2.6.12-rc1-mm4/drivers/perfctr/Makefile	2005-03-31 21:08:26.000000000 +0200
+++ linux-2.6.12-rc1-mm4.perfctr-ppc64-common-update/drivers/perfctr/Makefile	2005-03-31 23:36:04.000000000 +0200
@@ -1,4 +1,4 @@
-# $Id: Makefile,v 1.26 2004/05/30 23:02:14 mikpe Exp $
+# $Id: Makefile,v 1.27 2005/03/23 01:29:34 mikpe Exp $
 # Makefile for the Performance-monitoring counters driver.
 
 # This also covers x86_64.
@@ -8,6 +8,9 @@ tests-objs-$(CONFIG_X86) := x86_tests.o
 perfctr-objs-$(CONFIG_PPC32) := ppc.o
 tests-objs-$(CONFIG_PPC32) := ppc_tests.o
 
+perfctr-objs-$(CONFIG_PPC64) := ppc64.o
+tests-objs-$(CONFIG_PPC64) := ppc64_tests.o
+
 perfctr-objs-y += init.o
 perfctr-objs-$(CONFIG_PERFCTR_INIT_TESTS) += $(tests-objs-y)
 perfctr-objs-$(CONFIG_PERFCTR_VIRTUAL) += virtual.o
diff -rupN linux-2.6.12-rc1-mm4/drivers/perfctr/version.h linux-2.6.12-rc1-mm4.perfctr-ppc64-common-update/drivers/perfctr/version.h
--- linux-2.6.12-rc1-mm4/drivers/perfctr/version.h	2005-03-31 21:08:26.000000000 +0200
+++ linux-2.6.12-rc1-mm4.perfctr-ppc64-common-update/drivers/perfctr/version.h	2005-03-31 23:36:04.000000000 +0200
@@ -1 +1 @@
-#define VERSION "2.7.14"
+#define VERSION "2.7.15"
diff -rupN linux-2.6.12-rc1-mm4/drivers/perfctr/virtual.c linux-2.6.12-rc1-mm4.perfctr-ppc64-common-update/drivers/perfctr/virtual.c
--- linux-2.6.12-rc1-mm4/drivers/perfctr/virtual.c	2005-03-31 21:08:26.000000000 +0200
+++ linux-2.6.12-rc1-mm4.perfctr-ppc64-common-update/drivers/perfctr/virtual.c	2005-03-31 23:36:04.000000000 +0200
@@ -1,4 +1,4 @@
-/* $Id: virtual.c,v 1.111 2005/02/20 11:56:44 mikpe Exp $
+/* $Id: virtual.c,v 1.115 2005/03/28 22:39:02 mikpe Exp $
  * Virtual per-process performance counters.
  *
  * Copyright (C) 1999-2005  Mikael Pettersson
@@ -272,8 +272,17 @@ static void vperfctr_handle_overflow(str
 
 	pmc_mask = perfctr_cpu_identify_overflow(&perfctr->cpu_state);
 	if (!pmc_mask) {
+#ifdef CONFIG_PPC64
+		/* On some hardware (ppc64, in particular) it's
+		 * impossible to control interrupts finely enough to
+		 * eliminate overflows on counters we don't care
+		 * about.  So in this case just restart the counters
+		 * and keep going. */
+		vperfctr_resume(perfctr);
+#else
 		printk(KERN_ERR "%s: BUG! pid %d has unidentifiable overflow source\n",
 		       __FUNCTION__, tsk->pid);
+#endif
 		return;
 	}
 	perfctr->ireload_needed = 1;
