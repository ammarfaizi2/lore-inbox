Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751014AbWGZMVP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbWGZMVP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 08:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbWGZMVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 08:21:15 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:32153 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751014AbWGZMVO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 08:21:14 -0400
Date: Wed, 26 Jul 2006 05:20:59 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Pekka Enberg <penberg@cs.helsinki.fi>
cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] slab: always follow arch requested alignments
In-Reply-To: <84144f020607260505s17daa5c8j6e5095eb956828ee@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0607260511430.4075@schroedinger.engr.sgi.com>
References: <20060722110601.GA9572@osiris.boeblingen.de.ibm.com> 
 <Pine.LNX.4.64.0607220748160.13737@schroedinger.engr.sgi.com> 
 <20060722162607.GA10550@osiris.ibm.com>  <84144f020607260422t668c4d8dldfcdedfe3713b73e@mail.gmail.com>
  <Pine.LNX.4.64.0607260426450.3744@schroedinger.engr.sgi.com> 
 <Pine.LNX.4.58.0607261430520.17986@sbz-30.cs.Helsinki.FI> 
 <Pine.LNX.4.64.0607260433410.3855@schroedinger.engr.sgi.com> 
 <Pine.LNX.4.58.0607261443150.17986@sbz-30.cs.Helsinki.FI> 
 <Pine.LNX.4.58.0607261448520.17986@sbz-30.cs.Helsinki.FI> 
 <Pine.LNX.4.64.0607260451250.4021@schroedinger.engr.sgi.com>
 <84144f020607260505s17daa5c8j6e5095eb956828ee@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2006, Pekka Enberg wrote:

> On 7/26/06, Christoph Lameter <clameter@sgi.com> wrote:
> > Your patch only deals with ARCH_SLAB_MINALIGN. kmem_cache_create() never
> > uses ARCH_KMALLOC_MINALIGN only kmem_cache_init() does by passing it to
> > kmem_cache_create.  ARCH_KMALLOC_MINALIGN will still be ignored.
> 
> Yes, in which case the caller mandated align will be, well,
> ARCH_KMALLOC_MINALIGN. The patch changes kmem_cache_create to respect
> caller mandated alignment too.

As far as I understood Heiko s390 does not set ARCH_SLAB_MINALIGN
because they do not want alignent for all caches.

The following patch adds an option SLAB_DEBUG_OVERRIDE to switch off
debugging if its on by default. S390 would have to set ARCH_KMALLOC_FLAGS
to SLAB_DEBUG_OVERRIDE. The flag will then be passed in 
kmem_cache_init to kmem_cache_create(). This approach also preserves the 
existing slab behavior for all other archs.

Index: linux-2.6/include/linux/slab.h
===================================================================
--- linux-2.6.orig/include/linux/slab.h	2006-07-26 05:14:33.000000000 -0700
+++ linux-2.6/include/linux/slab.h	2006-07-26 05:15:08.000000000 -0700
@@ -46,6 +46,7 @@ typedef struct kmem_cache kmem_cache_t;
 #define SLAB_PANIC		0x00040000UL	/* panic if kmem_cache_create() fails */
 #define SLAB_DESTROY_BY_RCU	0x00080000UL	/* defer freeing pages to RCU */
 #define SLAB_MEM_SPREAD		0x00100000UL	/* Spread some memory over cpuset */
+#define SLAB_DEBUG_OVERRIDE	0x00200000UL	/* Do not debug this slab */
 
 /* flags passed to a constructor func */
 #define	SLAB_CTOR_CONSTRUCTOR	0x001UL		/* if not set, then deconstructor */
Index: linux-2.6/mm/slab.c
===================================================================
--- linux-2.6.orig/mm/slab.c	2006-07-26 05:13:59.000000000 -0700
+++ linux-2.6/mm/slab.c	2006-07-26 05:17:59.000000000 -0700
@@ -2055,8 +2055,11 @@ kmem_cache_create (const char *name, siz
 	 * above the next power of two: caches with object sizes just above a
 	 * power of two have a significant amount of internal fragmentation.
 	 */
-	if (size < 4096 || fls(size - 1) == fls(size-1 + 3 * BYTES_PER_WORD))
-		flags |= SLAB_RED_ZONE | SLAB_STORE_USER;
+
+	if (!(flags & DEBUG_OVERRIDE) &&
+		size < 4096 ||
+		(fls(size - 1) == fls(size-1 + 3 * BYTES_PER_WORD)))
+			flags |= SLAB_RED_ZONE | SLAB_STORE_USER;
 	if (!(flags & SLAB_DESTROY_BY_RCU))
 		flags |= SLAB_POISON;
 #endif

