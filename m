Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264100AbUDGFu4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 01:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264097AbUDGFu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 01:50:56 -0400
Received: from mail.cyclades.com ([64.186.161.6]:10375 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S264100AbUDGFuv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 01:50:51 -0400
Date: Wed, 7 Apr 2004 02:21:03 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH] shrink core hashes on small systems
Message-ID: <20040407052103.GB8738@logos.cnet>
References: <20040405204957.GF6248@waste.org> <20040405140223.2f775da4.akpm@osdl.org> <20040405211916.GH6248@waste.org> <20040405143824.7f9b7020.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040405143824.7f9b7020.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1i
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2004 at 02:38:24PM -0700, Andrew Morton wrote:
> Matt Mackall <mpm@selenic.com> wrote:
> >
> > Longer term, I think some serious thought needs to go into scaling
> > hash sizes across the board, but this serves my purposes on the
> > low-end without changing behaviour asymptotically.
> 
> Can we make longer-term a bit shorter?  init_per_zone_pages_min() only took
> a few minutes thinking..
> 
> I suspect what we need is to replace num_physpages with nr_free_pages(),
> then account for PAGE_SIZE, then muck around with sqrt() for a while then
> apply upper and lower bounds to it.
> 
> That hard-wired breakpoint seems just too arbitrary to me - some sort of
> graduated thing which has a little thought and explanation behind it would
> be preferred please.

Hi,

Arjan told me his changes were not to allow orders higher than 5 
(thus maximizing hash table size to 128K) to avoid possible cache thrashing.

I've done some tests with dbench during the day with different dentry hash table
sizes, here are the results on a 2-way P4 2GB box (default of 1MB hashtable).

I ran three consecutive dbenchs (with 32 clients) each reboot (each line), and then 
six consecutive dbenchs on the last run.

Output is "Mb/s" output from dbench 2.1.

128K dentry hashtable:

160 145 155
152 147 148
170 132 132 156 154 127

512K dentry hashtable:

156 135 144
153 146 159
157 135 148 149 148 143

1Mb dentry hashtable:

167 127 139
160 144 139
144 137 162 153 132 121

Not much of noticeable difference between them. I was told
SPECWeb benefits from big hash tables. Any other recommended test? 
I have no access to SPECWeb. 

Testing the different hash sizes is not trivial because there are 
so many different workloads...

Another thing is we allow the cache to grow too big: 1MB for 2GB, 
4Mb for 32Gb, 8Mb for 64Gb (on 32-bit, twice as much on 64-bit). 

What about the following patch to calculate the sizes of the VFS 
caches based on more correct variables.

It might be good to shrink the caches a half (passing "4" instead of "3" to  
vfs_cache_size() does it). We gain lowmem pinned memory and dont seem 
to loose performance. Help with testing is very much appreciated.

PS: Another improvement which might be interesting is non-power-of-2 
allocations? That would make the increase on the cache size "smoother" when memory size
increases. 
AFAICS we dont do that because of our allocator is limited.

--- linux-2.6.4.orig/fs/inode.c	2004-03-10 23:55:51.000000000 -0300
+++ linux-2.6.4/fs/inode.c	2004-04-07 01:36:05.000000000 -0300
@@ -1337,6 +1337,8 @@
 }
 __setup("ihash_entries=", set_ihash_entries);
 
+int vfs_cache_size(int);
+
 /*
  * Initialize the waitqueues and inode hash table.
  */
@@ -1351,11 +1353,8 @@
 		init_waitqueue_head(&i_wait_queue_heads[i].wqh);
 
 	if (!ihash_entries)
-		ihash_entries = PAGE_SHIFT < 14 ?
-				mempages >> (14 - PAGE_SHIFT) :
-				mempages << (PAGE_SHIFT - 14);
+		ihash_entries = vfs_cache_size(4);
 
-	ihash_entries *= sizeof(struct hlist_head);
 	for (order = 0; ((1UL << order) << PAGE_SHIFT) < ihash_entries; order++)
 		;
 
--- linux-2.6.4.orig/fs/dcache.c	2004-03-10 23:55:22.000000000 -0300
+++ linux-2.6.4/fs/dcache.c	2004-04-07 01:38:15.000000000 -0300
@@ -1541,6 +1541,38 @@
 }
 __setup("dhash_entries=", set_dhash_entries);
 
+unsigned int nr_free_pages(void);
+
+/*
+ * This function is used to calculate the number of elements in 
+ * the VFS caches.
+ *
+ * Increasing "shift" will cause the size to be shrunk harder -- we 
+ * do for small mem boxes.
+ *
+ */
+
+int __init vfs_cache_size(int shift)
+{
+       unsigned long free_kbytes;
+       unsigned long cache_size;
+
+       free_kbytes = nr_free_pages() * (PAGE_SIZE >> 10);
+
+	if (free_kbytes < (8 * 1024))
+		shift += 3;
+	else if (free_kbytes < (32 * 1024))
+		shift += 2;
+	else if (free_kbytes < (512 * 1024))
+		shift += 1;
+
+       cache_size = int_sqrt(free_kbytes) >> shift;
+	cache_size *= sizeof(struct hlist_head);
+
+	return (cache_size << 10);
+}
+
+
 static void __init dcache_init(unsigned long mempages)
 {
 	struct hlist_head *d;
@@ -1567,11 +1599,8 @@
 	set_shrinker(DEFAULT_SEEKS, shrink_dcache_memory);
 
 	if (!dhash_entries)
-		dhash_entries = PAGE_SHIFT < 13 ?
-				mempages >> (13 - PAGE_SHIFT) :
-				mempages << (PAGE_SHIFT - 13);
+		dhash_entries = vfs_cache_size(3);
 
-	dhash_entries *= sizeof(struct hlist_head);
 	for (order = 0; ((1UL << order) << PAGE_SHIFT) < dhash_entries; order++)
 		;
 
