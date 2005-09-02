Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751352AbVIBU6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbVIBU6k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 16:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbVIBU6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 16:58:10 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:1699 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751234AbVIBU6E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 16:58:04 -0400
Subject: [PATCH 03/11] memory hotplug prep: __section_nr helper
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Fri, 02 Sep 2005 13:56:45 -0700
References: <20050902205643.9A4EC17A@kernel.beaverton.ibm.com>
In-Reply-To: <20050902205643.9A4EC17A@kernel.beaverton.ibm.com>
Message-Id: <20050902205645.FD6DE397@kernel.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A little helper that we use in the hotplug code.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 memhotplug-dave/include/linux/mmzone.h |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+)

diff -puN include/linux/mmzone.h~C3-__section_nr include/linux/mmzone.h
--- memhotplug/include/linux/mmzone.h~C3-__section_nr	2005-08-18 14:59:45.000000000 -0700
+++ memhotplug-dave/include/linux/mmzone.h	2005-08-18 14:59:45.000000000 -0700
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
_
