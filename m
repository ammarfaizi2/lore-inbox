Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275506AbRIZTJc>; Wed, 26 Sep 2001 15:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275505AbRIZTJW>; Wed, 26 Sep 2001 15:09:22 -0400
Received: from grex.cyberspace.org ([216.93.104.34]:47623 "HELO
	grex.cyberspace.org") by vger.kernel.org with SMTP
	id <S275510AbRIZTJJ>; Wed, 26 Sep 2001 15:09:09 -0400
Date: Wed, 26 Sep 2001 15:09:52 -0400 (EDT)
From: KVK <kvk@cyberspace.org>
To: linux-kernel@vger.kernel.org
cc: torvalds@transmeta.com, sct@redhat.com
Subject: [PATCH] Remove ext2_notify_change()
Message-ID: <Pine.SUN.3.96.1010926145958.8988A-100000@grex.cyberspace.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ext2_notify_change() is no longer used by anyone. I think it can be 
safely removed. Patch against 2.4.10 follows.

Thanks,
-kvk
PS. I think there is lot of other dead code in ext2. I happened to 
notice this while going through vmtruncate().

--- vanilla/linux/fs/ext2/inode.c	Mon Sep 24 09:04:50 2001
+++ linux/fs/ext2/inode.c	Wed Sep 26 11:32:25 2001
@@ -1164,60 +1164,3 @@
 	return ext2_update_inode (inode, 1);
 }
 
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
-	if (retval != 0)
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

