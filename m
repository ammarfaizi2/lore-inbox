Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262812AbSKNXTZ>; Thu, 14 Nov 2002 18:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265320AbSKNXTZ>; Thu, 14 Nov 2002 18:19:25 -0500
Received: from patan.Sun.COM ([192.18.98.43]:36012 "EHLO patan.sun.com")
	by vger.kernel.org with ESMTP id <S262812AbSKNXTW>;
	Thu, 14 Nov 2002 18:19:22 -0500
From: Timothy Hockin <th122948@scl2.sfbay.sun.com>
Message-Id: <200211142326.gAENQFn31784@scl2.sfbay.sun.com>
Subject: [BK PATCH 2/2] Remove NGROUPS hardlimit (resend w/o qsort)
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Thu, 14 Nov 2002 15:26:15 -0800 (PST)
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
#	           ChangeSet	1.854   -> 1.855  
#	include/linux/sunrpc/svcauth.h	1.4     -> 1.5    
#	net/sunrpc/svcauth_unix.c	1.9     -> 1.10   
#	      fs/nfsd/auth.c	1.1     -> 1.2    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/11/11	thockin@freakshow.cobalt.com	1.855
# fix usage of NGROUPS in nfsd and svcauth
# --------------------------------------------
#
diff -Nru a/fs/nfsd/auth.c b/fs/nfsd/auth.c
--- a/fs/nfsd/auth.c	Mon Nov 11 17:36:51 2002
+++ b/fs/nfsd/auth.c	Mon Nov 11 17:36:51 2002
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
--- a/include/linux/sunrpc/svcauth.h	Mon Nov 11 17:36:51 2002
+++ b/include/linux/sunrpc/svcauth.h	Mon Nov 11 17:36:51 2002
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
--- a/net/sunrpc/svcauth_unix.c	Mon Nov 11 17:36:51 2002
+++ b/net/sunrpc/svcauth_unix.c	Mon Nov 11 17:36:51 2002
@@ -401,11 +401,11 @@
 	if (slen > 16 || (len -= (slen + 2)*4) < 0)
 		goto badcred;
 	for (i = 0; i < slen; i++)
-		if (i < NGROUPS)
+		if (i < SVC_CRED_NGROUPS)
 			cred->cr_groups[i] = ntohl(svc_getu32(argv));
 		else
 			svc_getu32(argv);
-	if (i < NGROUPS)
+	if (i < SVC_CRED_NGROUPS)
 		cred->cr_groups[i] = NOGROUP;
 
 	if (svc_getu32(argv) != RPC_AUTH_NULL || svc_getu32(argv) != 0) {
