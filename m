Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbUCXURw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 15:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbUCXURw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 15:17:52 -0500
Received: from holomorphy.com ([207.189.100.168]:24453 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261184AbUCXURs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 15:17:48 -0500
Date: Wed, 24 Mar 2004 12:17:34 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] anobjrmap 1/6 objrmap
Message-ID: <20040324201734.GL791@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040320123009.GC9009@dualathlon.random> <2696050000.1079798196@[10.10.2.4]> <20040320161905.GT9009@dualathlon.random> <2924080000.1079886632@[10.10.2.4]> <20040321235207.GC3649@dualathlon.random> <1684742704.1079970781@[10.10.2.4]> <20040324061957.GB2065@dualathlon.random> <24560000.1080143798@[10.10.2.4]> <20040324162116.GQ2065@dualathlon.random> <20040324200156.GK791@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040324200156.GK791@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2004 at 12:01:56PM -0800, William Lee Irwin III wrote:
> Don't confuse unslabify and the ->list removal. The ->list removal went
> around insisting the known universe stop using ->lru because of the
> relatively arbitrary choice that slab.c use ->lru. The unslabify patch
> attempts to update one user of ->lru by backing out the code using it.
> Do note that non-list-heads like ->index, ->private, or ->mapping are
> also unused on slab pages, and could have saved some pain for this
> former user of ->list had they been chosen.

Updating the user instead of backing them out would have looked
something like the following (totally untested, not even compiletested):


-- wli


Index: mm2-2.6.5-rc2-1/arch/i386/mm/pageattr.c
===================================================================
--- mm2-2.6.5-rc2-1.orig/arch/i386/mm/pageattr.c	2004-03-19 16:11:06.000000000 -0800
+++ mm2-2.6.5-rc2-1/arch/i386/mm/pageattr.c	2004-03-21 07:15:40.000000000 -0800
@@ -75,7 +75,7 @@
 		return;
 
 	spin_lock_irqsave(&pgd_lock, flags);
-	list_for_each_entry(page, &pgd_list, lru) {
+	for (page = pgd_list; page; page = (struct page *)page->index) {
 		pgd_t *pgd;
 		pmd_t *pmd;
 		pgd = (pgd_t *)page_address(page) + pgd_index(address);
Index: mm2-2.6.5-rc2-1/arch/i386/mm/pgtable.c
===================================================================
--- mm2-2.6.5-rc2-1.orig/arch/i386/mm/pgtable.c	2004-03-21 07:14:22.000000000 -0800
+++ mm2-2.6.5-rc2-1/arch/i386/mm/pgtable.c	2004-03-21 07:18:41.000000000 -0800
@@ -172,7 +172,27 @@
  * -- wli
  */
 spinlock_t pgd_lock = SPIN_LOCK_UNLOCKED;
-LIST_HEAD(pgd_list);
+struct page *pgd_list;
+
+static inline void pgd_list_add(pgd_t *pgd)
+{
+	struct page *page = virt_to_page(pgd);
+	page->index = (unsigned long)pgd_list;
+	if (pgd_list)
+		pgd_list->private = (unsigned long)&page->index;
+	pgd_list = page;
+	page->private = (unsigned long)&pgd_list;
+}
+
+static inline void pgd_list_del(pgd_t *pgd)
+{
+	struct page *next, **pprev, *page = virt_to_page(pgd);
+	next = (struct page *)page->index;
+	pprev = (struct page **)page->private;
+	*pprev = next;
+	if (next)
+		next->private = (unsigned long)pprev;
+}
 
 void pgd_ctor(void *pgd, kmem_cache_t *cache, unsigned long unused)
 {
@@ -188,7 +208,7 @@
 	if (PTRS_PER_PMD > 1)
 		return;
 
-	list_add(&virt_to_page(pgd)->lru, &pgd_list);
+	pgd_list_add(pgd);
 	spin_unlock_irqrestore(&pgd_lock, flags);
 	memset(pgd, 0, USER_PTRS_PER_PGD*sizeof(pgd_t));
 }
@@ -199,7 +219,7 @@
 	unsigned long flags; /* can be called from interrupt context */
 
 	spin_lock_irqsave(&pgd_lock, flags);
-	list_del(&virt_to_page(pgd)->lru);
+	pgd_list_del(pgd);
 	spin_unlock_irqrestore(&pgd_lock, flags);
 }
 
Index: mm2-2.6.5-rc2-1/include/asm-i386/pgtable.h
===================================================================
--- mm2-2.6.5-rc2-1.orig/include/asm-i386/pgtable.h	2004-03-19 16:11:34.000000000 -0800
+++ mm2-2.6.5-rc2-1/include/asm-i386/pgtable.h	2004-03-21 08:27:30.000000000 -0800
@@ -35,7 +35,7 @@
 extern kmem_cache_t *pgd_cache;
 extern kmem_cache_t *pmd_cache;
 extern spinlock_t pgd_lock;
-extern struct list_head pgd_list;
+extern struct page *pgd_list;
 
 void pmd_ctor(void *, kmem_cache_t *, unsigned long);
 void pgd_ctor(void *, kmem_cache_t *, unsigned long);
