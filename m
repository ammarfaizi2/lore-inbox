Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262145AbUJZHb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262145AbUJZHb5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 03:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262148AbUJZHb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 03:31:57 -0400
Received: from gate.crashing.org ([63.228.1.57]:3546 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262145AbUJZHby (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 03:31:54 -0400
Subject: [PATCH] ppc64: Fix g5-only build
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 26 Oct 2004 17:28:32 +1000
Message-Id: <1098775712.6897.17.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

The iommu_free_table() patch broke g5 only build by adding back some incestuous
relationship between generic code and pSeries code.
This patch wraps this in #ifdef as a quick fix until the original author of the
patch comes up with a better solution.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/ppc64/kernel/prom.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/prom.c	2004-10-26 13:15:54.000000000 +1000
+++ linux-work/arch/ppc64/kernel/prom.c	2004-10-26 17:22:28.397358448 +1000
@@ -1818,8 +1818,13 @@
 		return -EBUSY;
 	}
 
+	/* XXX This is a layering violation, should be moved to the caller
+	 * --BenH.
+	 */
+#ifdef CONFIG_PPC_PSERIES
 	if (np->iommu_table)
 		iommu_free_table(np);
+#endif /* CONFIG_PPC_PSERIES */
 
 	write_lock(&devtree_lock);
 	OF_MARK_STALE(np);
Index: linux-work/include/asm-ppc64/iommu.h
===================================================================
--- linux-work.orig/include/asm-ppc64/iommu.h	2004-10-26 13:15:55.000000000 +1000
+++ linux-work/include/asm-ppc64/iommu.h	2004-10-26 17:19:17.086442128 +1000
@@ -111,9 +111,17 @@
 extern void iommu_setup_u3(void);
 
 /* Creates table for an individual device node */
+/* XXX: This isn't generic, please name it accordingly or add
+ * some ppc_md. hooks for iommu implementations to do what they
+ * need to do. --BenH.
+ */
 extern void iommu_devnode_init(struct device_node *dn);
 
 /* Frees table for an individual device node */
+/* XXX: This isn't generic, please name it accordingly or add
+ * some ppc_md. hooks for iommu implementations to do what they
+ * need to do. --BenH.
+ */
 extern void iommu_free_table(struct device_node *dn);
 
 #endif /* CONFIG_PPC_MULTIPLATFORM */


