Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275682AbRJKBrV>; Wed, 10 Oct 2001 21:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275570AbRJKBrD>; Wed, 10 Oct 2001 21:47:03 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:25330 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S275265AbRJKBqx>; Wed, 10 Oct 2001 21:46:53 -0400
Date: Wed, 10 Oct 2001 18:44:45 -0700
From: Chris Wright <chris@wirex.com>
To: Remy.Card@linux.org, torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.11 unused code in ext2
Message-ID: <20011010184445.C19995@figure1.int.wirex.com>
Mail-Followup-To: Remy.Card@linux.org, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the ext2_permission function prototype in include/linux/ext2_fs.h is
never implemented.  no big deal, just a little misleading.  this appears
to be leftover from 2.2.

the ext2_notify_change function is implemented in fs/ext2/inode.c
but not used anywhere.  this appears to be leftover from 2.2 when
ext2_notify_change was part of super_operations.  now that the
corresponding functionality is provided by inode_operations->setattr,
ext2 lets vfs handle with generic inode_setattr function.  so this
function appears to just waste space.

the patch below removes both.  these are already removed from the -ac
tree.

thanks,
-chris

diff -X /home/chris/dontdiff -Naur linux-2.4.11/fs/ext2/inode.c linux-2.4.11-ext2/fs/ext2/inode.c
--- linux-2.4.11/fs/ext2/inode.c	Fri Oct  5 12:23:53 2001
+++ linux-2.4.11-ext2/fs/ext2/inode.c	Wed Oct 10 18:41:42 2001
@@ -1148,63 +1148,3 @@
 {
 	return ext2_update_inode (inode, 1);
 }
-
-int ext2_notify_change(struct dentry *dentry, struct iattr *iattr)
-{
-	struct inode *inode = dentry->d_inode;
-	int		retval;
-	unsigned int	flags;
-	
-	retval = -EPERM;
-	if (iattr->ia_valid & ATTR_ATTR_FLAG &&
-	    ((!(iattr->ia_attr_flags & ATTR_FLAG_APPEND) !=
-	      !(inode->u.ext2_i.i_flags & EXT2_APPEND_FL)) ||
-	     (!(iattr->ia_attr_flags & ATTR_FLAG_IMMUTABLE) !=
-	      !(inode->u.ext2_i.i_flags & EXT2_IMMUTABLE_FL)))) {
-		if (!capable(CAP_LINUX_IMMUTABLE))
-			goto out;
-	} else if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
-		goto out;
-
-	retval = inode_change_ok(inode, iattr);
-	if (retval != 0 || (((iattr->ia_valid & ATTR_UID && iattr->ia_uid != inode->i_uid) ||
-	    (iattr->ia_valid & ATTR_GID && iattr->ia_gid != inode->i_gid)) &&
-	    DQUOT_TRANSFER(inode, iattr)))
-		goto out;
-
-	inode_setattr(inode, iattr);
-	
-	flags = iattr->ia_attr_flags;
-	if (flags & ATTR_FLAG_SYNCRONOUS) {
-		inode->i_flags |= S_SYNC;
-		inode->u.ext2_i.i_flags |= EXT2_SYNC_FL;
-	} else {
-		inode->i_flags &= ~S_SYNC;
-		inode->u.ext2_i.i_flags &= ~EXT2_SYNC_FL;
-	}
-	if (flags & ATTR_FLAG_NOATIME) {
-		inode->i_flags |= S_NOATIME;
-		inode->u.ext2_i.i_flags |= EXT2_NOATIME_FL;
-	} else {
-		inode->i_flags &= ~S_NOATIME;
-		inode->u.ext2_i.i_flags &= ~EXT2_NOATIME_FL;
-	}
-	if (flags & ATTR_FLAG_APPEND) {
-		inode->i_flags |= S_APPEND;
-		inode->u.ext2_i.i_flags |= EXT2_APPEND_FL;
-	} else {
-		inode->i_flags &= ~S_APPEND;
-		inode->u.ext2_i.i_flags &= ~EXT2_APPEND_FL;
-	}
-	if (flags & ATTR_FLAG_IMMUTABLE) {
-		inode->i_flags |= S_IMMUTABLE;
-		inode->u.ext2_i.i_flags |= EXT2_IMMUTABLE_FL;
-	} else {
-		inode->i_flags &= ~S_IMMUTABLE;
-		inode->u.ext2_i.i_flags &= ~EXT2_IMMUTABLE_FL;
-	}
-	mark_inode_dirty(inode);
-out:
-	return retval;
-}
-
diff -X /home/chris/dontdiff -Naur linux-2.4.11/include/linux/ext2_fs.h linux-2.4.11-ext2/include/linux/ext2_fs.h
--- linux-2.4.11/include/linux/ext2_fs.h	Tue Oct  9 15:22:46 2001
+++ linux-2.4.11-ext2/include/linux/ext2_fs.h	Wed Oct 10 18:27:06 2001
@@ -545,9 +545,6 @@
 # define ATTRIB_NORET  __attribute__((noreturn))
 # define NORET_AND     noreturn,
 
-/* acl.c */
-extern int ext2_permission (struct inode *, int);
-
 /* balloc.c */
 extern int ext2_bg_has_super(struct super_block *sb, int group);
 extern unsigned long ext2_bg_num_gdb(struct super_block *sb, int group);
