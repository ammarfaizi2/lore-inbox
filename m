Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261463AbUJXNEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbUJXNEf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 09:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbUJXNEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 09:04:35 -0400
Received: from verein.lst.de ([213.95.11.210]:52645 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261463AbUJXNEb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 09:04:31 -0400
Date: Sun, 24 Oct 2004 15:04:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: anton@samba.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] cleanups hpte_init_native, kill warning for !PSERIES builds
Message-ID: <20041024130428.GA19391@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00,REMOVE_REMOVAL_NEAR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this splits out a small helper that checks whether tlb batching should
be enabled from hpte_init_native, thus cleaning up the ifdef hell and
killing a warning for pmac builds.


--- 1.19/arch/ppc64/mm/hash_native.c	2004-09-30 07:34:39 +02:00
+++ edited/arch/ppc64/mm/hash_native.c	2004-10-24 11:56:10 +02:00
@@ -387,33 +387,37 @@
 	local_irq_restore(flags);
 }
 
-void hpte_init_native(void)
-{
 #ifdef CONFIG_PPC_PSERIES
-	struct device_node *root;
-	const char *model;
-#endif /* CONFIG_PPC_PSERIES */
+/* Disable TLB batching on nighthawk */
+static inline int tlb_batching_enabled(void)
+{
+	struct device_node *root = of_find_node_by_path("/");
+	int enabled = 1;
+
+	if (root) {
+		const char *model = get_property(root, "model", NULL);
+		if (!strcmp(model, "CHRP IBM,9076-N81"))
+			enabled = 0;
+		of_node_put(root);
+	}
+
+	return enabled;
+}
+#else
+static inline int tlb_batching_enabled(void)
+{
+	return 1;
+}
+#endif
 
+void hpte_init_native(void)
+{
 	ppc_md.hpte_invalidate	= native_hpte_invalidate;
 	ppc_md.hpte_updatepp	= native_hpte_updatepp;
 	ppc_md.hpte_updateboltedpp = native_hpte_updateboltedpp;
 	ppc_md.hpte_insert	= native_hpte_insert;
 	ppc_md.hpte_remove     	= native_hpte_remove;
-
-#ifdef CONFIG_PPC_PSERIES
-	/* Disable TLB batching on nighthawk */
-	root = of_find_node_by_path("/");
-	if (root) {
-		model = get_property(root, "model", NULL);
-		if (!strcmp(model, "CHRP IBM,9076-N81")) {
-			of_node_put(root);
-			goto bail;
-		}
-		of_node_put(root);
-	}
-#endif /* CONFIG_PPC_PSERIES */
-
-	ppc_md.flush_hash_range = native_flush_hash_range;
- bail:
+	if (tlb_batching_enabled())
+		ppc_md.flush_hash_range = native_flush_hash_range;
 	htab_finish_init();
 }
