Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030287AbVIOBEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030287AbVIOBEq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 21:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030311AbVIOBEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 21:04:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13505 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030287AbVIOBEb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 21:04:31 -0400
Message-Id: <20050915010409.018350000@localhost.localdomain>
References: <20050915010343.577985000@localhost.localdomain>
Date: Wed, 14 Sep 2005 18:03:51 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Dave Kleikamp <shaggy@austin.ibm.com>, Chris Wright <chrisw@osdl.org>
Subject: [PATCH 08/11] jfs: jfs_delete_inode must call clear_inode
Content-Disposition: inline; filename=jfs_delete_inode-must-call-clear_inode.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

> From Chuck Ebbert:
I'm submitting this patch for -stable:

  - it reportedly fixes an oops
  - it's already in 2.6.13-git

JFS: jfs_delete_inode should always call clear_inode.

Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>
Signed-off-by: Chris Wright <chrisw@osdl.org>
---
 fs/jfs/inode.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

Index: linux-2.6.13.y/fs/jfs/inode.c
===================================================================
--- linux-2.6.13.y.orig/fs/jfs/inode.c
+++ linux-2.6.13.y/fs/jfs/inode.c
@@ -128,21 +128,21 @@ void jfs_delete_inode(struct inode *inod
 {
 	jfs_info("In jfs_delete_inode, inode = 0x%p", inode);
 
-	if (is_bad_inode(inode) ||
-	    (JFS_IP(inode)->fileset != cpu_to_le32(FILESYSTEM_I)))
-			return;
+	if (!is_bad_inode(inode) &&
+	    (JFS_IP(inode)->fileset == cpu_to_le32(FILESYSTEM_I))) {
 
-	if (test_cflag(COMMIT_Freewmap, inode))
-		jfs_free_zero_link(inode);
+		if (test_cflag(COMMIT_Freewmap, inode))
+			jfs_free_zero_link(inode);
 
-	diFree(inode);
+		diFree(inode);
 
-	/*
-	 * Free the inode from the quota allocation.
-	 */
-	DQUOT_INIT(inode);
-	DQUOT_FREE_INODE(inode);
-	DQUOT_DROP(inode);
+		/*
+		 * Free the inode from the quota allocation.
+		 */
+		DQUOT_INIT(inode);
+		DQUOT_FREE_INODE(inode);
+		DQUOT_DROP(inode);
+	}
 
 	clear_inode(inode);
 }

--
