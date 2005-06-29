Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262706AbVF2Ww4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262706AbVF2Ww4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 18:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262712AbVF2Ww4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 18:52:56 -0400
Received: from locomotive.csh.rit.edu ([129.21.60.149]:46853 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S262706AbVF2Wwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 18:52:33 -0400
Date: Wed, 29 Jun 2005 18:52:28 -0400
From: Jeff Mahoney <jeffm@suse.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] reiserfs: Check if attrs are enabled for attr ioctls
Message-ID: <20050629225228.GA7241@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.5-7.151-smp (i686)
X-GPG-Fingerprint: A16F A946 6C24 81CC 99BB  85AF 2CF5 B197 2B93 0FB2
X-GPG-Key: http://www.csh.rit.edu/~jeffm/jeffm.gpg
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 ReiserFS currently will allow the user to set/get attrs for files regardless
 if they are enabled. The patch checks to see if they are enabled, and returns
 -NOTTY if they are not.

 ext[23] doesn't need this check because attrs are always enabled.

 Please apply.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
 
diff -ruNpX dontdiff linux-2.6.12-rc6/fs/reiserfs/ioctl.c linux-2.6.12-rc6.devel/fs/reiserfs/ioctl.c
--- linux-2.6.12-rc6/fs/reiserfs/ioctl.c	2005-06-13 14:34:32.000000000 -0400
+++ linux-2.6.12-rc6.devel/fs/reiserfs/ioctl.c	2005-06-22 17:30:40.000000000 -0400
@@ -34,10 +34,16 @@ int reiserfs_ioctl (struct inode * inode
 	/* following two cases are taken from fs/ext2/ioctl.c by Remy
 	   Card (card@masi.ibp.fr) */
 	case REISERFS_IOC_GETFLAGS:
+		if (!reiserfs_attrs (inode->i_sb))
+			return -ENOTTY;
+
 		flags = REISERFS_I(inode) -> i_attrs;
 		i_attrs_to_sd_attrs( inode, ( __u16 * ) &flags );
 		return put_user(flags, (int __user *) arg);
 	case REISERFS_IOC_SETFLAGS: {
+		if (!reiserfs_attrs (inode->i_sb))
+			return -ENOTTY;
+
 		if (IS_RDONLY(inode))
 			return -EROFS;
 
-- 
Jeff Mahoney
SuSE Labs
