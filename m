Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262529AbULOXXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262529AbULOXXG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 18:23:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262532AbULOXXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 18:23:06 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:47065 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262529AbULOXWq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 18:22:46 -0500
Date: Wed, 15 Dec 2004 17:22:22 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@osdl.org>,
       James Morris <jmorris@redhat.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Properly split capset_check+capset_set
Message-ID: <20041215232222.GD888@IBM-BWN8ZTBWA01.austin.ibm.com>
References: <20041215194812.GA3080@IBM-BWN8ZTBWA01.austin.ibm.com> <1103142857.32732.13.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1103142857.32732.13.camel@moss-spartans.epoch.ncsc.mil>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Smalley (sds@epoch.ncsc.mil):
> On Wed, 2004-12-15 at 14:48, Serge E. Hallyn wrote:
> > The attached patch (against 2.6.10-rc3-mm1 w/ ioctl patch) removes the
> > redundant cap_capset_check hook and moves the security_capset_check
> > call to just before security_capset_set.  The selinux_capset_set hook
> > now simply sets the capability (through its secondary), while
> > selinux_capset_check checks the authorization permission.
> 
> One minor complaint:  the caller of capset() will no longer receive any
> error code if security_capset_check() fails.  I don't think that it is

Good point.  I was thinking in terms of cap_capset_check(), and lack of
that permission still returns an error, but selinux_capset_check's
return value in particular is not being reported.

How about the attached patch?

> necessary to preserve any error return in the cases where capset() is
> being applied to multiple processes, but in the case where it is being
> applied to a single specific process, it would be nice if any error
> return from security_capset_check() would be returned to the caller.

In the case of pid<0, would we want to do something like "return an error
if none of the sets was allowed, else return 0", or is that too ugly?

> I also wonder whether the existing hardcoded checks should be moved into
> the new security_capset_check() hook function for dummy and commoncap so
> that they will be applied to the real target, even when pid < 0. 
> Otherwise, those hardcoded checks seem bogus in the pid < 0 case, as
> they are then applied to current rather than to the true targets.

True, this (testing applicability of caps to the real targets in pid<0 case)
certainly seems like a good thing, so the attached patch leaves that
check in cap_capset_check, and just removes it from sys_capset() instead.

thanks,
-serge

Signed-off-by: Serge Hallyn <serue@us.ibm.com>

Index: linux-2.6.10-rc3-mm1/kernel/capability.c
===================================================================
--- linux-2.6.10-rc3-mm1.orig/kernel/capability.c	2004-12-15 17:14:39.080628184 -0600
+++ linux-2.6.10-rc3-mm1/kernel/capability.c	2004-12-15 17:23:43.617845944 -0600
@@ -93,8 +93,14 @@ static inline void cap_set_pg(int pgrp, 
 
 	do_each_task_pid(pgrp, PIDTYPE_PGID, g) {
 		target = g;
-		while_each_thread(g, target)
-			security_capset_set(target, effective, inheritable, permitted);
+		while_each_thread(g, target) {
+			if (!security_capset_check(target, effective,
+							inheritable,
+							permitted))
+				security_capset_set(target, effective,
+							inheritable,
+							permitted);
+		}
 	} while_each_task_pid(pgrp, PIDTYPE_PGID, g);
 }
 
@@ -111,6 +117,9 @@ static inline void cap_set_all(kernel_ca
      do_each_thread(g, target) {
              if (target == current || target->pid == 1)
                      continue;
+	     if (security_capset_check(target, effective, inheritable,
+						permitted))
+		     continue;
 	     security_capset_set(target, effective, inheritable, permitted);
      } while_each_thread(g, target);
 }
@@ -167,24 +176,6 @@ asmlinkage long sys_capset(cap_user_head
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
@@ -196,7 +187,11 @@ asmlinkage long sys_capset(cap_user_head
              else            /* all procs in process group */
                      cap_set_pg(-pid, &effective, &inheritable, &permitted);
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
--- linux-2.6.10-rc3-mm1.orig/security/selinux/hooks.c	2004-12-15 17:14:39.081628032 -0600
+++ linux-2.6.10-rc3-mm1/security/selinux/hooks.c	2004-12-15 17:25:55.381814776 -0600
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
 
