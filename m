Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265208AbTFMHJO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 03:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265218AbTFMHJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 03:09:14 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:2036 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id S265208AbTFMHJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 03:09:02 -0400
Date: Fri, 13 Jun 2003 00:22:24 -0700
From: Chris Wright <chris@wirex.com>
To: torvalds@transmeta.com, akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com,
       greg@kroah.com, sds@epoch.ncsc.mil
Subject: Re: [PATCH][LSM] setfsuid/setgsuid bug fix 4/4
Message-ID: <20030613002224.G31636@figure1.int.wirex.com>
Mail-Followup-To: torvalds@transmeta.com, akpm@digeo.com,
	linux-kernel@vger.kernel.org, linux-security-module@wirex.com,
	greg@kroah.com, sds@epoch.ncsc.mil
References: <20030613001021.D31636@figure1.int.wirex.com> <20030613001521.E31636@figure1.int.wirex.com> <20030613001908.F31636@figure1.int.wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030613001908.F31636@figure1.int.wirex.com>; from chris@wirex.com on Fri, Jun 13, 2003 at 12:19:08AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch from Jakub Jelínek <jakub@redhat.com>

[LSM] make sure setfsuid/setfsgid return values are right. Before
include/linux/security.h was added, setfsuid/setfsgid always returned
old_fsuid, no matter if the fsuid was actually changed or not.  With
the default security ops it seems to do the same, because both
security_task_setuid and security_task_post_setuid return 0, but
these are hooks which seem to return 0 on success, -errno on failure,
so if some non-default security hook is installed and ever returns
-errno in setfsuid/setfsgid, -errno will be returned from the syscall
instead of the expected old_fsuid. This makes it hard to distinguish
uids 0xfffff001 .. 0xffffffff from errors of security hooks.

--- linus-2.5/kernel/sys.c.setfsuid	Thu Jun 12 22:53:14 2003
+++ linus-2.5/kernel/sys.c	Thu Jun 12 22:53:14 2003
@@ -831,13 +831,11 @@
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
@@ -850,9 +848,7 @@
 		current->fsuid = uid;
 	}
 
-	retval = security_task_post_setuid(old_fsuid, (uid_t)-1, (uid_t)-1, LSM_SETID_FS);
-	if (retval)
-		return retval;
+	security_task_post_setuid(old_fsuid, (uid_t)-1, (uid_t)-1, LSM_SETID_FS);
 
 	return old_fsuid;
 }
@@ -863,13 +859,11 @@
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
