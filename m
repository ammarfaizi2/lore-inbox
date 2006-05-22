Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbWEVMjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbWEVMjY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 08:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbWEVMjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 08:39:24 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:42177 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750794AbWEVMjX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 08:39:23 -0400
Date: Mon, 22 May 2006 07:39:19 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Sam Vilain <sam@vilain.net>, "Serge E. Hallyn" <serue@us.ibm.com>,
       linux-kernel@vger.kernel.org, dev@sw.ru, herbert@13thfloor.at,
       devel@openvz.org, xemul@sw.ru, Dave Hansen <haveblue@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>, Cedric Le Goater <clg@fr.ibm.com>
Subject: Re: [PATCH 1/9] namespaces: add nsproxy
Message-ID: <20060522123919.GC6025@sergelap.austin.ibm.com>
References: <20060518154700.GA28344@sergelap.austin.ibm.com> <20060518154837.GB28344@sergelap.austin.ibm.com> <4470F7FD.4030608@vilain.net> <m11wunne30.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m11wunne30.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eric W. Biederman (ebiederm@xmission.com):
> Sam Vilain <sam@vilain.net> writes:
> 
> > Serge E. Hallyn wrote:
> >
> >>@@ -1585,7 +1591,15 @@ asmlinkage long sys_unshare(unsigned lon
> >> 
> >> 	if (new_fs || new_ns || new_sigh || new_mm || new_fd || new_ulist) {
> >> 
> >>+		old_nsproxy = current->nsproxy;
> >>+		new_nsproxy = dup_namespaces(old_nsproxy);
> >>+		if (!new_nsproxy) {
> >>+			err = -ENOMEM;
> >>+			goto bad_unshare_cleanup_semundo;
> >>+		}
> >>+
> >> 		task_lock(current);
> >>  
> >>
> >
> > We'll get lots of duplicate nsproxy structures before we move all of the
> > pointers for those subsystems into it. Do we need to dup namespaces on
> > all of those conditions?
> 
> Ugh.  Good catch.  The new nsproxy needs to be just for the fs and the uts
> namespace.  
> 
> I guess that means that test should be moved up a few lines.

Oh.  Yeah.  It didn't look odd to me bc it's about the number of
namespaces we are *going* to have  :)

Fix follows:

Subject: [PATCH] uts: copy nsproxy only when needed.
From: Serge Hallyn <serue@us.ibm.com>

The nsproxy was being copied in unshare() when anything was being
unshared, even if it was something not referenced from nsproxy.
This should end up in some cases with far more memory usage than
necessary.

Signed-off-by: Serge Hallyn <serue@us.ibm.com>

---

 kernel/fork.c |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)

74d1068458c62302ac8ed38e38a57b692580662f
diff --git a/kernel/fork.c b/kernel/fork.c
index cdc549e..9278a68 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1559,7 +1559,7 @@ asmlinkage long sys_unshare(unsigned lon
 	struct mm_struct *mm, *new_mm = NULL, *active_mm = NULL;
 	struct files_struct *fd, *new_fd = NULL;
 	struct sem_undo_list *new_ulist = NULL;
-	struct nsproxy *new_nsproxy, *old_nsproxy;
+	struct nsproxy *new_nsproxy = NULL, *old_nsproxy = NULL;
 	struct uts_namespace *uts, *new_uts = NULL;
 
 	check_unshare_flags(&unshare_flags);
@@ -1587,18 +1587,24 @@ asmlinkage long sys_unshare(unsigned lon
 	if ((err = unshare_utsname(unshare_flags, &new_uts)))
 		goto bad_unshare_cleanup_semundo;
 
-	if (new_fs || new_ns || new_sigh || new_mm || new_fd || new_ulist ||
-				new_uts) {
-
+	if (new_ns || new_uts) {
 		old_nsproxy = current->nsproxy;
 		new_nsproxy = dup_namespaces(old_nsproxy);
 		if (!new_nsproxy) {
 			err = -ENOMEM;
 			goto bad_unshare_cleanup_uts;
 		}
+	}
+
+	if (new_fs || new_ns || new_sigh || new_mm || new_fd || new_ulist ||
+				new_uts) {
 
 		task_lock(current);
-		current->nsproxy = new_nsproxy;
+
+		if (new_nsproxy) {
+			current->nsproxy = new_nsproxy;
+			new_nsproxy = old_nsproxy;
+		}
 
 		if (new_fs) {
 			fs = current->fs;
@@ -1640,9 +1646,11 @@ asmlinkage long sys_unshare(unsigned lon
 		}
 
 		task_unlock(current);
-		put_nsproxy(old_nsproxy);
 	}
 
+	if (new_nsproxy)
+		put_nsproxy(new_nsproxy);
+
 bad_unshare_cleanup_uts:
 	if (new_uts)
 		put_uts_ns(new_uts);
-- 
1.1.6
