Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966063AbWKOHu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966063AbWKOHu0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 02:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755480AbWKOHuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 02:50:25 -0500
Received: from smtp.ustc.edu.cn ([202.38.64.16]:18381 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1755468AbWKOHuZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 02:50:25 -0500
Message-ID: <363577021.21912@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20061115075024.850542829@localhost.localdomain>
References: <20061115075007.832957580@localhost.localdomain>
Date: Wed, 15 Nov 2006 15:50:10 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 03/28] mm: introduce probe_page()
Content-Disposition: inline; filename=mm-introduce-probe_page.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a pair of functions to probe the existence of file page.
	- int __probe_page(mapping, offset)
	- int probe_page(mapping, offset)

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
Signed-off-by: Andrew Morton <akpm@osdl.org>
--- linux-2.6.19-rc4-mm1.orig/include/linux/pagemap.h
+++ linux-2.6.19-rc4-mm1/include/linux/pagemap.h
@@ -72,6 +72,8 @@ static inline struct page *page_cache_al
 
 typedef int filler_t(void *, struct page *);
 
+extern int __probe_page(struct address_space *mapping, pgoff_t offset);
+extern int probe_page(struct address_space *mapping, pgoff_t offset);
 extern struct page * find_get_page(struct address_space *mapping,
 				unsigned long index);
 extern struct page * find_lock_page(struct address_space *mapping,
--- linux-2.6.19-rc4-mm1.orig/mm/filemap.c
+++ linux-2.6.19-rc4-mm1/mm/filemap.c
@@ -613,6 +613,29 @@ void fastcall __lock_page_nosync(struct 
 							TASK_UNINTERRUPTIBLE);
 }
 
+/*
+ * Probing page existence.
+ */
+int __probe_page(struct address_space *mapping, pgoff_t offset)
+{
+	return !!radix_tree_lookup(&mapping->page_tree, offset);
+}
+
+/*
+ * Here we just do not bother to grab the page, it's meaningless anyway.
+ */
+int probe_page(struct address_space *mapping, pgoff_t offset)
+{
+	int exists;
+
+	read_lock_irq(&mapping->tree_lock);
+	exists = __probe_page(mapping, offset);
+	read_unlock_irq(&mapping->tree_lock);
+
+	return exists;
+}
+EXPORT_SYMBOL(probe_page);
+
 /**
  * find_get_page - find and get a page reference
  * @mapping: the address_space to search

--
