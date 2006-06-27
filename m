Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422659AbWF0WQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422659AbWF0WQE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 18:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422655AbWF0WPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 18:15:43 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:24525 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030459AbWF0WOz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 18:14:55 -0400
Subject: [PATCH 10/20] unix_find_other() elevate write count for touch_atime()
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, herbert@13thfloor.at, viro@ftp.linux.org.uk,
       serue@us.ibm.com, Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Tue, 27 Jun 2006 15:14:49 -0700
References: <20060627221436.77CCB048@localhost.localdomain>
In-Reply-To: <20060627221436.77CCB048@localhost.localdomain>
Message-Id: <20060627221449.EFF2B632@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 lxc-dave/net/unix/af_unix.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff -puN net/unix/af_unix.c~C-elevate-writers-opens-part4 net/unix/af_unix.c
--- lxc/net/unix/af_unix.c~C-elevate-writers-opens-part4	2006-06-27 10:40:30.000000000 -0700
+++ lxc-dave/net/unix/af_unix.c	2006-06-27 10:40:30.000000000 -0700
@@ -686,21 +686,27 @@ static struct sock *unix_find_other(stru
 		err = path_lookup(sunname->sun_path, LOOKUP_FOLLOW, &nd);
 		if (err)
 			goto fail;
+
+		err = mnt_want_write(nd.mnt);
+		if (err)
+			goto put_path_fail;
+
 		err = vfs_permission(&nd, MAY_WRITE);
 		if (err)
-			goto put_fail;
+			goto mnt_drop_write_fail;
 
 		err = -ECONNREFUSED;
 		if (!S_ISSOCK(nd.dentry->d_inode->i_mode))
-			goto put_fail;
+			goto mnt_drop_write_fail;
 		u=unix_find_socket_byinode(nd.dentry->d_inode);
 		if (!u)
-			goto put_fail;
+			goto mnt_drop_write_fail;
 
 		if (u->sk_type == type)
 			touch_atime(nd.mnt, nd.dentry);
 
 		path_release(&nd);
+		mnt_drop_write(nd.mnt);
 
 		err=-EPROTOTYPE;
 		if (u->sk_type != type) {
@@ -720,7 +726,9 @@ static struct sock *unix_find_other(stru
 	}
 	return u;
 
-put_fail:
+mnt_drop_write_fail:
+	mnt_drop_write(nd.mnt);
+put_path_fail:
 	path_release(&nd);
 fail:
 	*error=err;
_
