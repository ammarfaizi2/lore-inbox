Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751456AbVIYOON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbVIYOON (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 10:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbVIYOON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 10:14:13 -0400
Received: from calsoftinc.com ([64.62.215.98]:4232 "HELO calsoftinc.com")
	by vger.kernel.org with SMTP id S1751456AbVIYOOM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 10:14:12 -0400
Date: Sun, 25 Sep 2005 19:46:51 +0530 (IST)
From: Alok Kataria <alokk@calsoftinc.com>
X-X-Sender: alokk@alok.intranet.calsoftinc.com
To: Christoph Lameter <clameter@engr.sgi.com>
cc: Petr Vandrovec <vandrove@vc.cvut.cz>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, manfred@colorfullife.com
Subject: Re: 2.6.14-rc1-git-now still dying in mm/slab - this time line 1849
Message-ID: <Pine.LNX.4.63.0509251937510.24430@alok.intranet.calsoftinc.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-09-24 at 05:35, Christoph Lameter wrote:
> Comments on the code:
>
> @@ -2852,6 +2860,8 @@
>
>        cache_alloc_debugcheck_before(cachep, flags);
>        local_irq_save(save_flags);
> +      if (nodeid == numa_node_id())
> +              ____cache_alloc(cachep, flags);
>        ptr = __cache_alloc_node(cachep, flags, nodeid);
>
> This should be
>
>                ptr = ___cache_alloc(cachep, flags)
>        else
>                ptr = __cache_alloc_node(...)
>
> right?
>
>        local_irq_restore(save_flags);
>        ptr = cache_alloc_debugcheck_after(cachep, flags, ptr,
> __builtin_return_address(0));

Oh a major blunder !! Updated the patch

--
As pointed by Christoph,  In kmalloc_node we are cheking if, the allocation is for the
same node when interrupts are "on", this may lead to an allocation on another node than intended.
This patch just shifts the check for the current node in __cache_alloc_node when interrupts
are disabled.

Signed-off-by: Alok N Kataria <alokk@calsoftinc.com>
Cc : Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.13/mm/slab.c
===================================================================
--- linux-2.6.13.orig/mm/slab.c	2005-09-25 18:48:16.068349500 +0530
+++ linux-2.6.13/mm/slab.c	2005-09-25 18:48:18.484500500 +0530
@@ -2508,16 +2508,12 @@
  #define cache_alloc_debugcheck_after(a,b,objp,d) (objp)
  #endif

-
-static inline void *__cache_alloc(kmem_cache_t *cachep, unsigned int __nocast flags)
+static inline void *____cache_alloc(kmem_cache_t *cachep, unsigned int __nocast flags)
  {
-	unsigned long save_flags;
  	void* objp;
  	struct array_cache *ac;

-	cache_alloc_debugcheck_before(cachep, flags);
-
-	local_irq_save(save_flags);
+	check_irq_off();
  	ac = ac_data(cachep);
  	if (likely(ac->avail)) {
  		STATS_INC_ALLOCHIT(cachep);
@@ -2527,6 +2523,18 @@
  		STATS_INC_ALLOCMISS(cachep);
  		objp = cache_alloc_refill(cachep, flags);
  	}
+	return objp;
+}
+
+static inline void *__cache_alloc(kmem_cache_t *cachep, unsigned int __nocast flags)
+{
+	unsigned long save_flags;
+	void* objp;
+
+	cache_alloc_debugcheck_before(cachep, flags);
+
+	local_irq_save(save_flags);
+	objp = ____cache_alloc(cachep, flags);
  	local_irq_restore(save_flags);
  	objp = cache_alloc_debugcheck_after(cachep, flags, objp,
  					__builtin_return_address(0));
@@ -2844,7 +2852,7 @@
  	unsigned long save_flags;
  	void *ptr;

-	if (nodeid == numa_node_id() || nodeid == -1)
+	if (nodeid == -1)
  		return __cache_alloc(cachep, flags);

  	if (unlikely(!cachep->nodelists[nodeid])) {
@@ -2855,7 +2863,10 @@

  	cache_alloc_debugcheck_before(cachep, flags);
  	local_irq_save(save_flags);
-	ptr = __cache_alloc_node(cachep, flags, nodeid);
+	if (nodeid == numa_node_id())
+		ptr = ____cache_alloc(cachep, flags);
+	else
+		ptr = __cache_alloc_node(cachep, flags, nodeid);
  	local_irq_restore(save_flags);
  	ptr = cache_alloc_debugcheck_after(cachep, flags, ptr, __builtin_return_address(0));

