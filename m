Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315222AbSF3PHx>; Sun, 30 Jun 2002 11:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315239AbSF3PHw>; Sun, 30 Jun 2002 11:07:52 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:35090 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S315222AbSF3PHi>; Sun, 30 Jun 2002 11:07:38 -0400
Subject: [BK-PATCH-2.5] NTFS: 2.0.13 - Use iget5_locked() in preparation for fake inodes and small cleanups.
To: torvalds@transmeta.com (Linus Torvalds)
Date: Sun, 30 Jun 2002 16:10:01 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17OgKw-0003vO-00@storm.christs.cam.ac.uk>
From: Anton Altaparmakov <aia21@cantab.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

	bk pull http://linux-ntfs.bkbits.net/ntfs-tng-2.5

Thanks!

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

This will update the following files:

 Documentation/filesystems/ntfs.txt |    3 
 fs/ntfs/ChangeLog                  |   17 ++
 fs/ntfs/Makefile                   |    2 
 fs/ntfs/inode.c                    |  254 +++++++++++++++++++++++++++++++++----
 fs/ntfs/inode.h                    |    6 
 fs/ntfs/mft.c                      |    3 
 fs/ntfs/namei.c                    |   24 ++-
 fs/ntfs/super.c                    |  108 +++++++--------
 fs/ntfs/volume.h                   |   17 --
 9 files changed, 321 insertions(+), 113 deletions(-)

through these ChangeSets:

<aia21@cantab.net> (02/06/27 1.603.1.3)
   NTFS: 2.0.13 - Use iget5_locked() in preparation for fake inodes and small cleanups.
   - Remove nr_mft_bits and the now superfluous union with nr_mft_records
     from ntfs_volume structure.
   - Remove nr_lcn_bits and the now superfluous union with nr_clusters
     from ntfs_volume structure.
   - Use iget5_locked() and friends instead of conventional iget(). Wrap
     the call in fs/ntfs/inode.c::ntfs_iget() and update callers of iget()
     to use ntfs_iget(). Leave only one iget() call at mount time so we
     don't need an ntfs_iget_mount().
   - Change fs/ntfs/inode.c::ntfs_new_extent_inode() to take mft_no as an
     additional argument.


diff -Nru a/Documentation/filesystems/ntfs.txt b/Documentation/filesystems/ntfs.txt
--- a/Documentation/filesystems/ntfs.txt	Sun Jun 30 13:47:22 2002
+++ b/Documentation/filesystems/ntfs.txt	Sun Jun 30 13:47:22 2002
@@ -247,6 +247,9 @@
 
 Note, a technical ChangeLog aimed at kernel hackers is in fs/ntfs/ChangeLog.
 
+2.0.13:
+	- Internal changes towards using iget5_locked() in preparation for
+	  fake inodes and small cleanups to ntfs_volume structure.
 2.0.12:
 	- Internal cleanups in address space operations made possible by the
 	  changes introduced in the previous release.
diff -Nru a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog	Sun Jun 30 13:47:22 2002
+++ b/fs/ntfs/ChangeLog	Sun Jun 30 13:47:22 2002
@@ -22,9 +22,24 @@
 	  based attribute i/o is further developed.
 	- CLEANUP: Modularising code in aops.c a bit, e.g. a-la get_block(),
 	  will be cleaner and make code reuse easier.
+	- Modify ntfs_read_locked_inode() to return an error code and update
+	  callers, i.e. ntfs_iget(), to pass that error code up instead of just
+	  using -EIO.
 	- Enable NFS exporting of NTFS.
-	- Use iget5_locked() and friends instead of conventional iget().
 	- Use fake inodes for address space i/o.
+
+2.0.13 - Use iget5_locked() in preparation for fake inodes and small cleanups.
+
+	- Remove nr_mft_bits and the now superfluous union with nr_mft_records
+	  from ntfs_volume structure.
+	- Remove nr_lcn_bits and the now superfluous union with nr_clusters
+	  from ntfs_volume structure.
+	- Use iget5_locked() and friends instead of conventional iget(). Wrap
+	  the call in fs/ntfs/inode.c::ntfs_iget() and update callers of iget()
+	  to use ntfs_iget(). Leave only one iget() call at mount time so we
+	  don't need an ntfs_iget_mount().
+	- Change fs/ntfs/inode.c::ntfs_new_extent_inode() to take mft_no as an
+	  additional argument.
 
 2.0.12 - Initial cleanup of address space operations following 2.0.11 changes.
 
diff -Nru a/fs/ntfs/Makefile b/fs/ntfs/Makefile
--- a/fs/ntfs/Makefile	Sun Jun 30 13:47:22 2002
+++ b/fs/ntfs/Makefile	Sun Jun 30 13:47:22 2002
@@ -5,7 +5,7 @@
 ntfs-objs := aops.o attrib.o compress.o debug.o dir.o file.o inode.o mft.o \
 	     mst.o namei.o super.o sysctl.o time.o unistr.o upcase.o
 
-EXTRA_CFLAGS = -DNTFS_VERSION=\"2.0.12\"
+EXTRA_CFLAGS = -DNTFS_VERSION=\"2.0.13\"
 
 ifeq ($(CONFIG_NTFS_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
diff -Nru a/fs/ntfs/inode.c b/fs/ntfs/inode.c
--- a/fs/ntfs/inode.c	Sun Jun 30 13:47:22 2002
+++ b/fs/ntfs/inode.c	Sun Jun 30 13:47:22 2002
@@ -24,6 +24,178 @@
 
 #include "ntfs.h"
 #include "dir.h"
+#include "inode.h"
+#include "attrib.h"
+
+/**
+ * ntfs_attr - ntfs in memory attribute structure
+ * @mft_no:	mft record number of the base mft record of this attribute
+ * @name:	Unicode name of the attribute (NULL if unnamed)
+ * @name_len:	length of @name in Unicode characters (0 if unnamed)
+ * @type:	attribute type (see layout.h)
+ *
+ * This structure exists only to provide a small structure for the
+ * ntfs_iget()/ntfs_test_inode()/ntfs_init_locked_inode() mechanism.
+ *
+ * NOTE: Elements are ordered by size to make the structure as compact as
+ * possible on all architectures.
+ */
+typedef struct {
+	unsigned long mft_no;
+	uchar_t *name;
+	u32 name_len;
+	ATTR_TYPES type;
+} ntfs_attr;
+
+/**
+ * ntfs_test_inode - compare two (possibly fake) inodes for equality
+ * @vi:		vfs inode which to test
+ * @na:		ntfs attribute which is being tested with
+ *
+ * Compare the ntfs attribute embedded in the ntfs specific part of the vfs
+ * inode @vi for equality with the ntfs attribute @na.
+ *
+ * If searching for the normal file/directory inode, set @na->type to AT_UNUSED.
+ * @na->name and @na->name_len are then ignored.
+ *
+ * Return 1 if the attributes match and 0 if not.
+ *
+ * NOTE: This function runs with the inode_lock spin lock held so it is not
+ * allowed to sleep.
+ */
+static int ntfs_test_inode(struct inode *vi, ntfs_attr *na)
+{
+	ntfs_inode *ni;
+
+	if (vi->i_ino != na->mft_no)
+		return 0;
+	ni = NTFS_I(vi);
+	/* If !NInoAttr(ni), @vi is a normal file or directory inode. */
+	if (likely(!NInoAttr(ni))) {
+		/* If not looking for a normal inode this is a mismatch. */
+		if (unlikely(na->type != AT_UNUSED))
+			return 0;
+	} else {
+		/* A fake inode describing an attribute. */
+		if (ni->type != na->type)
+			return 0;
+		if (ni->name_len != na->name_len)
+			return 0;
+		if (na->name_len && memcmp(ni->name, na->name,
+				na->name_len * sizeof(uchar_t)))
+			return 0;
+	}
+	/* Match! */
+	return 1;
+}
+
+/**
+ * ntfs_init_locked_inode - initialize an inode
+ * @vi:		vfs inode to initialize
+ * @na:		ntfs attribute which to initialize @vi to
+ *
+ * Initialize the vfs inode @vi with the values from the ntfs attribute @na in
+ * order to enable ntfs_test_inode() to do its work.
+ *
+ * If initializing the normal file/directory inode, set @na->type to AT_UNUSED.
+ * In that case, @na->name and @na->name_len should be set to NULL and 0,
+ * respectively. Although that is not strictly necessary as
+ * ntfs_read_inode_locked() will fill them in later.
+ *
+ * Return 0 on success and -errno on error.
+ *
+ * NOTE: This function runs with the inode_lock spin lock held so it is not
+ * allowed to sleep. (Hence the GFP_ATOMIC allocation.)
+ */
+static int ntfs_init_locked_inode(struct inode *vi, ntfs_attr *na)
+{
+	ntfs_inode *ni = NTFS_I(vi);
+
+	vi->i_ino = na->mft_no;
+	ni->type = na->type;
+	ni->name = na->name;
+	ni->name_len = na->name_len;
+	/* If initializing a normal inode, we are done. */
+	if (likely(na->type == AT_UNUSED))
+		return 0;
+	/* It is a fake inode. */
+	NInoSetAttr(ni);
+	/*
+	 * We have I30 global constant as an optimization as it is the name
+	 * in >99.9% of named attributes! The other <0.1% incur a GFP_ATOMIC
+	 * allocation but that is ok. And most attributes are unnamed anyway,
+	 * thus the fraction of named attributes with name != I30 is actually
+	 * absolutely tiny.
+	 */
+	if (na->name && na->name_len && na->name != I30) {
+		unsigned int i;
+
+		i = na->name_len * sizeof(uchar_t);
+		ni->name = (uchar_t*)kmalloc(i + sizeof(uchar_t), GFP_ATOMIC);
+		if (!ni->name)
+			return -ENOMEM;
+		memcpy(ni->name, na->name, i);
+		ni->name[i] = cpu_to_le16('\0');
+	}
+	return 0;
+}
+
+typedef int (*test_t)(struct inode *, void *);
+typedef int (*set_t)(struct inode *, void *);
+static void ntfs_read_locked_inode(struct inode *vi);
+
+/**
+ * ntfs_iget - obtain a struct inode corresponding to a specific normal inode
+ * @sb:		super block of mounted volume
+ * @mft_no:	mft record number / inode number to obtain
+ *
+ * Obtain the struct inode corresponding to a specific normal inode (i.e. a
+ * file or directory).
+ *
+ * If the inode is in the cache, it is just returned with an increased
+ * reference count. Otherwise, a new struct inode is allocated and initialized,
+ * and finally ntfs_read_locked_inode() is called to read in the inode and
+ * fill in the remainder of the inode structure.
+ *
+ * Return the struct inode on success. Check the return value with IS_ERR() and
+ * if true, the function failed and the error code is obtained from PTR_ERR().
+ */
+struct inode *ntfs_iget(struct super_block *sb, unsigned long mft_no)
+{
+	struct inode *vi;
+	ntfs_attr na;
+
+	na.mft_no = mft_no;
+	na.type = AT_UNUSED;
+	na.name = NULL;
+	na.name_len = 0;
+
+	vi = iget5_locked(sb, mft_no, (test_t)ntfs_test_inode,
+			(set_t)ntfs_init_locked_inode, &na);
+	if (!vi)
+		return ERR_PTR(-ENOMEM);
+
+	/* If this is a freshly allocated inode, need to read it now. */
+	if (vi->i_state & I_NEW) {
+		ntfs_read_locked_inode(vi);
+		unlock_new_inode(vi);
+	}
+#if 0
+	// TODO: Enable this and do the follow up cleanup, i.e. remove all the
+	// bad inode checks. -- BUT: Do we actually want to do this? -- It may
+	// result in repeated attemps to read a bad inode which is not
+	// desirable. (AIA)
+	/*
+	 * There is no point in keeping bad inodes around. This also simplifies
+	 * things in that we never need to check for bad inodes elsewhere.
+	 */
+	if (is_bad_inode(vi)) {
+		iput(vi);
+		vi = ERR_PTR(-EIO);
+	}
+#endif
+	return vi;
+}
 
 struct inode *ntfs_alloc_big_inode(struct super_block *sb)
 {
@@ -32,12 +204,12 @@
 	ntfs_debug("Entering.");
 	ni = (ntfs_inode *)kmem_cache_alloc(ntfs_big_inode_cache,
 			SLAB_NOFS);
-	if (!ni) {
-		ntfs_error(sb, "Allocation of NTFS big inode structure "
-				"failed.");
-		return NULL;
+	if (likely(ni != NULL)) {
+		ni->state = 0;
+		return VFS_I(ni);
 	}
-	return VFS_I(ni);
+	ntfs_error(sb, "Allocation of NTFS big inode structure failed.");
+	return NULL;
 }
 
 void ntfs_destroy_big_inode(struct inode *inode)
@@ -49,14 +221,17 @@
 	kmem_cache_free(ntfs_big_inode_cache, NTFS_I(inode));
 }
 
-ntfs_inode *ntfs_alloc_extent_inode(void)
+static ntfs_inode *ntfs_alloc_extent_inode(void)
 {
 	ntfs_inode *ni = (ntfs_inode *)kmem_cache_alloc(ntfs_inode_cache,
 			SLAB_NOFS);
 	ntfs_debug("Entering.");
-	if (unlikely(!ni))
-		ntfs_error(NULL, "Allocation of NTFS inode structure failed.");
-	return ni;
+	if (likely(ni != NULL)) {
+		ni->state = 0;
+		return ni;
+	}
+	ntfs_error(NULL, "Allocation of NTFS inode structure failed.");
+	return NULL;
 }
 
 void ntfs_destroy_extent_inode(ntfs_inode *ni)
@@ -68,27 +243,42 @@
 
 /**
  * __ntfs_init_inode - initialize ntfs specific part of an inode
+ * @sb:		super block of mounted volume
+ * @ni:		freshly allocated ntfs inode which to initialize
  *
  * Initialize an ntfs inode to defaults.
  *
+ * NOTE: ni->mft_no, ni->state, ni->type, ni->name, and ni->name_len are left
+ * untouched. Make sure to initialize them elsewhere.
+ *
  * Return zero on success and -ENOMEM on error.
  */
 static void __ntfs_init_inode(struct super_block *sb, ntfs_inode *ni)
 {
 	ntfs_debug("Entering.");
-	memset(ni, 0, sizeof(ntfs_inode));
+	ni->initialized_size = ni->allocated_size = 0;
+	ni->seq_no = 0;
 	atomic_set(&ni->count, 1);
-	ni->vol = NULL;
+	ni->vol = NTFS_SB(sb);
 	init_run_list(&ni->run_list);
 	init_rwsem(&ni->mrec_lock);
 	atomic_set(&ni->mft_count, 0);
 	ni->page = NULL;
+	ni->page_ofs = 0;
+	ni->attr_list_size = 0;
 	ni->attr_list = NULL;
 	init_run_list(&ni->attr_list_rl);
+	ni->_IDM(index_block_size) = 0;
+	ni->_IDM(index_vcn_size) = 0;
+	ni->_IDM(bmp_size) = 0;
+	ni->_IDM(bmp_initialized_size) = 0;
+	ni->_IDM(bmp_allocated_size) = 0;
 	init_run_list(&ni->_IDM(bmp_rl));
+	ni->_IDM(index_block_size_bits) = 0;
+	ni->_IDM(index_vcn_size_bits) = 0;
 	init_MUTEX(&ni->extent_lock);
+	ni->nr_extents = 0;
 	ni->_INE(base_ntfs_ino) = NULL;
-	ni->vol = NTFS_SB(sb);
 	return;
 }
 
@@ -102,13 +292,18 @@
 	return;
 }
 
-ntfs_inode *ntfs_new_extent_inode(struct super_block *sb)
+ntfs_inode *ntfs_new_extent_inode(struct super_block *sb, unsigned long mft_no)
 {
 	ntfs_inode *ni = ntfs_alloc_extent_inode();
 
 	ntfs_debug("Entering.");
-	if (ni)
+	if (likely(ni != NULL)) {
 		__ntfs_init_inode(sb, ni);
+		ni->mft_no = mft_no;
+		ni->type = AT_UNUSED;
+		ni->name = NULL;
+		ni->name_len = 0;
+	}
 	return ni;
 }
 
@@ -189,18 +384,20 @@
 }
 
 /**
- * ntfs_read_inode - read an inode from its device
+ * ntfs_read_locked_inode - read an inode from its device
  * @vi:		inode to read
  *
- * ntfs_read_inode() is called from the VFS iget() function to read the inode
+ * ntfs_read_locked_inode() is called from the ntfs_iget() to read the inode
  * described by @vi into memory from the device.
  *
  * The only fields in @vi that we need to/can look at when the function is
  * called are i_sb, pointing to the mounted device's super block, and i_ino,
- * the number of the inode to load.
+ * the number of the inode to load. If this is a fake inode, i.e. NInoAttr(),
+ * then the fields type, name, and name_len are also valid, and describe the
+ * attribute which this fake inode represents.
  *
- * ntfs_read_inode() maps, pins and locks the mft record number i_ino for
- * reading and sets up the necessary @vi fields as well as initializing
+ * ntfs_read_locked_inode() maps, pins and locks the mft record number i_ino
+ * for reading and sets up the necessary @vi fields as well as initializing
  * the ntfs inode.
  *
  * Q: What locks are held when the function is called?
@@ -209,9 +406,9 @@
  *    i_flags is set to 0 and we have no business touching it. Only an ioctl()
  *    is allowed to write to them. We should of course be honouring them but
  *    we need to do that using the IS_* macros defined in include/linux/fs.h.
- *    In any case ntfs_read_inode() has nothing to do with i_flags at all.
+ *    In any case ntfs_read_locked_inode() has nothing to do with i_flags.
  */
-void ntfs_read_inode(struct inode *vi)
+static void ntfs_read_locked_inode(struct inode *vi)
 {
 	ntfs_volume *vol = NTFS_SB(vi->i_sb);
 	ntfs_inode *ni;
@@ -661,7 +858,7 @@
 		vi->i_fop = &ntfs_dir_ops;
 		vi->i_mapping->a_ops = &ntfs_dir_aops;
 	} else {
-		/* It is a file: find first extent of unnamed data attribute. */
+		/* It is a file. */
 		reinit_attr_search_ctx(ctx);
 
 		/* Setup the data attribute, even if not present. */
@@ -669,6 +866,7 @@
 		ni->name = NULL;
 		ni->name_len = 0;
 
+		/* Find first extent of the unnamed data attribute. */
 		if (!lookup_attr(AT_DATA, NULL, 0, 0, 0, NULL, 0, ctx)) {
 			vi->i_size = ni->initialized_size =
 					ni->allocated_size = 0LL;
@@ -877,15 +1075,17 @@
 
 	ntfs_debug("Entering.");
 
-	/* Initialize the ntfs specific part of @vi. */
-	ntfs_init_big_inode(vi);
-	ni = NTFS_I(vi);
 	if (vi->i_ino != FILE_MFT) {
 		ntfs_error(sb, "Called for inode 0x%lx but only inode %d "
 				"allowed.", vi->i_ino, FILE_MFT);
 		goto err_out;
 	}
 
+	/* Initialize the ntfs specific part of @vi. */
+	ntfs_init_big_inode(vi);
+
+	ni = NTFS_I(vi);
+
 	/* Setup the data attribute. It is special as it is mst protected. */
 	NInoSetNonResident(ni);
 	NInoSetMstProtected(ni);
@@ -1158,7 +1358,7 @@
 				ntfs_error(sb, "$MFT is too big! Aborting.");
 				goto put_err_out;
 			}
-			vol->_VMM(nr_mft_records) = ll;
+			vol->nr_mft_records = ll;
 			/*
 			 * We have got the first extent of the run_list for
 			 * $MFT which means it is now relatively safe to call
@@ -1184,7 +1384,7 @@
 			 * ntfs_read_inode() on extents of $MFT/$DATA. But lets
 			 * hope this never happens...
 			 */
-			ntfs_read_inode(vi);
+			ntfs_read_locked_inode(vi);
 			if (is_bad_inode(vi)) {
 				ntfs_error(sb, "ntfs_read_inode() of $MFT "
 						"failed. BUG or corrupt $MFT. "
diff -Nru a/fs/ntfs/inode.h b/fs/ntfs/inode.h
--- a/fs/ntfs/inode.h	Sun Jun 30 13:47:22 2002
+++ b/fs/ntfs/inode.h	Sun Jun 30 13:47:22 2002
@@ -231,14 +231,16 @@
 	return &((big_ntfs_inode*)ni)->vfs_inode;
 }
 
+extern struct inode *ntfs_iget(struct super_block *sb, unsigned long mft_no);
+
 extern struct inode *ntfs_alloc_big_inode(struct super_block *sb);
 extern void ntfs_destroy_big_inode(struct inode *inode);
 extern void ntfs_clear_big_inode(struct inode *vi);
 
-extern ntfs_inode *ntfs_new_extent_inode(struct super_block *sb);
+extern ntfs_inode *ntfs_new_extent_inode(struct super_block *sb,
+		unsigned long mft_no);
 extern void ntfs_clear_extent_inode(ntfs_inode *ni);
 
-extern void ntfs_read_inode(struct inode *vi);
 extern void ntfs_read_inode_mount(struct inode *vi);
 
 extern void ntfs_dirty_inode(struct inode *vi);
diff -Nru a/fs/ntfs/mft.c b/fs/ntfs/mft.c
--- a/fs/ntfs/mft.c	Sun Jun 30 13:47:22 2002
+++ b/fs/ntfs/mft.c	Sun Jun 30 13:47:22 2002
@@ -417,14 +417,13 @@
 		return m;
 	}
 	/* Record wasn't there. Get a new ntfs inode and initialize it. */
-	ni = ntfs_new_extent_inode(base_ni->vol->sb);
+	ni = ntfs_new_extent_inode(base_ni->vol->sb, mft_no);
 	if (!ni) {
 		up(&base_ni->extent_lock);
 		atomic_dec(&base_ni->count);
 		return ERR_PTR(-ENOMEM);
 	}
 	ni->vol = base_ni->vol;
-	ni->mft_no = mft_no;
 	ni->seq_no = seq_no;
 	ni->nr_extents = -1;
 	ni->_INE(base_ntfs_ino) = base_ni;
diff -Nru a/fs/ntfs/namei.c b/fs/ntfs/namei.c
--- a/fs/ntfs/namei.c	Sun Jun 30 13:47:22 2002
+++ b/fs/ntfs/namei.c	Sun Jun 30 13:47:22 2002
@@ -38,8 +38,8 @@
  * supplying the name of the inode in @dent->d_name.name. ntfs_lookup()
  * converts the name to Unicode and walks the contents of the directory inode
  * @dir_ino looking for the converted Unicode name. If the name is found in the
- * directory, the corresponding inode is loaded by calling iget() on its inode
- * number and the inode is associated with the dentry @dent via a call to
+ * directory, the corresponding inode is loaded by calling ntfs_iget() on its
+ * inode number and the inode is associated with the dentry @dent via a call to
  * d_add().
  *
  * If the name is not found in the directory, a NULL inode is inserted into the
@@ -111,9 +111,9 @@
 	kmem_cache_free(ntfs_name_cache, uname);
 	if (!IS_ERR_MREF(mref)) {
 		dent_ino = MREF(mref);
-		ntfs_debug("Found inode 0x%lx. Calling iget.", dent_ino);
-		dent_inode = iget(vol->sb, dent_ino);
-		if (dent_inode) {
+		ntfs_debug("Found inode 0x%lx. Calling ntfs_iget.", dent_ino);
+		dent_inode = ntfs_iget(vol->sb, dent_ino);
+		if (likely(!IS_ERR(dent_inode))) {
 			/* Consistency check. */
 			if (MSEQNO(mref) == NTFS_I(dent_inode)->seq_no ||
 					dent_ino == FILE_MFT) {
@@ -132,16 +132,19 @@
 			ntfs_error(vol->sb, "Found stale reference to inode "
 					"0x%lx (reference sequence number = "
 					"0x%x, inode sequence number = 0x%x, "
-					"returning -EACCES. Run chkdsk.",
+					"returning -EIO. Run chkdsk.",
 					dent_ino, MSEQNO(mref),
 					NTFS_I(dent_inode)->seq_no);
 			iput(dent_inode);
+			dent_inode = ERR_PTR(-EIO);
 		} else
-			ntfs_error(vol->sb, "iget(0x%lx) failed, returning "
-					"-EACCES.", dent_ino);
+			ntfs_error(vol->sb, "ntfs_iget(0x%lx) failed with "
+				   "error code %li.", dent_ino,
+				   PTR_ERR(dent_inode));
 		if (name)
 			kfree(name);
-		return ERR_PTR(-EACCES);
+		/* Return the error code. */
+		return (struct dentry *)dent_inode;
 	}
 	/* It is guaranteed that name is no longer allocated at this point. */
 	if (MREF_ERR(mref) == -ENOENT) {
@@ -256,7 +259,8 @@
 		BUG_ON(real_dent->d_inode != dent_inode);
 		/*
 		 * Already have the inode and the dentry attached, decrement
-		 * the reference count to balance the iget() we did earlier on.
+		 * the reference count to balance the ntfs_iget() we did
+		 * earlier on.
 		 */
 		iput(dent_inode);
 		return real_dent;
diff -Nru a/fs/ntfs/super.c b/fs/ntfs/super.c
--- a/fs/ntfs/super.c	Sun Jun 30 13:47:22 2002
+++ b/fs/ntfs/super.c	Sun Jun 30 13:47:22 2002
@@ -605,17 +605,17 @@
 				sizeof(unsigned long) * 4);
 		return FALSE;
 	}
-	vol->_VCL(nr_clusters) = ll;
-	ntfs_debug("vol->nr_clusters = 0x%Lx", (long long)vol->_VCL(nr_clusters));
+	vol->nr_clusters = ll;
+	ntfs_debug("vol->nr_clusters = 0x%Lx", (long long)vol->nr_clusters);
 	ll = sle64_to_cpu(b->mft_lcn);
-	if (ll >= vol->_VCL(nr_clusters)) {
+	if (ll >= vol->nr_clusters) {
 		ntfs_error(vol->sb, "MFT LCN is beyond end of volume. Weird.");
 		return FALSE;
 	}
 	vol->mft_lcn = ll;
 	ntfs_debug("vol->mft_lcn = 0x%Lx", (long long)vol->mft_lcn);
 	ll = sle64_to_cpu(b->mftmirr_lcn);
-	if (ll >= vol->_VCL(nr_clusters)) {
+	if (ll >= vol->nr_clusters) {
 		ntfs_error(vol->sb, "MFTMirr LCN is beyond end of volume. "
 				"Weird.");
 		return FALSE;
@@ -629,7 +629,7 @@
 	 * Determine MFT zone size. This is not strictly the right place to do
 	 * this, but I am too lazy to create a function especially for it...
 	 */
-	vol->mft_zone_end = vol->_VCL(nr_clusters);
+	vol->mft_zone_end = vol->nr_clusters;
 	switch (vol->mft_zone_multiplier) {  /* % of volume size in clusters */
 	case 4:
 		vol->mft_zone_end = vol->mft_zone_end >> 1;	/* 50%   */
@@ -678,9 +678,9 @@
 
 	ntfs_debug("Entering.");
 	/* Read upcase table and setup vol->upcase and vol->upcase_len. */
-	ino = iget(sb, FILE_UpCase);
-	if (!ino || is_bad_inode(ino)) {
-		if (ino)
+	ino = ntfs_iget(sb, FILE_UpCase);
+	if (IS_ERR(ino) || is_bad_inode(ino)) {
+		if (!IS_ERR(ino))
 			iput(ino);
 		goto upcase_failed;
 	}
@@ -848,7 +848,7 @@
 			vol->mftbmp_allocated_size =
 					sle64_to_cpu(attr->_ANR(allocated_size));
 			/* Consistency check. */
-			if (vol->mftbmp_size < (vol->_VMM(nr_mft_records) + 7) >> 3) {
+			if (vol->mftbmp_size < (vol->nr_mft_records + 7) >> 3) {
 				ntfs_error(sb, "$MFT/$BITMAP is too short to "
 						"contain a complete mft "
 						"bitmap: impossible. $MFT is "
@@ -914,9 +914,9 @@
 	// volume read-write...
 
 	/* Get mft mirror inode. */
-	vol->mftmirr_ino = iget(sb, FILE_MFTMirr);
-	if (!vol->mftmirr_ino || is_bad_inode(vol->mftmirr_ino)) {
-		if (is_bad_inode(vol->mftmirr_ino))
+	vol->mftmirr_ino = ntfs_iget(sb, FILE_MFTMirr);
+	if (IS_ERR(vol->mftmirr_ino) || is_bad_inode(vol->mftmirr_ino)) {
+		if (!IS_ERR(vol->mftmirr_ino))
 			iput(vol->mftmirr_ino);
 		ntfs_error(sb, "Failed to load $MFTMirr.");
 		return FALSE;
@@ -932,13 +932,13 @@
 	 * need for any locking at this stage as we are already running
 	 * exclusively as we are mount in progress task.
 	 */
-	vol->lcnbmp_ino = iget(sb, FILE_Bitmap);
-	if (!vol->lcnbmp_ino || is_bad_inode(vol->lcnbmp_ino)) {
-		if (is_bad_inode(vol->lcnbmp_ino))
+	vol->lcnbmp_ino = ntfs_iget(sb, FILE_Bitmap);
+	if (IS_ERR(vol->lcnbmp_ino) || is_bad_inode(vol->lcnbmp_ino)) {
+		if (!IS_ERR(vol->lcnbmp_ino))
 			iput(vol->lcnbmp_ino);
 		goto bitmap_failed;
 	}
-	if ((vol->_VCL(nr_lcn_bits) + 7) >> 3 > vol->lcnbmp_ino->i_size) {
+	if ((vol->nr_clusters + 7) >> 3 > vol->lcnbmp_ino->i_size) {
 		iput(vol->lcnbmp_ino);
 bitmap_failed:
 		ntfs_error(sb, "Failed to load $Bitmap.");
@@ -948,9 +948,9 @@
 	 * Get the volume inode and setup our cache of the volume flags and
 	 * version.
 	 */
-	vol->vol_ino = iget(sb, FILE_Volume);
-	if (!vol->vol_ino || is_bad_inode(vol->vol_ino)) {
-		if (is_bad_inode(vol->vol_ino))
+	vol->vol_ino = ntfs_iget(sb, FILE_Volume);
+	if (IS_ERR(vol->vol_ino) || is_bad_inode(vol->vol_ino)) {
+		if (!IS_ERR(vol->vol_ino))
 			iput(vol->vol_ino);
 volume_failed:
 		ntfs_error(sb, "Failed to load $Volume.");
@@ -993,9 +993,9 @@
 	 * Get the inode for the logfile and empty it if this is a read-write
 	 * mount.
 	 */
-	tmp_ino = iget(sb, FILE_LogFile);
-	if (!tmp_ino || is_bad_inode(tmp_ino)) {
-		if (is_bad_inode(tmp_ino))
+	tmp_ino = ntfs_iget(sb, FILE_LogFile);
+	if (IS_ERR(tmp_ino) || is_bad_inode(tmp_ino)) {
+		if (!IS_ERR(tmp_ino))
 			iput(tmp_ino);
 		ntfs_error(sb, "Failed to load $LogFile.");
 		// FIMXE: We only want to empty the thing so pointless bailing
@@ -1010,9 +1010,9 @@
 	 * Get the inode for the attribute definitions file and parse the
 	 * attribute definitions.
 	 */ 
-	tmp_ino = iget(sb, FILE_AttrDef);
-	if (!tmp_ino || is_bad_inode(tmp_ino)) {
-		if (is_bad_inode(tmp_ino))
+	tmp_ino = ntfs_iget(sb, FILE_AttrDef);
+	if (IS_ERR(tmp_ino) || is_bad_inode(tmp_ino)) {
+		if (!IS_ERR(tmp_ino))
 			iput(tmp_ino);
 		ntfs_error(sb, "Failed to load $AttrDef.");
 		goto iput_vol_bmp_mirr_err_out;
@@ -1020,9 +1020,9 @@
 	// FIXME: Parse the attribute definitions.
 	iput(tmp_ino);
 	/* Get the root directory inode. */
-	vol->root_ino = iget(sb, FILE_root);
-	if (!vol->root_ino || is_bad_inode(vol->root_ino)) {
-		if (is_bad_inode(vol->root_ino))
+	vol->root_ino = ntfs_iget(sb, FILE_root);
+	if (IS_ERR(vol->root_ino) || is_bad_inode(vol->root_ino)) {
+		if (!IS_ERR(vol->root_ino))
 			iput(vol->root_ino);
 		ntfs_error(sb, "Failed to load root directory.");
 		goto iput_vol_bmp_mirr_err_out;
@@ -1032,18 +1032,18 @@
 		return TRUE;
 	/* NTFS 3.0+ specific initialization. */
 	/* Get the security descriptors inode. */
-	vol->secure_ino = iget(sb, FILE_Secure);
-	if (!vol->secure_ino || is_bad_inode(vol->secure_ino)) {
-		if (is_bad_inode(vol->secure_ino))
+	vol->secure_ino = ntfs_iget(sb, FILE_Secure);
+	if (IS_ERR(vol->secure_ino) || is_bad_inode(vol->secure_ino)) {
+		if (!IS_ERR(vol->secure_ino))
 			iput(vol->secure_ino);
 		ntfs_error(sb, "Failed to load $Secure.");
 		goto iput_root_vol_bmp_mirr_err_out;
 	}
 	// FIXME: Initialize security.
 	/* Get the extended system files' directory inode. */
-	tmp_ino = iget(sb, FILE_Extend);
-	if (!tmp_ino || is_bad_inode(tmp_ino)) {
-		if (is_bad_inode(tmp_ino))
+	tmp_ino = ntfs_iget(sb, FILE_Extend);
+	if (IS_ERR(tmp_ino) || is_bad_inode(tmp_ino)) {
+		if (!IS_ERR(tmp_ino))
 			iput(tmp_ino);
 		ntfs_error(sb, "Failed to load $Extend.");
 		goto iput_sec_root_vol_bmp_mirr_err_out;
@@ -1051,8 +1051,8 @@
 	// FIXME: Do something. E.g. want to delete the $UsnJrnl if exists.
 	// Note we might be doing this at the wrong level; we might want to
 	// d_alloc_root() and then do a "normal" open(2) of $Extend\$UsnJrnl
-	// rather than using iget here, as we don't know the inode number for
-	// the files in $Extend directory.
+	// rather than using ntfs_iget here, as we don't know the inode number
+	// for the files in $Extend directory.
 	iput(tmp_ino);
 	return TRUE;
 iput_sec_root_vol_bmp_mirr_err_out:
@@ -1172,7 +1172,7 @@
 	 * Convert the number of bits into bytes rounded up, then convert into
 	 * multiples of PAGE_CACHE_SIZE.
 	 */
-	max_index = (vol->_VCL(nr_clusters) + 7) >> (3 + PAGE_CACHE_SHIFT);
+	max_index = (vol->nr_clusters + 7) >> (3 + PAGE_CACHE_SHIFT);
 	/* Use multiples of 4 bytes. */
 	max_size = PAGE_CACHE_SIZE >> 2;
 	ntfs_debug("Reading $BITMAP, max_index = 0x%lx, max_size = 0x%x.",
@@ -1211,7 +1211,7 @@
 		 * Get the multiples of 4 bytes in use in the final partial
 		 * page.
 		 */
-		max_size = ((((vol->_VCL(nr_clusters) + 7) >> 3) & ~PAGE_CACHE_MASK)
+		max_size = ((((vol->nr_clusters + 7) >> 3) & ~PAGE_CACHE_MASK)
 				+ 3) >> 2;
 		/* If there is a partial page go back and do it. */
 		if (max_size) {
@@ -1254,7 +1254,7 @@
 	 * Convert the number of bits into bytes rounded up, then convert into
 	 * multiples of PAGE_CACHE_SIZE.
 	 */
-	max_index = (vol->_VMM(nr_mft_records) + 7) >> (3 + PAGE_CACHE_SHIFT);
+	max_index = (vol->nr_mft_records + 7) >> (3 + PAGE_CACHE_SHIFT);
 	/* Use multiples of 4 bytes. */
 	max_size = PAGE_CACHE_SIZE >> 2;
 	ntfs_debug("Reading $MFT/$BITMAP, max_index = 0x%lx, max_size = "
@@ -1293,12 +1293,12 @@
 		 * Get the multiples of 4 bytes in use in the final partial
 		 * page.
 		 */
-		max_size = ((((vol->_VMM(nr_mft_records) + 7) >> 3) &
+		max_size = ((((vol->nr_mft_records + 7) >> 3) &
 				~PAGE_CACHE_MASK) + 3) >> 2;
 		/* If there is a partial page go back and do it. */
 		if (max_size) {
 			/* Compensate for out of bounds zero bits. */
-			if ((i = vol->_VMM(nr_mft_records) & 31))
+			if ((i = vol->nr_mft_records & 31))
 				nr_free -= 32 - i;
 			ntfs_debug("Handling partial page, max_size = 0x%x",
 					max_size);
@@ -1345,7 +1345,7 @@
 	 * inodes are also stored in data blocs ($MFT is a file) this is just
 	 * the total clusters.
 	 */
-	sfs->f_blocks = vol->_VCL(nr_clusters) << vol->cluster_size_bits >>
+	sfs->f_blocks = vol->nr_clusters << vol->cluster_size_bits >>
 				PAGE_CACHE_SHIFT;
 	/* Free data blocks in file system in units of f_bsize. */
 	size	      = get_nr_free_clusters(vol) << vol->cluster_size_bits >>
@@ -1394,8 +1394,6 @@
 struct super_operations ntfs_sops = {
 	alloc_inode:	ntfs_alloc_big_inode,	/* VFS: Allocate a new inode. */
 	destroy_inode:	ntfs_destroy_big_inode,	/* VFS: Deallocate an inode. */
-	read_inode:	ntfs_read_inode,	/* VFS: Load inode from disk,
-						   called from iget(). */
 	dirty_inode:	ntfs_dirty_inode,	/* VFS: Called from
 						   __mark_inode_dirty(). */
 	//write_inode:	NULL,		/* VFS: Write dirty inode to disk. */
@@ -1575,9 +1573,9 @@
 	/*
 	 * Now load the metadata required for the page cache and our address
 	 * space operations to function. We do this by setting up a specialised
-	 * read_inode method and then just calling iget() to obtain the inode
-	 * for $MFT which is sufficient to allow our normal inode operations
-	 * and associated address space operations to function.
+	 * read_inode method and then just calling the normal iget() to obtain
+	 * the inode for $MFT which is sufficient to allow our normal inode
+	 * operations and associated address space operations to function.
 	 */
 	/*
 	 * Poison vol->mft_ino so we know whether iget() called into our
@@ -1601,9 +1599,7 @@
 	 * Note: sb->s_op has already been set to &ntfs_sops by our specialized
 	 * ntfs_read_inode_mount() method when it was invoked by iget().
 	 */
-
 	down(&ntfs_lock);
-
 	/*
 	 * The current mount is a compression user if the cluster size is
 	 * less than or equal 4kiB.
@@ -1618,7 +1614,6 @@
 			goto iput_tmp_ino_err_out_now;
 		}
 	}
-
 	/*
 	 * Increment the number of mounts and generate the global default
 	 * upcase table if necessary. Also temporarily increment the number of
@@ -1629,12 +1624,10 @@
 	ntfs_nr_upcase_users++;
 
 	up(&ntfs_lock);
-
 	/*
 	 * From now on, ignore @silent parameter. If we fail below this line,
 	 * it will be due to a corrupt fs or a system error, so we report it.
 	 */
-
 	/*
 	 * Open the system files with normal access functions and complete
 	 * setting up the ntfs super block.
@@ -1643,9 +1636,8 @@
 		ntfs_error(sb, "Failed to load system files.");
 		goto unl_upcase_iput_tmp_ino_err_out_now;
 	}
-
 	if ((sb->s_root = d_alloc_root(vol->root_ino))) {
-		/* We increment i_count simulating an iget(). */
+		/* We increment i_count simulating an ntfs_iget(). */
 		atomic_inc(&vol->root_ino->i_count);
 		ntfs_debug("Exiting, status successful.");
 		/* Release the default upcase if it has no users. */
@@ -1710,10 +1702,10 @@
 #undef OGIN
 	/*
 	 * This is needed to get ntfs_clear_extent_inode() called for each
-	 * inode we have ever called iget()/iput() on, otherwise we A) leak
-	 * resources and B) a subsequent mount fails automatically due to
-	 * iget() never calling down into our ntfs_read_inode{_mount}() methods
-	 * again...
+	 * inode we have ever called ntfs_iget()/iput() on, otherwise we A)
+	 * leak resources and B) a subsequent mount fails automatically due to
+	 * ntfs_iget() never calling down into our ntfs_read_locked_inode()
+	 * method again...
 	 */
 	if (invalidate_inodes(sb)) {
 		ntfs_error(sb, "Busy inodes left. This is most likely a NTFS "
diff -Nru a/fs/ntfs/volume.h b/fs/ntfs/volume.h
--- a/fs/ntfs/volume.h	Sun Jun 30 13:47:22 2002
+++ b/fs/ntfs/volume.h	Sun Jun 30 13:47:22 2002
@@ -3,7 +3,7 @@
  *	      of the Linux-NTFS project.
  *
  * Copyright (c) 2001,2002 Anton Altaparmakov.
- * Copyright (C) 2002 Richard Russon.
+ * Copyright (c) 2002 Richard Russon.
  *
  * This program/include file is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as published
@@ -89,10 +89,8 @@
 	u32 index_record_size;		/* in bytes */
 	u32 index_record_size_mask;	/* index_record_size - 1 */
 	u8 index_record_size_bits;	/* log2(index_record_size) */
-	union {
-		LCN nr_clusters;	/* Volume size in clusters. */
-		LCN nr_lcn_bits;	/* Number of bits in lcn bitmap. */
-	} SN(vcl);
+	LCN nr_clusters;		/* Volume size in clusters == number of
+					   bits in lcn bitmap. */
 	LCN mft_lcn;			/* Cluster location of mft data. */
 	LCN mftmirr_lcn;		/* Cluster location of copy of mft. */
 	u64 serial_no;			/* The volume serial number. */
@@ -104,10 +102,8 @@
 	struct inode *mft_ino;		/* The VFS inode of $MFT. */
 	struct rw_semaphore mftbmp_lock; /* Lock for serializing accesses to the
 					    mft record bitmap ($MFT/$BITMAP). */
-	union {
-		unsigned long nr_mft_records; /* Number of mft records. */
-		unsigned long nr_mft_bits; /* Number of bits in mft bitmap. */
-	} SN(vmm);
+	unsigned long nr_mft_records;	/* Number of mft records == number of
+					   bits in mft bitmap. */
 	struct address_space mftbmp_mapping; /* Page cache for $MFT/$BITMAP. */
 	run_list mftbmp_rl;		/* Run list for $MFT/$BITMAP. */
 	s64 mftbmp_size;		/* Data size of $MFT/$BITMAP. */
@@ -127,9 +123,6 @@
 					   only, otherwise NULL). */
 	struct nls_table *nls_map;
 } ntfs_volume;
-
-#define _VCL(X)  SC(vcl,X)
-#define _VMM(X)  SC(vmm,X)
 
 #endif /* _LINUX_NTFS_VOLUME_H */
 

===================================================================

This BitKeeper patch contains the following changesets:
aia21@cantab.net|ChangeSet|20020630124525|51727
aia21@cantab.net|ChangeSet|20020630124450|51727
aia21@cantab.net|ChangeSet|20020630124410|51727
aia21@cantab.net|ChangeSet|20020627112805|50162
## Wrapped with gzip_uu ##


begin 664 bkpatch13892
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
>K>K2!\1V'4<-%TWOWUX'09).UI/.'V2.\9LP50``
`
end
