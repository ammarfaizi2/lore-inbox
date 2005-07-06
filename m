Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262041AbVGFCWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbVGFCWA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 22:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbVGFCUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 22:20:42 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:61336 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262043AbVGFCTO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 22:19:14 -0400
Subject: [PATCH] [12/48] Suspend2 2.1.9.8 for 2.6.12: 402-mtrr-remove-sysdev.patch
In-Reply-To: <11206164393426@foobar.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 6 Jul 2005 12:20:40 +1000
Message-Id: <11206164401476@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Nigel Cunningham <nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruNp 403-debug-pagealloc-support.patch-old/arch/i386/mm/pageattr.c 403-debug-pagealloc-support.patch-new/arch/i386/mm/pageattr.c
--- 403-debug-pagealloc-support.patch-old/arch/i386/mm/pageattr.c	2005-06-20 11:46:43.000000000 +1000
+++ 403-debug-pagealloc-support.patch-new/arch/i386/mm/pageattr.c	2005-07-04 23:14:19.000000000 +1000
@@ -217,5 +217,46 @@ void kernel_map_pages(struct page *page,
 }
 #endif
 
+#ifdef CONFIG_SUSPEND2
+#ifdef CONFIG_DEBUG_PAGEALLOC
+static int page_is_kernel_mapped(struct page * page)
+{
+	pte_t *kpte; 
+	unsigned long address;
+
+	if (PageHighMem(page))
+		return 0;
+
+	address = (unsigned long)page_address(page);
+	
+	kpte = lookup_address(address);
+	if (!kpte)
+		return 0;
+
+	if (pte_same(*kpte, mk_pte(page, PAGE_KERNEL)))
+		return 1;
+
+	return 0;
+}
+
+int suspend_map_kernel_page(struct page * page, int enable)
+{
+	int is_already_mapped = page_is_kernel_mapped(page);
+
+	if (enable == is_already_mapped)
+		return 1;
+
+	kernel_map_pages(page, 1, enable);
+
+	return 0;
+}
+#else
+int suspend_map_kernel_page(struct page * page, int enable)
+{
+	return (enable == 1);
+}
+#endif
+#endif
+
 EXPORT_SYMBOL(change_page_attr);
 EXPORT_SYMBOL(global_flush_tlb);

