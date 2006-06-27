Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422654AbWF0WQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422654AbWF0WQG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 18:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422653AbWF0WPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 18:15:37 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:11483 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030460AbWF0WO4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 18:14:56 -0400
Subject: [PATCH 13/20] elevate writer count for do_sys_truncate()
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, herbert@13thfloor.at, viro@ftp.linux.org.uk,
       serue@us.ibm.com, Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Tue, 27 Jun 2006 15:14:51 -0700
References: <20060627221436.77CCB048@localhost.localdomain>
In-Reply-To: <20060627221436.77CCB048@localhost.localdomain>
Message-Id: <20060627221451.F53855F4@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 lxc-dave/fs/open.c |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff -puN fs/open.c~C-elevate-writers-opens-part2-do_sys_truncate fs/open.c
--- lxc/fs/open.c~C-elevate-writers-opens-part2-do_sys_truncate	2006-06-27 10:40:32.000000000 -0700
+++ lxc-dave/fs/open.c	2006-06-27 10:40:32.000000000 -0700
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
