Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965042AbVLGEcH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965042AbVLGEcH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 23:32:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932621AbVLGEcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 23:32:07 -0500
Received: from d36-15-41.home1.cgocable.net ([24.36.15.41]:53994 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S932607AbVLGEcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 23:32:06 -0500
Subject: [patch] add two inotify_add_watch flags
From: John McCutchan <ttb@tentacle.dhs.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Robert Love <rml@novell.com>, Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 06 Dec 2005 22:54:48 -0500
Message-Id: <1133927688.20396.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yo,

The below patch lets user space have more control over the inodes that
inotify will watch. It introduces two new flags. 

	IN_ONLYDIR -- only watch the inode if it is a directory
	This is needed to avoid the race that can occur when we want to be sure
that we are watching a directory.

	IN_DONT_FOLLOW -- don't follow a symlink. In combination with
IN_ONLYDIR we can make sure that we don't watch the target of symlinks.

The issues the flags fix came up when writing the gnome-vfs inotify
backend. Default behaviour is unchanged.


Signed-off-by: John McCutchan <ttb@tentacle.dhs.org>
Index: linux-2.6.14-rc5/fs/inotify.c
===================================================================
--- linux-2.6.14-rc5.orig/fs/inotify.c	2005-10-20 02:23:05.000000000 -0400
+++ linux-2.6.14-rc5/fs/inotify.c	2005-12-06 19:01:22.000000000 -0500
@@ -363,11 +363,18 @@
 /*
  * find_inode - resolve a user-given path to a specific inode and return a nd
  */
-static int find_inode(const char __user *dirname, struct nameidata *nd)
+static int find_inode(const char __user *dirname, struct nameidata *nd,
+		      int only_dir, int dont_follow_symlink)
 {
 	int error;
+	unsigned flags = 0;
 
-	error = __user_walk(dirname, LOOKUP_FOLLOW, nd);
+	if (!dont_follow_symlink)
+		flags |= LOOKUP_FOLLOW;
+	if (only_dir)
+		flags |= LOOKUP_DIRECTORY;
+
+	error = __user_walk(dirname, flags, nd);
 	if (error)
 		return error;
 	/* you can only watch an inode if you have read permissions on it */
@@ -943,7 +950,7 @@
 		goto fput_and_out;
 	}
 
-	ret = find_inode(path, &nd);
+	ret = find_inode(path, &nd, mask & IN_ONLYDIR, mask & IN_DONT_FOLLOW);
 	if (unlikely(ret))
 		goto fput_and_out;
 
Index: linux-2.6.14-rc5/include/linux/inotify.h
===================================================================
--- linux-2.6.14-rc5.orig/include/linux/inotify.h	2005-10-20 02:23:05.000000000 -0400
+++ linux-2.6.14-rc5/include/linux/inotify.h	2005-12-06 18:57:11.000000000 -0500
@@ -47,6 +47,8 @@
 #define IN_MOVE			(IN_MOVED_FROM | IN_MOVED_TO) /* moves */
 
 /* special flags */
+#define IN_ONLYDIR		0x01000000	/* only watch the path if it is a directory */
+#define IN_DONT_FOLLOW		0x02000000	/* don't follow a sym link */
 #define IN_MASK_ADD		0x20000000	/* add to the mask of an already existing watch */
 #define IN_ISDIR		0x40000000	/* event occurred against dir */
 #define IN_ONESHOT		0x80000000	/* only send event once */

