Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263775AbUA3VO0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 16:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263909AbUA3VO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 16:14:26 -0500
Received: from nwkea-mail-1.sun.com ([192.18.42.13]:36746 "EHLO
	nwkea-mail-1.sun.com") by vger.kernel.org with ESMTP
	id S263775AbUA3VOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 16:14:23 -0500
Date: Fri, 30 Jan 2004 13:12:56 -0800
From: Tim Hockin <thockin@sun.com>
To: Andrew Morton <akpm@osdl.org>
Cc: arjanv@redhat.com, thomas.schlichter@web.de, thoffman@arnor.net,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.2-rc2-mm2
Message-ID: <20040130211256.GZ9155@sun.com>
Reply-To: thockin@sun.com
References: <20040130014108.09c964fd.akpm@osdl.org> <1075489136.5995.30.camel@moria.arnor.net> <200401302007.26333.thomas.schlichter@web.de> <1075490624.4272.7.camel@laptop.fenrus.com> <20040130114701.18aec4e8.akpm@osdl.org> <20040130201731.GY9155@sun.com> <20040130123301.70009427.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040130123301.70009427.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 30, 2004 at 12:33:01PM -0800, Andrew Morton wrote:
> static long do_setgroups(int gidsetsize, gid_t __user *user_grouplist,
> 			gid_t *kern_grouplist)
> {
> }

> asmlinkage long sys_setgroups(int gidsetsize, gid_t __user *grouplist)
> {
> 	return do_setgroups(gidsetsize, grouplist, NULL);
> }
> 
> long kern_setgroups(int gidsetsize, gid_t *grouplist)
> {
> 	return do_setgroups(gidsetsize, NULL, grouplist);
> }

I guess that works.  It saves a bit of duplicate code at the cost of said
grubbiness.  Is that really preferred over a parallel to sys_setgroups():
	int kern_setgroups(int gidsetsize, gid_t *grouplist)
or simpler:

nfsd code:
	/* build up the array of SVC_CRED_NGROUPS */
	group_info = groups_alloc(SVC_CRED_NGROUPS);
	/* error check */
	/* copy local array into group_info */
	retval = set_current_groups(group_info);
	/* error check */

The nfsd code does not need to check CAP_SETGID or > NGROUPS_MAX, really.
Interestingly, nfsd_setuser returns void, so any error checking is moot.
Bad news, there.

set_current_groups() was extracted so that any place in kernel that needs to
set the groups can do so properly.  I suggest that I just clean it up as
that, or add a kern_setgroups() that encapsulates the above.  It will be
about 12 lines of code.

In fact, here is a rough cut (would need a coupel exported syms, too).  The
lack of any way to handle errors bothers me.  printk and fail?  yeesh.


===== fs/nfsd/auth.c 1.3 vs edited =====
--- 1.3/fs/nfsd/auth.c	Thu Jan 29 13:40:50 2004
+++ edited/fs/nfsd/auth.c	Fri Jan 30 13:11:21 2004
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
@@ -48,7 +47,12 @@
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
 
 	if ((cred->cr_uid)) {
 		cap_t(current->cap_effective) &= ~CAP_NFSD_MASK;



-- 
Tim Hockin
Sun Microsystems, Linux Software Engineering
thockin@sun.com
All opinions are my own, not Sun's
