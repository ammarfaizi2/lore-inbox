Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261291AbVAUJRG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbVAUJRG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 04:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbVAUJRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 04:17:06 -0500
Received: from rproxy.gmail.com ([64.233.170.192]:33385 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261291AbVAUJQt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 04:16:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding;
        b=oadv3ntu9a0ns17WCPCn2A8NRvcf19jncnhFQpPcwbCyclrvcROSvCBAR0NnfUkQwD9Sxh6OOmOrHJtvvRbpnUSBVhSE6VA1ceeW9gSf0VqcckaByzPH1YpY3+EHVrBw8K8fJ5oADtV4So8VCePpDBZRCfvU3dU9yD4EEBuMxJk=
Message-ID: <73e6204505012101165b8164c4@mail.gmail.com>
Date: Fri, 21 Jan 2005 17:16:48 +0800
From: zhan rongkai <zhanrk@gmail.com>
Reply-To: zhan rongkai <zhanrk@gmail.com>
To: uclinux-dev@uclinux.org
Subject: [PATCH] the page count of buddy seems to be buggy under no MMU
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This set_page_refs() function is copied from linux-2.6.10 mm/page_alloc.c

static inline void set_page_refs(struct page *page, int order)
{
#ifdef CONFIG_MMU
	set_page_count(page, 1);
#else
	int i;

	/*
	 * We need to reference all the pages for this order, otherwise if
	 * anyone accesses one of the pages with (get/put) it will be freed.
	 */
	for (i = 0; i < (1 << order); i++)
		set_page_count(page+i, 1);
#endif /* CONFIG_MMU */
}

So when we are under no MMU, the __free_pages() function also should
de-reference all the pages for this order (order > 0), too. However,
the current __free_pages() only decrements the first page's refcount,
which will cause __free_pages_ok() to dump stack!

---------------------------------------------------------

--- linux-2.6.10.orig/mm/page_alloc.c	2004-12-25 05:33:51.000000000 +0800
+++ linux-2.6.10/mm/page_alloc.c	2005-01-21 17:14:08.000000000 +0800
@@ -786,6 +786,8 @@
 		free_hot_cold_page(pvec->pages[i], pvec->cold);
 }
 
+#ifdef CONFIG_MMU
+
 fastcall void __free_pages(struct page *page, unsigned int order)
 {
 	if (!PageReserved(page) && put_page_testzero(page)) {
@@ -796,6 +798,35 @@
 	}
 }
 
+#else
+
+fastcall void __free_pages(struct page *page, unsigned int order)
+{
+	if (PageReserved(page))
+		return;
+	
+	if (order == 0) {
+		if (put_page_testzero(page))
+			free_hot_page(page);
+	} else {
+		int i, result = 0;
+		
+		/*
+		 * We need to de-reference all the pages for this order -- see
set_page_refs()
+		 */
+		for (i = 0; i < (1 << order); i++)
+			result += put_page_testzero(page + i);
+		
+		if (result) {
+			if (result != (1 << order))
+				BUG();
+			__free_pages_ok(page, order);
+		}
+	}
+}
+
+#endif /* CONFIG_MMU */
+
 EXPORT_SYMBOL(__free_pages);
 
 fastcall void free_pages(unsigned long addr, unsigned int order)

-- 
Rongkai Zhan
