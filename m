Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266886AbRGKXDg>; Wed, 11 Jul 2001 19:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266882AbRGKXD1>; Wed, 11 Jul 2001 19:03:27 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:64247 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S266880AbRGKXDW>; Wed, 11 Jul 2001 19:03:22 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200107112252.f6BMqJYF010096@webber.adilger.int>
Subject: Re: [PATCH] comment out obsolete ext2 code
In-Reply-To: "from (env: adilger) at Jul 11, 2001 04:48:46 pm"
To: torvalds@transmeta.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Wed, 11 Jul 2001 16:52:19 -0600 (MDT)
CC: Linux kernel development list <linux-kernel@vger.kernel.org>,
        Ext2 development mailing list 
	<ext2-devel@lists.sourceforge.net>
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I previously wrote:
> This patch comments out code in ext2 which is obsolete, or was never used
> in the first place (i.e. future vision stuff, etc).  In particular, the
> inode->i_attr_flags field is not used anywhere else in the kernel, and it
> is only set, but not referenced in the ext2 code.  It could probably be
> deleted entirely (saving 4 bytes in struct inode).

> Similarly, the ext2_notify_change() function is not currently in use (but
> it may be needed at some time in the future).  However, per previous
> discussions with Stephen on ext2-devel, the 2.4 code is buggy (2.2 code
> was fixed), so even though it is currently unused I have fixed it.  The
> brokenness in question also relates to i_attr_flags, so it could also
> be deleted entirely if that is the goal.
> 
> There are a couple of other obsolete bits not removed by this patch,
> namely i_osync, and i_new_inode in ext2_inode_info.  Another day...

Now for the patch...

Cheers, Andreas
========================================================================
diff -ru linux-2.4.6.orig/fs/ext2/inode.c linux-2.4.6-aed/fs/ext2/inode.c
--- linux-2.4.6.orig/fs/ext2/inode.c	Thu Jun 28 14:28:24 2001
+++ linux-2.4.6-aed/fs/ext2/inode.c	Thu Jun 28 14:27:24 2001
@@ -1003,21 +998,21 @@
 		init_special_inode(inode, inode->i_mode,
 				   le32_to_cpu(raw_inode->i_block[0]));
 	brelse (bh);
-	inode->i_attr_flags = 0;
+	/* inode->i_attr_flags = 0;				unused */
 	if (inode->u.ext2_i.i_flags & EXT2_SYNC_FL) {
-		inode->i_attr_flags |= ATTR_FLAG_SYNCRONOUS;
+		/* inode->i_attr_flags |= ATTR_FLAG_SYNCRONOUS;	unused */
 		inode->i_flags |= S_SYNC;
 	}
 	if (inode->u.ext2_i.i_flags & EXT2_APPEND_FL) {
-		inode->i_attr_flags |= ATTR_FLAG_APPEND;
+		/* inode->i_attr_flags |= ATTR_FLAG_APPEND;	unused */
 		inode->i_flags |= S_APPEND;
 	}
 	if (inode->u.ext2_i.i_flags & EXT2_IMMUTABLE_FL) {
-		inode->i_attr_flags |= ATTR_FLAG_IMMUTABLE;
+		/* inode->i_attr_flags |= ATTR_FLAG_IMMUTABLE;	unused */
 		inode->i_flags |= S_IMMUTABLE;
 	}
 	if (inode->u.ext2_i.i_flags & EXT2_NOATIME_FL) {
-		inode->i_attr_flags |= ATTR_FLAG_NOATIME;
+		/* inode->i_attr_flags |= ATTR_FLAG_NOATIME;	unused */
 		inode->i_flags |= S_NOATIME;
 	}
 	return;
@@ -1165,60 +1158,65 @@
 	return ext2_update_inode (inode, 1);
 }
 
+#if 0	/* Currently unused */
 int ext2_notify_change(struct dentry *dentry, struct iattr *iattr)
 {
 	struct inode *inode = dentry->d_inode;
-	int		retval;
-	unsigned int	flags;
-	
+	int retval;
+
+#if 0	/* Can currently only set attribute flags via ext2_ioctl */
 	retval = -EPERM;
-	if (iattr->ia_valid & ATTR_ATTR_FLAG &&
-	    ((!(iattr->ia_attr_flags & ATTR_FLAG_APPEND) !=
-	      !(inode->u.ext2_i.i_flags & EXT2_APPEND_FL)) ||
-	     (!(iattr->ia_attr_flags & ATTR_FLAG_IMMUTABLE) !=
-	      !(inode->u.ext2_i.i_flags & EXT2_IMMUTABLE_FL)))) {
-		if (!capable(CAP_LINUX_IMMUTABLE))
+	if (iattr->ia_valid & ATTR_ATTR_FLAG) {
+		if ((!(iattr->ia_attr_flags & ATTR_FLAG_APPEND) !=
+		     !(inode->u.ext2_i.i_flags & EXT2_APPEND_FL)) ||
+		    (!(iattr->ia_attr_flags & ATTR_FLAG_IMMUTABLE) !=
+		     !(inode->u.ext2_i.i_flags & EXT2_IMMUTABLE_FL))))
+		     if (!capable(CAP_LINUX_IMMUTABLE))
+				goto out;
+		if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
 			goto out;
-	} else if ((current->fsuid != inode->i_uid) && !capable(CAP_FOWNER))
-		goto out;
-
+	}
+#endif
 	retval = inode_change_ok(inode, iattr);
 	if (retval != 0)
 		goto out;
 
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
+#if 0	/* Can currently only set attribute flags via ext2_ioctl */
+	if (iattr->ia_valid & ATTR_ATTR_FLAG) {
+		unsigned int flags = iattr->ia_attr_flags;
+		if (flags & ATTR_FLAG_SYNCRONOUS) {
+			inode->i_flags |= S_SYNC;
+			inode->u.ext2_i.i_flags |= EXT2_SYNC_FL;
+		} else {
+			inode->i_flags &= ~S_SYNC;
+			inode->u.ext2_i.i_flags &= ~EXT2_SYNC_FL;
+		}
+		if (flags & ATTR_FLAG_NOATIME) {
+			inode->i_flags |= S_NOATIME;
+			inode->u.ext2_i.i_flags |= EXT2_NOATIME_FL;
+		} else {
+			inode->i_flags &= ~S_NOATIME;
+			inode->u.ext2_i.i_flags &= ~EXT2_NOATIME_FL;
+		}
+		if (flags & ATTR_FLAG_APPEND) {
+			inode->i_flags |= S_APPEND;
+			inode->u.ext2_i.i_flags |= EXT2_APPEND_FL;
+		} else {
+			inode->i_flags &= ~S_APPEND;
+			inode->u.ext2_i.i_flags &= ~EXT2_APPEND_FL;
+		}
+		if (flags & ATTR_FLAG_IMMUTABLE) {
+			inode->i_flags |= S_IMMUTABLE;
+			inode->u.ext2_i.i_flags |= EXT2_IMMUTABLE_FL;
+		} else {
+			inode->i_flags &= ~S_IMMUTABLE;
+			inode->u.ext2_i.i_flags &= ~EXT2_IMMUTABLE_FL;
+		}
 	}
-	mark_inode_dirty(inode);
+#endif
+	inode_setattr(inode, iattr); /* This calls mark_inode_dirty for us */
 out:
 	return retval;
 }
+#endif
 
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
