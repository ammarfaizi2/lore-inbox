Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316838AbSGLUgO>; Fri, 12 Jul 2002 16:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316849AbSGLUgM>; Fri, 12 Jul 2002 16:36:12 -0400
Received: from gateway2.ensim.com ([65.164.64.250]:57860 "EHLO
	nasdaq.ms.ensim.com") by vger.kernel.org with ESMTP
	id <S316838AbSGLUgK>; Fri, 12 Jul 2002 16:36:10 -0400
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Paul Menage <pmenage@ensim.com>
To: viro@math.psu.edu, linux-kernel@vger.kernel.org
cc: pmenage@ensim.com
Subject: [RFC] Rearranging struct dentry for cache affinity
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 12 Jul 2002 13:38:35 -0700
Message-Id: <E17T7BT-0006zT-00@pmenage-dt.ensim.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's a patch that reorganises struct dentry to try to improve the 
cache behaviour. Main changes:

- try to separate out volatile data from constant or rarely-changing
data. On a 32-bit system with 64 byte cacheline, the first cacheline is
used for the refcounting/lru data and the "less-referenced" data, mainly
used by remote and exported filesystems. The second cacheline is used 
for mostly read-only data.

- for systems where cacheline size = 4 * word size, keep all the data
needed for checking a non-matching dcache hash entry (modulo
hash-collisions) in one cacheline. 

- on SMP systems, only set the DCACHE_REFERENCED bit in d_vfs_flags if 
it wasn't already set.

Al, would you have any interest in a patch like this, if it has a
noticeable performance effect? If so, I'll put some performance figures
together.

Paul

diff -X /mnt/elbrus/home/pmenage/dontdiff -Naur linux-2.5.25/fs/dcache.c linux-2.5.25-dentry/fs/dcache.c
--- linux-2.5.25/fs/dcache.c	Tue Jun 18 19:11:48 2002
+++ linux-2.5.25-dentry/fs/dcache.c	Fri Jul 12 12:56:07 2002
@@ -707,7 +707,7 @@
 	struct dentry *res = NULL;
 
 	if (root_inode) {
-		res = d_alloc(NULL, &(const struct qstr) { "/", 1, 0 });
+		res = d_alloc(NULL, &(const struct qstr) { name: "/", len: 1});
 		if (res) {
 			res->d_sb = root_inode->i_sb;
 			res->d_parent = res;
@@ -754,7 +754,7 @@
 		return res;
 	}
 
-	tmp = d_alloc(NULL, &(const struct qstr) {"",0,0});
+	tmp = d_alloc(NULL, &(const struct qstr) { });
 	if (!tmp)
 		return NULL;
 
@@ -883,7 +883,10 @@
 			if (memcmp(dentry->d_name.name, str, len))
 				continue;
 		}
-		dentry->d_vfs_flags |= DCACHE_REFERENCED;
+#ifdef CONFIG_SMP
+		if(!(dentry->d_vfs_flags & DCACHE_REFERENCED))
+#endif
+			dentry->d_vfs_flags |= DCACHE_REFERENCED;
 		return dentry;
 	}
 	return NULL;
diff -X /mnt/elbrus/home/pmenage/dontdiff -Naur linux-2.5.25/include/linux/dcache.h linux-2.5.25-dentry/include/linux/dcache.h
--- linux-2.5.25/include/linux/dcache.h	Tue Jun 18 19:11:59 2002
+++ linux-2.5.25-dentry/include/linux/dcache.h	Fri Jul 12 13:13:04 2002
@@ -22,12 +22,15 @@
 
 /*
  * "quick string" -- eases parameter passing, but more importantly
- * saves "metadata" about the string (ie length and the hash).
+ * saves "metadata" about the string (ie length and the hash).  
+ *
+ * "hash" comes first to keep it in the same cacheline as "d_hash" and
+ * "d_parent" for systems where a cacheline is 4 words.
  */
 struct qstr {
-	const unsigned char * name;
-	unsigned int len;
 	unsigned int hash;
+	unsigned int len;
+	const unsigned char * name;
 };
 
 struct dentry_stat_t {
@@ -67,23 +70,45 @@
 #define DNAME_INLINE_LEN 16
 
 struct dentry {
-	atomic_t d_count;
+	/* First cacheline(s): data that changes frequently and is referenced often */
+
+	/* Keep refcounting/lru data together for 32-bit/16-byte systems */
+  	atomic_t d_count;
+  	unsigned long d_vfs_flags;
+	struct list_head d_lru;		/* d_count = 0 LRU list */
+
+	/* Data that is referenced less often, or only by a few
+	 * (mostly remote or exported) filesystems.  (effectively
+	 * cache padding for 64-byte cachelines) */
 	unsigned int d_flags;
-	struct inode  * d_inode;	/* Where the name belongs to - NULL is negative */
+  	struct list_head d_alias;	/* inode alias list */
+
+  	unsigned long d_time;		/* used by d_revalidate */
+  	struct super_block * d_sb;	/* The root of the dentry tree */
+  	void * d_fsdata;		/* fs-specific data */
+
+	/* This probably belongs in the second section, but if we put
+	 * it there we spill over into the next cacheline on
+	 * 32-bit/64-byte systems */
+
+  	struct list_head d_subdirs;	/* our children */
+
+	/* Data that rarely changes and is referenced often - start a
+	 * new cacheline to avoid SMP cache bounce.
+	 *
+	 * All the data for a failed hash check is in the same
+	 * cacheline on a 32-bit/16-byte systems.
+	 */ 
+
+  	struct list_head d_hash ____cacheline_aligned; /* lookup hash list */
 	struct dentry * d_parent;	/* parent directory */
-	struct list_head d_hash;	/* lookup hash list */
-	struct list_head d_lru;		/* d_count = 0 LRU list */
-	struct list_head d_child;	/* child of parent list */
-	struct list_head d_subdirs;	/* our children */
-	struct list_head d_alias;	/* inode alias list */
+  	struct qstr d_name;
+  	unsigned char d_iname[DNAME_INLINE_LEN]; /* small names */
+	struct inode  * d_inode;	/* Where the name belongs to - NULL is negative */
+  	struct dentry_operations  *d_op;
 	int d_mounted;
-	struct qstr d_name;
-	unsigned long d_time;		/* used by d_revalidate */
-	struct dentry_operations  *d_op;
-	struct super_block * d_sb;	/* The root of the dentry tree */
-	unsigned long d_vfs_flags;
-	void * d_fsdata;		/* fs-specific data */
-	unsigned char d_iname[DNAME_INLINE_LEN]; /* small names */
+
+  	struct list_head d_child;	/* child of parent list */
 };
 
 struct dentry_operations {
diff -X /mnt/elbrus/home/pmenage/dontdiff -Naur linux-2.5.25/kernel/futex.c linux-2.5.25-dentry/kernel/futex.c
--- linux-2.5.25/kernel/futex.c	Wed Jun 26 01:07:20 2002
+++ linux-2.5.25-dentry/kernel/futex.c	Fri Jul 12 13:01:34 2002
@@ -366,7 +366,7 @@
 	root->i_uid = root->i_gid = 0;
 	root->i_atime = root->i_mtime = root->i_ctime = CURRENT_TIME;
 
-	sb->s_root = d_alloc(NULL, &(const struct qstr) { "futex", 5, 0 });
+	sb->s_root = d_alloc(NULL, &(const struct qstr) { name : "futex", len : 5});
 	sb->s_root->d_sb = sb;
 	sb->s_root->d_parent = sb->s_root;
 	d_instantiate(sb->s_root, root);



