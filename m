Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262566AbTKYNgI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 08:36:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262569AbTKYNgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 08:36:08 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:53433 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S262566AbTKYNgB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 08:36:01 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16323.23221.835676.999857@gargle.gargle.HOWL>
Date: Tue, 25 Nov 2003 08:35:49 -0500
To: Alexander Viro <viro@math.psu.edu>
CC: Andrew Morton <akpm@osdl.org>,
       "William Lee Irwin, III" <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org, jbarnes@sgi.com, steiner@sgi.com
Subject: hash table sizes
X-Mailer: VM 7.03 under Emacs 21.2.1
From: Jes Sorensen <jes@trained-monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On NUMA systems with way too much memory, the current algorithms for
determining the size of the inode and dentry hash tables ends up trying
to allocate tables that are so big they may not fit within the physical
memory of a single node. Ie. on a 256 node system with 512GB of RAM with
16KB pages it basically ends up eating up all the memory on node before
completing a boot because of this. The inode and dentry hashes are 256MB
each and the IP routing table hash is 128MB.

I have tried changing the algorithm as below and it seems to produce
reasonable results and almost identical numbers for the smaller /
mid-sized configs I looked at.

This is not meant to be a final patch, any input/oppinion is welcome.

Thanks,
Jes

--- orig/linux-2.6.0-test10/fs/dcache.c	Sat Oct 25 11:42:58 2003
+++ linux-2.6.0-test10/fs/dcache.c	Tue Nov 25 05:33:04 2003
@@ -1549,9 +1549,8 @@
 static void __init dcache_init(unsigned long mempages)
 {
 	struct hlist_head *d;
-	unsigned long order;
 	unsigned int nr_hash;
-	int i;
+	int i, order;
 
 	/* 
 	 * A constructor could be added for stable state like the lists,
@@ -1571,12 +1570,17 @@
 	
 	set_shrinker(DEFAULT_SEEKS, shrink_dcache_memory);
 
+#if 0
 #if PAGE_SHIFT < 13
 	mempages >>= (13 - PAGE_SHIFT);
 #endif
 	mempages *= sizeof(struct hlist_head);
 	for (order = 0; ((1UL << order) << PAGE_SHIFT) < mempages; order++)
 		;
+#endif
+	mempages >>= (23 - (PAGE_SHIFT - 1));
+	order = max(2, fls(mempages));
+	order = min(12, order);
 
 	do {
 		unsigned long tmp;
@@ -1594,7 +1598,7 @@
 			__get_free_pages(GFP_ATOMIC, order);
 	} while (dentry_hashtable == NULL && --order >= 0);
 
-	printk(KERN_INFO "Dentry cache hash table entries: %d (order: %ld, %ld bytes)\n",
+	printk(KERN_INFO "Dentry cache hash table entries: %d (order: %d, %ld bytes)\n",
 			nr_hash, order, (PAGE_SIZE << order));
 
 	if (!dentry_hashtable)
--- orig/linux-2.6.0-test10/fs/inode.c	Sat Oct 25 11:44:53 2003
+++ linux-2.6.0-test10/fs/inode.c	Tue Nov 25 05:33:27 2003
@@ -1333,17 +1333,21 @@
 void __init inode_init(unsigned long mempages)
 {
 	struct hlist_head *head;
-	unsigned long order;
 	unsigned int nr_hash;
-	int i;
+	int i, order;
 
 	for (i = 0; i < ARRAY_SIZE(i_wait_queue_heads); i++)
 		init_waitqueue_head(&i_wait_queue_heads[i].wqh);
 
+#if 0
 	mempages >>= (14 - PAGE_SHIFT);
 	mempages *= sizeof(struct hlist_head);
 	for (order = 0; ((1UL << order) << PAGE_SHIFT) < mempages; order++)
 		;
+#endif
+	mempages >>= (23 - (PAGE_SHIFT - 1));
+	order = max(2, fls(mempages));
+	order = min(12, order);
 
 	do {
 		unsigned long tmp;
