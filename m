Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbVIBTGH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbVIBTGH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 15:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750889AbVIBTGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 15:06:07 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:6583 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750733AbVIBTGE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 15:06:04 -0400
Subject: [PATCH] document mark_inode_dirty & mark_inode_dirty_sync in fs.h
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       fsdevel <linux-fsdevel@vger.kernel.org>
In-Reply-To: <20050902164649.GW7054@schatzie.adilger.int>
References: <17AB476A04B7C842887E0EB1F268111E026F3E@xpserver.intra.lexbox.org>
	 <1125664959.9401.15.camel@kleikamp.austin.ibm.com>
	 <20050902164649.GW7054@schatzie.adilger.int>
Content-Type: text/plain
Date: Fri, 02 Sep 2005 14:05:48 -0500
Message-Id: <1125687948.9402.53.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-02 at 10:46 -0600, Andreas Dilger wrote:
> On Sep 02, 2005  07:42 -0500, Dave Kleikamp wrote:
> > They put the inode on the superblock's dirty list and make the inode as
> > dirty in the i_state field.  This makes sure that the inode will
> > eventually be written to disk.
> > 
> > mark_inode_dirty_sync only sets the I_DIRTY_SYNC flag, which does not
> > imply that any file data was changed.  It is called when a minor change
> > is made to an inode, such as a timestamp is changed.  Some sync
> > operations will only write the inode if data was written, so can avoid
> > writing the an inode that is only dirtied by I_DIRTY_SYNC.
> > 
> > mark_inode_dirty sets I_DIRTY which is I_DIRTY_SYNC | I_DIRTY_DATASYNC |
> > I_DIRTY_PAGES.  This indicates that the in-memory inode has changes to
> > the data that have not yet been written to disk.
> 
> Dave, could you consider submitting a patch to add the above as comments
> to fs.h for future reference?
> 
> Cheers, Andreas

How about this?
=================
Document mark_inode_dirty and mark_inode_dirty_sync in fs.h

Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>

diff --git a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1048,7 +1048,7 @@ struct super_operations {
 /* Inode state bits.  Protected by inode_lock. */
 #define I_DIRTY_SYNC		1 /* Not dirty enough for O_DATASYNC */
 #define I_DIRTY_DATASYNC	2 /* Data-related inode changes pending */
-#define I_DIRTY_PAGES		4 /* Data-related inode changes pending */
+#define I_DIRTY_PAGES		4 /* Data changes pending */
 #define __I_LOCK		3
 #define I_LOCK			(1 << __I_LOCK)
 #define I_FREEING		16
@@ -1059,11 +1059,19 @@ struct super_operations {
 #define I_DIRTY (I_DIRTY_SYNC | I_DIRTY_DATASYNC | I_DIRTY_PAGES)
 
 extern void __mark_inode_dirty(struct inode *, int);
+/*
+ * mark_inode_dirty indicates pending changes to the inode's data.
+ * Puts inode on superblock's dirty list.
+ */
 static inline void mark_inode_dirty(struct inode *inode)
 {
 	__mark_inode_dirty(inode, I_DIRTY);
 }
 
+/*
+ * mark_inode_dirty_sync indicates non-data related changes to the inode,
+ * such as a change to a timestamp.  Puts inode on superblock's dirty list.
+ */
 static inline void mark_inode_dirty_sync(struct inode *inode)
 {
 	__mark_inode_dirty(inode, I_DIRTY_SYNC);

-- 
David Kleikamp
IBM Linux Technology Center

