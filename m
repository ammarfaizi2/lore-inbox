Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbTERIz6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 04:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbTERIz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 04:55:58 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:3018 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261244AbTERIzq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 04:55:46 -0400
Message-ID: <3EC746E4.5020406@colorfullife.com>
Date: Sun, 18 May 2003 10:40:04 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Improve inter-cpu object passing in slab 2/3
Content-Type: multipart/mixed;
 boundary="------------080209010100080703070908"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080209010100080703070908
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

2nd part for faster object transfer between cpus:

Make it tunable by writing to /proc/slabinfo.

The patch is against 2.5.69-mm6, it applies to 2.5.69-bk12 with some 
offsets.

What do you think? The change breaks backward compatibility: previously 
/proc/slabinfo expected two numbers (batchcount, limit), now it expects 
three numbers (batchcount, limit, sharedfactor). Calls with the wrong 
number of arguments just fail.

--
    Manfred

--------------080209010100080703070908
Content-Type: text/plain;
 name="patch-slab-arraytune"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-slab-arraytune"

--- 2.5/mm/slab.c	2003-05-16 23:43:44.000000000 +0200
+++ build-2.5/mm/slab.c	2003-05-17 00:05:02.000000000 +0200
@@ -203,7 +203,6 @@
  * into this structure, too. Figure out what causes
  * fewer cross-node spinlock operations.
  */
-#define SHARED_ARRAY_FACTOR	16
 struct kmem_list3 {
 	struct list_head	slabs_partial;	/* partial list first, better asm code */
 	struct list_head	slabs_free;
@@ -2176,7 +2175,7 @@
 }
 
 
-static int do_tune_cpucache (kmem_cache_t* cachep, int limit, int batchcount)
+static int do_tune_cpucache (kmem_cache_t* cachep, int limit, int batchcount, int shared)
 {
 	struct ccupdate_struct new;
 	struct array_cache *new_shared;
@@ -2218,12 +2217,12 @@
 		spin_unlock_irq(&cachep->spinlock);
 		kfree(ccold);
 	}
-	new_shared = kmalloc(sizeof(void*)*batchcount*SHARED_ARRAY_FACTOR+
+	new_shared = kmalloc(sizeof(void*)*batchcount*shared+
 				sizeof(struct array_cache), GFP_KERNEL);
 	if (new_shared) {
 		struct array_cache *old;
 		new_shared->avail = 0;
-		new_shared->limit = batchcount*SHARED_ARRAY_FACTOR;
+		new_shared->limit = batchcount*shared;
 		new_shared->batchcount = 0xbaadf00d;
 		new_shared->touched = 0;
 
@@ -2243,7 +2242,7 @@
 static void enable_cpucache (kmem_cache_t *cachep)
 {
 	int err;
-	int limit;
+	int limit, shared;
 
 	/* The head array serves three purposes:
 	 * - create a LIFO ordering, i.e. return objects that are cache-warm
@@ -2258,11 +2257,25 @@
 	else if (cachep->objsize > PAGE_SIZE)
 		limit = 8;
 	else if (cachep->objsize > 1024)
-		limit = 54;
+		limit = 24;
 	else if (cachep->objsize > 256)
-		limit = 120;
+		limit = 54;
 	else
-		limit = 248;
+		limit = 120;
+
+	/* Cpu bound tasks (e.g. network routing) can exhibit cpu bound
+	 * allocation behaviour: Most allocs on one cpu, most free operations
+	 * on another cpu. For these cases, an efficient object passing between
+	 * cpus is necessary. This is provided by a shared array. The array
+	 * replaces Bonwick's magazine layer.
+	 * On uniprocessor, it's functionally equivalent (but less efficient)
+	 * to a larger limit. Thus disabled by default.
+	 */
+	shared = 0;
+#ifdef CONFIG_SMP
+	if (cachep->objsize <= PAGE_SIZE)
+		shared = 8;
+#endif
 
 #if DEBUG
 	/* With debugging enabled, large batchcount lead to excessively
@@ -2272,7 +2285,7 @@
 	if (limit > 32)
 		limit = 32;
 #endif
-	err = do_tune_cpucache(cachep, limit, (limit+1)/2);
+	err = do_tune_cpucache(cachep, limit, (limit+1)/2, shared);
 	if (err)
 		printk(KERN_ERR "enable_cpucache failed for %s, error %d.\n",
 					cachep->name, -err);
@@ -2580,7 +2593,7 @@
 
 #define MAX_SLABINFO_WRITE 128
 /**
- * slabinfo_write - SMP tuning for the slab allocator
+ * slabinfo_write - Tuning for the slab allocator
  * @file: unused
  * @buffer: user buffer
  * @count: data len
@@ -2590,7 +2603,7 @@
 				size_t count, loff_t *ppos)
 {
 	char kbuf[MAX_SLABINFO_WRITE+1], *tmp;
-	int limit, batchcount, res;
+	int limit, batchcount, shared, res;
 	struct list_head *p;
 	
 	if (count > MAX_SLABINFO_WRITE)
@@ -2604,10 +2617,8 @@
 		return -EINVAL;
 	*tmp = '\0';
 	tmp++;
-	limit = simple_strtol(tmp, &tmp, 10);
-	while (*tmp == ' ')
-		tmp++;
-	batchcount = simple_strtol(tmp, &tmp, 10);
+	if (sscanf(tmp, " %d %d %d", &limit, &batchcount, &shared) != 3)
+		return -EINVAL;
 
 	/* Find the cache in the chain of caches. */
 	down(&cache_chain_sem);
@@ -2618,10 +2629,11 @@
 		if (!strcmp(cachep->name, kbuf)) {
 			if (limit < 1 ||
 			    batchcount < 1 ||
-			    batchcount > limit) {
+			    batchcount > limit ||
+			    shared < 0) {
 				res = -EINVAL;
 			} else {
-				res = do_tune_cpucache(cachep, limit, batchcount);
+				res = do_tune_cpucache(cachep, limit, batchcount, shared);
 			}
 			break;
 		}

--------------080209010100080703070908--


