Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbUL2OBY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbUL2OBY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 09:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbUL2OBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 09:01:24 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:61424 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261347AbUL2OBU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 09:01:20 -0500
Date: Wed, 29 Dec 2004 08:01:12 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: bert hubert <ahu@ds9a.nl>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: local root exploit confirmed in 2.6.10: Linux 2.6 Kernel Capability LSM Module Local Privilege Elevation
Message-ID: <20041229140112.GA4812@IBM-BWN8ZTBWA01.austin.ibm.com>
References: <1104268915.20714.20.camel@krustophenia.net> <20041229102532.GB9926@outpost.ds9a.nl> <1104316379.2984.26.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1104316379.2984.26.camel@krustophenia.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lee Revell (rlrevell@joe-job.com):
> On Wed, 2004-12-29 at 11:25 +0100, bert hubert wrote:
> > On Tue, Dec 28, 2004 at 04:21:55PM -0500, Lee Revell wrote:
> > > Frank Barknecht pointed this out on linux-audio-dev, it's a horrible
> > > bug, I confirmed it in 2.6.10, and have not seen it mentioned on the
> > > list.
> > 
> > Although this sucks, it should be pointed out that it only grants root to
> > users able to force the loading of a certain module, aka 'root'.
> 
> Not force the loading of a certain module, but predict when it will be
> loaded.  Still, not easy to exploit.
> 
> Lee

Right, this means it is unsafe to have capabilities compiled as a
module, or at least loaded after any untrusted processes start.

The attached patch, which is a simple port of a fix by Chris Wright
(sent out a year ago), fixes this problem by having the dummy module
track capabilities.

-serge

Signed-off-by: Serge Hallyn <serue@us.ibm.com>

Index: linux-2.6.9/security/dummy.c
===================================================================
--- linux-2.6.9.orig/security/dummy.c	2004-12-24 05:33:33.000000000 -0600
+++ linux-2.6.9/security/dummy.c	2004-12-24 05:41:11.000000000 -0600
@@ -74,12 +74,10 @@ static int dummy_acct (struct file *file
 
 static int dummy_capable (struct task_struct *tsk, int cap)
 {
-	if (cap_is_fs_cap (cap) ? tsk->fsuid == 0 : tsk->euid == 0)
-		/* capability granted */
+	if (cap_raised (tsk->cap_effective, cap))
 		return 0;
-
-	/* capability denied */
-	return -EPERM;
+	else
+		return -EPERM;
 }
 
 static int dummy_sysctl (ctl_table * table, int op)
@@ -199,6 +197,10 @@ static void dummy_bprm_apply_creds (stru
 
 	current->suid = current->euid = current->fsuid = bprm->e_uid;
 	current->sgid = current->egid = current->fsgid = bprm->e_gid;
+
+	dummy_capget(current, &current->cap_effective,
+					&current->cap_inheritable,
+					&current->cap_permitted);
 }
 
 static int dummy_bprm_set_security (struct linux_binprm *bprm)
@@ -563,6 +565,9 @@ static int dummy_task_setuid (uid_t id0,
 
 static int dummy_task_post_setuid (uid_t id0, uid_t id1, uid_t id2, int flags)
 {
+	dummy_capget(current, &current->cap_effective,
+					&current->cap_inheritable,
+					&current->cap_permitted);
 	return 0;
 }
 

