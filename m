Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030560AbVKPXAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030560AbVKPXAi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 18:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030562AbVKPXAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 18:00:38 -0500
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:60643
	"EHLO pinky.shadowen.org") by vger.kernel.org with ESMTP
	id S1030560AbVKPXA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 18:00:28 -0500
Date: Wed, 16 Nov 2005 23:00:23 +0000
To: Mike Kravetz <kravetz@us.ibm.com>
Cc: Andy Whitcroft <apw@shadowen.org>, Anton Blanchard <anton@samba.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 3/3] sparse provide pfn_to_nid
Message-ID: <20051116230023.GA16493@shadowen.org>
References: <exportbomb.1132181992@pinky>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
InReply-To: <exportbomb.1132181992@pinky>
User-Agent: Mutt/1.5.9i
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sparsemem: provide pfn_to_nid

Before SPARSEMEM is initialised we cannot provide an efficient
pfn_to_nid() implmentation; before initialisation is complete we use
early_pfn_to_nid() to provide location information.  Until recently
there was no non-init user of this functionality.  Provide a post
init pfn_to_nid() implementation.

Note that this implmentation assumes that the pfn passed has
been validated with pfn_valid().  The current single user of this
function already has this check.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
 mmzone.h |   13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)
diff -upN reference/include/linux/mmzone.h current/include/linux/mmzone.h
--- reference/include/linux/mmzone.h
+++ current/include/linux/mmzone.h
@@ -598,14 +598,11 @@ static inline int pfn_valid(unsigned lon
 	return valid_section(__nr_to_section(pfn_to_section_nr(pfn)));
 }
 
-/*
- * These are _only_ used during initialisation, therefore they
- * can use __initdata ...  They could have names to indicate
- * this restriction.
- */
-#ifdef CONFIG_NUMA
-#define pfn_to_nid		early_pfn_to_nid
-#endif
+#define pfn_to_nid(pfn)							\
+({									\
+ 	unsigned long __pfn = (pfn);                                    \
+	page_to_nid(pfn_to_page(pfn));					\
+})
 
 #define early_pfn_valid(pfn)	pfn_valid(pfn)
 void sparse_init(void);
