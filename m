Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbWH1VjQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbWH1VjQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 17:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932165AbWH1VjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 17:39:16 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:29865 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932130AbWH1VjP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 17:39:15 -0400
Date: Mon, 28 Aug 2006 16:39:12 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <method@gentoo.org>,
       "Serge E. Hallyn" <serge@hallyn.com>,
       Nicholas Miell <nmiell@comcast.net>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       lkml <linux-kernel@vger.kernel.org>,
       linux-security-module@vger.kernel.org, chrisw@sous-sol.org
Subject: Re: [RFC] [PATCH] file posix capabilities
Message-ID: <20060828213912.GA428@sergelap.austin.ibm.com>
References: <20060815020647.GB16220@sergelap.austin.ibm.com> <m13bbyr80e.fsf@ebiederm.dsl.xmission.com> <1155615736.2468.12.camel@entropy> <20060815114946.GA7267@vino.hallyn.com> <1155658688.1780.33.camel@moss-spartans.epoch.ncsc.mil> <20060816024200.GD15241@sergelap.austin.ibm.com> <1155734401.18911.33.camel@moss-spartans.epoch.ncsc.mil> <44E45A70.8090801@gentoo.org> <1155817698.21070.18.camel@moss-spartans.epoch.ncsc.mil> <20060821203656.GA22769@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060821203656.GA22769@sergelap.austin.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch addresses remaining LSM hooks which need to be
handled in the face of file capabilities.  This is on top of the
cap_bprm_secureexec patch in the email I had replied to.

-serge

>From 7ee4dafddb85d6ccf34ddc50e2a44b244bb4b6b3 Mon Sep 17 00:00:00 2001
From: Serge E. Hallyn <serue@us.ibm.com>
Date: Mon, 28 Aug 2006 14:39:57 -0500
Subject: [PATCH 3/3] fscaps: define task_kill and other new capchecks

task_setrlimit, task_prctl, and task_movememory are not a problem
with fscaps.  This patch defines task_setscheduler, task_setioprio,
cap_task_kill, and task_setnice to make sure a user cannot affect a
process in which they called a program with some fscaps.

One remaining question is the note under task_setscheduler: are we
ok with CAP_SYS_NICE being sufficient to confine a process to a
cpuset?

It is a semantic change, as without fsccaps, attach_task doesn't
allow CAP_SYS_NICE to override the uid equivalence check.  But since
it uses security_task_setscheduler, which elsewhere is used where
CAP_SYS_NICE can be used to override the uid equivalence check,
fixing it might be tough.

     task_setscheduler
         need to check for !capable(CAP_SYS_NICE)  && current->euid==p->euid
             && !cap_subset(current->caps, p->caps) where p->caps are not
             subset of current->caps
         note: this also controls cpuset:attach_task.  Are we ok with
             CAP_SYS_NICE being used to confine to a cpuset?
     task_setioprio
         Same check as task_setscheduler
     task_setnice
         sys_setpriority uses this (through set_one_prio) for another
         process.  Need same checks as setrlimit

 no need:
     task_setrlimit
         affect only calling task
     task_prctl (set_dumpable, set_keepcaps)
         affect only calling task
     task_movememory
         CAP_SYS_NICE is already checked

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
---
 include/linux/security.h |   10 +++++--
 security/capability.c    |    4 +++
 security/commoncap.c     |   62 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+), 3 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index f753038..7a99930 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -51,6 +51,10 @@ extern int cap_inode_setxattr(struct den
 extern int cap_inode_removexattr(struct dentry *dentry, char *name);
 extern int cap_task_post_setuid (uid_t old_ruid, uid_t old_euid, uid_t old_suid, int flags);
 extern void cap_task_reparent_to_init (struct task_struct *p);
+extern int cap_task_kill(struct task_struct *p, struct siginfo *info, int sig, u32 secid);
+extern int cap_task_setscheduler (struct task_struct *p, int policy, struct sched_param *lp);
+extern int cap_task_setioprio (struct task_struct *p, int ioprio);
+extern int cap_task_setnice (struct task_struct *p, int nice);
 extern int cap_syslog (int type);
 extern int cap_vm_enough_memory (long pages);
 
@@ -2522,12 +2526,12 @@ static inline int security_task_setgroup
 
 static inline int security_task_setnice (struct task_struct *p, int nice)
 {
-	return 0;
+	return cap_task_setnice(p, nice);
 }
 
 static inline int security_task_setioprio (struct task_struct *p, int ioprio)
 {
-	return 0;
+	return cap_task_setioprio(p, ioprio);
 }
 
 static inline int security_task_getioprio (struct task_struct *p)
@@ -2562,7 +2566,7 @@ static inline int security_task_kill (st
 				      struct siginfo *info, int sig,
 				      u32 secid)
 {
-	return 0;
+	return cap_task_kill(p, info, sig, secid);
 }
 
 static inline int security_task_wait (struct task_struct *p)
diff --git a/security/capability.c b/security/capability.c
index b868e7e..14cb592 100644
--- a/security/capability.c
+++ b/security/capability.c
@@ -40,6 +40,10 @@ static struct security_operations capabi
 	.inode_setxattr =		cap_inode_setxattr,
 	.inode_removexattr =		cap_inode_removexattr,
 
+	.task_kill =			cap_task_kill,
+	.task_setscheduler =		cap_task_setscheduler,
+	.task_setioprio =		cap_task_setioprio,
+	.task_setnice =			cap_task_setnice,
 	.task_post_setuid =		cap_task_post_setuid,
 	.task_reparent_to_init =	cap_task_reparent_to_init,
 
diff --git a/security/commoncap.c b/security/commoncap.c
index b1777a9..82bd59f 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -387,6 +387,64 @@ int cap_task_post_setuid (uid_t old_ruid
 	return 0;
 }
 
+/*
+ * Rationale: code calling task_setscheduler, task_setioprio, and
+ * task_setnice, assumes that
+ *   . if capable(cap_sys_nice), then those actions should be allowed
+ *   . if not capable(cap_sys_nice), but acting on your own processes,
+ *   	then those actions should be allowed
+ * This is insufficient now since you can call code without suid, but
+ * yet with increased caps.
+ * So we check for increased caps on the target process.
+ */
+static inline int cap_safe_nice(struct task_struct *p)
+{
+	if (!cap_issubset(p->cap_permitted, current->cap_permitted) &&
+	    !__capable(current, CAP_SYS_NICE))
+		return -EPERM;
+	return 0;
+}
+
+int cap_task_setscheduler (struct task_struct *p, int policy,
+			   struct sched_param *lp)
+{
+	return cap_safe_nice(p);
+}
+
+int cap_task_setioprio (struct task_struct *p, int ioprio)
+{
+	return cap_safe_nice(p);
+}
+
+int cap_task_setnice (struct task_struct *p, int nice)
+{
+	return cap_safe_nice(p);
+}
+
+int cap_task_kill(struct task_struct *p, struct siginfo *info,
+				int sig, u32 secid)
+{
+	if (info != SEND_SIG_NOINFO && (is_si_special(info) || SI_FROMKERNEL(info)))
+		return 0;
+
+	if (secid)
+		/*
+		 * Signal sent as a particular user.
+		 * Capabilities are ignored.  May be wrong, but it's the
+		 * only thing we can do at the moment.
+		 * Used only by usb drivers?
+		 */
+		return 0;
+	if (current->uid == 0 || current->euid == 0)
+		return 0;
+	if (capable(CAP_KILL))
+		return 0;
+	if (cap_issubset(p->cap_permitted, current->cap_permitted))
+		return 0;
+
+	return -EPERM;
+}
+
 void cap_task_reparent_to_init (struct task_struct *p)
 {
 	p->cap_effective = CAP_INIT_EFF_SET;
@@ -424,6 +482,10 @@ EXPORT_SYMBOL(cap_bprm_secureexec);
 EXPORT_SYMBOL(cap_inode_setxattr);
 EXPORT_SYMBOL(cap_inode_removexattr);
 EXPORT_SYMBOL(cap_task_post_setuid);
+EXPORT_SYMBOL(cap_task_kill);
+EXPORT_SYMBOL(cap_task_setscheduler);
+EXPORT_SYMBOL(cap_task_setioprio);
+EXPORT_SYMBOL(cap_task_setnice);
 EXPORT_SYMBOL(cap_task_reparent_to_init);
 EXPORT_SYMBOL(cap_syslog);
 EXPORT_SYMBOL(cap_vm_enough_memory);
-- 
1.4.2

