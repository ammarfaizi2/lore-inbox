Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751690AbWHXUCp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690AbWHXUCp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 16:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751691AbWHXUCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 16:02:45 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:415 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751689AbWHXUCp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 16:02:45 -0400
Date: Thu, 24 Aug 2006 15:02:45 -0500
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, mhalcrow@us.ibm.com
Subject: [PATCH] eCryptfs: mntput() lower mount on umount_begin()
Message-ID: <20060824200245.GB3117@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On unmount, eCryptfs needs to decrement the mount count of the lower
mount, or else you cannot unmount the lower filesystem.

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 fs/ecryptfs/super.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

bcc1939b87a3df14a9b975bdfde47dd5b230a6e5
diff --git a/fs/ecryptfs/super.c b/fs/ecryptfs/super.c
index 120f060..f4f06ea 100644
--- a/fs/ecryptfs/super.c
+++ b/fs/ecryptfs/super.c
@@ -144,10 +144,7 @@ static void ecryptfs_clear_inode(struct 
 /**
  * ecryptfs_umount_begin
  *
- * Called in do_umount() if the MNT_FORCE flag was used and this
- * function is defined.  See comment in linux/fs/super.c:do_umount().
- * Used only in nfs, to kill any pending RPC tasks, so that subsequent
- * code can actually succeed and won't leave tasks that need handling.
+ * Called in do_umount().
  */
 static void ecryptfs_umount_begin(struct vfsmount *vfsmnt, int flags)
 {
@@ -155,6 +152,7 @@ static void ecryptfs_umount_begin(struct
 		ecryptfs_dentry_to_lower_mnt(vfsmnt->mnt_sb->s_root);
 	struct super_block *lower_sb;
 
+	mntput(lower_mnt);
 	lower_sb = lower_mnt->mnt_sb;
 	if (lower_sb->s_op->umount_begin)
 		lower_sb->s_op->umount_begin(lower_mnt, flags);
-- 
1.3.3

