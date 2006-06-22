Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161208AbWFVTlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161208AbWFVTlL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 15:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161211AbWFVTlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 15:41:11 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:28088 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1161208AbWFVTlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 15:41:09 -0400
Date: Thu, 22 Jun 2006 12:40:51 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Pekka J Enberg <penberg@cs.helsinki.fi>
cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@kvack.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Theodore Tso <tytso@mit.edu>,
       Dave Chinner <dgc@sgi.com>, Andi Kleen <ak@suse.de>
Subject: Re: [RFC 3/4] Add checks to current destructor uses
In-Reply-To: <Pine.LNX.4.58.0606222223420.5385@sbz-30.cs.Helsinki.FI>
Message-ID: <Pine.LNX.4.64.0606221239540.31332@schroedinger.engr.sgi.com>
References: <20060619184651.23130.62875.sendpatchset@schroedinger.engr.sgi.com>
 <20060619184707.23130.81359.sendpatchset@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0606222223420.5385@sbz-30.cs.Helsinki.FI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006, Pekka J Enberg wrote:

> On Mon, 19 Jun 2006, Christoph Lameter wrote:
> > slab: Add checks to current destructor uses
> > 
> > We will be adding new destructor options soon. So insure that all
> > existing destructors only react to SLAB_DTOR_DESTROY.
> 
> Hmm, I don't see the slab allocator passing SLAB_DTOR_DESTROY anywhere in 
> this patch?  Please don't introduce changesets that break the kernel.  
> It's bad for stuff like git bisect.

Correct. Thanks.

Fixed up patch:

slab: Add checks to current destructor uses

We will be adding new destructor options soon. So insure that all
existing destructors only react to SLAB_DTOR_DESTROY.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17/arch/i386/mm/pgtable.c
===================================================================
--- linux-2.6.17.orig/arch/i386/mm/pgtable.c	2006-06-17 18:49:35.000000000 -0700
+++ linux-2.6.17/arch/i386/mm/pgtable.c	2006-06-22 12:38:29.179955802 -0700
@@ -226,15 +226,19 @@ void pgd_ctor(void *pgd, kmem_cache_t *c
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
Index: linux-2.6.17/include/linux/slab.h
===================================================================
--- linux-2.6.17.orig/include/linux/slab.h	2006-06-17 18:49:35.000000000 -0700
+++ linux-2.6.17/include/linux/slab.h	2006-06-22 12:38:29.180932304 -0700
@@ -53,6 +53,9 @@ typedef struct kmem_cache kmem_cache_t;
 #define SLAB_CTOR_ATOMIC	0x002UL		/* tell constructor it can't sleep */
 #define	SLAB_CTOR_VERIFY	0x004UL		/* tell constructor it's a verify call */
 
+/* flags passed to a constructor func */
+#define SLAB_DTOR_DESTROY	0x1000UL	/* Called during slab destruction */
+
 #ifndef CONFIG_SLOB
 
 /* prototypes */
Index: linux-2.6.17/arch/frv/mm/pgalloc.c
===================================================================
--- linux-2.6.17.orig/arch/frv/mm/pgalloc.c	2006-06-17 18:49:35.000000000 -0700
+++ linux-2.6.17/arch/frv/mm/pgalloc.c	2006-06-22 12:38:29.212180365 -0700
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
Index: linux-2.6.17/mm/slab.c
===================================================================
--- linux-2.6.17.orig/mm/slab.c	2006-06-22 12:35:58.685386714 -0700
+++ linux-2.6.17/mm/slab.c	2006-06-22 12:39:37.971586394 -0700
@@ -1689,7 +1689,8 @@ static void slab_destroy_objs(struct kme
 					   "was overwritten");
 		}
 		if (cachep->dtor && !(cachep->flags & SLAB_POISON))
-			(cachep->dtor) (objp + obj_offset(cachep), cachep, 0);
+			(cachep->dtor) (objp + obj_offset(cachep), cachep,
+				SLAB_DTOR_DESTROY);
 	}
 }
 #else
@@ -1699,7 +1700,7 @@ static void slab_destroy_objs(struct kme
 		int i;
 		for (i = 0; i < cachep->num; i++) {
 			void *objp = index_to_obj(cachep, slabp, i);
-			(cachep->dtor) (objp, cachep, 0);
+			(cachep->dtor) (objp, cachep, SLAB_DTOR_DESTROY);
 		}
 	}
 }
@@ -2661,7 +2662,8 @@ static void *cache_free_debugcheck(struc
 		/* we want to cache poison the object,
 		 * call the destruction callback
 		 */
-		cachep->dtor(objp + obj_offset(cachep), cachep, 0);
+		cachep->dtor(objp + obj_offset(cachep), cachep,
+			SLAB_DTOR_DESTROY);
 	}
 #ifdef CONFIG_DEBUG_SLAB_LEAK
 	slab_bufctl(slabp)[objnr] = BUFCTL_FREE;
