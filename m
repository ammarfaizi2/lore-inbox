Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbUBVEBp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 23:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261667AbUBVEBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 23:01:45 -0500
Received: from mail-02.iinet.net.au ([203.59.3.34]:60608 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261670AbUBVEBi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 23:01:38 -0500
Message-ID: <4038299E.9030907@cyberone.com.au>
Date: Sun, 22 Feb 2004 15:01:34 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Linus Torvalds <torvalds@osdl.org>, Mike Fedyk <mfedyk@matchmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Large slab cache in 2.6.1
References: <4037FCDA.4060501@matchmail.com> <20040222023638.GA13840@dingdong.cryptoapps.com> <Pine.LNX.4.58.0402211901520.3301@ppc970.osdl.org> <20040222031113.GB13840@dingdong.cryptoapps.com> <Pine.LNX.4.58.0402211919360.3301@ppc970.osdl.org> <20040222033111.GA14197@dingdong.cryptoapps.com>
In-Reply-To: <20040222033111.GA14197@dingdong.cryptoapps.com>
Content-Type: multipart/mixed;
 boundary="------------040308080300010009060506"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040308080300010009060506
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



Chris Wedgwood wrote:

>On Sat, Feb 21, 2004 at 07:28:24PM -0800, Linus Torvalds wrote:
>
>
>>What happened to the experiment of having slab pages on the
>>(in)active lists and letting them be free'd that way? Didn't
>>somebody already do that? Ed Tomlinson and Craig Kulesa?
>>
>
>Just as a data point:
>
>cw@taniwha:~/wk/linux/bk-2.5.x$ grep -E '(LowT|Slab)' /proc/meminfo
>LowTotal:       898448 kB
>Slab:           846260 kB
>
>So the slab pressure I have right now is simply because there is
>nowhere else it has to grow...
>
>

Can you try the following patch? It is against 2.6.3-mm2.


--------------040308080300010009060506
Content-Type: text/plain;
 name="vm-slab-balance.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vm-slab-balance.patch"

 linux-2.6-npiggin/fs/dcache.c         |    4 ++--
 linux-2.6-npiggin/fs/dquot.c          |    2 +-
 linux-2.6-npiggin/fs/inode.c          |    4 ++--
 linux-2.6-npiggin/fs/mbcache.c        |    2 +-
 linux-2.6-npiggin/fs/xfs/linux/kmem.h |    2 +-
 linux-2.6-npiggin/include/linux/mm.h  |    3 +--
 linux-2.6-npiggin/mm/vmscan.c         |   22 ++++++++++++----------
 7 files changed, 20 insertions(+), 19 deletions(-)

diff -puN mm/vmscan.c~vm-slab-balance mm/vmscan.c
--- linux-2.6/mm/vmscan.c~vm-slab-balance	2004-02-22 14:52:45.000000000 +1100
+++ linux-2.6-npiggin/mm/vmscan.c	2004-02-22 15:00:24.000000000 +1100
@@ -82,7 +82,6 @@ static long total_memory;
 struct shrinker {
 	shrinker_t		shrinker;
 	struct list_head	list;
-	int			seeks;	/* seeks to recreate an obj */
 	long			nr;	/* objs pending delete */
 };
 
@@ -92,14 +91,13 @@ static DECLARE_MUTEX(shrinker_sem);
 /*
  * Add a shrinker callback to be called from the vm
  */
-struct shrinker *set_shrinker(int seeks, shrinker_t theshrinker)
+struct shrinker *set_shrinker(shrinker_t theshrinker)
 {
         struct shrinker *shrinker;
 
         shrinker = kmalloc(sizeof(*shrinker), GFP_KERNEL);
         if (shrinker) {
 	        shrinker->shrinker = theshrinker;
-	        shrinker->seeks = seeks;
 	        shrinker->nr = 0;
 	        down(&shrinker_sem);
 	        list_add(&shrinker->list, &shrinker_list);
@@ -139,20 +137,24 @@ EXPORT_SYMBOL(remove_shrinker);
  */
 static int shrink_slab(unsigned long scanned, unsigned int gfp_mask)
 {
+	unsigned long long to_scan = scanned;
+	unsigned long slab_size = 0;
 	struct shrinker *shrinker;
-	long pages;
 
 	if (down_trylock(&shrinker_sem))
 		return 0;
 
-	pages = nr_used_zone_pages();
 	list_for_each_entry(shrinker, &shrinker_list, list) {
-		unsigned long long delta;
+		slab_size += (*shrinker->shrinker)(0, gfp_mask);
+	}
 
-		delta = 4 * scanned / shrinker->seeks;
-		delta *= (*shrinker->shrinker)(0, gfp_mask);
-		do_div(delta, pages + 1);
-		shrinker->nr += delta;
+	list_for_each_entry(shrinker, &shrinker_list, list) {
+		unsigned long long delta = to_scan;
+		int this_size = (*shrinker->shrinker)(0, gfp_mask);
+		delta *= this_size;
+		do_div(delta, slab_size + 1);
+		/* + 1 to make sure some scanning is eventually done */
+		shrinker->nr += delta + 1;
 		if (shrinker->nr > SHRINK_BATCH) {
 			long nr_to_scan = shrinker->nr;
 
diff -puN include/linux/mm.h~vm-slab-balance include/linux/mm.h
--- linux-2.6/include/linux/mm.h~vm-slab-balance	2004-02-22 14:52:45.000000000 +1100
+++ linux-2.6-npiggin/include/linux/mm.h	2004-02-22 14:52:45.000000000 +1100
@@ -483,9 +483,8 @@ typedef int (*shrinker_t)(int nr_to_scan
  * to recreate one of the objects that these functions age.
  */
 
-#define DEFAULT_SEEKS 2
 struct shrinker;
-extern struct shrinker *set_shrinker(int, shrinker_t);
+extern struct shrinker *set_shrinker(shrinker_t);
 extern void remove_shrinker(struct shrinker *shrinker);
 
 /*
diff -puN fs/dcache.c~vm-slab-balance fs/dcache.c
--- linux-2.6/fs/dcache.c~vm-slab-balance	2004-02-22 14:52:45.000000000 +1100
+++ linux-2.6-npiggin/fs/dcache.c	2004-02-22 14:52:45.000000000 +1100
@@ -657,7 +657,7 @@ static int shrink_dcache_memory(int nr, 
 		if (gfp_mask & __GFP_FS)
 			prune_dcache(nr);
 	}
-	return dentry_stat.nr_unused;
+	return dentry_stat.nr_dentry;
 }
 
 #define NAME_ALLOC_LEN(len)	((len+16) & ~15)
@@ -1564,7 +1564,7 @@ static void __init dcache_init(unsigned 
 	if (!dentry_cache)
 		panic("Cannot create dentry cache");
 	
-	set_shrinker(DEFAULT_SEEKS, shrink_dcache_memory);
+	set_shrinker(shrink_dcache_memory);
 
 	if (!dhash_entries)
 		dhash_entries = PAGE_SHIFT < 13 ?
diff -puN fs/dquot.c~vm-slab-balance fs/dquot.c
--- linux-2.6/fs/dquot.c~vm-slab-balance	2004-02-22 14:52:45.000000000 +1100
+++ linux-2.6-npiggin/fs/dquot.c	2004-02-22 14:52:45.000000000 +1100
@@ -1661,7 +1661,7 @@ static int __init dquot_init(void)
 	if (!dquot_cachep)
 		panic("Cannot create dquot SLAB cache");
 
-	set_shrinker(DEFAULT_SEEKS, shrink_dqcache_memory);
+	set_shrinker(shrink_dqcache_memory);
 
 	return 0;
 }
diff -puN fs/inode.c~vm-slab-balance fs/inode.c
--- linux-2.6/fs/inode.c~vm-slab-balance	2004-02-22 14:52:45.000000000 +1100
+++ linux-2.6-npiggin/fs/inode.c	2004-02-22 14:52:45.000000000 +1100
@@ -479,7 +479,7 @@ static int shrink_icache_memory(int nr, 
 		if (gfp_mask & __GFP_FS)
 			prune_icache(nr);
 	}
-	return inodes_stat.nr_unused;
+	return inodes_stat.nr_inodes;
 }
 
 static void __wait_on_freeing_inode(struct inode *inode);
@@ -1394,7 +1394,7 @@ void __init inode_init(unsigned long mem
 	if (!inode_cachep)
 		panic("cannot create inode slab cache");
 
-	set_shrinker(DEFAULT_SEEKS, shrink_icache_memory);
+	set_shrinker(shrink_icache_memory);
 }
 
 void init_special_inode(struct inode *inode, umode_t mode, dev_t rdev)
diff -puN fs/mbcache.c~vm-slab-balance fs/mbcache.c
--- linux-2.6/fs/mbcache.c~vm-slab-balance	2004-02-22 14:52:45.000000000 +1100
+++ linux-2.6-npiggin/fs/mbcache.c	2004-02-22 14:52:45.000000000 +1100
@@ -629,7 +629,7 @@ mb_cache_entry_find_next(struct mb_cache
 
 static int __init init_mbcache(void)
 {
-	mb_shrinker = set_shrinker(DEFAULT_SEEKS, mb_cache_shrink_fn);
+	mb_shrinker = set_shrinker(mb_cache_shrink_fn);
 	return 0;
 }
 
diff -puN fs/xfs/linux/kmem.h~vm-slab-balance fs/xfs/linux/kmem.h
--- linux-2.6/fs/xfs/linux/kmem.h~vm-slab-balance	2004-02-22 14:52:45.000000000 +1100
+++ linux-2.6-npiggin/fs/xfs/linux/kmem.h	2004-02-22 14:52:45.000000000 +1100
@@ -171,7 +171,7 @@ typedef int (*kmem_shake_func_t)(int, un
 static __inline kmem_shaker_t
 kmem_shake_register(kmem_shake_func_t sfunc)
 {
-	return set_shrinker(DEFAULT_SEEKS, sfunc);
+	return set_shrinker(sfunc);
 }
 
 static __inline void

_

--------------040308080300010009060506--
