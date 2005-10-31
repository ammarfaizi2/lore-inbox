Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932288AbVJaOlq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbVJaOlq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 09:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbVJaOlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 09:41:46 -0500
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:3753 "EHLO
	ppsw-9.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932288AbVJaOlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 09:41:45 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Mon, 31 Oct 2005 14:41:43 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 16/17] NTFS: Fix compilation warnings with gcc-4.0.2 on SUSE
 10.0.
In-Reply-To: <Pine.LNX.4.64.0510311408160.27357@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.64.0510311440260.27357@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.64.0510311408160.27357@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NTFS: Fix compilation warnings with gcc-4.0.2 on SUSE 10.0.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

 fs/ntfs/ChangeLog |    1 +
 fs/ntfs/attrib.c  |    2 +-
 fs/ntfs/file.c    |   23 ++++++++---------------
 3 files changed, 10 insertions(+), 16 deletions(-)

applies-to: 53086f94589ecf35912e47fa14b8d8a5bc4714c0
dda65b941f992ab10fda3d9f09539c68206b7114
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
index 2a76b1f..dea7424 100644
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -77,6 +77,7 @@ ToDo/Notes:
 	  EOPNOTSUPP is returned.
 	- $EA attributes can be both resident and non-resident.
 	- Use %z for size_t to fix compilation warnings.  (Andrew Morton)
+	- Fix compilation warnings with gcc-4.0.2 on SUSE 10.0.
 
 2.1.24 - Lots of bug fixes and support more clean journal states.
 
diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index df2e209..eda056b 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -91,7 +91,7 @@ int ntfs_map_runlist_nolock(ntfs_inode *
 	struct page *put_this_page = NULL;
 	int err = 0;
 	BOOL ctx_is_temporary, ctx_needs_reset;
-	ntfs_attr_search_ctx old_ctx;
+	ntfs_attr_search_ctx old_ctx = { NULL, };
 
 	ntfs_debug("Mapping runlist part containing vcn 0x%llx.",
 			(unsigned long long)vcn);
diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index cdedc84..cf3e6ce 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -78,12 +78,8 @@ static int ntfs_file_open(struct inode *
  * Extend the initialized size of an attribute described by the ntfs inode @ni
  * to @new_init_size bytes.  This involves zeroing any non-sparse space between
  * the old initialized size and @new_init_size both in the page cache and on
- * disk (if relevant complete pages are zeroed in the page cache then these may
- * simply be marked dirty for later writeout).  There is one caveat and that is
- * that if any uptodate page cache pages between the old initialized size and
- * the smaller of @new_init_size and the file size (vfs inode->i_size) are in
- * memory, these need to be marked dirty without being zeroed since they could
- * be non-zero due to mmap() based writes.
+ * disk (if relevant complete pages are already uptodate in the page cache then
+ * these are simply marked dirty).
  *
  * As a side-effect, the file size (vfs inode->i_size) may be incremented as,
  * in the resident attribute case, it is tied to the initialized size and, in
@@ -98,10 +94,10 @@ static int ntfs_file_open(struct inode *
  * with new data via mmap() based writes, so we cannot just zero it.  And since
  * POSIX specifies that the behaviour of resizing a file whilst it is mmap()ped
  * is unspecified, we choose not to do zeroing and thus we do not need to touch
- * the page at all.  For a more detailed explanation see ntfs_truncate() which
- * is in fs/ntfs/inode.c.
+ * the page at all.  For a more detailed explanation see ntfs_truncate() in
+ * fs/ntfs/inode.c.
  *
- * @cached_page and @lru_pvec are just optimisations for dealing with multiple
+ * @cached_page and @lru_pvec are just optimizations for dealing with multiple
  * pages.
  *
  * Return 0 on success and -errno on error.  In the case that an error is
@@ -110,9 +106,8 @@ static int ntfs_file_open(struct inode *
  * this is the case, the necessary zeroing will also have happened and that all
  * metadata is self-consistent.
  *
- * Locking: This function locks the mft record of the base ntfs inode and
- * maintains the lock throughout execution of the function.  This is required
- * so that the initialized size of the attribute can be modified safely.
+ * Locking: i_sem on the vfs inode corrseponsind to the ntfs inode @ni must be
+ *	    held by the caller.
  */
 static int ntfs_attr_extend_initialized(ntfs_inode *ni, const s64 new_init_size,
 		struct page **cached_page, struct pagevec *lru_pvec)
@@ -1836,7 +1831,7 @@ static ssize_t ntfs_file_buffered_write(
 	VCN last_vcn;
 	LCN lcn;
 	unsigned long flags;
-	size_t bytes, iov_ofs;
+	size_t bytes, iov_ofs = 0;	/* Offset in the current iovec. */
 	ssize_t status, written;
 	unsigned nr_pages;
 	int err;
@@ -1988,8 +1983,6 @@ static ssize_t ntfs_file_buffered_write(
 	last_vcn = -1;
 	if (likely(nr_segs == 1))
 		buf = iov->iov_base;
-	else
-		iov_ofs = 0;	/* Offset in the current iovec. */
 	do {
 		VCN vcn;
 		pgoff_t idx, start_idx;
---
0.99.9
