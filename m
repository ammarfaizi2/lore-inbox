Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261693AbVCQMJQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbVCQMJQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 07:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263043AbVCQLuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 06:50:25 -0500
Received: from ozlabs.org ([203.10.76.45]:43670 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263057AbVCQKqX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 05:46:23 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16953.24619.485334.953840@cargo.ozlabs.ibm.com>
Date: Thu, 17 Mar 2005 21:47:07 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: Nathan Lynch <ntl@pobox.com>, anton@samba.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] PPC64 pSeries_iommu.c: use pSeries reconfig notifier
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use the pSeries_reconfig notifier chain for tearing down the iommu
table when a device node is removed.

Signed-off-by: Nathan Lynch <ntl@pobox.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

 arch/ppc64/kernel/pSeries_iommu.c    |   25 +++++++++++++++
 arch/ppc64/kernel/pSeries_reconfig.c |   12 -------
 2 files changed, 25 insertions(+), 12 deletions(-)

Index: linux-2.6.11-bk10/arch/ppc64/kernel/pSeries_iommu.c
===================================================================
--- linux-2.6.11-bk10.orig/arch/ppc64/kernel/pSeries_iommu.c	2005-03-13 02:51:53.000000000 +0000
+++ linux-2.6.11-bk10/arch/ppc64/kernel/pSeries_iommu.c	2005-03-14 22:29:30.000000000 +0000
@@ -43,6 +43,7 @@
 #include <asm/machdep.h>
 #include <asm/abs_addr.h>
 #include <asm/plpar_wrappers.h>
+#include <asm/pSeries_reconfig.h>
 #include <asm/systemcfg.h>
 #include "pci.h"
 
@@ -455,6 +456,28 @@ static void iommu_dev_setup_pSeries(stru
 	}
 }
 
+static int iommu_reconfig_notifier(struct notifier_block *nb, unsigned long action, void *node)
+{
+	int err = NOTIFY_OK;
+	struct device_node *np = node;
+
+	switch (action) {
+	case PSERIES_RECONFIG_REMOVE:
+		if (np->iommu_table &&
+		    get_property(np, "ibm,dma-window", NULL))
+			iommu_free_table(np);
+		break;
+	default:
+		err = NOTIFY_DONE;
+		break;
+	}
+	return err;
+}
+
+static struct notifier_block iommu_reconfig_nb = {
+	.notifier_call = iommu_reconfig_notifier,
+};
+
 static void iommu_bus_setup_null(struct pci_bus *b) { }
 static void iommu_dev_setup_null(struct pci_dev *d) { }
 
@@ -487,6 +510,8 @@ void iommu_init_early_pSeries(void)
 
 	ppc_md.iommu_dev_setup = iommu_dev_setup_pSeries;
 
+	pSeries_reconfig_notifier_register(&iommu_reconfig_nb);
+
 	pci_iommu_init();
 }
 
Index: linux-2.6.11-bk10/arch/ppc64/kernel/pSeries_reconfig.c
===================================================================
--- linux-2.6.11-bk10.orig/arch/ppc64/kernel/pSeries_reconfig.c	2005-03-14 22:16:09.000000000 +0000
+++ linux-2.6.11-bk10/arch/ppc64/kernel/pSeries_reconfig.c	2005-03-14 22:29:30.000000000 +0000
@@ -164,16 +164,6 @@ out_err:
 	return err;
 }
 
-/*
- * Prepare an OF node for removal from system
- * XXX move this to pSeries_iommu.c
- */
-static void of_cleanup_node(struct device_node *np)
-{
-	if (np->iommu_table && get_property(np, "ibm,dma-window", NULL))
-		iommu_free_table(np);
-}
-
 static int pSeries_reconfig_remove_node(struct device_node *np)
 {
 	struct device_node *parent, *child;
@@ -187,8 +177,6 @@ static int pSeries_reconfig_remove_node(
 		return -EBUSY;
 	}
 
-	of_cleanup_node(np);
-
 	remove_node_proc_entries(np);
 
 	notifier_call_chain(&pSeries_reconfig_chain,
