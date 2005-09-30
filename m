Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932532AbVI3Ayz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932532AbVI3Ayz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 20:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932531AbVI3Ayy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 20:54:54 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:34704 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932528AbVI3Ayx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 20:54:53 -0400
Date: Thu, 29 Sep 2005 19:54:51 -0500
To: paulus@samba.org
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] ppc64: EEH Add event/internal state statistics
Message-ID: <20050930005451.GC6173@austin.ibm.com>
References: <20050930004800.GL29826@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050930004800.GL29826@austin.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
From: linas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


03-eeh-statistics.patch

This minor patch adds some statistics-gathering counters that allow the 
behaviour of the EEH subsystem o be monitored. While far from perfect,
it does provide a rudimentary device that makes understanding of the 
current state of the system a bit easier.

Signed-off-by: Linas Vepstas <linas@linas.org>


Index: linux-2.6.14-rc2-git6/arch/ppc64/kernel/eeh.c
===================================================================
--- linux-2.6.14-rc2-git6.orig/arch/ppc64/kernel/eeh.c	2005-09-29 13:52:08.188222887 -0500
+++ linux-2.6.14-rc2-git6/arch/ppc64/kernel/eeh.c	2005-09-29 16:05:53.025549160 -0500
@@ -102,6 +102,10 @@
 static int eeh_error_buf_size;
 
 /* System monitoring statistics */
+static DEFINE_PER_CPU(unsigned long, no_device);
+static DEFINE_PER_CPU(unsigned long, no_dn);
+static DEFINE_PER_CPU(unsigned long, no_cfg_addr);
+static DEFINE_PER_CPU(unsigned long, ignored_check);
 static DEFINE_PER_CPU(unsigned long, total_mmio_ffs);
 static DEFINE_PER_CPU(unsigned long, false_positives);
 static DEFINE_PER_CPU(unsigned long, ignored_failures);
@@ -493,8 +497,6 @@
 		notifier_call_chain (&eeh_notifier_chain,
 				     EEH_NOTIFY_FREEZE, event);
 
-		__get_cpu_var(slot_resets)++;
-
 		pci_dev_put(event->dev);
 		kfree(event);
 	}
@@ -546,17 +548,24 @@
 	if (!eeh_subsystem_enabled)
 		return 0;
 
-	if (!dn)
+	if (!dn) {
+		__get_cpu_var(no_dn)++;
 		return 0;
+	}
 	pdn = PCI_DN(dn);
 
 	/* Access to IO BARs might get this far and still not want checking. */
 	if (!pdn->eeh_capable || !(pdn->eeh_mode & EEH_MODE_SUPPORTED) ||
 	    pdn->eeh_mode & EEH_MODE_NOCHECK) {
+		__get_cpu_var(ignored_check)++;
+#ifdef DEBUG
+		printk ("EEH:ignored check for %s %s\n", pci_name (dev), dn->full_name);
+#endif
 		return 0;
 	}
 
 	if (!pdn->eeh_config_addr) {
+		__get_cpu_var(no_cfg_addr)++;
 		return 0;
 	}
 
@@ -590,6 +599,7 @@
 
 	/* prevent repeated reports of this failure */
 	pdn->eeh_mode |= EEH_MODE_ISOLATED;
+	 __get_cpu_var(slot_resets)++;
 
 	reset_state = rets[0];
 
@@ -657,8 +667,10 @@
 	/* Finding the phys addr + pci device; this is pretty quick. */
 	addr = eeh_token_to_phys((unsigned long __force) token);
 	dev = pci_get_device_by_addr(addr);
-	if (!dev)
+	if (!dev) {
+		__get_cpu_var(no_device)++;
 		return val;
+	}
 
 	dn = pci_device_to_OF_node(dev);
 	eeh_dn_check_failure (dn, dev);
@@ -903,12 +915,17 @@
 	unsigned int cpu;
 	unsigned long ffs = 0, positives = 0, failures = 0;
 	unsigned long resets = 0;
+	unsigned long no_dev = 0, no_dn = 0, no_cfg = 0, no_check = 0;
 
 	for_each_cpu(cpu) {
 		ffs += per_cpu(total_mmio_ffs, cpu);
 		positives += per_cpu(false_positives, cpu);
 		failures += per_cpu(ignored_failures, cpu);
 		resets += per_cpu(slot_resets, cpu);
+		no_dev += per_cpu(no_device, cpu);
+		no_dn += per_cpu(no_dn, cpu);
+		no_cfg += per_cpu(no_cfg_addr, cpu);
+		no_check += per_cpu(ignored_check, cpu);
 	}
 
 	if (0 == eeh_subsystem_enabled) {
@@ -916,13 +933,17 @@
 		seq_printf(m, "eeh_total_mmio_ffs=%ld\n", ffs);
 	} else {
 		seq_printf(m, "EEH Subsystem is enabled\n");
-		seq_printf(m, "eeh_total_mmio_ffs=%ld\n"
-			   "eeh_false_positives=%ld\n"
-			   "eeh_ignored_failures=%ld\n"
-			   "eeh_slot_resets=%ld\n"
-				"eeh_fail_count=%d\n",
-			   ffs, positives, failures, resets,
-				eeh_fail_count.counter);
+		seq_printf(m,
+				"no device=%ld\n"
+				"no device node=%ld\n"
+				"no config address=%ld\n"
+				"check not wanted=%ld\n"
+				"eeh_total_mmio_ffs=%ld\n"
+				"eeh_false_positives=%ld\n"
+				"eeh_ignored_failures=%ld\n"
+				"eeh_slot_resets=%ld\n",
+				no_dev, no_dn, no_cfg, no_check,
+				ffs, positives, failures, resets);
 	}
 
 	return 0;
