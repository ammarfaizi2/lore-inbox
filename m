Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934962AbWKXQQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934962AbWKXQQj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 11:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934961AbWKXQQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 11:16:39 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:64387 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S934959AbWKXQQi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 11:16:38 -0500
Date: Fri, 24 Nov 2006 10:16:26 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Chris Friedhoff <chris@friedhoff.org>,
       "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-security-module@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
       Chris Wright <chrisw@sous-sol.org>, KaiGai Kohei <kaigai@kaigai.gr.jp>,
       Alexey Dobriyan <adobriyan@gmail.com>
Subject: file caps: permit unsafe signaling when CONFIG_FS_CAPS=n
Message-ID: <20061124161626.GA22462@sergelap.austin.ibm.com>
References: <20061114030655.GB31893@sergelap> <20061123001458.fe73f64a.akpm@osdl.org> <20061123002207.5e18bade.akpm@osdl.org> <20061123131203.f7b6972f.chris@friedhoff.org> <20061123103920.8d908952.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061123103920.8d908952.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, the following patch restores the CONFIG_FS_CAPS=n signaling
behavior, but I'm having a config problem.  When
CONFIG_SECURITY_CAPABILITIES=n, and I toggle
CONFIG_SECURITY_FS_CAPABILITIES between y and n, security/commoncap.o
does not recompile.  However since capabilities are now the default
security module, commoncap.o is in fact included in the kernel build,
and therefore should be recompiled.

Looking into why, but maybe someone knows offhand what would be going
wrong?

thanks,
-serge

From: Serge E. Hallyn <serue@us.ibm.com>
Subject: [PATCH 1/1] file caps: permit unsafe signaling when CONFIG_FS_CAPS=n

In legacy behavior, when a user starts a setuid program, that user
can send signals to the running program.  The file capabilities
patch prevents that not only when file capabilities are enabled,
but in all cases where capabilities are used.

For instance, when starting the X server, which is setuid root, it
is expected that the user who started it be able to kill it.

Existing behavior should not be changed.  This patch should reenable
signaling setuid processes started by the signaling user.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
---
 security/commoncap.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index 0e89f1b..04b277f 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -389,6 +389,7 @@ int cap_task_post_setuid (uid_t old_ruid
 	return 0;
 }
 
+#ifdef CONFIG_SECURITY_FS_CAPABILITIES
 /*
  * Rationale: code calling task_setscheduler, task_setioprio, and
  * task_setnice, assumes that
@@ -444,6 +445,26 @@ int cap_task_kill(struct task_struct *p,
 
 	return -EPERM;
 }
+#else
+int cap_task_setscheduler (struct task_struct *p, int policy,
+			   struct sched_param *lp)
+{
+	return 0;
+}
+int cap_task_setioprio (struct task_struct *p, int ioprio)
+{
+	return 0;
+}
+int cap_task_setnice (struct task_struct *p, int nice)
+{
+	return 0;
+}
+int cap_task_kill(struct task_struct *p, struct siginfo *info,
+				int sig, u32 secid)
+{
+	return 0;
+}
+#endif
 
 void cap_task_reparent_to_init (struct task_struct *p)
 {
-- 
1.4.1

