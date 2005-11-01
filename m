Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbVKAQKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbVKAQKX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 11:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbVKAQKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 11:10:23 -0500
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:59039 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1750763AbVKAQKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 11:10:22 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Tue, 1 Nov 2005 16:10:07 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
       Yura Pakhuchiy <pakhuchiy@gmail.com>
Subject: [2.6-GIT] NTFS: Fix the segfault in the new write code.
Message-ID: <Pine.LNX.4.64.0511011605240.17031@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/aia21/ntfs-2.6.git

This fixes the segfault reported by Yura Pakhuchiy in the new write code.

Diffstat:

 fs/ntfs/file.c |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

The diff is below for non-git users.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

---

NTFS: Fix a stupid bug causing writes to non-initialized pages to segfault.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

applies-to: d7e2216b6e65b833c0c2b79b478d13ce17dbf296
3aebf25bdcf030f3e4afeb9340486d5b46deb46e
diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index cf3e6ce..7275338 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -668,10 +668,10 @@ map_buffer_cached:
 				 * to, we need to read it in before the write,
 				 * i.e. now.
 				 */
-				if (!buffer_uptodate(bh) && ((bh_pos < pos &&
-						bh_end > pos) ||
-						(bh_end > end &&
-						bh_end > end))) {
+				if (!buffer_uptodate(bh) && bh_pos < end &&
+						bh_end > pos &&
+						(bh_pos < pos ||
+						bh_end > end)) {
 					/*
 					 * If the buffer is fully or partially
 					 * within the initialized size, do an
@@ -784,10 +784,11 @@ retry_remap:
 						blocksize_bits);
 				cdelta = 0;
 				/*
-				 * If the number of remaining clusters in the
-				 * @pages is smaller or equal to the number of
-				 * cached clusters, unlock the runlist as the
-				 * map cache will be used from now on.
+				 * If the number of remaining clusters touched
+				 * by the write is smaller or equal to the
+				 * number of cached clusters, unlock the
+				 * runlist as the map cache will be used from
+				 * now on.
 				 */
 				if (likely(vcn + vcn_len >= cend)) {
 					if (rl_write_locked) {
---
0.99.9
