Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261644AbULPQRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbULPQRE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 11:17:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbULPQRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 11:17:04 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:8651 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261644AbULPQQw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 11:16:52 -0500
Date: Thu, 16 Dec 2004 10:16:48 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, Andrew Morton <akpm@osdl.org>,
       James Morris <jmorris@redhat.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Properly split capset_check+capset_set
Message-ID: <20041216161648.GA3260@IBM-BWN8ZTBWA01.austin.ibm.com>
References: <20041215194812.GA3080@IBM-BWN8ZTBWA01.austin.ibm.com> <1103142857.32732.13.camel@moss-spartans.epoch.ncsc.mil> <20041215232222.GD888@IBM-BWN8ZTBWA01.austin.ibm.com> <20041215154757.H2357@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041215154757.H2357@build.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chris Wright (chrisw@osdl.org):
> * Serge E. Hallyn (serue@us.ibm.com) wrote:
> > Quoting Stephen Smalley (sds@epoch.ncsc.mil):
> > > necessary to preserve any error return in the cases where capset() is
> > > being applied to multiple processes, but in the case where it is being
> > > applied to a single specific process, it would be nice if any error
> > > return from security_capset_check() would be returned to the caller.
> > 
> > In the case of pid<0, would we want to do something like "return an error
> > if none of the sets was allowed, else return 0", or is that too ugly?
> 
> The signal code returns an error if any delivery failed.  So, there's at
> least precedence for that type of behaviour.

Ok, the attached patch returns an error if none of the capsets succeeded,
else returns 0.  That seems to me to make the most sense from the caller's
point of view.

> > True, this (testing applicability of caps to the real targets in pid<0 case)
> > certainly seems like a good thing, so the attached patch leaves that
> > check in cap_capset_check, and just removes it from sys_capset() instead.
> 
> Yeah, it is inconsistent right now.  Don't forget, the dummy code doesn't
> even allow for capability setting.

So is the attached patch sufficient?  (With it, dummy will always refuse
the capset_set, as it did before)

thanks,
-serge

Signed-off-by: Serge Hallyn <serue@us.ibm.com>

Index: linux-2.6.10-rc3-mm1/kernel/capability.c
===================================================================
--- linux-2.6.10-rc3-mm1.orig/kernel/capability.c	2004-12-15 17:14:39.000000000 -0600
+++ linux-2.6.10-rc3-mm1/kernel/capability.c	2004-12-16 11:15:22.699524536 -0600
@@ -85,34 +85,52 @@ out:
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
+		}
 	} while_each_task_pid(pgrp, PIDTYPE_PGID, g);
+
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
 
      do_each_thread(g, target) {
              if (target == current || target->pid == 1)
                      continue;
+	     if (security_capset_check(target, effective, inheritable,
+						permitted))
+		     continue;
+	     ret = 0;
 	     security_capset_set(target, effective, inheritable, permitted);
      } while_each_thread(g, target);
+
+     return ret;
 }
 
 /*
@@ -167,36 +185,23 @@ asmlinkage long sys_capset(cap_user_head
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
Index: linux-2.6.10-rc3-mm1/security/selinux/hooks.c
===================================================================
--- linux-2.6.10-rc3-mm1.orig/security/selinux/hooks.c	2004-12-15 17:14:39.000000000 -0600
+++ linux-2.6.10-rc3-mm1/security/selinux/hooks.c	2004-12-15 17:25:55.000000000 -0600
@@ -1405,12 +1405,6 @@ static int selinux_capset_check(struct t
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
 
