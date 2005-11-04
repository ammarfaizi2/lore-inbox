Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161017AbVKDBEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161017AbVKDBEg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 20:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161018AbVKDAty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 19:49:54 -0500
Received: from h-67-100-217-179.hstqtx02.covad.net ([67.100.217.179]:45203
	"EHLO mail.gnucash.org") by vger.kernel.org with ESMTP
	id S1161017AbVKDAtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 19:49:39 -0500
Date: Thu, 3 Nov 2005 18:49:38 -0600
From: Linas Vepstas <linas@linas.org>
To: paulus@samba.org, linuxppc64-dev@ozlabs.org
Cc: johnrose@austin.ibm.com, linux-pci@atrey.karlin.mff.cuni.cz,
       bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 9/42]: ppc64: bugfix: crash on PCI hotplug
Message-ID: <20051104004938.GA26852@mail.gnucash.org>
Reply-To: linas@austin.ibm.com
References: <20051103235918.GA25616@mail.gnucash.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

09-hotplug-bugfix.patch

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

Mailed to: paulus@samba.org
CC: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org, johnrose@linux.ibm.com
On Monday 3 October 2005

revised on 4 Ocober to
[PATCH 1/2] ppc64: Crash in DLPAR code on PCI hotplug add

Index: linux-2.6.14-git3/arch/ppc64/kernel/pci_dn.c
===================================================================
--- linux-2.6.14-git3.orig/arch/ppc64/kernel/pci_dn.c	2005-10-31 12:19:03.211506966 -0600
+++ linux-2.6.14-git3/arch/ppc64/kernel/pci_dn.c	2005-10-31 12:19:47.420303479 -0600
@@ -43,7 +43,7 @@
 	u32 *regs;
 	struct pci_dn *pdn;
 
-	if (phb->is_dynamic)
+	if (mem_init_done)
 		pdn = kmalloc(sizeof(*pdn), GFP_KERNEL);
 	else
 		pdn = alloc_bootmem(sizeof(*pdn));
@@ -120,6 +120,14 @@
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
@@ -200,9 +208,14 @@
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
