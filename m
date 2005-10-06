Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751272AbVJFXyj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbVJFXyj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 19:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbVJFXyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 19:54:39 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:7862 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751266AbVJFXyi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 19:54:38 -0400
Date: Thu, 6 Oct 2005 18:54:36 -0500
To: paulus@samba.org
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: [PATCH 17/22] ppc64: New Partition Endpoin support
Message-ID: <20051006235436.GR29826@austin.ibm.com>
References: <20051006232032.GA29826@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051006232032.GA29826@austin.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
From: linas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


17-eeh-partition-endpoint.patch

New versions of firmware introduce a new method by which the 
"partition endpoint" (the point at which the pci bus is cut). 
This code adds the support for this (mandatory) new feature.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>


Index: linux-2.6.14-rc2-git6/arch/ppc64/kernel/eeh.c
===================================================================
--- linux-2.6.14-rc2-git6.orig/arch/ppc64/kernel/eeh.c	2005-10-06 17:56:42.936627345 -0500
+++ linux-2.6.14-rc2-git6/arch/ppc64/kernel/eeh.c	2005-10-06 17:56:46.221166493 -0500
@@ -84,6 +84,7 @@
 static int ibm_read_slot_reset_state;
 static int ibm_read_slot_reset_state2;
 static int ibm_slot_error_detail;
+static int ibm_get_config_addr_info;
 
 static int eeh_subsystem_enabled;
 
@@ -458,6 +459,7 @@
 static void
 rtas_pci_slot_reset(struct pci_dn *pdn, int state)
 {
+	int config_addr;
 	int rc;
 
 	BUG_ON (pdn==NULL); 
@@ -468,8 +470,13 @@
 		return;
 	}
 
+	/* Use PE configuration address, if present */
+	config_addr = pdn->eeh_config_addr;
+	if (pdn->eeh_pe_config_addr)
+		config_addr = pdn->eeh_pe_config_addr;
+
 	rc = rtas_call(ibm_set_slot_reset,4,1, NULL,
-	               pdn->eeh_config_addr,
+	               config_addr,
 	               BUID_HI(pdn->phb->buid),
 	               BUID_LO(pdn->phb->buid),
 	               state);
@@ -696,8 +703,22 @@
 			eeh_subsystem_enabled = 1;
 			pdn->eeh_mode |= EEH_MODE_SUPPORTED;
 			pdn->eeh_config_addr = regs[0];
+
+			/* If the newer, better, ibm,get-config-addr-info is supported, 
+			 * then use that instead. */
+			pdn->eeh_pe_config_addr = 0;
+			if (ibm_get_config_addr_info != RTAS_UNKNOWN_SERVICE) {
+				unsigned int rets[2];
+				ret = rtas_call (ibm_get_config_addr_info, 4, 2, rets, 
+					pdn->eeh_config_addr, 
+					info->buid_hi, info->buid_lo,
+					0);
+				if (ret == 0)
+					pdn->eeh_pe_config_addr = rets[0];
+			}
 #ifdef DEBUG
-			printk(KERN_DEBUG "EEH: %s: eeh enabled\n", dn->full_name);
+			printk(KERN_DEBUG "EEH: %s: eeh enabled, config=%x pe_config=%x\n",
+			       dn->full_name, pdn->eeh_config_addr, pdn->eeh_pe_config_addr);
 #endif
 		} else {
 
@@ -749,6 +770,7 @@
 	ibm_read_slot_reset_state2 = rtas_token("ibm,read-slot-reset-state2");
 	ibm_read_slot_reset_state = rtas_token("ibm,read-slot-reset-state");
 	ibm_slot_error_detail = rtas_token("ibm,slot-error-detail");
+	ibm_get_config_addr_info = rtas_token("ibm,get-config-addr-info");
 
 	if (ibm_set_eeh_option == RTAS_UNKNOWN_SERVICE)
 		return;
Index: linux-2.6.14-rc2-git6/include/asm-ppc64/pci-bridge.h
===================================================================
--- linux-2.6.14-rc2-git6.orig/include/asm-ppc64/pci-bridge.h	2005-10-06 17:54:00.310445328 -0500
+++ linux-2.6.14-rc2-git6/include/asm-ppc64/pci-bridge.h	2005-10-06 17:56:46.222166353 -0500
@@ -61,6 +61,7 @@
 	int	devfn;			/* for pci devices */
 	int	eeh_mode;		/* See eeh.h for possible EEH_MODEs */
 	int	eeh_config_addr;
+	int	eeh_pe_config_addr; /* new-style partition endpoint address */
 	int 	eeh_check_count;	/* # times driver ignored error */
 	int 	eeh_freeze_count;	/* # times this device froze up. */
 	int	eeh_is_bridge;		/* device is pci-to-pci bridge */
