Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263596AbTL2QH0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 11:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263605AbTL2QH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 11:07:26 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:21929 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S263596AbTL2QHV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 11:07:21 -0500
Subject: [PATCH] Add resource limit control to SELinux
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>
Cc: Roland McGrath <roland@redhat.com>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1072714025.845.92.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Mon, 29 Dec 2003 11:07:05 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against 2.6.0-mm2 (specifically, relative to the selinux
signal state inheritance control patch) adds controls to the SELinux
module over the setting and inheritance of resource limits.  With these
controls, the ability to set hard limits can be limited to specific
processes such as login, and when an untrusted process invokes a more
trusted program, soft limits can be reset, thereby avoiding failures in
the trusted program due to malicious setting of the soft limit by the
untrusted process.  Roland McGrath provided input and feedback on the
patch.  Please apply, or let James Morris and me know if you'd like this
to be resubmitted later.  Thanks.

 security/selinux/hooks.c                     |   34 +++++++++++++++++++++++----
 security/selinux/include/av_perm_to_string.h |    2 +
 security/selinux/include/av_permissions.h    |    2 +
 3 files changed, 34 insertions(+), 4 deletions(-)

diff -X /home/sds/dontdiff -Nru linux-2.6.0.prev/security/selinux/hooks.c linux-2.6.0.next/security/selinux/hooks.c
--- linux-2.6.0.prev/security/selinux/hooks.c	2003-12-19 13:37:05.000000000 -0500
+++ linux-2.6.0.next/security/selinux/hooks.c	2003-12-19 13:37:05.000000000 -0500
@@ -1516,6 +1516,7 @@
 	u32 sid;
 	struct av_decision avd;
 	struct itimerval itimer;
+	struct rlimit *rlim, *initrlim;
 	int rc, i;
 
 	secondary_ops->bprm_compute_creds(bprm);
@@ -1586,6 +1587,26 @@
 			spin_unlock_irq(&current->sighand->siglock);
 		}
 
+		/* Check whether the new SID can inherit resource limits
+		   from the old SID.  If not, reset all soft limits to
+		   the lower of the current task's hard limit and the init
+		   task's soft limit.  Note that the setting of hard limits 
+		   (even to lower them) can be controlled by the setrlimit 
+		   check. The inclusion of the init task's soft limit into
+	           the computation is to avoid resetting soft limits higher
+		   than the default soft limit for cases where the default
+		   is lower than the hard limit, e.g. RLIMIT_CORE or 
+		   RLIMIT_STACK.*/
+		rc = avc_has_perm(tsec->osid, tsec->sid, SECCLASS_PROCESS,
+				  PROCESS__RLIMITINH, NULL, NULL);
+		if (rc) {
+			for (i = 0; i < RLIM_NLIMITS; i++) {
+				rlim = current->rlim + i;
+				initrlim = init_task.rlim+i;
+				rlim->rlim_cur = min(rlim->rlim_max,initrlim->rlim_cur);
+			}
+		}
+
 		/* Wake up the parent if it is waiting so that it can
 		   recheck wait permission to the new task SID. */
 		wake_up_interruptible(&current->parent->wait_chldexit);
@@ -2222,10 +2243,15 @@
 
 static int selinux_task_setrlimit(unsigned int resource, struct rlimit *new_rlim)
 {
-	/* SELinux does not currently provide a process
-	   resource limit policy based on security contexts.
-	   It does control the use of the CAP_SYS_RESOURCE capability
-	   using the capable hook. */
+	struct rlimit *old_rlim = current->rlim + resource;
+
+	/* Control the ability to change the hard limit (whether
+	   lowering or raising it), so that the hard limit can
+	   later be used as a safe reset point for the soft limit
+	   upon context transitions. See selinux_bprm_compute_creds. */
+	if (old_rlim->rlim_max != new_rlim->rlim_max)
+		return task_has_perm(current, current, PROCESS__SETRLIMIT);
+
 	return 0;
 }
 
diff -X /home/sds/dontdiff -Nru linux-2.6.0.prev/security/selinux/include/av_permissions.h linux-2.6.0.next/security/selinux/include/av_permissions.h
--- linux-2.6.0.prev/security/selinux/include/av_permissions.h	2003-12-19 13:37:05.000000000 -0500
+++ linux-2.6.0.next/security/selinux/include/av_permissions.h	2003-12-19 13:37:05.000000000 -0500
@@ -451,6 +451,8 @@
 #define PROCESS__SETFSCREATE                      0x00040000UL
 #define PROCESS__NOATSECURE                       0x00080000UL
 #define PROCESS__SIGINH                           0x00100000UL
+#define PROCESS__SETRLIMIT                        0x00200000UL
+#define PROCESS__RLIMITINH                        0x00400000UL
 
 #define IPC__SETATTR                              0x00000008UL
 #define IPC__READ                                 0x00000010UL
diff -X /home/sds/dontdiff -Nru linux-2.6.0.prev/security/selinux/include/av_perm_to_string.h linux-2.6.0.next/security/selinux/include/av_perm_to_string.h
--- linux-2.6.0.prev/security/selinux/include/av_perm_to_string.h	2003-12-19 13:37:05.000000000 -0500
+++ linux-2.6.0.next/security/selinux/include/av_perm_to_string.h	2003-12-19 13:37:05.000000000 -0500
@@ -67,6 +67,8 @@
    { SECCLASS_PROCESS, PROCESS__SETFSCREATE, "setfscreate" },
    { SECCLASS_PROCESS, PROCESS__NOATSECURE, "noatsecure" },
    { SECCLASS_PROCESS, PROCESS__SIGINH, "siginh" },
+   { SECCLASS_PROCESS, PROCESS__SETRLIMIT, "setrlimit" },
+   { SECCLASS_PROCESS, PROCESS__RLIMITINH, "rlimitinh" },
    { SECCLASS_MSGQ, MSGQ__ENQUEUE, "enqueue" },
    { SECCLASS_MSG, MSG__SEND, "send" },
    { SECCLASS_MSG, MSG__RECEIVE, "receive" },



-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

