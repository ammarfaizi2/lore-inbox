Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265053AbUGCIZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265053AbUGCIZu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 04:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265057AbUGCIZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 04:25:50 -0400
Received: from ozlabs.org ([203.10.76.45]:62940 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265053AbUGCIZm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 04:25:42 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16614.27917.591277.829508@cargo.ozlabs.ibm.com>
Date: Sat, 3 Jul 2004 18:23:41 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: linas@austin.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 EEH fixes for POWER5 machines (1/2)
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linas Vepstas <linas@austin.ibm.com>

This patch allows ppc64 to boot on Power5 machines.  The new Power5
PCI bridge design requires EEH (enhanced PCI error handling) to be
enabled for all PCI devices, not just some PCI devices.  In addition,
this patch moves the check for PCI to ISA bridges out of perf critical
code, and into initialization code.  This also avoids race conditions
where the device type might not have been set.  Also, some whitespace
fixes, and some error-message-printing beautification.

Signed-off-by: Linas Vepstas <linas@linas.org>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.6/arch/ppc64/kernel/eeh.c test26/arch/ppc64/kernel/eeh.c
--- linux-2.6/arch/ppc64/kernel/eeh.c	2004-07-03 16:03:13.021923824 +1000
+++ test26/arch/ppc64/kernel/eeh.c	2004-07-03 16:33:13.000000000 +1000
@@ -397,12 +397,6 @@
 		return val;
 	}
 
-        /* Make sure we aren't ISA */
-        if (!strcmp(dn->type, "isa")) {
-                pci_dev_put(dev);
-                return val;
-        }
-
 	if (!dn->eeh_config_addr) {
 		pci_dev_put(dev);
 		return val;
@@ -465,6 +459,7 @@
 struct eeh_early_enable_info {
 	unsigned int buid_hi;
 	unsigned int buid_lo;
+	int force_off;
 };
 
 /* Enable eeh for the given device node. */
@@ -479,6 +474,8 @@
 	u32 *regs;
 	int enable;
 
+	dn->eeh_mode = 0;
+
 	if (status && strcmp(status, "ok") != 0)
 		return NULL;	/* ignore devices with bad status */
 
@@ -492,6 +489,12 @@
 	     *device_id == 0x0188 || *device_id == 0x0302))
 		return NULL;
 
+	/* There is nothing to check on PCI to ISA bridges */
+	if (dn->type && !strcmp(dn->type, "isa")) {
+		dn->eeh_mode |= EEH_MODE_NOCHECK;
+		return NULL;
+	}
+
 	/*
 	 * Now decide if we are going to "Disable" EEH checking
 	 * for this device.  We still run with the EEH hardware active,
@@ -508,12 +511,12 @@
 				   enable)) {
 		if (enable) {
 			printk(KERN_WARNING "EEH: %s user requested to run "
-			       "without EEH.\n", dn->full_name);
+			       "without EEH checking.\n", dn->full_name);
 			enable = 0;
 		}
 	}
 
-	if (!enable) {
+	if (!enable || info->force_off) {
 		dn->eeh_mode = EEH_MODE_NOCHECK;
 		return NULL;
 	}
@@ -543,8 +546,8 @@
 			       dn->full_name);
 #endif
 		} else {
-			printk(KERN_WARNING "EEH: %s: could not enable EEH, rtas_call failed.\n",
-			       dn->full_name);
+			printk(KERN_WARNING "EEH: %s: could not enable EEH, rtas_call failed; rc=%d\n",
+			       dn->full_name, ret);
 		}
 	} else {
 		printk(KERN_WARNING "EEH: %s: unable to get reg property.\n",
@@ -570,10 +573,18 @@
  */
 void __init eeh_init(void)
 {
-	struct device_node *phb;
+	struct device_node *phb, *np;
 	struct eeh_early_enable_info info;
 	char *eeh_force_off = strstr(saved_command_line, "eeh-force-off");
 
+	init_pci_config_tokens();
+
+	np = of_find_node_by_path("/rtas");
+	if (np == NULL) {
+		printk(KERN_WARNING "EEH: RTAS not found !\n");
+		return;
+	}
+
 	ibm_set_eeh_option = rtas_token("ibm,set-eeh-option");
 	ibm_set_slot_reset = rtas_token("ibm,set-slot-reset");
 	ibm_read_slot_reset_state = rtas_token("ibm,read-slot-reset-state");
@@ -581,14 +592,14 @@
 	if (ibm_set_eeh_option == RTAS_UNKNOWN_SERVICE)
 		return;
 
+	info.force_off = 0;
 	if (eeh_force_off) {
 		printk(KERN_WARNING "EEH: WARNING: PCI Enhanced I/O Error "
 		       "Handling is user disabled\n");
-		return;
+		info.force_off = 1;
 	}
 
 	/* Enable EEH for all adapters.  Note that eeh requires buid's */
-	init_pci_config_tokens();
 	for (phb = of_find_node_by_name(NULL, "pci"); phb;
 	     phb = of_find_node_by_name(phb, "pci")) {
 		unsigned long buid;
@@ -602,8 +613,11 @@
 		traverse_pci_devices(phb, early_enable_eeh, NULL, &info);
 	}
 
-	if (eeh_subsystem_enabled)
+	if (eeh_subsystem_enabled) {
 		printk(KERN_INFO "EEH: PCI Enhanced I/O Error Handling Enabled\n");
+	} else {
+		printk(KERN_WARNING "EEH: disabled PCI Enhanced I/O Error Handling\n");
+	}
 }
 
 /**
@@ -743,10 +757,10 @@
 }
 
 static struct file_operations proc_eeh_operations = {
-	.open		= proc_eeh_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
+	.open      = proc_eeh_open,
+	.read      = seq_read,
+	.llseek    = seq_lseek,
+	.release   = single_release,
 };
 
 static int __init eeh_init_proc(void)
@@ -759,7 +773,7 @@
 			e->proc_fops = &proc_eeh_operations;
 	}
 
-        return 0;
+	return 0;
 }
 __initcall(eeh_init_proc);
 
