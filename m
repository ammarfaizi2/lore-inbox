Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932698AbVJCVtn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932698AbVJCVtn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 17:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932702AbVJCVtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 17:49:43 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:62693 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932698AbVJCVtm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 17:49:42 -0400
Date: Mon, 3 Oct 2005 16:49:40 -0500
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: paulus@samba.org, linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       johnrose@austin.ibm.com
Subject: Re: [PATCH] ppc64: Crash in DLPAR code on PCI hotplug add
Message-ID: <20051003214940.GT29826@austin.ibm.com>
References: <20051003185739.GR29826@austin.ibm.com> <20051003213430.GD7554@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051003213430.GD7554@mipter.zuzino.mipt.ru>
User-Agent: Mutt/1.5.6+20040907i
From: linas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2005 at 01:34:30AM +0400, Alexey Dobriyan was heard to remark:
> 
> Please, add docs in a proper way:

Done, new patch attached.

--linas

08-hotplug-bugfix.patch

In the current 2.6.14-rc2-git6 kernel, performing a Dynamic LPAR Add 
of a hotplug slot will crash the system, with the following (abbreviated) 
stack trace:

cpu 0x3: Vector: 700 (Program Check) at [c000000053dff7f0]
    pc: c0000000004f5974: .__alloc_bootmem+0x0/0xb0
    lr: c0000000000258a0: .update_dn_pci_info+0x108/0x118
        c0000000000257c8 .update_dn_pci_info+0x30/0x118 (unreliable)
        c0000000000258fc .pci_dn_reconfig_notifier+0x4c/0x64
        c000000000060754 .notifier_call_chain+0x68/0x9c

The root cause was that the phb was not marked "dynamic", and so instead
of having kmalloc() being called, the __init __alloc_bootmem() was called,
resulting in access of garage data.  The patch below fixes this crash,
and adds some docs to clarify the code.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

Index: linux-2.6.14-rc2-git6/arch/ppc64/kernel/pci_dn.c
===================================================================
--- linux-2.6.14-rc2-git6.orig/arch/ppc64/kernel/pci_dn.c	2005-10-03 13:45:58.000000000 -0500
+++ linux-2.6.14-rc2-git6/arch/ppc64/kernel/pci_dn.c	2005-10-03 16:46:33.816658976 -0500
@@ -121,6 +121,14 @@
 	return NULL;
 }
 
+/** 
+ * pci_devs_phb_init_dynamic - setup pci devices under this PHB
+ * phb: pci-to-host bridge (top-level bridge connecting to cpu)
+ *
+ * This routine is called both during boot, (before the memory
+ * subsystem is set up, before kmalloc is valid) and during the 
+ * dynamic lpar operation of adding a PHB to a running system.
+ */
 void __devinit pci_devs_phb_init_dynamic(struct pci_controller *phb)
 {
 	struct device_node * dn = (struct device_node *) phb->arch_data;
@@ -201,17 +209,24 @@
 	.notifier_call = pci_dn_reconfig_notifier,
 };
 
-/*
- * Actually initialize the phbs.
- * The buswalk on this phb has not happened yet.
+/** 
+ * pci_devs_phb_init - Initialize phbs and pci devs under them.
+ * 
+ * This routine walks over all phb's (pci-host bridges) on the
+ * system, and sets up assorted pci-related structures 
+ * (including pci info in the device node structs) for each
+ * pci device found underneath.  This routine runs once,
+ * early in the boot sequence.
  */
 void __init pci_devs_phb_init(void)
 {
 	struct pci_controller *phb, *tmp;
 
 	/* This must be done first so the device nodes have valid pci info! */
-	list_for_each_entry_safe(phb, tmp, &hose_list, list_node)
+	list_for_each_entry_safe(phb, tmp, &hose_list, list_node) {
 		pci_devs_phb_init_dynamic(phb);
+		phb->is_dynamic = 1;
+	}
 
 	pSeries_reconfig_notifier_register(&pci_dn_reconfig_nb);
 }
