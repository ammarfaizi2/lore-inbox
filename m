Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265109AbUETNdb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265109AbUETNdb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 09:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265148AbUETNdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 09:33:31 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:52964 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265109AbUETNdI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 09:33:08 -0400
Date: Thu, 20 May 2004 19:04:10 +0530
From: Raghavan <raghav@in.ibm.com>
To: "Jose R. Santos" <jrsantos@austin.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dentry and inode cache hash algorithm performance changes.
Message-ID: <20040520133410.GA13522@in.ibm.com>
Reply-To: raghav@in.ibm.com
References: <20040430195504.GE14271@rx8.ibm.com> <8765bg4af9.fsf@goat.bogus.local> <20040501150857.GA17778@austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
In-Reply-To: <20040501150857.GA17778@austin.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jose,

Did u try the new hashing algorithm with dcache bench?
dcachebench is focussed entirely on dcache performance.
I had measured the performance of the dcachebench on
2.6.6 kernel  with and without the new hashing algorithm
and noticed significant decrease in performance with the
new hash algorithm.  Enclosed is the mail from LKML that dicusses
this.

Also I wrote an instrumentation patch that measures the
number of clock cycles spent by the hash and lookup.
The hash time saw an increase(obviously) but I did see an
increase in the time spent in the lookup function too.
Attached is the patch I used for the instrumentation.

Thanks and Regards
Raghav

On Sat, May 01, 2004 at 10:08:57AM -0500, Jose R. Santos wrote:
> * Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de> [2004-05-01 14:08:26 +0200]:
> > Judging from the graphs (!), I don't see a real difference for
> > dcache. There's just one outlier (depth 11) for the old hash function,
> > which seems to be translated to multiple depth 9 entries. The
> > histograms seem to confirm, that there's at most a minimal difference,
> > if they'd be equally scaled.
> > 
> > Maybe this is due to qstr hashes, which were used by both approaches
> > as input?
> 
> SpecSFS is not really the best benchmark to show the efficiency of the
> dentry hash function.  I need to come up with a better defense for the
> this hash functions.  While I did not do the study for this hash
> function, mathematically speaking this hash algorithm should always
> create a equal or better hash.  SFS just shows equal (well, slightly
> better), so Ill work on getting some more data to back up the "better"
> claim.
> 
> > The inode hash seems to be distributed more evenly with the new hash
> > function. Although the inode histogram suggests, that most buckets are
> > in the 0-2 depth range, with the old hash function leading slightly in
> > the zero depth range.
> 
> Thats a good thing.  With the new hash function, we get 25% more bucket
> usage and most of the bucket are only 1 object deep.  This buckets take
> up memory so we better use them.   The old hash functions was no very
> efficient in spreading the hashes across all the buckets, with the new
> hash function we have 4.5 times more buckets with only 1 object deep so
> it scales better as we increase the number of buckets as well.
> 
> It also provides a 3% improvement on the overall SFS number with half
> the number of buckets use which I believe its a great improvement from 
> just a hash algorithm change.
> 
> -JRS
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=original_mail



On Fri, 14 May 2004, Dipankar Sarma wrote:
> > 
> > 2.6.6                       10280             110
> > 
> > 2.6.6-bk                    10862             30
> 
> > To find out if the huge performance dip between the 2.6.6
> > and 2.6.6-bk is because of the hash changes, I removed the hash patch
> > from 2.6.6-bk and applied it to 2.6.6.
> > 
> > 2.6.6-bk with old hash      10685             34
> > 
> > 2.6.6 with new hash         10496             125
> > 
> > Looks like the new hashing function has brought down the performance.
> > Also some code outside dcache.c and inode.c seems to have pushed down
> > the performance in 2.6.6-bk.
> 
> OK, I am confused. These numbers show that the new hash function
> is better.

No, look again.

			old hash		new hash
	
	2.6.6:		10280			10496
	2.6.6-bk:	10685			10862

in both cases, the new hash makes each iteration about ~200us (or whatever 
the metric is) slower.

There's something _else_ going on too, since plain 2.6.6 is so clearly 
better than the others. I don't know why - the only thing -bk does is the 
hash change and some changes to GFP_NOFS behaviour (different return value 
from shrink_dentries or whatever). Which shouldn't even trigger, I'd have 
assumed this is all cached.

NOTE! Just "simple" things like variations in I$ layout of the kernel code 
can make a pretty big difference if you're unlucky. And the new dentry 
code doesn't align the things on a D$ cache line boundary, so there could 
easily be "consistent" differences from that - just from the order of 
dentries allocated etc.

But it's interesting to note that the hash does make a difference. The old 
hash was very much optimized for simplicity (those hash-calculation 
routines are some of the hottest in the kernel). But I don't see that a 
few extra instructions should make that big of a difference.

		Linus


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch

--- linux-2.6.6.orig/fs/dcache.c	2004-05-10 08:02:01.000000000 +0530
+++ linux-2.6.6/fs/dcache.c	2004-05-20 18:07:37.000000000 +0530
@@ -21,6 +21,7 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/smp_lock.h>
+#include <linux/hash.h>
 #include <linux/cache.h>
 #include <linux/module.h>
 #include <linux/mount.h>
@@ -40,6 +41,19 @@ EXPORT_SYMBOL(dcache_lock);
 
 static kmem_cache_t *dentry_cache; 
 
+//#define OLD_HASH
+#define DB
+
+#ifdef DB
+#include <asm/processor.h>
+#include <asm/msr.h>
+#include <asm/e820.h>
+unsigned long  d_hash_count, d_lookup_count;
+unsigned long d_hash_misses, d_lookup_misses;
+unsigned long d_hash_overflow, d_lookup_overflow;
+unsigned long hash_array[250], lookup_array[500];
+#endif
+
 /*
  * This is the single most critical data structure when it comes
  * to the dcache: the hashtable for lookups. Somebody should try
@@ -643,24 +657,23 @@ void shrink_dcache_anon(struct hlist_hea
 }
 
 /*
- * This is called from kswapd when we think we need some more memory.
+ * Scan `nr' dentries and return the number which remain.
+ *
+ * We need to avoid reentering the filesystem if the caller is performing a
+ * GFP_NOFS allocation attempt.  One example deadlock is:
+ *
+ * ext2_new_block->getblk->GFP->shrink_dcache_memory->prune_dcache->
+ * prune_one_dentry->dput->dentry_iput->iput->inode->i_sb->s_op->put_inode->
+ * ext2_discard_prealloc->ext2_free_blocks->lock_super->DEADLOCK.
+ *
+ * In this case we return -1 to tell the caller that we baled.
  */
 static int shrink_dcache_memory(int nr, unsigned int gfp_mask)
 {
 	if (nr) {
-		/*
-		 * Nasty deadlock avoidance.
-		 *
-	 	 * ext2_new_block->getblk->GFP->shrink_dcache_memory->
-		 * prune_dcache->prune_one_dentry->dput->dentry_iput->iput->
-		 * inode->i_sb->s_op->put_inode->ext2_discard_prealloc->
-		 * ext2_free_blocks->lock_super->DEADLOCK.
-	 	 *
-	 	 * We should make sure we don't hold the superblock lock over
-	 	 * block allocations, but for now:
-		 */
-		if (gfp_mask & __GFP_FS)
-			prune_dcache(nr);
+		if (!(gfp_mask & __GFP_FS))
+			return -1;
+		prune_dcache(nr);
 	}
 	return dentry_stat.nr_unused;
 }
@@ -795,11 +808,45 @@ struct dentry * d_alloc_root(struct inod
 	return res;
 }
 
-static inline struct hlist_head * d_hash(struct dentry * parent, unsigned long hash)
+static inline struct hlist_head *d_hash(struct dentry *parent,
+					unsigned long hash)
 {
+#ifdef DB
+        unsigned long long t1=0,t2=0;
+        preempt_disable();
+        rdtscll(t1);
+#endif
+
+#ifdef OLD_HASH
 	hash += (unsigned long) parent / L1_CACHE_BYTES;
 	hash = hash ^ (hash >> D_HASHBITS);
+#else
+	hash += ((unsigned long) parent ^ GOLDEN_RATIO_PRIME) / L1_CACHE_BYTES;
+	hash = hash ^ ((hash ^ GOLDEN_RATIO_PRIME) >> D_HASHBITS);
+#endif
+
+#ifndef DB
 	return dentry_hashtable + (hash & D_HASHMASK);
+#else
+        rdtscll(t2);
+        preempt_enable();
+
+        if( d_hash_count < 0xffffffff )
+        {
+                if( (t2 > t1) && ( (t2 - t1) >= 0  ) && ((t2 - t1) < 5000))
+                {
+                        unsigned int c =  ((unsigned int)(t2 - t1)) /20;
+                        hash_array[c]++;
+                }
+                else
+                        d_hash_misses++;
+                d_hash_count++;
+        }
+        else d_hash_overflow++;
+
+        return dentry_hashtable + (hash & D_HASHMASK);
+#endif
+
 }
 
 /**
@@ -970,6 +1017,12 @@ struct dentry * __d_lookup(struct dentry
 	struct dentry *found = NULL;
 	struct hlist_node *node;
 
+#ifdef DB
+        unsigned long long t1=0,t2=0;
+        preempt_disable();
+        rdtscll(t1);
+#endif
+
 	rcu_read_lock();
 	
 	hlist_for_each (node, head) { 
@@ -1023,6 +1076,25 @@ struct dentry * __d_lookup(struct dentry
 		break;
  	}
  	rcu_read_unlock();
+#ifdef DB
+        rdtscll(t2);
+        preempt_enable();
+
+        if( d_lookup_count < 0xffffffff )
+        {
+                if( (t2 > t1) && ( (t2 - t1) >= 0  ) && ((t2 - t1) < 10000))
+                {
+                        unsigned int c =  ((unsigned int)(t2 - t1)) /20;
+                        lookup_array[c]++;
+                }
+                else
+                        d_lookup_misses++;
+                d_lookup_count++;
+        }
+        else d_lookup_overflow++;
+
+#endif
+
 
  	return found;
 }
--- linux-2.6.6.orig/fs/inode.c	2004-05-10 08:03:21.000000000 +0530
+++ linux-2.6.6/fs/inode.c	2004-05-20 18:07:24.000000000 +0530
@@ -32,6 +32,20 @@
  */
 #include <linux/buffer_head.h>
 
+#define OLD_HASH
+
+#define DB
+
+#ifdef DB
+#include <asm/processor.h>
+#include <asm/msr.h>
+#include <asm/e820.h>
+unsigned long  i_hash_count, i_lookup_count;
+unsigned long i_hash_misses, i_lookup_misses;
+unsigned long i_hash_overflow, i_lookup_overflow;
+unsigned long i_hash_array[250], i_lookup_array[500];
+#endif
+
 /*
  * New inode.c implementation.
  *
@@ -490,6 +504,12 @@ static struct inode * find_inode(struct 
 	struct hlist_node *node;
 	struct inode * inode = NULL;
 
+#ifdef DB
+        unsigned long long t1=0,t2=0;
+        preempt_disable();
+        rdtscll(t1);
+#endif
+
 repeat:
 	hlist_for_each (node, head) { 
 		inode = hlist_entry(node, struct inode, i_hash);
@@ -503,6 +523,24 @@ repeat:
 		}
 		break;
 	}
+#ifdef DB
+        rdtscll(t2);
+        preempt_enable();
+
+        if( i_lookup_count < 0xffffffff )
+        {
+                if( (t2 > t1) && ( (t2 - t1) >= 0  ) && ((t2 - t1) < 10000))
+                {
+                        unsigned int c =  ((unsigned int)(t2 - t1)) /20;
+                        i_lookup_array[c]++;
+                }
+                else
+                        i_lookup_misses++;
+                i_lookup_count++;
+        }
+        else i_lookup_overflow++;
+#endif
+
 	return node ? inode : NULL;
 }
 
@@ -515,6 +553,12 @@ static struct inode * find_inode_fast(st
 	struct hlist_node *node;
 	struct inode * inode = NULL;
 
+#ifdef DB
+        unsigned long long t1=0,t2=0;
+        preempt_disable();
+        rdtscll(t1);
+#endif
+
 repeat:
 	hlist_for_each (node, head) {
 		inode = hlist_entry(node, struct inode, i_hash);
@@ -528,6 +572,23 @@ repeat:
 		}
 		break;
 	}
+#ifdef DB
+        rdtscll(t2);
+        preempt_enable();
+
+        if( i_lookup_count < 0xffffffff )
+        {
+                if( (t2 > t1) && ( (t2 - t1) >= 0  ) && ((t2 - t1) < 10000))
+                {
+                        unsigned int c =  ((unsigned int)(t2 - t1)) /20;
+                        i_lookup_array[c]++;
+                }
+                else
+                        i_lookup_misses++;
+                i_lookup_count++;
+        }
+        else i_lookup_overflow++;
+#endif
 	return node ? inode : NULL;
 }
 
@@ -671,12 +732,46 @@ static struct inode * get_new_inode_fast
 
 static inline unsigned long hash(struct super_block *sb, unsigned long hashval)
 {
-	unsigned long tmp = hashval + ((unsigned long) sb / L1_CACHE_BYTES);
+	unsigned long tmp;
+
+#ifdef DB
+        unsigned long long t1=0,t2=0;
+        preempt_disable();
+        rdtscll(t1);
+#endif
+
+#ifdef OLD_HASH
+	tmp = hashval + ((unsigned long) sb / L1_CACHE_BYTES);
 	tmp = tmp + (tmp >> I_HASHBITS);
+#else
+	tmp = (hashval * (unsigned long)sb) ^ (GOLDEN_RATIO_PRIME + hashval) /
+			L1_CACHE_BYTES;
+	tmp = tmp ^ ((tmp ^ GOLDEN_RATIO_PRIME) >> I_HASHBITS);
+#endif
+
+#ifndef DB
+	return tmp & I_HASHMASK;
+#else
+        rdtscll(t2);
+	preempt_enable();
+
+	if( i_hash_count < 0xffffffff )
+	{
+        	if( (t2 > t1) && ( (t2 - t1) >= 0  ) && ((t2 - t1) < 5000))
+		{
+       			unsigned int c =  ((unsigned int)(t2 - t1)) /20;
+			i_hash_array[c]++;
+		}
+		else
+			i_hash_misses++;
+		i_hash_count++;
+	}
+	else i_hash_overflow++;
+
 	return tmp & I_HASHMASK;
-}
 
-/* Yeah, I know about quadratic hash. Maybe, later. */
+#endif
+}
 
 /**
  *	iunique - get a unique inode number
--- linux-2.6.6.orig/fs/proc/proc_misc.c	2004-05-10 08:02:01.000000000 +0530
+++ linux-2.6.6/fs/proc/proc_misc.c	2004-05-20 18:07:51.000000000 +0530
@@ -51,6 +51,18 @@
 #include <asm/tlb.h>
 #include <asm/div64.h>
 
+#define DB
+#ifdef DB
+extern unsigned long  d_hash_average, d_hash_count, d_lookup_average, d_lookup_count;
+extern unsigned long d_hash_misses, d_lookup_misses;
+extern unsigned long d_hash_overflow, d_lookup_overflow;
+extern unsigned long hash_array[250], lookup_array[500];
+extern unsigned long  i_hash_average, i_hash_count, i_lookup_average, i_lookup_count;
+extern unsigned long i_hash_misses, i_lookup_misses;
+extern unsigned long i_hash_overflow, i_lookup_overflow;
+extern unsigned long i_hash_array[250], i_lookup_array[500];
+#endif
+
 #define LOAD_INT(x) ((x) >> FSHIFT)
 #define LOAD_FRAC(x) LOAD_INT(((x) & (FIXED_1-1)) * 100)
 /*
@@ -134,6 +146,85 @@ static struct vmalloc_info get_vmalloc_i
 	return vmi;
 }
 
+#ifdef DB
+static int proc_read_dcache_hash(char *page, char **start, off_t off,
+				 int count, int *eof, void *data)
+{
+	unsigned int i=0;
+	int len=0;
+
+
+  
+	len = sprintf(page + len, "\ndcache Hash statistics: \n");
+	
+	for(i=0; i < 250; i++)
+		len += sprintf(page + len, "%lu ", hash_array[i]);
+
+	len += sprintf(page + len, " \n");
+
+	len += sprintf(page + len, "misses:%lu overflow:%lu \n \n",d_hash_misses, d_hash_overflow);
+
+	return proc_calc_metrics(page, start, off, count, eof, len);
+
+}
+
+static int proc_read_dcache_lookup(char *page, char **start, off_t off,
+				 int count, int *eof, void *data)
+{
+	unsigned int i=0;
+	int len=0;
+	
+	len += sprintf(page + len, "\ndcache lookup statistics: \n");
+
+	for(i=0; i < 500; i++)
+		len += sprintf(page + len, "%lu ", lookup_array[i]);
+
+	len += sprintf(page + len, " \n");
+
+	len += sprintf(page + len, "misses:%lu overflow:%lu \n \n",d_lookup_misses, d_lookup_overflow);
+
+	return proc_calc_metrics(page, start, off, count, eof, len);
+}
+	
+
+static int proc_read_inode_hash(char *page, char **start, off_t off,
+				 int count, int *eof, void *data)
+{
+	unsigned int i=0;
+	int len=0;
+
+	len = sprintf(page + len, "\ninode Hash statistics: \n");
+
+	for(i=0; i < 250; i++)
+		len += sprintf(page + len, "%lu ", i_hash_array[i]);
+
+	len += sprintf(page + len, " \n");
+
+	len += sprintf(page + len, "misses:%lu overflow:%lu \n \n",i_hash_misses, i_hash_overflow);
+
+	return proc_calc_metrics(page, start, off, count, eof, len);
+}
+
+static int proc_read_inode_lookup(char *page, char **start, off_t off,
+				 int count, int *eof, void *data)
+{
+	unsigned int i=0;
+	int len=0;
+
+	len = sprintf(page + len, "\ninode lookup statistics: \n");
+
+	for(i=0; i < 500; i++)
+		len += sprintf(page + len, "%lu ", i_lookup_array[i]);
+
+	len += sprintf(page + len, " \n");
+
+	len += sprintf(page + len, "misses:%lu overflow:%lu \n \n",i_lookup_misses, i_lookup_overflow);
+
+	return proc_calc_metrics(page, start, off, count, eof, len);
+}
+#endif
+
+
 static int uptime_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
@@ -150,6 +241,7 @@ static int uptime_read_proc(char *page, 
 			(unsigned long) idle.tv_sec,
 			(idle.tv_nsec / (NSEC_PER_SEC / 100)));
 
+
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
 
@@ -651,6 +743,7 @@ static void create_seq_entry(char *name,
 		entry->proc_fops = f;
 }
 
+
 void __init proc_misc_init(void)
 {
 	struct proc_dir_entry *entry;
@@ -675,6 +768,12 @@ void __init proc_misc_init(void)
 		{"rtc",		ds1286_read_proc},
 #endif
 		{"locks",	locks_read_proc},
+#ifdef DB
+		{"dcache_hash",	proc_read_dcache_hash},
+		{"dcache_lookup",	proc_read_dcache_lookup},
+		{"inode_hash",	proc_read_inode_hash},
+		{"inode_lookup",	proc_read_inode_lookup},
+#endif
 		{"execdomains",	execdomains_read_proc},
 		{NULL,}
 	};

--6c2NcOVqGQ03X4Wi--
