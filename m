Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261309AbUJZALU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbUJZALU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 20:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261927AbUJYPGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 11:06:39 -0400
Received: from ip22-176.tor.istop.com ([66.11.176.22]:4777 "EHLO
	crlf.tor.istop.com") by vger.kernel.org with ESMTP id S261836AbUJYOuu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 10:50:50 -0400
Cc: raven@themaw.net
Subject: [PATCH 24/28] VFS: Fixup for ->follow_link on root of filesystem
In-Reply-To: <10987158112343@sun.com>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Mon, 25 Oct 2004 10:50:41 -0400
Message-Id: <10987158413464@sun.com>
References: <10987158112343@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Mike Waychison <michael.waychison@sun.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When a follow_link dentry call is made, the implementation expects the
dentry to be followed as well as a nameidata struct to be filled in.
The received nd->mnt is expected to contain the vfsmount of the dentry
being followed, so that a subsequent call to vfs_follow_link may
properly pivot off that mount and onto another vfsmount as the path of
the link is walked, thus keeping reference counts proper.

The changes made in fs/namei.c@1.42 break this behaviour if the dentry
being follow_link'ed is a root dentry. This is because follow_mount
follows down next.mnt and not nd->mnt like it used to. So, if a root
dentry has a follow_link op, the nd->mnt it receives is in fact the
vfsmount of the mount it is mounted upon (which breaks reference counts).

Signed-off-by: Mike Waychison <michael.waychison@sun.com>
---

 namei.c |    2 ++
 1 files changed, 2 insertions(+)

Index: linux-2.6.9-quilt/fs/namei.c
===================================================================
--- linux-2.6.9-quilt.orig/fs/namei.c	2004-10-22 17:17:34.762179488 -0400
+++ linux-2.6.9-quilt/fs/namei.c	2004-10-22 17:17:46.571384216 -0400
@@ -755,6 +755,7 @@ int fastcall link_path_walk(const char *
 
 		if (inode->i_op->follow_link) {
 			mntget(next.mnt);
+			nd->mnt = next.mnt;
 			err = do_follow_link(next.dentry, nd);
 			dput(next.dentry);
 			mntput(next.mnt);
@@ -809,6 +810,7 @@ last_component:
 		if ((lookup_flags & LOOKUP_FOLLOW)
 		    && inode && inode->i_op && inode->i_op->follow_link) {
 			mntget(next.mnt);
+			nd->mnt = next.mnt;
 			err = do_follow_link(next.dentry, nd);
 			dput(next.dentry);
 			mntput(next.mnt);

