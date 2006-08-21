Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750990AbWHUUhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbWHUUhO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 16:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750707AbWHUUhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 16:37:14 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:41369 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750985AbWHUUhM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 16:37:12 -0400
Date: Mon, 21 Aug 2006 15:36:56 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Joshua Brindle <method@gentoo.org>, "Serge E. Hallyn" <serue@us.ibm.com>,
       "Serge E. Hallyn" <serge@hallyn.com>,
       Nicholas Miell <nmiell@comcast.net>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       lkml <linux-kernel@vger.kernel.org>,
       linux-security-module@vger.kernel.org, chrisw@sous-sol.org
Subject: Re: [RFC] [PATCH] file posix capabilities
Message-ID: <20060821203656.GA22769@sergelap.austin.ibm.com>
References: <m1r6zirgst.fsf@ebiederm.dsl.xmission.com> <20060815020647.GB16220@sergelap.austin.ibm.com> <m13bbyr80e.fsf@ebiederm.dsl.xmission.com> <1155615736.2468.12.camel@entropy> <20060815114946.GA7267@vino.hallyn.com> <1155658688.1780.33.camel@moss-spartans.epoch.ncsc.mil> <20060816024200.GD15241@sergelap.austin.ibm.com> <1155734401.18911.33.camel@moss-spartans.epoch.ncsc.mil> <44E45A70.8090801@gentoo.org> <1155817698.21070.18.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155817698.21070.18.camel@moss-spartans.epoch.ncsc.mil>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Smalley (sds@tycho.nsa.gov):
> On Thu, 2006-08-17 at 08:00 -0400, Joshua Brindle wrote:
> > Stephen Smalley wrote:
> > > On Tue, 2006-08-15 at 21:42 -0500, Serge E. Hallyn wrote:
> > >   
> > > <snip>
> > >> Very good point.  Preventing communication channels i.e. through signals
> > >> isn't a concern, but user hallyn ptracing himself running /bin/passwd
> > >> certainly is.
> > >>     
> > >
> > > Actually, ptrace already performs a capability comparison (cap_ptrace).
> > > Wrt signals, it wasn't the communication channel that concerned me but
> > > the ability to interfere with the operation of a process running in the
> > > same uid but different capabilities, like stopping it at a critical
> > > point.  Likewise with many other task hooks - you wouldn't want to be
> > > able to depress the priority of a process running with greater
> > > capabilities.
> > >
> > >   
> > On this point, what about environment tampering of processes with caps? 
> > LD_PRELOAD=my_bad_lib.so /usr/bin/passwd. glibc atsecure logic would 
> > have to be updated to do a capability comparison.
> 
> That's the bprm_secureexec logic change that has already been mentioned;
> that determines the AT_SECURE value, and glibc then just acts based on
> that value provided by the kernel.  Just a matter of extending
> cap_bprm_secureexec to compare the capability sets.  Already on Serge's
> todo list, but it is necessary for this to be a safe change, and should
> happen before this patch goes anywhere (even -mm), IMHO.

Does the following seem a reasonable way to handle secureexec in the
face of file caps?

Seems like it should work so long as we don't have to worry about the
bprm changing partway through exec.  This should avoid the need to store
the old capabilities.

Unless I've got my head screwed on completely backward...

thanks,
-serge

(note - Still need at least a signals patch on top of this before the
file caps could be safe for use)

>From e791e196cda84743e805167c11e424f4132aa2a4 Mon Sep 17 00:00:00 2001
From: Serge E. Hallyn <serue@us.ibm.com>
Date: Mon, 21 Aug 2006 14:54:17 -0500
Subject: [PATCH 1/1] security: handle secureexec with filesystem capabilities

A secure exec is required if euid!=uid, and, correspondingly,
if the executable's file capability set was not empty and the
process is not owned by (real uid) root.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
---
 security/commoncap.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index 6bf030d..b1777a9 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -265,11 +265,15 @@ void cap_bprm_apply_creds (struct linux_
 
 int cap_bprm_secureexec (struct linux_binprm *bprm)
 {
-	/* If/when this module is enhanced to incorporate capability
-	   bits on files, the test below should be extended to also perform a 
-	   test between the old and new capability sets.  For now,
-	   it simply preserves the legacy decision algorithm used by
-	   the old userland. */
+	if (current->uid != 0) {
+		if (!cap_isclear(bprm->cap_effective))
+			return 1;
+		if (!cap_isclear(bprm->cap_permitted))
+			return 1;
+		if (!cap_isclear(bprm->cap_inheritable))
+			return 1;
+	}
+
 	return (current->euid != current->uid ||
 		current->egid != current->gid);
 }
-- 
1.4.2

