Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262196AbSJ2T2D>; Tue, 29 Oct 2002 14:28:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262207AbSJ2T1v>; Tue, 29 Oct 2002 14:27:51 -0500
Received: from nwkea-mail-1.sun.com ([192.18.42.13]:16033 "EHLO
	nwkea-mail-1.sun.com") by vger.kernel.org with ESMTP
	id <S262196AbSJ2T0g>; Tue, 29 Oct 2002 14:26:36 -0500
From: Timothy Hockin <th122948@scl2.sfbay.sun.com>
Message-Id: <200210291932.g9TJWlC30619@scl2.sfbay.sun.com>
Subject: [BK PATCH 3/4] fix NGROUPS hard limit (resend)
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 29 Oct 2002 11:32:47 -0800 (PST)
Reply-To: thockin@sun.com
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.810   -> 1.811  
#	include/linux/sunrpc/svcauth.h	1.4     -> 1.5    
#	net/sunrpc/svcauth_unix.c	1.7     -> 1.8    
#	      fs/nfsd/auth.c	1.1     -> 1.2    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/21	thockin@freakshow.cobalt.com	1.811
# fix usage of NGROUPS in nfsd and svcauth
# --------------------------------------------
#
diff -Nru a/fs/nfsd/auth.c b/fs/nfsd/auth.c
--- a/fs/nfsd/auth.c	Mon Oct 21 17:14:34 2002
+++ b/fs/nfsd/auth.c	Mon Oct 21 17:14:34 2002
@@ -10,12 +10,15 @@
 #include <linux/sunrpc/svcauth.h>
 #include <linux/nfsd/nfsd.h>
 
+extern asmlinkage long sys_setgroups(int gidsetsize, gid_t *grouplist);
+
 #define	CAP_NFSD_MASK (CAP_FS_MASK|CAP_TO_MASK(CAP_SYS_RESOURCE))
 void
 nfsd_setuser(struct svc_rqst *rqstp, struct svc_export *exp)
 {
 	struct svc_cred	*cred = &rqstp->rq_cred;
 	int		i;
+	gid_t		groups[SVC_CRED_NGROUPS];
 
 	if (rqstp->rq_userset)
 		return;
@@ -29,7 +32,7 @@
 			cred->cr_uid = exp->ex_anon_uid;
 		if (!cred->cr_gid)
 			cred->cr_gid = exp->ex_anon_gid;
-		for (i = 0; i < NGROUPS; i++)
+		for (i = 0; i < SVC_CRED_NGROUPS; i++)
 			if (!cred->cr_groups[i])
 				cred->cr_groups[i] = exp->ex_anon_gid;
 	}
@@ -42,13 +45,13 @@
 		current->fsgid = cred->cr_gid;
 	else
 		current->fsgid = exp->ex_anon_gid;
-	for (i = 0; i < NGROUPS; i++) {
+	for (i = 0; i < SVC_CRED_NGROUPS; i++) {
 		gid_t group = cred->cr_groups[i];
 		if (group == (gid_t) NOGROUP)
 			break;
-		current->groups[i] = group;
+		groups[i] = group;
 	}
-	current->ngroups = i;
+	sys_setgroups(i, groups);
 
 	if ((cred->cr_uid)) {
 		cap_t(current->cap_effective) &= ~CAP_NFSD_MASK;
diff -Nru a/include/linux/sunrpc/svcauth.h b/include/linux/sunrpc/svcauth.h
--- a/include/linux/sunrpc/svcauth.h	Mon Oct 21 17:14:34 2002
+++ b/include/linux/sunrpc/svcauth.h	Mon Oct 21 17:14:34 2002
@@ -14,10 +14,11 @@
 #include <linux/sunrpc/msg_prot.h>
 #include <linux/sunrpc/cache.h>
 
+#define SVC_CRED_NGROUPS	32
 struct svc_cred {
 	uid_t			cr_uid;
 	gid_t			cr_gid;
-	gid_t			cr_groups[NGROUPS];
+	gid_t			cr_groups[SVC_CRED_NGROUPS];
 };
 
 struct svc_rqst;		/* forward decl */
diff -Nru a/net/sunrpc/svcauth_unix.c b/net/sunrpc/svcauth_unix.c
--- a/net/sunrpc/svcauth_unix.c	Mon Oct 21 17:14:34 2002
+++ b/net/sunrpc/svcauth_unix.c	Mon Oct 21 17:14:34 2002
@@ -392,9 +392,9 @@
 	slen = ntohl(*bufp++);			/* gids length */
 	if (slen > 16 || (len -= slen + 2) < 0)
 		goto badcred;
-	for (i = 0; i < NGROUPS && i < slen; i++)
+	for (i = 0; i < SVC_CRED_NGROUPS && i < slen; i++)
 		cred->cr_groups[i] = ntohl(*bufp++);
-	if (i < NGROUPS)
+	if (i < SVC_CRED_NGROUPS)
 		cred->cr_groups[i] = NOGROUP;
 	bufp += (slen - i);
 
