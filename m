Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277560AbRJKA35>; Wed, 10 Oct 2001 20:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277705AbRJKA3s>; Wed, 10 Oct 2001 20:29:48 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:59631 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S277560AbRJKA3g>; Wed, 10 Oct 2001 20:29:36 -0400
Date: Wed, 10 Oct 2001 17:27:27 -0700
From: Chris Wright <chris@wirex.com>
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk, torvalds@transmeta.com
Subject: [PATCH] minor code duplication in fs/proc/base.c
Message-ID: <20011010172727.H21401@figure1.int.wirex.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
	torvalds@transmeta.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While looking through the proc code I noticed the standard_permission()
function is essentially the same as vfs_permission().  It appears there
is no need to maintain this code separately.  For example, the recent
tweaks in vfs_permission() didn't make it into standard_permission().
If it helps, here is a patch.  It is against 2.4.11, but it applies
cleanly 2.4.10-ac11.

thanks,
-chris


--- linux-2.4.11/fs/proc/base.c	Fri Jul 20 12:39:56 2001
+++ linux-2.4.11-proc/fs/proc/base.c	Wed Oct 10 17:10:25 2001
@@ -184,29 +184,6 @@
 
 /* permission checks */
 
-static int standard_permission(struct inode *inode, int mask)
-{
-	int mode = inode->i_mode;
-
-	if ((mask & S_IWOTH) && IS_RDONLY(inode) &&
-	    (S_ISREG(mode) || S_ISDIR(mode) || S_ISLNK(mode)))
-		return -EROFS; /* Nobody gets write access to a read-only fs */
-	else if ((mask & S_IWOTH) && IS_IMMUTABLE(inode))
-		return -EACCES; /* Nobody gets write access to an immutable file */
-	else if (current->fsuid == inode->i_uid)
-		mode >>= 6;
-	else if (in_group_p(inode->i_gid))
-		mode >>= 3;
-	if (((mode & mask & S_IRWXO) == mask) || capable(CAP_DAC_OVERRIDE))
-		return 0;
-	/* read and search access */
-	if ((mask == S_IROTH) ||
-	    (S_ISDIR(mode)  && !(mask & ~(S_IROTH | S_IXOTH))))
-		if (capable(CAP_DAC_READ_SEARCH))
-			return 0;
-	return -EACCES;
-}
-
 static int proc_check_root(struct inode *inode)
 {
 	struct dentry *de, *base, *root;
@@ -249,7 +226,7 @@
 
 static int proc_permission(struct inode *inode, int mask)
 {
-	if (standard_permission(inode, mask) != 0)
+	if (vfs_permission(inode, mask) != 0)
 		return -EACCES;
 	return proc_check_root(inode);
 }
