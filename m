Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261887AbUJYPE4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbUJYPE4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 11:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbUJYPEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 11:04:36 -0400
Received: from ip22-176.tor.istop.com ([66.11.176.22]:7593 "EHLO
	crlf.tor.istop.com") by vger.kernel.org with ESMTP id S261887AbUJYOvu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 10:51:50 -0400
Cc: raven@themaw.net
Subject: [PATCH 26/28] VFS: Introduce MNT_NOFOLLOW
In-Reply-To: <10987158711277@sun.com>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Mon, 25 Oct 2004 10:51:42 -0400
Message-Id: <1098715902968@sun.com>
References: <10987158711277@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Mike Waychison <michael.waychison@sun.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Umounting direct mounts requires the ability to umount without following
->follow_link.  We do this by adding a new flag called MNT_NOFOLLOW to
umount2.

Signed-off-by: Mike Waychison <michael.waychison@sun.com>
---

 fs/namespace.c     |    3 ++-
 include/linux/fs.h |    1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

Index: linux-2.6.9-quilt/include/linux/fs.h
===================================================================
--- linux-2.6.9-quilt.orig/include/linux/fs.h	2004-10-22 17:17:43.766810576 -0400
+++ linux-2.6.9-quilt/include/linux/fs.h	2004-10-22 17:17:47.808196192 -0400
@@ -735,6 +735,7 @@ extern int send_sigurg(struct fown_struc
 
 #define MNT_FORCE	0x00000001	/* Attempt to forcibily umount */
 #define MNT_DETACH	0x00000002	/* Just detach from the tree */
+#define MNT_NOFOLLOW    0x00000004      /* Do not follow symlinks */
 
 extern struct list_head super_blocks;
 extern spinlock_t sb_lock;
Index: linux-2.6.9-quilt/fs/namespace.c
===================================================================
--- linux-2.6.9-quilt.orig/fs/namespace.c	2004-10-22 17:17:45.491548376 -0400
+++ linux-2.6.9-quilt/fs/namespace.c	2004-10-22 17:17:47.809196040 -0400
@@ -693,8 +693,9 @@ asmlinkage long sys_umount(char __user *
 {
 	struct nameidata nd;
 	int retval;
+	int walk_flags = flags & MNT_NOFOLLOW ? 0 : LOOKUP_FOLLOW;
 
-	retval = __user_walk(name, LOOKUP_FOLLOW, &nd);
+	retval = __user_walk(name, walk_flags, &nd);
 	if (retval)
 		goto out;
 	retval = -EINVAL;

