Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932549AbWEZMEt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932549AbWEZMEt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 08:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932371AbWEZMEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 08:04:24 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:10969 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S932357AbWEZLxA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 07:53:00 -0400
Message-ID: <348644375.06563@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060526115300.609227164@localhost.localdomain>
References: <20060526113906.084341801@localhost.localdomain>
Date: Fri, 26 May 2006 19:39:10 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 04/33] mm: introduce probe_pages()
Content-Disposition: inline; filename=mm-probe-page.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a pair of functions to probe the existence of file page.
	- int __probe_page(mapping, offset)
	- int probe_page(mapping, offset)

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---


--- linux.orig/include/linux/pagemap.h
+++ linux/include/linux/pagemap.h
@@ -68,6 +68,8 @@ static inline struct page *page_cache_al
 
 typedef int filler_t(void *, struct page *);
 
+extern int __probe_page(struct address_space *mapping, pgoff_t offset);
+extern int probe_page(struct address_space *mapping, pgoff_t offset);
 extern struct page * find_get_page(struct address_space *mapping,
 				unsigned long index);
 extern struct page * find_lock_page(struct address_space *mapping,
--- linux.orig/mm/filemap.c
+++ linux/mm/filemap.c
@@ -548,6 +548,28 @@ void fastcall __lock_page(struct page *p
 EXPORT_SYMBOL(__lock_page);
 
 /*
+ * Probing page existence.
+ */
+int __probe_page(struct address_space *mapping, pgoff_t offset)
+{
+	return !! radix_tree_lookup(&mapping->page_tree, offset);
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
+
+/*
  * a rather lightweight function, finding and getting a reference to a
  * hashed page atomically.
  */

--
