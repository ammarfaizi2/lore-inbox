Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265200AbUGGO5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265200AbUGGO5i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 10:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265196AbUGGO5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 10:57:38 -0400
Received: from verein.lst.de ([212.34.189.10]:12982 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S265200AbUGGO5U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 10:57:20 -0400
Date: Wed, 7 Jul 2004 16:57:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] idr comments updates
Message-ID: <20040707145712.GA13942@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00,REMOVE_REMOVAL_NEAR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update idr.c comments, now uses doc-book style API documentation.


--- 1.9/lib/idr.c	2004-06-30 05:22:01 +02:00
+++ edited/lib/idr.c	2004-07-04 17:38:39 +02:00
@@ -1,32 +1,30 @@
 /*
- * linux/kernel/id.c
- *
  * 2002-10-18  written by Jim Houston jim.houston@ccur.com
  *	Copyright (C) 2002 by Concurrent Computer Corporation
  *	Distributed under the GNU GPL license version 2.
  *
+ * Modified by George Anzinger to reuse immediately and to use
+ * find bit instructions.  Also removed _irq on spinlocks.
+ */
+
+/*
  * Small id to pointer translation service.  
  *
  * It uses a radix tree like structure as a sparse array indexed 
  * by the id to obtain the pointer.  The bitmap makes allocating
  * a new id quick.  
-
- * Modified by George Anzinger to reuse immediately and to use
- * find bit instructions.  Also removed _irq on spinlocks.
-
- * So here is what this bit of code does:
-
+ *
  * You call it to allocate an id (an int) an associate with that id a
  * pointer or what ever, we treat it as a (void *).  You can pass this
  * id to a user for him to pass back at a later time.  You then pass
  * that id to this code and it returns your pointer.
-
+ *
  * You can release ids at any time. When all ids are released, most of 
  * the memory is returned (we keep IDR_FREE_MAX) in a local pool so we
  * don't need to go to the memory "store" during an id allocate, just 
  * so you don't need to be too concerned about locking and conflicts
  * with the slab allocator.
-
+ *
  * What you need to do is, since we don't keep the counter as part of
  * id / ptr pair, to keep a copy of it in the pointed to structure
  * (or else where) so that when you ask for a ptr you can varify that
@@ -41,63 +39,11 @@
  * structure is found in some other way) this seems reasonable.  If you
  * really think otherwise, the code to check these bits here, it is just
  * disabled with a #if 0.
-
-
- * So here are the complete details:
-
- *  include <linux/idr.h>
-
- * void idr_init(struct idr *idp)
-
- *   This function is use to set up the handle (idp) that you will pass
- *   to the rest of the functions.  The structure is defined in the
- *   header.
-
- * int idr_pre_get(struct idr *idp, unsigned gfp_mask)
-
- *   This function should be called prior to locking and calling the
- *   following function.  It pre allocates enough memory to satisfy the
- *   worst possible allocation.  Unless gfp_mask is GFP_ATOMIC, it can
- *   sleep, so must not be called with any spinlocks held.  If the system is
- *   REALLY out of memory this function returns 0, other wise 1.
-
- * int idr_get_new(struct idr *idp, void *ptr, int *id);
- 
- *   This is the allocate id function.  It should be called with any
- *   required locks.  In fact, in the SMP case, you MUST lock prior to
- *   calling this function to avoid possible out of memory problems.
- *   If memory is required, it will return -EAGAIN, you should unlock
- *   and go back to the idr_pre_get() call.  If the idr is full, it
- *   will return a -ENOSPC.  ptr is the pointer you want associated
- *   with the id.  The value is returned in the "id" field.  idr_get_new()
- *   returns a value in the range 0 ... 0x7fffffff
-
- * int idr_get_new_above(struct idr *idp, void *ptr, int start_id, int *id);
-
- *   Like idr_get_new(), but the returned id is guaranteed to be at or
- *   above start_id.
-
- * void *idr_find(struct idr *idp, int id);
- 
- *   returns the "ptr", given the id.  A NULL return indicates that the
- *   id is not valid (or you passed NULL in the idr_get_new(), shame on
- *   you).  This function must be called with a spinlock that prevents
- *   calling either idr_get_new() or idr_remove() or idr_find() while it
- *   is working.
-
- * void idr_remove(struct idr *idp, int id);
-
- *   removes the given id, freeing that slot and any memory that may
- *   now be unused.  See idr_find() for locking restrictions.
-
- * int idr_full(struct idr *idp);
-
- *   Returns true if the idr is full and false if not.
-
+ *
+ * See the kerneldoc comments ontop of the individual functions for API
+ * details.
  */
 
-
-
 #ifndef TEST                        // to test in user space...
 #include <linux/slab.h>
 #include <linux/init.h>
@@ -137,6 +83,18 @@
 	spin_unlock(&idp->lock);
 }
 
+/**
+ * idr_pre_get - reserver resources for idr allocation
+ * @idp:	idr handle
+ * @gfp_mask:	memory allocation flags
+ *
+ * This function should be called prior to locking and calling the
+ * following function.  It preallocates enough memory to satisfy
+ * the worst possible allocation.
+ *
+ * If the system is REALLY out of memory this function returns 0,
+ * otherwise 1.
+ */
 int idr_pre_get(struct idr *idp, unsigned gfp_mask)
 {
 	while (idp->id_free_cnt < IDR_FREE_MAX) {
@@ -271,6 +229,22 @@
 	return(v);
 }
 
+/**
+ * idr_get_new_above - allocate new idr entry above a start id
+ * @idp: idr handle
+ * @ptr: pointer you want associated with the ide
+ * @start_id: id to start search at
+ * @id: pointer to the allocated handle
+ *
+ * This is the allocate id function.  It should be called with any
+ * required locks. 
+ *
+ * If memory is required, it will return -EAGAIN, you should unlock
+ * and go back to the idr_pre_get() call.  If the idr is full, it will
+ * return -ENOSPC.
+ *
+ * @id returns a value in the range 0 ... 0x7fffffff
+ */
 int idr_get_new_above(struct idr *idp, void *ptr, int starting_id, int *id)
 {
 	int rv;
@@ -290,6 +264,21 @@
 }
 EXPORT_SYMBOL(idr_get_new_above);
 
+/**
+ * idr_get_new - allocate new idr entry
+ * @idp: idr handle
+ * @ptr: pointer you want associated with the ide
+ * @id: pointer to the allocated handle
+ *
+ * This is the allocate id function.  It should be called with any
+ * required locks. 
+ *
+ * If memory is required, it will return -EAGAIN, you should unlock
+ * and go back to the idr_pre_get() call.  If the idr is full, it will
+ * return -ENOSPC.
+ *
+ * @id returns a value in the range 0 ... 0x7fffffff
+ */
 int idr_get_new(struct idr *idp, void *ptr, int *id)
 {
 	int rv;
@@ -338,6 +327,11 @@
 	}
 }
 
+/**
+ * idr_remove - remove the given id and free it's slot
+ * idp: idr handle
+ * id: uniqueue key
+ */
 void idr_remove(struct idr *idp, int id)
 {
 	struct idr_layer *p;
@@ -365,6 +359,17 @@
 }
 EXPORT_SYMBOL(idr_remove);
 
+/**
+ * idr_find - return pointer for given id
+ * @idp: idr handle
+ * @id: lookup key
+ *
+ * Return the pointer given the id it has been registered with.  A %NULL
+ * return indicates that @id is not valid or you passed %NULL in
+ * idr_get_new().
+ *
+ * The caller must serialize idr_find() vs idr_get_new() and idr_remove().
+ */
 void *idr_find(struct idr *idp, int id)
 {
 	int n;
@@ -405,6 +410,13 @@
 	return 0;
 }
 
+/**
+ * idr_init - initialize idr handle
+ * @idp:	idr handle
+ *
+ * This function is use to set up the handle (@idp) that you will pass
+ * to the rest of the functions.
+ */
 void idr_init(struct idr *idp)
 {
 	init_id_cache();
