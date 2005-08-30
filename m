Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbVH3Qr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbVH3Qr3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 12:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbVH3Qr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 12:47:29 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:51094 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932219AbVH3Qr2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 12:47:28 -0400
Subject: Re: OOPS in 2.6.13: jfsCommit
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: "SR, ESC" <simon@nuit.ca>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050830115950.GA8764@pylon>
References: <20050830115950.GA8764@pylon>
Content-Type: text/plain
Date: Tue, 30 Aug 2005 11:47:11 -0500
Message-Id: <1125420432.9223.3.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-30 at 07:59 -0400, SR, ESC wrote:
> hi,
> 
> i encountered an OOPS during boot here. dropped the machine into xmon
> even. during boot, i got what's in the attached file
> (kernel_bug_2.6.13_jfsCommit).

I think the problem may be a recent change to jfs_delete_inode.  Does
this patch fix the problem?
---------------------------------------------------------------------
JFS: jfs_delete_inode should always call clear_inode.

Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>

diff --git a/fs/jfs/inode.c b/fs/jfs/inode.c
--- a/fs/jfs/inode.c
+++ b/fs/jfs/inode.c
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
David Kleikamp
IBM Linux Technology Center

