Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261653AbULBPu2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261653AbULBPu2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 10:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261658AbULBPuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 10:50:13 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:53187 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S261653AbULBPsB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 10:48:01 -0500
Subject: [PATCH 4/6] Add dynamic context transition support to SELinux
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Darrel Goeddel <dgoeddel@trustedcs.com>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1102002189.26015.107.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 02 Dec 2004 10:43:09 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch for 2.6.10-rc2-mm4 adds dynamic context transition support to SELinux via
writes to the existing /proc/pid/attr/current interface.  Previously,
SELinux only supported exec-based context transitions.  This
functionality allows privileged applications to apply privilege
bracketing without necessarily being refactored to an exec-based model
(although such a model has advantages in least privilege and
isolation).  A process must have setcurrent permission to use this
mechanism at all, and the dyntransition permission must be granted
between the old and new security contexts.  Multi-threaded processes
are not allowed to use this operation, as it will yield an
inconsistency among the security contexts of the threads sharing the
same mm.  Ptrace permission is revalidated against the new context if
the process is being ptraced.  Please apply.

Author:  Darrel Goeddel <dgoeddel@trustedcs.com>
Signed-off-by:  Stephen Smalley <sds@epoch.ncsc.mil>
Signed-off-by:  James Morris <jmorris@redhat.com>

 security/selinux/hooks.c                     |   52 +++++++++++++++++++++++++--
 security/selinux/include/av_perm_to_string.h |    2 +
 security/selinux/include/av_permissions.h    |    2 +
 security/selinux/ss/services.c               |    5 +-
 5 files changed, 56 insertions(+), 5 deletions(-)

diff -X /home/sds/exclude -ru linux-2.6/security/selinux/hooks.c linux-2.6-cvs/security/selinux/hooks.c
--- linux-2.6/security/selinux/hooks.c	2004-11-23 12:34:29.000000000 -0500
+++ linux-2.6-cvs/security/selinux/hooks.c	2004-11-30 12:35:29.000000000 -0500
@@ -4107,10 +4107,9 @@
 	u32 sid = 0;
 	int error;
 
-	if (current != p || !strcmp(name, "current")) {
+	if (current != p) {
 		/* SELinux only allows a process to change its own
-		   security attributes, and it only allows the process
-		   current SID to change via exec. */
+		   security attributes. */
 		return -EACCES;
 	}
 
@@ -4123,6 +4122,8 @@
 		error = task_has_perm(current, p, PROCESS__SETEXEC);
 	else if (!strcmp(name, "fscreate"))
 		error = task_has_perm(current, p, PROCESS__SETFSCREATE);
+	else if (!strcmp(name, "current"))
+		error = task_has_perm(current, p, PROCESS__SETCURRENT);
 	else
 		error = -EINVAL;
 	if (error)
@@ -4147,6 +4148,51 @@
 		tsec->exec_sid = sid;
 	else if (!strcmp(name, "fscreate"))
 		tsec->create_sid = sid;
+	else if (!strcmp(name, "current")) {
+		struct av_decision avd;
+
+		if (sid == 0)
+			return -EINVAL;
+
+		/* Only allow single threaded processes to change context */
+		if (atomic_read(&p->mm->mm_users) != 1) {
+			struct task_struct *g, *t;
+			struct mm_struct *mm = p->mm;
+			read_lock(&tasklist_lock);
+			do_each_thread(g, t)
+				if (t->mm == mm && t != p) {
+					read_unlock(&tasklist_lock);
+					return -EPERM;
+				}
+			while_each_thread(g, t);
+			read_unlock(&tasklist_lock);
+                }
+
+		/* Check permissions for the transition. */
+		error = avc_has_perm(tsec->sid, sid, SECCLASS_PROCESS,
+		                     PROCESS__DYNTRANSITION, NULL);
+		if (error)
+			return error;
+
+		/* Check for ptracing, and update the task SID if ok.
+		   Otherwise, leave SID unchanged and fail. */
+		task_lock(p);
+		if (p->ptrace & PT_PTRACED) {
+			error = avc_has_perm_noaudit(tsec->ptrace_sid, sid,
+						     SECCLASS_PROCESS,
+						     PROCESS__PTRACE, &avd);
+			if (!error)
+				tsec->sid = sid;
+			task_unlock(p);
+			avc_audit(tsec->ptrace_sid, sid, SECCLASS_PROCESS,
+				  PROCESS__PTRACE, &avd, error, NULL);
+			if (error)
+				return error;
+		} else {
+			tsec->sid = sid;
+			task_unlock(p);
+		}
+	}
 	else
 		return -EINVAL;
 
diff -X /home/sds/exclude -ru linux-2.6/security/selinux/include/av_permissions.h linux-2.6-cvs/security/selinux/include/av_permissions.h
--- linux-2.6/security/selinux/include/av_permissions.h	2004-11-23 12:34:29.000000000 -0500
+++ linux-2.6-cvs/security/selinux/include/av_permissions.h	2004-11-29 16:36:51.000000000 -0500
@@ -456,6 +456,8 @@
 #define PROCESS__SIGINH                           0x00100000UL
 #define PROCESS__SETRLIMIT                        0x00200000UL
 #define PROCESS__RLIMITINH                        0x00400000UL
+#define PROCESS__DYNTRANSITION                    0x00800000UL
+#define PROCESS__SETCURRENT                       0x01000000UL
 
 #define IPC__CREATE                               0x00000001UL
 #define IPC__DESTROY                              0x00000002UL
diff -X /home/sds/exclude -ru linux-2.6/security/selinux/include/av_perm_to_string.h linux-2.6-cvs/security/selinux/include/av_perm_to_string.h
--- linux-2.6/security/selinux/include/av_perm_to_string.h	2004-11-23 12:34:29.000000000 -0500
+++ linux-2.6-cvs/security/selinux/include/av_perm_to_string.h	2004-11-29 16:36:51.000000000 -0500
@@ -62,6 +62,8 @@
    S_(SECCLASS_PROCESS, PROCESS__SIGINH, "siginh")
    S_(SECCLASS_PROCESS, PROCESS__SETRLIMIT, "setrlimit")
    S_(SECCLASS_PROCESS, PROCESS__RLIMITINH, "rlimitinh")
+   S_(SECCLASS_PROCESS, PROCESS__DYNTRANSITION, "dyntransition")
+   S_(SECCLASS_PROCESS, PROCESS__SETCURRENT, "setcurrent")
    S_(SECCLASS_MSGQ, MSGQ__ENQUEUE, "enqueue")
    S_(SECCLASS_MSG, MSG__SEND, "send")
    S_(SECCLASS_MSG, MSG__RECEIVE, "receive")
diff -X /home/sds/exclude -ru linux-2.6/security/selinux/ss/services.c linux-2.6-cvs/security/selinux/ss/services.c
--- linux-2.6/security/selinux/ss/services.c	2004-11-23 12:34:29.000000000 -0500
+++ linux-2.6-cvs/security/selinux/ss/services.c	2004-11-29 16:11:45.000000000 -0500
@@ -275,7 +275,7 @@
 	 * pair.
 	 */
 	if (tclass == SECCLASS_PROCESS &&
-	    (avd->allowed & PROCESS__TRANSITION) &&
+	    (avd->allowed & (PROCESS__TRANSITION | PROCESS__DYNTRANSITION)) &&
 	    scontext->role != tcontext->role) {
 		for (ra = policydb.role_allow; ra; ra = ra->next) {
 			if (scontext->role == ra->role &&
@@ -283,7 +283,8 @@
 				break;
 		}
 		if (!ra)
-			avd->allowed = (avd->allowed) & ~(PROCESS__TRANSITION);
+			avd->allowed = (avd->allowed) & ~(PROCESS__TRANSITION |
+			                                PROCESS__DYNTRANSITION);
 	}
 
 	return 0;

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

