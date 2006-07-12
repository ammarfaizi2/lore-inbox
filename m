Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932373AbWGLSSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373AbWGLSSM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 14:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbWGLSRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 14:17:54 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:63148 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932378AbWGLSR2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 14:17:28 -0400
Subject: [RFC][PATCH 19/27] elevate writer count for do_sys_truncate()
To: viro@ftp.linux.org.uk
Cc: serue@us.ibm.com, linux-kernel@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Wed, 12 Jul 2006 11:17:23 -0700
References: <20060712181709.5C1A4353@localhost.localdomain>
In-Reply-To: <20060712181709.5C1A4353@localhost.localdomain>
Message-Id: <20060712181723.3AC3A2F1@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 lxc-dave/fs/open.c |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff -puN fs/open.c~C-elevate-writers-opens-part2-do_sys_truncate fs/open.c
--- lxc/fs/open.c~C-elevate-writers-opens-part2-do_sys_truncate	2006-07-12 11:09:26.000000000 -0700
+++ lxc-dave/fs/open.c	2006-07-12 11:09:35.000000000 -0700
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
