Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751812AbWJWIgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812AbWJWIgK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 04:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751823AbWJWIgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 04:36:10 -0400
Received: from pfx2.jmh.fr ([194.153.89.55]:13500 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S1751812AbWJWIgJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 04:36:09 -0400
From: Eric Dumazet <dada1@cosmosbay.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] vmalloc : optimization, cleanup, bugfixes
Date: Mon, 23 Oct 2006 10:36:09 +0200
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <453C3A29.4010606@intel.com> <20061022214508.6c4f30c6.akpm@osdl.org>
In-Reply-To: <20061022214508.6c4f30c6.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_67HPFkgkemdTTyT"
Message-Id: <200610231036.10418.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_67HPFkgkemdTTyT
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

[PATCH] vmalloc : optimization, cleanup, bugfixes

This patch does three things

1) reorder 'struct vm_struct' to speedup lookups on CPUS with small cache 
lines. The fields 'next,addr,size' should be now in the same cache line, to 
speedup lookups.

2) One minor cleanup in __get_vm_area_node()

3) Bugfixes in vmalloc_user() and vmalloc_32_user()
NULL returns from __vmalloc() and __find_vm_area() were not tested.


Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>

--Boundary-00=_67HPFkgkemdTTyT
Content-Type: text/plain;
  charset="iso-8859-1";
  name="vmalloc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="vmalloc.patch"

--- linux-2.6/include/linux/vmalloc.h	2006-10-23 10:09:48.000000000 +0200
+++ linux-2.6-ed/include/linux/vmalloc.h	2006-10-23 10:26:37.000000000 +0200
@@ -23,13 +23,14 @@
 #endif
 
 struct vm_struct {
+	/* keep next,addr,size together to speedup lookups */
+	struct vm_struct	*next;
 	void			*addr;
 	unsigned long		size;
 	unsigned long		flags;
 	struct page		**pages;
 	unsigned int		nr_pages;
 	unsigned long		phys_addr;
-	struct vm_struct	*next;
 };
 
 /*
--- linux-2.6/mm/vmalloc.c	2006-10-23 10:11:43.000000000 +0200
+++ linux-2.6-ed/mm/vmalloc.c	2006-10-23 10:17:52.000000000 +0200
@@ -180,15 +180,13 @@
 	addr = ALIGN(start, align);
 	size = PAGE_ALIGN(size);
 
+	if (unlikely(!size))
+		return NULL;
+
 	area = kmalloc_node(sizeof(*area), GFP_KERNEL, node);
 	if (unlikely(!area))
 		return NULL;
 
-	if (unlikely(!size)) {
-		kfree (area);
-		return NULL;
-	}
-
 	/*
 	 * We always allocate a guard page.
 	 */
@@ -528,11 +526,13 @@
 	void *ret;
 
 	ret = __vmalloc(size, GFP_KERNEL | __GFP_HIGHMEM | __GFP_ZERO, PAGE_KERNEL);
-	write_lock(&vmlist_lock);
-	area = __find_vm_area(ret);
-	area->flags |= VM_USERMAP;
-	write_unlock(&vmlist_lock);
-
+	if (ret) {
+		write_lock(&vmlist_lock);
+		area = __find_vm_area(ret);
+		if (area)
+			area->flags |= VM_USERMAP;
+		write_unlock(&vmlist_lock);
+	}
 	return ret;
 }
 EXPORT_SYMBOL(vmalloc_user);
@@ -601,11 +601,13 @@
 	void *ret;
 
 	ret = __vmalloc(size, GFP_KERNEL | __GFP_ZERO, PAGE_KERNEL);
-	write_lock(&vmlist_lock);
-	area = __find_vm_area(ret);
-	area->flags |= VM_USERMAP;
-	write_unlock(&vmlist_lock);
-
+	if (ret) {
+		write_lock(&vmlist_lock);
+		area = __find_vm_area(ret);
+		if (area)
+			area->flags |= VM_USERMAP;
+		write_unlock(&vmlist_lock);
+	}
 	return ret;
 }
 EXPORT_SYMBOL(vmalloc_32_user);

--Boundary-00=_67HPFkgkemdTTyT--
