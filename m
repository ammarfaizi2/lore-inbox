Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261732AbVCGKLf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbVCGKLf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 05:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261734AbVCGKLf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 05:11:35 -0500
Received: from ozlabs.org ([203.10.76.45]:47507 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261732AbVCGKLJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 05:11:09 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16940.10454.188673.504263@cargo.ozlabs.ibm.com>
Date: Mon, 7 Mar 2005 21:11:34 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: anton@samba.org, linux-kernel@vger.kernel.org,
       John Rose <johnrose@austin.ibm.com>
Subject: [PATCH] PPC64 set pci_io_base dynamically if necessary
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is from John Rose <johnrose@austin.ibm.com>.

Upon DLPAR addition of a PCI Host Brige to a system with purely virtual
I/O, set pci_io_base as necessary.

Signed-off-by: John Rose <johnrose@austin.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc64/kernel/pSeries_pci.c test/arch/ppc64/kernel/pSeries_pci.c
--- linux-2.5/arch/ppc64/kernel/pSeries_pci.c	2005-01-12 18:20:48.000000000 +1100
+++ test/arch/ppc64/kernel/pSeries_pci.c	2005-03-07 21:04:02.000000000 +1100
@@ -424,16 +424,18 @@
 	unsigned int root_size_cells = 0;
 	struct pci_controller *phb;
 	struct pci_bus *bus;
+	int primary;
 
 	root_size_cells = prom_n_size_cells(root);
 
+	primary = list_empty(&hose_list);
 	phb = alloc_phb_dynamic(dn, root_size_cells);
 	if (!phb)
 		return NULL;
 
 	pci_process_bridge_OF_ranges(phb, dn);
 
-	pci_setup_phb_io_dynamic(phb);
+	pci_setup_phb_io_dynamic(phb, primary);
 	of_node_put(root);
 
 	pci_devs_phb_init_dynamic(phb);
diff -urN linux-2.5/arch/ppc64/kernel/pci.c test/arch/ppc64/kernel/pci.c
--- linux-2.5/arch/ppc64/kernel/pci.c	2005-03-07 08:21:53.000000000 +1100
+++ test/arch/ppc64/kernel/pci.c	2005-03-07 21:04:02.000000000 +1100
@@ -619,7 +619,8 @@
 	res->end += io_virt_offset;
 }
 
-void __devinit pci_setup_phb_io_dynamic(struct pci_controller *hose)
+void __devinit pci_setup_phb_io_dynamic(struct pci_controller *hose,
+					int primary)
 {
 	unsigned long size = hose->pci_io_size;
 	unsigned long io_virt_offset;
@@ -631,6 +632,9 @@
 		hose->global_number, hose->io_base_phys,
 		(unsigned long) hose->io_base_virt);
 
+	if (primary)
+		pci_io_base = (unsigned long)hose->io_base_virt;
+
 	io_virt_offset = (unsigned long)hose->io_base_virt - pci_io_base;
 	res = &hose->io_resource;
 	res->start += io_virt_offset;
diff -urN linux-2.5/arch/ppc64/kernel/pci.h test/arch/ppc64/kernel/pci.h
--- linux-2.5/arch/ppc64/kernel/pci.h	2005-01-12 18:20:48.000000000 +1100
+++ test/arch/ppc64/kernel/pci.h	2005-03-07 21:06:52.000000000 +1100
@@ -16,8 +16,7 @@
 
 extern void pci_setup_pci_controller(struct pci_controller *hose);
 extern void pci_setup_phb_io(struct pci_controller *hose, int primary);
-
-extern void pci_setup_phb_io_dynamic(struct pci_controller *hose);
+extern void pci_setup_phb_io_dynamic(struct pci_controller *hose, int primary);
 
 
 extern struct list_head hose_list;
