Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbVLNH6L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbVLNH6L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 02:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbVLNH6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 02:58:11 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:31889 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750710AbVLNH6J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 02:58:09 -0500
Message-ID: <439FD08E.3020401@us.ibm.com>
Date: Tue, 13 Dec 2005 23:58:06 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: andrea@suse.de, Sridhar Samudrala <sri@us.ibm.com>, pavel@suse.cz,
       Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: [RFC][PATCH 4/6] Slab Prep: slab_destruct()
References: <439FCECA.3060909@us.ibm.com>
In-Reply-To: <439FCECA.3060909@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------030308000601030406020504"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030308000601030406020504
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Create a helper function for slab_destroy() called slab_destruct().  Remove
some ifdefs inside functions and generally make the slab destroying code
more readable prior to slab support for the Critical Page Pool.

-Matt

--------------030308000601030406020504
Content-Type: text/x-patch;
 name="slab_prep-slab_destruct.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="slab_prep-slab_destruct.patch"

Create a helper function, slab_destruct(), called from slab_destroy().  This
makes slab_destroy() smaller and more readable, and moves ifdefs outside the
function body.

Signed-off-by: Matthew Dobson <colpatch@us.ibm.com>

Index: linux-2.6.15-rc5+critical_pool/mm/slab.c
===================================================================
--- linux-2.6.15-rc5+critical_pool.orig/mm/slab.c	2005-12-05 10:20:43.886907432 -0800
+++ linux-2.6.15-rc5+critical_pool/mm/slab.c	2005-12-05 10:20:45.289694176 -0800
@@ -1401,15 +1401,13 @@ static void check_poison_obj(kmem_cache_
 }
 #endif
 
-/* Destroy all the objs in a slab, and release the mem back to the system.
- * Before calling the slab must have been unlinked from the cache.
- * The cache-lock is not held/needed.
+#if DEBUG
+/**
+ * slab_destruct - call the registered destructor for each object in
+ *      a slab that is to be destroyed.
  */
-static void slab_destroy (kmem_cache_t *cachep, struct slab *slabp)
+static void slab_destruct(kmem_cache_t *cachep, struct slab *slabp)
 {
-	void *addr = slabp->s_mem - slabp->colouroff;
-
-#if DEBUG
 	int i;
 	for (i = 0; i < cachep->num; i++) {
 		void *objp = slabp->s_mem + cachep->objsize * i;
@@ -1435,7 +1433,10 @@ static void slab_destroy (kmem_cache_t *
 		if (cachep->dtor && !(cachep->flags & SLAB_POISON))
 			(cachep->dtor)(objp+obj_dbghead(cachep), cachep, 0);
 	}
+}
 #else
+static void slab_destruct(kmem_cache_t *cachep, struct slab *slabp)
+{
 	if (cachep->dtor) {
 		int i;
 		for (i = 0; i < cachep->num; i++) {
@@ -1443,8 +1444,19 @@ static void slab_destroy (kmem_cache_t *
 			(cachep->dtor)(objp, cachep, 0);
 		}
 	}
+}
 #endif
 
+/**
+ * Destroy all the objs in a slab, and release the mem back to the system.
+ * Before calling the slab must have been unlinked from the cache.
+ * The cache-lock is not held/needed.
+ */
+static void slab_destroy(kmem_cache_t *cachep, struct slab *slabp)
+{
+	void *addr = slabp->s_mem - slabp->colouroff;
+
+	slab_destruct(cachep, slabp);
 	if (unlikely(cachep->flags & SLAB_DESTROY_BY_RCU)) {
 		struct slab_rcu *slab_rcu;
 

--------------030308000601030406020504--
