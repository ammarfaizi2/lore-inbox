Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbTLWQBG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 11:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbTLWQBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 11:01:06 -0500
Received: from [144.51.25.10] ([144.51.25.10]:27364 "EHLO epoch.ncsc.mil")
	by vger.kernel.org with ESMTP id S261606AbTLWQA7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 11:00:59 -0500
Subject: [PATCH] Add signal state inheritance control to SELinux
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>
Cc: Roland McGrath <roland@redhat.com>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1072195228.18003.56.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Tue, 23 Dec 2003 11:00:28 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against 2.6.0 adds a control to the SELinux module over the
inheritance of signal-related state upon security context transitions in
order to protect the new security context.  If the permission is not
granted by the policy for a given pair of contexts, then transitions
between them will clear itimers, flush all pending signals, forcibly
flush signal handlers, and unblock all signals.  Roland McGrath provided
input and feedback on the patch.  
Please apply, or let James Morris and me know if you'd like this to be
resubmitted later.  Thanks.

 security/selinux/hooks.c                     |   23 ++++++++++++++++++++++-
 security/selinux/include/av_perm_to_string.h |    1 +
 security/selinux/include/av_permissions.h    |    1 +
 3 files changed, 24 insertions(+), 1 deletion(-)

diff -X /home/sds/dontdiff -Nru linux-2.6.0.prev/security/selinux/hooks.c linux-2.6.0.next/security/selinux/hooks.c
--- linux-2.6.0.prev/security/selinux/hooks.c	2003-12-19 13:37:00.000000000 -0500
+++ linux-2.6.0.next/security/selinux/hooks.c	2003-12-19 13:37:00.000000000 -0500
@@ -1515,7 +1515,8 @@
 	struct bprm_security_struct *bsec;
 	u32 sid;
 	struct av_decision avd;
-	int rc;
+	struct itimerval itimer;
+	int rc, i;
 
 	secondary_ops->bprm_compute_creds(bprm);
 
@@ -1565,6 +1566,26 @@
 		/* Close files for which the new task SID is not authorized. */
 		flush_unauthorized_files(current->files);
 
+		/* Check whether the new SID can inherit signal state
+		   from the old SID.  If not, clear itimers to avoid
+		   subsequent signal generation and flush and unblock
+		   signals. This must occur _after_ the task SID has
+                  been updated so that any kill done after the flush
+                  will be checked against the new SID. */
+		rc = avc_has_perm(tsec->osid, tsec->sid, SECCLASS_PROCESS,
+				  PROCESS__SIGINH, NULL, NULL);
+		if (rc) {
+			memset(&itimer, 0, sizeof itimer);
+			for (i = 0; i < 3; i++)
+				do_setitimer(i, &itimer, NULL);
+			flush_signals(current);
+			spin_lock_irq(&current->sighand->siglock);
+			flush_signal_handlers(current, 1);
+			sigemptyset(&current->blocked);
+			recalc_sigpending();
+			spin_unlock_irq(&current->sighand->siglock);
+		}
+
 		/* Wake up the parent if it is waiting so that it can
 		   recheck wait permission to the new task SID. */
 		wake_up_interruptible(&current->parent->wait_chldexit);
diff -X /home/sds/dontdiff -Nru linux-2.6.0.prev/security/selinux/include/av_permissions.h linux-2.6.0.next/security/selinux/include/av_permissions.h
--- linux-2.6.0.prev/security/selinux/include/av_permissions.h	2003-12-17 21:58:28.000000000 -0500
+++ linux-2.6.0.next/security/selinux/include/av_permissions.h	2003-12-19 13:37:00.000000000 -0500
@@ -450,6 +450,7 @@
 #define PROCESS__SETEXEC                          0x00020000UL
 #define PROCESS__SETFSCREATE                      0x00040000UL
 #define PROCESS__NOATSECURE                       0x00080000UL
+#define PROCESS__SIGINH                           0x00100000UL
 
 #define IPC__SETATTR                              0x00000008UL
 #define IPC__READ                                 0x00000010UL
diff -X /home/sds/dontdiff -Nru linux-2.6.0.prev/security/selinux/include/av_perm_to_string.h linux-2.6.0.next/security/selinux/include/av_perm_to_string.h
--- linux-2.6.0.prev/security/selinux/include/av_perm_to_string.h	2003-12-17 21:59:27.000000000 -0500
+++ linux-2.6.0.next/security/selinux/include/av_perm_to_string.h	2003-12-19 13:37:00.000000000 -0500
@@ -66,6 +66,7 @@
    { SECCLASS_PROCESS, PROCESS__SETEXEC, "setexec" },
    { SECCLASS_PROCESS, PROCESS__SETFSCREATE, "setfscreate" },
    { SECCLASS_PROCESS, PROCESS__NOATSECURE, "noatsecure" },
+   { SECCLASS_PROCESS, PROCESS__SIGINH, "siginh" },
    { SECCLASS_MSGQ, MSGQ__ENQUEUE, "enqueue" },
    { SECCLASS_MSG, MSG__SEND, "send" },
    { SECCLASS_MSG, MSG__RECEIVE, "receive" },


-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

