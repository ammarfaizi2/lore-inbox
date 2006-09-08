Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750949AbWIHM1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbWIHM1Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 08:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750958AbWIHM1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 08:27:23 -0400
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:27284
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750949AbWIHM1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 08:27:22 -0400
Date: Fri, 8 Sep 2006 13:26:48 +0100
From: Andy Whitcroft <apw@shadowen.org>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Andy Whitcroft <apw@shadowen.org>
Subject: [PATCH 4/5] linear reclaim add pfn_valid_within for zone holes
Message-ID: <20060908122648.GA1481@shadowen.org>
References: <exportbomb.1157718286@pinky>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
InReply-To: <exportbomb.1157718286@pinky>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linear reclaim add pfn_valid_within for zone holes

Generally we work under the assumption that memory the mem_map array
is contigious and valid out to MAX_ORDER blocks.  When this is not
true we much check each and every reference we make from a pfn.
Add a pfn_valid_within() which should be used when checking pages
within a block when we have already checked the validility of the
block normally.  This can then be optimised away when we have holes.

Added in: V1

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 3d31354..8c09638 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -680,6 +680,18 @@ #endif
 void memory_present(int nid, unsigned long start, unsigned long end);
 unsigned long __init node_memmap_size_bytes(int, unsigned long, unsigned long);
 
+/*
+ * If we have holes within zones (smaller than MAX_ORDER) then we need
+ * to check pfn validility within MAX_ORDER blocks.  pfn_valid_within
+ * should be used in this case; we optimise this away when we have
+ * no holes.
+ */
+#ifdef CONFIG_HOLES_IN_ZONE
+#define pfn_valid_within(pfn) pfn_valid(pfn)
+#else
+#define pfn_valid_within(pfn) (1)
+#endif
+
 #endif /* !__ASSEMBLY__ */
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MMZONE_H */
