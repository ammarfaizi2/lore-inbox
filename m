Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161118AbVKRTog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161118AbVKRTog (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 14:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161124AbVKRTof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 14:44:35 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:32733 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161118AbVKRTof
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 14:44:35 -0500
Message-ID: <437E2F20.9090302@us.ibm.com>
Date: Fri, 18 Nov 2005 11:44:32 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Linux Memory Management <linux-mm@kvack.org>
Subject: [RFC][PATCH 6/8] slab_destruct
References: <437E2C69.4000708@us.ibm.com>
In-Reply-To: <437E2C69.4000708@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------090902050305040107070309"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090902050305040107070309
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Break the current slab_destroy() into 2 functions: slab_destroy and
slab_destruct.  slab_destruct calls the destructor code and any necessary
debug code.

-Matt

--------------090902050305040107070309
Content-Type: text/x-patch;
 name="slab_prep-slab_destruct.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="slab_prep-slab_destruct.patch"

Create a helper function, slab_destruct(), called from slab_destroy().  This
makes slab_destroy() smaller and more readable, and moves ifdefs outside the
function body.

Signed-off-by: Matthew Dobson <colpatch@us.ibm.com>

Index: linux-2.6.14+critical_pool/mm/slab.c
===================================================================
--- linux-2.6.14+critical_pool.orig/mm/slab.c	2005-11-14 10:52:22.427207392 -0800
+++ linux-2.6.14+critical_pool/mm/slab.c	2005-11-14 10:52:27.514434016 -0800
@@ -1388,16 +1388,13 @@ static void check_poison_obj(kmem_cache_
 }
 #endif
 
-/*
- * Destroy all the objs in a slab, and release the mem back to the system.
- * Before calling the slab must have been unlinked from the cache.
- * The cache-lock is not held/needed.
+#if DEBUG
+/**
+ * slab_destruct - call the registered destructor for each object in
+ *      a slab that is to be destroyed.
  */
-static void slab_destroy(kmem_cache_t *cachep, struct slab *slabp)
+static void slab_destruct(kmem_cache_t *cachep, struct slab *slabp)
 {
-	void *addr = slabp->s_mem - slabp->colouroff;
-
-#if DEBUG
 	int i;
 	for (i = 0; i < cachep->num; i++) {
 		void *objp = slabp->s_mem + cachep->objsize * i;
@@ -1425,7 +1422,10 @@ static void slab_destroy(kmem_cache_t *c
 		if (cachep->dtor && !(cachep->flags & SLAB_POISON))
 			(cachep->dtor)(objp + obj_dbghead(cachep), cachep, 0);
 	}
+}
 #else
+static void slab_destruct(kmem_cache_t *cachep, struct slab *slabp)
+{
 	if (cachep->dtor) {
 		int i;
 		for (i = 0; i < cachep->num; i++) {
@@ -1433,8 +1433,19 @@ static void slab_destroy(kmem_cache_t *c
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
 

--------------090902050305040107070309--
