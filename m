Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261856AbUJYOzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261856AbUJYOzF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 10:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbUJYOpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 10:45:36 -0400
Received: from ip22-176.tor.istop.com ([66.11.176.22]:42920 "EHLO
	crlf.tor.istop.com") by vger.kernel.org with ESMTP id S261827AbUJYOkj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 10:40:39 -0400
Cc: raven@themaw.net
Subject: [PATCH 4/28] VFS: Stat shouldn't stop expire
In-Reply-To: <10987152003432@sun.com>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Mon, 25 Oct 2004 10:40:30 -0400
Message-Id: <1098715230634@sun.com>
References: <10987152003432@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Mike Waychison <michael.waychison@sun.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the problem where if you have a mountpoint that is going to
expire, it fails to expire before somebody keeps stat(2)ing the root of it's
filesystem.  For example, consider the case where a user has his home
directory automounted on /home/mikew.   Some other user can keep the
filesystem mounted forever by simply calling ls(1) in /home, because the stat
action resets the marker on each call.

Signed-off-by: Mike Waychison <michael.waychison@sun.com>
---

 namei.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletion(-)

Index: linux-2.6.9-quilt/fs/namei.c
===================================================================
--- linux-2.6.9-quilt.orig/fs/namei.c	2004-08-14 01:36:45.000000000 -0400
+++ linux-2.6.9-quilt/fs/namei.c	2004-10-22 17:17:34.762179488 -0400
@@ -275,7 +275,16 @@ int deny_write_access(struct file * file
 void path_release(struct nameidata *nd)
 {
 	dput(nd->dentry);
-	mntput(nd->mnt);
+	/*
+	 * In order to ensure that access to an automounted filesystems'
+	 * root does not reset it's expire counter, we check to see if the path
+	 * being released here is a mountpoint itself.  If it is, then we call
+	 * _mntput which leaves the expire counter alone.
+	 */
+	if (nd->mnt && nd->mnt->mnt_root == nd->dentry)
+		_mntput(nd->mnt);
+	else  
+		mntput(nd->mnt);
 }
 
 /*

