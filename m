Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272796AbRIGRjq>; Fri, 7 Sep 2001 13:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272792AbRIGRjg>; Fri, 7 Sep 2001 13:39:36 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:62987 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S272793AbRIGRjV>; Fri, 7 Sep 2001 13:39:21 -0400
Date: Fri, 7 Sep 2001 19:39:35 +0200
From: Jan Kara <jack@ucw.cz>
To: viro@math.psu.edu
Cc: vs@namesys.com, linux-kernel@vger.kernel.org
Subject: Freeing inode
Message-ID: <20010907193935.A5166@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hello,

  Vladimir pointed me to another bug in ext2 quota allocation. The problem is
that when inode is being created but creation fails (either from user being
over quota or from some other reason) then quota is decremented incorrectly
(previously the usual case when user is over quota was handled by DQUOT_DROP()
but this works no more because of DQUOT_INIT() in iput() and ext2_free_inode()).
  I made a patch which marks inode as bad and then quota is not initialized on
bad inodes (which makes sence anyway). The patch which is attached is just preliminary
and nontested (just now I'm realizing that inode being marked as bad might be
dirty which is not probably the best combination). I'd just like to know whether
this approach is ok with you or whether you have some better ideas.

									Honza


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="freeinode.diff"

--- fs/inode.c.orig	Fri Sep  7 19:01:50 2001
+++ fs/inode.c	Fri Sep  7 19:14:55 2001
@@ -1049,7 +1049,8 @@
 
 			if (op && op->delete_inode) {
 				void (*delete)(struct inode *) = op->delete_inode;
-				DQUOT_INIT(inode);
+				if (!is_bad_inode(inode))
+					DQUOT_INIT(inode);
 				/* s_op->delete_inode internally recalls clear_inode() */
 				delete(inode);
 			} else
--- fs/ext2/ialloc.c.orig	Fri Sep  7 18:52:51 2001
+++ fs/ext2/ialloc.c	Fri Sep  7 19:14:43 2001
@@ -194,9 +194,11 @@
 	 * Note: we must free any quota before locking the superblock,
 	 * as writing the quota to disk may need the lock as well.
 	 */
-	DQUOT_INIT(inode);
-	DQUOT_FREE_INODE(sb, inode);
-	DQUOT_DROP(inode);
+	if (!is_bad_inode(inode)) {
+		/* Quota is already initialized in iput() */
+	    	DQUOT_FREE_INODE(sb, inode);
+		DQUOT_DROP(inode);
+	}
 
 	lock_super (sb);
 	es = sb->u.ext2_sb.s_es;
@@ -453,8 +455,9 @@
 
 	unlock_super (sb);
 	if(DQUOT_ALLOC_INODE(sb, inode)) {
-		sb->dq_op->drop(inode);
+		DQUOT_DROP(inode);
 		inode->i_nlink = 0;
+		make_bad_inode(inode);
 		iput(inode);
 		return ERR_PTR(-EDQUOT);
 	}
@@ -463,6 +466,7 @@
 
 fail:
 	unlock_super(sb);
+	make_bad_inode(inode);
 	iput(inode);
 	return ERR_PTR(err);
 }

--qDbXVdCdHGoSgWSk--
