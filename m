Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264361AbUA3XHR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 18:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264363AbUA3XHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 18:07:17 -0500
Received: from fw.osdl.org ([65.172.181.6]:61121 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264361AbUA3XHF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 18:07:05 -0500
Date: Fri, 30 Jan 2004 15:08:19 -0800
From: Andrew Morton <akpm@osdl.org>
To: thockin@sun.com
Cc: arjanv@redhat.com, thomas.schlichter@web.de, thoffman@arnor.net,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.2-rc2-mm2
Message-Id: <20040130150819.2425386b.akpm@osdl.org>
In-Reply-To: <20040130223105.GC9155@sun.com>
References: <20040130014108.09c964fd.akpm@osdl.org>
	<1075489136.5995.30.camel@moria.arnor.net>
	<200401302007.26333.thomas.schlichter@web.de>
	<1075490624.4272.7.camel@laptop.fenrus.com>
	<20040130114701.18aec4e8.akpm@osdl.org>
	<20040130201731.GY9155@sun.com>
	<20040130123301.70009427.akpm@osdl.org>
	<20040130211256.GZ9155@sun.com>
	<20040130140024.4b409335.akpm@osdl.org>
	<20040130223105.GC9155@sun.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Hockin <thockin@sun.com> wrote:
>
> On Fri, Jan 30, 2004 at 02:00:24PM -0800, Andrew Morton wrote:
> > Tim Hockin <thockin@sun.com> wrote:
> > >
> > > In fact, here is a rough cut (would need a coupel exported syms, too).  The
> > > lack of any way to handle errors bothers me.  printk and fail?  yeesh.
> > 
> > Seems to be a good way to go.  It doesn't seem likely that any other parts
> > of the kernel will want to be setting the group ownership in this way.
> 
> How's the attached patch?

OK.  But we really should check that error code.  I'll see your patch and
raise you one.

I think this is right - the NFSEXP_ALLSQUASH case appears to be clearing
all groups.  When this settles down we need to run it all by Neil.

Do we need to handle the return value from set_current_groups(), or should
that guy be simply returning void?


diff -puN fs/nfsd/auth.c~increase-NGROUPS-nfsd-cleanup-checks fs/nfsd/auth.c
--- 25/fs/nfsd/auth.c~increase-NGROUPS-nfsd-cleanup-checks	Fri Jan 30 15:03:55 2004
+++ 25-akpm/fs/nfsd/auth.c	Fri Jan 30 15:06:43 2004
@@ -11,13 +11,25 @@
 #include <linux/nfsd/nfsd.h>
 
 #define	CAP_NFSD_MASK (CAP_FS_MASK|CAP_TO_MASK(CAP_SYS_RESOURCE))
-void
-nfsd_setuser(struct svc_rqst *rqstp, struct svc_export *exp)
+
+int nfsd_setuser(struct svc_rqst *rqstp, struct svc_export *exp)
 {
 	struct svc_cred	*cred = &rqstp->rq_cred;
-	int		i, j;
-	gid_t		groups[SVC_CRED_NGROUPS];
-	struct group_info *group_info;
+	struct group_info *group_info = NULL;
+	int ngroups;
+	int i;
+	int ret;
+
+	ngroups = 0;
+	if (!(exp->ex_flags & NFSEXP_ALLSQUASH)) {
+		for (i = 0; i < SVC_CRED_NGROUPS; i++) {
+			if (cred->cr_groups[i])
+				ngroups++;
+		}
+	}
+	group_info = groups_alloc(ngroups);
+	if (group_info == NULL)
+		return -ENOMEM;
 
 	if (exp->ex_flags & NFSEXP_ALLSQUASH) {
 		cred->cr_uid = exp->ex_anon_uid;
@@ -41,25 +53,24 @@ nfsd_setuser(struct svc_rqst *rqstp, str
 		current->fsgid = cred->cr_gid;
 	else
 		current->fsgid = exp->ex_anon_gid;
+
 	for (i = 0; i < SVC_CRED_NGROUPS; i++) {
 		gid_t group = cred->cr_groups[i];
 		if (group == (gid_t) NOGROUP)
 			break;
-		groups[i] = group;
+		GROUP_AT(group_info, i) = group;
 	}
-	group_info = groups_alloc(i);
-	/* should be error checking, but we can't return ENOMEM! */
-	for (j = 0; j < i; j++)
-		GROUP_AT(group_info, j) = groups[j];
-	if (set_current_groups(group_info))
-		put_group_info(group_info);
-		/* should be error handling but we return void */
 
-	if ((cred->cr_uid)) {
-		cap_t(current->cap_effective) &= ~CAP_NFSD_MASK;
+	ret = set_current_groups(group_info);
+	if (ret == 0) {
+		if ((cred->cr_uid)) {
+			cap_t(current->cap_effective) &= ~CAP_NFSD_MASK;
+		} else {
+			cap_t(current->cap_effective) |= (CAP_NFSD_MASK &
+							current->cap_permitted);
+		}
 	} else {
-		cap_t(current->cap_effective) |= (CAP_NFSD_MASK &
-						  current->cap_permitted);
+		put_group_info(group_info);
 	}
-
+	return ret;
 }
diff -puN include/linux/nfsd/auth.h~increase-NGROUPS-nfsd-cleanup-checks include/linux/nfsd/auth.h
--- 25/include/linux/nfsd/auth.h~increase-NGROUPS-nfsd-cleanup-checks	Fri Jan 30 15:03:55 2004
+++ 25-akpm/include/linux/nfsd/auth.h	Fri Jan 30 15:03:55 2004
@@ -21,7 +21,7 @@
  * Set the current process's fsuid/fsgid etc to those of the NFS
  * client user
  */
-void		nfsd_setuser(struct svc_rqst *, struct svc_export *);
+int nfsd_setuser(struct svc_rqst *, struct svc_export *);
 
 #endif /* __KERNEL__ */
 #endif /* LINUX_NFSD_AUTH_H */

_

