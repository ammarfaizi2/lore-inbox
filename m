Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161042AbVKDAzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161042AbVKDAzi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 19:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161030AbVKDAzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 19:55:37 -0500
Received: from h-67-100-217-179.hstqtx02.covad.net ([67.100.217.179]:42132
	"EHLO mail.gnucash.org") by vger.kernel.org with ESMTP
	id S1161044AbVKDAz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 19:55:26 -0500
Date: Thu, 3 Nov 2005 18:55:25 -0600
From: Linas Vepstas <linas@linas.org>
To: paulus@samba.org, linuxppc64-dev@ozlabs.org
Cc: johnrose@austin.ibm.com, linux-pci@atrey.karlin.mff.cuni.cz,
       bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 42/42]: ppc64: get rid of per_cpu counters
Message-ID: <20051104005525.GA27197@mail.gnucash.org>
Reply-To: linas@austin.ibm.com
References: <20051103235918.GA25616@mail.gnucash.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

242-eeh-no-percpu-counters.patch

Remove per-cpu counters from the EEH code.  These statistics counters are 
incremented at a very low-frequency, and the performance gains of per-cpu 
variables are negligable.  By conrast, the counters weren't safe against
cpu gard operations, and its not worth the effeort to make them so (other
than to turn them into plain globals).

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

--
Index: linux-2.6.14-git3/arch/powerpc/platforms/pseries/eeh.c
===================================================================
--- linux-2.6.14-git3.orig/arch/powerpc/platforms/pseries/eeh.c	2005-11-02 18:42:28.243139205 -0600
+++ linux-2.6.14-git3/arch/powerpc/platforms/pseries/eeh.c	2005-11-02 18:49:24.196716323 -0600
@@ -97,14 +97,14 @@
 static int eeh_error_buf_size;
 
 /* System monitoring statistics */
-static DEFINE_PER_CPU(unsigned long, no_device);
-static DEFINE_PER_CPU(unsigned long, no_dn);
-static DEFINE_PER_CPU(unsigned long, no_cfg_addr);
-static DEFINE_PER_CPU(unsigned long, ignored_check);
-static DEFINE_PER_CPU(unsigned long, total_mmio_ffs);
-static DEFINE_PER_CPU(unsigned long, false_positives);
-static DEFINE_PER_CPU(unsigned long, ignored_failures);
-static DEFINE_PER_CPU(unsigned long, slot_resets);
+static unsigned long no_device;
+static unsigned long no_dn;
+static unsigned long no_cfg_addr;
+static unsigned long ignored_check;
+static unsigned long total_mmio_ffs;
+static unsigned long false_positives;
+static unsigned long ignored_failures;
+static unsigned long slot_resets;
 
 #define IS_BRIDGE(class_code) (((class_code)<<16) == PCI_BASE_CLASS_BRIDGE)
 
@@ -288,13 +288,13 @@
 	enum pci_channel_state state;
 	int rc = 0;
 
-	__get_cpu_var(total_mmio_ffs)++;
+	total_mmio_ffs++;
 
 	if (!eeh_subsystem_enabled)
 		return 0;
 
 	if (!dn) {
-		__get_cpu_var(no_dn)++;
+		no_dn++;
 		return 0;
 	}
 	pdn = PCI_DN(dn);
@@ -302,7 +302,7 @@
 	/* Access to IO BARs might get this far and still not want checking. */
 	if (!(pdn->eeh_mode & EEH_MODE_SUPPORTED) ||
 	    pdn->eeh_mode & EEH_MODE_NOCHECK) {
-		__get_cpu_var(ignored_check)++;
+		ignored_check++;
 #ifdef DEBUG
 		printk ("EEH:ignored check (%x) for %s %s\n", 
 		        pdn->eeh_mode, pci_name (dev), dn->full_name);
@@ -311,7 +311,7 @@
 	}
 
 	if (!pdn->eeh_config_addr && !pdn->eeh_pe_config_addr) {
-		__get_cpu_var(no_cfg_addr)++;
+		no_cfg_addr++;
 		return 0;
 	}
 
@@ -353,7 +353,7 @@
 	if (ret != 0) {
 		printk(KERN_WARNING "EEH: read_slot_reset_state() failed; rc=%d dn=%s\n",
 		       ret, dn->full_name);
-		__get_cpu_var(false_positives)++;
+		false_positives++;
 		rc = 0;
 		goto dn_unlock;
 	}
@@ -362,14 +362,14 @@
 	if (rets[1] != 1) {
 		printk(KERN_WARNING "EEH: event on unsupported device, rc=%d dn=%s\n",
 		       ret, dn->full_name);
-		__get_cpu_var(false_positives)++;
+		false_positives++;
 		rc = 0;
 		goto dn_unlock;
 	}
 
 	/* If not the kind of error we know about, punt. */
 	if (rets[0] != 2 && rets[0] != 4 && rets[0] != 5) {
-		__get_cpu_var(false_positives)++;
+		false_positives++;
 		rc = 0;
 		goto dn_unlock;
 	}
@@ -377,12 +377,12 @@
 	/* Note that config-io to empty slots may fail;
 	 * we recognize empty because they don't have children. */
 	if ((rets[0] == 5) && (dn->child == NULL)) {
-		__get_cpu_var(false_positives)++;
+		false_positives++;
 		rc = 0;
 		goto dn_unlock;
 	}
 
-	__get_cpu_var(slot_resets)++;
+	slot_resets++;
  
 	/* Avoid repeated reports of this failure, including problems
 	 * with other functions on this device, and functions under
@@ -432,7 +432,7 @@
 	addr = eeh_token_to_phys((unsigned long __force) token);
 	dev = pci_get_device_by_addr(addr);
 	if (!dev) {
-		__get_cpu_var(no_device)++;
+		no_device++;
 		return val;
 	}
 
@@ -963,25 +963,9 @@
 
 static int proc_eeh_show(struct seq_file *m, void *v)
 {
-	unsigned int cpu;
-	unsigned long ffs = 0, positives = 0, failures = 0;
-	unsigned long resets = 0;
-	unsigned long no_dev = 0, no_dn = 0, no_cfg = 0, no_check = 0;
-
-	for_each_cpu(cpu) {
-		ffs += per_cpu(total_mmio_ffs, cpu);
-		positives += per_cpu(false_positives, cpu);
-		failures += per_cpu(ignored_failures, cpu);
-		resets += per_cpu(slot_resets, cpu);
-		no_dev += per_cpu(no_device, cpu);
-		no_dn += per_cpu(no_dn, cpu);
-		no_cfg += per_cpu(no_cfg_addr, cpu);
-		no_check += per_cpu(ignored_check, cpu);
-	}
-
 	if (0 == eeh_subsystem_enabled) {
 		seq_printf(m, "EEH Subsystem is globally disabled\n");
-		seq_printf(m, "eeh_total_mmio_ffs=%ld\n", ffs);
+		seq_printf(m, "eeh_total_mmio_ffs=%ld\n", total_mmio_ffs);
 	} else {
 		seq_printf(m, "EEH Subsystem is enabled\n");
 		seq_printf(m,
@@ -993,8 +977,10 @@
 				"eeh_false_positives=%ld\n"
 				"eeh_ignored_failures=%ld\n"
 				"eeh_slot_resets=%ld\n",
-				no_dev, no_dn, no_cfg, no_check,
-				ffs, positives, failures, resets);
+				no_device, no_dn, no_cfg_addr, 
+				ignored_check, total_mmio_ffs, 
+				false_positives, ignored_failures, 
+				slot_resets);
 	}
 
 	return 0;
