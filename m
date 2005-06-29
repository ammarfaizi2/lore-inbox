Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262470AbVF2S4b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262470AbVF2S4b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 14:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262432AbVF2SwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 14:52:08 -0400
Received: from rgminet01.oracle.com ([148.87.122.30]:51611 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S262419AbVF2SuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 14:50:13 -0400
Date: Wed, 29 Jun 2005 11:49:37 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org
Subject: [RFC] [PATCH 1/2] move truncate_inode_pages() into ->delete_inode()
Message-ID: <20050629184937.GJ8215@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Oracle Corporation
User-Agent: Mutt/1.5.9i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allow file systems supporting ->delete_inode() to call
truncate_inode_pages() on their own. OCFS2 wants this so it can query
the cluster before making a final decision on whether to wipe an inode
from disk or not. In some corner cases an inode marked on the local
node via voting may not actually get orphaned. A good example is node
death before the transaction moving the inode to the orphan dir
commits to the journal. Without this patch, the truncate_inode_pages()
call in generic_delete_inode() would discard valid data for such
inodes.

During earlier discussion in the 2.6.13 merge plan thread, Christoph
Hellwig indicated that other file systems might also find this useful.

IMHO, the best solution would be to just allow ->drop_inode() to do
the cluster query but it seems that would require a substantial
reworking of that section of the code. Assuming it is safe to call
write_inode_now() in ocfs2_delete_inode() for those inodes which won't
actually get wiped, this solution should get us by for now.

Trivial testing of this patch (and a related OCFS2 update) has shown
this to avoid the corruption I'm seeing.

Signed-off-by: Mark Fasheh <mark.fasheh@oracle.com>

--- linux-2.6.12.orig/fs/inode.c	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12/fs/inode.c	2005-06-28 16:18:52.559820000 -0700
@@ -992,19 +992,21 @@
 	inodes_stat.nr_inodes--;
 	spin_unlock(&inode_lock);
 
-	if (inode->i_data.nrpages)
-		truncate_inode_pages(&inode->i_data, 0);
-
 	security_inode_delete(inode);
 
 	if (op->delete_inode) {
 		void (*delete)(struct inode *) = op->delete_inode;
 		if (!is_bad_inode(inode))
 			DQUOT_INIT(inode);
-		/* s_op->delete_inode internally recalls clear_inode() */
+		/* Filesystems implementing their own
+		 * s_op->delete_inode are required to call
+		 * truncate_inode_pages and clear_inode()
+		 * internally */
 		delete(inode);
-	} else
+	} else {
+		truncate_inode_pages(&inode->i_data, 0);
 		clear_inode(inode);
+	}
 	spin_lock(&inode_lock);
 	hlist_del_init(&inode->i_hash);
 	spin_unlock(&inode_lock);
