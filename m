Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262136AbTFBJvX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 05:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbTFBJvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 05:51:23 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:7161 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id S262136AbTFBJvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 05:51:14 -0400
Date: Mon, 2 Jun 2003 03:01:45 -0700
From: Chris Wright <chris@wirex.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com,
       greg@kroah.com, sds@epoch.ncsc.mil
Subject: Re: [PATCH][LSM] Early init for security modules and various cleanups
Message-ID: <20030602030145.F27233@figure1.int.wirex.com>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, linux-security-module@wirex.com,
	greg@kroah.com, sds@epoch.ncsc.mil
References: <20030602024910.B27233@figure1.int.wirex.com> <20030602025450.C27233@figure1.int.wirex.com> <20030602025736.D27233@figure1.int.wirex.com> <20030602030009.E27233@figure1.int.wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030602030009.E27233@figure1.int.wirex.com>; from chris@wirex.com on Mon, Jun 02, 2003 at 03:00:09AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1262  -> 1.1263 
#	        kernel/sys.c	1.45    -> 1.46   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/06/02	jakub@redhat.com	1.1263
# [LSM] make sure setfsuid/setfsgid return values are right. Before
# include/linux/security.h was added, setfsuid/setfsgid always returned
# old_fsuid, no matter if the fsuid was actually changed or not.  With
# the default security ops it seems to do the same, because both
# security_task_setuid and security_task_post_setuid return 0, but
# these are hooks which seem to return 0 on success, -errno on failure,
# so if some non-default security hook is installed and ever returns
# -errno in setfsuid/setfsgid, -errno will be returned from the syscall
# instead of the expected old_fsuid. This makes it hard to distinguish
# uids 0xfffff001 .. 0xffffffff from errors of security hooks.
# --------------------------------------------
#
diff -Nru a/kernel/sys.c b/kernel/sys.c
--- a/kernel/sys.c	Mon Jun  2 01:31:40 2003
+++ b/kernel/sys.c	Mon Jun  2 01:31:40 2003
@@ -829,13 +829,11 @@
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
@@ -848,9 +846,7 @@
 		current->fsuid = uid;
 	}
 
-	retval = security_task_post_setuid(old_fsuid, (uid_t)-1, (uid_t)-1, LSM_SETID_FS);
-	if (retval)
-		return retval;
+	security_task_post_setuid(old_fsuid, (uid_t)-1, (uid_t)-1, LSM_SETID_FS);
 
 	return old_fsuid;
 }
@@ -861,13 +857,11 @@
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
