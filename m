Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbVGBOoN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbVGBOoN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 10:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbVGBOoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 10:44:13 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:47296 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261179AbVGBOoA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 10:44:00 -0400
Message-ID: <42C6A823.20203@colorfullife.com>
Date: Sat, 02 Jul 2005 16:43:47 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.8) Gecko/20050513 Fedora/1.7.8-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: bharata@in.ibm.com
Subject: [PATCH] do not create 0-sized shared arrays
Content-Type: multipart/mixed;
 boundary="------------070105080103090702080000"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070105080103090702080000
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

the slab allocator supports system-wide arrays with object pointers for 
fast memory allocations. The arrays are optional: for caches with large 
objects they are not used, because it could use too much memory.
Bharata noticed a bug in the implemenation: s_show accessed the shared 
array without checking that it's not NULL.
And do_tune_cpucache allocated an array, even if 0 entries were 
requested, thus s_show only oopses if the system runs out of memory...
The attached patch (against 2.6.12) fixes both bugs. It's tested on i386.

Signed-Off-By: Manfred Spraul <manfred@colorfullife.com>

--------------070105080103090702080000
Content-Type: text/plain;
 name="patch-slab-01-no_0_shared"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-slab-01-no_0_shared"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 6
//  SUBLEVEL = 12
//  EXTRAVERSION =
--- 2.6/mm/slab.c	2005-06-18 15:00:24.000000000 +0200
+++ build-2.6/mm/slab.c	2005-07-02 16:37:52.000000000 +0200
@@ -2642,7 +2642,7 @@
 				int shared)
 {
 	struct ccupdate_struct new;
-	struct array_cache *new_shared;
+	struct array_cache *new_shared, *old;
 	int i;
 
 	memset(&new.new,0,sizeof(new.new));
@@ -2677,19 +2677,26 @@
 		spin_unlock_irq(&cachep->spinlock);
 		kfree(ccold);
 	}
-	new_shared = alloc_arraycache(-1, batchcount*shared, 0xbaadf00d);
-	if (new_shared) {
-		struct array_cache *old;
-
-		spin_lock_irq(&cachep->spinlock);
-		old = cachep->lists.shared;
-		cachep->lists.shared = new_shared;
-		if (old)
-			free_block(cachep, ac_entry(old), old->avail);
-		spin_unlock_irq(&cachep->spinlock);
-		kfree(old);
+	if (shared > 0) {
+		new_shared = alloc_arraycache(-1, batchcount*shared, 0xbaadf00d);
+		/*
+		 * Memory allocation failed - keep shared as it was
+		 */
+		if (!new_shared)
+			goto keep_shared;
+	} else {
+		new_shared = NULL;
 	}
 
+	spin_lock_irq(&cachep->spinlock);
+	old = cachep->lists.shared;
+	cachep->lists.shared = new_shared;
+	if (old)
+		free_block(cachep, ac_entry(old), old->avail);
+	spin_unlock_irq(&cachep->spinlock);
+	kfree(old);
+
+keep_shared:
 	return 0;
 }
 
@@ -2908,6 +2915,7 @@
 	unsigned long	num_objs;
 	unsigned long	active_slabs = 0;
 	unsigned long	num_slabs;
+	unsigned int	shared_sz, shared_avail;
 	const char *name; 
 	char *error = NULL;
 
@@ -2949,11 +2957,17 @@
 	seq_printf(m, "%-17s %6lu %6lu %6u %4u %4d",
 		name, active_objs, num_objs, cachep->objsize,
 		cachep->num, (1<<cachep->gfporder));
+	if (cachep->lists.shared) {
+		shared_sz = cachep->lists.shared->limit/cachep->batchcount;
+		shared_avail = cachep->lists.shared->avail;
+	} else {
+		shared_sz = 0;
+		shared_avail = 0;
+	}
 	seq_printf(m, " : tunables %4u %4u %4u",
-			cachep->limit, cachep->batchcount,
-			cachep->lists.shared->limit/cachep->batchcount);
+			cachep->limit, cachep->batchcount, shared_sz);
 	seq_printf(m, " : slabdata %6lu %6lu %6u",
-			active_slabs, num_slabs, cachep->lists.shared->avail);
+			active_slabs, num_slabs, shared_avail);
 #if STATS
 	{	/* list3 stats */
 		unsigned long high = cachep->high_mark;

--------------070105080103090702080000--
