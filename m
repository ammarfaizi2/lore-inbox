Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262412AbVCIWb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262412AbVCIWb5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 17:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262084AbVCIWba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 17:31:30 -0500
Received: from dsl027-162-124.atl1.dsl.speakeasy.net ([216.27.162.124]:61844
	"EHLO kevlar.burdell.org") by vger.kernel.org with ESMTP
	id S262428AbVCIWNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 17:13:33 -0500
Date: Wed, 9 Mar 2005 16:57:40 -0500
From: Sonny Rao <sonny@burdell.org>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: Badari Pulavarty <pbadari@us.ibm.com>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Ext2-devel] Re: inode cache, dentry cache, buffer heads usage
Message-ID: <20050309215740.GA10757@kevlar.burdell.org>
References: <1110394558.24286.203.camel@dyn318077bld.beaverton.ibm.com> <20050309212732.GA5036@in.ibm.com> <1110403763.24286.213.camel@dyn318077bld.beaverton.ibm.com> <20050309215349.GD4663@in.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
In-Reply-To: <20050309215349.GD4663@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 10, 2005 at 03:23:49AM +0530, Dipankar Sarma wrote:
> On Wed, Mar 09, 2005 at 01:29:23PM -0800, Badari Pulavarty wrote:
> > On Wed, 2005-03-09 at 13:27, Dipankar Sarma wrote:
> > > On Wed, Mar 09, 2005 at 10:55:58AM -0800, Badari Pulavarty wrote:
> > > > Hi,
> > > > 
> > > > We have a 8-way P-III, 16GB RAM running 2.6.8-1. We use this as
> > > > our server to keep source code, cscopes and do the builds.
> > > > This machine seems to slow down over the time. One thing we
> > > > keep noticing is it keeps running out of lowmem. Most of 
> > > > the lowmem is used for ext3 inode cache + dentry cache +
> > > > bufferheads + Buffers. So we did 2:2 split - but it improved
> > > > thing, but again run into same issues.
> > > > 
> > > > So, why is these slab cache are not getting purged/shrinked even
> > > > under memory pressure ? (I have seen lowmem as low as 6MB). What
> > > > can I do to keep the machine healthy ?
> > > 
> > > How does /proc/sys/fs/dentry-state look when you run low on lowmem ?
> > 
> > 
> > 
> > badari@kernel:~$ cat /proc/sys/fs/dentry-state
> > 1434093 1348947 45      0       0       0
> > badari@kernel:~$ grep dentry /proc/slabinfo
> > dentry_cache      1434094 1857519    144   27    1 : tunables  120  
> > 60    8 : slabdata  68797  68797      0
> 
> Hmm.. so we are not shrinking dcache despite a large number of
> unsed dentries. That is where we need to look. Will dig a bit
> tomorrow.

Here's my really old patch where I saw some improvement for this scenario...

I haven't tried this in a really long time, so I have no idea if it'll
work :-) 


Sonny

--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.6.8-rc1-dcache-reclaim-rb.patch"

--- fs/dcache.c.original	2004-08-02 15:43:42.629539312 -0500
+++ fs/dcache.c	2004-08-03 18:16:45.007809144 -0500
@@ -31,6 +31,7 @@
 #include <linux/seqlock.h>
 #include <linux/swap.h>
 #include <linux/bootmem.h>
+#include <linux/rbtree.h>
 
 /* #define DCACHE_DEBUG 1 */
 
@@ -60,12 +61,61 @@ static unsigned int d_hash_mask;
 static unsigned int d_hash_shift;
 static struct hlist_head *dentry_hashtable;
 static LIST_HEAD(dentry_unused);
+static struct rb_root dentry_tree = RB_ROOT;
+
+#define RB_NONE (2)
+#define ON_RB(node)	((node)->rb_color != RB_NONE)
+#define RB_CLEAR(node)	((node)->rb_color = RB_NONE )
 
 /* Statistics gathering. */
 struct dentry_stat_t dentry_stat = {
 	.age_limit = 45,
 };
 
+
+/* take a dentry safely off the rbtree */
+static void drb_delete(struct dentry* dentry)
+{
+  //  printk("drb_delete: 0x%p (%s) proc %d\n",dentry,dentry->d_iname,smp_processor_id());
+	if (ON_RB(&dentry->d_rb)) {
+		rb_erase(&dentry->d_rb, &dentry_tree);
+		RB_CLEAR(&dentry->d_rb);
+	} else {
+		/* All allocated dentry objs should be in the tree */
+		BUG_ON(1);
+	}
+}
+
+static  
+struct dentry * drb_insert(struct dentry * dentry)
+{
+	struct rb_node ** p = &dentry_tree.rb_node;
+	struct rb_node * parent = NULL;
+	struct rb_node * node    = &dentry->d_rb;
+	struct dentry  * cur    = NULL;
+
+	//	printk("drb_insert: 0x%p (%s)\n",dentry,dentry->d_iname);
+
+	while (*p)
+	{
+		parent = *p;
+		cur = rb_entry(parent, struct dentry, d_rb);
+
+		if (dentry < cur)
+			p = &(*p)->rb_left;
+		else if (dentry > cur)
+			p = &(*p)->rb_right;
+		else {
+			return cur;
+		}
+	}
+
+	rb_link_node(node, parent, p);
+	rb_insert_color(node,&dentry_tree); 
+	return NULL;
+}
+
+
 static void d_callback(struct rcu_head *head)
 {
 	struct dentry * dentry = container_of(head, struct dentry, d_rcu);
@@ -189,6 +239,7 @@ kill_it: {
   		list_del(&dentry->d_child);
 		dentry_stat.nr_dentry--;	/* For d_free, below */
 		/*drops the locks, at that point nobody can reach this dentry */
+		drb_delete(dentry);
 		dentry_iput(dentry);
 		parent = dentry->d_parent;
 		d_free(dentry);
@@ -351,6 +402,7 @@ static inline void prune_one_dentry(stru
 	__d_drop(dentry);
 	list_del(&dentry->d_child);
 	dentry_stat.nr_dentry--;	/* For d_free, below */
+	drb_delete(dentry);
 	dentry_iput(dentry);
 	parent = dentry->d_parent;
 	d_free(dentry);
@@ -360,7 +412,7 @@ static inline void prune_one_dentry(stru
 }
 
 /**
- * prune_dcache - shrink the dcache
+ * prune_lru - shrink the lru list
  * @count: number of entries to try and free
  *
  * Shrink the dcache. This is done when we need
@@ -372,7 +424,7 @@ static inline void prune_one_dentry(stru
  * all the dentries are in use.
  */
  
-static void prune_dcache(int count)
+static void prune_lru(int count)
 {
 	spin_lock(&dcache_lock);
 	for (; count ; count--) {
@@ -410,6 +462,93 @@ static void prune_dcache(int count)
 	spin_unlock(&dcache_lock);
 }
 
+/**
+ * prune_dcache - try and "intelligently" shrink the dcache
+ * @requested - num of dentrys to try and free
+ *
+ * The basic strategy here is to scan through our tree of dentrys
+ * in-order and put them at the end of the lru - free list
+ * Why in-order?  Because, we want the chances of actually freeing
+ * all 15-27 (depending on arch) dentrys on a given page, instead
+ * of just in random lru order, which tends to lower dcache utilization
+ * and not free many pages.
+ */
+static void prune_dcache(unsigned  requested)
+{
+	/* ------ debug --------- */
+	//static int mod = 0;
+	//int flag = 0, removed = 0;
+	/* ------ debug --------- */
+
+	unsigned found = 0;
+	unsigned count;
+	struct rb_node * next;
+	struct dentry *dentry;
+#define NUM_LRU_PTRS 8
+	struct rb_node *lru_ptrs[NUM_LRU_PTRS];
+	struct list_head *cur;
+	int i;
+
+	spin_lock(&dcache_lock);
+	
+       	cur = dentry_unused.prev;
+
+	/* grab NUM_LRU_PTRS entrys off the end of lru list */
+	/* we'll use these as pseudo-random starting points in the tree */
+	for (i = 0 ; i < NUM_LRU_PTRS ; i++ ){
+		if ( cur == &dentry_unused ) {
+			/* if there aren't NUM_LRU_PTRS entrys, we probably
+			   can't even free a page now, give up */
+			spin_unlock(&dcache_lock);
+			return;
+		}
+		lru_ptrs[i] = &(list_entry(cur,struct dentry, d_lru)->d_rb); 
+		cur = cur->prev;
+	}
+	
+	i = 0;
+	
+	do {
+		count = 4 * PAGE_SIZE / sizeof(struct dentry) ; /* abitrary heuristic */
+		next = lru_ptrs[i];
+		for (; count ; count--) {
+			if( ! next ) {
+				//flag = 1;  /* ------ debug --------- */
+				break;
+			}
+			dentry = list_entry(next, struct dentry, d_rb);
+			next = rb_next(next);
+			prefetch(next);
+			if( ! list_empty( &dentry->d_lru) ) {
+				list_del_init(&dentry->d_lru);
+				dentry_stat.nr_unused--;
+			}
+			if (atomic_read(&dentry->d_count)) {
+				//removed++; 	/* ------ debug --------- */
+				continue;
+			} else {
+				list_add_tail(&dentry->d_lru, &dentry_unused);
+				dentry_stat.nr_unused++;
+				found++;
+			}
+		}
+		i++;
+	} while ( (found < requested / 2) && (i < NUM_LRU_PTRS ) );
+#undef NUM_LRU_PTRS
+
+	spin_unlock(&dcache_lock);
+	
+	/* ------ debug --------- */
+	//mod++;	
+	//if ( ! (mod & 64) ) {
+	//	mod = 0;
+	//	printk("prune_dcache: i %d flag %d, found %d removed %d\n",i,flag,found,removed);
+	//}
+	/* ------ debug --------- */
+
+	prune_lru(found);
+}
+
 /*
  * Shrink the dcache for the specified super block.
  * This allows us to unmount a device without disturbing
@@ -604,7 +743,7 @@ void shrink_dcache_parent(struct dentry 
 	int found;
 
 	while ((found = select_parent(parent)) != 0)
-		prune_dcache(found);
+		prune_lru(found);
 }
 
 /**
@@ -642,7 +781,7 @@ void shrink_dcache_anon(struct hlist_hea
 			}
 		}
 		spin_unlock(&dcache_lock);
-		prune_dcache(found);
+		prune_lru(found);
 	} while(found);
 }
 
@@ -730,6 +869,7 @@ struct dentry *d_alloc(struct dentry * p
 	if (parent)
 		list_add(&dentry->d_child, &parent->d_subdirs);
 	dentry_stat.nr_dentry++;
+	drb_insert(dentry);
 	spin_unlock(&dcache_lock);
 
 	return dentry;
--- include/linux/dcache.h.original	2004-08-03 18:20:40.800963136 -0500
+++ include/linux/dcache.h	2004-08-02 15:36:19.886846432 -0500
@@ -9,6 +9,7 @@
 #include <linux/cache.h>
 #include <linux/rcupdate.h>
 #include <asm/bug.h>
+#include <linux/rbtree.h>
 
 struct nameidata;
 struct vfsmount;
@@ -94,6 +95,7 @@ struct dentry {
 	struct hlist_head *d_bucket;	/* lookup hash bucket */
 	struct qstr d_name;
 
+	struct rb_node   d_rb;
 	struct list_head d_lru;		/* LRU list */
 	struct list_head d_child;	/* child of parent list */
 	struct list_head d_subdirs;	/* our children */

--ew6BAiZeqk4r7MaW--
