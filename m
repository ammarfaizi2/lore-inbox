Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270948AbSISJon>; Thu, 19 Sep 2002 05:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270940AbSISJoj>; Thu, 19 Sep 2002 05:44:39 -0400
Received: from plum.csi.cam.ac.uk ([131.111.8.3]:47752 "EHLO
	plum.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S270937AbSISJo3>; Thu, 19 Sep 2002 05:44:29 -0400
Subject: [BK-PATCH-2.5-1/2] Introduce ilookup() for searching for inodes in icache
To: torvalds@transmeta.com (Linus Torvalds),
       viro@math.psu.edu (Alexander Viro)
Date: Thu, 19 Sep 2002 10:49:32 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel), linux-fsdevel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17rxwC-0007Kj-00@storm.christs.cam.ac.uk>
From: Anton Altaparmakov <aia21@cantab.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

	bk pull http://linux-ntfs.bkbits.net/linux-2.5-ilookup

This is a reworked version of my previous ilookup() patches. We now use
helper functions taking the calculated hash as parameter to do the actual
icache search so that we can use the same helpers in iget_locked() without
having to calculate the hash twice in the slow path of iget_locked().

This patch introduces ilookup() and the helpers.

The next patch switches iget_locked() to using the helpers.

Since the helpers are static inline, the iget_locked() code paths should
be fully identical to what they were before.

Patches tested with your current BK tree and work fine here.

Please apply.

Best regards,

	Anton
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

<aia21@cantab.net> (02/09/18 1.536.1.37)
   Add functions for searching for an inode in icache and getting a reference
   to it if present - fs/inode.c::ilookup() and ilookup5(), mirroring the
   iget_locked() and iget5_locked() function pair. Also add two internal
   helpers ifind_fast() and ifind() respectively which will later be used
   by iget_locked() and iget5_locked() to do the search, too.


diff -Nru a/fs/inode.c b/fs/inode.c
--- a/fs/inode.c	Thu Sep 19 10:39:33 2002
+++ b/fs/inode.c	Thu Sep 19 10:39:33 2002
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
--- a/include/linux/fs.h	Thu Sep 19 10:39:33 2002
+++ b/include/linux/fs.h	Thu Sep 19 10:39:33 2002
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
1.536.1.37
## Wrapped with gzip_uu ##


begin 664 bkpatch16620
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
6#2Y%,3\:.D$T"EV/_`6I:[I>G1<`````
`
end
