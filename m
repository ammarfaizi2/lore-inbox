Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261533AbSJAI1Z>; Tue, 1 Oct 2002 04:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261534AbSJAI1Z>; Tue, 1 Oct 2002 04:27:25 -0400
Received: from plum.csi.cam.ac.uk ([131.111.8.3]:6837 "EHLO plum.csi.cam.ac.uk")
	by vger.kernel.org with ESMTP id <S261533AbSJAI1V>;
	Tue, 1 Oct 2002 04:27:21 -0400
Subject: [RESEND][BK-PATCH-1/2] Introduce ilookup() for searching for inodes in icache
To: torvalds@transmeta.com (Linus Torvalds)
Date: Tue, 1 Oct 2002 09:32:38 +0100 (BST)
Cc: viro@math.psu.edu (Alexander Viro),
       linux-kernel@vger.kernel.org (Linux Kernel)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17wISM-0000ug-00@storm.christs.cam.ac.uk>
From: Anton Altaparmakov <aia21@cantab.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

	bk pull http://linux-ntfs.bkbits.net/linux-2.5-ilookup

This is just a resend, no changes. Patches tested with your current BK
tree (2.5.40) and work fine here...

Since noone complained last time can we assume that the patches are
now ok? If so, please, please apply. Thanks!

Best regards,

	Anton

--- description from previous post ---
This is a reworked version of my previous ilookup() patches. We now use
helper functions taking the calculated hash as parameter to do the actual
icache search so that we can use the same helpers in iget_locked() without
having to calculate the hash twice in the slow path of iget_locked().

This patch introduces ilookup() and the helpers.

The next patch switches iget_locked() to using the helpers.

Since the helpers are static inline, the iget_locked() code paths should
be fully identical to what they were before.
--- end of description from previous post ---

-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

This will update the following files:

 fs/inode.c         |  117 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h |    4 +
 2 files changed, 121 insertions(+)

through these ChangeSets:

<aia21@cantab.net> (02/09/18 1.536.35.8)
   Add functions for searching for an inode in icache and getting a reference
   to it if present - fs/inode.c::ilookup() and ilookup5(), mirroring the
   iget_locked() and iget5_locked() function pair. Also add two internal
   helpers ifind_fast() and ifind() respectively which will later be used
   by iget_locked() and iget5_locked() to do the search, too.


diff -Nru a/fs/inode.c b/fs/inode.c
--- a/fs/inode.c	Tue Oct  1 09:22:21 2002
+++ b/fs/inode.c	Tue Oct  1 09:22:21 2002
@@ -695,6 +695,123 @@
 	return inode;
 }
 
+/**
+ * ifind - internal function, you want ilookup5() or iget5().
+ * @sb:		super block of file system to search
+ * @hashval:	hash value (usually inode number) to search for
+ * @test:	callback used for comparisons between inodes
+ * @data:	opaque data pointer to pass to @test
+ *
+ * ifind() searches for the inode specified by @hashval and @data in the inode
+ * cache. This is a generalized version of ifind_fast() for file systems where
+ * the inode number is not sufficient for unique identification of an inode.
+ *
+ * If the inode is in the cache, the inode is returned with an incremented
+ * reference count.
+ *
+ * Otherwise NULL is returned.
+ *
+ * Note, @test is called with the inode_lock held, so can't sleep.
+ */
+static inline struct inode *ifind(struct super_block *sb,
+		struct list_head *head, int (*test)(struct inode *, void *),
+		void *data)
+{
+	struct inode *inode;
+
+	spin_lock(&inode_lock);
+	inode = find_inode(sb, head, test, data);
+	if (inode) {
+		__iget(inode);
+		spin_unlock(&inode_lock);
+		wait_on_inode(inode);
+		return inode;
+	}
+	spin_unlock(&inode_lock);
+	return NULL;
+}
+
+/**
+ * ifind_fast - internal function, you want ilookup() or iget().
+ * @sb:		super block of file system to search
+ * @ino:	inode number to search for
+ *
+ * ifind_fast() searches for the inode @ino in the inode cache. This is for
+ * file systems where the inode number is sufficient for unique identification
+ * of an inode.
+ *
+ * If the inode is in the cache, the inode is returned with an incremented
+ * reference count.
+ *
+ * Otherwise NULL is returned.
+ */
+static inline struct inode *ifind_fast(struct super_block *sb,
+		struct list_head *head, unsigned long ino)
+{
+	struct inode *inode;
+
+	spin_lock(&inode_lock);
+	inode = find_inode_fast(sb, head, ino);
+	if (inode) {
+		__iget(inode);
+		spin_unlock(&inode_lock);
+		wait_on_inode(inode);
+		return inode;
+	}
+	spin_unlock(&inode_lock);
+	return NULL;
+}
+
+/**
+ * ilookup5 - search for an inode in the inode cache
+ * @sb:		super block of file system to search
+ * @hashval:	hash value (usually inode number) to search for
+ * @test:	callback used for comparisons between inodes
+ * @data:	opaque data pointer to pass to @test
+ *
+ * ilookup5() uses ifind() to search for the inode specified by @hashval and
+ * @data in the inode cache. This is a generalized version of ilookup() for
+ * file systems where the inode number is not sufficient for unique
+ * identification of an inode.
+ *
+ * If the inode is in the cache, the inode is returned with an incremented
+ * reference count.
+ *
+ * Otherwise NULL is returned.
+ *
+ * Note, @test is called with the inode_lock held, so can't sleep.
+ */
+struct inode *ilookup5(struct super_block *sb, unsigned long hashval,
+		int (*test)(struct inode *, void *), void *data)
+{
+	struct list_head *head = inode_hashtable + hash(sb, hashval);
+
+	return ifind(sb, head, test, data);
+}
+EXPORT_SYMBOL(ilookup5);
+
+/**
+ * ilookup - search for an inode in the inode cache
+ * @sb:		super block of file system to search
+ * @ino:	inode number to search for
+ *
+ * ilookup() uses ifind_fast() to search for the inode @ino in the inode cache.
+ * This is for file systems where the inode number is sufficient for unique
+ * identification of an inode.
+ *
+ * If the inode is in the cache, the inode is returned with an incremented
+ * reference count.
+ *
+ * Otherwise NULL is returned.
+ */
+struct inode *ilookup(struct super_block *sb, unsigned long ino)
+{
+	struct list_head *head = inode_hashtable + hash(sb, ino);
+
+	return ifind_fast(sb, head, ino);
+}
+EXPORT_SYMBOL(ilookup);
+
 /*
  * This is iget without the read_inode portion of get_new_inode
  * the filesystem gets back a new locked and hashed inode and gets
diff -Nru a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h	Tue Oct  1 09:22:21 2002
+++ b/include/linux/fs.h	Tue Oct  1 09:22:21 2002
@@ -1202,6 +1202,10 @@
 extern int inode_needs_sync(struct inode *inode);
 extern void generic_delete_inode(struct inode *inode);
 
+extern struct inode *ilookup5(struct super_block *sb, unsigned long hashval,
+		int (*test)(struct inode *, void *), void *data);
+extern struct inode *ilookup(struct super_block *sb, unsigned long ino);
+
 extern struct inode * iget5_locked(struct super_block *, unsigned long, int (*test)(struct inode *, void *), int (*set)(struct inode *, void *), void *);
 extern struct inode * iget_locked(struct super_block *, unsigned long);
 extern void unlock_new_inode(struct inode *);

===================================================================

This BitKeeper patch contains the following changesets:
1.536.35.8
## Wrapped with gzip_uu ##


begin 664 bkpatch12212
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
5\%(6TR/F]X)AY$_(7PHHUR"=%P``
`
end
