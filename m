Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261237AbVCONtc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbVCONtc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 08:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261240AbVCONtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 08:49:31 -0500
Received: from mailfe06.swip.net ([212.247.154.161]:47275 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261237AbVCONrN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 08:47:13 -0500
X-T2-Posting-ID: icQHdNe7aEavrnKIz+aKnQ==
Subject: Re: Capabilities across execve
From: Alexander Nyberg <alexn@dsv.su.se>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <20050313032117.GA28536@shell0.pdx.osdl.net>
References: <1110627748.2376.6.camel@boxen>
	 <20050313032117.GA28536@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Tue, 15 Mar 2005 15:46:32 +0100
Message-Id: <1110897992.1146.56.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This makes it possible for a root-task to pass capabilities to
> > nonroot-task across execve. The root-task needs to change it's
> > cap_inheritable mask and set prctl(PR_SET_KEEPCAPS, 1) to pass on
> > capabilities. 
> 
> This overloads keepcaps, which could surprise to existing users.

current->keep_capabilities is set to 0 at each execve, however the
inheritable mask is passed on and therefor also the allowed effective +
permitted. I think this is very necessery if there's ever going to be a
real use of it. It's not worth anything getting a shell with every
capability if every new process you run afterwards will have its
capabilities dropped. If we do like this it will only be useful in
special circumstances when wanting to run _one_ application with some
special capability. The scope can be much more general. How about having
users that can run all the way CAP_SYS_NICE, would give every audio man
his realtime applications. This is certainly possible with capabilities
across execve and pam_cap (using a few caps myself right now).

> > At execve time the capabilities will be passed on to the new
> > nonroot-task and any non-inheritable effective and permitted
> > capabilities will be masked out.
> > The effective capability of the new nonroot-task will be set to the
> > maximum permitted.
> 
> What happens to eff on setuid() to non-root 

If KEEPCAPS is set the permitted and inheritable capabilities are still
there, the effective capabilities are cleared either way. 

> or restore to uid 0?

Full capabilities restored.

> What happens if you exec a setuid-root binary, 

Sets full permitted & effective, inheritable left as is.
This means that if the setuid-root binary does an execve to another
program cap_inheritable will take effect and the capabilities will be
the same as before calling the setuid-root binary. I doubt this is
common scenario however.

> or a setuid-nonroot binary?

capabilities unchanged

> How about ptrace?

I'll look into this part, but I don't see it changing anything here
right now. 

However I'm sure there are cases I've missed and I'm looking for them
right now. This patch is going to need a few good eyes.

> Here's the tests I use.

I've looked at some cases in this test suite but as It doesn't say much
more than "begin test 37" I have no idea of how to parse the output.

Updated patch.

===== security/commoncap.c 1.15 vs edited =====
--- 1.15/security/commoncap.c	2005-01-11 02:29:23 +01:00
+++ edited/security/commoncap.c	2005-03-15 14:45:36 +01:00
@@ -111,13 +111,19 @@ void cap_capset_set (struct task_struct 
 
 int cap_bprm_set_security (struct linux_binprm *bprm)
 {
-	/* Copied from fs/exec.c:prepare_binprm. */
-
-	/* We don't have VFS support for capabilities yet */
-	cap_clear (bprm->cap_inheritable);
-	cap_clear (bprm->cap_permitted);
-	cap_clear (bprm->cap_effective);
+	struct task_struct *p = current;
 
+	/*
+	 * Mask out the non-inheritable capabilities.
+	 * Note: init has a zero mask of cap_inheritable, so a root-task will not
+	 * pass on any capabilities unless explicitly told to do so. If a non-zero
+	 * inheritable mask is passed to a positive uid task it will then pass on 
+	 * its inheritable mask to all children unless told otherwise.
+	 */
+	bprm->cap_permitted = cap_intersect(p->cap_permitted, p->cap_inheritable);
+	bprm->cap_effective = cap_intersect(p->cap_effective, p->cap_inheritable);
+	bprm->cap_inheritable = p->cap_inheritable;
+	
 	/*  To support inheritance of root-permissions and suid-root
 	 *  executables under compatibility mode, we raise all three
 	 *  capability sets for the file.
@@ -127,7 +133,7 @@ int cap_bprm_set_security (struct linux_
 	 */
 
 	if (!issecure (SECURE_NOROOT)) {
-		if (bprm->e_uid == 0 || current->uid == 0) {
+		if (bprm->e_uid == 0 || p->uid == 0) {
 			cap_set_full (bprm->cap_inheritable);
 			cap_set_full (bprm->cap_permitted);
 		}
@@ -139,13 +145,9 @@ int cap_bprm_set_security (struct linux_
 
 void cap_bprm_apply_creds (struct linux_binprm *bprm, int unsafe)
 {
-	/* Derived from fs/exec.c:compute_creds. */
-	kernel_cap_t new_permitted, working;
+	kernel_cap_t new_permitted;
 
 	new_permitted = cap_intersect (bprm->cap_permitted, cap_bset);
-	working = cap_intersect (bprm->cap_inheritable,
-				 current->cap_inheritable);
-	new_permitted = cap_combine (new_permitted, working);
 
 	if (bprm->e_uid != current->uid || bprm->e_gid != current->gid ||
 	    !cap_issubset (new_permitted, current->cap_permitted)) {
@@ -166,14 +168,15 @@ void cap_bprm_apply_creds (struct linux_
 	current->suid = current->euid = current->fsuid = bprm->e_uid;
 	current->sgid = current->egid = current->fsgid = bprm->e_gid;
 
-	/* For init, we want to retain the capabilities set
-	 * in the init_task struct. Thus we skip the usual
-	 * capability rules */
-	if (current->pid != 1) {
-		current->cap_permitted = new_permitted;
-		current->cap_effective =
-		    cap_intersect (new_permitted, bprm->cap_effective);
-	}
+	current->cap_permitted = new_permitted;
+	/*
+	 * Is this a root task that did seteuid before execve? if so
+	 * it wanted its effective permissions dropped.
+	 */
+	if (current->euid && current->uid == 0)
+		cap_clear(current->cap_effective);
+	else	
+		current->cap_effective = new_permitted;
 
 	/* AUD: Audit candidate if current->cap_effective is set */
 


