Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751032AbVHLOsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032AbVHLOsS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 10:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750947AbVHLOsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 10:48:05 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:65178 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751032AbVHLOrZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 10:47:25 -0400
Subject: [RFC][PATCH 04/12] memory hotplug prep: __section_nr helper
To: linux-kernel@vger.kernel.org
From: Dave Hansen <haveblue@us.ibm.com>
Date: Fri, 12 Aug 2005 07:47:22 -0700
References: <20050812144714.805F4B48@kernel.beaverton.ibm.com>
In-Reply-To: <20050812144714.805F4B48@kernel.beaverton.ibm.com>
Message-Id: <20050812144722.2A4D8B7F@kernel.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A little helper that we use in the hotplug code.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 memhotplug-dave/include/linux/mmzone.h |   26 ++++++++++++++++++++++++++
 mm/sparse.c                            |    0 
 2 files changed, 26 insertions(+)

diff -puN include/linux/mmzone.h~C3-__section_nr include/linux/mmzone.h
--- memhotplug/include/linux/mmzone.h~C3-__section_nr	2005-08-12 07:43:45.000000000 -0700
+++ memhotplug-dave/include/linux/mmzone.h	2005-08-12 07:43:45.000000000 -0700
@@ -511,6 +511,31 @@ static inline struct mem_section *__nr_t
 }
 
 /*
+ * Although written for the SPARSEMEM_EXTREME case, this happens
+ * to also work for the flat array case becase
+ * NR_SECTION_ROOTS==NR_MEM_SECTIONS.
+ */
+static inline int __section_nr(struct mem_section* ms)
+{
+	unsigned long root_nr;
+	struct mem_section* root;
+
+	for (root_nr = 0;
+	     root_nr < NR_MEM_SECTIONS;
+	     root_nr += SECTIONS_PER_ROOT) {
+		root = __nr_to_section(root_nr);
+
+		if (!root)
+			continue;
+
+		if ((ms >= root) && (ms < (root + SECTIONS_PER_ROOT)))
+		     break;
+	}
+
+	return (root_nr * SECTIONS_PER_ROOT) + (ms - root);
+}
+
+/*
  * We use the lower bits of the mem_map pointer to store
  * a little bit of information.  There should be at least
  * 3 bits here due to 32-bit alignment.
@@ -606,3 +631,4 @@ unsigned long __init node_memmap_size_by
 #endif /* !__ASSEMBLY__ */
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MMZONE_H */
+
diff -puN mm/sparse.c~C3-__section_nr mm/sparse.c
_
