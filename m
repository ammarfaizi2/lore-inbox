Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264305AbUA3WbY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 17:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264321AbUA3WbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 17:31:24 -0500
Received: from brmea-mail-4.Sun.COM ([192.18.98.36]:36607 "EHLO
	brmea-mail-4.sun.com") by vger.kernel.org with ESMTP
	id S264305AbUA3WbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 17:31:21 -0500
Date: Fri, 30 Jan 2004 14:31:06 -0800
From: Tim Hockin <thockin@sun.com>
To: Andrew Morton <akpm@osdl.org>
Cc: arjanv@redhat.com, thomas.schlichter@web.de, thoffman@arnor.net,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.2-rc2-mm2
Message-ID: <20040130223105.GC9155@sun.com>
Reply-To: thockin@sun.com
References: <20040130014108.09c964fd.akpm@osdl.org> <1075489136.5995.30.camel@moria.arnor.net> <200401302007.26333.thomas.schlichter@web.de> <1075490624.4272.7.camel@laptop.fenrus.com> <20040130114701.18aec4e8.akpm@osdl.org> <20040130201731.GY9155@sun.com> <20040130123301.70009427.akpm@osdl.org> <20040130211256.GZ9155@sun.com> <20040130140024.4b409335.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="54u2kuW9sGWg/X+X"
Content-Disposition: inline
In-Reply-To: <20040130140024.4b409335.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--54u2kuW9sGWg/X+X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 30, 2004 at 02:00:24PM -0800, Andrew Morton wrote:
> Tim Hockin <thockin@sun.com> wrote:
> >
> > In fact, here is a rough cut (would need a coupel exported syms, too).  The
> > lack of any way to handle errors bothers me.  printk and fail?  yeesh.
> 
> Seems to be a good way to go.  It doesn't seem likely that any other parts
> of the kernel will want to be setting the group ownership in this way.

How's the attached patch?  Do you need me to BK it, or is the patch enough?

-- 
Tim Hockin
Sun Microsystems, Linux Software Engineering
thockin@sun.com
All opinions are my own, not Sun's

--54u2kuW9sGWg/X+X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ngroups-nfsd+exports.diff"

===== kernel/sys.c 1.70 vs edited =====
--- 1.70/kernel/sys.c	Thu Jan 29 13:41:05 2004
+++ edited/kernel/sys.c	Fri Jan 30 14:27:09 2004
@@ -1132,6 +1132,8 @@
 	return NULL;
 }
 
+EXPORT_SYMBOL(groups_alloc);
+
 void groups_free(struct group_info *group_info)
 {
 	if (group_info->ngroups > NGROUPS_SMALL) {
@@ -1142,6 +1144,8 @@
 	kfree(group_info);
 }
 
+EXPORT_SYMBOL(groups_free);
+
 /* export the group_info to a user-space array */
 static int groups_to_user(gid_t __user *grouplist,
     struct group_info *group_info)
@@ -1251,6 +1255,8 @@
 
 	return 0;
 }
+
+EXPORT_SYMBOL(set_current_groups);
 
 asmlinkage long sys_getgroups(int gidsetsize, gid_t __user *grouplist)
 {
===== fs/nfsd/auth.c 1.3 vs edited =====
--- 1.3/fs/nfsd/auth.c	Thu Jan 29 13:40:50 2004
+++ edited/fs/nfsd/auth.c	Fri Jan 30 14:28:20 2004
@@ -10,15 +10,14 @@
 #include <linux/sunrpc/svcauth.h>
 #include <linux/nfsd/nfsd.h>
 
-extern asmlinkage long sys_setgroups(int gidsetsize, gid_t *grouplist);
-
 #define	CAP_NFSD_MASK (CAP_FS_MASK|CAP_TO_MASK(CAP_SYS_RESOURCE))
 void
 nfsd_setuser(struct svc_rqst *rqstp, struct svc_export *exp)
 {
 	struct svc_cred	*cred = &rqstp->rq_cred;
-	int		i;
+	int		i, j;
 	gid_t		groups[SVC_CRED_NGROUPS];
+	struct group_info *group_info;
 
 	if (exp->ex_flags & NFSEXP_ALLSQUASH) {
 		cred->cr_uid = exp->ex_anon_uid;
@@ -48,7 +47,13 @@
 			break;
 		groups[i] = group;
 	}
-	sys_setgroups(i, groups);
+	group_info = groups_alloc(i);
+	/* should be error checking, but we can't return ENOMEM! */
+	for (j = 0; j < i; j++)
+		GROUP_AT(group_info, j) = groups[j];
+	if (set_current_groups(group_info))
+		put_group_info(group_info);
+		/* should be error handling but we return void */
 
 	if ((cred->cr_uid)) {
 		cap_t(current->cap_effective) &= ~CAP_NFSD_MASK;

--54u2kuW9sGWg/X+X--
