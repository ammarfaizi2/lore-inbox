Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750852AbWFQTNb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbWFQTNb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 15:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750860AbWFQTNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 15:13:31 -0400
Received: from mx1.redhat.com ([66.187.233.31]:61913 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750852AbWFQTNb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 15:13:31 -0400
Date: Sat, 17 Jun 2006 15:13:22 -0400
From: Ulrich Drepper <drepper@redhat.com>
Message-Id: <200606171913.k5HJDM3U021408@devserv.devel.redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Implement AT_SYMLINK_FOLLOW flag for linkat
Cc: akpm@osdl.org, torvalds@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When the linkat() syscall was added the flag parameter was added in the
last minute but it wasn't used so far.  The following patch should
change that.  My tests show that this is all that's needed.

If OLDNAME is a symlink setting the flag causes linkat to follow the
symlink and create a hardlink with the target.  This is actually
the behavior POSIX demands for link() as well but Linux wisely does
not do this.  With this flag (which will most likely be in the next
POSIX revision) the programmer can choose the behavior, defaulting
to the safe variant.  As a side effect it is now possible to implement
a POSIX-compliant link(2) function for those who are interested.

  touch file
  ln -s file symlink

  linkat(fd, "symlink", fd, "newlink", 0)
    -> newlink is hardlink of symlink

  linkat(fd, "symlink", fd, "newlink", AT_SYMLINK_FOLLOW)
    -> newlink is hardlink of file

The value of AT_SYMLINK_FOLLOW is determined by the definition we
already use in glibc.


Signed-Off-By: Ulrich Drepper <drepper@redhat.com>


 fs/namei.c            |    6 ++++--
 include/linux/fcntl.h |    1 +
 2 files changed, 5 insertions(+), 2 deletions(-)


--- linux/fs/namei.c-follow	2006-06-17 11:22:39.000000000 -0700
+++ linux/fs/namei.c	2006-06-17 11:58:18.000000000 -0700
@@ -2243,14 +2243,16 @@
 	int error;
 	char * to;
 
-	if (flags != 0)
+	if ((flags & ~AT_SYMLINK_FOLLOW) != 0)
 		return -EINVAL;
 
 	to = getname(newname);
 	if (IS_ERR(to))
 		return PTR_ERR(to);
 
-	error = __user_walk_fd(olddfd, oldname, 0, &old_nd);
+	error = __user_walk_fd(olddfd, oldname,
+			       flags & AT_SYMLINK_FOLLOW ? LOOKUP_FOLLOW : 0,
+			       &old_nd);
 	if (error)
 		goto exit;
 	error = do_path_lookup(newdfd, to, LOOKUP_PARENT, &nd);
--- linux/include/linux/fcntl.h-follow	2006-06-17 11:24:21.000000000 -0700
+++ linux/include/linux/fcntl.h	2006-06-17 11:24:51.000000000 -0700
@@ -29,6 +29,7 @@
 #define AT_SYMLINK_NOFOLLOW	0x100   /* Do not follow symbolic links.  */
 #define AT_REMOVEDIR		0x200   /* Remove directory instead of
                                            unlinking file.  */
+#define AT_SYMLINK_FOLLOW	0x400   /* Follow symbolic links.  */
 
 #ifdef __KERNEL__
 
