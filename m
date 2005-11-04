Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161054AbVKDBAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161054AbVKDBAG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 20:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161010AbVKDA7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 19:59:37 -0500
Received: from h-67-100-217-179.hstqtx02.covad.net ([67.100.217.179]:31636
	"EHLO mail.gnucash.org") by vger.kernel.org with ESMTP
	id S1161031AbVKDAyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 19:54:40 -0500
Date: Thu, 3 Nov 2005 18:54:39 -0600
From: Linas Vepstas <linas@linas.org>
To: paulus@samba.org, linuxppc64-dev@ozlabs.org
Cc: johnrose@austin.ibm.com, linux-pci@atrey.karlin.mff.cuni.cz,
       bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 36/42]: ppc64: Use PE configuration address consistently
Message-ID: <20051104005439.GA27130@mail.gnucash.org>
Reply-To: linas@austin.ibm.com
References: <20051103235918.GA25616@mail.gnucash.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

236-eeh-config-addr.patch

The PE configuration address wasn't being cnsistently used in all locations
where a config address is called for.  This patch adds it to the places it
should have appeared in.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

Index: linux-2.6.14-git3/arch/powerpc/platforms/pseries/eeh.c
===================================================================
--- linux-2.6.14-git3.orig/arch/powerpc/platforms/pseries/eeh.c	2005-11-02 14:45:43.651257860 -0600
+++ linux-2.6.14-git3/arch/powerpc/platforms/pseries/eeh.c	2005-11-02 14:47:07.798456202 -0600
@@ -110,6 +110,7 @@
 
 void eeh_slot_error_detail (struct pci_dn *pdn, int severity)
 {
+	int config_addr;
 	unsigned long flags;
 	int rc;
 
@@ -117,8 +118,13 @@
 	spin_lock_irqsave(&slot_errbuf_lock, flags);
 	memset(slot_errbuf, 0, eeh_error_buf_size);
 
+	/* Use PE configuration address, if present */
+	config_addr = pdn->eeh_config_addr;
+	if (pdn->eeh_pe_config_addr)
+		config_addr = pdn->eeh_pe_config_addr;
+
 	rc = rtas_call(ibm_slot_error_detail,
-	               8, 1, NULL, pdn->eeh_config_addr,
+	               8, 1, NULL, config_addr,
 	               BUID_HI(pdn->phb->buid),
 	               BUID_LO(pdn->phb->buid), NULL, 0,
 	               virt_to_phys(slot_errbuf),
@@ -138,6 +144,7 @@
 static int read_slot_reset_state(struct pci_dn *pdn, int rets[])
 {
 	int token, outputs;
+	int config_addr;
 
 	if (ibm_read_slot_reset_state2 != RTAS_UNKNOWN_SERVICE) {
 		token = ibm_read_slot_reset_state2;
@@ -148,7 +155,12 @@
 		outputs = 3;
 	}
 
-	return rtas_call(token, 3, outputs, rets, pdn->eeh_config_addr,
+	/* Use PE configuration address, if present */
+	config_addr = pdn->eeh_config_addr;
+	if (pdn->eeh_pe_config_addr)
+		config_addr = pdn->eeh_pe_config_addr;
+
+	return rtas_call(token, 3, outputs, rets, config_addr,
 			 BUID_HI(pdn->phb->buid), BUID_LO(pdn->phb->buid));
 }
 
@@ -284,7 +296,7 @@
 		return 0;
 	}
 
-	if (!pdn->eeh_config_addr) {
+	if (!pdn->eeh_config_addr && !pdn->eeh_pe_config_addr) {
 		__get_cpu_var(no_cfg_addr)++;
 		return 0;
 	}
@@ -613,13 +625,20 @@
 void
 rtas_configure_bridge(struct pci_dn *pdn)
 {
+	int config_addr;
 	int token = rtas_token ("ibm,configure-bridge");
 	int rc;
 
 	if (token == RTAS_UNKNOWN_SERVICE)
 		return;
+	
+	/* Use PE configuration address, if present */
+	config_addr = pdn->eeh_config_addr;
+	if (pdn->eeh_pe_config_addr)
+		config_addr = pdn->eeh_pe_config_addr;
+
 	rc = rtas_call(token,3,1, NULL,
-	               pdn->eeh_config_addr,
+	               config_addr,
 	               BUID_HI(pdn->phb->buid),
 	               BUID_LO(pdn->phb->buid));
 	if (rc) {
