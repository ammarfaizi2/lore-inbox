Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262393AbVA0Dg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262393AbVA0Dg0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 22:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262433AbVA0Dfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 22:35:51 -0500
Received: from ozlabs.org ([203.10.76.45]:5589 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262432AbVA0DfR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 22:35:17 -0500
Date: Thu, 27 Jan 2005 14:31:04 +1100
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org, neilb@cse.unsw.edu.au
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix large allocation in nfsd init
Message-ID: <20050127033104.GA26367@krispykreme.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I just added an NFS mount to a ppc64 box that had been up for a while.
This required inserting the nfsd module. Unfortunately it failed:  

modprobe: page allocation failure. order:5, mode:0xd0
Trace:
[c0000000000ba0f8] alloc_pages_current+0xc0/0xe4
[c0000000000941fc] __get_free_pages+0x54/0x1e0
[d00000000046f7d8] nfsd_cache_init+0x54/0x1a4 [nfsd]
[d0000000004782cc] init_nfsd+0x30/0x2564 [nfsd]
[c000000000084bec] sys_init_module+0x23c/0x5ac
[c00000000001045c] ret_from_syscall_1+0x0/0xa4
nfsd: cannot allocate 98304 bytes for reply cache

An order 5 allocation. Replace it with a vmalloc.

Anton

Signed-off-by: Anton Blanchard <anton@samba.org>

diff -puN fs/nfsd/nfscache.c~fix_nfsd_allocation fs/nfsd/nfscache.c
--- foobar2/fs/nfsd/nfscache.c~fix_nfsd_allocation	2005-01-27 13:56:14.248445552 +1100
+++ foobar2-anton/fs/nfsd/nfscache.c	2005-01-27 14:22:52.764642869 +1100
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/spinlock.h>
+#include <linux/vmalloc.h>
 
 #include <linux/sunrpc/svc.h>
 #include <linux/nfsd/nfsd.h>
@@ -56,14 +57,10 @@ nfsd_cache_init(void)
 	struct svc_cacherep	*rp;
 	struct nfscache_head	*rh;
 	size_t			i;
-	unsigned long		order;
-
 
 	i = CACHESIZE * sizeof (struct svc_cacherep);
-	for (order = 0; (PAGE_SIZE << order) < i; order++)
-		;
-	nfscache = (struct svc_cacherep *)
-		__get_free_pages(GFP_KERNEL, order);
+
+	nfscache = vmalloc(i);
 	if (!nfscache) {
 		printk (KERN_ERR "nfsd: cannot allocate %Zd bytes for reply cache\n", i);
 		return;
@@ -73,7 +70,7 @@ nfsd_cache_init(void)
 	i = HASHSIZE * sizeof (struct nfscache_head);
 	hash_list = kmalloc (i, GFP_KERNEL);
 	if (!hash_list) {
-		free_pages ((unsigned long)nfscache, order);
+		vfree(nfscache);
 		nfscache = NULL;
 		printk (KERN_ERR "nfsd: cannot allocate %Zd bytes for hash list\n", i);
 		return;
@@ -102,8 +99,6 @@ void
 nfsd_cache_shutdown(void)
 {
 	struct svc_cacherep	*rp;
-	size_t			i;
-	unsigned long		order;
 
 	for (rp = lru_head; rp; rp = rp->c_lru_next) {
 		if (rp->c_state == RC_DONE && rp->c_type == RC_REPLBUFF)
@@ -112,10 +107,7 @@ nfsd_cache_shutdown(void)
 
 	cache_disabled = 1;
 
-	i = CACHESIZE * sizeof (struct svc_cacherep);
-	for (order = 0; (PAGE_SIZE << order) < i; order++)
-		;
-	free_pages ((unsigned long)nfscache, order);
+	vfree(nfscache);
 	nfscache = NULL;
 	kfree (hash_list);
 	hash_list = NULL;
_
