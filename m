Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750915AbWHPWpv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbWHPWpv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 18:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbWHPWpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 18:45:51 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:20137 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750915AbWHPWpv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 18:45:51 -0400
Date: Wed, 16 Aug 2006 15:45:32 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Manfred Spraul <manfred@colorfullife.com>
cc: mpm@selenic.com, Marcelo Tosatti <marcelo@kvack.org>,
       linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       Andi Kleen <ak@suse.de>, Dave Chinner <dgc@sgi.com>
Subject: Re: [MODSLAB 0/7] A modular slab allocator V1
In-Reply-To: <Pine.LNX.4.64.0608161533580.19172@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.64.0608161544080.19244@schroedinger.engr.sgi.com>
References: <20060816022238.13379.24081.sendpatchset@schroedinger.engr.sgi.com>
 <44E344A8.1040804@colorfullife.com> <Pine.LNX.4.64.0608161533580.19172@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some more minor fixes that my newer compiler on the i386 box discovered.


Index: linux-2.6.18-rc4/include/linux/allocator.h
===================================================================
--- linux-2.6.18-rc4.orig/include/linux/allocator.h	2006-08-16 15:42:24.000000000 -0700
+++ linux-2.6.18-rc4/include/linux/allocator.h	2006-08-16 15:42:27.000000000 -0700
@@ -66,7 +66,7 @@
  * a page is freed.
  */
 struct page_allocator *ctor_and_dtor_for_page_allocator
-	(const struct page_allocator *, unsigned long size, void *private,
+	(const struct page_allocator *, unsigned int size, void *private,
 		void (*ctor)(void *, void *, unsigned long),
                 void (*dtor)(void *, void *, unsigned long));
 
Index: linux-2.6.18-rc4/mm/allocator.c
===================================================================
--- linux-2.6.18-rc4.orig/mm/allocator.c	2006-08-16 15:42:24.000000000 -0700
+++ linux-2.6.18-rc4/mm/allocator.c	2006-08-16 15:42:27.000000000 -0700
@@ -123,8 +123,8 @@
 static void page_free_rcu(struct rcu_head *h)
 {
 	struct page *page;
-	struct page_allocator * base;
-	int order = page->index;
+	struct page_allocator *base;
+	int order;
 
  	page = container_of((struct list_head *)h, struct page, lru);
 	base = (void *)page->mapping;
@@ -228,7 +228,7 @@
 
 struct page_allocator *ctor_and_dtor_for_page_allocator
 	(const struct page_allocator *base,
-		size_t size, void *private,
+		unsigned int size, void *private,
 		void (*ctor)(void *, void *, unsigned long),
 		void (*dtor)(void *, void *, unsigned long))
 {
@@ -318,7 +318,7 @@
 	struct slabr *r = (void *) rcu;
 	struct slab_cache *s = r->s;
 	struct rcuified_slab *d = (void *)s->slab_alloc;
-	void *object = (void *)object - d->rcu_offset;
+	void *object = (void *)rcu - d->rcu_offset;
 
 	d->base->free(s, object);
 }
