Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbVADQdU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbVADQdU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 11:33:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbVADQa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 11:30:26 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:16569 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261724AbVADQ1o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 11:27:44 -0500
Date: Tue, 4 Jan 2005 10:27:45 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, James Morris <jmorris@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] properly split capset_check+capset_set
Message-ID: <20050104162745.GA400@IBM-BWN8ZTBWA01.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch removes checks from kernel/capability.c which are
redundant with cap_capset_check() code, and moves the capset_check()
calls to immediately before the capset_set() calls.  This allows
capset_check() to accurately check the setter's permission to set caps
on the target.  Please apply.

thanks,
-serge

Signed-off-by: Serge Hallyn <serue@us.ibm.com>

Index: linux-2.6.10-mm1/kernel/capability.c
===================================================================
--- linux-2.6.10-mm1.orig/kernel/capability.c	2005-01-04 10:23:54.000000000 -0600
+++ linux-2.6.10-mm1/kernel/capability.c	2005-01-04 10:32:48.000000000 -0600
@@ -85,34 +85,60 @@ out:
  * cap_set_pg - set capabilities for all processes in a given process
  * group.  We call this holding task_capability_lock and tasklist_lock.
  */
-static inline void cap_set_pg(int pgrp, kernel_cap_t *effective,
+static inline int cap_set_pg(int pgrp, kernel_cap_t *effective,
 			      kernel_cap_t *inheritable,
 			      kernel_cap_t *permitted)
 {
 	task_t *g, *target;
+	int ret = -EPERM;
+	int found = 0;
 
 	do_each_task_pid(pgrp, PIDTYPE_PGID, g) {
 		target = g;
-		while_each_thread(g, target)
-			security_capset_set(target, effective, inheritable, permitted);
+		while_each_thread(g, target) {
+			if (!security_capset_check(target, effective,
+							inheritable,
+							permitted)) {
+				security_capset_set(target, effective,
+							inheritable,
+							permitted);
+				ret = 0;
+			}
+			found = 1;
+		}
 	} while_each_task_pid(pgrp, PIDTYPE_PGID, g);
+
+	if (!found)
+	     ret = 0;
+	return ret;
 }
 
 /*
  * cap_set_all - set capabilities for all processes other than init
  * and self.  We call this holding task_capability_lock and tasklist_lock.
  */
-static inline void cap_set_all(kernel_cap_t *effective,
+static inline int cap_set_all(kernel_cap_t *effective,
 			       kernel_cap_t *inheritable,
 			       kernel_cap_t *permitted)
 {
      task_t *g, *target;
+     int ret = -EPERM;
+     int found = 0;
 
      do_each_thread(g, target) {
              if (target == current || target->pid == 1)
                      continue;
+             found = 1;
+	     if (security_capset_check(target, effective, inheritable,
+						permitted))
+		     continue;
+	     ret = 0;
 	     security_capset_set(target, effective, inheritable, permitted);
      } while_each_thread(g, target);
+
+     if (!found)
+	     ret = 0;
+     return ret;
 }
 
 /*
@@ -167,36 +193,23 @@ asmlinkage long sys_capset(cap_user_head
      } else
                target = current;
 
-     ret = -EPERM;
-
-     if (security_capset_check(target, &effective, &inheritable, &permitted))
-	     goto out;
-
-     if (!cap_issubset(inheritable, cap_combine(target->cap_inheritable,
-                       current->cap_permitted)))
-             goto out;
-
-     /* verify restrictions on target's new Permitted set */
-     if (!cap_issubset(permitted, cap_combine(target->cap_permitted,
-                       current->cap_permitted)))
-             goto out;
-
-     /* verify the _new_Effective_ is a subset of the _new_Permitted_ */
-     if (!cap_issubset(effective, permitted))
-             goto out;
-
      ret = 0;
 
      /* having verified that the proposed changes are legal,
            we now put them into effect. */
      if (pid < 0) {
              if (pid == -1)  /* all procs other than current and init */
-                     cap_set_all(&effective, &inheritable, &permitted);
+                     ret = cap_set_all(&effective, &inheritable, &permitted);
 
              else            /* all procs in process group */
-                     cap_set_pg(-pid, &effective, &inheritable, &permitted);
+                     ret = cap_set_pg(-pid, &effective, &inheritable,
+		     					&permitted);
      } else {
-	     security_capset_set(target, &effective, &inheritable, &permitted);
+	     ret = security_capset_check(target, &effective, &inheritable,
+	     						&permitted);
+	     if (!ret)
+		     security_capset_set(target, &effective, &inheritable,
+		     					&permitted);
      }
 
 out:
Index: linux-2.6.10-mm1/security/selinux/hooks.c
===================================================================
--- linux-2.6.10-mm1.orig/security/selinux/hooks.c	2005-01-04 10:23:54.000000000 -0600
+++ linux-2.6.10-mm1/security/selinux/hooks.c	2005-01-04 10:24:19.000000000 -0600
@@ -1390,12 +1390,6 @@ static int selinux_capset_check(struct t
 static void selinux_capset_set(struct task_struct *target, kernel_cap_t *effective,
                                kernel_cap_t *inheritable, kernel_cap_t *permitted)
 {
-	int error;
-
-	error = task_has_perm(current, target, PROCESS__SETCAP);
-	if (error)
-		return;
-
 	secondary_ops->capset_set(target, effective, inheritable, permitted);
 }
 
