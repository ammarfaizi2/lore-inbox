Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262702AbUKXNas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262702AbUKXNas (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 08:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262658AbUKXN2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 08:28:05 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:45972 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262651AbUKXNBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 08:01:53 -0500
Subject: Suspend 2 merge: 18/51: Debug page_alloc support.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1101292194.5805.180.camel@desktop.cunninghams>
References: <1101292194.5805.180.camel@desktop.cunninghams>
Content-Type: text/plain
Message-Id: <1101295326.5805.259.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 24 Nov 2004 23:58:12 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides support for making suspend work when DEBUG_PAGEALLOC
is enabled.

diff -ruN 510-debug-pagealloc-support-old/arch/i386/mm/pageattr.c 510-debug-pagealloc-support-new/arch/i386/mm/pageattr.c
--- 510-debug-pagealloc-support-old/arch/i386/mm/pageattr.c	2004-11-03 21:53:39.000000000 +1100
+++ 510-debug-pagealloc-support-new/arch/i386/mm/pageattr.c	2004-11-04 16:27:40.000000000 +1100
@@ -211,5 +213,49 @@
 EXPORT_SYMBOL(kernel_map_pages);
 #endif
 
+#ifdef CONFIG_SOFTWARE_SUSPEND2
+#ifdef CONFIG_DEBUG_PAGEALLOC
+static int page_is_kernel_mapped(struct page * page)
+{
+	pte_t *kpte; 
+	unsigned long address;
+
+#ifdef CONFIG_HIGHMEM
+	if (page >= highmem_start_page) 
+		return 0;
+#endif
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
+EXPORT_SYMBOL(suspend_map_kernel_page);
+#endif
+
 EXPORT_SYMBOL(change_page_attr);
 EXPORT_SYMBOL(global_flush_tlb);


