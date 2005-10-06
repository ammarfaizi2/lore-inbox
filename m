Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751226AbVJFXXX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbVJFXXX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 19:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbVJFXXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 19:23:23 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:65485 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751226AbVJFXXW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 19:23:22 -0400
Date: Thu, 6 Oct 2005 18:23:16 -0500
To: paulus@samba.org
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: [PATCH 1/22] ppc64: Dynamic LPAR bugfix
Message-ID: <20051006232316.GB29826@austin.ibm.com>
References: <20051006232032.GA29826@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051006232032.GA29826@austin.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
From: linas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


01-hotplug-bugfix.patch

In the current 2.6.14-rc2-git6 kernel, performing a Dynamic LPAR Add 
of a hotplug slot will crash the system, with the following (abbreviated) 
stack trace:

cpu 0x3: Vector: 700 (Program Check) at [c000000053dff7f0]
    pc: c0000000004f5974: .__alloc_bootmem+0x0/0xb0
    lr: c0000000000258a0: .update_dn_pci_info+0x108/0x118
        c0000000000257c8 .update_dn_pci_info+0x30/0x118 (unreliable)
        c0000000000258fc .pci_dn_reconfig_notifier+0x4c/0x64
        c000000000060754 .notifier_call_chain+0x68/0x9c

The root cause was that __init __alloc_bootmem() was called long after 
boot had finished, resulting in a crash because this routine is undefined
after boot time.  The patch below fixes this crash, and adds some docs to 
clarify the code.

p.s. congrats to all for getting slashdotted on this yesterday!

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

Index: linux-2.6.14-rc2-git6/arch/ppc64/kernel/pci_dn.c
===================================================================
--- linux-2.6.14-rc2-git6.orig/arch/ppc64/kernel/pci_dn.c	2005-10-03 13:45:58.000000000 -0500
+++ linux-2.6.14-rc2-git6/arch/ppc64/kernel/pci_dn.c	2005-10-04 15:37:49.761245845 -0500
@@ -44,7 +44,7 @@
 	u32 *regs;
 	struct pci_dn *pdn;
 
-	if (phb->is_dynamic)
+	if (mem_init_done)
 		pdn = kmalloc(sizeof(*pdn), GFP_KERNEL);
 	else
 		pdn = alloc_bootmem(sizeof(*pdn));
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
@@ -201,9 +209,14 @@
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
