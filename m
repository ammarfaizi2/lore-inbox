Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262270AbSJKB3H>; Thu, 10 Oct 2002 21:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262269AbSJKB2N>; Thu, 10 Oct 2002 21:28:13 -0400
Received: from patan.Sun.COM ([192.18.98.43]:52363 "EHLO patan.sun.com")
	by vger.kernel.org with ESMTP id <S262265AbSJKB2H>;
	Thu, 10 Oct 2002 21:28:07 -0400
From: Timothy Hockin <th122948@scl2.sfbay.sun.com>
Message-Id: <200210110133.g9B1XnU18440@scl2.sfbay.sun.com>
Subject: [BK PATCH 3/4] fix NGROUPS hard limit
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Thu, 10 Oct 2002 18:33:48 -0700 (PDT)
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
#	           ChangeSet	1.740   -> 1.741  
#	net/sunrpc/svcauth.c	1.4     -> 1.5    
#	include/linux/sunrpc/svcauth.h	1.2     -> 1.3    
#	      fs/nfsd/auth.c	1.1     -> 1.2    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/10	thockin@freakshow.cobalt.com	1.741
# fix usage of NGROUPS in nfsd and svcauth
# --------------------------------------------
#
diff -Nru a/fs/nfsd/auth.c b/fs/nfsd/auth.c
--- a/fs/nfsd/auth.c	Thu Oct 10 18:19:50 2002
+++ b/fs/nfsd/auth.c	Thu Oct 10 18:19:50 2002
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
--- a/include/linux/sunrpc/svcauth.h	Thu Oct 10 18:19:50 2002
+++ b/include/linux/sunrpc/svcauth.h	Thu Oct 10 18:19:50 2002
@@ -13,11 +13,13 @@
 
 #include <linux/sunrpc/msg_prot.h>
 
+#define SVC_CRED_NGROUPS	32
+
 struct svc_cred {
 	rpc_authflavor_t	cr_flavor;
 	uid_t			cr_uid;
 	gid_t			cr_gid;
-	gid_t			cr_groups[NGROUPS];
+	gid_t			cr_groups[SVC_CRED_NGROUPS];
 };
 
 struct svc_rqst;		/* forward decl */
diff -Nru a/net/sunrpc/svcauth.c b/net/sunrpc/svcauth.c
--- a/net/sunrpc/svcauth.c	Thu Oct 10 18:19:50 2002
+++ b/net/sunrpc/svcauth.c	Thu Oct 10 18:19:50 2002
@@ -136,9 +136,9 @@
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
 
