Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261885AbUJYPFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbUJYPFY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 11:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbUJYPFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 11:05:05 -0400
Received: from ip22-176.tor.istop.com ([66.11.176.22]:6057 "EHLO
	crlf.tor.istop.com") by vger.kernel.org with ESMTP id S261885AbUJYOvU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 10:51:20 -0400
Cc: raven@themaw.net
Subject: [PATCH 25/28] VFS: statfs(64) shouldn't follow last component symlink
In-Reply-To: <10987158413464@sun.com>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Mon, 25 Oct 2004 10:51:11 -0400
Message-Id: <10987158711277@sun.com>
References: <10987158413464@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Mike Waychison <michael.waychison@sun.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mount-related userspace tools will require the ability to detect whether what
looks like a regular directory is actually a autofs trigger.  To handle this,
tools can statfs a given directory and check to see if statfs->f_type ==
AUTOFSNG_SUPER_MAGIC before walking into the directory (and causing the a
filesystem to automount).

To make this happen, we cannot allow statfs to follow_link.

NOTE: This may break any userspace that assumes it can statfs across a
last-component symlink.  I can't think of any real world breakage however, as
mount(8) will drop the real path in /etc/mtab and /proc/mounts will always
show the true path.

Signed-off-by: Mike Waychison <michael.waychison@sun.com>
---

 open.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.9-quilt/fs/open.c
===================================================================
--- linux-2.6.9-quilt.orig/fs/open.c	2004-08-14 01:36:13.000000000 -0400
+++ linux-2.6.9-quilt/fs/open.c	2004-10-22 17:17:47.180291648 -0400
@@ -121,7 +121,7 @@ asmlinkage long sys_statfs(const char __
 	struct nameidata nd;
 	int error;
 
-	error = user_path_walk(path, &nd);
+	error = user_path_walk_link(path, &nd);
 	if (!error) {
 		struct statfs tmp;
 		error = vfs_statfs_native(nd.dentry->d_inode->i_sb, &tmp);
@@ -140,7 +140,7 @@ asmlinkage long sys_statfs64(const char 
 
 	if (sz != sizeof(*buf))
 		return -EINVAL;
-	error = user_path_walk(path, &nd);
+	error = user_path_walk_link(path, &nd);
 	if (!error) {
 		struct statfs64 tmp;
 		error = vfs_statfs64(nd.dentry->d_inode->i_sb, &tmp);

