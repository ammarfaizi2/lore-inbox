Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261763AbULPSQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbULPSQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 13:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261919AbULPSQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 13:16:27 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:754 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261763AbULPSQP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 13:16:15 -0500
Date: Thu, 16 Dec 2004 12:16:13 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       James Morris <jmorris@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Split bprm_apply_creds into two functions
Message-ID: <20041216181613.GB3260@IBM-BWN8ZTBWA01.austin.ibm.com>
References: <20041215200005.GB3080@IBM-BWN8ZTBWA01.austin.ibm.com> <20041215145222.V469@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041215145222.V469@build.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chris Wright (chrisw@osdl.org):
> * Serge E. Hallyn (serue@us.ibm.com) wrote:
> > The security_bprm_apply_creds() function is called from
> > fs/exec.c:compute_creds() under task_lock(current).  SELinux must
> > perform some work which is unsafe in that context, and therefore
> > explicitly drops the task_lock, does the work, and re-acquires the
> > task_lock.  This is unsafe if other security modules are stacked after
> > SELinux, as their bprm_apply_creds assumes that the 'unsafe' variable is
> > still meaningful, that is, that the task_lock has not been dropped.
> 
> I don't like this approach.  The whole point is to ensure safety, and
> avoid races that have been found in the past.  This gives a new interface
> that could be easily used under the wrong conditions, and breaking
> the interface into two pieces looks kinda hackish.  Is there no other
> solution?  I looked at this once before and wondered why task_unlock()
> is needed to call avc_audit?  audit should be as lock friendly as printk
> IMO, and I don't recall seeing any deadlock after short review of it.
> But I didn't get much beyond that.  Is it all the flushing that can't
> hold task_lock?

As Stephen points out, it was more a concern about lock nesting.  The
attached patch simply removes the task_unlock from selinux_bprm_apply_creds,
and runs just fine on my machine.  Stephen, do you have a preference
either way, or was the task_unlock to relieve the concerns of others?

thanks,
-serge

Signed-off-by: Serge Hallyn <serue@us.ibm.com>

Index: linux-2.6.9-test/security/selinux/hooks.c
===================================================================
--- linux-2.6.9-test.orig/security/selinux/hooks.c	2004-12-16 12:14:32.000000000 -0600
+++ linux-2.6.9-test/security/selinux/hooks.c	2004-12-16 12:51:55.000000000 -0600
@@ -1827,35 +1827,26 @@ static void selinux_bprm_apply_creds(str
 		/* Check for shared state.  If not ok, leave SID
 		   unchanged and kill. */
 		if (unsafe & LSM_UNSAFE_SHARE) {
-			rc = avc_has_perm_noaudit(tsec->sid, sid,
-					  SECCLASS_PROCESS, PROCESS__SHARE, &avd);
+			rc = avc_has_perm(tsec->sid, sid, SECCLASS_PROCESS,
+						PROCESS__SHARE, NULL);
 			if (rc) {
-				task_unlock(current);
-				avc_audit(tsec->sid, sid, SECCLASS_PROCESS,
-				    PROCESS__SHARE, &avd, rc, NULL);
 				force_sig_specific(SIGKILL, current);
-				goto lock_out;
+				return;
 			}
 		}
 
 		/* Check for ptracing, and update the task SID if ok.
 		   Otherwise, leave SID unchanged and kill. */
 		if (unsafe & (LSM_UNSAFE_PTRACE | LSM_UNSAFE_PTRACE_CAP)) {
-			rc = avc_has_perm_noaudit(tsec->ptrace_sid, sid,
-					  SECCLASS_PROCESS, PROCESS__PTRACE, &avd);
-			if (!rc)
-				tsec->sid = sid;
-			task_unlock(current);
-			avc_audit(tsec->ptrace_sid, sid, SECCLASS_PROCESS,
-				  PROCESS__PTRACE, &avd, rc, NULL);
+			rc = avc_has_perm(tsec->ptrace_sid, sid,
+					  SECCLASS_PROCESS, PROCESS__PTRACE,
+					  NULL);
 			if (rc) {
 				force_sig_specific(SIGKILL, current);
-				goto lock_out;
+				return;
 			}
-		} else {
-			tsec->sid = sid;
-			task_unlock(current);
 		}
+		tsec->sid = sid;
 
 		/* Close files for which the new task SID is not authorized. */
 		flush_unauthorized_files(current->files);
@@ -1903,10 +1894,6 @@ static void selinux_bprm_apply_creds(str
 		/* Wake up the parent if it is waiting so that it can
 		   recheck wait permission to the new task SID. */
 		wake_up_interruptible(&current->parent->signal->wait_chldexit);
-
-lock_out:
-		task_lock(current);
-		return;
 	}
 }
 
