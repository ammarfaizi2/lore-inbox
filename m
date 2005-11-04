Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161047AbVKDA6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161047AbVKDA6K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 19:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161040AbVKDAzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 19:55:13 -0500
Received: from h-67-100-217-179.hstqtx02.covad.net ([67.100.217.179]:37012
	"EHLO mail.gnucash.org") by vger.kernel.org with ESMTP
	id S1161038AbVKDAzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 19:55:02 -0500
Date: Thu, 3 Nov 2005 18:55:01 -0600
From: Linas Vepstas <linas@linas.org>
To: paulus@samba.org, linuxppc64-dev@ozlabs.org
Cc: johnrose@austin.ibm.com, linux-pci@atrey.karlin.mff.cuni.cz,
       bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 39/42]: ppc64: handle multifunction PCI devices  properly
Message-ID: <20051104005501.GA27154@mail.gnucash.org>
Reply-To: linas@austin.ibm.com
References: <20051103235918.GA25616@mail.gnucash.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

239-eeh-multifunction-consolidate.patch

New-style firmware will often place multiple different functions 
under a non-EEH-aware parent.  However, tehse devices might share 
a common PE "partition endpoint" and config address, ad thus any
EEH events will affect all of the devices in common.  This patch
makes the effort to find all of these common devices and handle
them together.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

--
Index: linux-2.6.14-git3/arch/powerpc/platforms/pseries/eeh.c
===================================================================
--- linux-2.6.14-git3.orig/arch/powerpc/platforms/pseries/eeh.c	2005-11-02 14:48:13.093298267 -0600
+++ linux-2.6.14-git3/arch/powerpc/platforms/pseries/eeh.c	2005-11-02 14:48:44.941831253 -0600
@@ -223,6 +223,11 @@
 void eeh_mark_slot (struct device_node *dn, int mode_flag)
 {
 	dn = find_device_pe (dn);
+
+	/* Back up one, since config addrs might be shared */
+	if (PCI_DN(dn) && PCI_DN(dn)->eeh_pe_config_addr)
+		dn = dn->parent;
+
 	PCI_DN(dn)->eeh_mode |= mode_flag;
 	__eeh_mark_slot (dn->child, mode_flag);
 }
@@ -244,7 +249,13 @@
 {
 	unsigned long flags;
 	spin_lock_irqsave(&confirm_error_lock, flags);
+	
 	dn = find_device_pe (dn);
+	
+	/* Back up one, since config addrs might be shared */
+	if (PCI_DN(dn) && PCI_DN(dn)->eeh_pe_config_addr)
+		dn = dn->parent;
+
 	PCI_DN(dn)->eeh_mode &= ~mode_flag;
 	PCI_DN(dn)->eeh_check_count = 0;
 	__eeh_clear_slot (dn->child, mode_flag);
@@ -609,7 +620,7 @@
 	if (!pdn) 
 		return;
 	
-	if (! pdn->eeh_is_bridge)
+	if ((pdn->eeh_mode & EEH_MODE_SUPPORTED) && (!pdn->eeh_is_bridge))
 		__restore_bars (pdn);
 
 	dn = pdn->node->child;
Index: linux-2.6.14-git3/arch/powerpc/platforms/pseries/eeh_driver.c
===================================================================
--- linux-2.6.14-git3.orig/arch/powerpc/platforms/pseries/eeh_driver.c	2005-11-02 14:48:13.100297285 -0600
+++ linux-2.6.14-git3/arch/powerpc/platforms/pseries/eeh_driver.c	2005-11-02 14:48:44.950829991 -0600
@@ -213,9 +213,23 @@
 	if (rc)
 		return rc;
 
-	/* Walk over all functions on this device */
-	rtas_configure_bridge(pe_dn);
-	eeh_restore_bars(pe_dn);
+ 	/* New-style config addrs might be shared across multiple devices,
+ 	 * Walk over all functions on this device */
+ 	if (pe_dn->eeh_pe_config_addr) {
+ 		struct device_node *pe = pe_dn->node;
+ 		pe = pe->parent->child;
+ 		while (pe) {
+ 			struct pci_dn *ppe = PCI_DN(pe);
+ 			if (pe_dn->eeh_pe_config_addr == ppe->eeh_pe_config_addr) {
+ 				rtas_configure_bridge(ppe);
+ 				eeh_restore_bars(ppe);
+ 			}
+ 			pe = pe->sibling;
+ 		}
+ 	} else {
+ 		rtas_configure_bridge(pe_dn);
+ 		eeh_restore_bars(pe_dn);
+ 	}
 
 	/* Give the system 5 seconds to finish running the user-space
 	 * hotplug shutdown scripts, e.g. ifdown for ethernet.  Yes, 
