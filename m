Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262868AbTC1K0y>; Fri, 28 Mar 2003 05:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262872AbTC1K0x>; Fri, 28 Mar 2003 05:26:53 -0500
Received: from bi-01pt1.bluebird.ibm.com ([129.42.208.186]:2700 "EHLO
	bigbang.in.ibm.com") by vger.kernel.org with ESMTP
	id <S262868AbTC1K0u>; Fri, 28 Mar 2003 05:26:50 -0500
Date: Fri, 28 Mar 2003 16:10:43 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Dipankar Sarma <dipankar@in.ibm.com>,
       Paul McKenney <Paul.McKenney@us.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] real_lookup fix
Message-ID: <20030328104043.GA1127@in.ibm.com>
Reply-To: maneesh@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Here is a patch to use seqlock for real_lookup race with d_lookup as suggested
by Linus. The race condition can result in duplicate dentry when d_lookup
fails due concurrent d_move in some unrelated directory. 

Apart from real_lookup, lookup_hash()->cached_lookup() can also fail due
to same reason. So, for that I am doing the d_lookup again.

Now we have __d_lookup (called from do_lookup() during pathwalk) and
d_lookup which uses seqlock to protect againt rename race.

dcachebench numbers (lower is better) don't have much difference on a 4-way
PIII xeon SMP box.

base-2565
Average usec/iteration  19059.4
Standard Deviation      503.07

base-2565 + seq_lock
Average usec/iteration  18843.2
Standard Deviation      450.57


The patch is against 2.5.66. 

diff -urN linux-2.5.66-base/fs/dcache.c linux-2.5.66-real_lookup/fs/dcache.c
--- linux-2.5.66-base/fs/dcache.c	Tue Mar 25 03:30:02 2003
+++ linux-2.5.66-real_lookup/fs/dcache.c	Fri Mar 28 10:07:36 2003
@@ -27,12 +27,14 @@
 #include <linux/file.h>
 #include <asm/uaccess.h>
 #include <linux/security.h>
+#include <linux/seqlock.h>
 
 #define DCACHE_PARANOIA 1
 /* #define DCACHE_DEBUG 1 */
 
 spinlock_t dcache_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 rwlock_t dparent_lock __cacheline_aligned_in_smp = RW_LOCK_UNLOCKED;
+seqlock_t rename_lock __cacheline_aligned_in_smp = SEQLOCK_UNLOCKED;
 
 static kmem_cache_t *dentry_cache; 
 
@@ -926,7 +928,7 @@
  * is returned. The caller must use d_put to free the entry when it has
  * finished using it. %NULL is returned on failure.
  *
- * d_lookup is now, dcache_lock free. The hash list is protected using RCU.
+ * __d_lookup is dcache_lock free. The hash list is protected using RCU.
  * Memory barriers are used while updating and doing lockless traversal. 
  * To avoid races with d_move while rename is happening, d_move_count is 
  * used. 
@@ -939,10 +941,27 @@
  *
  * d_lru list is not updated, which can leave non-zero d_count dentries
  * around in d_lru list.
+ *
+ * d_lookup() is protected against the concurrent renames in some unrelated
+ * directory using the seqlockt_t rename_lock.
  */
 
 struct dentry * d_lookup(struct dentry * parent, struct qstr * name)
 {
+	struct dentry * dentry = NULL;
+	unsigned long seq;
+
+        do {
+                seq = read_seqbegin(&rename_lock);
+                dentry = __d_lookup(parent, name);
+                if (dentry)
+			break;
+	} while (read_seqretry(&rename_lock, seq));
+	return dentry;
+}
+
+struct dentry * __d_lookup(struct dentry * parent, struct qstr * name)
+{
 	unsigned int len = name->len;
 	unsigned int hash = name->hash;
 	const unsigned char *str = name->name;
@@ -1185,6 +1204,7 @@
 		printk(KERN_WARNING "VFS: moving negative dcache entry\n");
 
 	spin_lock(&dcache_lock);
+	write_seqlock(&rename_lock);
 	spin_lock(&dentry->d_lock);
 
 	/* Move the dentry to the target hash queue, if on different bucket */
@@ -1222,6 +1242,7 @@
 	list_add(&dentry->d_child, &dentry->d_parent->d_subdirs);
 	dentry->d_move_count++;
 	spin_unlock(&dentry->d_lock);
+	write_sequnlock(&rename_lock);
 	spin_unlock(&dcache_lock);
 }
 
diff -urN linux-2.5.66-base/fs/namei.c linux-2.5.66-real_lookup/fs/namei.c
--- linux-2.5.66-base/fs/namei.c	Tue Mar 25 03:30:16 2003
+++ linux-2.5.66-real_lookup/fs/namei.c	Fri Mar 28 10:16:18 2003
@@ -275,8 +275,14 @@
  */
 static struct dentry * cached_lookup(struct dentry * parent, struct qstr * name, int flags)
 {
-	struct dentry * dentry = d_lookup(parent, name);
-	
+	struct dentry * dentry = __d_lookup(parent, name);
+
+	/* lockess __d_lookup may fail due to concurrent d_move() 
+	 * in some unrelated directory, so try with d_lookup
+	 */
+	if (!dentry)
+		dentry = d_lookup(parent, name);
+
 	if (dentry && dentry->d_op && dentry->d_op->d_revalidate) {
 		if (!dentry->d_op->d_revalidate(dentry, flags) && !d_invalidate(dentry)) {
 			dput(dentry);
@@ -348,12 +354,9 @@
 	 * negatives from the RCU list walk here, unlike the optimistic
 	 * fast walk).
 	 *
-	 * We really should do a sequence number thing to avoid this
-	 * all.
+	 * so doing d_lookup() (with seqlock), instead of lockfree __d_lookup
 	 */
-	spin_lock(&dcache_lock);
 	result = d_lookup(parent, name);
-	spin_unlock(&dcache_lock);
 	if (!result) {
 		struct dentry * dentry = d_alloc(parent, name);
 		result = ERR_PTR(-ENOMEM);
@@ -524,7 +527,7 @@
 		     struct path *path, int flags)
 {
 	struct vfsmount *mnt = nd->mnt;
-	struct dentry *dentry = d_lookup(nd->dentry, name);
+	struct dentry *dentry = __d_lookup(nd->dentry, name);
 
 	if (!dentry)
 		goto need_lookup;
diff -urN linux-2.5.66-base/include/linux/dcache.h linux-2.5.66-real_lookup/include/linux/dcache.h
--- linux-2.5.66-base/include/linux/dcache.h	Tue Mar 25 03:31:48 2003
+++ linux-2.5.66-real_lookup/include/linux/dcache.h	Fri Mar 28 09:56:51 2003
@@ -238,6 +238,7 @@
 
 /* appendix may either be NULL or be used for transname suffixes */
 extern struct dentry * d_lookup(struct dentry *, struct qstr *);
+extern struct dentry * __d_lookup(struct dentry *, struct qstr *);
 
 /* validate "insecure" dentry pointer */
 extern int d_validate(struct dentry *, struct dentry *);


-- 
Maneesh Soni
IBM Linux Technology Center, 
IBM India Software Lab, Bangalore.
Phone: +91-80-5044999 email: maneesh@in.ibm.com
http://lse.sourceforge.net/
