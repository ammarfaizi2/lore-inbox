Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264382AbUD0Wn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264382AbUD0Wn3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 18:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264384AbUD0Wn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 18:43:29 -0400
Received: from fw.osdl.org ([65.172.181.6]:63426 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264382AbUD0WnW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 18:43:22 -0400
Date: Tue, 27 Apr 2004 15:45:30 -0700
From: Dave Olien <dmo@osdl.org>
To: thornber@redhat.com
Cc: dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] trivial patch to dm-io.c
Message-ID: <20040427224530.GA16850@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's trivial patches to dm-io.c.  Just adds static declarations, and adds
dm_io_sync_bvec() to the list of EXPORT_SYMBOL functions.


diff -ur linux-2.6.6-rc2-udm1-original/drivers/md/dm-io.c linux-2.6.6-rc2-udm1-patched/drivers/md/dm-io.c
--- linux-2.6.6-rc2-udm1-original/drivers/md/dm-io.c	2004-04-27 15:36:39.000000000 -0700
+++ linux-2.6.6-rc2-udm1-patched/drivers/md/dm-io.c	2004-04-27 15:36:04.000000000 -0700
@@ -369,7 +369,7 @@
 /*
  * Functions for getting the pages from a list.
  */
-void list_get_page(struct dpages *dp,
+static void list_get_page(struct dpages *dp,
 		  struct page **p, unsigned long *len, unsigned *offset)
 {
 	unsigned o = dp->context_u;
@@ -380,14 +380,14 @@
 	*offset = o;
 }
 
-void list_next_page(struct dpages *dp)
+static void list_next_page(struct dpages *dp)
 {
 	struct page_list *pl = (struct page_list *) dp->context_ptr;
 	dp->context_ptr = pl->next;
 	dp->context_u = 0;
 }
 
-void list_dp_init(struct dpages *dp, struct page_list *pl, unsigned offset)
+static void list_dp_init(struct dpages *dp, struct page_list *pl, unsigned offset)
 {
 	dp->get_page = list_get_page;
 	dp->next_page = list_next_page;
@@ -398,7 +398,7 @@
 /*
  * Functions for getting the pages from a bvec.
  */
-void bvec_get_page(struct dpages *dp,
+static void bvec_get_page(struct dpages *dp,
 		  struct page **p, unsigned long *len, unsigned *offset)
 {
 	struct bio_vec *bvec = (struct bio_vec *) dp->context_ptr;
@@ -407,20 +407,20 @@
 	*offset = bvec->bv_offset;
 }
 
-void bvec_next_page(struct dpages *dp)
+static void bvec_next_page(struct dpages *dp)
 {
 	struct bio_vec *bvec = (struct bio_vec *) dp->context_ptr;
 	dp->context_ptr = bvec + 1;
 }
 
-void bvec_dp_init(struct dpages *dp, struct bio_vec *bvec)
+static void bvec_dp_init(struct dpages *dp, struct bio_vec *bvec)
 {
 	dp->get_page = bvec_get_page;
 	dp->next_page = bvec_next_page;
 	dp->context_ptr = bvec;
 }
 
-void vm_get_page(struct dpages *dp,
+static void vm_get_page(struct dpages *dp,
 		 struct page **p, unsigned long *len, unsigned *offset)
 {
 	*p = vmalloc_to_page(dp->context_ptr);
@@ -428,13 +428,13 @@
 	*len = PAGE_SIZE - dp->context_u;
 }
 
-void vm_next_page(struct dpages *dp)
+static void vm_next_page(struct dpages *dp)
 {
 	dp->context_ptr += PAGE_SIZE - dp->context_u;
 	dp->context_u = 0;
 }
 
-void vm_dp_init(struct dpages *dp, void *data)
+static void vm_dp_init(struct dpages *dp, void *data)
 {
 	dp->get_page = vm_get_page;
 	dp->next_page = vm_next_page;
@@ -516,7 +516,7 @@
 	dec_count(io, 0, 0);
 }
 
-int sync_io(unsigned int num_regions, struct io_region *where,
+static int sync_io(unsigned int num_regions, struct io_region *where,
 	    int rw, struct dpages *dp, unsigned long *error_bits)
 {
 	struct io io;
@@ -546,7 +546,7 @@
 	return io.error ? -EIO : 0;
 }
 
-int async_io(unsigned int num_regions, struct io_region *where, int rw,
+static int async_io(unsigned int num_regions, struct io_region *where, int rw,
 	     struct dpages *dp, io_notify_fn fn, void *context)
 {
 	struct io *io = mempool_alloc(_io_pool, GFP_NOIO);
@@ -615,6 +615,7 @@
 EXPORT_SYMBOL(dm_io_put);
 EXPORT_SYMBOL(dm_io_sync);
 EXPORT_SYMBOL(dm_io_async);
+EXPORT_SYMBOL(dm_io_sync_bvec);
 EXPORT_SYMBOL(dm_io_async_bvec);
 EXPORT_SYMBOL(dm_io_sync_vm);
 EXPORT_SYMBOL(dm_io_async_vm);
