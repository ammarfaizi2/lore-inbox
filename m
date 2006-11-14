Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966272AbWKNTVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966272AbWKNTVK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 14:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966275AbWKNTVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 14:21:10 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:25047 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S966272AbWKNTVI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 14:21:08 -0500
Date: Tue, 14 Nov 2006 13:21:06 -0600
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] eCryptfs: dput() lower d_parent on rename
Message-ID: <20061114192106.GA4601@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On rename, for both the old and new lower dentry objects, eCryptfs is
missing a dput on the lower parent directory dentry. This patch will
prevent the BUG() at fs/dcache.c:613 from being hit after renaming a
file inside eCryptfs and then doing a umount on the lower filesystem.

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 fs/ecryptfs/inode.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

ad6bdd754bf12f926bf6b2e528d085177bce9def
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index fc0f624..dfcc684 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -631,6 +631,8 @@ ecryptfs_rename(struct inode *old_dir, s
 		ecryptfs_copy_attr_all(old_dir, lower_old_dir_dentry->d_inode);
 out_lock:
 	unlock_rename(lower_old_dir_dentry, lower_new_dir_dentry);
+	dput(lower_new_dentry->d_parent);
+	dput(lower_old_dentry->d_parent);
 	dput(lower_new_dentry);
 	dput(lower_old_dentry);
 	return rc;
-- 
1.3.3

