Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422794AbWHYA4i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422794AbWHYA4i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 20:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbWHYA4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 20:56:38 -0400
Received: from over.ny.us.ibm.com ([32.97.182.150]:61117 "EHLO
	over.ny.us.ibm.com") by vger.kernel.org with ESMTP id S932243AbWHYA4h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 20:56:37 -0400
Subject: Re: [RFC][PATCH] Manage jbd allocations from its own slabs
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
       lkml <linux-kernel@vger.kernel.org>,
       ext2-devel <Ext2-devel@lists.sourceforge.net>
In-Reply-To: <20060823163410.d9af3baa.akpm@osdl.org>
References: <1156374495.30517.5.camel@dyn9047017100.beaverton.ibm.com>
	 <20060823163410.d9af3baa.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 24 Aug 2006 17:00:56 -0700
Message-Id: <1156464056.5392.11.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Here is the latest patch. Unfortunately, its not surviving my stress
tests on 1k filesystem. I keep running into 

fs/buffer.c: 2791 assert in submit_bh()
	        BUG_ON(!buffer_mapped(bh));

I haven't touched "bh" itself. So, I am not sure whats happening
here. I am trying to reproduce it on mainline 2.6.18-rc4 (seen
it once so far - but not consistently).

Changes since the last patch:

- create appropriate slabs only when we mount the filesystem with
that blocksize.
- simplify the find slab idx process and get it by shifting size.

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
 fs/jbd/journal.c     |   86 ++++++++++++++++++++++++++++++++++++++++++++++++---
 fs/jbd/transaction.c |    9 ++---
 include/linux/jbd.h  |    3 +
 4 files changed, 93 insertions(+), 11 deletions(-)

Index: linux-2.6.18-rc4/fs/jbd/journal.c
===================================================================
--- linux-2.6.18-rc4.orig/fs/jbd/journal.c	2006-08-24 13:23:28.000000000 -0700
+++ linux-2.6.18-rc4/fs/jbd/journal.c	2006-08-24 16:19:27.000000000 -0700
@@ -84,6 +84,7 @@
 
 static int journal_convert_superblock_v1(journal_t *, journal_superblock_t *);
 static void __journal_abort_soft (journal_t *journal, int errno);
+static int journal_create_jbd_slab(size_t slab_size);
 
 /*
  * Helper function used to manage commit timeouts
@@ -328,10 +329,10 @@
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
 
@@ -1090,6 +1091,13 @@
 		}
 	}
 
+	/*
+	 * Make sure to create a slab for this blocksize
+	 */
+	err = journal_create_jbd_slab(cpu_to_be32(journal->j_superblock->s_blocksize));
+	if (err)
+		return err;
+
 	/* Let the recovery code check whether it needs to recover any
 	 * data from the journal. */
 	if (journal_recover(journal))
@@ -1612,6 +1620,76 @@
 }
 
 /*
+ * jbd slab management: create 1k, 2k, 4k, 8k slabs as needed
+ * and allocate frozen and commit buffers from these slabs.
+ *
+ * Reason for doing this is to avoid, SLAB_DEBUG - since it could
+ * cause bh to cross page boundary.
+ */
+
+#define JBD_MAX_SLABS 5
+#define JBD_SLAB_INDEX(size)  (size >> 11)
+
+static kmem_cache_t *jbd_slab[JBD_MAX_SLABS];
+static const char *jbd_slab_names[JBD_MAX_SLABS] = {
+	"jbd_1k", "jbd_2k", "jbd_4k", NULL, "jbd_8k"
+};
+
+static void journal_destroy_jbd_slabs(void)
+{
+	int i;
+
+	for (i=0; i<JBD_MAX_SLABS; i++) {
+		if (jbd_slab[i])
+			kmem_cache_destroy(jbd_slab[i]);
+		jbd_slab[i] = NULL;
+	}
+}
+
+static int journal_create_jbd_slab(size_t slab_size)
+{
+	int i = JBD_SLAB_INDEX(slab_size);
+
+	BUG_ON(i >= JBD_MAX_SLABS);
+	/*
+	 * Check if we already have a slab created for this size
+	 */
+	if (jbd_slab[i])
+		return 0;
+
+	/*
+	 * Create a slab and force alignment to be same as slabsize -
+	 * this will make sure that allocations won't cross the page
+	 * boundary.
+	 */
+	jbd_slab[i] = kmem_cache_create(jbd_slab_names[i],
+				slab_size, slab_size, 0, NULL, NULL);
+	if (!jbd_slab[i]) {
+		printk(KERN_EMERG "JBD: no memory for jbd_slab cache\n");
+		return -ENOMEM;
+	}
+	return 0;
+}
+
+void * jbd_slab_alloc(size_t size, gfp_t flags)
+{
+	int idx;
+
+	idx = JBD_SLAB_INDEX(size);
+	BUG_ON(jbd_slab[idx] == NULL);
+	return kmem_cache_alloc(jbd_slab[idx], flags | __GFP_NOFAIL);
+}
+
+void jbd_slab_free(void *ptr,  size_t size)
+{
+	int idx;
+
+	idx = JBD_SLAB_INDEX(size);
+	BUG_ON(jbd_slab[idx] == NULL);
+	kmem_cache_free(jbd_slab[idx], ptr);
+}
+
+/*
  * Journal_head storage management
  */
 static kmem_cache_t *journal_head_cache;
@@ -1799,13 +1877,13 @@
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
@@ -1961,6 +2039,7 @@
 	journal_destroy_revoke_caches();
 	journal_destroy_journal_head_cache();
 	journal_destroy_handle_cache();
+	journal_destroy_jbd_slabs();
 }
 
 static int __init journal_init(void)
Index: linux-2.6.18-rc4/fs/jbd/transaction.c
===================================================================
--- linux-2.6.18-rc4.orig/fs/jbd/transaction.c	2006-08-24 13:23:28.000000000 -0700
+++ linux-2.6.18-rc4/fs/jbd/transaction.c	2006-08-24 13:23:55.000000000 -0700
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
--- linux-2.6.18-rc4.orig/fs/jbd/commit.c	2006-08-24 13:23:28.000000000 -0700
+++ linux-2.6.18-rc4/fs/jbd/commit.c	2006-08-24 13:23:55.000000000 -0700
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
--- linux-2.6.18-rc4.orig/include/linux/jbd.h	2006-08-24 13:23:28.000000000 -0700
+++ linux-2.6.18-rc4/include/linux/jbd.h	2006-08-24 13:23:55.000000000 -0700
@@ -72,6 +72,9 @@
 #endif
 
 extern void * __jbd_kmalloc (const char *where, size_t size, gfp_t flags, int retry);
+extern void * jbd_slab_alloc(size_t size, gfp_t flags);
+extern void jbd_slab_free(void *ptr, size_t size);
+
 #define jbd_kmalloc(size, flags) \
 	__jbd_kmalloc(__FUNCTION__, (size), (flags), journal_oom_retry)
 #define jbd_rep_kmalloc(size, flags) \



