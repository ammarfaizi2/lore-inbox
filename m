Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263053AbVCQLtB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263053AbVCQLtB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 06:49:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263047AbVCQLpD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 06:45:03 -0500
Received: from ozlabs.org ([203.10.76.45]:32661 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263049AbVCQKoj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 05:44:39 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16953.24528.580432.40738@cargo.ozlabs.ibm.com>
Date: Thu, 17 Mar 2005 21:45:36 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: Nathan Lynch <ntl@pobox.com>, anton@samba.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] PPC64 pci_dn.c: use pSeries reconfig notifier
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use the pSeries_reconfig notifier list to handle newly added pci
device nodes.

Signed-off-by: Nathan Lynch <ntl@pobox.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

 arch/ppc64/kernel/pci_dn.c |   22 ++++++++++++++++++++++
 arch/ppc64/kernel/prom.c   |   14 --------------
 2 files changed, 22 insertions(+), 14 deletions(-)

Index: linux-2.6.11-bk10/arch/ppc64/kernel/pci_dn.c
===================================================================
--- linux-2.6.11-bk10.orig/arch/ppc64/kernel/pci_dn.c	2005-03-14 21:28:14.000000000 +0000
+++ linux-2.6.11-bk10/arch/ppc64/kernel/pci_dn.c	2005-03-14 22:29:03.000000000 +0000
@@ -27,6 +27,7 @@
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/pci-bridge.h>
+#include <asm/pSeries_reconfig.h>
 
 #include "pci.h"
 
@@ -161,6 +162,25 @@ struct device_node *fetch_dev_dn(struct 
 }
 EXPORT_SYMBOL(fetch_dev_dn);
 
+static int pci_dn_reconfig_notifier(struct notifier_block *nb, unsigned long action, void *node)
+{
+	struct device_node *np = node;
+	int err = NOTIFY_OK;
+
+	switch (action) {
+	case PSERIES_RECONFIG_ADD:
+		update_dn_pci_info(np, np->parent->phb);
+		break;
+	default:
+		err = NOTIFY_DONE;
+		break;
+	}
+	return err;
+}
+
+static struct notifier_block pci_dn_reconfig_nb = {
+	.notifier_call = pci_dn_reconfig_notifier,
+};
 
 /*
  * Actually initialize the phbs.
@@ -173,4 +193,6 @@ void __init pci_devs_phb_init(void)
 	/* This must be done first so the device nodes have valid pci info! */
 	list_for_each_entry_safe(phb, tmp, &hose_list, list_node)
 		pci_devs_phb_init_dynamic(phb);
+
+	pSeries_reconfig_notifier_register(&pci_dn_reconfig_nb);
 }
Index: linux-2.6.11-bk10/arch/ppc64/kernel/prom.c
===================================================================
--- linux-2.6.11-bk10.orig/arch/ppc64/kernel/prom.c	2005-03-14 22:28:19.000000000 +0000
+++ linux-2.6.11-bk10/arch/ppc64/kernel/prom.c	2005-03-14 22:29:03.000000000 +0000
@@ -1591,7 +1591,6 @@ static int of_finish_dynamic_node(struct
 				  int unused3, int unused4)
 {
 	struct device_node *parent = of_get_parent(node);
-	u32 *regs;
 	int err = 0;
 	phandle *ibm_phandle;
 
@@ -1613,19 +1612,6 @@ static int of_finish_dynamic_node(struct
 	if ((ibm_phandle = (unsigned int *)get_property(node, "ibm,phandle", NULL)))
 		node->linux_phandle = *ibm_phandle;
 
-	/* now do the rough equivalent of update_dn_pci_info, this
-	 * probably is not correct for phb's, but should work for
-	 * IOAs and slots.
-	 */
-
-	node->phb = parent->phb;
-
-	regs = (u32 *)get_property(node, "reg", NULL);
-	if (regs) {
-		node->busno = (regs[0] >> 16) & 0xff;
-		node->devfn = (regs[0] >> 8) & 0xff;
-	}
-
 out:
 	of_node_put(parent);
 	return err;
