Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964813AbWCXXLc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbWCXXLc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 18:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964815AbWCXXLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 18:11:32 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:11724 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S964813AbWCXXLb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 18:11:31 -0500
Date: Fri, 24 Mar 2006 17:11:29 -0600
To: Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/pseries: Cleanup device name printing.
Message-ID: <20060324231129.GB21895@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul,

Please apply and forward. 

--linas


[PATCH] powerpc/pseries: Cleanup device name printing.

This patch avoids printk'ing a NULL string.

Signed-off-by: Linas Vepstas <linas@linas.org>

----

 arch/powerpc/platforms/pseries/eeh_driver.c |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

Index: linux-2.6.16-git6/arch/powerpc/platforms/pseries/eeh_driver.c
===================================================================
--- linux-2.6.16-git6.orig/arch/powerpc/platforms/pseries/eeh_driver.c	2006-03-24 16:46:25.836892186 -0600
+++ linux-2.6.16-git6/arch/powerpc/platforms/pseries/eeh_driver.c	2006-03-24 16:58:55.305489138 -0600
@@ -257,6 +257,7 @@ void handle_eeh_events (struct eeh_event
 	struct pci_bus *frozen_bus;
 	int rc = 0;
 	enum pci_ers_result result = PCI_ERS_RESULT_NONE;
+	const char *pci_str, *drv_str;
 
 	frozen_dn = find_device_pe(event->dn);
 	frozen_bus = pcibios_find_pci_bus(frozen_dn);
@@ -291,6 +292,13 @@ void handle_eeh_events (struct eeh_event
 
 	frozen_pdn = PCI_DN(frozen_dn);
 	frozen_pdn->eeh_freeze_count++;
+
+	pci_str = pci_name (frozen_pdn->pcidev);
+	drv_str = pcid_name (frozen_pdn->pcidev);
+	if (!pci_str) {
+		pci_str = pci_name (event->dev);
+		drv_str = pcid_name (event->dev);
+	}
 	
 	if (frozen_pdn->eeh_freeze_count > EEH_MAX_ALLOWED_FREEZES)
 		goto hard_fail;
@@ -306,9 +314,7 @@ void handle_eeh_events (struct eeh_event
 	eeh_slot_error_detail(frozen_pdn, 1 /* Temporary Error */);
 	printk(KERN_WARNING
 	   "EEH: This PCI device has failed %d times since last reboot: %s - %s\n",
-		frozen_pdn->eeh_freeze_count,
-		pci_name (frozen_pdn->pcidev), 
-		pcid_name(frozen_pdn->pcidev));
+		frozen_pdn->eeh_freeze_count, drv_str, pci_str);
 
 	/* Walk the various device drivers attached to this slot through
 	 * a reset sequence, giving each an opportunity to do what it needs
@@ -360,9 +366,7 @@ hard_fail:
 	   "EEH: PCI device %s - %s has failed %d times \n"
 	   "and has been permanently disabled.  Please try reseating\n"
 	   "this device or replacing it.\n",
-		pci_name (frozen_pdn->pcidev), 
-		pcid_name(frozen_pdn->pcidev), 
-		frozen_pdn->eeh_freeze_count);
+		drv_str, pci_str, frozen_pdn->eeh_freeze_count);
 
 	eeh_slot_error_detail(frozen_pdn, 2 /* Permanent Error */);
 
