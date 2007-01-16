Return-Path: <linux-kernel-owner+w=401wt.eu-S932414AbXAPFsb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbXAPFsb (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 00:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbXAPFs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 00:48:29 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:58776 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932389AbXAPFsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 00:48:04 -0500
Date: Mon, 15 Jan 2007 21:47:53 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Paul Menage <menage@google.com>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Andi Kleen <ak@suse.de>, Paul Jackson <pj@sgi.com>,
       Dave Chinner <dgc@sgi.com>, Christoph Lameter <clameter@sgi.com>
Message-Id: <20070116054753.15358.57869.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20070116054743.15358.77287.sendpatchset@schroedinger.engr.sgi.com>
References: <20070116054743.15358.77287.sendpatchset@schroedinger.engr.sgi.com>
Subject: [RFC 2/8] Add a map to inodes to track dirty pages per node
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a dirty map to the inode

In a NUMA system it is helpful to know where the dirty pages of a mapping
are located. That way we will be able to implement writeout for applications
that are constrained to a portion of the memory of the system as required by
cpusets.

Two functions are introduced to manage the dirty node map:

cpuset_clear_dirty_nodes() and cpuset_update_nodes(). Both are defined using
macros since the definition of struct inode may not be available in cpuset.h.

The dirty map is cleared when the inode is cleared. There is no
synchronization (except for atomic nature of node_set) for the dirty_map. The
only problem that could be done is that we do not write out an inode if a
node bit is not set. That is rare and will be impossibly rare if multiple pages
are involved. There is therefore a slight chance that we have missed a dirty
node if it just contains a single page. Which is likely tolerable.

This patch increases the size of struct inode for the NUMA case. For
most arches that only support up to 64 nodes this is simply adding one
unsigned long.

However, the default Itanium configuration allows for up to 1024 nodes.
On Itanium we add 128 byte per inode. A later patch will make the size of
the per node bit array dynamic so that the size of the inode slab caches
is properly sized.

Signed-off-by; Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.20-rc5/fs/fs-writeback.c
===================================================================
--- linux-2.6.20-rc5.orig/fs/fs-writeback.c	2007-01-12 12:54:26.000000000 -0600
+++ linux-2.6.20-rc5/fs/fs-writeback.c	2007-01-15 22:34:12.065241639 -0600
@@ -22,6 +22,7 @@
 #include <linux/blkdev.h>
 #include <linux/backing-dev.h>
 #include <linux/buffer_head.h>
+#include <linux/cpuset.h>
 #include "internal.h"
 
 /**
@@ -223,11 +224,13 @@ __sync_single_inode(struct inode *inode,
 			/*
 			 * The inode is clean, inuse
 			 */
+			cpuset_clear_dirty_nodes(inode);
 			list_move(&inode->i_list, &inode_in_use);
 		} else {
 			/*
 			 * The inode is clean, unused
 			 */
+			cpuset_clear_dirty_nodes(inode);
 			list_move(&inode->i_list, &inode_unused);
 		}
 	}
Index: linux-2.6.20-rc5/fs/inode.c
===================================================================
--- linux-2.6.20-rc5.orig/fs/inode.c	2007-01-12 12:54:26.000000000 -0600
+++ linux-2.6.20-rc5/fs/inode.c	2007-01-15 22:33:55.802081773 -0600
@@ -22,6 +22,7 @@
 #include <linux/bootmem.h>
 #include <linux/inotify.h>
 #include <linux/mount.h>
+#include <linux/cpuset.h>
 
 /*
  * This is needed for the following functions:
@@ -134,6 +135,7 @@ static struct inode *alloc_inode(struct 
 		inode->i_cdev = NULL;
 		inode->i_rdev = 0;
 		inode->dirtied_when = 0;
+		cpuset_clear_dirty_nodes(inode);
 		if (security_inode_alloc(inode)) {
 			if (inode->i_sb->s_op->destroy_inode)
 				inode->i_sb->s_op->destroy_inode(inode);
Index: linux-2.6.20-rc5/include/linux/fs.h
===================================================================
--- linux-2.6.20-rc5.orig/include/linux/fs.h	2007-01-12 12:54:26.000000000 -0600
+++ linux-2.6.20-rc5/include/linux/fs.h	2007-01-15 22:33:55.876307100 -0600
@@ -589,6 +589,9 @@ struct inode {
 	void			*i_security;
 #endif
 	void			*i_private; /* fs or device private pointer */
+#ifdef CONFIG_CPUSETS
+	nodemask_t		dirty_nodes;	/* Map of nodes with dirty pages */
+#endif
 };
 
 /*
Index: linux-2.6.20-rc5/mm/page-writeback.c
===================================================================
--- linux-2.6.20-rc5.orig/mm/page-writeback.c	2007-01-12 12:54:26.000000000 -0600
+++ linux-2.6.20-rc5/mm/page-writeback.c	2007-01-15 22:34:14.425802376 -0600
@@ -33,6 +33,7 @@
 #include <linux/syscalls.h>
 #include <linux/buffer_head.h>
 #include <linux/pagevec.h>
+#include <linux/cpuset.h>
 
 /*
  * The maximum number of pages to writeout in a single bdflush/kupdate
@@ -780,6 +781,7 @@ int __set_page_dirty_nobuffers(struct pa
 		if (mapping->host) {
 			/* !PageAnon && !swapper_space */
 			__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
+			cpuset_update_dirty_nodes(mapping->host, page);
 		}
 		return 1;
 	}
Index: linux-2.6.20-rc5/fs/buffer.c
===================================================================
--- linux-2.6.20-rc5.orig/fs/buffer.c	2007-01-12 12:54:26.000000000 -0600
+++ linux-2.6.20-rc5/fs/buffer.c	2007-01-15 22:34:14.459008443 -0600
@@ -42,6 +42,7 @@
 #include <linux/bitops.h>
 #include <linux/mpage.h>
 #include <linux/bit_spinlock.h>
+#include <linux/cpuset.h>
 
 static int fsync_buffers_list(spinlock_t *lock, struct list_head *list);
 static void invalidate_bh_lrus(void);
@@ -739,6 +740,7 @@ int __set_page_dirty_buffers(struct page
 	}
 	write_unlock_irq(&mapping->tree_lock);
 	__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
+	cpuset_update_dirty_nodes(mapping->host, page);
 	return 1;
 }
 EXPORT_SYMBOL(__set_page_dirty_buffers);
Index: linux-2.6.20-rc5/include/linux/cpuset.h
===================================================================
--- linux-2.6.20-rc5.orig/include/linux/cpuset.h	2007-01-12 12:54:26.000000000 -0600
+++ linux-2.6.20-rc5/include/linux/cpuset.h	2007-01-15 22:34:37.757947994 -0600
@@ -75,6 +75,19 @@ static inline int cpuset_do_slab_mem_spr
 
 extern void cpuset_track_online_nodes(void);
 
+/*
+ * We need macros since struct inode is not defined yet
+ */
+#define cpuset_update_dirty_nodes(__inode, __page) \
+	node_set(page_to_nid(__page), (__inode)->dirty_nodes)
+
+#define cpuset_clear_dirty_nodes(__inode) \
+		(__inode)->dirty_nodes = NODE_MASK_NONE
+
+#define cpuset_intersects_dirty_nodes(__inode, __nodemask_ptr) \
+		(!(__nodemask_ptr) || nodes_intersects((__inode)->dirty_nodes, \
+		*(__nodemask_ptr)))
+
 #else /* !CONFIG_CPUSETS */
 
 static inline int cpuset_init_early(void) { return 0; }
@@ -146,6 +159,17 @@ static inline int cpuset_do_slab_mem_spr
 
 static inline void cpuset_track_online_nodes(void) {}
 
+static inline void cpuset_update_dirty_nodes(struct inode *i,
+		struct page *page) {}
+
+static inline void cpuset_clear_dirty_nodes(struct inode *i) {}
+
+static inline int cpuset_intersects_dirty_nodes(struct inode *i,
+		nodemask_t *n)
+{
+	return 1;
+}
+
 #endif /* !CONFIG_CPUSETS */
 
 #endif /* _LINUX_CPUSET_H */
