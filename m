Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751793AbWD1WmV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751793AbWD1WmV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 18:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751794AbWD1WmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 18:42:20 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:39345 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751793AbWD1WmU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 18:42:20 -0400
Date: Fri, 28 Apr 2006 17:42:18 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH]: powerpc/pseries: Print PCI slot location code on failure
Message-ID: <20060428224218.GE22621@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Paul,

A low-priority patch the improves diagnostic printing on EEH failures.
Please review and forward upstream as appropriate.

--linas

[PATCH]: powerpc/pseries: Print PCI slot location code on failure

The PCI error recovery code will printk diagnostic info when
a PCI error event occurs. Change the messages to include the slot
location code, which is how most sysadmins will know the device.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/platforms/pseries/eeh_driver.c |   33 ++++++++++++++++------------
 1 files changed, 20 insertions(+), 13 deletions(-)

Index: linux-2.6.17-rc1/arch/powerpc/platforms/pseries/eeh_driver.c
===================================================================
--- linux-2.6.17-rc1.orig/arch/powerpc/platforms/pseries/eeh_driver.c	2006-04-28 17:31:31.000000000 -0500
+++ linux-2.6.17-rc1/arch/powerpc/platforms/pseries/eeh_driver.c	2006-04-28 17:31:39.000000000 -0500
@@ -261,16 +261,20 @@ struct pci_dn * handle_eeh_events (struc
 	struct pci_bus *frozen_bus;
 	int rc = 0;
 	enum pci_ers_result result = PCI_ERS_RESULT_NONE;
-	const char *pci_str, *drv_str;
+	const char *location, *pci_str, *drv_str;
 
 	frozen_dn = find_device_pe(event->dn);
 	frozen_bus = pcibios_find_pci_bus(frozen_dn);
 
 	if (!frozen_dn) {
-		printk(KERN_ERR "EEH: Error: Cannot find partition endpoint for %s\n",
-		        pci_name(event->dev));
+
+		location = (char *) get_property(event->dn, "ibm,loc-code", NULL);
+		printk(KERN_ERR "EEH: Error: Cannot find partition endpoint "
+		                "for location=%s pci addr=%s\n",
+		        location, pci_name(event->dev));
 		return NULL;
 	}
+	location = (char *) get_property(frozen_dn, "ibm,loc-code", NULL);
 
 	/* There are two different styles for coming up with the PE.
 	 * In the old style, it was the highest EEH-capable device
@@ -282,8 +286,9 @@ struct pci_dn * handle_eeh_events (struc
 		frozen_bus = pcibios_find_pci_bus (frozen_dn->parent);
 
 	if (!frozen_bus) {
-		printk(KERN_ERR "EEH: Cannot find PCI bus for %s\n",
-		        frozen_dn->full_name);
+		printk(KERN_ERR "EEH: Cannot find PCI bus "
+		        "for location=%s dn=%s\n",
+		        location, frozen_dn->full_name);
 		return NULL;
 	}
 
@@ -318,8 +323,9 @@ struct pci_dn * handle_eeh_events (struc
 
 	eeh_slot_error_detail(frozen_pdn, 1 /* Temporary Error */);
 	printk(KERN_WARNING
-	   "EEH: This PCI device has failed %d times since last reboot: %s - %s\n",
-		frozen_pdn->eeh_freeze_count, drv_str, pci_str);
+	   "EEH: This PCI device has failed %d times since last reboot: "
+		"location=%s driver=%s pci addr=%s\n",
+		frozen_pdn->eeh_freeze_count, location, drv_str, pci_str);
 
 	/* Walk the various device drivers attached to this slot through
 	 * a reset sequence, giving each an opportunity to do what it needs
@@ -368,17 +374,18 @@ excess_failures:
 	 * due to actual, failed cards.
 	 */
 	printk(KERN_ERR
-	   "EEH: PCI device %s - %s has failed %d times \n"
-	   "and has been permanently disabled.  Please try reseating\n"
-	   "this device or replacing it.\n",
-		drv_str, pci_str, frozen_pdn->eeh_freeze_count);
+	   "EEH: PCI device at location=%s driver=%s pci addr=%s \n"
+		"has failed %d times and has been permanently disabled. \n"
+		"Please try reseating this device or replacing it.\n",
+		location, drv_str, pci_str, frozen_pdn->eeh_freeze_count);
 	goto perm_error;
 
 hard_fail:
 	printk(KERN_ERR
-	   "EEH: Unable to recover from failure of PCI device %s - %s\n"
+	   "EEH: Unable to recover from failure of PCI device "
+	   "at location=%s driver=%s pci addr=%s \n"
 	   "Please try reseating this device or replacing it.\n",
-		drv_str, pci_str);
+		location, drv_str, pci_str);
 
 perm_error:
 	eeh_slot_error_detail(frozen_pdn, 2 /* Permanent Error */);
