Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751858AbWJWJaZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751858AbWJWJaZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 05:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751860AbWJWJaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 05:30:25 -0400
Received: from pfx2.jmh.fr ([194.153.89.55]:15552 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S1751858AbWJWJaZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 05:30:25 -0400
From: Eric Dumazet <dada1@cosmosbay.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] vmalloc : optimization, cleanup, bugfixes
Date: Mon, 23 Oct 2006 11:30:26 +0200
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <453C3A29.4010606@intel.com> <200610231036.10418.dada1@cosmosbay.com> <453C87A6.4060602@yahoo.com.au>
In-Reply-To: <453C87A6.4060602@yahoo.com.au>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_yuIPFNg1DXXUs1I"
Message-Id: <200610231130.26594.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_yuIPFNg1DXXUs1I
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 23 October 2006 11:13, Nick Piggin wrote:
> Eric Dumazet wrote:
> > 3) Bugfixes in vmalloc_user() and vmalloc_32_user()
> > NULL returns from __vmalloc() and __find_vm_area() were not tested.
>
> Hmm, so they weren't. As far as testing the return of __find_vm_area,
> you can just turn that into a BUG_ON(!area), because at that point,
> we've established that the vmalloc succeeded.

OK :) 

[PATCH] vmalloc : optimization, cleanup, bugfixes

This patch does three things

1) reorder 'struct vm_struct' to speedup lookups on CPUS with small cache 
lines. The fields 'next,addr,size' should be now in the same cache line, to 
speedup lookups.

2) One minor cleanup in __get_vm_area_node()

3) Bugfixes in vmalloc_user() and vmalloc_32_user()
NULL returns from __vmalloc() and __find_vm_area() were not tested.


Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>

--Boundary-00=_yuIPFNg1DXXUs1I
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
+++ linux-2.6-ed/mm/vmalloc.c	2006-10-23 11:26:47.000000000 +0200
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
+		BUG_ON(!area);
+		area->flags |= VM_USERMAP;
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
+		BUG_ON(!area);
+		area->flags |= VM_USERMAP;
+		write_unlock(&vmlist_lock);
+	}
 	return ret;
 }
 EXPORT_SYMBOL(vmalloc_32_user);

--Boundary-00=_yuIPFNg1DXXUs1I--
