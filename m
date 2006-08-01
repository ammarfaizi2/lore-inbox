Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbWHAX4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbWHAX4v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 19:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbWHAXxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 19:53:30 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:7078 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750785AbWHAXw7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 19:52:59 -0400
Subject: [PATCH 21/28] elevate writer count for do_sys_truncate()
To: linux-kernel@vger.kernel.org
Cc: viro@ftp.linux.org.uk, herbert@13thfloor.at, hch@infradead.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Tue, 01 Aug 2006 16:52:56 -0700
References: <20060801235240.82ADCA42@localhost.localdomain>
In-Reply-To: <20060801235240.82ADCA42@localhost.localdomain>
Message-Id: <20060801235256.8CFFD795@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 lxc-dave/fs/open.c |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff -puN fs/open.c~C-elevate-writers-opens-part2-do_sys_truncate fs/open.c
--- lxc/fs/open.c~C-elevate-writers-opens-part2-do_sys_truncate	2006-08-01 16:35:22.000000000 -0700
+++ lxc-dave/fs/open.c	2006-08-01 16:35:29.000000000 -0700
@@ -244,28 +244,32 @@ static long do_sys_truncate(const char _
 	if (!S_ISREG(inode->i_mode))
 		goto dput_and_out;
 
-	error = vfs_permission(&nd, MAY_WRITE);
+	error = mnt_want_write(nd.mnt);
 	if (error)
 		goto dput_and_out;
 
+	error = vfs_permission(&nd, MAY_WRITE);
+	if (error)
+		goto mnt_drop_write_and_out;
+
 	error = -EROFS;
 	if (IS_RDONLY(inode))
-		goto dput_and_out;
+		goto mnt_drop_write_and_out;
 
 	error = -EPERM;
 	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
-		goto dput_and_out;
+		goto mnt_drop_write_and_out;
 
 	/*
 	 * Make sure that there are no leases.
 	 */
 	error = break_lease(inode, FMODE_WRITE);
 	if (error)
-		goto dput_and_out;
+		goto mnt_drop_write_and_out;
 
 	error = get_write_access(inode);
 	if (error)
-		goto dput_and_out;
+		goto mnt_drop_write_and_out;
 
 	error = locks_verify_truncate(inode, NULL, length);
 	if (!error) {
@@ -274,6 +278,8 @@ static long do_sys_truncate(const char _
 	}
 	put_write_access(inode);
 
+mnt_drop_write_and_out:
+	mnt_drop_write(nd.mnt);
 dput_and_out:
 	path_release(&nd);
 out:
_
