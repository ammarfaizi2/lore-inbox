Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932415AbWBAJD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbWBAJD5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 04:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbWBAJDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 04:03:55 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:25419 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S932411AbWBAJDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 04:03:37 -0500
Message-Id: <20060201090335.859839000@localhost.localdomain>
References: <20060201090224.536581000@localhost.localdomain>
Date: Wed, 01 Feb 2006 18:03:07 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: Anton Altaparmakov <aia21@cantab.net>,
       linux-ntfs-dev@lists.sourceforge.net,
       Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 43/44] ntfs: remove generic_ffs()
Content-Disposition: inline; filename=ntfs-fix.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now the only user who are using generic_ffs() is ntfs filesystem.
This patch isolates generic_ffs() as ntfs_ffs() for ntfs.

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

 fs/ntfs/logfile.c |    4 ++--
 fs/ntfs/mft.c     |    2 +-
 fs/ntfs/ntfs.h    |   29 +++++++++++++++++++++++++++++
 3 files changed, 32 insertions(+), 3 deletions(-)

Index: 2.6-git/fs/ntfs/logfile.c
===================================================================
--- 2.6-git.orig/fs/ntfs/logfile.c
+++ 2.6-git/fs/ntfs/logfile.c
@@ -515,10 +515,10 @@ BOOL ntfs_check_logfile(struct inode *lo
 		log_page_size = PAGE_CACHE_SIZE;
 	log_page_mask = log_page_size - 1;
 	/*
-	 * Use generic_ffs() instead of ffs() to enable the compiler to
+	 * Use ntfs_ffs() instead of ffs() to enable the compiler to
 	 * optimize log_page_size and log_page_bits into constants.
 	 */
-	log_page_bits = generic_ffs(log_page_size) - 1;
+	log_page_bits = ntfs_ffs(log_page_size) - 1;
 	size &= ~(s64)(log_page_size - 1);
 	/*
 	 * Ensure the log file is big enough to store at least the two restart
Index: 2.6-git/fs/ntfs/mft.c
===================================================================
--- 2.6-git.orig/fs/ntfs/mft.c
+++ 2.6-git/fs/ntfs/mft.c
@@ -2672,7 +2672,7 @@ mft_rec_already_initialized:
 			ni->name_len = 4;
 
 			ni->itype.index.block_size = 4096;
-			ni->itype.index.block_size_bits = generic_ffs(4096) - 1;
+			ni->itype.index.block_size_bits = ntfs_ffs(4096) - 1;
 			ni->itype.index.collation_rule = COLLATION_FILE_NAME;
 			if (vol->cluster_size <= ni->itype.index.block_size) {
 				ni->itype.index.vcn_size = vol->cluster_size;
Index: 2.6-git/fs/ntfs/ntfs.h
===================================================================
--- 2.6-git.orig/fs/ntfs/ntfs.h
+++ 2.6-git/fs/ntfs/ntfs.h
@@ -132,4 +132,33 @@ extern int ntfs_ucstonls(const ntfs_volu
 /* From fs/ntfs/upcase.c */
 extern ntfschar *generate_default_upcase(void);
 
+static inline int ntfs_ffs(int x)
+{
+	int r = 1;
+
+	if (!x)
+		return 0;
+	if (!(x & 0xffff)) {
+		x >>= 16;
+		r += 16;
+	}
+	if (!(x & 0xff)) {
+		x >>= 8;
+		r += 8;
+	}
+	if (!(x & 0xf)) {
+		x >>= 4;
+		r += 4;
+	}
+	if (!(x & 3)) {
+		x >>= 2;
+		r += 2;
+	}
+	if (!(x & 1)) {
+		x >>= 1;
+		r += 1;
+	}
+	return r;
+}
+
 #endif /* _LINUX_NTFS_H */

--
