Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751086AbVIWTbn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbVIWTbn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 15:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbVIWTbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 15:31:42 -0400
Received: from calsoftinc.com ([64.62.215.98]:56266 "HELO calsoftinc.com")
	by vger.kernel.org with SMTP id S1751086AbVIWTbm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 15:31:42 -0400
Message-ID: <433458B6.7000008@calsoftinc.com>
Date: Sat, 24 Sep 2005 01:04:14 +0530
From: Alok Kataria <alokk@calsoftinc.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@engr.sgi.com>
CC: Petr Vandrovec <vandrove@vc.cvut.cz>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, manfred@colorfullife.com
Subject: Re: 2.6.14-rc1-git-now still dying in mm/slab - this time line 1849
Content-Type: multipart/mixed;
 boundary="------------000506000204000101080801"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000506000204000101080801
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On Wed, 2005-09-21 at 06:33, Christoph Lameter wrote:

Hi Christoph,
I have some doubts over this...

>/On Tue, 20 Sep 2005, Petr Vandrovec wrote:
>
>> slab belonging to node#1, while having acquired lock for cachep belonging
>> to node #0.  Due to this check_spinlock_acquired_node(cachep, nodeid) fails
>> (check_spinlock_acquired_node(cachep, 0) would succeed).
>
>Hmmm. If a node runs out of memory then pages from another node may end up 
>on the slab list of a node. But it seems that free_block cannot handle 
>that properly.
>
>How are you producing the problem?
>
>Could you try the following patch:
>
>---
>
>The numa slab allocator may allocate pages from foreign nodes onto the lists
>for a particular node if a node runs out of memory. Inspecting the slab->nodeid
>field will not reflect that the page is now in use for the slabs of another node.
>/
>
/
/

IMO the slab->nodeid  field just lets us know to which nodes list3 is 
this slab attached, irrespective of the node from
which node the memory was got.
 

>/This patch fixes that issue by adding a node field to free_block so that the caller
>can indicate which node currently uses a slab.
>
>/
>
But the nodeid is already accessible through the slab-descriptor of this 
object, and this nodeid is set in the cache_grow
function.

>/Also removes the check for the current node from kmalloc_cache_node since the
>process may shift later to another node which may lead to an allocation on another
>node than intended.
>/
>
Yeah that is possible, but won't putting a check in __cache_alloc_node 
after disabling the interrupt be better, because 
kmalloc_node/kmem_cache_alloc_node can be called at runtime as well, and 
getting the object directly from the slabs, instead of the arraycaches 
may slow up things.
Thus tweaking the patch a little.


Thanks & Regards,
Alok


--------------000506000204000101080801
Content-Type: text/x-patch;
 name="cache_alloc_node.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cache_alloc_node.patch"

Signed-off-by: Alok N Kataria <alokk@calsoftinc.com>

Index: linux-2.6.13/mm/slab.c
===================================================================
--- linux-2.6.13.orig/mm/slab.c	2005-09-24 00:08:00.221900000 +0530
+++ linux-2.6.13/mm/slab.c	2005-09-24 00:24:12.206645250 +0530
@@ -2507,16 +2507,12 @@
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
@@ -2526,6 +2522,18 @@
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
 	objp = cache_alloc_debugcheck_after(cachep, flags, objp, __builtin_return_address(0));
 	return objp;
@@ -2841,7 +2849,7 @@
 	unsigned long save_flags;
 	void *ptr;
 
-	if (nodeid == numa_node_id() || nodeid == -1)
+	if (nodeid == -1)
 		return __cache_alloc(cachep, flags);
 
 	if (unlikely(!cachep->nodelists[nodeid])) {
@@ -2852,6 +2860,8 @@
 
 	cache_alloc_debugcheck_before(cachep, flags);
 	local_irq_save(save_flags);
+	if (nodeid == numa_node_id())
+		____cache_alloc(cachep, flags);
 	ptr = __cache_alloc_node(cachep, flags, nodeid);
 	local_irq_restore(save_flags);
 	ptr = cache_alloc_debugcheck_after(cachep, flags, ptr, __builtin_return_address(0));

--------------000506000204000101080801--
