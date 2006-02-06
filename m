Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932335AbWBFTvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbWBFTvw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 14:51:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbWBFTvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 14:51:51 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:3566 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932335AbWBFTvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 14:51:50 -0500
To: <linux-kernel@vger.kernel.org>
Cc: <vserver@list.linux-vserver.org>, Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Kirill Korotaev <dev@sw.ru>, Greg <gkurz@fr.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, Rik van Riel <riel@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, Kirill Korotaev <dev@openvz.org>,
       Andi Kleen <ak@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Jes Sorensen <jes@sgi.com>
Subject: [RFC][PATCH 10/20] capabilities: Update the capabilities code to
 handle pspaces.
References: <m11wygnvlp.fsf@ebiederm.dsl.xmission.com>
	<m1vevsmgvz.fsf@ebiederm.dsl.xmission.com>
	<m1lkwomgoj.fsf_-_@ebiederm.dsl.xmission.com>
	<m1fymwmgk0.fsf_-_@ebiederm.dsl.xmission.com>
	<m1bqxkmgcv.fsf_-_@ebiederm.dsl.xmission.com>
	<m17j88mg8l.fsf_-_@ebiederm.dsl.xmission.com>
	<m13biwmg4p.fsf_-_@ebiederm.dsl.xmission.com>
	<m1y80ol1gh.fsf_-_@ebiederm.dsl.xmission.com>
	<m1u0bcl1ai.fsf_-_@ebiederm.dsl.xmission.com>
	<m1psm0l170.fsf_-_@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 06 Feb 2006 12:49:20 -0700
In-Reply-To: <m1psm0l170.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Mon, 06 Feb 2006 12:46:59 -0700")
Message-ID: <m1lkwol133.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 kernel/capability.c |   56 +++++++++++++++++++++++++++++++--------------------
 1 files changed, 34 insertions(+), 22 deletions(-)

d84edcf08e16ef0af7170b494b371493d1829ee7
diff --git a/kernel/capability.c b/kernel/capability.c
index bfa3c92..80a618b 100644
--- a/kernel/capability.c
+++ b/kernel/capability.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/security.h>
 #include <linux/syscalls.h>
+#include <linux/pspace.h>
 #include <asm/uaccess.h>
 
 unsigned securebits = SECUREBITS_DEFAULT; /* systemwide security settings */
@@ -68,7 +69,7 @@ asmlinkage long sys_capget(cap_user_head
      read_lock(&tasklist_lock); 
 
      if (pid && pid != current->pid) {
-	     target = find_task_by_pid(pid);
+	     target = find_task_by_pid(current->pspace, pid);
 	     if (!target) {
 	          ret = -ESRCH;
 	          goto out;
@@ -96,11 +97,12 @@ static inline int cap_set_pg(int pgrp, k
 			      kernel_cap_t *inheritable,
 			      kernel_cap_t *permitted)
 {
+	struct pspace *pspace = current->pspace;
 	task_t *g, *target;
 	int ret = -EPERM;
 	int found = 0;
 
-	do_each_task_pid(pgrp, PIDTYPE_PGID, g) {
+	do_each_task_pid(pspace, pgrp, PIDTYPE_PGID, g) {
 		target = g;
 		while_each_thread(g, target) {
 			if (!security_capset_check(target, effective,
@@ -113,7 +115,7 @@ static inline int cap_set_pg(int pgrp, k
 			}
 			found = 1;
 		}
-	} while_each_task_pid(pgrp, PIDTYPE_PGID, g);
+	} while_each_task_pid(pspace, pgrp, PIDTYPE_PGID, g);
 
 	if (!found)
 	     ret = 0;
@@ -121,20 +123,26 @@ static inline int cap_set_pg(int pgrp, k
 }
 
 /*
- * cap_set_all - set capabilities for all processes other than init
- * and self.  We call this holding task_capability_lock and tasklist_lock.
- */
-static inline int cap_set_all(kernel_cap_t *effective,
-			       kernel_cap_t *inheritable,
-			       kernel_cap_t *permitted)
+ * cap_set_pspace - set capabilities for all processes in pspace
+ * other than init and self.  We call this holding
+ * task_capability_lock and tasklist_lock.
+ */
+static inline int cap_set_pspace(struct pspace *pspace,
+					kernel_cap_t *effective,
+					kernel_cap_t *inheritable,
+					kernel_cap_t *permitted)
 {
      task_t *g, *target;
      int ret = -EPERM;
      int found = 0;
 
      do_each_thread(g, target) {
-             if (target == current || target->pid == 1)
-                     continue;
+	     if (target == current)
+		     continue;
+	     if (current_pspace_leader(target))
+		     continue;
+	     if (!in_pspace(pspace, target))
+		     continue;
              found = 1;
 	     if (security_capset_check(target, effective, inheritable,
 						permitted))
@@ -200,7 +208,7 @@ asmlinkage long sys_capset(cap_user_head
      read_lock(&tasklist_lock);
 
      if (pid > 0 && pid != current->pid) {
-          target = find_task_by_pid(pid);
+          target = find_task_by_pid(current->pspace, pid);
           if (!target) {
                ret = -ESRCH;
                goto out;
@@ -212,20 +220,24 @@ asmlinkage long sys_capset(cap_user_head
 
      /* having verified that the proposed changes are legal,
            we now put them into effect. */
-     if (pid < 0) {
-             if (pid == -1)  /* all procs other than current and init */
-                     ret = cap_set_all(&effective, &inheritable, &permitted);
+	if (pid < 0) {
+		struct task_struct *p;
 
-             else            /* all procs in process group */
-                     ret = cap_set_pg(-pid, &effective, &inheritable,
+		p = find_task_by_pid(current->pspace, -pid);
+		if (p && pspace_leader(p))
+			/* all procs other than current and init */
+			ret = cap_set_pspace(p->pspace, &effective, 
+						&inheritable, &permitted);
+		else            /* all procs in process group */
+			ret = cap_set_pg(-pid, &effective, &inheritable,
 		     					&permitted);
-     } else {
-	     ret = security_capset_check(target, &effective, &inheritable,
+	} else {
+		ret = security_capset_check(target, &effective, &inheritable,
 	     						&permitted);
-	     if (!ret)
-		     security_capset_set(target, &effective, &inheritable,
+		if (!ret)
+			security_capset_set(target, &effective, &inheritable,
 		     					&permitted);
-     }
+	}
 
 out:
      read_unlock(&tasklist_lock);
-- 
1.1.5.g3480

