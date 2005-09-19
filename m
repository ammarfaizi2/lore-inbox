Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932375AbVISJbc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbVISJbc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 05:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbVISJbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 05:31:32 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:12985 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932375AbVISJbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 05:31:31 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Mon, 19 Sep 2005 10:31:27 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [1/3] NTFS: Fix various bugs in the runlist merging code.
In-Reply-To: <Pine.LNX.4.60.0509190950420.19497@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0509191029490.19497@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0509190950420.19497@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NTFS: Fix various bugs in the runlist merging code.  (Based on libntfs
      changes by Richard Russon.)

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

 fs/ntfs/ChangeLog |    2 +
 fs/ntfs/runlist.c |  132 +++++++++++++++++++++++++++--------------------------
 2 files changed, 70 insertions(+), 64 deletions(-)

5c9f6de3b80ca46000bd1b63d892820f9ee32138
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -92,6 +92,8 @@ ToDo/Notes:
 	  an octal number to conform to how chmod(1) works, too.  Thanks to
 	  Giuseppe Bilotta and Horst von Brand for pointing out the errors of
 	  my ways.
+	- Fix various bugs in the runlist merging code.  (Based on libntfs
+	  changes by Richard Russon.)
 
 2.1.23 - Implement extension of resident files and make writing safe as well as
 	 many bug fixes, cleanups, and enhancements...
diff --git a/fs/ntfs/runlist.c b/fs/ntfs/runlist.c
--- a/fs/ntfs/runlist.c
+++ b/fs/ntfs/runlist.c
@@ -2,7 +2,7 @@
  * runlist.c - NTFS runlist handling code.  Part of the Linux-NTFS project.
  *
  * Copyright (c) 2001-2005 Anton Altaparmakov
- * Copyright (c) 2002 Richard Russon
+ * Copyright (c) 2002-2005 Richard Russon
  *
  * This program/include file is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as published
@@ -214,8 +214,8 @@ static inline void __ntfs_rl_merge(runli
 static inline runlist_element *ntfs_rl_append(runlist_element *dst,
 		int dsize, runlist_element *src, int ssize, int loc)
 {
-	BOOL right;
-	int magic;
+	BOOL right;	/* Right end of @src needs merging. */
+	int marker;	/* End of the inserted runs. */
 
 	BUG_ON(!dst);
 	BUG_ON(!src);
@@ -236,18 +236,19 @@ static inline runlist_element *ntfs_rl_a
 	if (right)
 		__ntfs_rl_merge(src + ssize - 1, dst + loc + 1);
 
-	magic = loc + ssize;
+	/* First run after the @src runs that have been inserted. */
+	marker = loc + ssize + 1;
 
 	/* Move the tail of @dst out of the way, then copy in @src. */
-	ntfs_rl_mm(dst, magic + 1, loc + 1 + right, dsize - loc - 1 - right);
+	ntfs_rl_mm(dst, marker, loc + 1 + right, dsize - (loc + 1 + right));
 	ntfs_rl_mc(dst, loc + 1, src, 0, ssize);
 
 	/* Adjust the size of the preceding hole. */
 	dst[loc].length = dst[loc + 1].vcn - dst[loc].vcn;
 
 	/* We may have changed the length of the file, so fix the end marker */
-	if (dst[magic + 1].lcn == LCN_ENOENT)
-		dst[magic + 1].vcn = dst[magic].vcn + dst[magic].length;
+	if (dst[marker].lcn == LCN_ENOENT)
+		dst[marker].vcn = dst[marker - 1].vcn + dst[marker - 1].length;
 
 	return dst;
 }
@@ -279,18 +280,17 @@ static inline runlist_element *ntfs_rl_a
 static inline runlist_element *ntfs_rl_insert(runlist_element *dst,
 		int dsize, runlist_element *src, int ssize, int loc)
 {
-	BOOL left = FALSE;
-	BOOL disc = FALSE;	/* Discontinuity */
-	BOOL hole = FALSE;	/* Following a hole */
-	int magic;
+	BOOL left = FALSE;	/* Left end of @src needs merging. */
+	BOOL disc = FALSE;	/* Discontinuity between @dst and @src. */
+	int marker;		/* End of the inserted runs. */
 
 	BUG_ON(!dst);
 	BUG_ON(!src);
 
-	/* disc => Discontinuity between the end of @dst and the start of @src.
-	 *	   This means we might need to insert a hole.
-	 * hole => @dst ends with a hole or an unmapped region which we can
-	 *	   extend to match the discontinuity. */
+	/*
+	 * disc => Discontinuity between the end of @dst and the start of @src.
+	 *	   This means we might need to insert a "not mapped" run.
+	 */
 	if (loc == 0)
 		disc = (src[0].vcn > 0);
 	else {
@@ -303,58 +303,49 @@ static inline runlist_element *ntfs_rl_i
 			merged_length += src->length;
 
 		disc = (src[0].vcn > dst[loc - 1].vcn + merged_length);
-		if (disc)
-			hole = (dst[loc - 1].lcn == LCN_HOLE);
 	}
-
-	/* Space required: @dst size + @src size, less one if we merged, plus
-	 * one if there was a discontinuity, less one for a trailing hole. */
-	dst = ntfs_rl_realloc(dst, dsize, dsize + ssize - left + disc - hole);
+	/*
+	 * Space required: @dst size + @src size, less one if we merged, plus
+	 * one if there was a discontinuity.
+	 */
+	dst = ntfs_rl_realloc(dst, dsize, dsize + ssize - left + disc);
 	if (IS_ERR(dst))
 		return dst;
 	/*
 	 * We are guaranteed to succeed from here so can start modifying the
 	 * original runlist.
 	 */
-
 	if (left)
 		__ntfs_rl_merge(dst + loc - 1, src);
-
-	magic = loc + ssize - left + disc - hole;
+	/*
+	 * First run after the @src runs that have been inserted.
+	 * Nominally,  @marker equals @loc + @ssize, i.e. location + number of
+	 * runs in @src.  However, if @left, then the first run in @src has
+	 * been merged with one in @dst.  And if @disc, then @dst and @src do
+	 * not meet and we need an extra run to fill the gap.
+	 */
+	marker = loc + ssize - left + disc;
 
 	/* Move the tail of @dst out of the way, then copy in @src. */
-	ntfs_rl_mm(dst, magic, loc, dsize - loc);
-	ntfs_rl_mc(dst, loc + disc - hole, src, left, ssize - left);
+	ntfs_rl_mm(dst, marker, loc, dsize - loc);
+	ntfs_rl_mc(dst, loc + disc, src, left, ssize - left);
 
-	/* Adjust the VCN of the last run ... */
-	if (dst[magic].lcn <= LCN_HOLE)
-		dst[magic].vcn = dst[magic - 1].vcn + dst[magic - 1].length;
+	/* Adjust the VCN of the first run after the insertion... */
+	dst[marker].vcn = dst[marker - 1].vcn + dst[marker - 1].length;
 	/* ... and the length. */
-	if (dst[magic].lcn == LCN_HOLE || dst[magic].lcn == LCN_RL_NOT_MAPPED)
-		dst[magic].length = dst[magic + 1].vcn - dst[magic].vcn;
+	if (dst[marker].lcn == LCN_HOLE || dst[marker].lcn == LCN_RL_NOT_MAPPED)
+		dst[marker].length = dst[marker + 1].vcn - dst[marker].vcn;
 
-	/* Writing beyond the end of the file and there's a discontinuity. */
+	/* Writing beyond the end of the file and there is a discontinuity. */
 	if (disc) {
-		if (hole)
-			dst[loc - 1].length = dst[loc].vcn - dst[loc - 1].vcn;
-		else {
-			if (loc > 0) {
-				dst[loc].vcn = dst[loc - 1].vcn +
-						dst[loc - 1].length;
-				dst[loc].length = dst[loc + 1].vcn -
-						dst[loc].vcn;
-			} else {
-				dst[loc].vcn = 0;
-				dst[loc].length = dst[loc + 1].vcn;
-			}
-			dst[loc].lcn = LCN_RL_NOT_MAPPED;
+		if (loc > 0) {
+			dst[loc].vcn = dst[loc - 1].vcn + dst[loc - 1].length;
+			dst[loc].length = dst[loc + 1].vcn - dst[loc].vcn;
+		} else {
+			dst[loc].vcn = 0;
+			dst[loc].length = dst[loc + 1].vcn;
 		}
-
-		magic += hole;
-
-		if (dst[magic].lcn == LCN_ENOENT)
-			dst[magic].vcn = dst[magic - 1].vcn +
-					dst[magic - 1].length;
+		dst[loc].lcn = LCN_RL_NOT_MAPPED;
 	}
 	return dst;
 }
@@ -385,9 +376,10 @@ static inline runlist_element *ntfs_rl_i
 static inline runlist_element *ntfs_rl_replace(runlist_element *dst,
 		int dsize, runlist_element *src, int ssize, int loc)
 {
-	BOOL left = FALSE;
-	BOOL right;
-	int magic;
+	BOOL left = FALSE;	/* Left end of @src needs merging. */
+	BOOL right;		/* Right end of @src needs merging. */
+	int tail;		/* Start of tail of @dst. */
+	int marker;		/* End of the inserted runs. */
 
 	BUG_ON(!dst);
 	BUG_ON(!src);
@@ -396,9 +388,10 @@ static inline runlist_element *ntfs_rl_r
 	right = ntfs_are_rl_mergeable(src + ssize - 1, dst + loc + 1);
 	if (loc > 0)
 		left = ntfs_are_rl_mergeable(dst + loc - 1, src);
-
-	/* Allocate some space. We'll need less if the left, right, or both
-	 * ends were merged. */
+	/*
+	 * Allocate some space.  We will need less if the left, right, or both
+	 * ends were merged.
+	 */
 	dst = ntfs_rl_realloc(dst, dsize, dsize + ssize - left - right);
 	if (IS_ERR(dst))
 		return dst;
@@ -410,17 +403,28 @@ static inline runlist_element *ntfs_rl_r
 		__ntfs_rl_merge(src + ssize - 1, dst + loc + 1);
 	if (left)
 		__ntfs_rl_merge(dst + loc - 1, src);
-
-	/* FIXME: What does this mean? (AIA) */
-	magic = loc + ssize - left;
+	/*
+	 * First run of @dst that needs to be moved out of the way to make
+	 * space for the runs to be copied from @src, i.e. the first run of the
+	 * tail of @dst.
+	 */
+	tail = loc + right + 1;
+	/*
+	 * First run after the @src runs that have been inserted, i.e. where
+	 * the tail of @dst needs to be moved to.
+	 * Nominally, marker equals @loc + @ssize, i.e. location + number of
+	 * runs in @src).  However, if @left, then the first run in @src has
+	 * been merged with one in @dst.
+	 */
+	marker = loc + ssize - left;
 
 	/* Move the tail of @dst out of the way, then copy in @src. */
-	ntfs_rl_mm(dst, magic, loc + right + 1, dsize - loc - right - 1);
+	ntfs_rl_mm(dst, marker, tail, dsize - tail);
 	ntfs_rl_mc(dst, loc, src, left, ssize - left);
 
-	/* We may have changed the length of the file, so fix the end marker */
-	if (dst[magic].lcn == LCN_ENOENT)
-		dst[magic].vcn = dst[magic - 1].vcn + dst[magic - 1].length;
+	/* We may have changed the length of the file, so fix the end marker. */
+	if (dsize - tail > 0 && dst[marker].lcn == LCN_ENOENT)
+		dst[marker].vcn = dst[marker - 1].vcn + dst[marker - 1].length;
 	return dst;
 }
 
