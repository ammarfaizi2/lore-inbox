Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbWHAXzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbWHAXzJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 19:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWHAXyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 19:54:09 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:48848 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750773AbWHAXxo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 19:53:44 -0400
Subject: [PATCH 18/28] unix_find_other() elevate write count for touch_atime()
To: linux-kernel@vger.kernel.org
Cc: viro@ftp.linux.org.uk, herbert@13thfloor.at, hch@infradead.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Tue, 01 Aug 2006 16:52:53 -0700
References: <20060801235240.82ADCA42@localhost.localdomain>
In-Reply-To: <20060801235240.82ADCA42@localhost.localdomain>
Message-Id: <20060801235253.5BBF8CE0@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 lxc-dave/net/unix/af_unix.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff -puN net/unix/af_unix.c~C-elevate-writers-opens-part4 net/unix/af_unix.c
--- lxc/net/unix/af_unix.c~C-elevate-writers-opens-part4	2006-08-01 16:35:09.000000000 -0700
+++ lxc-dave/net/unix/af_unix.c	2006-08-01 16:35:27.000000000 -0700
@@ -708,21 +708,27 @@ static struct sock *unix_find_other(stru
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
@@ -742,7 +748,9 @@ static struct sock *unix_find_other(stru
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
