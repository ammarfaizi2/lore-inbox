Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263589AbUDUS2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263589AbUDUS2d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 14:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263596AbUDUS2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 14:28:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:20446 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263589AbUDUS2a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 14:28:30 -0400
Date: Wed, 21 Apr 2004 11:28:27 -0700
From: Chris Wright <chrisw@osdl.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Andy Lutomirski <luto@myrealbox.com>, Chris Wright <chrisw@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       James Morris <jmorris@redhat.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: compute_creds fixup in -mm
Message-ID: <20040421112827.O21045@build.pdx.osdl.net>
References: <20040421010621.L22989@build.pdx.osdl.net> <4086AEFC.5010002@myrealbox.com> <1082571199.9213.61.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1082571199.9213.61.camel@moss-spartans.epoch.ncsc.mil>; from sds@epoch.ncsc.mil on Wed, Apr 21, 2004 at 02:13:19PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Stephen Smalley (sds@epoch.ncsc.mil) wrote:
> On Wed, 2004-04-21 at 13:27, Andy Lutomirski wrote:
> > This doesn't fix selinux, though -- its apply_creds hook just blindly calls
> > commoncap's.  In fact, this breaks all attempts to get nested capability modules
> > right.  The problem is that, AFAICS, not only does ptrace_detach not take
> > task_lock, _exit() doesn't either.  So you get an equivalent race for the shared
> > state check.  I see two ways to fix that:
> 
> I didn't see Chris' patch.  I assume that the worst case is unexpected
> program failure due to lack of capability, right?  The SELinux security

The opposite.  You'd get a program with non-root euid, but full
capability set, and AT_SECURE set false.  My patch is below.

--- a/security/commoncap.c~compute_creds-lock	2004-04-21 00:54:34.000000000 -0700
+++ b/security/commoncap.c	2004-04-21 01:01:00.000000000 -0700
@@ -135,28 +135,26 @@
 
 	task_lock(current);
 
-	if (bprm->e_uid != current->uid || bprm->e_gid != current->gid) {
+	if (bprm->e_uid != current->uid || bprm->e_gid != current->gid ||
+	    !cap_issubset (new_permitted, current->cap_permitted)) {
 		current->mm->dumpable = 0;
 
-		if (must_not_trace_exec(current) && !capable(CAP_SETUID)) {
-			bprm->e_uid = current->uid;
-			bprm->e_gid = current->gid;
+		if (must_not_trace_exec(current)) {
+			if (!capable(CAP_SETUID)) {
+				bprm->e_uid = current->uid;
+				bprm->e_gid = current->gid;
+			}
+			if (!capable (CAP_SETPCAP)) {
+				new_permitted = cap_intersect (new_permitted,
+							current->cap_permitted);
+			}
+
 		}
 	}
 
 	current->suid = current->euid = current->fsuid = bprm->e_uid;
 	current->sgid = current->egid = current->fsgid = bprm->e_gid;
 
-	if (!cap_issubset (new_permitted, current->cap_permitted)) {
-		current->mm->dumpable = 0;
-
-		if (must_not_trace_exec (current) && !capable (CAP_SETPCAP)) {
-			new_permitted = cap_intersect (new_permitted,
-						       current->
-						       cap_permitted);
-		}
-	}
-
 	/* For init, we want to retain the capabilities set
 	 * in the init_task struct. Thus we skip the usual
 	 * capability rules */


