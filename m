Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318263AbSHDXK3>; Sun, 4 Aug 2002 19:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318264AbSHDXK3>; Sun, 4 Aug 2002 19:10:29 -0400
Received: from maroon.csi.cam.ac.uk ([131.111.8.2]:48086 "EHLO
	maroon.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S318263AbSHDXKN>; Sun, 4 Aug 2002 19:10:13 -0400
Subject: [BK-2.5-PATCH] NTFS: 2.0.23 - Major bug fixes (races, deadlocks, non-i386 architectures)
To: torvalds@transmeta.com (Linus Torvalds)
Date: Mon, 5 Aug 2002 00:13:47 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17bUZH-0005hu-00@storm.christs.cam.ac.uk>
From: Anton Altaparmakov <aia21@cantab.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

	bk pull http://linux-ntfs.bkbits.net/ntfs-tng-2.5

Thanks!

This is quite a massive bug fix update. I have a dual athlon with 3G RAM
to play with at the moment so have been able to iron out a lot of races,
recursive locking, and subsequent deadlocks.

This should also fix the reported ntfs over loopback i/o error problems.
At least I can no longer reproduce the errors after I added the optimization
barrier() in fs/ntfs/compress.c. I suspect gcc screws up without it...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

This will update the following files:

 Documentation/filesystems/ntfs.txt |    8 +
 fs/ntfs/ChangeLog                  |   14 ++
 fs/ntfs/Makefile                   |    2 
 fs/ntfs/aops.c                     |   10 -
 fs/ntfs/attrib.c                   |    8 -
 fs/ntfs/compress.c                 |   23 +++-
 fs/ntfs/dir.c                      |  202 +++++++++++++++++++------------------
 fs/ntfs/inode.c                    |   47 +++++---
 fs/ntfs/inode.h                    |    3 
 fs/ntfs/malloc.h                   |   17 ---
 fs/ntfs/mft.c                      |  197 +++++++++++++-----------------------
 fs/ntfs/mft.h                      |    6 -
 fs/ntfs/namei.c                    |   38 +++---
 fs/ntfs/super.c                    |    6 -
 14 files changed, 295 insertions(+), 286 deletions(-)

through these ChangeSets:

<aia21@cantab.net> (02/08/05 1.458)
   NTFS: 2.0.23 - Major bug fixes (races, deadlocks, non-i386 architectures).
   - Massive internal locking changes to mft record locking. Fixes lock
     recursion and replaces the mrec_lock read/write semaphore with a
     mutex. Also removes the now superfluous mft_count. This fixes several
     race conditions and deadlocks, especially in the future write code.
   - Fix ntfs over loopback for compressed files by adding an
     optimization barrier. (gcc was screwing up otherwise ?)
   - Miscellaneous cleanups all over the code and a fix or two in error
     handling code paths.
   Thanks go to Christoph Hellwig for pointing out the following two:
   - Remove now unused function fs/ntfs/malloc.h::vmalloc_nofs().
   - Fix ntfs_free() for ia64 and parisc by checking for VMALLOC_END, too.


diff -Nru a/Documentation/filesystems/ntfs.txt b/Documentation/filesystems/ntfs.txt
--- a/Documentation/filesystems/ntfs.txt	Mon Aug  5 00:08:29 2002
+++ b/Documentation/filesystems/ntfs.txt	Mon Aug  5 00:08:29 2002
@@ -247,6 +247,14 @@
 
 Note, a technical ChangeLog aimed at kernel hackers is in fs/ntfs/ChangeLog.
 
+2.0.23:
+	- Massive internal locking changes to mft record locking. Fixes
+	  various race conditions and deadlocks.
+	- Fix ntfs over loopback for compressed files by adding an
+	  optimization barrier. (gcc was screwing up otherwise ?)
+	Thanks go to Christoph Hellwig for pointing these two out:
+	- Remove now unused function fs/ntfs/malloc.h::vmalloc_nofs().
+	- Fix ntfs_free() for ia64 and parisc.
 2.0.22:
 	- Small internal cleanups.
 2.0.21:
diff -Nru a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog	Mon Aug  5 00:08:29 2002
+++ b/fs/ntfs/ChangeLog	Mon Aug  5 00:08:29 2002
@@ -2,6 +2,20 @@
 	- Find and fix bugs.
 	- Enable NFS exporting of NTFS.
 
+2.0.23 - Major bug fixes (races, deadlocks, non-i386 architectures).
+
+	- Massive internal locking changes to mft record locking. Fixes lock
+	  recursion and replaces the mrec_lock read/write semaphore with a
+	  mutex. Also removes the now superfluous mft_count. This fixes several
+	  race conditions and deadlocks, especially in the future write code.
+	- Fix ntfs over loopback for compressed files by adding an
+	  optimization barrier. (gcc was screwing up otherwise ?)
+	- Miscellaneous cleanups all over the code and a fix or two in error
+	  handling code paths.
+	Thanks go to Christoph Hellwig for pointing out the following two:
+	- Remove now unused function fs/ntfs/malloc.h::vmalloc_nofs().
+	- Fix ntfs_free() for ia64 and parisc by checking for VMALLOC_END, too.
+
 2.0.22 - Cleanups, mainly to ntfs_readdir(), and use C99 initializers.
 
 	- Change fs/ntfs/dir.c::ntfs_reddir() to only read/write ->f_pos once
diff -Nru a/fs/ntfs/Makefile b/fs/ntfs/Makefile
--- a/fs/ntfs/Makefile	Mon Aug  5 00:08:29 2002
+++ b/fs/ntfs/Makefile	Mon Aug  5 00:08:29 2002
@@ -5,7 +5,7 @@
 ntfs-objs := aops.o attrib.o compress.o debug.o dir.o file.o inode.o mft.o \
 	     mst.o namei.o super.o sysctl.o time.o unistr.o upcase.o
 
-EXTRA_CFLAGS = -DNTFS_VERSION=\"2.0.22\"
+EXTRA_CFLAGS = -DNTFS_VERSION=\"2.0.23\"
 
 ifeq ($(CONFIG_NTFS_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
diff -Nru a/fs/ntfs/aops.c b/fs/ntfs/aops.c
--- a/fs/ntfs/aops.c	Mon Aug  5 00:08:29 2002
+++ b/fs/ntfs/aops.c	Mon Aug  5 00:08:29 2002
@@ -106,8 +106,6 @@
 	if (!NInoMstProtected(ni)) {
 		if (likely(page_uptodate && !PageError(page)))
 			SetPageUptodate(page);
-		unlock_page(page);
-		return;
 	} else {
 		char *addr;
 		unsigned int i, recs, nr_err;
@@ -332,6 +330,8 @@
  * for it to be read in before we can do the copy.
  *
  * Return 0 on success and -errno on error.
+ *
+ * WARNING: Do not make this function static! It is used by mft.c!
  */
 int ntfs_readpage(struct file *file, struct page *page)
 {
@@ -372,8 +372,8 @@
 	else
 		base_ni = ni->_INE(base_ntfs_ino);
 
-	/* Map, pin and lock the mft record for reading. */
-	mrec = map_mft_record(READ, base_ni);
+	/* Map, pin and lock the mft record. */
+	mrec = map_mft_record(base_ni);
 	if (unlikely(IS_ERR(mrec))) {
 		err = PTR_ERR(mrec);
 		goto err_out;
@@ -416,7 +416,7 @@
 put_unm_err_out:
 	put_attr_search_ctx(ctx);
 unm_err_out:
-	unmap_mft_record(READ, base_ni);
+	unmap_mft_record(base_ni);
 err_out:
 	unlock_page(page);
 	return err;
diff -Nru a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
--- a/fs/ntfs/attrib.c	Mon Aug  5 00:08:29 2002
+++ b/fs/ntfs/attrib.c	Mon Aug  5 00:08:29 2002
@@ -948,7 +948,7 @@
 	else
 		base_ni = ni->_INE(base_ntfs_ino);
 
-	mrec = map_mft_record(READ, base_ni);
+	mrec = map_mft_record(base_ni);
 	if (IS_ERR(mrec))
 		return PTR_ERR(mrec);
 	ctx = get_attr_search_ctx(base_ni, mrec);
@@ -979,7 +979,7 @@
 	
 	put_attr_search_ctx(ctx);
 err_out:
-	unmap_mft_record(READ, base_ni);
+	unmap_mft_record(base_ni);
 	return err;
 }
 
@@ -1671,7 +1671,7 @@
 		return;
 	} /* Attribute list. */
 	if (ctx->ntfs_ino != ctx->base_ntfs_ino)
-		unmap_mft_record(READ, ctx->ntfs_ino);
+		unmap_mft_record(ctx->ntfs_ino);
 	init_attr_search_ctx(ctx, ctx->base_ntfs_ino, ctx->base_mrec);
 	return;
 }
@@ -1704,7 +1704,7 @@
 void put_attr_search_ctx(attr_search_context *ctx)
 {
 	if (ctx->base_ntfs_ino && ctx->ntfs_ino != ctx->base_ntfs_ino)
-		unmap_mft_record(READ, ctx->ntfs_ino);
+		unmap_mft_record(ctx->ntfs_ino);
 	kmem_cache_free(ntfs_attr_ctx_cache, ctx);
 	return;
 }
diff -Nru a/fs/ntfs/compress.c b/fs/ntfs/compress.c
--- a/fs/ntfs/compress.c	Mon Aug  5 00:08:29 2002
+++ b/fs/ntfs/compress.c	Mon Aug  5 00:08:29 2002
@@ -608,8 +608,27 @@
 		if (buffer_uptodate(tbh))
 			continue;
 		wait_on_buffer(tbh);
-		if (unlikely(!buffer_uptodate(tbh)))
-			goto read_err;
+		/*      
+		 * We need an optimization barrier here, otherwise we start
+		 * hitting the below fixup code when accessing a loopback
+		 * mounted ntfs partition. This indicates either there is a
+		 * race condition in the loop driver or, more likely, gcc
+		 * overoptimises the code without the barrier and it doesn't 
+		 * do the Right Thing(TM).
+		 */      
+		barrier();
+		if (unlikely(!buffer_uptodate(tbh))) {
+			ntfs_warning(vol->sb, "Buffer is unlocked but not "
+					"uptodate! Unplugging the disk queue " 
+					"and rescheduling.");
+			get_bh(tbh);
+			blk_run_queues();
+			schedule();
+			put_bh(tbh);
+			if (unlikely(!buffer_uptodate(tbh)))
+				goto read_err;
+			ntfs_warning(vol->sb, "Buffer is now uptodate. Good.");
+		}
 	}
 
 	/*
diff -Nru a/fs/ntfs/dir.c b/fs/ntfs/dir.c
--- a/fs/ntfs/dir.c	Mon Aug  5 00:08:29 2002
+++ b/fs/ntfs/dir.c	Mon Aug  5 00:08:29 2002
@@ -76,7 +76,7 @@
 	u8 *index_end;
 	u64 mref;
 	attr_search_context *ctx;
-	int err = 0, rc;
+	int err, rc;
 	VCN vcn, old_vcn;
 	struct address_space *ia_mapping;
 	struct page *page;
@@ -84,23 +84,24 @@
 	ntfs_name *name = NULL;
 
 	/* Get hold of the mft record for the directory. */
-	m = map_mft_record(READ, dir_ni);
-	if (IS_ERR(m))
-		goto map_err_out;
-
+	m = map_mft_record(dir_ni);
+	if (unlikely(IS_ERR(m))) {
+		ntfs_error(sb, "map_mft_record() failed with error code %ld.",
+				-PTR_ERR(m));
+		return ERR_MREF(PTR_ERR(m));
+	}
 	ctx = get_attr_search_ctx(dir_ni, m);
-	if (!ctx) {
+	if (unlikely(!ctx)) {
 		err = -ENOMEM;
-		goto unm_err_out;
+		goto err_out;
 	}
-
 	/* Find the index root attribute in the mft record. */
 	if (!lookup_attr(AT_INDEX_ROOT, I30, 4, CASE_SENSITIVE, 0, NULL, 0,
 			ctx)) {
 		ntfs_error(sb, "Index root attribute missing in directory "
 				"inode 0x%lx.", dir_ni->mft_no);
 		err = -EIO;
-		goto put_unm_err_out;
+		goto err_out;
 	}
 	/* Get to the index root value (it's been verified in read_inode). */
 	ir = (INDEX_ROOT*)((u8*)ctx->attr +
@@ -154,7 +155,7 @@
 							GFP_NOFS);
 					if (!name) {
 						err = -ENOMEM;
-						goto put_unm_err_out;
+						goto err_out;
 					}
 				}
 				name->mref = le64_to_cpu(
@@ -169,7 +170,7 @@
 			}
 			mref = le64_to_cpu(ie->_IIF(indexed_file));
 			put_attr_search_ctx(ctx);
-			unmap_mft_record(READ, dir_ni);
+			unmap_mft_record(dir_ni);
 			return mref;
 		}
 		/*
@@ -208,7 +209,7 @@
 			name = kmalloc(name_size, GFP_NOFS);
 			if (!name) {
 				err = -ENOMEM;
-				goto put_unm_err_out;
+				goto err_out;
 			}
 			name->mref = le64_to_cpu(ie->_IIF(indexed_file));
 			name->type = type;
@@ -267,12 +268,12 @@
 	if (!(ie->_IEH(flags) & INDEX_ENTRY_NODE)) {
 		if (name) {
 			put_attr_search_ctx(ctx);
-			unmap_mft_record(READ, dir_ni);
+			unmap_mft_record(dir_ni);
 			return name->mref;
 		}
 		ntfs_debug("Entry not found.");
 		err = -ENOENT;
-		goto put_unm_err_out;
+		goto err_out;
 	} /* Child node present, descend into it. */
 	/* Consistency check: Verify that an index allocation exists. */
 	if (!NInoIndexAllocPresent(dir_ni)) {
@@ -280,11 +281,19 @@
 				"requires one. Directory inode 0x%lx is "
 				"corrupt or driver bug.", dir_ni->mft_no);
 		err = -EIO;
-		goto put_unm_err_out;
+		goto err_out;
 	}
 	/* Get the starting vcn of the index_block holding the child node. */
 	vcn = sle64_to_cpup((u8*)ie + le16_to_cpu(ie->_IEH(length)) - 8);
 	ia_mapping = VFS_I(dir_ni)->i_mapping;
+	/*
+	 * We are done with the index root and the mft record. Release them,
+	 * otherwise we deadlock with ntfs_map_page().
+	 */
+	put_attr_search_ctx(ctx);
+	unmap_mft_record(dir_ni);
+	m = NULL;
+	ctx = NULL;
 descend_into_child_node:
 	/*
 	 * Convert vcn to index into the index allocation attribute in units
@@ -296,7 +305,8 @@
 	if (IS_ERR(page)) {
 		ntfs_error(sb, "Failed to map directory index page, error %ld.",
 				-PTR_ERR(page));
-		goto put_unm_err_out;
+		err = PTR_ERR(page);
+		goto err_out;
 	}
 	kaddr = (u8*)page_address(page);
 fast_descend_into_child_node:
@@ -308,7 +318,7 @@
 		ntfs_error(sb, "Out of bounds check failed. Corrupt directory "
 				"inode 0x%lx or driver bug.", dir_ni->mft_no);
 		err = -EIO;
-		goto unm_unm_err_out;
+		goto unm_err_out;
 	}
 	if (sle64_to_cpu(ia->index_block_vcn) != vcn) {
 		ntfs_error(sb, "Actual VCN (0x%Lx) of index buffer is "
@@ -318,7 +328,7 @@
 				(long long)sle64_to_cpu(ia->index_block_vcn),
 				(long long)vcn, dir_ni->mft_no);
 		err = -EIO;
-		goto unm_unm_err_out;
+		goto unm_err_out;
 	}
 	if (le32_to_cpu(ia->index.allocated_size) + 0x18 !=
 			dir_ni->_IDM(index_block_size)) {
@@ -330,7 +340,7 @@
 				le32_to_cpu(ia->index.allocated_size) + 0x18,
 				dir_ni->_IDM(index_block_size));
 		err = -EIO;
-		goto unm_unm_err_out;
+		goto unm_err_out;
 	}
 	index_end = (u8*)ia + dir_ni->_IDM(index_block_size);
 	if (index_end > kaddr + PAGE_CACHE_SIZE) {
@@ -339,7 +349,7 @@
 				"Cannot access! This is probably a bug in the "
 				"driver.", (long long)vcn, dir_ni->mft_no);
 		err = -EIO;
-		goto unm_unm_err_out;
+		goto unm_err_out;
 	}
 	index_end = (u8*)&ia->index + le32_to_cpu(ia->index.index_length);
 	if (index_end > (u8*)ia + dir_ni->_IDM(index_block_size)) {
@@ -347,7 +357,7 @@
 				"inode 0x%lx exceeds maximum size.",
 				(long long)vcn, dir_ni->mft_no);
 		err = -EIO;
-		goto unm_unm_err_out;
+		goto unm_err_out;
 	}
 	/* The first index entry. */
 	ie = (INDEX_ENTRY*)((u8*)&ia->index +
@@ -367,7 +377,7 @@
 					"directory inode 0x%lx.",
 					dir_ni->mft_no);
 			err = -EIO;
-			goto unm_unm_err_out;
+			goto unm_err_out;
 		}
 		/*
 		 * The last entry cannot contain a name. It can however contain
@@ -403,7 +413,7 @@
 							GFP_NOFS);
 					if (!name) {
 						err = -ENOMEM;
-						goto unm_unm_err_out;
+						goto unm_err_out;
 					}
 				}
 				name->mref = le64_to_cpu(
@@ -418,8 +428,6 @@
 			}
 			mref = le64_to_cpu(ie->_IIF(indexed_file));
 			ntfs_unmap_page(page);
-			put_attr_search_ctx(ctx);
-			unmap_mft_record(READ, dir_ni);
 			return mref;
 		}
 		/*
@@ -459,7 +467,7 @@
 			name = kmalloc(name_size, GFP_NOFS);
 			if (!name) {
 				err = -ENOMEM;
-				goto put_unm_err_out;
+				goto unm_err_out;
 			}
 			name->mref = le64_to_cpu(ie->_IIF(indexed_file));
 			name->type = type;
@@ -519,7 +527,7 @@
 					"a leaf node in directory inode 0x%lx.",
 					dir_ni->mft_no);
 			err = -EIO;
-			goto unm_unm_err_out;
+			goto unm_err_out;
 		}
 		/* Child node present, descend into it. */
 		old_vcn = vcn;
@@ -539,7 +547,7 @@
 		ntfs_error(sb, "Negative child node vcn in directory inode "
 				"0x%lx.", dir_ni->mft_no);
 		err = -EIO;
-		goto unm_unm_err_out;
+		goto unm_err_out;
 	}
 	/*
 	 * No child node present, return -ENOENT, unless we have got a matching
@@ -548,31 +556,26 @@
 	 */
 	if (name) {
 		ntfs_unmap_page(page);
-		put_attr_search_ctx(ctx);
-		unmap_mft_record(READ, dir_ni);
 		return name->mref;
 	}
 	ntfs_debug("Entry not found.");
 	err = -ENOENT;
-unm_unm_err_out:
-	ntfs_unmap_page(page);
-put_unm_err_out:
-	put_attr_search_ctx(ctx);
 unm_err_out:
-	unmap_mft_record(READ, dir_ni);
+	ntfs_unmap_page(page);
+err_out:
+	if (ctx)
+		put_attr_search_ctx(ctx);
+	if (m)
+		unmap_mft_record(dir_ni);
 	if (name) {
 		kfree(name);
 		*res = NULL;
 	}
 	return ERR_MREF(err);
-map_err_out:
-	ntfs_error(sb, "map_mft_record(READ) failed with error code %ld.",
-			-PTR_ERR(m));
-	return ERR_MREF(PTR_ERR(m));
 dir_err_out:
 	ntfs_error(sb, "Corrupt directory. Aborting lookup.");
 	err = -EIO;
-	goto put_unm_err_out;
+	goto err_out;
 }
 
 #if 0
@@ -614,7 +617,7 @@
 	u8 *index_end;
 	u64 mref;
 	attr_search_context *ctx;
-	int err = 0, rc;
+	int err, rc;
 	IGNORE_CASE_BOOL ic;
 	VCN vcn, old_vcn;
 	struct address_space *ia_mapping;
@@ -622,23 +625,24 @@
 	u8 *kaddr;
 
 	/* Get hold of the mft record for the directory. */
-	m = map_mft_record(READ, dir_ni);
-	if (IS_ERR(m))
-		goto map_err_out;
-
+	m = map_mft_record(dir_ni);
+	if (IS_ERR(m)) {
+		ntfs_error(sb, "map_mft_record() failed with error code %ld.",
+				-PTR_ERR(m));
+		return ERR_MREF(PTR_ERR(m));
+	}
 	ctx = get_attr_search_ctx(dir_ni, m);
 	if (!ctx) {
 		err = -ENOMEM;
-		goto unm_err_out;
+		goto err_out;
 	}
-
 	/* Find the index root attribute in the mft record. */
 	if (!lookup_attr(AT_INDEX_ROOT, I30, 4, CASE_SENSITIVE, 0, NULL, 0,
 			ctx)) {
 		ntfs_error(sb, "Index root attribute missing in directory "
 				"inode 0x%lx.", dir_ni->mft_no);
 		err = -EIO;
-		goto put_unm_err_out;
+		goto err_out;
 	}
 	/* Get to the index root value (it's been verified in read_inode). */
 	ir = (INDEX_ROOT*)((u8*)ctx->attr +
@@ -689,7 +693,7 @@
 found_it:
 			mref = le64_to_cpu(ie->_IIF(indexed_file));
 			put_attr_search_ctx(ctx);
-			unmap_mft_record(READ, dir_ni);
+			unmap_mft_record(dir_ni);
 			return mref;
 		}
 		/*
@@ -737,7 +741,7 @@
 	if (!(ie->_IEH(flags) & INDEX_ENTRY_NODE)) {
 		/* No child node, return -ENOENT. */
 		err = -ENOENT;
-		goto put_unm_err_out;
+		goto err_out;
 	} /* Child node present, descend into it. */
 	/* Consistency check: Verify that an index allocation exists. */
 	if (!NInoIndexAllocPresent(dir_ni)) {
@@ -745,11 +749,19 @@
 				"requires one. Directory inode 0x%lx is "
 				"corrupt or driver bug.", dir_ni->mft_no);
 		err = -EIO;
-		goto put_unm_err_out;
+		goto err_out;
 	}
 	/* Get the starting vcn of the index_block holding the child node. */
 	vcn = sle64_to_cpup((u8*)ie + le16_to_cpu(ie->_IEH(length)) - 8);
 	ia_mapping = VFS_I(dir_ni)->i_mapping;
+	/*
+	 * We are done with the index root and the mft record. Release them,
+	 * otherwise we deadlock with ntfs_map_page().
+	 */
+	put_attr_search_ctx(ctx);
+	unmap_mft_record(dir_ni);
+	m = NULL;
+	ctx = NULL;
 descend_into_child_node:
 	/*
 	 * Convert vcn to index into the index allocation attribute in units
@@ -761,7 +773,8 @@
 	if (IS_ERR(page)) {
 		ntfs_error(sb, "Failed to map directory index page, error %ld.",
 				-PTR_ERR(page));
-		goto put_unm_err_out;
+		err = PTR_ERR(page);
+		goto err_out;
 	}
 	kaddr = (u8*)page_address(page);
 fast_descend_into_child_node:
@@ -773,7 +786,7 @@
 		ntfs_error(sb, "Out of bounds check failed. Corrupt directory "
 				"inode 0x%lx or driver bug.", dir_ni->mft_no);
 		err = -EIO;
-		goto unm_unm_err_out;
+		goto unm_err_out;
 	}
 	if (sle64_to_cpu(ia->index_block_vcn) != vcn) {
 		ntfs_error(sb, "Actual VCN (0x%Lx) of index buffer is "
@@ -783,7 +796,7 @@
 				(long long)sle64_to_cpu(ia->index_block_vcn),
 				(long long)vcn, dir_ni->mft_no);
 		err = -EIO;
-		goto unm_unm_err_out;
+		goto unm_err_out;
 	}
 	if (le32_to_cpu(ia->index.allocated_size) + 0x18 !=
 			dir_ni->_IDM(index_block_size)) {
@@ -795,7 +808,7 @@
 				le32_to_cpu(ia->index.allocated_size) + 0x18,
 				dir_ni->_IDM(index_block_size));
 		err = -EIO;
-		goto unm_unm_err_out;
+		goto unm_err_out;
 	}
 	index_end = (u8*)ia + dir_ni->_IDM(index_block_size);
 	if (index_end > kaddr + PAGE_CACHE_SIZE) {
@@ -804,7 +817,7 @@
 				"Cannot access! This is probably a bug in the "
 				"driver.", (long long)vcn, dir_ni->mft_no);
 		err = -EIO;
-		goto unm_unm_err_out;
+		goto unm_err_out;
 	}
 	index_end = (u8*)&ia->index + le32_to_cpu(ia->index.index_length);
 	if (index_end > (u8*)ia + dir_ni->_IDM(index_block_size)) {
@@ -812,7 +825,7 @@
 				"inode 0x%lx exceeds maximum size.",
 				(long long)vcn, dir_ni->mft_no);
 		err = -EIO;
-		goto unm_unm_err_out;
+		goto unm_err_out;
 	}
 	/* The first index entry. */
 	ie = (INDEX_ENTRY*)((u8*)&ia->index +
@@ -832,7 +845,7 @@
 					"directory inode 0x%lx.",
 					dir_ni->mft_no);
 			err = -EIO;
-			goto unm_unm_err_out;
+			goto unm_err_out;
 		}
 		/*
 		 * The last entry cannot contain a name. It can however contain
@@ -865,8 +878,6 @@
 found_it2:
 			mref = le64_to_cpu(ie->_IIF(indexed_file));
 			ntfs_unmap_page(page);
-			put_attr_search_ctx(ctx);
-			unmap_mft_record(READ, dir_ni);
 			return mref;
 		}
 		/*
@@ -917,7 +928,7 @@
 					"a leaf node in directory inode 0x%lx.",
 					dir_ni->mft_no);
 			err = -EIO;
-			goto unm_unm_err_out;
+			goto unm_err_out;
 		}
 		/* Child node present, descend into it. */
 		old_vcn = vcn;
@@ -937,26 +948,23 @@
 		ntfs_error(sb, "Negative child node vcn in directory inode "
 				"0x%lx.", dir_ni->mft_no);
 		err = -EIO;
-		goto unm_unm_err_out;
+		goto unm_err_out;
 	}
 	/* No child node, return -ENOENT. */
 	ntfs_debug("Entry not found.");
 	err = -ENOENT;
-unm_unm_err_out:
-	ntfs_unmap_page(page);
-put_unm_err_out:
-	put_attr_search_ctx(ctx);
 unm_err_out:
-	unmap_mft_record(READ, dir_ni);
+	ntfs_unmap_page(page);
+err_out:
+	if (ctx)
+		put_attr_search_ctx(ctx);
+	if (m)
+		unmap_mft_record(dir_ni);
 	return ERR_MREF(err);
-map_err_out:
-	ntfs_error(sb, "map_mft_record(READ) failed with error code %ld.",
-			-PTR_ERR(m));
-	return ERR_MREF(PTR_ERR(m));
 dir_err_out:
 	ntfs_error(sb, "Corrupt directory. Aborting lookup.");
 	err = -EIO;
-	goto put_unm_err_out;
+	goto err_out;
 }
 
 #endif
@@ -1095,22 +1103,8 @@
 			goto done;
 		fpos++;
 	}
-
-	/* Get hold of the mft record for the directory. */
-	m = map_mft_record(READ, ndir);
-	if (unlikely(IS_ERR(m))) {
-		err = PTR_ERR(m);
-		m = NULL;
-		ctx = NULL;
-		goto err_out;
-	}
-
-	ctx = get_attr_search_ctx(ndir, m);
-	if (unlikely(!ctx)) {
-		err = -ENOMEM;
-		goto err_out;
-	}
-
+	m = NULL;
+	ctx = NULL;
 	/*
 	 * Allocate a buffer to store the current name being processed
 	 * converted to format determined by current NLS.
@@ -1124,6 +1118,18 @@
 	/* Are we jumping straight into the index allocation attribute? */
 	if (fpos >= vol->mft_record_size)
 		goto skip_index_root;
+	/* Get hold of the mft record for the directory. */
+	m = map_mft_record(ndir);
+	if (unlikely(IS_ERR(m))) {
+		err = PTR_ERR(m);
+		m = NULL;
+		goto err_out;
+	}
+	ctx = get_attr_search_ctx(ndir, m);
+	if (unlikely(!ctx)) {
+		err = -ENOMEM;
+		goto err_out;
+	}
 	/* Get the offset into the index root attribute. */
 	ir_pos = (s64)fpos;
 	/* Find the index root attribute in the mft record. */
@@ -1162,9 +1168,21 @@
 		/* Submit the name to the filldir callback. */
 		rc = ntfs_filldir(vol, &fpos, ndir, INDEX_TYPE_ROOT, ir, ie,
 				name, dirent, filldir);
-		if (rc)
+		if (rc) {
+			put_attr_search_ctx(ctx);
+			unmap_mft_record(ndir);
 			goto abort;
+		}
 	}
+	/*
+	 * We are done with the index root and the mft record for that matter.
+	 * We need to release it, otherwise we deadlock on ntfs_attr_iget()
+	 * and/or ntfs_read_page().
+	 */
+	put_attr_search_ctx(ctx);
+	unmap_mft_record(ndir);
+	m = NULL; 
+	ctx = NULL;
 	/* If there is no index allocation attribute we are finished. */
 	if (!NInoIndexAllocPresent(ndir))
 		goto EOD;
@@ -1197,7 +1215,7 @@
 	}
 	/* Get the starting bit position in the current bitmap page. */
 	cur_bmp_pos = bmp_pos & ((PAGE_CACHE_SIZE * 8) - 1);
-	bmp_pos &= ~((PAGE_CACHE_SIZE * 8) - 1);
+	bmp_pos &= ~(u64)((PAGE_CACHE_SIZE * 8) - 1);
 get_next_bmp_page:
 	ntfs_debug("Reading bitmap with page index 0x%Lx, bit ofs 0x%Lx",
 			(long long)bmp_pos >> (3 + PAGE_CACHE_SHIFT),
@@ -1343,8 +1361,6 @@
 	/* We are finished, set fpos to EOD. */
 	fpos = vdir->i_size + vol->mft_record_size;
 abort:
-	put_attr_search_ctx(ctx);
-	unmap_mft_record(READ, ndir);
 	kfree(name);
 done:
 #ifdef DEBUG
@@ -1366,7 +1382,7 @@
 	if (ctx)
 		put_attr_search_ctx(ctx);
 	if (m)
-		unmap_mft_record(READ, ndir);
+		unmap_mft_record(ndir);
 	if (!err)
 		err = -EIO;
 	ntfs_debug("Failed. Returning error code %i.", -err);
diff -Nru a/fs/ntfs/inode.c b/fs/ntfs/inode.c
--- a/fs/ntfs/inode.c	Mon Aug  5 00:08:29 2002
+++ b/fs/ntfs/inode.c	Mon Aug  5 00:08:29 2002
@@ -278,7 +278,7 @@
 	ntfs_inode *ni = NTFS_I(inode);
 
 	ntfs_debug("Entering.");
-	BUG_ON(atomic_read(&ni->mft_count) || !atomic_dec_and_test(&ni->count));
+	BUG_ON(ni->page || !atomic_dec_and_test(&ni->count));
 	kmem_cache_free(ntfs_big_inode_cache, NTFS_I(inode));
 }
 
@@ -299,7 +299,7 @@
 void ntfs_destroy_extent_inode(ntfs_inode *ni)
 {
 	ntfs_debug("Entering.");
-	BUG_ON(atomic_read(&ni->mft_count) || !atomic_dec_and_test(&ni->count));
+	BUG_ON(ni->page || !atomic_dec_and_test(&ni->count));
 	kmem_cache_free(ntfs_inode_cache, ni);
 }
 
@@ -323,8 +323,7 @@
 	atomic_set(&ni->count, 1);
 	ni->vol = NTFS_SB(sb);
 	init_run_list(&ni->run_list);
-	init_rwsem(&ni->mrec_lock);
-	atomic_set(&ni->mft_count, 0);
+	init_MUTEX(&ni->mrec_lock);
 	ni->page = NULL;
 	ni->page_ofs = 0;
 	ni->attr_list_size = 0;
@@ -504,7 +503,7 @@
 		ntfs_init_big_inode(vi);
 	ni = NTFS_I(vi);
 
-	m = map_mft_record(READ, ni);
+	m = map_mft_record(ni);
 	if (IS_ERR(m)) {
 		err = PTR_ERR(m);
 		goto err_out;
@@ -790,6 +789,11 @@
 			/* No index allocation. */
 			vi->i_size = ni->initialized_size =
 					ni->allocated_size = 0;
+			/* We are done with the mft record, so we release it. */
+			put_attr_search_ctx(ctx);
+			unmap_mft_record(ni);
+			m = NULL;
+			ctx = NULL;
 			goto skip_large_dir_stuff;
 		} /* LARGE_INDEX: Index allocation present. Setup state. */
 		NInoSetIndexAllocPresent(ni);
@@ -834,7 +838,14 @@
 				ctx->attr->_ANR(initialized_size));
 		ni->allocated_size = sle64_to_cpu(
 				ctx->attr->_ANR(allocated_size));
-
+		/*
+		 * We are done with the mft record, so we release it. Otherwise
+		 *
+		 */
+		put_attr_search_ctx(ctx);
+		unmap_mft_record(ni);
+		m = NULL;
+		ctx = NULL;
 		/* Get the index bitmap attribute inode. */
 		bvi = ntfs_attr_iget(vi, AT_BITMAP, I30, 4);
 		if (unlikely(IS_ERR(bvi))) {
@@ -858,7 +869,6 @@
 					bvi->i_size << 3, vi->i_size);
 			goto unm_err_out;
 		}
-
 skip_large_dir_stuff:
 		/* Everyone gets read and scan permissions. */
 		vi->i_mode |= S_IRUGO | S_IXUGO;
@@ -998,6 +1008,11 @@
 				le32_to_cpu(ctx->attr->_ARA(value_length));
 		}
 no_data_attr_special_case:
+		/* We are done with the mft record, so we release it. */
+		put_attr_search_ctx(ctx);
+		unmap_mft_record(ni);
+		m = NULL;
+		ctx = NULL;
 		/* Everyone gets all permissions. */
 		vi->i_mode |= S_IRWXUGO;
 		/* If read-only, noone gets write permissions. */
@@ -1026,9 +1041,6 @@
 	else
 		vi->i_blocks = ni->_ICF(compressed_size) >> 9;
 
-	put_attr_search_ctx(ctx);
-	unmap_mft_record(READ, ni);
-
 	ntfs_debug("Done.");
 	return 0;
 
@@ -1037,7 +1049,8 @@
 		err = -EIO;
 	if (ctx)
 		put_attr_search_ctx(ctx);
-	unmap_mft_record(READ, ni);
+	if (m)
+		unmap_mft_record(ni);
 err_out:
 	ntfs_error(vi->i_sb, "Failed with error code %i. Marking inode 0x%lx "
 			"as bad.", -err, vi->i_ino);
@@ -1091,7 +1104,7 @@
 	/* Set inode type to zero but preserve permissions. */
 	vi->i_mode	= base_vi->i_mode & ~S_IFMT;
 
-	m = map_mft_record(READ, base_ni);
+	m = map_mft_record(base_ni);
 	if (IS_ERR(m)) {
 		err = PTR_ERR(m);
 		goto err_out;
@@ -1265,7 +1278,7 @@
 	ni->nr_extents = -1;
 
 	put_attr_search_ctx(ctx);
-	unmap_mft_record(READ, base_ni);
+	unmap_mft_record(base_ni);
 
 	ntfs_debug("Done.");
 	return 0;
@@ -1275,7 +1288,7 @@
 		err = -EIO;
 	if (ctx)
 		put_attr_search_ctx(ctx);
-	unmap_mft_record(READ, base_ni);
+	unmap_mft_record(base_ni);
 err_out:
 	ntfs_error(vi->i_sb, "Failed with error code %i while reading "
 			"attribute inode (mft_no 0x%lx, type 0x%x, name_len "
@@ -1398,7 +1411,7 @@
 	/* Need this to sanity check attribute list references to $MFT. */
 	ni->seq_no = le16_to_cpu(m->sequence_number);
 
-	/* Provides readpage() and sync_page() for map_mft_record(READ). */
+	/* Provides readpage() and sync_page() for map_mft_record(). */
 	vi->i_mapping->a_ops = &ntfs_mft_aops;
 
 	ctx = get_attr_search_ctx(ni, m);
@@ -1795,8 +1808,8 @@
 		}
 	}
 	/* Synchronize with ntfs_commit_inode(). */
-	down_write(&ni->mrec_lock);
-	up_write(&ni->mrec_lock);
+	down(&ni->mrec_lock);
+	up(&ni->mrec_lock);
 	if (NInoDirty(ni)) {
 		ntfs_error(ni->vol->sb, "Failed to commit dirty inode "
 				"asynchronously.");
diff -Nru a/fs/ntfs/inode.h b/fs/ntfs/inode.h
--- a/fs/ntfs/inode.h	Mon Aug  5 00:08:29 2002
+++ b/fs/ntfs/inode.h	Mon Aug  5 00:08:29 2002
@@ -72,9 +72,8 @@
 	 * The following fields are only valid for real inodes and extent
 	 * inodes.
 	 */
-	struct rw_semaphore mrec_lock;	/* Lock for serializing access to the
+	struct semaphore mrec_lock; /* Lock for serializing access to the
 				   mft record belonging to this inode. */
-	atomic_t mft_count;	/* Mapping reference count for book keeping. */
 	struct page *page;	/* The page containing the mft record of the
 				   inode. This should only be touched by the
 				   (un)map_mft_record*() functions. */
diff -Nru a/fs/ntfs/malloc.h b/fs/ntfs/malloc.h
--- a/fs/ntfs/malloc.h	Mon Aug  5 00:08:29 2002
+++ b/fs/ntfs/malloc.h	Mon Aug  5 00:08:29 2002
@@ -26,20 +26,6 @@
 #include <linux/slab.h>
 
 /**
- * vmalloc_nofs - allocate any pages but don't allow calls into fs layer
- * @size:	number of bytes to allocate
- *
- * Allocate any pages but don't allow calls into fs layer. Return allocated
- * memory or NULL if insufficient memory.
- */
-static inline void *vmalloc_nofs(unsigned long size)
-{
-	if (likely(size >> PAGE_SHIFT < num_physpages))
-		return __vmalloc(size, GFP_NOFS | __GFP_HIGHMEM, PAGE_KERNEL);
-	return NULL;
-}
-
-/**
  * ntfs_malloc_nofs - allocate memory in multiples of pages
  * @size	number of bytes to allocate
  *
@@ -66,7 +52,8 @@
 
 static inline void ntfs_free(void *addr)
 {
-	if (likely((unsigned long)addr < VMALLOC_START)) {
+	if (likely(((unsigned long)addr < VMALLOC_START) ||
+			((unsigned long)addr >= VMALLOC_END ))) {
 		return kfree(addr);
 		/* return free_page((unsigned long)addr); */
 	}
diff -Nru a/fs/ntfs/mft.c b/fs/ntfs/mft.c
--- a/fs/ntfs/mft.c	Mon Aug  5 00:08:29 2002
+++ b/fs/ntfs/mft.c	Mon Aug  5 00:08:29 2002
@@ -2,7 +2,7 @@
  * mft.c - NTFS kernel mft record operations. Part of the Linux-NTFS project.
  *
  * Copyright (c) 2001,2002 Anton Altaparmakov.
- * Copyright (C) 2002 Richard Russon.
+ * Copyright (c) 2002 Richard Russon.
  *
  * This program/include file is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as published
@@ -85,13 +85,15 @@
 	if (mft_rec)
 		m = mft_rec;
 	else {
-		m = map_mft_record(WRITE, ni);
+		m = map_mft_record(ni);
 		if (IS_ERR(m))
 			return PTR_ERR(m);
 	}
 	__format_mft_record(m, ni->vol->mft_record_size, ni->mft_no);
-	if (!mft_rec)
-		unmap_mft_record(WRITE, ni);
+	if (!mft_rec) {
+		// FIXME: Need to set the mft record dirty!
+		unmap_mft_record(ni);
+	}
 	return 0;
 }
 
@@ -132,7 +134,7 @@
 	struct page *page;
 	unsigned long index, ofs, end_index;
 
-	BUG_ON(atomic_read(&ni->mft_count) || ni->page);
+	BUG_ON(ni->page);
 	/*
 	 * The index into the page cache and the offset within the page cache
 	 * page of the wanted mft record. FIXME: We need to check for
@@ -146,70 +148,36 @@
 	end_index = mft_vi->i_size >> PAGE_CACHE_SHIFT;
 
 	/* If the wanted index is out of bounds the mft record doesn't exist. */
-	if (index >= end_index) {
+	if (unlikely(index >= end_index)) {
 		if (index > end_index || (mft_vi->i_size & ~PAGE_CACHE_MASK) <
 				ofs + vol->mft_record_size) {
 			page = ERR_PTR(-ENOENT);
-			goto up_err_out;
+			goto err_out;
 		}
 	}
 	/* Read, map, and pin the page. */
 	page = ntfs_map_page(mft_vi->i_mapping, index);
-	if (!IS_ERR(page)) {
-		/* Pin the mft record mapping in the ntfs_inode. */
-		atomic_inc(&ni->mft_count);
-
-		/* Setup the references in the ntfs_inode. */
+	if (likely(!IS_ERR(page))) {
 		ni->page = page;
 		ni->page_ofs = ofs;
-
 		return page_address(page) + ofs;
 	}
-up_err_out:
-	/* Just in case... */
+err_out:
 	ni->page = NULL;
 	ni->page_ofs = 0;
-
 	ntfs_error(vol->sb, "Failed with error code %lu.", -PTR_ERR(page));
 	return (void*)page;
 }
 
 /**
- * unmap_mft_record_page - unmap the page in which a specific mft record resides
- * @ni:		ntfs inode whose mft record page to unmap
- *
- * This unmaps the page in which the mft record of the ntfs inode @ni is
- * situated and returns. This is a NOOP if highmem is not configured.
- *
- * The unmap happens via ntfs_unmap_page() which in turn decrements the use
- * count on the page thus releasing it from the pinned state.
- *
- * We do not actually unmap the page from memory of course, as that will be
- * done by the page cache code itself when memory pressure increases or
- * whatever.
- */
-static inline void unmap_mft_record_page(ntfs_inode *ni)
-{
-	BUG_ON(atomic_read(&ni->mft_count) || !ni->page);
-	// TODO: If dirty, blah...
-	ntfs_unmap_page(ni->page);
-	ni->page = NULL;
-	ni->page_ofs = 0;
-	return;
-}
-
-/**
  * map_mft_record - map, pin and lock an mft record
- * @rw:		map for read (rw = READ) or write (rw = WRITE)
  * @ni:		ntfs inode whose MFT record to map
  *
- * First, take the mrec_lock semaphore for reading or writing, depending on
- * the value or @rw. We might now be sleeping, while waiting for the semaphore
- * if it was already locked by someone else.
- *
- * Then increment the map reference count and return the mft. If this is the
- * first invocation, the page of the record is first mapped using
- * map_mft_record_page().
+ * First, take the mrec_lock semaphore. We might now be sleeping, while waiting
+ * for the semaphore if it was already locked by someone else.
+ *
+ * The page of the record is first mapped using map_mft_record_page() before
+ * being returned to the caller.
  *
  * This in turn uses ntfs_map_page() to get the page containing the wanted mft
  * record (it in turn calls read_cache_page() which reads it in from disk if
@@ -234,11 +202,11 @@
  * locking problem then is them locking the page while we are accessing it.
  *
  * So that code will end up having to own the mrec_lock of all mft
- * records/inodes present in the page before I/O can proceed. Grr. In that
- * case we wouldn't need need to bother with PG_locked and PG_uptodate as
- * nobody will be accessing anything without owning the mrec_lock semaphore.
- * But we do need to use them because of the read_cache_page() invokation and
- * the code becomes so much simpler this way that it is well worth it.
+ * records/inodes present in the page before I/O can proceed. In that case we
+ * wouldn't need to bother with PG_locked and PG_uptodate as nobody will be
+ * accessing anything without owning the mrec_lock semaphore. But we do need
+ * to use them because of the read_cache_page() invokation and the code becomes
+ * so much simpler this way that it is well worth it.
  *
  * The mft record is now ours and we return a pointer to it. You need to check
  * the returned pointer with IS_ERR() and if that is true, PTR_ERR() will return
@@ -251,89 +219,75 @@
  * A: No, the inode ones mean we want to change the mft record, not we want to
  * write it out.
  */
-MFT_RECORD *map_mft_record(const int rw, ntfs_inode *ni)
+MFT_RECORD *map_mft_record(ntfs_inode *ni)
 {
 	MFT_RECORD *m;
 
-	ntfs_debug("Entering for mft_no 0x%lx, mapping for %s.", ni->mft_no,
-			rw == READ ? "READ" : "WRITE");
+	ntfs_debug("Entering for mft_no 0x%lx.", ni->mft_no);
 
 	/* Make sure the ntfs inode doesn't go away. */
 	atomic_inc(&ni->count);
 
 	/* Serialize access to this mft record. */
-	if (rw == READ)
-		down_read(&ni->mrec_lock);
-	else
-		down_write(&ni->mrec_lock);
-
-	/* If already mapped, bump reference count and return the mft record. */
-	if (atomic_read(&ni->mft_count)) {
-		BUG_ON(!ni->page);
-		atomic_inc(&ni->mft_count);
-		return page_address(ni->page) + ni->page_ofs;
-	}
+	down(&ni->mrec_lock);
 
-	/* Wasn't mapped. Map it now and return it if all was ok. */
 	m = map_mft_record_page(ni);
-	if (!IS_ERR(m))
+	if (likely(!IS_ERR(m)))
 		return m;
 
-	/* Mapping failed. Release the mft record lock. */
-	if (rw == READ)
-		up_read(&ni->mrec_lock);
-	else
-		up_write(&ni->mrec_lock);
-
-	ntfs_error(ni->vol->sb, "Failed with error code %lu.", -PTR_ERR(m));
-
-	/* Release the ntfs inode and return the error code. */
+	up(&ni->mrec_lock);
 	atomic_dec(&ni->count);
+	ntfs_error(ni->vol->sb, "Failed with error code %lu.", -PTR_ERR(m));
 	return m;
 }
 
 /**
- * unmap_mft_record - release a mapped mft record
- * @rw:		unmap from read (@rw = READ) or write (@rw = WRITE)
- * @ni:		ntfs inode whose MFT record to unmap
- *
- * First, decrement the mapping count and when it reaches zero unmap the mft
- * record.
+ * unmap_mft_record_page - unmap the page in which a specific mft record resides
+ * @ni:		ntfs inode whose mft record page to unmap
  *
- * Second, release the mrec_lock semaphore.
+ * This unmaps the page in which the mft record of the ntfs inode @ni is
+ * situated and returns. This is a NOOP if highmem is not configured.
  *
- * The mft record is now released for others to get hold of.
+ * The unmap happens via ntfs_unmap_page() which in turn decrements the use
+ * count on the page thus releasing it from the pinned state.
  *
- * Finally, release the ntfs inode by decreasing the ntfs inode reference count.
+ * We do not actually unmap the page from memory of course, as that will be
+ * done by the page cache code itself when memory pressure increases or
+ * whatever.
+ */
+static inline void unmap_mft_record_page(ntfs_inode *ni)
+{
+	BUG_ON(!ni->page);
+
+	// TODO: If dirty, blah...
+	ntfs_unmap_page(ni->page);
+	ni->page = NULL;
+	ni->page_ofs = 0;
+	return;
+}
+
+/**
+ * unmap_mft_record - release a mapped mft record
+ * @ni:		ntfs inode whose MFT record to unmap
  *
- * NOTE: If caller had the mft record mapped for write and has modified it, it
- * is imperative to set the mft record dirty BEFORE calling unmap_mft_record().
+ * We release the page mapping and the mrec_lock mutex which unmaps the mft
+ * record and releases it for others to get hold of. We also release the ntfs
+ * inode by decrementing the ntfs inode reference count.
  *
- * NOTE: This has to be done both for 'normal' mft records, and for extent mft
- * records.
+ * NOTE: If caller has modified the mft record, it is imperative to set the mft
+ * record dirty BEFORE calling unmap_mft_record().
  */
-void unmap_mft_record(const int rw, ntfs_inode *ni)
+void unmap_mft_record(ntfs_inode *ni)
 {
 	struct page *page = ni->page;
 
-	BUG_ON(!atomic_read(&ni->mft_count) || !page);
+	BUG_ON(!page);
 
-	ntfs_debug("Entering for mft_no 0x%lx, unmapping from %s.", ni->mft_no,
-			rw == READ ? "READ" : "WRITE");
+	ntfs_debug("Entering for mft_no 0x%lx.", ni->mft_no);
 
-	/* Only release the actual page mapping if this is the last one. */
-	if (atomic_dec_and_test(&ni->mft_count))
-		unmap_mft_record_page(ni);
-
-	/* Release the semaphore. */
-	if (rw == READ)
-		up_read(&ni->mrec_lock);
-	else
-		up_write(&ni->mrec_lock);
-
-	/* Release the ntfs inode. */
+	unmap_mft_record_page(ni);
+	up(&ni->mrec_lock);
 	atomic_dec(&ni->count);
-
 	/*
 	 * If pure ntfs_inode, i.e. no vfs inode attached, we leave it to
 	 * ntfs_clear_extent_inode() in the extent inode case, and to the
@@ -355,11 +309,6 @@
  *
  * On successful return, @ntfs_ino contains a pointer to the ntfs_inode
  * structure of the mapped extent inode.
- *
- * Note, we always map for READ. We consider this lock as irrelevant because
- * the base inode will be write locked in all cases when we want to write to
- * an extent inode which already gurantees that there is no-one else accessing
- * the extent inode.
  */
 MFT_RECORD *map_extent_mft_record(ntfs_inode *base_ni, MFT_REF mref,
 		ntfs_inode **ntfs_ino)
@@ -393,21 +342,21 @@
 			break;
 		}
 	}
-	if (ni) {
+	if (likely(ni != NULL)) {
 		up(&base_ni->extent_lock);
 		atomic_dec(&base_ni->count);
 		/* We found the record; just have to map and return it. */
-		m = map_mft_record(READ, ni);
-		/* Map mft record increments this on success. */
+		m = map_mft_record(ni);
+		/* map_mft_record() has incremented this on success. */
 		atomic_dec(&ni->count);
-		if (!IS_ERR(m)) {
+		if (likely(!IS_ERR(m))) {
 			/* Verify the sequence number. */
-			if (le16_to_cpu(m->sequence_number) == seq_no) {
+			if (likely(le16_to_cpu(m->sequence_number) == seq_no)) {
 				ntfs_debug("Done 1.");
 				*ntfs_ino = ni;
 				return m;
 			}
-			unmap_mft_record(READ, ni);
+			unmap_mft_record(ni);
 			ntfs_error(base_ni->vol->sb, "Found stale extent mft "
 					"reference! Corrupt file system. "
 					"Run chkdsk.");
@@ -420,7 +369,7 @@
 	}
 	/* Record wasn't there. Get a new ntfs inode and initialize it. */
 	ni = ntfs_new_extent_inode(base_ni->vol->sb, mft_no);
-	if (!ni) {
+	if (unlikely(!ni)) {
 		up(&base_ni->extent_lock);
 		atomic_dec(&base_ni->count);
 		return ERR_PTR(-ENOMEM);
@@ -430,15 +379,15 @@
 	ni->nr_extents = -1;
 	ni->_INE(base_ntfs_ino) = base_ni;
 	/* Now map the record. */
-	m = map_mft_record(READ, ni);
-	if (IS_ERR(m)) {
+	m = map_mft_record(ni);
+	if (unlikely(IS_ERR(m))) {
 		up(&base_ni->extent_lock);
 		atomic_dec(&base_ni->count);
 		ntfs_clear_extent_inode(ni);
 		goto map_err_out;
 	}
 	/* Verify the sequence number. */
-	if (le16_to_cpu(m->sequence_number) != seq_no) {
+	if (unlikely(le16_to_cpu(m->sequence_number) != seq_no)) {
 		ntfs_error(base_ni->vol->sb, "Found stale extent mft "
 				"reference! Corrupt file system. Run chkdsk.");
 		destroy_ni = TRUE;
@@ -451,7 +400,7 @@
 		int new_size = (base_ni->nr_extents + 4) * sizeof(ntfs_inode *);
 
 		tmp = (ntfs_inode **)kmalloc(new_size, GFP_NOFS);
-		if (!tmp) {
+		if (unlikely(!tmp)) {
 			ntfs_error(base_ni->vol->sb, "Failed to allocate "
 					"internal buffer.");
 			destroy_ni = TRUE;
@@ -472,7 +421,7 @@
 	*ntfs_ino = ni;
 	return m;
 unm_err_out:
-	unmap_mft_record(READ, ni);
+	unmap_mft_record(ni);
 	up(&base_ni->extent_lock);
 	atomic_dec(&base_ni->count);
 	/*
diff -Nru a/fs/ntfs/mft.h b/fs/ntfs/mft.h
--- a/fs/ntfs/mft.h	Mon Aug  5 00:08:29 2002
+++ b/fs/ntfs/mft.h	Mon Aug  5 00:08:29 2002
@@ -31,15 +31,15 @@
 //extern int format_mft_record2(struct super_block *vfs_sb,
 //		const unsigned long inum, MFT_RECORD *m);
 
-extern MFT_RECORD *map_mft_record(const int rw, ntfs_inode *ni);
-extern void unmap_mft_record(const int rw, ntfs_inode *ni);
+extern MFT_RECORD *map_mft_record(ntfs_inode *ni);
+extern void unmap_mft_record(ntfs_inode *ni);
 
 extern MFT_RECORD *map_extent_mft_record(ntfs_inode *base_ni, MFT_REF mref,
 		ntfs_inode **ntfs_ino);
 
 static inline void unmap_extent_mft_record(ntfs_inode *ni)
 {
-	unmap_mft_record(READ, ni);
+	unmap_mft_record(ni);
 	return;
 }
 
diff -Nru a/fs/ntfs/namei.c b/fs/ntfs/namei.c
--- a/fs/ntfs/namei.c	Mon Aug  5 00:08:29 2002
+++ b/fs/ntfs/namei.c	Mon Aug  5 00:08:29 2002
@@ -162,6 +162,7 @@
 handle_name:
    {
 	struct dentry *real_dent;
+	MFT_RECORD *m;
 	attr_search_context *ctx;
 	ntfs_inode *ni = NTFS_I(dent_inode);
 	int err;
@@ -175,22 +176,23 @@
 				name->len * 3 + 1);
 		kfree(name);
 	} else /* if (name->type == FILE_NAME_DOS) */ {		/* Case 3. */
-		MFT_RECORD *m;
 		FILE_NAME_ATTR *fn;
 
 		kfree(name);
 
 		/* Find the WIN32 name corresponding to the matched DOS name. */
 		ni = NTFS_I(dent_inode);
-		m = map_mft_record(READ, ni);
+		m = map_mft_record(ni);
 		if (IS_ERR(m)) {
 			err = PTR_ERR(m);
-			goto name_err_out;
+			m = NULL;
+			ctx = NULL;
+			goto err_out;
 		}
 		ctx = get_attr_search_ctx(ni, m);
 		if (!ctx) {
 			err = -ENOMEM;
-			goto unm_err_out;
+			goto err_out;
 		}
 		do {
 			ATTR_RECORD *a;
@@ -202,21 +204,21 @@
 						"namespace counterpart to DOS "
 						"file name. Run chkdsk.");
 				err = -EIO;
-				goto put_unm_err_out;
+				goto err_out;
 			}
 			/* Consistency checks. */
 			a = ctx->attr;
 			if (a->non_resident || a->flags)
-				goto eio_put_unm_err_out;
+				goto eio_err_out;
 			val_len = le32_to_cpu(a->_ARA(value_length));
 			if (le16_to_cpu(a->_ARA(value_offset)) + val_len >
 					le32_to_cpu(a->length))
-				goto eio_put_unm_err_out;
+				goto eio_err_out;
 			fn = (FILE_NAME_ATTR*)((u8*)ctx->attr + le16_to_cpu(
 					ctx->attr->_ARA(value_offset)));
 			if ((u32)(fn->file_name_length * sizeof(uchar_t) +
 					sizeof(FILE_NAME_ATTR)) > val_len)
-				goto eio_put_unm_err_out;
+				goto eio_err_out;
 		} while (fn->file_name_type != FILE_NAME_WIN32);
 
 		/* Convert the found WIN32 name to current NLS code page. */
@@ -226,13 +228,15 @@
 				fn->file_name_length * 3 + 1);
 
 		put_attr_search_ctx(ctx);
-		unmap_mft_record(READ, ni);
+		unmap_mft_record(ni);
 	}
+	m = NULL;
+	ctx = NULL;
 
 	/* Check if a conversion error occured. */
 	if ((signed)nls_name.len < 0) {
 		err = (signed)nls_name.len;
-		goto name_err_out;
+		goto err_out;
 	}
 	nls_name.hash = full_name_hash(nls_name.name, nls_name.len);
 
@@ -248,7 +252,7 @@
 		kfree(nls_name.name);
 		if (!real_dent) {
 			err = -ENOMEM;
-			goto name_err_out;
+			goto err_out;
 		}
 		d_add(real_dent, dent_inode);
 		return real_dent;
@@ -269,14 +273,14 @@
 	d_instantiate(real_dent, dent_inode);
 	return real_dent;
 
-eio_put_unm_err_out:
+eio_err_out:
 	ntfs_error(vol->sb, "Illegal file name attribute. Run chkdsk.");
 	err = -EIO;
-put_unm_err_out:
-	put_attr_search_ctx(ctx);
-unm_err_out:
-	unmap_mft_record(READ, ni);
-name_err_out:
+err_out:
+	if (ctx)
+		put_attr_search_ctx(ctx);
+	if (m)
+		unmap_mft_record(ni);
 	iput(dent_inode);
 	return ERR_PTR(err);
    }
diff -Nru a/fs/ntfs/super.c b/fs/ntfs/super.c
--- a/fs/ntfs/super.c	Mon Aug  5 00:08:29 2002
+++ b/fs/ntfs/super.c	Mon Aug  5 00:08:29 2002
@@ -852,7 +852,7 @@
 		ntfs_error(sb, "Failed to load $Volume.");
 		goto iput_lcnbmp_err_out;
 	}
-	m = map_mft_record(READ, NTFS_I(vol->vol_ino));
+	m = map_mft_record(NTFS_I(vol->vol_ino));
 	if (IS_ERR(m)) {
 iput_volume_failed:
 		iput(vol->vol_ino);
@@ -867,7 +867,7 @@
 err_put_vol:
 		put_attr_search_ctx(ctx);
 get_ctx_vol_failed:
-		unmap_mft_record(READ, NTFS_I(vol->vol_ino));
+		unmap_mft_record(NTFS_I(vol->vol_ino));
 		goto iput_volume_failed;
 	}
 	vi = (VOLUME_INFORMATION*)((char*)ctx->attr +
@@ -882,7 +882,7 @@
 	vol->major_ver = vi->major_ver;
 	vol->minor_ver = vi->minor_ver;
 	put_attr_search_ctx(ctx);
-	unmap_mft_record(READ, NTFS_I(vol->vol_ino));
+	unmap_mft_record(NTFS_I(vol->vol_ino));
 	printk(KERN_INFO "NTFS volume version %i.%i.\n", vol->major_ver,
 			vol->minor_ver);
 	/*

===================================================================

This BitKeeper patch contains the following changesets:
aia21@cantab.net|ChangeSet|20020804230133|24300
## Wrapped with gzip_uu ##


begin 664 bkpatch12434
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
8'MU]Y+/),]/W[,#45OO_`)54W^.\3P``
`
end
