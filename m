Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030238AbWI0Q35@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030238AbWI0Q35 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 12:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030239AbWI0Q34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 12:29:56 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:23692 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030238AbWI0Q3y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 12:29:54 -0400
Date: Wed, 27 Sep 2006 11:29:56 -0500
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: akpm@osdl.org
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] eCryptfs: Grab lock on lower_page in ecryptfs_sync_page
Message-ID: <20060927162956.GC3256@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The recent swap of grab_cache_page() with find_get_page() in
ecryptfs_sync_page() missed the fact that we need a lock on the lower
page. This patch replaces find_get_page() with find_lock_page() in
order to make sure that this lock is obtained.

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 fs/ecryptfs/mmap.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

ef0b82f22907486bd87f8c37508a9f7d1dcd5601
diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
index 8a4040d..924dd90 100644
--- a/fs/ecryptfs/mmap.c
+++ b/fs/ecryptfs/mmap.c
@@ -766,9 +766,9 @@ static void ecryptfs_sync_page(struct pa
 	lower_inode = ecryptfs_inode_to_lower(inode);
 	/* NOTE: Recently swapped with grab_cache_page(), since
 	 * sync_page() just makes sure that pending I/O gets done. */
-	lower_page = find_get_page(lower_inode->i_mapping, page->index);
+	lower_page = find_lock_page(lower_inode->i_mapping, page->index);
 	if (!lower_page) {
-		ecryptfs_printk(KERN_DEBUG, "find_get_page failed\n");
+		ecryptfs_printk(KERN_DEBUG, "find_lock_page failed\n");
 		return;
 	}
 	lower_page->mapping->a_ops->sync_page(lower_page);
-- 
1.3.3

