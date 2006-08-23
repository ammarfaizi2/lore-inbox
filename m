Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965288AbWHWXFM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965288AbWHWXFM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 19:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965293AbWHWXFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 19:05:12 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:51150 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S965288AbWHWXFJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 19:05:09 -0400
Subject: [RFC][PATCH] Manage jbd allocations from its own slabs
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Herbert Xu <herbert@gondor.apana.org.au>, akpm@osdl.org
Cc: lkml <linux-kernel@vger.kernel.org>,
       ext2-devel <Ext2-devel@lists.sourceforge.net>
Content-Type: text/plain
Date: Wed, 23 Aug 2006 16:08:15 -0700
Message-Id: <1156374495.30517.5.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is the fix to "bh: Ensure bh fits within a page" problem
caused by JBD.

BTW, I realized that this problem can happen only with 1k, 2k
filesystems - as 4k, 8k allocations disable slab debug 
automatically. But for completeness, I created slabs for those
also.

What do you think ? I ran basic tests and things are fine.

Thanks,
Badari

JBD currently allocates commit and frozen buffers from slabs.
With CONFIG_SLAB_DEBUG, its possible for an allocation to
cross the page boundary causing IO problems.

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=200127

So, instead of allocating these from regular slabs - manage
allocation from its own slabs and disable slab debug for these slabs.

Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>
---
 fs/jbd/commit.c      |    6 +--
 fs/jbd/journal.c     |   88 ++++++++++++++++++++++++++++++++++++++++++++++++---
 fs/jbd/transaction.c |    9 ++---
 include/linux/jbd.h  |    3 +
 4 files changed, 95 insertions(+), 11 deletions(-)

Index: linux-2.6.18-rc4/fs/jbd/journal.c
===================================================================
--- linux-2.6.18-rc4.orig/fs/jbd/journal.c	2006-08-23 14:47:25.000000000 -0700
+++ linux-2.6.18-rc4/fs/jbd/journal.c	2006-08-23 15:59:06.000000000 -0700
@@ -328,10 +328,10 @@
 		char *tmp;
 
 		jbd_unlock_bh_state(bh_in);
-		tmp = jbd_rep_kmalloc(bh_in->b_size, GFP_NOFS);
+		tmp = jbd_slab_alloc(bh_in->b_size, GFP_NOFS);
 		jbd_lock_bh_state(bh_in);
 		if (jh_in->b_frozen_data) {
-			kfree(tmp);
+			jbd_slab_free(tmp, bh_in->b_size);
 			goto repeat;
 		}
 
@@ -1612,6 +1612,89 @@
 }
 
 /*
+ * jbd slab management: create 1k, 2k, 4k, 8k slabs and allocate
+ * frozen and commit buffers from these slabs.
+ *
+ * Reason for doing this is to avoid, SLAB_DEBUG - since it could
+ * cause bh to cross page boundary.
+ */
+
+static kmem_cache_t *jbd_slab[4];
+static const char *jbd_slab_names[4] = {
+	"jbd_1k",
+	"jbd_2k",
+	"jbd_4k",
+	"jbd_8k",
+};
+
+static void journal_destroy_jbd_slabs(void)
+{
+	int i;
+
+	for (i=0; i<4; i++) {
+		if (jbd_slab[i])
+			kmem_cache_destroy(jbd_slab[i]);
+		jbd_slab[i] = NULL;
+	}
+}
+
+static int journal_init_jbd_slabs(void)
+{
+	int i = 0;
+	int retval = 0;
+
+	for (i=0; i<4; i++) {
+		unsigned long slab_size = 1024 << i;
+		jbd_slab[i] = kmem_cache_create(jbd_slab_names[i],
+					slab_size, slab_size,
+					0, NULL, NULL);
+		if (jbd_slab[i] == 0) {
+			journal_destroy_jbd_slabs();
+			retval = -ENOMEM;
+			printk(KERN_EMERG "JBD: no memory for jbd_slab cache\n");
+			goto out;
+		}
+	}
+out:
+	return retval;
+}
+
+static int jbd_find_slab_index(size_t size)
+{
+	int idx = 0;
+
+	switch (size) {
+	case 1024:	idx = 0;
+			break;
+	case 2048:	idx = 1;
+			break;
+	case 4096:	idx = 2;
+			break;
+	case 8192:	idx = 3;
+			break;
+	default:	printk("JBD unknown slab size %ld\n", size);
+			BUG();
+	}
+	return idx;
+}
+
+void * jbd_slab_alloc(size_t size, gfp_t flags)
+{
+	int idx;
+
+	idx = jbd_find_slab_index(size);
+	return kmem_cache_alloc(jbd_slab[idx], flags | __GFP_NOFAIL);
+}
+
+void jbd_slab_free(void *ptr,  size_t size)
+{
+	int idx;
+
+	idx = jbd_find_slab_index(size);
+	kmem_cache_free(jbd_slab[idx], ptr);
+}
+
+/*
  * Journal_head storage management
  */
 static kmem_cache_t *journal_head_cache;
@@ -1799,13 +1882,13 @@
 				printk(KERN_WARNING "%s: freeing "
 						"b_frozen_data\n",
 						__FUNCTION__);
-				kfree(jh->b_frozen_data);
+				jbd_slab_free(jh->b_frozen_data, bh->b_size);
 			}
 			if (jh->b_committed_data) {
 				printk(KERN_WARNING "%s: freeing "
 						"b_committed_data\n",
 						__FUNCTION__);
-				kfree(jh->b_committed_data);
+				jbd_slab_free(jh->b_committed_data, bh->b_size);
 			}
 			bh->b_private = NULL;
 			jh->b_bh = NULL;	/* debug, really */
@@ -1953,6 +2036,8 @@
 		ret = journal_init_journal_head_cache();
 	if (ret == 0)
 		ret = journal_init_handle_cache();
+	if (ret == 0)
+		ret = journal_init_jbd_slabs();
 	return ret;
 }
 
@@ -1961,6 +2046,7 @@
 	journal_destroy_revoke_caches();
 	journal_destroy_journal_head_cache();
 	journal_destroy_handle_cache();
+	journal_destroy_jbd_slabs();
 }
 
 static int __init journal_init(void)
Index: linux-2.6.18-rc4/fs/jbd/transaction.c
===================================================================
--- linux-2.6.18-rc4.orig/fs/jbd/transaction.c	2006-08-23 14:05:57.000000000 -0700
+++ linux-2.6.18-rc4/fs/jbd/transaction.c	2006-08-23 14:50:17.000000000 -0700
@@ -666,8 +666,9 @@
 			if (!frozen_buffer) {
 				JBUFFER_TRACE(jh, "allocate memory for buffer");
 				jbd_unlock_bh_state(bh);
-				frozen_buffer = jbd_kmalloc(jh2bh(jh)->b_size,
-							    GFP_NOFS);
+				frozen_buffer =
+					jbd_slab_alloc(jh2bh(jh)->b_size,
+							 GFP_NOFS);
 				if (!frozen_buffer) {
 					printk(KERN_EMERG
 					       "%s: OOM for frozen_buffer\n",
@@ -879,7 +880,7 @@
 
 repeat:
 	if (!jh->b_committed_data) {
-		committed_data = jbd_kmalloc(jh2bh(jh)->b_size, GFP_NOFS);
+		committed_data = jbd_slab_alloc(jh2bh(jh)->b_size, GFP_NOFS);
 		if (!committed_data) {
 			printk(KERN_EMERG "%s: No memory for committed data\n",
 				__FUNCTION__);
@@ -906,7 +907,7 @@
 out:
 	journal_put_journal_head(jh);
 	if (unlikely(committed_data))
-		kfree(committed_data);
+		jbd_slab_free(committed_data, bh->b_size);
 	return err;
 }
 
Index: linux-2.6.18-rc4/fs/jbd/commit.c
===================================================================
--- linux-2.6.18-rc4.orig/fs/jbd/commit.c	2006-08-23 14:05:57.000000000 -0700
+++ linux-2.6.18-rc4/fs/jbd/commit.c	2006-08-23 14:50:17.000000000 -0700
@@ -261,7 +261,7 @@
 			struct buffer_head *bh = jh2bh(jh);
 
 			jbd_lock_bh_state(bh);
-			kfree(jh->b_committed_data);
+			jbd_slab_free(jh->b_committed_data, bh->b_size);
 			jh->b_committed_data = NULL;
 			jbd_unlock_bh_state(bh);
 		}
@@ -745,14 +745,14 @@
 		 * Otherwise, we can just throw away the frozen data now.
 		 */
 		if (jh->b_committed_data) {
-			kfree(jh->b_committed_data);
+			jbd_slab_free(jh->b_committed_data, bh->b_size);
 			jh->b_committed_data = NULL;
 			if (jh->b_frozen_data) {
 				jh->b_committed_data = jh->b_frozen_data;
 				jh->b_frozen_data = NULL;
 			}
 		} else if (jh->b_frozen_data) {
-			kfree(jh->b_frozen_data);
+			jbd_slab_free(jh->b_frozen_data, bh->b_size);
 			jh->b_frozen_data = NULL;
 		}
 
Index: linux-2.6.18-rc4/include/linux/jbd.h
===================================================================
--- linux-2.6.18-rc4.orig/include/linux/jbd.h	2006-08-23 14:05:57.000000000 -0700
+++ linux-2.6.18-rc4/include/linux/jbd.h	2006-08-23 14:50:17.000000000 -0700
@@ -72,6 +72,9 @@
 #endif
 
 extern void * __jbd_kmalloc (const char *where, size_t size, gfp_t flags, int retry);
+extern void * jbd_slab_alloc(size_t size, gfp_t flags);
+extern void jbd_slab_free(void *ptr, size_t size);
+
 #define jbd_kmalloc(size, flags) \
 	__jbd_kmalloc(__FUNCTION__, (size), (flags), journal_oom_retry)
 #define jbd_rep_kmalloc(size, flags) \




