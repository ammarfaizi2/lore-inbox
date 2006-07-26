Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030455AbWGZIxL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030455AbWGZIxL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 04:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030456AbWGZIxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 04:53:10 -0400
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:30442 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1030455AbWGZIxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 04:53:09 -0400
Date: Wed, 26 Jul 2006 10:50:28 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Pekka Enberg <penberg@cs.helsinki.fi>, linux-mm@kvack.org,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 1/2] slab: always consider caller mandated alignment
Message-ID: <20060726085028.GC9592@osiris.boeblingen.de.ibm.com>
References: <20060722110601.GA9572@osiris.boeblingen.de.ibm.com> <Pine.LNX.4.64.0607220748160.13737@schroedinger.engr.sgi.com> <20060722162607.GA10550@osiris.ibm.com> <Pine.LNX.4.64.0607221241130.14513@schroedinger.engr.sgi.com> <20060723073500.GA10556@osiris.ibm.com> <Pine.LNX.4.64.0607230558560.15651@schroedinger.engr.sgi.com> <20060723162427.GA10553@osiris.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060723162427.GA10553@osiris.ibm.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

In case of CONFIG_DEBUG_SLAB kmem_cache_create() creates caches with an
alignment lesser than ARCH_KMALLOC_MINALIGN. This breaks s390 (32bit),
since it needs an eight byte alignment. Also it doesn't behave like it's
decribed in mm/slab.c :

 * Enforce a minimum alignment for the kmalloc caches.
 * Usually, the kmalloc caches are cache_line_size() aligned, except when
 * DEBUG and FORCED_DEBUG are enabled, then they are BYTES_PER_WORD aligned.
 * Some archs want to perform DMA into kmalloc caches and need a guaranteed
 * alignment larger than BYTES_PER_WORD. ARCH_KMALLOC_MINALIGN allows that.
 * Note that this flag disables some debug features.

For example the following might happen if kmem_cache_create() gets called
with -- size: 64; align: 8; flags with SLAB_HWCACHE_ALIGN, SLAB_RED_ZONE and
SLAB_STORE_USER set.
These are the steps as numbered in kmem_cache_create() where 5) is after the
"if (flags & SLAB_RED_ZONE)" statement.

1) align: 8 ralign 64 
2) align: 8 ralign 64 
3) align: 8 ralign 64 
4) align: 64 ralign 64
5) align: 4 ralign 64 

Note that in this case in step 3) the flags SLAB_RED_ZONE and SLAB_STORE_USER
don't get masked out and that this causes an BYTES_PER_WORD alignment in
step 5) which breaks s390.

Cc: Christoph Lameter <clameter@sgi.com>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 mm/slab.c |    3 +++
 1 files changed, 3 insertions(+)

Index: linux-2.6/mm/slab.c
===================================================================
--- linux-2.6.orig/mm/slab.c	2006-07-24 09:41:36.000000000 +0200
+++ linux-2.6/mm/slab.c	2006-07-26 09:55:54.000000000 +0200
@@ -2109,6 +2109,9 @@
 		if (ralign > BYTES_PER_WORD)
 			flags &= ~(SLAB_RED_ZONE | SLAB_STORE_USER);
 	}
+	if (align > BYTES_PER_WORD)
+		flags &= ~(SLAB_RED_ZONE | SLAB_STORE_USER);
+
 	/*
 	 * 4) Store it. Note that the debug code below can reduce
 	 *    the alignment to BYTES_PER_WORD.
