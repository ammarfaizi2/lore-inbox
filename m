Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbUAIPiM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 10:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbUAIPiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 10:38:12 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:29555 "EHLO
	thoron.boston.redhat.com") by vger.kernel.org with ESMTP
	id S262126AbUAIPiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 10:38:03 -0500
Date: Fri, 9 Jan 2004 10:37:53 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Stephen Smalley <sds@epoch.ncsc.mil>,
       <selinux@tycho.nsa.gov>
Subject: [PATCH][SELINUX] 1/7 Add resource limit control to SELinux (resend)
Message-ID: <Xine.LNX.4.44.0401091009440.21309-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against 2.6.1-mm1 (specifically, relative to the selinux
signal state inheritance control patch) adds controls to the SELinux
module over the setting and inheritance of resource limits.  With these
controls, the ability to set hard limits can be limited to specific
processes such as login, and when an untrusted process invokes a more
trusted program, soft limits can be reset, thereby avoiding failures in
the trusted program due to malicious setting of the soft limit by the
untrusted process.  Roland McGrath provided input and feedback on the
patch, which was implemented by Stephen Smalley <sds@epoch.ncsc.mil>.

Please apply.

 hooks.c                     |   34 ++++++++++++++++++++++++++++++----
 include/av_perm_to_string.h |    2 ++
 include/av_permissions.h    |    2 ++
 3 files changed, 34 insertions(+), 4 deletions(-)

diff -urN -X dontdiff linux-2.6.1-rc2.pending/security/selinux/hooks.c linux-2.6.1-rc2.w1/security/selinux/hooks.c
--- linux-2.6.1-rc2.pending/security/selinux/hooks.c	2004-01-07 11:19:00.000000000 -0500
+++ linux-2.6.1-rc2.w1/security/selinux/hooks.c	2004-01-07 11:32:23.957197280 -0500
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
 
diff -urN -X dontdiff linux-2.6.1-rc2.pending/security/selinux/include/av_permissions.h linux-2.6.1-rc2.w1/security/selinux/include/av_permissions.h
--- linux-2.6.1-rc2.pending/security/selinux/include/av_permissions.h	2004-01-07 11:19:00.000000000 -0500
+++ linux-2.6.1-rc2.w1/security/selinux/include/av_permissions.h	2004-01-07 11:32:23.997191200 -0500
@@ -451,6 +451,8 @@
 #define PROCESS__SETFSCREATE                      0x00040000UL
 #define PROCESS__NOATSECURE                       0x00080000UL
 #define PROCESS__SIGINH                           0x00100000UL
+#define PROCESS__SETRLIMIT                        0x00200000UL
+#define PROCESS__RLIMITINH                        0x00400000UL
 
 #define IPC__SETATTR                              0x00000008UL
 #define IPC__READ                                 0x00000010UL
diff -urN -X dontdiff linux-2.6.1-rc2.pending/security/selinux/include/av_perm_to_string.h linux-2.6.1-rc2.w1/security/selinux/include/av_perm_to_string.h
--- linux-2.6.1-rc2.pending/security/selinux/include/av_perm_to_string.h	2004-01-07 11:19:00.000000000 -0500
+++ linux-2.6.1-rc2.w1/security/selinux/include/av_perm_to_string.h	2004-01-07 11:32:23.998191048 -0500
@@ -67,6 +67,8 @@
    { SECCLASS_PROCESS, PROCESS__SETFSCREATE, "setfscreate" },
    { SECCLASS_PROCESS, PROCESS__NOATSECURE, "noatsecure" },
    { SECCLASS_PROCESS, PROCESS__SIGINH, "siginh" },
+   { SECCLASS_PROCESS, PROCESS__SETRLIMIT, "setrlimit" },
+   { SECCLASS_PROCESS, PROCESS__RLIMITINH, "rlimitinh" },
    { SECCLASS_MSGQ, MSGQ__ENQUEUE, "enqueue" },
    { SECCLASS_MSG, MSG__SEND, "send" },
    { SECCLASS_MSG, MSG__RECEIVE, "receive" },



