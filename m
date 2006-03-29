Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750960AbWC2VbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960AbWC2VbL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 16:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbWC2VbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 16:31:11 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:19943 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750960AbWC2VbJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 16:31:09 -0500
Date: Wed, 29 Mar 2006 15:31:04 -0600
To: Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linuxppc-dev@ozlabs.org
Subject: [PATCH]: powerpc/pseries: print message if EEH recovery fails
Message-ID: <20060329213104.GK2172@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Paul,
Pleae review/apply/forward upstream.

--linas

[PATCH]: powerpc/pseries: print message if EEH recovery fails

The current code prints an ambiguous message if the recovery
of a failed PCI device fails. Give this special case its own
unique message.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/platforms/pseries/eeh_driver.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

Index: linux-2.6.16-git6/arch/powerpc/platforms/pseries/eeh_driver.c
===================================================================
--- linux-2.6.16-git6.orig/arch/powerpc/platforms/pseries/eeh_driver.c	2006-03-29 14:45:42.000000000 -0600
+++ linux-2.6.16-git6/arch/powerpc/platforms/pseries/eeh_driver.c	2006-03-29 15:02:19.648928196 -0600
@@ -301,7 +301,7 @@ void handle_eeh_events (struct eeh_event
 	}
 	
 	if (frozen_pdn->eeh_freeze_count > EEH_MAX_ALLOWED_FREEZES)
-		goto hard_fail;
+		goto excess_failures;
 
 	/* If the reset state is a '5' and the time to reset is 0 (infinity)
 	 * or is more then 15 seconds, then mark this as a permanent failure.
@@ -356,7 +356,7 @@ void handle_eeh_events (struct eeh_event
 
 	return;
 	
-hard_fail:
+excess_failures:
 	/*
 	 * About 90% of all real-life EEH failures in the field
 	 * are due to poorly seated PCI cards. Only 10% or so are
@@ -367,7 +367,15 @@ hard_fail:
 	   "and has been permanently disabled.  Please try reseating\n"
 	   "this device or replacing it.\n",
 		drv_str, pci_str, frozen_pdn->eeh_freeze_count);
+	goto perm_error;
+
+hard_fail:
+	printk(KERN_ERR
+	   "EEH: Unable to recover from failure of PCI device %s - %s\n"
+	   "Please try reseating this device or replacing it.\n",
+		drv_str, pci_str);
 
+perm_error:
 	eeh_slot_error_detail(frozen_pdn, 2 /* Permanent Error */);
 
 	/* Notify all devices that they're about to go down. */
