Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264903AbUGBTdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264903AbUGBTdG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 15:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264857AbUGBTdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 15:33:06 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:2996 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S264912AbUGBTcl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 15:32:41 -0400
Date: Fri, 2 Jul 2004 14:32:39 -0500
From: linas@austin.ibm.com
To: paulus@au1.ibm.com, paulus@samba.org
Cc: linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6 PPC64 Power5 PCI boot fixes
Message-ID: <20040702143238.A17762@forte.austin.ibm.com>
References: <20040702142906.X21634@forte.austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040702142906.X21634@forte.austin.ibm.com>; from linas@austin.ibm.com on Fri, Jul 02, 2004 at 02:29:06PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Resending, I forgot to attach the patch last time.

On Fri, Jul 02, 2004 at 02:29:06PM -0500, linas@austin.ibm.com wrote:
> 
> Paul,
> 
> Please review and forward upstream the following PCI EEH patch.
> 
> This patch allows ppc64 to boot on the Power5 architecture.  The 
> new Power5 PCI bridge design requires EEH to be enabled for all PCI
> devices, not just some PCI devices.  In addition, this patch moves
> the check for PCI to ISA bridges out of perf critical code, and into
> initialization code.   This also avoids race conditions where the 
> device type might not have been set.  Also, some whitespace fixes, 
> and some error-message-printing beautification. 
> 
> Signed-off-by: Linas Vepstas <linas@linas.org>
> 
> --linas

--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="eeh-isa-power5.patch"

===== arch/ppc64/kernel/eeh.c 1.21 vs edited =====
--- 1.21/arch/ppc64/kernel/eeh.c	Fri Jul  2 13:49:21 2004
+++ edited/arch/ppc64/kernel/eeh.c	Fri Jul  2 14:06:51 2004
@@ -394,12 +394,6 @@
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
@@ -462,6 +456,7 @@
 struct eeh_early_enable_info {
 	unsigned int buid_hi;
 	unsigned int buid_lo;
+	int force_off;
 };
 
 /* Enable eeh for the given device node. */
@@ -476,6 +471,8 @@
 	u32 *regs;
 	int enable;
 
+	dn->eeh_mode = 0;
+
 	if (status && strcmp(status, "ok") != 0)
 		return NULL;	/* ignore devices with bad status */
 
@@ -489,6 +486,12 @@
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
@@ -505,12 +508,12 @@
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
@@ -540,8 +543,8 @@
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
@@ -567,10 +570,18 @@
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
@@ -578,14 +589,14 @@
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
@@ -599,8 +610,11 @@
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
@@ -740,10 +754,10 @@
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
@@ -756,7 +770,7 @@
 			e->proc_fops = &proc_eeh_operations;
 	}
 
-        return 0;
+	return 0;
 }
 __initcall(eeh_init_proc);
 

--Dxnq1zWXvFF0Q93v--
