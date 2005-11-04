Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030581AbVKDAx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030581AbVKDAx5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 19:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030582AbVKDAxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 19:53:54 -0500
Received: from h-67-100-217-179.hstqtx02.covad.net ([67.100.217.179]:11156
	"EHLO mail.gnucash.org") by vger.kernel.org with ESMTP
	id S1030578AbVKDAx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 19:53:27 -0500
Date: Thu, 3 Nov 2005 18:53:20 -0600
From: Linas Vepstas <linas@linas.org>
To: paulus@samba.org, linuxppc64-dev@ozlabs.org
Cc: johnrose@austin.ibm.com, linux-pci@atrey.karlin.mff.cuni.cz,
       bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 26/42]: ppc64: Add "partion endpoint" support
Message-ID: <20051104005320.GA27049@mail.gnucash.org>
Reply-To: linas@austin.ibm.com
References: <20051103235918.GA25616@mail.gnucash.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

26-eeh-partition-endpoint.patch

New versions of firmware introduce a new method by which the 
"partition endpoint" (the point at which the pci bus is cut). 
This code adds the support for this (mandatory) new feature.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>


Index: linux-2.6.14-git3/arch/powerpc/platforms/pseries/eeh.c
===================================================================
--- linux-2.6.14-git3.orig/arch/powerpc/platforms/pseries/eeh.c	2005-11-02 14:42:38.986155538 -0600
+++ linux-2.6.14-git3/arch/powerpc/platforms/pseries/eeh.c	2005-11-02 14:43:49.212307192 -0600
@@ -83,6 +83,7 @@
 static int ibm_read_slot_reset_state;
 static int ibm_read_slot_reset_state2;
 static int ibm_slot_error_detail;
+static int ibm_get_config_addr_info;
 
 static int eeh_subsystem_enabled;
 
@@ -457,6 +458,7 @@
 static void
 rtas_pci_slot_reset(struct pci_dn *pdn, int state)
 {
+	int config_addr;
 	int rc;
 
 	BUG_ON (pdn==NULL); 
@@ -467,8 +469,13 @@
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
@@ -695,8 +702,22 @@
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
 
@@ -748,6 +769,7 @@
 	ibm_read_slot_reset_state2 = rtas_token("ibm,read-slot-reset-state2");
 	ibm_read_slot_reset_state = rtas_token("ibm,read-slot-reset-state");
 	ibm_slot_error_detail = rtas_token("ibm,slot-error-detail");
+	ibm_get_config_addr_info = rtas_token("ibm,get-config-addr-info");
 
 	if (ibm_set_eeh_option == RTAS_UNKNOWN_SERVICE)
 		return;
Index: linux-2.6.14-git3/include/asm-ppc64/pci-bridge.h
===================================================================
--- linux-2.6.14-git3.orig/include/asm-ppc64/pci-bridge.h	2005-11-02 14:39:24.755392219 -0600
+++ linux-2.6.14-git3/include/asm-ppc64/pci-bridge.h	2005-11-02 14:43:49.218306351 -0600
@@ -63,6 +63,7 @@
 	int	devfn;			/* for pci devices */
 	int	eeh_mode;		/* See eeh.h for possible EEH_MODEs */
 	int	eeh_config_addr;
+	int	eeh_pe_config_addr; /* new-style partition endpoint address */
 	int 	eeh_check_count;	/* # times driver ignored error */
 	int 	eeh_freeze_count;	/* # times this device froze up. */
 	int	eeh_is_bridge;		/* device is pci-to-pci bridge */
