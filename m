Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964840AbWFSSrl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964840AbWFSSrl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 14:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964843AbWFSSrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 14:47:40 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:7912 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S964841AbWFSSr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 14:47:27 -0400
Date: Mon, 19 Jun 2006 11:47:07 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, Marcelo Tosatti <marcelo@kvack.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>, Theodore Tso <tytso@mit.edu>,
       Dave Chinner <dgc@sgi.com>, Andi Kleen <ak@suse.de>
Message-Id: <20060619184707.23130.81359.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060619184651.23130.62875.sendpatchset@schroedinger.engr.sgi.com>
References: <20060619184651.23130.62875.sendpatchset@schroedinger.engr.sgi.com>
Subject: [RFC 3/4] Add checks to current destructor uses
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

slab: Add checks to current destructor uses

We will be adding new destructor options soon. So insure that all
existing destructors only react to SLAB_DTOR_DESTROY.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-rc6-mm2/arch/i386/mm/pgtable.c
===================================================================
--- linux-2.6.17-rc6-mm2.orig/arch/i386/mm/pgtable.c	2006-06-16 11:48:44.229756909 -0700
+++ linux-2.6.17-rc6-mm2/arch/i386/mm/pgtable.c	2006-06-19 10:02:05.008801502 -0700
@@ -224,15 +224,19 @@ void pgd_ctor(void *pgd, kmem_cache_t *c
 }
 
 /* never called when PTRS_PER_PMD > 1 */
-void pgd_dtor(void *pgd, kmem_cache_t *cache, unsigned long unused)
+void pgd_dtor(void *pgd, kmem_cache_t *cache, unsigned long slab_flags)
 {
 	unsigned long flags; /* can be called from interrupt context */
 
+	if (!(slab_flags & SLAB_DTOR_DESTROY))
+		return;
+
 	spin_lock_irqsave(&pgd_lock, flags);
 	pgd_list_del(pgd);
 	spin_unlock_irqrestore(&pgd_lock, flags);
 }
 
+
 pgd_t *pgd_alloc(struct mm_struct *mm)
 {
 	int i;
Index: linux-2.6.17-rc6-mm2/include/linux/slab.h
===================================================================
--- linux-2.6.17-rc6-mm2.orig/include/linux/slab.h	2006-06-16 11:48:52.272227349 -0700
+++ linux-2.6.17-rc6-mm2/include/linux/slab.h	2006-06-19 10:00:33.951924377 -0700
@@ -52,6 +52,9 @@ typedef struct kmem_cache kmem_cache_t;
 #define SLAB_CTOR_ATOMIC	0x002UL		/* tell constructor it can't sleep */
 #define	SLAB_CTOR_VERIFY	0x004UL		/* tell constructor it's a verify call */
 
+/* flags passed to a constructor func */
+#define SLAB_DTOR_DESTROY	0x1000UL	/* Called during slab destruction */
+
 #ifndef CONFIG_SLOB
 
 /* prototypes */
Index: linux-2.6.17-rc6-mm2/arch/frv/mm/pgalloc.c
===================================================================
--- linux-2.6.17-rc6-mm2.orig/arch/frv/mm/pgalloc.c	2006-06-05 17:57:02.000000000 -0700
+++ linux-2.6.17-rc6-mm2/arch/frv/mm/pgalloc.c	2006-06-19 10:03:11.301582635 -0700
@@ -120,10 +120,13 @@ void pgd_ctor(void *pgd, kmem_cache_t *c
 }
 
 /* never called when PTRS_PER_PMD > 1 */
-void pgd_dtor(void *pgd, kmem_cache_t *cache, unsigned long unused)
+void pgd_dtor(void *pgd, kmem_cache_t *cache, unsigned long slab_flags)
 {
 	unsigned long flags; /* can be called from interrupt context */
 
+	if (!(slab_flags & SLAB_DTOR_DESTROY))
+		return;
+
 	spin_lock_irqsave(&pgd_lock, flags);
 	pgd_list_del(pgd);
 	spin_unlock_irqrestore(&pgd_lock, flags);
