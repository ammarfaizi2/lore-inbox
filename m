Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261651AbULBPpM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbULBPpM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 10:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261653AbULBPn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 10:43:28 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:60098 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S261651AbULBPm3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 10:42:29 -0500
Subject: [PATCH 2/6] Update selinux_task_setscheduler
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1102001847.26015.98.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 02 Dec 2004 10:37:27 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch for 2.6.10-rc2-mm4 updates the selinux_task_setscheduler hook function to use
the standard helper for task permission checks since it is now safe to
audit from this hook (due to the upstream change to setscheduler() to
not hold the runqueue lock during the security hook call).   Please apply.

Signed-off-by:  Stephen Smalley <sds@epoch.ncsc.mil>
Signed-off-by:  James Morris <jmorris@redhat.com>

 security/selinux/hooks.c |   11 +----------
 1 files changed, 1 insertion(+), 10 deletions(-)

--- linux-2.6.10-rc2-mm4/security/selinux/hooks.c.orig	2004-12-01 13:02:07.819344632 -0500
+++ linux-2.6.10-rc2-mm4/security/selinux/hooks.c	2004-12-01 13:12:27.700108432 -0500
@@ -2710,16 +2710,7 @@ static int selinux_task_setrlimit(unsign
 
 static int selinux_task_setscheduler(struct task_struct *p, int policy, struct sched_param *lp)
 {
-	struct task_security_struct *tsec1, *tsec2;
-
-	tsec1 = current->security;
-	tsec2 = p->security;
-
-	/* No auditing from the setscheduler hook, since the runqueue lock
-	   is held and the system will deadlock if we try to log an audit
-	   message. */
-	return avc_has_perm_noaudit(tsec1->sid, tsec2->sid,
-				    SECCLASS_PROCESS, PROCESS__SETSCHED, NULL);
+	return task_has_perm(current, p, PROCESS__SETSCHED);
 }
 
 static int selinux_task_getscheduler(struct task_struct *p)

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

