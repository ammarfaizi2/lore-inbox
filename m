Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267094AbUBEX45 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 18:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267085AbUBEX45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 18:56:57 -0500
Received: from fw.osdl.org ([65.172.181.6]:49070 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267094AbUBEX4r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 18:56:47 -0500
Date: Thu, 5 Feb 2004 15:58:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Limit hash table size
Message-Id: <20040205155813.726041bd.akpm@osdl.org>
In-Reply-To: <B05667366EE6204181EABE9C1B1C0EB5802441@scsmsx401.sc.intel.com>
References: <B05667366EE6204181EABE9C1B1C0EB5802441@scsmsx401.sc.intel.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ken, I remain unhappy with this patch.  If a big box has 500 million
dentries or inodes in cache (is possible), those hash chains will be more
than 200 entries long on average.  It will be very slow.

We need to do something smarter.  At least, for machines which do not have
the ia64 proliferation-of-zones problem.

Maybe we should leave the sizing of these tables as-is, and add some hook
which allows the architecture to scale them back.




From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>

The issue of exceedingly large hash tables has been discussed on the
mailing list a while back, but seems to slip through the cracks.

What we found is it's not a problem for x86 (and most other
architectures) because __get_free_pages won't be able to get anything
beyond order MAX_ORDER-1 (10) which means at most those hash tables are
4MB each (assume 4K page size).  However, on ia64, in order to support
larger hugeTLB page size, the MAX_ORDER is bumped up to 18, which now
means a 2GB upper limits enforced by the page allocator (assume 16K page
size).  PPC64 is another example that bumps up MAX_ORDER.

Last time I checked, the tcp ehash table is taking a whooping (insane!)
2GB on one of our large machine.  dentry and inode hash tables also take
considerable amount of memory.

We enforce the maximum size based on the number of entries instead of the
page order.  The upper bound is capped at 2M.  All numbers on x86 remain the
same as we don't want to disturb already established and working number.

(acked by davem)


---

 25-akpm/fs/dcache.c      |    9 +++++----
 25-akpm/fs/inode.c       |    7 +++++--
 25-akpm/net/ipv4/route.c |    2 +-
 25-akpm/net/ipv4/tcp.c   |    2 +-
 4 files changed, 12 insertions(+), 8 deletions(-)

diff -puN fs/dcache.c~limit-hash-table-sizes fs/dcache.c
--- 25/fs/dcache.c~limit-hash-table-sizes	Thu Feb  5 15:43:40 2004
+++ 25-akpm/fs/dcache.c	Thu Feb  5 15:43:40 2004
@@ -49,6 +49,7 @@ static kmem_cache_t *dentry_cache; 
  */
 #define D_HASHBITS     d_hash_shift
 #define D_HASHMASK     d_hash_mask
+#define D_HASHMAX	(2*1024*1024UL)	/* max number of entries */
 
 static unsigned int d_hash_mask;
 static unsigned int d_hash_shift;
@@ -1565,10 +1566,10 @@ static void __init dcache_init(unsigned 
 	
 	set_shrinker(DEFAULT_SEEKS, shrink_dcache_memory);
 
-#if PAGE_SHIFT < 13
-	mempages >>= (13 - PAGE_SHIFT);
-#endif
-	mempages *= sizeof(struct hlist_head);
+	mempages = PAGE_SHIFT < 13 ?
+		   mempages >> (13 - PAGE_SHIFT) :
+		   mempages << (PAGE_SHIFT - 13);
+	mempages = min(D_HASHMAX, mempages) * sizeof(struct hlist_head);
 	for (order = 0; ((1UL << order) << PAGE_SHIFT) < mempages; order++)
 		;
 
diff -puN fs/inode.c~limit-hash-table-sizes fs/inode.c
--- 25/fs/inode.c~limit-hash-table-sizes	Thu Feb  5 15:43:40 2004
+++ 25-akpm/fs/inode.c	Thu Feb  5 15:43:40 2004
@@ -53,6 +53,7 @@
  */
 #define I_HASHBITS	i_hash_shift
 #define I_HASHMASK	i_hash_mask
+#define I_HASHMAX	(2*1024*1024UL)	/* max number of entries */
 
 static unsigned int i_hash_mask;
 static unsigned int i_hash_shift;
@@ -1325,8 +1326,10 @@ void __init inode_init(unsigned long mem
 	for (i = 0; i < ARRAY_SIZE(i_wait_queue_heads); i++)
 		init_waitqueue_head(&i_wait_queue_heads[i].wqh);
 
-	mempages >>= (14 - PAGE_SHIFT);
-	mempages *= sizeof(struct hlist_head);
+	mempages = PAGE_SHIFT < 14 ?
+		   mempages >> (14 - PAGE_SHIFT) :
+		   mempages << (PAGE_SHIFT - 14);
+	mempages = min(I_HASHMAX, mempages) * sizeof(struct hlist_head);
 	for (order = 0; ((1UL << order) << PAGE_SHIFT) < mempages; order++)
 		;
 
diff -puN net/ipv4/route.c~limit-hash-table-sizes net/ipv4/route.c
--- 25/net/ipv4/route.c~limit-hash-table-sizes	Thu Feb  5 15:43:40 2004
+++ 25-akpm/net/ipv4/route.c	Thu Feb  5 15:43:40 2004
@@ -2744,7 +2744,7 @@ int __init ip_rt_init(void)
 
 	goal = num_physpages >> (26 - PAGE_SHIFT);
 
-	for (order = 0; (1UL << order) < goal; order++)
+	for (order = 0; (order < 10) && ((1UL << order) < goal); order++)
 		/* NOTHING */;
 
 	do {
diff -puN net/ipv4/tcp.c~limit-hash-table-sizes net/ipv4/tcp.c
--- 25/net/ipv4/tcp.c~limit-hash-table-sizes	Thu Feb  5 15:43:40 2004
+++ 25-akpm/net/ipv4/tcp.c	Thu Feb  5 15:43:40 2004
@@ -2611,7 +2611,7 @@ void __init tcp_init(void)
 	else
 		goal = num_physpages >> (23 - PAGE_SHIFT);
 
-	for (order = 0; (1UL << order) < goal; order++)
+	for (order = 0; (order < 10) && ((1UL << order) < goal); order++)
 		;
 	do {
 		tcp_ehash_size = (1UL << order) * PAGE_SIZE /

_

