Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030183AbVIIJ0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030183AbVIIJ0z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 05:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030181AbVIIJ0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 05:26:55 -0400
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:29073 "EHLO
	ppsw-9.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1030183AbVIIJ0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 05:26:53 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Fri, 9 Sep 2005 10:26:45 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 13/25] NTFS: Fix several bugs in fs/ntfs/attrib.c.
In-Reply-To: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0509091026280.26845@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0509090950100.11051@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 13/25] NTFS: Fix several bugs in fs/ntfs/attrib.c.

- Fix a bug in ntfs_map_runlist_nolock() where we forgot to protect
  access to the allocated size in the ntfs inode with the size lock.
- Fix ntfs_attr_vcn_to_lcn_nolock() and ntfs_attr_find_vcn_nolock() to
  return LCN_ENOENT when there is no runlist and the allocated size is
  zero.
- Fix load_attribute_list() to handle the case of a NULL runlist.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

---

 fs/ntfs/ChangeLog |    6 ++++++
 fs/ntfs/attrib.c  |   32 +++++++++++++++++++++++++++++++-
 2 files changed, 37 insertions(+), 1 deletions(-)

2983d1bd1a596e88cdddc0c2d45b9e97728f3f41
diff --git a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog
+++ b/fs/ntfs/ChangeLog
@@ -60,6 +60,12 @@ ToDo/Notes:
 	  the index context.  Thanks to Yura Pakhuchiy for finding this bug.
 	- Remove bogus setting of PageError in ntfs_read_compressed_block().
 	- Add fs/ntfs/attrib.[hc]::ntfs_resident_attr_value_resize().
+	- Fix a bug in ntfs_map_runlist_nolock() where we forgot to protect
+	  access to the allocated size in the ntfs inode with the size lock.
+	- Fix ntfs_attr_vcn_to_lcn_nolock() and ntfs_attr_find_vcn_nolock() to
+	  return LCN_ENOENT when there is no runlist and the allocated size is
+	  zero.
+	- Fix load_attribute_list() to handle the case of a NULL runlist.
 
 2.1.23 - Implement extension of resident files and make writing safe as well as
 	 many bug fixes, cleanups, and enhancements...
diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -43,6 +43,9 @@
  * which is not an error as such.  This is -ENOENT.  It means that @vcn is out
  * of bounds of the runlist.
  *
+ * Note the runlist can be NULL after this function returns if @vcn is zero and
+ * the attribute has zero allocated size, i.e. there simply is no runlist.
+ *
  * Locking: - The runlist must be locked for writing.
  *	    - This function modifies the runlist.
  */
@@ -54,6 +57,7 @@ int ntfs_map_runlist_nolock(ntfs_inode *
 	ATTR_RECORD *a;
 	ntfs_attr_search_ctx *ctx;
 	runlist_element *rl;
+	unsigned long flags;
 	int err = 0;
 
 	ntfs_debug("Mapping runlist part containing vcn 0x%llx.",
@@ -85,8 +89,11 @@ int ntfs_map_runlist_nolock(ntfs_inode *
 	 * ntfs_mapping_pairs_decompress() fails.
 	 */
 	end_vcn = sle64_to_cpu(a->data.non_resident.highest_vcn) + 1;
-	if (unlikely(!a->data.non_resident.lowest_vcn && end_vcn <= 1))
+	if (unlikely(!a->data.non_resident.lowest_vcn && end_vcn <= 1)) {
+		read_lock_irqsave(&ni->size_lock, flags);
 		end_vcn = ni->allocated_size >> ni->vol->cluster_size_bits;
+		read_unlock_irqrestore(&ni->size_lock, flags);
+	}
 	if (unlikely(vcn >= end_vcn)) {
 		err = -ENOENT;
 		goto err_out;
@@ -165,6 +172,7 @@ LCN ntfs_attr_vcn_to_lcn_nolock(ntfs_ino
 		const BOOL write_locked)
 {
 	LCN lcn;
+	unsigned long flags;
 	BOOL is_retry = FALSE;
 
 	ntfs_debug("Entering for i_ino 0x%lx, vcn 0x%llx, %s_locked.",
@@ -173,6 +181,14 @@ LCN ntfs_attr_vcn_to_lcn_nolock(ntfs_ino
 	BUG_ON(!ni);
 	BUG_ON(!NInoNonResident(ni));
 	BUG_ON(vcn < 0);
+	if (!ni->runlist.rl) {
+		read_lock_irqsave(&ni->size_lock, flags);
+		if (!ni->allocated_size) {
+			read_unlock_irqrestore(&ni->size_lock, flags);
+			return LCN_ENOENT;
+		}
+		read_unlock_irqrestore(&ni->size_lock, flags);
+	}
 retry_remap:
 	/* Convert vcn to lcn.  If that fails map the runlist and retry once. */
 	lcn = ntfs_rl_vcn_to_lcn(ni->runlist.rl, vcn);
@@ -255,6 +271,7 @@ retry_remap:
 runlist_element *ntfs_attr_find_vcn_nolock(ntfs_inode *ni, const VCN vcn,
 		const BOOL write_locked)
 {
+	unsigned long flags;
 	runlist_element *rl;
 	int err = 0;
 	BOOL is_retry = FALSE;
@@ -265,6 +282,14 @@ runlist_element *ntfs_attr_find_vcn_nolo
 	BUG_ON(!ni);
 	BUG_ON(!NInoNonResident(ni));
 	BUG_ON(vcn < 0);
+	if (!ni->runlist.rl) {
+		read_lock_irqsave(&ni->size_lock, flags);
+		if (!ni->allocated_size) {
+			read_unlock_irqrestore(&ni->size_lock, flags);
+			return ERR_PTR(-ENOENT);
+		}
+		read_unlock_irqrestore(&ni->size_lock, flags);
+	}
 retry_remap:
 	rl = ni->runlist.rl;
 	if (likely(rl && vcn >= rl[0].vcn)) {
@@ -528,6 +553,11 @@ int load_attribute_list(ntfs_volume *vol
 	block_size_bits = sb->s_blocksize_bits;
 	down_read(&runlist->lock);
 	rl = runlist->rl;
+	if (!rl) {
+		ntfs_error(sb, "Cannot read attribute list since runlist is "
+				"missing.");
+		goto err_out;	
+	}
 	/* Read all clusters specified by the runlist one run at a time. */
 	while (rl->length) {
 		lcn = ntfs_rl_vcn_to_lcn(rl, rl->vcn);
