Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262111AbVAJG3D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262111AbVAJG3D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 01:29:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbVAJG3C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 01:29:02 -0500
Received: from ozlabs.org ([203.10.76.45]:59535 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262111AbVAJG2k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 01:28:40 -0500
Date: Tue, 11 Jan 2005 05:01:27 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Anton Blanchard <anton@samba.org>, Maynard Johnson <mpjohn@us.ibm.com>,
       linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PPC64] Functions to reserve performance monitor hardware
Message-ID: <20050110180127.GD22101@localhost.localdomain>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
	Maynard Johnson <mpjohn@us.ibm.com>, linuxppc64-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please apply:

The PPC64 interrupt code includes a hook to call when an exception
from the performance monitor unit occurs.  However, there's no way of
reserving the hook properly, so if more than one bit of code tries to
use it things will get ugly.  Currently oprofile is the only user, but
there are likely to be more in future e.g. perfctr, if and when it
reaches a fit state for merging.

This patch creates functions to reserve and release the performance
monitor hardware (including its interrupt), and makes oprofile use
them.  It also creates a new arch/ppc64/kernel/pmc.c, in which we can
put any future helper functions for handling the performance monitor
counters.

Signed-off-by: David Gibson <dwg@au1.ibm.com>

Index: working-2.6/arch/ppc64/kernel/pmc.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ working-2.6/arch/ppc64/kernel/pmc.c	2005-01-10 16:32:49.733411536 +1100
@@ -0,0 +1,65 @@
+/*
+ *  linux/arch/ppc64/kernel/pmc.c
+ *
+ *  Copyright (C) 2004 David Gibson, IBM Corporation.
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/config.h>
+#include <linux/errno.h>
+#include <linux/spinlock.h>
+
+#include <asm/processor.h>
+#include <asm/pmc.h>
+
+/* Ensure exceptions are disabled */
+static void dummy_perf(struct pt_regs *regs)
+{
+	unsigned int mmcr0 = mfspr(SPRN_MMCR0);
+
+	mmcr0 &= ~(MMCR0_PMXE|MMCR0_PMAO);
+	mtspr(SPRN_MMCR0, mmcr0);
+}
+
+static spinlock_t pmc_owner_lock = SPIN_LOCK_UNLOCKED;
+static void *pmc_owner_caller; /* mostly for debugging */
+perf_irq_t perf_irq = dummy_perf;
+
+int reserve_pmc_hardware(perf_irq_t new_perf_irq)
+{
+	int err = -EBUSY;;
+
+	spin_lock(&pmc_owner_lock);
+
+	if (pmc_owner_caller) {
+		printk(KERN_WARNING "reserve_pmc_hardware: "
+		       "PMC hardware busy (reserved by caller %p)\n",
+		       pmc_owner_caller);
+		goto out;
+	}
+
+	pmc_owner_caller = __builtin_return_address(0);
+	perf_irq = new_perf_irq ? : dummy_perf;
+
+	err = 0;
+
+ out:
+	spin_unlock(&pmc_owner_lock);
+	return err;
+}
+
+void release_pmc_hardware(void)
+{
+	spin_lock(&pmc_owner_lock);
+
+	WARN_ON(! pmc_owner_caller);
+
+	pmc_owner_caller = NULL;
+	perf_irq = dummy_perf;
+
+	spin_unlock(&pmc_owner_lock);
+}
Index: working-2.6/arch/ppc64/kernel/traps.c
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/traps.c	2005-01-10 10:51:31.000000000 +1100
+++ working-2.6/arch/ppc64/kernel/traps.c	2005-01-10 16:33:43.154412536 +1100
@@ -40,6 +40,7 @@
 #include <asm/rtas.h>
 #include <asm/systemcfg.h>
 #include <asm/machdep.h>
+#include <asm/pmc.h>
 
 #ifdef CONFIG_DEBUGGER
 int (*__debugger)(struct pt_regs *regs);
@@ -449,18 +450,7 @@
 	die("Unrecoverable VMX/Altivec Unavailable Exception", regs, SIGABRT);
 }
 
-/* Ensure exceptions are disabled */
-static void dummy_perf(struct pt_regs *regs)
-{
-	unsigned int mmcr0 = mfspr(SPRN_MMCR0);
-
-	mmcr0 &= ~(MMCR0_PMXE|MMCR0_PMAO);
-	mtspr(SPRN_MMCR0, mmcr0);
-}
-
-void (*perf_irq)(struct pt_regs *) = dummy_perf;
-
-EXPORT_SYMBOL(perf_irq);
+extern perf_irq_t perf_irq;
 
 void performance_monitor_exception(struct pt_regs *regs)
 {
Index: working-2.6/include/asm-ppc64/pmc.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ working-2.6/include/asm-ppc64/pmc.h	2005-01-10 15:24:40.217406672 +1100
@@ -0,0 +1,29 @@
+/*
+ * pmc.h
+ * Copyright (C) 2004  David Gibson, IBM Corporation
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ * 
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ * 
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+#ifndef _PPC64_PMC_H
+#define _PPC64_PMC_H
+
+#include <asm/ptrace.h>
+
+typedef void (*perf_irq_t)(struct pt_regs *);
+
+int reserve_pmc_hardware(perf_irq_t new_perf_irq);
+void release_pmc_hardware(void);
+
+#endif /* _PPC64_PMC_H */
Index: working-2.6/arch/ppc64/kernel/Makefile
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/Makefile	2005-01-10 10:51:31.000000000 +1100
+++ working-2.6/arch/ppc64/kernel/Makefile	2005-01-10 15:24:40.218406520 +1100
@@ -11,7 +11,7 @@
 			udbg.o binfmt_elf32.o sys_ppc32.o ioctl32.o \
 			ptrace32.o signal32.o rtc.o init_task.o \
 			lmb.o cputable.o cpu_setup_power4.o idle_power4.o \
-			iommu.o sysfs.o
+			iommu.o sysfs.o pmc.o
 
 obj-$(CONFIG_PPC_OF) +=	of_device.o
 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist.  NOT _the_ _other_ _way_
				| _around_!
http://www.ozlabs.org/people/dgibson
