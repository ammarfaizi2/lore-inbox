Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbVITN5V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbVITN5V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 09:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932416AbVITN5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 09:57:21 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:659 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932195AbVITN5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 09:57:20 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Tue, 20 Sep 2005 14:46:19 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [2.6.14-rc2-git] And more NTFS bugfixes.
Message-ID: <Pine.LNX.4.60.0509201442190.15718@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from

rsync://rsync.kernel.org/pub/scm/linux/kernel/git/aia21/ntfs-2.6.git/HEAD

 fs/ntfs/runlist.c |   55 ++++++++++++++++++++++++++++++++---------------------
 1 files changed, 33 insertions(+), 22 deletions(-)

This contains more bugfixes for NTFS that need to go in before 2.6.14
is released.  -  Please apply.  Thanks!  -  There should not be any more 
for 2.6.14!  Famous last words...

Since this is only one changeset, I have added the actual diff format 
patches for non-git users at the bottom of this email.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

---

NTFS: More runlist handling fixes from Richard Russon and myself.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

eed8b2dee7cff46dd4bf5b82dc53465d229162ba
diff --git a/fs/ntfs/runlist.c b/fs/ntfs/runlist.c
--- a/fs/ntfs/runlist.c
+++ b/fs/ntfs/runlist.c
@@ -158,17 +158,21 @@ static inline BOOL ntfs_are_rl_mergeable
 	BUG_ON(!dst);
 	BUG_ON(!src);
 
-	if ((dst->lcn < 0) || (src->lcn < 0)) {   /* Are we merging holes? */
-		if (dst->lcn == LCN_HOLE && src->lcn == LCN_HOLE)
-			return TRUE;
+	/* We can merge unmapped regions even if they are misaligned. */
+	if ((dst->lcn == LCN_RL_NOT_MAPPED) && (src->lcn == LCN_RL_NOT_MAPPED))
+		return TRUE;
+	/* If the runs are misaligned, we cannot merge them. */
+	if ((dst->vcn + dst->length) != src->vcn)
 		return FALSE;
-	}
-	if ((dst->lcn + dst->length) != src->lcn) /* Are the runs contiguous? */
-		return FALSE;
-	if ((dst->vcn + dst->length) != src->vcn) /* Are the runs misaligned? */
-		return FALSE;
-
-	return TRUE;
+	/* If both runs are non-sparse and contiguous, we can merge them. */
+	if ((dst->lcn >= 0) && (src->lcn >= 0) &&
+			((dst->lcn + dst->length) == src->lcn))
+		return TRUE;
+	/* If we are merging two holes, we can merge them. */
+	if ((dst->lcn == LCN_HOLE) && (src->lcn == LCN_HOLE))
+		return TRUE;
+	/* Cannot merge. */
+	return FALSE;
 }
 
 /**
@@ -214,14 +218,15 @@ static inline void __ntfs_rl_merge(runli
 static inline runlist_element *ntfs_rl_append(runlist_element *dst,
 		int dsize, runlist_element *src, int ssize, int loc)
 {
-	BOOL right;	/* Right end of @src needs merging. */
-	int marker;	/* End of the inserted runs. */
+	BOOL right = FALSE;	/* Right end of @src needs merging. */
+	int marker;		/* End of the inserted runs. */
 
 	BUG_ON(!dst);
 	BUG_ON(!src);
 
 	/* First, check if the right hand end needs merging. */
-	right = ntfs_are_rl_mergeable(src + ssize - 1, dst + loc + 1);
+	if ((loc + 1) < dsize)
+		right = ntfs_are_rl_mergeable(src + ssize - 1, dst + loc + 1);
 
 	/* Space required: @dst size + @src size, less one if we merged. */
 	dst = ntfs_rl_realloc(dst, dsize, dsize + ssize - right);
@@ -377,20 +382,21 @@ static inline runlist_element *ntfs_rl_r
 		int dsize, runlist_element *src, int ssize, int loc)
 {
 	BOOL left = FALSE;	/* Left end of @src needs merging. */
-	BOOL right;		/* Right end of @src needs merging. */
+	BOOL right = FALSE;	/* Right end of @src needs merging. */
 	int tail;		/* Start of tail of @dst. */
 	int marker;		/* End of the inserted runs. */
 
 	BUG_ON(!dst);
 	BUG_ON(!src);
 
-	/* First, merge the left and right ends, if necessary. */
-	right = ntfs_are_rl_mergeable(src + ssize - 1, dst + loc + 1);
+	/* First, see if the left and right ends need merging. */
+	if ((loc + 1) < dsize)
+		right = ntfs_are_rl_mergeable(src + ssize - 1, dst + loc + 1);
 	if (loc > 0)
 		left = ntfs_are_rl_mergeable(dst + loc - 1, src);
 	/*
 	 * Allocate some space.  We will need less if the left, right, or both
-	 * ends were merged.
+	 * ends get merged.
 	 */
 	dst = ntfs_rl_realloc(dst, dsize, dsize + ssize - left - right);
 	if (IS_ERR(dst))
@@ -399,21 +405,26 @@ static inline runlist_element *ntfs_rl_r
 	 * We are guaranteed to succeed from here so can start modifying the
 	 * original runlists.
 	 */
+
+	/* First, merge the left and right ends, if necessary. */
 	if (right)
 		__ntfs_rl_merge(src + ssize - 1, dst + loc + 1);
 	if (left)
 		__ntfs_rl_merge(dst + loc - 1, src);
 	/*
-	 * First run of @dst that needs to be moved out of the way to make
-	 * space for the runs to be copied from @src, i.e. the first run of the
-	 * tail of @dst.
+	 * Offset of the tail of @dst.  This needs to be moved out of the way
+	 * to make space for the runs to be copied from @src, i.e. the first
+	 * run of the tail of @dst.
+	 * Nominally, @tail equals @loc + 1, i.e. location, skipping the
+	 * replaced run.  However, if @right, then one of @dst's runs is
+	 * already merged into @src.
 	 */
 	tail = loc + right + 1;
 	/*
 	 * First run after the @src runs that have been inserted, i.e. where
 	 * the tail of @dst needs to be moved to.
-	 * Nominally, marker equals @loc + @ssize, i.e. location + number of
-	 * runs in @src).  However, if @left, then the first run in @src has
+	 * Nominally, @marker equals @loc + @ssize, i.e. location + number of
+	 * runs in @src.  However, if @left, then the first run in @src has
 	 * been merged with one in @dst.
 	 */
 	marker = loc + ssize - left;
