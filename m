Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317388AbSGDKxF>; Thu, 4 Jul 2002 06:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317390AbSGDKxE>; Thu, 4 Jul 2002 06:53:04 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:36419 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S317388AbSGDKwv>; Thu, 4 Jul 2002 06:52:51 -0400
Subject: [BK-PATCH-2.5] NTFS: 2.0.14 - Run list merging code cleanup, minor locking changes, typo fixes
To: torvalds@transmeta.com (Linus Torvalds)
Date: Thu, 4 Jul 2002 11:55:22 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17Q4Gg-0000aU-00@storm.christs.cam.ac.uk>
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

===================================================================

This will update the following files:

 Documentation/filesystems/ntfs.txt |    3 
 fs/ntfs/ChangeLog                  |   11 
 fs/ntfs/Makefile                   |    2 
 fs/ntfs/attrib.c                   |  849 +++++++++++++++++++++----------------
 fs/ntfs/mst.c                      |    4 
 fs/ntfs/super.c                    |   18 
 6 files changed, 522 insertions(+), 365 deletions(-)

through these ChangeSets:

<aia21@cantab.net> (02/07/03 1.616)
   NTFS: 2.0.14 - Run list merging code cleanup, minor locking changes, typo fixes.
   - Change fs/ntfs/super.c::ntfs_statfs() to not rely on BKL by moving
     the locking out of super.c::get_nr_free_mft_records() and taking and
     dropping the mftbmp_lock rw_semaphore in ntfs_statfs() itself.
   - Bring attribute run list merging code (fs/ntfs/attrib.c) in sync with
     current userspace ntfs library code. This means that if a merge
     fails the original run lists are always left unmodified instead of
     being silently corrupted.
   - Misc typo fixes.


diff -Nru a/Documentation/filesystems/ntfs.txt b/Documentation/filesystems/ntfs.txt
--- a/Documentation/filesystems/ntfs.txt	Thu Jul  4 11:35:24 2002
+++ b/Documentation/filesystems/ntfs.txt	Thu Jul  4 11:35:24 2002
@@ -247,6 +247,9 @@
 
 Note, a technical ChangeLog aimed at kernel hackers is in fs/ntfs/ChangeLog.
 
+2.0.14:
+	- Internal changes improving run list merging code and minor locking
+	  change to not rely on BKL in ntfs_statfs().
 2.0.13:
 	- Internal changes towards using iget5_locked() in preparation for
 	  fake inodes and small cleanups to ntfs_volume structure.
diff -Nru a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog	Thu Jul  4 11:35:24 2002
+++ b/fs/ntfs/ChangeLog	Thu Jul  4 11:35:24 2002
@@ -28,6 +28,17 @@
 	- Enable NFS exporting of NTFS.
 	- Use fake inodes for address space i/o.
 
+2.0.14 - Run list merging code cleanup, minor locking changes, typo fixes.
+
+	- Change fs/ntfs/super.c::ntfs_statfs() to not rely on BKL by moving
+	  the locking out of super.c::get_nr_free_mft_records() and taking and
+	  dropping the mftbmp_lock rw_semaphore in ntfs_statfs() itself.
+	- Bring attribute run list merging code (fs/ntfs/attrib.c) in sync with
+	  current userspace ntfs library code. This means that if a merge
+	  fails the original run lists are always left unmodified instead of
+	  being silently corrupted.
+	- Misc typo fixes.
+
 2.0.13 - Use iget5_locked() in preparation for fake inodes and small cleanups.
 
 	- Remove nr_mft_bits and the now superfluous union with nr_mft_records
diff -Nru a/fs/ntfs/Makefile b/fs/ntfs/Makefile
--- a/fs/ntfs/Makefile	Thu Jul  4 11:35:24 2002
+++ b/fs/ntfs/Makefile	Thu Jul  4 11:35:24 2002
@@ -5,7 +5,7 @@
 ntfs-objs := aops.o attrib.o compress.o debug.o dir.o file.o inode.o mft.o \
 	     mst.o namei.o super.o sysctl.o time.o unistr.o upcase.o
 
-EXTRA_CFLAGS = -DNTFS_VERSION=\"2.0.13\"
+EXTRA_CFLAGS = -DNTFS_VERSION=\"2.0.14\"
 
 ifeq ($(CONFIG_NTFS_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
diff -Nru a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
--- a/fs/ntfs/attrib.c	Thu Jul  4 11:35:24 2002
+++ b/fs/ntfs/attrib.c	Thu Jul  4 11:35:24 2002
@@ -27,338 +27,433 @@
 /* Temporary helper functions -- might become macros */
 
 /**
- * rl_mm - run_list memmove
+ * ntfs_rl_mm - run_list memmove
  *
  * It is up to the caller to serialize access to the run list @base.
  */
-static inline void rl_mm(run_list_element *base, int dst, int src, int size)
+static inline void ntfs_rl_mm(run_list_element *base, int dst, int src,
+		int size)
 {
-	if ((dst != src) && (size > 0))
-		memmove (base + dst, base + src, size * sizeof (*base));
+	if (likely((dst != src) && (size > 0)))
+		memmove(base + dst, base + src, size * sizeof (*base));
 }
 
 /**
- * rl_mc - run_list memory copy
+ * ntfs_rl_mc - run_list memory copy
  *
  * It is up to the caller to serialize access to the run lists @dstbase and
  * @srcbase.
  */
-static inline void rl_mc(run_list_element *dstbase, int dst,
+static inline void ntfs_rl_mc(run_list_element *dstbase, int dst,
 		run_list_element *srcbase, int src, int size)
 {
-	if (size > 0)
-		memcpy (dstbase+dst, srcbase+src, size * sizeof (*dstbase));
+	if (likely(size > 0))
+		memcpy(dstbase + dst, srcbase + src, size * sizeof(*dstbase));
 }
 
 /**
  * ntfs_rl_realloc - Reallocate memory for run_lists
- * @orig:  The original memory allocation
- * @old:   The number of run_lists in the original
- * @new:   The number of run_lists we need space for
+ * @rl:		original run list
+ * @old_size:	number of run list elements in the original run list @rl
+ * @new_size:	number of run list elements we need space for
  *
  * As the run_lists grow, more memory will be required.  To prevent the
  * kernel having to allocate and reallocate large numbers of small bits of
  * memory, this function returns and entire page of memory.
  *
- * It is up to the caller to serialize access to the run list @orig.
+ * It is up to the caller to serialize access to the run list @rl.
  *
  * N.B.  If the new allocation doesn't require a different number of pages in
  *       memory, the function will return the original pointer.
  *
- * Return: Pointer  The newly allocated, or recycled,  memory.
- *
- * Errors: -ENOMEM, Not enough memory to allocate run list array.
- *         -EINVAL, Invalid parameters were passed in.
+ * On success, return a pointer to the newly allocated, or recycled, memory.
+ * On error, return -errno. The following error codes are defined:
+ *	-ENOMEM	- Not enough memory to allocate run list array.
+ *	-EINVAL	- Invalid parameters were passed in.
  */
-static inline run_list_element *ntfs_rl_realloc(run_list_element *orig,
-		int old, int new)
+static inline run_list_element *ntfs_rl_realloc(run_list_element *rl,
+		int old_size, int new_size)
 {
-	run_list_element *nrl;
+	run_list_element *new_rl;
 
-	old = PAGE_ALIGN (old * sizeof (*orig));
-	new = PAGE_ALIGN (new * sizeof (*orig));
-	if (old == new)
-		return orig;
+	old_size = PAGE_ALIGN(old_size * sizeof(*rl));
+	new_size = PAGE_ALIGN(new_size * sizeof(*rl));
+	if (old_size == new_size)
+		return rl;
 
-	nrl = ntfs_malloc_nofs (new);
-	if (!nrl)
-		return ERR_PTR (-ENOMEM);
+	new_rl = ntfs_malloc_nofs(new_size);
+	if (unlikely(!new_rl))
+		return ERR_PTR(-ENOMEM);
 
-	if (orig) {
-		memcpy (nrl, orig, min (old, new));
-		ntfs_free (orig);
+	if (likely(rl != NULL)) {
+		if (unlikely(old_size > new_size))
+			old_size = new_size;
+		memcpy(new_rl, rl, old_size);
+		ntfs_free(rl);
 	}
-	return nrl;
+	return new_rl;
 }
 
 /**
- * ntfs_rl_merge - Join together two run_lists
- * @one:  The first run_list and destination
- * @two:  The second run_list
+ * ntfs_are_rl_mergeable - test if two run lists can be joined together
+ * @dst:	original run list
+ * @src:	new run list to test for mergeability with @dst
  *
- * If possible merge together two run_lists.  For this, their VCNs and LCNs
+ * Test if two run lists can be joined together. For this, their VCNs and LCNs
  * must be adjacent.
  *
- * It is up to the caller to serialize access to the run lists @one and @two.
+ * It is up to the caller to serialize access to the run lists @dst and @src.
  *
- * Return: TRUE   Success, the run_lists were merged
- *         FALSE  Failure, the run_lists were not merged
+ * Return: TRUE   Success, the run lists can be merged.
+ *         FALSE  Failure, the run lists cannot be merged.
  */
-static inline BOOL ntfs_rl_merge(run_list_element *one, run_list_element *two)
+static inline BOOL ntfs_are_rl_mergeable(run_list_element *dst,
+		run_list_element *src)
 {
-	BUG_ON (!one || !two);
+	BUG_ON(!dst || !src);
 
-	if ((one->lcn < 0) || (two->lcn < 0))     /* Are we merging holes? */
+	if ((dst->lcn < 0) || (src->lcn < 0))     /* Are we merging holes? */
 		return FALSE;
-	if ((one->lcn + one->length) != two->lcn) /* Are the runs contiguous? */
+	if ((dst->lcn + dst->length) != src->lcn) /* Are the runs contiguous? */
 		return FALSE;
-	if ((one->vcn + one->length) != two->vcn) /* Are the runs misaligned? */
+	if ((dst->vcn + dst->length) != src->vcn) /* Are the runs misaligned? */
 		return FALSE;
 
-	one->length += two->length;
 	return TRUE;
 }
 
 /**
- * ntfs_rl_append - Append a run_list after the given element
- * @orig:   The original run_list to be worked on.
- * @osize:  The number of elements in @orig (including end marker).
- * @new:    The run_list to be inserted.
- * @nsize:  The number of elements in @new (excluding end marker).
- * @loc:    Append the new run_list after this element in @orig.
- *
- * Append a run_list after element @loc in @orig.  Merge the right end of
- * the new run_list, if necessary.  Adjust the size of the hole before the
- * appended run_list.
- *
- * It is up to the caller to serialize access to the run lists @orig and @new.
- *
- * Return: Pointer, The new, combined, run_list
+ * __ntfs_rl_merge - merge two run lists without testing if they can be merged
+ * @dst:	original, destination run list
+ * @src:	new run list to merge with @dst
+ *
+ * Merge the two run lists, writing into the destination run list @dst. The
+ * caller must make sure the run lists can be merged or this will corrupt the
+ * destination run list.
  *
- * Errors: -ENOMEM, Not enough memory to allocate run list array.
- *         -EINVAL, Invalid parameters were passed in.
+ * It is up to the caller to serialize access to the run lists @dst and @src.
+ */
+static inline void __ntfs_rl_merge(run_list_element *dst, run_list_element *src)
+{
+	dst->length += src->length;
+}
+
+/**
+ * ntfs_rl_merge - test if two run lists can be joined together and merge them
+ * @dst:	original, destination run list
+ * @src:	new run list to merge with @dst
+ *
+ * Test if two run lists can be joined together. For this, their VCNs and LCNs
+ * must be adjacent. If they can be merged, perform the merge, writing into
+ * the destination run list @dst.
+ *
+ * It is up to the caller to serialize access to the run lists @dst and @src.
+ *
+ * Return: TRUE   Success, the run lists have been merged.
+ *         FALSE  Failure, the run lists cannot be merged and have not been
+ *		  modified.
  */
-static inline run_list_element *ntfs_rl_append(run_list_element *orig,
-		int osize, run_list_element *new, int nsize, int loc)
+static inline BOOL ntfs_rl_merge(run_list_element *dst, run_list_element *src)
+{
+	BOOL merge = ntfs_are_rl_mergeable(dst, src);
+
+	if (merge)
+		__ntfs_rl_merge(dst, src);
+	return merge;
+}
+
+/**
+ * ntfs_rl_append - append a run list after a given element
+ * @dst:	original run list to be worked on
+ * @dsize:	number of elements in @dst (including end marker)
+ * @src:	run list to be inserted into @dst
+ * @ssize:	number of elements in @src (excluding end marker)
+ * @loc:	append the new run list @src after this element in @dst
+ *
+ * Append the run list @src after element @loc in @dst.  Merge the right end of
+ * the new run list, if necessary. Adjust the size of the hole before the
+ * appended run list.
+ *
+ * It is up to the caller to serialize access to the run lists @dst and @src.
+ *
+ * On success, return a pointer to the new, combined, run list. Note, both
+ * run lists @dst and @src are deallocated before returning so you cannot use
+ * the pointers for anything any more. (Strictly speaking the returned run list
+ * may be the same as @dst but this is irrelevant.)
+ *
+ * On error, return -errno. Both run lists are left unmodified. The following
+ * error codes are defined:
+ *	-ENOMEM	- Not enough memory to allocate run list array.
+ *	-EINVAL	- Invalid parameters were passed in.
+ */
+static inline run_list_element *ntfs_rl_append(run_list_element *dst,
+		int dsize, run_list_element *src, int ssize, int loc)
 {
-	run_list_element *res;
 	BOOL right;
+	int magic;
+
+	BUG_ON(!dst || !src);
+
+	/* First, check if the right hand end needs merging. */
+	right = ntfs_are_rl_mergeable(src + ssize - 1, dst + loc + 1);
 
-	BUG_ON (!orig || !new);
+	/* Space required: @dst size + @src size, less one if we merged. */
+	dst = ntfs_rl_realloc(dst, dsize, dsize + ssize - right);
+	if (IS_ERR(dst))
+		return dst;
+	/*
+	 * We are guaranteed to succeed from here so can start modifying the
+	 * original run lists.
+	 */
 
 	/* First, merge the right hand end, if necessary. */
-	right = ntfs_rl_merge (new + nsize - 1, orig + loc + 1);
+	if (right)
+		__ntfs_rl_merge(src + ssize - 1, dst + loc + 1);
 
-	/* Space required: Orig size + New size, less one if we merged. */
-	res = ntfs_rl_realloc (orig, osize, osize + nsize - right);
-	if (IS_ERR (res))
-		return res;
-
-	/* Move the tail of Orig out of the way, then copy in New. */
-	rl_mm (res, loc + 1 + nsize, loc + 1 + right, osize - loc - 1 - right);
-	rl_mc (res, loc + 1, new, 0, nsize);
+	magic = loc + ssize;
+
+	/* Move the tail of @dst out of the way, then copy in @src. */
+	ntfs_rl_mm(dst, magic + 1, loc + 1 + right, dsize - loc - 1 - right);
+	ntfs_rl_mc(dst, loc + 1, src, 0, ssize);
 
 	/* Adjust the size of the preceding hole. */
-	res[loc].length = res[loc+1].vcn - res[loc].vcn;
+	dst[loc].length = dst[loc + 1].vcn - dst[loc].vcn;
 
 	/* We may have changed the length of the file, so fix the end marker */
-	if (res[loc+nsize+1].lcn == LCN_ENOENT)
-		res[loc+nsize+1].vcn = res[loc+nsize].vcn + res[loc+nsize].length;
+	if (dst[magic + 1].lcn == LCN_ENOENT)
+		dst[magic + 1].vcn = dst[magic].vcn + dst[magic].length;
 
-	return res;
+	return dst;
 }
 
 /**
- * ntfs_rl_insert - Insert a run_list into another
- * @orig:   The original run_list to be worked on.
- * @osize:  The number of elements in @orig (including end marker).
- * @new:    The run_list to be inserted.
- * @nsize:  The number of elements in @new (excluding end marker).
- * @loc:    Insert the new run_list before this element in @orig.
- *
- * Insert a run_list before element @loc in @orig.  Merge the left end of
- * the new run_list, if necessary.  Adjust the size of the hole after the
- * inserted run_list.
- *
- * It is up to the caller to serialize access to the run lists @orig and @new.
- *
- * Return: Pointer, The new, combined, run_list
- *
- * Errors: -ENOMEM, Not enough memory to allocate run list array.
- *         -EINVAL, Invalid parameters were passed in.
+ * ntfs_rl_insert - insert a run list into another
+ * @dst:	original run list to be worked on
+ * @dsize:	number of elements in @dst (including end marker)
+ * @src:	new run list to be inserted
+ * @ssize:	number of elements in @src (excluding end marker)
+ * @loc:	insert the new run list @src before this element in @dst
+ *
+ * Insert the run list @src before element @loc in the run list @dst. Merge the
+ * left end of the new run list, if necessary. Adjust the size of the hole
+ * after the inserted run list.
+ *
+ * It is up to the caller to serialize access to the run lists @dst and @src.
+ *
+ * On success, return a pointer to the new, combined, run list. Note, both
+ * run lists @dst and @src are deallocated before returning so you cannot use
+ * the pointers for anything any more. (Strictly speaking the returned run list
+ * may be the same as @dst but this is irrelevant.)
+ *
+ * On error, return -errno. Both run lists are left unmodified. The following
+ * error codes are defined:
+ *	-ENOMEM	- Not enough memory to allocate run list array.
+ *	-EINVAL	- Invalid parameters were passed in.
  */
-static inline run_list_element *ntfs_rl_insert(run_list_element *orig,
-		int osize, run_list_element *new, int nsize, int loc)
+static inline run_list_element *ntfs_rl_insert(run_list_element *dst,
+		int dsize, run_list_element *src, int ssize, int loc)
 {
-	run_list_element *res;
 	BOOL left = FALSE;
 	BOOL disc = FALSE;	/* Discontinuity */
 	BOOL hole = FALSE;	/* Following a hole */
+	int magic;
 
-	BUG_ON (!orig || !new);
+	BUG_ON(!dst || !src);
 
-	/* disc => Discontinuity between the end of Orig and the start of New.
+	/* disc => Discontinuity between the end of @dst and the start of @src.
 	 *         This means we might need to insert a hole.
-	 * hole => Orig ends with a hole or an unmapped region which we can
+	 * hole => @dst ends with a hole or an unmapped region which we can
 	 *         extend to match the discontinuity. */
-	if (loc == 0) {
-		disc = (new[0].vcn > 0);
-	} else {
-		left = ntfs_rl_merge (orig + loc - 1, new);
+	if (loc == 0)
+		disc = (src[0].vcn > 0);
+	else {
+		s64 merged_length;
+
+		left = ntfs_are_rl_mergeable(dst + loc - 1, src);
+
+		merged_length = dst[loc - 1].length;
+		if (left)
+			merged_length += src->length;
 
-		disc = (new[0].vcn > (orig[loc-1].vcn + orig[loc-1].length));
+		disc = (src[0].vcn > dst[loc - 1].vcn + merged_length);
 		if (disc)
-			hole = (orig[loc-1].lcn == LCN_HOLE);
+			hole = (dst[loc - 1].lcn == LCN_HOLE);
 	}
 
-	/* Space required: Orig size + New size, less one if we merged,
-	 * plus one if there was a discontinuity, less one for a trailing hole */
-	res = ntfs_rl_realloc (orig, osize, osize + nsize - left + disc - hole);
-	if (IS_ERR (res))
-		return res;
-
-	/* Move the tail of Orig out of the way, then copy in New. */
-	rl_mm (res, loc + nsize - left + disc - hole, loc, osize - loc);
-	rl_mc (res, loc + disc - hole, new, left, nsize - left);
+	/* Space required: @dst size + @src size, less one if we merged, plus
+	 * one if there was a discontinuity, less one for a trailing hole. */
+	dst = ntfs_rl_realloc(dst, dsize, dsize + ssize - left + disc - hole);
+	if (IS_ERR(dst))
+		return dst;
+	/*
+	 * We are guaranteed to succeed from here so can start modifying the
+	 * original run list.
+	 */
+
+	if (left)
+		__ntfs_rl_merge(dst + loc - 1, src);
+
+	magic = loc + ssize - left + disc - hole;
+
+	/* Move the tail of @dst out of the way, then copy in @src. */
+	ntfs_rl_mm(dst, magic, loc, dsize - loc);
+	ntfs_rl_mc(dst, loc + disc - hole, src, left, ssize - left);
 
 	/* Adjust the VCN of the last run ... */
-	if (res[loc+nsize-left+disc-hole].lcn <= LCN_HOLE) {
-		res[loc+nsize-left+disc-hole].vcn =
-			res[loc+nsize-left+disc-hole-1].vcn +
-			res[loc+nsize-left+disc-hole-1].length;
-	}
+	if (dst[magic].lcn <= LCN_HOLE)
+		dst[magic].vcn = dst[magic - 1].vcn + dst[magic - 1].length;
 	/* ... and the length. */
-	if ((res[loc+nsize-left+disc-hole].lcn == LCN_HOLE) ||
-	    (res[loc+nsize-left+disc-hole].lcn == LCN_RL_NOT_MAPPED)) {
-		res[loc+nsize-left+disc-hole].length =
-			res[loc+nsize-left+disc-hole+1].vcn -
-			res[loc+nsize-left+disc-hole].vcn;
-	}
+	if (dst[magic].lcn == LCN_HOLE || dst[magic].lcn == LCN_RL_NOT_MAPPED)
+		dst[magic].length = dst[magic + 1].vcn - dst[magic].vcn;
 
 	/* Writing beyond the end of the file and there's a discontinuity. */
 	if (disc) {
-		if (hole) {
-			res[loc-1].length = res[loc].vcn - res[loc-1].vcn;
-		} else {
+		if (hole)
+			dst[loc - 1].length = dst[loc].vcn - dst[loc - 1].vcn;
+		else {
 			if (loc > 0) {
-				res[loc].vcn = res[loc-1].vcn +
-					res[loc-1].length;
-				res[loc].length = res[loc+1].vcn - res[loc].vcn;
+				dst[loc].vcn = dst[loc - 1].vcn +
+						dst[loc - 1].length;
+				dst[loc].length = dst[loc + 1].vcn -
+						dst[loc].vcn;
 			} else {
-				res[loc].vcn = 0;
-				res[loc].length = res[loc+1].vcn;
+				dst[loc].vcn = 0;
+				dst[loc].length = dst[loc + 1].vcn;
 			}
-			res[loc].lcn = LCN_RL_NOT_MAPPED;
+			dst[loc].lcn = LCN_RL_NOT_MAPPED;
 		}
 
-		if (res[loc+nsize-left+disc].lcn == LCN_ENOENT)
-			res[loc+nsize-left+disc].vcn = res[loc+nsize-left+disc-1].vcn +
-				res[loc+nsize-left+disc-1].length;
-	}
+		magic += hole;
 
-	return res;
+		if (dst[magic].lcn == LCN_ENOENT)
+			dst[magic].vcn = dst[magic - 1].vcn +
+					dst[magic - 1].length;
+	}
+	return dst;
 }
 
 /**
- * ntfs_rl_replace - Overwrite a run_list element with another run_list
- * @orig:   The original run_list to be worked on.
- * @osize:  The number of elements in @orig (including end marker).
- * @new:    The run_list to be inserted.
- * @nsize:  The number of elements in @new (excluding end marker).
- * @loc:    Index of run_list @orig to overwrite with @new.
- *
- * Replace the run_list at @loc with @new.  Merge the left and right ends of
- * the inserted run_list, if necessary.
- *
- * It is up to the caller to serialize access to the run lists @orig and @new.
- *
- * Return: Pointer, The new, combined, run_list
- *
- * Errors: -ENOMEM, Not enough memory to allocate run list array.
- *         -EINVAL, Invalid parameters were passed in.
+ * ntfs_rl_replace - overwrite a run_list element with another run list
+ * @dst:	original run list to be worked on
+ * @dsize:	number of elements in @dst (including end marker)
+ * @src:	new run list to be inserted
+ * @ssize:	number of elements in @src (excluding end marker)
+ * @loc:	index in run list @dst to overwrite with @src
+ *
+ * Replace the run list element @dst at @loc with @src. Merge the left and
+ * right ends of the inserted run list, if necessary.
+ *
+ * It is up to the caller to serialize access to the run lists @dst and @src.
+ *
+ * On success, return a pointer to the new, combined, run list. Note, both
+ * run lists @dst and @src are deallocated before returning so you cannot use
+ * the pointers for anything any more. (Strictly speaking the returned run list
+ * may be the same as @dst but this is irrelevant.)
+ *
+ * On error, return -errno. Both run lists are left unmodified. The following
+ * error codes are defined:
+ *	-ENOMEM	- Not enough memory to allocate run list array.
+ *	-EINVAL	- Invalid parameters were passed in.
  */
-static inline run_list_element *ntfs_rl_replace(run_list_element *orig,
-		int osize, run_list_element *new, int nsize, int loc)
+static inline run_list_element *ntfs_rl_replace(run_list_element *dst,
+		int dsize, run_list_element *src, int ssize, int loc)
 {
-	run_list_element *res;
 	BOOL left = FALSE;
 	BOOL right;
+	int magic;
 
-	BUG_ON (!orig || !new);
+	BUG_ON(!dst || !src);
 
 	/* First, merge the left and right ends, if necessary. */
-	right = ntfs_rl_merge (new + nsize - 1, orig + loc + 1);
+	right = ntfs_are_rl_mergeable(src + ssize - 1, dst + loc + 1);
 	if (loc > 0)
-		left = ntfs_rl_merge (orig + loc - 1, new);
+		left = ntfs_are_rl_mergeable(dst + loc - 1, src);
 
-	/* Allocate some space.  We'll need less if the left, right
-	 * or both ends were merged. */
-	res = ntfs_rl_realloc (orig, osize, osize + nsize - left - right);
-	if (IS_ERR (res))
-		return res;
-
-	/* Move the tail of Orig out of the way, then copy in New. */
-	rl_mm (res, loc + nsize - left, loc + right + 1,
-		osize - loc - right - 1);
-	rl_mc (res, loc, new, left, nsize - left);
+	/* Allocate some space. We'll need less if the left, right, or both
+	 * ends were merged. */
+	dst = ntfs_rl_realloc(dst, dsize, dsize + ssize - left - right);
+	if (IS_ERR(dst))
+		return dst;
+	/*
+	 * We are guaranteed to succeed from here so can start modifying the
+	 * original run lists.
+	 */
+	if (right)
+		__ntfs_rl_merge(src + ssize - 1, dst + loc + 1);
+	if (left)
+		__ntfs_rl_merge(dst + loc - 1, src);
+
+	/* FIXME: What does this mean? (AIA) */
+	magic = loc + ssize - left;
+
+	/* Move the tail of @dst out of the way, then copy in @src. */
+	ntfs_rl_mm(dst, magic, loc + right + 1, dsize - loc - right - 1);
+	ntfs_rl_mc(dst, loc, src, left, ssize - left);
 
 	/* We may have changed the length of the file, so fix the end marker */
-	if (res[loc+nsize-left].lcn == LCN_ENOENT)
-		res[loc+nsize-left].vcn = res[loc+nsize-left-1].vcn +
-					  res[loc+nsize-left-1].length;
-	return res;
+	if (dst[magic].lcn == LCN_ENOENT)
+		dst[magic].vcn = dst[magic - 1].vcn + dst[magic - 1].length;
+	return dst;
 }
 
 /**
- * ntfs_rl_split - Insert a run_list into the centre of a hole
- * @orig:   The original run_list to be worked on.
- * @osize:  The number of elements in @orig (including end marker).
- * @new:    The run_list to be inserted.
- * @nsize:  The number of elements in @new (excluding end marker).
- * @loc:    Index of run_list in @orig to split with @new.
- *
- * Split the run_list at @loc into two and insert @new.  No merging of
- * run_lists is necessary.  Adjust the size of the holes either side.
- *
- * It is up to the caller to serialize access to the run lists @orig and @new.
- *
- * Return: Pointer, The new, combined, run_list
- *
- * Errors: -ENOMEM, Not enough memory to allocate run list array.
- *         -EINVAL, Invalid parameters were passed in.
+ * ntfs_rl_split - insert a run list into the centre of a hole
+ * @dst:	original run list to be worked on
+ * @dsize:	number of elements in @dst (including end marker)
+ * @src:	new run list to be inserted
+ * @ssize:	number of elements in @src (excluding end marker)
+ * @loc:	index in run list @dst at which to split and insert @src
+ *
+ * Split the run list @dst at @loc into two and insert @new in between the two
+ * fragments. No merging of run lists is necessary. Adjust the size of the
+ * holes either side.
+ *
+ * It is up to the caller to serialize access to the run lists @dst and @src.
+ *
+ * On success, return a pointer to the new, combined, run list. Note, both
+ * run lists @dst and @src are deallocated before returning so you cannot use
+ * the pointers for anything any more. (Strictly speaking the returned run list
+ * may be the same as @dst but this is irrelevant.)
+ *
+ * On error, return -errno. Both run lists are left unmodified. The following
+ * error codes are defined:
+ *	-ENOMEM	- Not enough memory to allocate run list array.
+ *	-EINVAL	- Invalid parameters were passed in.
  */
-static inline run_list_element *ntfs_rl_split(run_list_element *orig, int osize,
-		run_list_element *new, int nsize, int loc)
+static inline run_list_element *ntfs_rl_split(run_list_element *dst, int dsize,
+		run_list_element *src, int ssize, int loc)
 {
-	run_list_element *res;
-
-	BUG_ON (!orig || !new);
-
-	/* Space required: Orig size + New size + One new hole. */
-	res = ntfs_rl_realloc (orig, osize, osize + nsize + 1);
-	if (IS_ERR (res))
-		return res;
+	BUG_ON(!dst || !src);
 
-	/* Move the tail of Orig out of the way, then copy in New. */
-	rl_mm (res, loc + 1 + nsize, loc, osize - loc);
-	rl_mc (res, loc + 1, new, 0, nsize);
+	/* Space required: @dst size + @src size + one new hole. */
+	dst = ntfs_rl_realloc(dst, dsize, dsize + ssize + 1);
+	if (IS_ERR(dst))
+		return dst;
+	/*
+	 * We are guaranteed to succeed from here so can start modifying the
+	 * original run lists.
+	 */
 
-	/* Adjust the size of the holes either size of New. */
-	res[loc].length         = res[loc+1].vcn       - res[loc].vcn;
-	res[loc+nsize+1].vcn    = res[loc+nsize].vcn   + res[loc+nsize].length;
-	res[loc+nsize+1].length = res[loc+nsize+2].vcn - res[loc+nsize+1].vcn;
+	/* Move the tail of @dst out of the way, then copy in @src. */
+	ntfs_rl_mm(dst, loc + 1 + ssize, loc, dsize - loc);
+	ntfs_rl_mc(dst, loc + 1, src, 0, ssize);
+
+	/* Adjust the size of the holes either size of @src. */
+	dst[loc].length         = dst[loc+1].vcn       - dst[loc].vcn;
+	dst[loc+ssize+1].vcn    = dst[loc+ssize].vcn   + dst[loc+ssize].length;
+	dst[loc+ssize+1].length = dst[loc+ssize+2].vcn - dst[loc+ssize+1].vcn;
 
-	return res;
+	return dst;
 }
 
 /**
- * merge_run_lists - merge two run_lists into one
- * @drl:  The original run_list.
- * @srl:  The new run_list to be merge into @drl.
- *
- * First we sanity check the two run_lists to make sure that they are sensible
- * and can be merged.  The @srl run_list must be either after the @drl run_list
- * or completely within a hole in @drl.
+ * ntfs_merge_run_lists - merge two run_lists into one
+ * @drl:	original run list to be worked on
+ * @srl:	new run list to be merged into @drl
+ *
+ * First we sanity check the two run lists @srl and @drl to make sure that they
+ * are sensible and can be merged. The run list @srl must be either after the
+ * run list @drl or completely within a hole (or unmapped region) in @drl.
  *
  * It is up to the caller to serialize access to the run lists @drl and @srl.
  *
@@ -366,25 +461,28 @@
  *   1. When attribute lists are used and a further extent is being mapped.
  *   2. When new clusters are allocated to fill a hole or extend a file.
  *
- * There are four possible ways @srl can be merged.  It can be inserted at
- * the beginning of a hole; split the hole in two; appended at the end of
- * a hole; replace the whole hole.  It can also be appended to the end of
- * the run_list, which is just a variant of the insert case.
- *
- * N.B.  Either, or both, of the input pointers may be freed if the function
- *       is successful.  Only the returned pointer may be used.
- *
- *       If the function fails, neither of the input run_lists may be safe.
- *
- * Return: Pointer, The resultant merged run_list.
- *
- * Errors: -ENOMEM, Not enough memory to allocate run list array.
- *         -EINVAL, Invalid parameters were passed in.
- *         -ERANGE, The run_lists overlap and cannot be merged.
+ * There are four possible ways @srl can be merged. It can:
+ *	- be inserted at the beginning of a hole,
+ *	- split the hole in two and be inserted between the two fragments,
+ *	- be appended at the end of a hole, or it can
+ *	- replace the whole hole.
+ * It can also be appended to the end of the run list, which is just a variant
+ * of the insert case.
+ *
+ * On success, return a pointer to the new, combined, run list. Note, both
+ * run lists @drl and @srl are deallocated before returning so you cannot use
+ * the pointers for anything any more. (Strictly speaking the returned run list
+ * may be the same as @dst but this is irrelevant.)
+ *
+ * On error, return -errno. Both run lists are left unmodified. The following
+ * error codes are defined:
+ *	-ENOMEM	- Not enough memory to allocate run list array.
+ *	-EINVAL	- Invalid parameters were passed in.
+ *	-ERANGE	- The run lists overlap and cannot be merged.
  */
-run_list_element *merge_run_lists(run_list_element *drl, run_list_element *srl)
+run_list_element *ntfs_merge_run_lists(run_list_element *drl,
+		run_list_element *srl)
 {
-	run_list_element *nrl;	/* New run list. */
 	int di, si;		/* Current index into @[ds]rl. */
 	int sstart;		/* First index with lcn > LCN_RL_NOT_MAPPED. */
 	int dins;		/* Index into @drl at which to insert @srl. */
@@ -392,49 +490,49 @@
 	int dfinal, sfinal;	/* The last index into @[ds]rl with
 				   lcn >= LCN_HOLE. */
 	int marker = 0;
+	VCN marker_vcn = 0;
 
-#if 1
-	ntfs_debug ("dst:");
-	ntfs_debug_dump_runlist (drl);
-	ntfs_debug ("src:");
-	ntfs_debug_dump_runlist (srl);
+#ifdef DEBUG
+	ntfs_debug("dst:");
+	ntfs_debug_dump_runlist(drl);
+	ntfs_debug("src:");
+	ntfs_debug_dump_runlist(srl);
 #endif
 
  	/* Check for silly calling... */
-	if (unlikely (!srl))
+	if (unlikely(!srl))
 		return drl;
-	if (unlikely (IS_ERR (srl) || IS_ERR (drl)))
-		return ERR_PTR (-EINVAL);
+	if (unlikely(IS_ERR(srl) || IS_ERR(drl)))
+		return ERR_PTR(-EINVAL);
 
 	/* Check for the case where the first mapping is being done now. */
-	if (unlikely (!drl)) {
-		nrl = srl;
-
+	if (unlikely(!drl)) {
+		drl = srl;
 		/* Complete the source run list if necessary. */
-		if (unlikely (srl[0].vcn)) {
+		if (unlikely(drl[0].vcn)) {
 			/* Scan to the end of the source run list. */
-			for (send = 0; likely (srl[send].length); send++)
+			for (dend = 0; likely(drl[dend].length); dend++)
 				;
-			nrl = ntfs_rl_realloc (srl, send, send + 1);
-			if (!nrl)
-				return ERR_PTR (-ENOMEM);
-
-			rl_mm (nrl, 1, 0, send);
-			nrl[0].vcn = 0;			/* Add start element. */
-			nrl[0].lcn = LCN_RL_NOT_MAPPED;
-			nrl[0].length = nrl[1].vcn;
+			drl = ntfs_rl_realloc(drl, dend, dend + 1);
+			if (IS_ERR(drl))
+				return drl;
+			/* Insert start element at the front of the run list. */
+			ntfs_rl_mm(drl, 1, 0, dend);
+			drl[0].vcn = 0;
+			drl[0].lcn = LCN_RL_NOT_MAPPED;
+			drl[0].length = drl[1].vcn;
 		}
 		goto finished;
 	}
 
 	si = di = 0;
 
-	/* Skip the unmapped start element(s) in each run_list if present. */
+	/* Skip any unmapped start element(s) in the source run_list. */
 	while (srl[si].length && srl[si].lcn < (LCN)LCN_HOLE)
 		si++;
 
-	/* Can't have an entirely unmapped srl run_list. */
-	BUG_ON (!srl[si].length);
+	/* Can't have an entirely unmapped source run list. */
+	BUG_ON(!srl[si].length);
 
 	/* Record the starting points. */
 	sstart = si;
@@ -445,19 +543,16 @@
 	 * appended to @drl.
 	 */
 	for (; drl[di].length; di++) {
-		if ((drl[di].vcn + drl[di].length) > srl[sstart].vcn)
+		if (drl[di].vcn + drl[di].length > srl[sstart].vcn)
 			break;
 	}
 	dins = di;
 
 	/* Sanity check for illegal overlaps. */
-	if ((drl[di].vcn == srl[si].vcn) &&
-	    (drl[di].lcn >= 0) &&
-	    (srl[si].lcn >= 0)) {
-		ntfs_error (NULL, "Run lists overlap. Cannot merge! Returning "
-				"ERANGE.");
-		nrl = ERR_PTR (-ERANGE);
-		goto exit;
+	if ((drl[di].vcn == srl[si].vcn) && (drl[di].lcn >= 0) &&
+			(srl[si].lcn >= 0)) {
+		ntfs_error(NULL, "Run lists overlap. Cannot merge!");
+		return ERR_PTR(-ERANGE);
 	}
 
 	/* Scan to the end of both run lists in order to know their sizes. */
@@ -466,9 +561,8 @@
 	for (dend = di; drl[dend].length; dend++)
 		;
 
-	if (srl[send].lcn == LCN_ENOENT) {
-		marker = send;
-	}
+	if (srl[send].lcn == (LCN)LCN_ENOENT)
+		marker_vcn = srl[marker = send].vcn;
 
 	/* Scan to the last element with lcn >= LCN_HOLE. */
 	for (sfinal = send; sfinal >= 0 && srl[sfinal].lcn < LCN_HOLE; sfinal--)
@@ -479,96 +573,142 @@
 	{
 	BOOL start;
 	BOOL finish;
-	int ds = dend   + 1;		/* Number of elements in drl & srl */
+	int ds = dend + 1;		/* Number of elements in drl & srl */
 	int ss = sfinal - sstart + 1;
 
 	start  = ((drl[dins].lcn <  LCN_RL_NOT_MAPPED) ||    /* End of file   */
 		  (drl[dins].vcn == srl[sstart].vcn));	     /* Start of hole */
 	finish = ((drl[dins].lcn >= LCN_RL_NOT_MAPPED) &&    /* End of file   */
 		 ((drl[dins].vcn + drl[dins].length) <=      /* End of hole   */
-		  (srl[send-1].vcn + srl[send-1].length)));
+		  (srl[send - 1].vcn + srl[send - 1].length)));
 
 	/* Or we'll lose an end marker */
 	if (start && finish && (drl[dins].length == 0))
 		ss++;
-	if (marker && (drl[dins].vcn + drl[dins].length > srl[send-1].vcn))
+	if (marker && (drl[dins].vcn + drl[dins].length > srl[send - 1].vcn))
 		finish = FALSE;
-
 #if 0
 	ntfs_debug("dfinal = %i, dend = %i", dfinal, dend);
 	ntfs_debug("sstart = %i, sfinal = %i, send = %i", sstart, sfinal, send);
 	ntfs_debug("start = %i, finish = %i", start, finish);
 	ntfs_debug("ds = %i, ss = %i, dins = %i", ds, ss, dins);
 #endif
-	if (start)
+	if (start) {
 		if (finish)
-			nrl = ntfs_rl_replace (drl, ds, srl + sstart, ss, dins);
+			drl = ntfs_rl_replace(drl, ds, srl + sstart, ss, dins);
 		else
-			nrl = ntfs_rl_insert  (drl, ds, srl + sstart, ss, dins);
-	else
+			drl = ntfs_rl_insert(drl, ds, srl + sstart, ss, dins);
+	} else {
 		if (finish)
-			nrl = ntfs_rl_append  (drl, ds, srl + sstart, ss, dins);
+			drl = ntfs_rl_append(drl, ds, srl + sstart, ss, dins);
 		else
-			nrl = ntfs_rl_split   (drl, ds, srl + sstart, ss, dins);
-
-	if (marker && !IS_ERR(nrl)) {
-		for (ds = 0; nrl[ds].length; ds++)
+			drl = ntfs_rl_split(drl, ds, srl + sstart, ss, dins);
+	}
+	if (IS_ERR(drl)) {
+		ntfs_error(NULL, "Merge failed.");
+		return drl;
+	}
+	ntfs_free(srl);
+	if (marker) {
+		ntfs_debug("Triggering marker code.");
+		for (ds = dend; drl[ds].length; ds++)
 			;
-		nrl = ntfs_rl_insert(nrl, ds + 1, srl + marker, 1, ds);
+		/* We only need to care if @srl ended after @drl. */
+		if (drl[ds].vcn <= marker_vcn) {
+			int slots = 0;
+
+			if (drl[ds].vcn == marker_vcn) {
+				ntfs_debug("Old marker = 0x%Lx, replacing with "
+						"LCN_ENOENT.\n",
+						(unsigned long long)
+						drl[ds].lcn);
+				drl[ds].lcn = (LCN)LCN_ENOENT;
+				goto finished;
+			}
+			/*
+			 * We need to create an unmapped run list element in
+			 * @drl or extend an existing one before adding the
+			 * ENOENT terminator.
+			 */
+			if (drl[ds].lcn == (LCN)LCN_ENOENT) {
+				ds--;
+				slots = 1;
+			}
+			if (drl[ds].lcn != (LCN)LCN_RL_NOT_MAPPED) {
+				/* Add an unmapped run list element. */
+				if (!slots) {
+					/* FIXME/TODO: We need to have the
+					 * extra memory already! (AIA) */
+					drl = ntfs_rl_realloc(drl, ds, ds + 2);
+					if (!drl)
+						goto critical_error;
+					slots = 2;
+				}
+				ds++;
+				/* Need to set vcn if it isn't set already. */
+				if (slots != 1)
+					drl[ds].vcn = drl[ds - 1].vcn +
+							drl[ds - 1].length;
+				drl[ds].lcn = (LCN)LCN_RL_NOT_MAPPED;
+				/* We now used up a slot. */
+				slots--;
+			}
+			drl[ds].length = marker_vcn - drl[ds].vcn;
+			/* Finally add the ENOENT terminator. */
+			ds++;
+			if (!slots) {
+				/* FIXME/TODO: We need to have the extra
+				 * memory already! (AIA) */
+				drl = ntfs_rl_realloc(drl, ds, ds + 1);
+				if (!drl)
+					goto critical_error;
+			}
+			drl[ds].vcn = marker_vcn;
+			drl[ds].lcn = (LCN)LCN_ENOENT;
+			drl[ds].length = (s64)0;
+		}
 	}
 	}
 
-	if (likely (!IS_ERR (nrl))) {
-		/* The merge was completed successfully. */
 finished:
-		if (nrl != srl)
-			ntfs_free (srl);
-		/*ntfs_debug ("Done.");*/
-		/*ntfs_debug ("Merged run list:");*/
-
-#if 1
-		ntfs_debug ("res:");
-		ntfs_debug_dump_runlist (nrl);
-#endif
-	} else {
-		ntfs_error (NULL, "Merge failed, returning error code %ld.",
-				-PTR_ERR (nrl));
-	}
-exit:
-	return nrl;
+	/* The merge was completed successfully. */
+	ntfs_debug("Merged run list:");
+	ntfs_debug_dump_runlist(drl);
+	return drl;
+
+critical_error:
+	/* Critical error! We cannot afford to fail here. */
+	ntfs_error(NULL, "Critical error! Not enough memory.");
+	panic("NTFS: Cannot continue.");
 }
 
 /**
  * decompress_mapping_pairs - convert mapping pairs array to run list
  * @vol:	ntfs volume on which the attribute resides
  * @attr:	attribute record whose mapping pairs array to decompress
- * @run_list:	optional run list in which to insert @attr's run list
- *
- * Decompress the attribute @attr's mapping pairs array into a run_list and
- * return the run list or -errno on error. If @run_list is not NULL then
- * the mapping pairs array of @attr is decompressed and the run list inserted
- * into the appropriate place in @run_list. If this is the case and the
- * function returns success, the original pointer passed into @run_list is no
- * longer valid.
+ * @old_rl:	optional run list in which to insert @attr's run list
  *
  * It is up to the caller to serialize access to the run list @old_rl.
  *
- * Check the return value for error with IS_ERR(ret_val). If this is FALSE,
- * the function was successful, the return value is the new run list, and if
- * an existing run list pointer was passed in, this is no longer valid.
- * If IS_ERR(ret_val) returns true, there was an error, the return value is not
- * a run_list pointer and the existing run list pointer if one was passed in
- * has not been touched. In this case use PTR_ERR(ret_val) to obtain the error
- * code. Following error codes are defined:
- * 	-ENOMEM		Not enough memory to allocate run list array.
- * 	-EIO		Corrupt run list.
- * 	-EINVAL		Invalid parameters were passed in.
- * 	-ERANGE		The two run lists overlap.
+ * Decompress the attribute @attr's mapping pairs array into a run list. On
+ * success, return the decompressed run list.
+ *
+ * If @old_rl is not NULL, decompressed run list is inserted into the
+ * appropriate place in @old_rl and the resultant, combined run list is
+ * returned. The original @old_rl is deallocated.
+ *
+ * On error, return -errno. @old_rl is left unmodified in that case.
+ *
+ * The following error codes are defined:
+ *	-ENOMEM	- Not enough memory to allocate run list array.
+ * 	-EIO	- Corrupt run list.
+ * 	-EINVAL	- Invalid parameters were passed in.
+ * 	-ERANGE	- The two run lists overlap.
  *
  * FIXME: For now we take the conceptionally simplest approach of creating the
  * new run list disregarding the already existing one and then splicing the
- * two into one if that is possible (we check for overlap and discard the new
- * run list if overlap present and return error).
+ * two into one, if that is possible (we check for overlap and discard the new
+ * run list if overlap present before returning ERR_PTR(-ERANGE)).
  */
 run_list_element *decompress_mapping_pairs(const ntfs_volume *vol,
 		const ATTR_RECORD *attr, run_list_element *old_rl)
@@ -576,12 +716,12 @@
 	VCN vcn;		/* Current vcn. */
 	LCN lcn; 		/* Current lcn. */
 	s64 deltaxcn;		/* Change in [vl]cn. */
-	run_list_element *rl = NULL;	/* The output run_list. */
-	run_list_element *rl2;	/* Temporary run_list. */
+	run_list_element *rl;	/* The output run list. */
 	u8 *buf;		/* Current position in mapping pairs array. */
 	u8 *attr_end;		/* End of attribute. */
-	int rlsize;		/* Size of run_list buffer. */
-	int rlpos;		/* Current run_list position. */
+	int rlsize;		/* Size of run list buffer. */
+	u16 rlpos;		/* Current run list position in units of
+				   run_list_elements. */
 	u8 b;			/* Current byte offset in buf. */
 
 #ifdef DEBUG
@@ -602,14 +742,12 @@
 		ntfs_error(vol->sb, "Corrupt attribute.");
 		return ERR_PTR(-EIO);
 	}
-	/* Current position in run_list array. */
+	/* Current position in run list array. */
 	rlpos = 0;
-	/* Allocate first page. */
-	rl = ntfs_malloc_nofs(PAGE_SIZE);
+	/* Allocate first page and set current run list size to one page. */
+	rl = ntfs_malloc_nofs(rlsize = PAGE_SIZE);
 	if (unlikely(!rl))
 		return ERR_PTR(-ENOMEM);
-	/* Current run_list buffer size in bytes. */
-	rlsize = PAGE_SIZE;
 	/* Insert unmapped starting element if necessary. */
 	if (vcn) {
 		rl->vcn = (VCN)0;
@@ -624,18 +762,20 @@
 		 * operates on whole pages only.
 		 */
 		if (((rlpos + 3) * sizeof(*old_rl)) > rlsize) {
+			run_list_element *rl2;
+			
 			rl2 = ntfs_malloc_nofs(rlsize + (int)PAGE_SIZE);
 			if (unlikely(!rl2)) {
 				ntfs_free(rl);
 				return ERR_PTR(-ENOMEM);
 			}
-			memmove(rl2, rl, rlsize);
+			memcpy(rl2, rl, rlsize);
 			ntfs_free(rl);
 			rl = rl2;
 			rlsize += PAGE_SIZE;
 		}
 		/* Enter the current vcn into the current run_list element. */
-		(rl + rlpos)->vcn = vcn;
+		rl[rlpos].vcn = vcn;
 		/*
 		 * Get the change in vcn, i.e. the run length in clusters.
 		 * Doing it this way ensures that we signextend negative values.
@@ -664,10 +804,10 @@
 			goto err_out;
 		}
 		/*
-		 * Enter the current run length into the current run_list
+		 * Enter the current run length into the current run list
 		 * element.
 		 */
-		(rl + rlpos)->length = deltaxcn;
+		rl[rlpos].length = deltaxcn;
 		/* Increment the current vcn by the current run length. */
 		vcn += deltaxcn;
 		/*
@@ -676,7 +816,7 @@
 		 * to LCN_HOLE.
 		 */
 		if (!(*buf & 0xf0))
-			(rl + rlpos)->lcn = (LCN)LCN_HOLE;
+			rl[rlpos].lcn = (LCN)LCN_HOLE;
 		else {
 			/* Get the lcn change which really can be negative. */
 			u8 b2 = *buf & 0xf;
@@ -709,7 +849,7 @@
 				goto err_out;
 			}
 			/* Enter the current lcn into the run_list element. */
-			(rl + rlpos)->lcn = lcn;
+			rl[rlpos].lcn = lcn;
 		}
 		/* Get to the next run_list element. */
 		rlpos++;
@@ -729,7 +869,7 @@
 				"non-resident attribute.");
 		goto err_out;
 	}
-	/* Setup not mapped run_list element if this is the base extent. */
+	/* Setup not mapped run list element if this is the base extent. */
 	if (!attr->_ANR(lowest_vcn)) {
 		VCN max_cluster;
 
@@ -742,13 +882,13 @@
 		 * likely, there are more extents following this one.
 		 */
 		if (deltaxcn < --max_cluster) {
-			//RAR ntfs_debug("More extents to follow; deltaxcn = 0x%Lx, "
-					//RAR "max_cluster = 0x%Lx",
-					//RAR (long long)deltaxcn,
-					//RAR (long long)max_cluster);
-			(rl + rlpos)->vcn = vcn;
-			vcn += (rl + rlpos)->length = max_cluster - deltaxcn;
-			(rl + rlpos)->lcn = (LCN)LCN_RL_NOT_MAPPED;
+			ntfs_debug("More extents to follow; deltaxcn = 0x%Lx, "
+					"max_cluster = 0x%Lx",
+					(long long)deltaxcn,
+					(long long)max_cluster);
+			rl[rlpos].vcn = vcn;
+			vcn += rl[rlpos].length = max_cluster - deltaxcn;
+			rl[rlpos].lcn = (LCN)LCN_RL_NOT_MAPPED;
 			rlpos++;
 		} else if (unlikely(deltaxcn > max_cluster)) {
 			ntfs_error(vol->sb, "Corrupt attribute. deltaxcn = "
@@ -757,25 +897,26 @@
 					(long long)max_cluster);
 			goto mpa_err;
 		}
-		(rl + rlpos)->lcn = (LCN)LCN_ENOENT;
+		rl[rlpos].lcn = (LCN)LCN_ENOENT;
 	} else /* Not the base extent. There may be more extents to follow. */
-		(rl + rlpos)->lcn = (LCN)LCN_RL_NOT_MAPPED;
+		rl[rlpos].lcn = (LCN)LCN_RL_NOT_MAPPED;
 
 	/* Setup terminating run_list element. */
-	(rl + rlpos)->vcn = vcn;
-	(rl + rlpos)->length = (s64)0;
-	//RAR ntfs_debug("Mapping pairs array successfully decompressed.");
-	//RAR ntfs_debug_dump_runlist(rl);
+	rl[rlpos].vcn = vcn;
+	rl[rlpos].length = (s64)0;
 	/* If no existing run list was specified, we are done. */
-	if (!old_rl)
+	if (!old_rl) {
+		ntfs_debug("Mapping pairs array successfully decompressed:");
+		ntfs_debug_dump_runlist(rl);
 		return rl;
+	}
 	/* Now combine the new and old run lists checking for overlaps. */
-	rl2 = merge_run_lists(old_rl, rl);
-	if (likely(!IS_ERR(rl2)))
-		return rl2;
+	old_rl = ntfs_merge_run_lists(old_rl, rl);
+	if (likely(!IS_ERR(old_rl)))
+		return old_rl;
 	ntfs_free(rl);
 	ntfs_error(vol->sb, "Failed to merge run lists.");
-	return rl2;
+	return old_rl;
 io_error:
 	ntfs_error(vol->sb, "Corrupt attribute.");
 err_out:
diff -Nru a/fs/ntfs/mst.c b/fs/ntfs/mst.c
--- a/fs/ntfs/mst.c	Thu Jul  4 11:35:24 2002
+++ b/fs/ntfs/mst.c	Thu Jul  4 11:35:24 2002
@@ -48,7 +48,7 @@
 	usa_ofs = le16_to_cpu(b->usa_ofs);
 	/* Decrement usa_count to get number of fixups. */
 	usa_count = le16_to_cpu(b->usa_count) - 1;
-	/* Size and alignement checks. */
+	/* Size and alignment checks. */
 	if ( size & (NTFS_BLOCK_SIZE - 1)	||
 	     usa_ofs & 1			||
 	     usa_ofs + (usa_count * 2) > size	||
@@ -132,7 +132,7 @@
 	usa_ofs = le16_to_cpu(b->usa_ofs);
 	/* Decrement usa_count to get number of fixups. */
 	usa_count = le16_to_cpu(b->usa_count) - 1;
-	/* Size and alignement checks. */
+	/* Size and alignment checks. */
 	if ( size & (NTFS_BLOCK_SIZE - 1)	||
 	     usa_ofs & 1			||
 	     usa_ofs + (usa_count * 2) > size	||
diff -Nru a/fs/ntfs/super.c b/fs/ntfs/super.c
--- a/fs/ntfs/super.c	Thu Jul  4 11:35:24 2002
+++ b/fs/ntfs/super.c	Thu Jul  4 11:35:24 2002
@@ -1077,7 +1077,7 @@
  * releases all inodes and memory belonging to the NTFS specific part of the
  * super block.
  */
-void ntfs_put_super(struct super_block *vfs_sb)
+static void ntfs_put_super(struct super_block *vfs_sb)
 {
 	ntfs_volume *vol = NTFS_SB(vfs_sb);
 
@@ -1155,7 +1155,7 @@
  * Errors are ignored and we just return the number of free clusters we have
  * found. This means we return an underestimate on error.
  */
-s64 get_nr_free_clusters(ntfs_volume *vol)
+static s64 get_nr_free_clusters(ntfs_volume *vol)
 {
 	struct address_space *mapping = vol->lcnbmp_ino->i_mapping;
 	filler_t *readpage = (filler_t*)mapping->a_ops->readpage;
@@ -1227,7 +1227,7 @@
 }
 
 /**
- * get_nr_free_mft_records - return the number of free inodes on a volume
+ * __get_nr_free_mft_records - return the number of free inodes on a volume
  * @vol:	ntfs volume for which to obtain free inode count
  *
  * Calculate the number of free mft records (inodes) on the mounted NTFS
@@ -1235,8 +1235,10 @@
  *
  * Errors are ignored and we just return the number of free inodes we have
  * found. This means we return an underestimate on error.
+ *
+ * NOTE: Caller must hold mftbmp_lock rw_semaphore for reading or writing.
  */
-unsigned long get_nr_free_mft_records(ntfs_volume *vol)
+static unsigned long __get_nr_free_mft_records(ntfs_volume *vol)
 {
 	struct address_space *mapping;
 	filler_t *readpage;
@@ -1247,7 +1249,6 @@
 
 	ntfs_debug("Entering.");
 	/* Serialize accesses to the inode bitmap. */
-	down_read(&vol->mftbmp_lock);
 	mapping = &vol->mftbmp_mapping;
 	readpage = (filler_t*)mapping->a_ops->readpage;
 	/*
@@ -1307,7 +1308,6 @@
 	}
 	ntfs_debug("Finished reading $MFT/$BITMAP, last index = 0x%lx",
 			index - 1);
-	up_read(&vol->mftbmp_lock);
 	ntfs_debug("Exiting.");
 	return nr_free;
 }
@@ -1330,7 +1330,7 @@
  *
  * Return 0 on success or -errno on error.
  */
-int ntfs_statfs(struct super_block *sb, struct statfs *sfs)
+static int ntfs_statfs(struct super_block *sb, struct statfs *sfs)
 {
 	ntfs_volume *vol = NTFS_SB(sb);
 	s64 size;
@@ -1354,10 +1354,12 @@
 		size = 0LL;
 	/* Free blocks avail to non-superuser, same as above on NTFS. */
 	sfs->f_bavail = sfs->f_bfree = size;
+	down_read(&vol->mftbmp_lock);
 	/* Total file nodes in file system (at this moment in time). */
 	sfs->f_files  = vol->mft_ino->i_size >> vol->mft_record_size_bits;
 	/* Free file nodes in fs (based on current total count). */
-	sfs->f_ffree = get_nr_free_mft_records(vol);
+	sfs->f_ffree = __get_nr_free_mft_records(vol);
+	up_read(&vol->mftbmp_lock);
 	/*
 	 * File system id. This is extremely *nix flavour dependent and even
 	 * within Linux itself all fs do their own thing. I interpret this to

===================================================================

This BitKeeper patch contains the following changesets:
aia21@cantab.net|ChangeSet|20020703215523|04706
## Wrapped with gzip_uu ##


begin 664 bkpatch16646
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
$S&D`````
`
end
