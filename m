Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267420AbUGNOTB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267420AbUGNOTB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 10:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267418AbUGNOSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 10:18:00 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:16060 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S267423AbUGNOHL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 10:07:11 -0400
Date: Wed, 14 Jul 2004 23:06:54 +0900 (JST)
Message-Id: <20040714.230654.58831017.taka@valinux.co.jp>
To: linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Cc: linux-mm@kvack.org
Subject: [PATCH] memory hotremoval for linux-2.6.7 [16/16]
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <20040714.224138.95803956.taka@valinux.co.jp>
References: <20040714.224138.95803956.taka@valinux.co.jp>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- linux-2.6.7.ORG/fs/direct-io.c	Thu Jun 17 15:17:13 2032
+++ linux-2.6.7/fs/direct-io.c	Thu Jun 17 15:28:44 2032
@@ -27,6 +27,7 @@
 #include <linux/slab.h>
 #include <linux/highmem.h>
 #include <linux/pagemap.h>
+#include <linux/hugetlb.h>
 #include <linux/bio.h>
 #include <linux/wait.h>
 #include <linux/err.h>
@@ -110,7 +111,11 @@ struct dio {
 	 * Page queue.  These variables belong to dio_refill_pages() and
 	 * dio_get_page().
 	 */
+#ifndef CONFIG_HUGETLB_PAGE
 	struct page *pages[DIO_PAGES];	/* page buffer */
+#else
+	struct page *pages[HPAGE_SIZE/PAGE_SIZE];	/* page buffer */
+#endif
 	unsigned head;			/* next page to process */
 	unsigned tail;			/* last valid page + 1 */
 	int page_errors;		/* errno from get_user_pages() */
@@ -143,9 +148,20 @@ static int dio_refill_pages(struct dio *
 {
 	int ret;
 	int nr_pages;
+	struct vm_area_struct * vma;
 
-	nr_pages = min(dio->total_pages - dio->curr_page, DIO_PAGES);
 	down_read(&current->mm->mmap_sem);
+#ifdef CONFIG_HUGETLB_PAGE
+	vma = find_vma(current->mm, dio->curr_user_address);
+	if (vma && is_vm_hugetlb_page(vma)) {
+		unsigned long n = dio->curr_user_address & PAGE_MASK;
+		n = (n & ~HPAGE_MASK) >> PAGE_SHIFT;
+		n = HPAGE_SIZE/PAGE_SIZE - n;
+		nr_pages = min(dio->total_pages - dio->curr_page, (int)n);
+	} else
+#endif
+		nr_pages = min(dio->total_pages - dio->curr_page, DIO_PAGES);
+
 	ret = get_user_pages(
 		current,			/* Task for fault acounting */
 		current->mm,			/* whose pages? */
