Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965119AbVIIJVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965119AbVIIJVV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 05:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965121AbVIIJVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 05:21:21 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:40130 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S965119AbVIIJVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 05:21:20 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Fri, 9 Sep 2005 10:21:18 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 3/25] NTFS: Use ntfs_malloc_nofs_nofail() in ntfs_runlists_merge().
In-Reply-To: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0509091020280.26845@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 3/25] NTFS: Use ntfs_malloc_nofs_nofail() in ntfs_runlists_merge()
      in the two critical regions.  This means we no longer need to
      panic() when the allocation fails as it now cannot fail.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

 fs/ntfs/ChangeLog |    3 ++
 fs/ntfs/runlist.c |   68 +++++++++++++++++++++++++++++++++++++++--------------
 2 files changed, 53 insertions(+), 18 deletions(-)

9529d461d0992959026264b8fc002ac01d226708
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -40,6 +40,9 @@ ToDo/Notes:
 	- Add fs/ntfs/malloc.h::ntfs_malloc_nofs_nofail() which is analogous to
 	  ntfs_malloc_nofs() but it performs allocations with __GFP_NOFAIL and
 	  hence cannot fail.
+	- Use ntfs_malloc_nofs_nofail() in the two critical regions in
+	  fs/ntfs/runlist.c::ntfs_runlists_merge().  This means we no longer
+	  need to panic() if the allocation fails as it now cannot fail.
 
 2.1.23 - Implement extension of resident files and make writing safe as well as
 	 many bug fixes, cleanups, and enhancements...
diff --git a/fs/ntfs/runlist.c b/fs/ntfs/runlist.c
--- a/fs/ntfs/runlist.c
+++ b/fs/ntfs/runlist.c
@@ -35,7 +35,7 @@ static inline void ntfs_rl_mm(runlist_el
 		int size)
 {
 	if (likely((dst != src) && (size > 0)))
-		memmove(base + dst, base + src, size * sizeof (*base));
+		memmove(base + dst, base + src, size * sizeof(*base));
 }
 
 /**
@@ -95,6 +95,51 @@ static inline runlist_element *ntfs_rl_r
 }
 
 /**
+ * ntfs_rl_realloc_nofail - Reallocate memory for runlists
+ * @rl:		original runlist
+ * @old_size:	number of runlist elements in the original runlist @rl
+ * @new_size:	number of runlist elements we need space for
+ *
+ * As the runlists grow, more memory will be required.  To prevent the
+ * kernel having to allocate and reallocate large numbers of small bits of
+ * memory, this function returns an entire page of memory.
+ *
+ * This function guarantees that the allocation will succeed.  It will sleep
+ * for as long as it takes to complete the allocation.
+ *
+ * It is up to the caller to serialize access to the runlist @rl.
+ *
+ * N.B.  If the new allocation doesn't require a different number of pages in
+ *       memory, the function will return the original pointer.
+ *
+ * On success, return a pointer to the newly allocated, or recycled, memory.
+ * On error, return -errno. The following error codes are defined:
+ *	-ENOMEM	- Not enough memory to allocate runlist array.
+ *	-EINVAL	- Invalid parameters were passed in.
+ */
+static inline runlist_element *ntfs_rl_realloc_nofail(runlist_element *rl,
+		int old_size, int new_size)
+{
+	runlist_element *new_rl;
+
+	old_size = PAGE_ALIGN(old_size * sizeof(*rl));
+	new_size = PAGE_ALIGN(new_size * sizeof(*rl));
+	if (old_size == new_size)
+		return rl;
+
+	new_rl = ntfs_malloc_nofs_nofail(new_size);
+	BUG_ON(!new_rl);
+
+	if (likely(rl != NULL)) {
+		if (unlikely(old_size > new_size))
+			old_size = new_size;
+		memcpy(new_rl, rl, old_size);
+		ntfs_free(rl);
+	}
+	return new_rl;
+}
+
+/**
  * ntfs_are_rl_mergeable - test if two runlists can be joined together
  * @dst:	original runlist
  * @src:	new runlist to test for mergeability with @dst
@@ -621,11 +666,8 @@ runlist_element *ntfs_runlists_merge(run
 			if (drl[ds].lcn != LCN_RL_NOT_MAPPED) {
 				/* Add an unmapped runlist element. */
 				if (!slots) {
-					/* FIXME/TODO: We need to have the
-					 * extra memory already! (AIA) */
-					drl = ntfs_rl_realloc(drl, ds, ds + 2);
-					if (!drl)
-						goto critical_error;
+					drl = ntfs_rl_realloc_nofail(drl, ds,
+							ds + 2);
 					slots = 2;
 				}
 				ds++;
@@ -640,13 +682,8 @@ runlist_element *ntfs_runlists_merge(run
 			drl[ds].length = marker_vcn - drl[ds].vcn;
 			/* Finally add the ENOENT terminator. */
 			ds++;
-			if (!slots) {
-				/* FIXME/TODO: We need to have the extra
-				 * memory already! (AIA) */
-				drl = ntfs_rl_realloc(drl, ds, ds + 1);
-				if (!drl)
-					goto critical_error;
-			}
+			if (!slots)
+				drl = ntfs_rl_realloc_nofail(drl, ds, ds + 1);
 			drl[ds].vcn = marker_vcn;
 			drl[ds].lcn = LCN_ENOENT;
 			drl[ds].length = (s64)0;
@@ -659,11 +696,6 @@ finished:
 	ntfs_debug("Merged runlist:");
 	ntfs_debug_dump_runlist(drl);
 	return drl;
-
-critical_error:
-	/* Critical error! We cannot afford to fail here. */
-	ntfs_error(NULL, "Critical error! Not enough memory.");
-	panic("NTFS: Cannot continue.");
 }
 
 /**
