Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262617AbTCZXEJ>; Wed, 26 Mar 2003 18:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262619AbTCZXEI>; Wed, 26 Mar 2003 18:04:08 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:24502 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S262617AbTCZXD5>; Wed, 26 Mar 2003 18:03:57 -0500
Date: Wed, 26 Mar 2003 18:15:09 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: setfs[ug]id syscall return value and include/linux/security.h question
Message-ID: <20030326181509.Q13397@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Before include/linux/security.h was added, setfsuid/setfsgid always returned
old_fsuid, no matter if the fsuid was actually changed or not.
With the default security ops it seems to do the same, because both
security_task_setuid and security_task_post_setuid return 0, but these are
hooks which seem to return 0 on success, -errno on failure, so if some
non-default security hook is installed and ever returns -errno
in setfsuid/setfsgid, -errno will be returned from the syscall instead
of the expected old_fsuid. This makes it hard to distinguish uids
0xfffff001 .. 0xffffffff from errors of security hooks.
Shouldn't sys_setfsuid/sys_setfsgid be changed:

--- linux-2.5.66/kernel/sys.c.jj	Mon Mar 24 23:00:00 2003
+++ linux-2.5.66/kernel/sys.c	Thu Mar 27 00:11:20 2003
@@ -824,13 +824,11 @@ asmlinkage long sys_getresgid(gid_t *rgi
 asmlinkage long sys_setfsuid(uid_t uid)
 {
 	int old_fsuid;
-	int retval;
-
-	retval = security_task_setuid(uid, (uid_t)-1, (uid_t)-1, LSM_SETID_FS);
-	if (retval)
-		return retval;
 
 	old_fsuid = current->fsuid;
+	if (security_task_setuid(uid, (uid_t)-1, (uid_t)-1, LSM_SETID_FS))
+		return old_fsuid;
+
 	if (uid == current->uid || uid == current->euid ||
 	    uid == current->suid || uid == current->fsuid || 
 	    capable(CAP_SETUID))
@@ -843,9 +841,7 @@ asmlinkage long sys_setfsuid(uid_t uid)
 		current->fsuid = uid;
 	}
 
-	retval = security_task_post_setuid(old_fsuid, (uid_t)-1, (uid_t)-1, LSM_SETID_FS);
-	if (retval)
-		return retval;
+	security_task_post_setuid(old_fsuid, (uid_t)-1, (uid_t)-1, LSM_SETID_FS);
 
 	return old_fsuid;
 }
@@ -856,13 +852,11 @@ asmlinkage long sys_setfsuid(uid_t uid)
 asmlinkage long sys_setfsgid(gid_t gid)
 {
 	int old_fsgid;
-	int retval;
-
-	retval = security_task_setgid(gid, (gid_t)-1, (gid_t)-1, LSM_SETID_FS);
-	if (retval)
-		return retval;
 
 	old_fsgid = current->fsgid;
+	if (security_task_setgid(gid, (gid_t)-1, (gid_t)-1, LSM_SETID_FS))
+		return old_fsgid;
+
 	if (gid == current->gid || gid == current->egid ||
 	    gid == current->sgid || gid == current->fsgid || 
 	    capable(CAP_SETGID))

	Jakub
