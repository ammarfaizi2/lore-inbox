Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751122AbVJBQc5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbVJBQc5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 12:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbVJBQc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 12:32:57 -0400
Received: from [59.92.132.103] ([59.92.132.103]:61060 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751122AbVJBQc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 12:32:56 -0400
Date: Sun, 2 Oct 2005 22:02:29 +0530
From: Bharata B Rao <bharata@in.ibm.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Dipankar Sarma <dipankar@in.ibm.com>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: VM balancing issues on 2.6.13: dentry cache not getting shrunk enough
Message-ID: <20051002163229.GB5190@in.ibm.com>
Reply-To: bharata@in.ibm.com
References: <20050911105709.GA16369@thunk.org> <20050911120045.GA4477@in.ibm.com> <20050912031636.GB16758@thunk.org> <20050913084752.GC4474@in.ibm.com> <20050914230843.GA11748@dmt.cnet> <20050915093945.GD3869@in.ibm.com> <20050915132910.GA6806@dmt.cnet>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
In-Reply-To: <20050915132910.GA6806@dmt.cnet>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 15, 2005 at 10:29:10AM -0300, Marcelo Tosatti wrote:
> On Thu, Sep 15, 2005 at 03:09:45PM +0530, Bharata B Rao wrote:
> > On Wed, Sep 14, 2005 at 08:08:43PM -0300, Marcelo Tosatti wrote:
> > > On Tue, Sep 13, 2005 at 02:17:52PM +0530, Bharata B Rao wrote:
> > > > 
> > <snip>
> > > > First is dentry_stats patch which collects some dcache statistics
> > > > and puts it into /proc/meminfo. This patch provides information 
> > > > about how dentries are distributed in dcache slab pages, how many
> > > > free and in use dentries are present in dentry_unused lru list and
> > > > how prune_dcache() performs with respect to freeing the requested
> > > > number of dentries.
> > > 
> > > Bharata, 
> > > 
> > > Ideally one should move the "nr_requested/nr_freed" counters from your
> > > stats patch into "struct shrinker" (or somewhere else more appropriate
> > > in which per-shrinkable-cache stats are maintained), and use the
> > > "mod_page_state" infrastructure to do lockless per-CPU accounting. ie.
> > > break /proc/vmstats's "slabs_scanned" apart in meaningful pieces.
> > 
> > Yes, I agree that we should have the nr_requested and nr_freed type of
> > counters in appropriate place. And "struct shrinker" is probably right
> > place for it.
> > 
> > Essentially you are suggesting that we maintain per cpu statistics
> > of 'requested to free'(scanned) slab objects and actual freed objects.
> > And this should be on per shrinkable cache basis.
> 
> Yep. 
> 
> > Is it ok to maintain this requested/freed counters as growing counters
> > or would it make more sense to have them reflect the statistics from
> > the latest/last attempt of cache shrink ? 
> 
> It makes a lot more sense to account for all shrink attempts: it is necessary
> to know how the reclaiming process is behaving over time. Thats why I wondered
> about using "=" instead of "+=" in your patch.
> 
> > And where would be right place to export this information ?
> > (/proc/slabinfo ?, since it already gives details of all caches)
> 
> My feeling is that changing /proc/slabinfo format might break userspace
> applications.
> 
> > If I understand correctly, "slabs_scanned" is the sum total number
> > of objects from all shrinkable caches scanned for possible freeeing.
> 
> Yep.
> 
> > I didn't get why this is part of page_state which mostly includes
> > page related statistics.
> 
> Well, page_state contains most of the reclaiming statistics - its scope
> is broader than "struct page" information.
> 
> To me it seems like the best place.
> 

Marcelo,

The attached patch is an attempt to break the "slabs_scanned" into
meaningful pieces as you suggested.

But I coudn't do this cleanly because kmem_cache_t isn't defined
in a .h file and I didn't want to touch too many files in the first
attempt.

What I am doing here is making the "requested to free" and
"actual freed" counters as part of struct shrinker. With this I can
update these statistics seamlessly from shrink_slab().

I don't have this as per cpu counters because I wasn't sure if shrink_slab()
would have many concurrent executions warranting a lockless percpu
counters for these.

I am displaying this information as part of /proc/slabinfo and I have
verified that it atleast isn't breaking slabtop.

I thought about having this as part of /proc/vmstat and using
mod_page_state infrastructure as u suggested, but having the
"requested to free" and "actual freed" counters in struct page_state
for only those caches which set the shrinker function didn't look
good.

If you think that all this can be done in a better way, please
let me know.

Regards,
Bharata.

--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cache_shrink_stats.patch"



Signed-off-by: Bharata B Rao <bharata@in.ibm.com>
---

 fs/dcache.c          |    4 +++-
 fs/dquot.c           |    4 +++-
 fs/inode.c           |    4 +++-
 include/linux/mm.h   |   15 ++++++++++++++-
 include/linux/slab.h |    3 +++
 mm/slab.c            |   14 ++++++++++++++
 mm/vmscan.c          |   19 +++++++------------
 7 files changed, 47 insertions(+), 16 deletions(-)

diff -puN mm/vmscan.c~cache_shrink_stats mm/vmscan.c
--- linux-2.6.14-rc2-shrink/mm/vmscan.c~cache_shrink_stats	2005-09-28 11:17:01.508944136 +0530
+++ linux-2.6.14-rc2-shrink-bharata/mm/vmscan.c	2005-09-28 17:18:57.799566152 +0530
@@ -84,17 +84,6 @@ struct scan_control {
 	int swap_cluster_max;
 };
 
-/*
- * The list of shrinker callbacks used by to apply pressure to
- * ageable caches.
- */
-struct shrinker {
-	shrinker_t		shrinker;
-	struct list_head	list;
-	int			seeks;	/* seeks to recreate an obj */
-	long			nr;	/* objs pending delete */
-};
-
 #define lru_to_page(_head) (list_entry((_head)->prev, struct page, lru))
 
 #ifdef ARCH_HAS_PREFETCH
@@ -146,6 +135,8 @@ struct shrinker *set_shrinker(int seeks,
 	        shrinker->shrinker = theshrinker;
 	        shrinker->seeks = seeks;
 	        shrinker->nr = 0;
+		atomic_set(&shrinker->nr_req, 0);
+		atomic_set(&shrinker->nr_freed, 0);
 	        down_write(&shrinker_rwsem);
 	        list_add_tail(&shrinker->list, &shrinker_list);
 	        up_write(&shrinker_rwsem);
@@ -221,9 +212,13 @@ static int shrink_slab(unsigned long sca
 			shrink_ret = (*shrinker->shrinker)(this_scan, gfp_mask);
 			if (shrink_ret == -1)
 				break;
-			if (shrink_ret < nr_before)
+			if (shrink_ret < nr_before) {
 				ret += nr_before - shrink_ret;
+				atomic_add(nr_before - shrink_ret,
+					&shrinker->nr_freed);
+			}
 			mod_page_state(slabs_scanned, this_scan);
+			atomic_add(this_scan, &shrinker->nr_req);
 			total_scan -= this_scan;
 
 			cond_resched();
diff -puN fs/inode.c~cache_shrink_stats fs/inode.c
--- linux-2.6.14-rc2-shrink/fs/inode.c~cache_shrink_stats	2005-09-28 11:25:58.000000000 +0530
+++ linux-2.6.14-rc2-shrink-bharata/fs/inode.c	2005-09-28 14:02:24.422431992 +0530
@@ -1357,11 +1357,13 @@ void __init inode_init_early(void)
 void __init inode_init(unsigned long mempages)
 {
 	int loop;
+	struct shrinker *shrinker;
 
 	/* inode slab cache */
 	inode_cachep = kmem_cache_create("inode_cache", sizeof(struct inode),
 				0, SLAB_RECLAIM_ACCOUNT|SLAB_PANIC, init_once, NULL);
-	set_shrinker(DEFAULT_SEEKS, shrink_icache_memory);
+	shrinker = set_shrinker(DEFAULT_SEEKS, shrink_icache_memory);
+	kmem_set_shrinker(inode_cachep, shrinker);
 
 	/* Hash may have been set up in inode_init_early */
 	if (!hashdist)
diff -puN fs/dquot.c~cache_shrink_stats fs/dquot.c
--- linux-2.6.14-rc2-shrink/fs/dquot.c~cache_shrink_stats	2005-09-28 11:28:51.000000000 +0530
+++ linux-2.6.14-rc2-shrink-bharata/fs/dquot.c	2005-09-28 14:06:13.197652872 +0530
@@ -1793,6 +1793,7 @@ static int __init dquot_init(void)
 {
 	int i;
 	unsigned long nr_hash, order;
+	struct shrinker *shrinker;
 
 	printk(KERN_NOTICE "VFS: Disk quotas %s\n", __DQUOT_VERSION__);
 
@@ -1824,7 +1825,8 @@ static int __init dquot_init(void)
 	printk("Dquot-cache hash table entries: %ld (order %ld, %ld bytes)\n",
 			nr_hash, order, (PAGE_SIZE << order));
 
-	set_shrinker(DEFAULT_SEEKS, shrink_dqcache_memory);
+	shrinker = set_shrinker(DEFAULT_SEEKS, shrink_dqcache_memory);
+	kmem_set_shrinker(dquot_cachep, shrinker);
 
 	return 0;
 }
diff -puN fs/dcache.c~cache_shrink_stats fs/dcache.c
--- linux-2.6.14-rc2-shrink/fs/dcache.c~cache_shrink_stats	2005-09-28 11:31:35.000000000 +0530
+++ linux-2.6.14-rc2-shrink-bharata/fs/dcache.c	2005-09-28 13:47:46.507895288 +0530
@@ -1668,6 +1668,7 @@ static void __init dcache_init_early(voi
 static void __init dcache_init(unsigned long mempages)
 {
 	int loop;
+	struct shrinker *shrinker;
 
 	/* 
 	 * A constructor could be added for stable state like the lists,
@@ -1680,7 +1681,8 @@ static void __init dcache_init(unsigned 
 					 SLAB_RECLAIM_ACCOUNT|SLAB_PANIC,
 					 NULL, NULL);
 	
-	set_shrinker(DEFAULT_SEEKS, shrink_dcache_memory);
+	shrinker = set_shrinker(DEFAULT_SEEKS, shrink_dcache_memory);
+	kmem_set_shrinker(dentry_cache, shrinker);
 
 	/* Hash may have been set up in dcache_init_early */
 	if (!hashdist)
diff -puN mm/slab.c~cache_shrink_stats mm/slab.c
--- linux-2.6.14-rc2-shrink/mm/slab.c~cache_shrink_stats	2005-09-28 11:40:00.285338264 +0530
+++ linux-2.6.14-rc2-shrink-bharata/mm/slab.c	2005-09-28 14:26:52.187297816 +0530
@@ -400,6 +400,9 @@ struct kmem_cache_s {
 	/* de-constructor func */
 	void (*dtor)(void *, kmem_cache_t *, unsigned long);
 
+	/* shrinker data for this cache */
+	struct shrinker *shrinker;
+
 /* 4) cache creation/removal */
 	const char		*name;
 	struct list_head	next;
@@ -3483,6 +3486,12 @@ static int s_show(struct seq_file *m, vo
 			allochit, allocmiss, freehit, freemiss);
 	}
 #endif
+	/* shrinker stats */
+	if (cachep->shrinker) {
+		seq_printf(m, " : shrinker stat %7lu %7lu",
+			atomic_read(&cachep->shrinker->nr_req),
+			atomic_read(&cachep->shrinker->nr_freed));
+	}
 	seq_putc(m, '\n');
 	spin_unlock_irq(&cachep->spinlock);
 	return 0;
@@ -3606,3 +3615,8 @@ char *kstrdup(const char *s, unsigned in
 	return buf;
 }
 EXPORT_SYMBOL(kstrdup);
+
+void kmem_set_shrinker(kmem_cache_t *cachep, struct shrinker *shrinker)
+{
+	cachep->shrinker = shrinker;
+}
diff -puN include/linux/mm.h~cache_shrink_stats include/linux/mm.h
--- linux-2.6.14-rc2-shrink/include/linux/mm.h~cache_shrink_stats	2005-09-28 12:41:09.664507840 +0530
+++ linux-2.6.14-rc2-shrink-bharata/include/linux/mm.h	2005-09-28 12:41:46.014981728 +0530
@@ -755,7 +755,20 @@ typedef int (*shrinker_t)(int nr_to_scan
  */
 
 #define DEFAULT_SEEKS 2
-struct shrinker;
+
+/*
+ * The list of shrinker callbacks used by to apply pressure to
+ * ageable caches.
+ */
+struct shrinker {
+	shrinker_t		shrinker;
+	struct list_head	list;
+	int			seeks;	/* seeks to recreate an obj */
+	long			nr;	/* objs pending delete */
+	atomic_t		nr_req; /* objs scanned for possible freeing */
+	atomic_t		nr_freed; /* actual number of objects freed */
+};
+
 extern struct shrinker *set_shrinker(int, shrinker_t);
 extern void remove_shrinker(struct shrinker *shrinker);
 
diff -puN include/linux/slab.h~cache_shrink_stats include/linux/slab.h
--- linux-2.6.14-rc2-shrink/include/linux/slab.h~cache_shrink_stats	2005-09-28 13:52:53.852171856 +0530
+++ linux-2.6.14-rc2-shrink-bharata/include/linux/slab.h	2005-09-28 14:07:42.127133536 +0530
@@ -147,6 +147,9 @@ extern kmem_cache_t	*bio_cachep;
 
 extern atomic_t slab_reclaim_pages;
 
+struct shrinker;
+extern void kmem_set_shrinker(kmem_cache_t *cachep, struct shrinker *shrinker);
+
 #endif	/* __KERNEL__ */
 
 #endif	/* _LINUX_SLAB_H */
_

--7AUc2qLy4jB3hD7Z--
