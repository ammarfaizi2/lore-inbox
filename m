Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbTK2Kk3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 05:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbTK2Kk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 05:40:29 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:48278 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261731AbTK2KkY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 05:40:24 -0500
Message-ID: <3FC87770.1080400@colorfullife.com>
Date: Sat, 29 Nov 2003 11:39:44 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jack Steiner <steiner@sgi.com>
CC: Jes Sorensen <jes@wildopensource.com>, linux-kernel@vger.kernel.org,
       anton@samba.org, "Martin J. Bligh" <mbligh@aracnet.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: hash table sizes
Content-Type: multipart/mixed;
 boundary="------------090003080206090602010503"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090003080206090602010503
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

What about the attached patch?
- add command line overrides for the hash tables sizes. It's impossible 
to guess if the system is used as a HPC or as a file server. Doc update 
missing.
- limit the dcache hash to 8 mio entries, and the inode hash to 1 mio 
entries, regardless of the amount of memory in the system. The system 
admin can override the defaults at boot time if needed.
- distribute the memory allocations that happen during boot to all nodes 
- the memory will be touched by all cpus, binding all allocs to the boot 
node is wrong.

The patch compiles, but is untested due to lack of hardware.

--
    Manfred



--------------090003080206090602010503
Content-Type: text/plain;
 name="patch-numa"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-numa"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 6
//  SUBLEVEL = 0
//  EXTRAVERSION = -test11
--- 2.6/mm/page_alloc.c	2003-11-29 09:46:35.000000000 +0100
+++ build-2.6/mm/page_alloc.c	2003-11-29 11:34:04.000000000 +0100
@@ -681,6 +681,42 @@
 
 EXPORT_SYMBOL(__alloc_pages);
 
+#ifdef CONFIG_NUMA
+/* Early boot: Everything is done by one cpu, but the data structures will be
+ * used by all cpus - spread them on all nodes.
+ */
+static __init unsigned long get_boot_pages(unsigned int gfp_mask, unsigned int order)
+{
+static int nodenr;
+	int i = nodenr;
+	struct page *page;
+
+	for (;;) {
+		if (i > nodenr + numnodes)
+			return 0;
+		if (node_present_pages(i%numnodes)) {
+			struct zone **z;
+			/* The node contains memory. Check that there is 
+			 * memory in the intended zonelist.
+			 */
+			z = NODE_DATA(i%numnodes)->node_zonelists[gfp_mask & GFP_ZONEMASK].zones;
+			while (*z) {
+				if ( (*z)->free_pages > (1UL<<order))
+					goto found_node;
+				z++;
+			}
+		}
+		i++;
+	}
+found_node:
+	nodenr = i+1;
+	page = alloc_pages_node(i%numnodes, gfp_mask, order);
+	if (!page)
+		return 0;
+	return (unsigned long) page_address(page);
+}
+#endif
+
 /*
  * Common helper functions.
  */
@@ -688,6 +724,10 @@
 {
 	struct page * page;
 
+#ifdef CONFIG_NUMA
+	if (unlikely(!system_running))
+		return get_boot_pages(gfp_mask, order);
+#endif
 	page = alloc_pages(gfp_mask, order);
 	if (!page)
 		return 0;
--- 2.6/fs/inode.c	2003-11-29 09:46:34.000000000 +0100
+++ build-2.6/fs/inode.c	2003-11-29 10:19:21.000000000 +0100
@@ -1327,6 +1327,20 @@
 		wake_up_all(wq);
 }
 
+static __initdata int ihash_entries;
+
+static int __init set_ihash_entries(char *str)
+{
+	get_option(&str, &ihash_entries);
+	if (ihash_entries <= 0) {
+		ihash_entries = 0;
+		return 0;
+	}
+	return 1;
+}
+
+__setup("ihash_entries=", set_ihash_entries);
+
 /*
  * Initialize the waitqueues and inode hash table.
  */
@@ -1340,8 +1354,16 @@
 	for (i = 0; i < ARRAY_SIZE(i_wait_queue_heads); i++)
 		init_waitqueue_head(&i_wait_queue_heads[i].wqh);
 
-	mempages >>= (14 - PAGE_SHIFT);
-	mempages *= sizeof(struct hlist_head);
+	if (!ihash_entries) {
+		ihash_entries = mempages >> (14 - PAGE_SHIFT);
+		/* Limit inode hash size. Override for nfs servers
+		 * that handle lots of files.
+		 */
+		if (ihash_entries > 1024*1024)
+			ihash_entries = 1024*1024;
+	}
+
+	mempages = ihash_entries*sizeof(struct hlist_head);
 	for (order = 0; ((1UL << order) << PAGE_SHIFT) < mempages; order++)
 		;
 
--- 2.6/fs/dcache.c	2003-11-29 09:46:34.000000000 +0100
+++ build-2.6/fs/dcache.c	2003-11-29 10:53:15.000000000 +0100
@@ -1546,6 +1546,20 @@
 	return ino;
 }
 
+static __initdata int dhash_entries;
+
+static int __init set_dhash_entries(char *str)
+{
+	get_option(&str, &dhash_entries);
+	if (dhash_entries <= 0) {
+		dhash_entries = 0;
+		return 0;
+	}
+	return 1;
+}
+
+__setup("dhash_entries=", set_dhash_entries);
+
 static void __init dcache_init(unsigned long mempages)
 {
 	struct hlist_head *d;
@@ -1571,10 +1585,18 @@
 	
 	set_shrinker(DEFAULT_SEEKS, shrink_dcache_memory);
 
+	if (!dhash_entries) {
 #if PAGE_SHIFT < 13
-	mempages >>= (13 - PAGE_SHIFT);
+		mempages >>= (13 - PAGE_SHIFT);
 #endif
-	mempages *= sizeof(struct hlist_head);
+		dhash_entries = mempages;
+		/* 8 mio is enough for general purpose systems.
+		 * For file servers, override with "dhash_entries="
+		 */
+		if (dhash_entries > 8*1024*1024)
+			dhash_entries = 8*1024*1024;
+	}
+	mempages = dhash_entries*sizeof(struct hlist_head);
 	for (order = 0; ((1UL << order) << PAGE_SHIFT) < mempages; order++)
 		;
 

--------------090003080206090602010503--

