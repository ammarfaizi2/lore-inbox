Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964911AbVKQWln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964911AbVKQWln (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 17:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964931AbVKQWln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 17:41:43 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:55492 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S964911AbVKQWlm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 17:41:42 -0500
Date: Thu, 17 Nov 2005 14:41:38 -0800
From: Mike Kravetz <kravetz@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Remove arch independent NODES_SPAN_OTHER_NODES
Message-ID: <20051117224138.GA5393@w-mikek2.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The NODES_SPAN_OTHER_NODES config option was created so that DISCONTIGMEM
could handle pSeries numa layouts.  However, support for DISCONTIGMEM has
been replaced by SPARSEMEM on powerpc.  As a result, this config option and
supporting code is no longer needed.

I have already sent a patch to Paul that removes the option from powerpc
specific code.  This removes the arch independent piece.  Doesn't really
matter which is applied first.

Signed-off-by: Mike Kravetz <kravetz@us.ibm.com>

diff -Naupr linux-2.6.15-rc1-mm1/include/linux/mmzone.h linux-2.6.15-rc1-mm1.work/include/linux/mmzone.h
--- linux-2.6.15-rc1-mm1/include/linux/mmzone.h	2005-11-17 18:22:08.000000000 +0000
+++ linux-2.6.15-rc1-mm1.work/include/linux/mmzone.h	2005-11-17 19:02:40.000000000 +0000
@@ -610,12 +610,6 @@ void sparse_init(void);
 #define sparse_index_init(_sec, _nid)  do {} while (0)
 #endif /* CONFIG_SPARSEMEM */
 
-#ifdef CONFIG_NODES_SPAN_OTHER_NODES
-#define early_pfn_in_nid(pfn, nid)	(early_pfn_to_nid(pfn) == (nid))
-#else
-#define early_pfn_in_nid(pfn, nid)	(1)
-#endif
-
 #ifndef early_pfn_valid
 #define early_pfn_valid(pfn)	(1)
 #endif
diff -Naupr linux-2.6.15-rc1-mm1/mm/page_alloc.c linux-2.6.15-rc1-mm1.work/mm/page_alloc.c
--- linux-2.6.15-rc1-mm1/mm/page_alloc.c	2005-11-17 18:22:08.000000000 +0000
+++ linux-2.6.15-rc1-mm1.work/mm/page_alloc.c	2005-11-17 19:03:24.000000000 +0000
@@ -1752,8 +1752,6 @@ void __devinit memmap_init_zone(unsigned
 	for (pfn = start_pfn; pfn < end_pfn; pfn++, page++) {
 		if (!early_pfn_valid(pfn))
 			continue;
-		if (!early_pfn_in_nid(pfn, nid))
-			continue;
 		page = pfn_to_page(pfn);
 		set_page_links(page, zone, nid, pfn);
 		set_page_count(page, 1);
