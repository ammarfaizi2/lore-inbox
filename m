Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267558AbUHZEmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267558AbUHZEmO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 00:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267578AbUHZEmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 00:42:13 -0400
Received: from ozlabs.org ([203.10.76.45]:1739 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S267626AbUHZEln (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 00:41:43 -0400
Date: Thu, 26 Aug 2004 14:41:13 +1000
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] reduce size of struct inode on 64bit
Message-ID: <20040826044113.GA10843@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Reduce the size of struct inode on 64bit architectures by reducing padding.
This assumes spinlocks are 32bit or less which is the case on most
architectures.

This reduces inode structs by 24 bytes on ppc64, and on ext2 increases
the number of inodes in a 4kB slab from 5 to 6.

Signed-off-by: Anton Blanchard <anton@samba.org>

--

 gr_work-anton/include/linux/fs.h |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff -puN include/linux/fs.h~reduce_inode include/linux/fs.h
--- gr_work/include/linux/fs.h~reduce_inode	2004-08-25 22:38:03.543805050 -0500
+++ gr_work-anton/include/linux/fs.h	2004-08-25 22:38:03.556802993 -0500
@@ -335,14 +335,14 @@ struct address_space {
 	struct inode		*host;		/* owner: inode, block_device */
 	struct radix_tree_root	page_tree;	/* radix tree of all pages */
 	spinlock_t		tree_lock;	/* and spinlock protecting it */
-	unsigned long		nrpages;	/* number of total pages */
-	pgoff_t			writeback_index;/* writeback starts here */
-	struct address_space_operations *a_ops;	/* methods */
-	struct prio_tree_root	i_mmap;		/* tree of private mappings */
 	unsigned int		i_mmap_writable;/* count VM_SHARED mappings */
+	struct prio_tree_root	i_mmap;		/* tree of private mappings */
 	struct list_head	i_mmap_nonlinear;/*list VM_NONLINEAR mappings */
 	spinlock_t		i_mmap_lock;	/* protect tree, count, list */
 	atomic_t		truncate_count;	/* Cover race condition with truncate */
+	unsigned long		nrpages;	/* number of total pages */
+	pgoff_t			writeback_index;/* writeback starts here */
+	struct address_space_operations *a_ops;	/* methods */
 	unsigned long		flags;		/* error bits/gfp mask */
 	struct backing_dev_info *backing_dev_info; /* device readahead, etc */
 	spinlock_t		private_lock;	/* for use by the address_space */
@@ -437,6 +437,7 @@ struct inode {
 	unsigned long		i_version;
 	unsigned long		i_blocks;
 	unsigned short          i_bytes;
+	unsigned char		i_sock;
 	spinlock_t		i_lock;	/* i_blocks, i_bytes, maybe i_size */
 	struct semaphore	i_sem;
 	struct rw_semaphore	i_alloc_sem;
@@ -456,6 +457,8 @@ struct inode {
 	struct cdev		*i_cdev;
 	int			i_cindex;
 
+	__u32			i_generation;
+
 	unsigned long		i_dnotify_mask; /* Directory notify events */
 	struct dnotify_struct	*i_dnotify; /* for directory notifications */
 
@@ -463,11 +466,9 @@ struct inode {
 	unsigned long		dirtied_when;	/* jiffies of first dirtying */
 
 	unsigned int		i_flags;
-	unsigned char		i_sock;
 
 	atomic_t		i_writecount;
 	void			*i_security;
-	__u32			i_generation;
 	union {
 		void		*generic_ip;
 	} u;
_
