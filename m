Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261262AbUEDWMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbUEDWMg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 18:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261273AbUEDWMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 18:12:36 -0400
Received: from brev.stacken.kth.se ([130.237.234.84]:49367 "EHLO
	brev.stacken.kth.se") by vger.kernel.org with ESMTP id S261262AbUEDWMe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 18:12:34 -0400
From: Tomas Olsson <tol@stacken.kth.se>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: getgroups16() problem
Date: 05 May 2004 00:12:27 +0200
Message-ID: <lsr7jvrdepg.fsf@gustavskorv.stacken.kth.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
sys_getgroups16 (or rather groups16_to_user()) returns large gids
truncated. Needs to be fixed, one way or another. Don't know why the other
similar casts are still there.

Any thoughts?

/Tomas

--- linux-2.6.5/kernel/uid16.c	2004-04-04 05:37:07.000000000 +0200
+++ linux/kernel/uid16.c	2004-05-04 16:28:03.000000000 +0200
@@ -39,7 +39,7 @@
 
 asmlinkage long sys_setgid16(old_gid_t gid)
 {
-	return sys_setgid((gid_t)gid);
+	return sys_setgid(low2highgid(gid));
 }
 
 asmlinkage long sys_setreuid16(old_uid_t ruid, old_uid_t euid)
@@ -49,7 +49,7 @@
 
 asmlinkage long sys_setuid16(old_uid_t uid)
 {
-	return sys_setuid((uid_t)uid);
+	return sys_setuid(low2highuid(uid));
 }
 
 asmlinkage long sys_setresuid16(old_uid_t ruid, old_uid_t euid, old_uid_t suid)
@@ -88,12 +88,12 @@
 
 asmlinkage long sys_setfsuid16(old_uid_t uid)
 {
-	return sys_setfsuid((uid_t)uid);
+	return sys_setfsuid(low2highuid(uid));
 }
 
 asmlinkage long sys_setfsgid16(old_gid_t gid)
 {
-	return sys_setfsgid((gid_t)gid);
+	return sys_setfsgid(low2highgid(gid));
 }
 
 static int groups16_to_user(old_gid_t __user *grouplist,
@@ -103,7 +103,7 @@
 	old_gid_t group;
 
 	for (i = 0; i < group_info->ngroups; i++) {
-		group = (old_gid_t)GROUP_AT(group_info, i);
+		group = high2lowgid(GROUP_AT(group_info, i));
 		if (put_user(group, grouplist+i))
 			return -EFAULT;
 	}
@@ -120,7 +120,7 @@
 	for (i = 0; i < group_info->ngroups; i++) {
 		if (get_user(group, grouplist+i))
 			return  -EFAULT;
-		GROUP_AT(group_info, i) = (gid_t)group;
+		GROUP_AT(group_info, i) = low2highgid(group);
 	}
 
 	return 0;

