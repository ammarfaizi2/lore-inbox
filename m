Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266908AbTBQHjX>; Mon, 17 Feb 2003 02:39:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266917AbTBQHjX>; Mon, 17 Feb 2003 02:39:23 -0500
Received: from dp.samba.org ([66.70.73.150]:22664 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266908AbTBQHjV>;
	Mon, 17 Feb 2003 02:39:21 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: tridge@samba.org, linux-kernel@vger.kernel.org, cyeoh@samba.org,
       sfr@canb.auug.org.au
Subject: [PATCH] Prevent setting 32 uids/gids in the error range
Date: Mon, 17 Feb 2003 18:41:59 +1100
Message-Id: <20030217074920.E76822C003@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tridge noticed that getegid() was returning EPERM.

I used -1000 since that's what PTR_ERR uses, but i386 _syscall macros
use -125: I don't suppose it really matters.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: User and Group ID range check patch
Author: Rusty Russell
Status: Tested on 2.5.61-bk1

D: sys_getuid etc return long, which means that setting your gid to -1
D: on 32-bit platforms causes sys_getuid to return "EPERM", for example.

diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.61-bk1/include/linux/types.h working-2.5.61-bk1-valid_ids/include/linux/types.h
--- linux-2.5.61-bk1/include/linux/types.h	2003-02-11 14:26:19.000000000 +1100
+++ working-2.5.61-bk1-valid_ids/include/linux/types.h	2003-02-17 17:26:38.000000000 +1100
@@ -34,6 +34,10 @@ typedef __kernel_gid32_t	gid_t;
 typedef __kernel_uid16_t        uid16_t;
 typedef __kernel_gid16_t        gid16_t;
 
+/* If we allowed these to be set, getuid etc. would break (they return long) */
+#define is_valid_gid(gid) ((unsigned long)(gid) < -1000UL)
+#define is_valid_uid(uid) ((unsigned long)(uid) < -1000UL)
+
 #ifdef CONFIG_UID16
 /* This is defined by include/asm-{arch}/posix_types.h */
 typedef __kernel_old_uid_t	old_uid_t;
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.61-bk1/kernel/sys.c working-2.5.61-bk1-valid_ids/kernel/sys.c
--- linux-2.5.61-bk1/kernel/sys.c	2003-02-17 11:37:55.000000000 +1100
+++ working-2.5.61-bk1-valid_ids/kernel/sys.c	2003-02-17 18:11:01.000000000 +1100
@@ -658,6 +658,9 @@ asmlinkage long sys_setuid(uid_t uid)
 	if (retval)
 		return retval;
 
+	if (!is_valid_uid(uid))
+		return -EINVAL;
+
 	old_ruid = new_ruid = current->uid;
 	old_suid = current->suid;
 	new_suid = old_suid;
@@ -700,6 +705,11 @@ asmlinkage long sys_setresuid(uid_t ruid
 	if (retval)
 		return retval;
 
+	if ((!is_valid_uid(ruid) && ruid != (uid_t)-1)
+	    || (!is_valid_uid(euid) && euid != (uid_t)-1)
+	    || (!is_valid_uid(suid) && suid != (uid_t)-1))
+		return -EINVAL;
+
 	if (!capable(CAP_SETUID)) {
 		if ((ruid != (uid_t) -1) && (ruid != current->uid) &&
 		    (ruid != current->euid) && (ruid != current->suid))
@@ -752,6 +762,11 @@ asmlinkage long sys_setresgid(gid_t rgid
 	if (retval)
 		return retval;
 
+	if ((!is_valid_gid(rgid) && rgid != (gid_t)-1)
+	    || (!is_valid_gid(egid) && egid != (gid_t)-1)
+	    || (!is_valid_gid(sgid) && sgid != (gid_t)-1))
+		return -EINVAL;
+
 	if (!capable(CAP_SETGID)) {
 		if ((rgid != (gid_t) -1) && (rgid != current->gid) &&
 		    (rgid != current->egid) && (rgid != current->sgid))
@@ -806,6 +821,9 @@ asmlinkage long sys_setfsuid(uid_t uid)
 	if (retval)
 		return retval;
 
+	if (!is_valid_uid(uid))
+		return -EINVAL;
+
 	old_fsuid = current->fsuid;
 	if (uid == current->uid || uid == current->euid ||
 	    uid == current->suid || uid == current->fsuid || 
@@ -838,6 +856,9 @@ asmlinkage long sys_setfsgid(gid_t gid)
 	if (retval)
 		return retval;
 
+	if (!is_valid_gid(gid))
+		return -EINVAL;
+
 	old_fsgid = current->fsgid;
 	if (gid == current->gid || gid == current->egid ||
 	    gid == current->sgid || gid == current->fsgid || 
@@ -1059,7 +1080,7 @@ asmlinkage long sys_getgroups(int gidset
 asmlinkage long sys_setgroups(int gidsetsize, gid_t *grouplist)
 {
 	gid_t groups[NGROUPS];
-	int retval;
+	int retval, i;
 
 	if (!capable(CAP_SETGID))
 		return -EPERM;
@@ -1067,6 +1088,9 @@ asmlinkage long sys_setgroups(int gidset
 		return -EINVAL;
 	if(copy_from_user(groups, grouplist, gidsetsize * sizeof(gid_t)))
 		return -EFAULT;
+	for (i = 0; i < gidsetsize; i++)
+		if (!is_valid_gid(groups[i]))
+			return -EINVAL;
 	retval = security_task_setgroups(gidsetsize, groups);
 	if (retval)
 		return retval;
