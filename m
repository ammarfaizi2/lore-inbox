Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932397AbWGYBzk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbWGYBzk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 21:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbWGYBzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 21:55:40 -0400
Received: from mail.suse.de ([195.135.220.2]:12524 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932394AbWGYBzc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 21:55:32 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 25 Jul 2006 11:54:52 +1000
Message-Id: <1060725015452.21969@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 006 of 9] knfsd: Remove nfsd_versbits as intermediate storage for desired versions.
References: <20060725114207.21779.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We have an array 'nfsd_version' which lists the available versions
of nfsd, and 'nfsd_versions' (poor choice there :-() which lists
the currently active versions.

Then we have a bitmap - nfsd_versbits which says which versions are
wanted.  The bits in this bitset cause content to be copied from
nfsd_version to nfsd_versions when nfsd starts.

This patch removes nfsd_versbits and moves information directly from
nfsd_version to nfsd_versions when requests for version changes arrive.

Note that this doesn't make it possible to change versions while the
server is running.  This is because serv->sv_xdrsize is calculated when
a service is created, and used when threads are created, and xdrsize
depends on the active versions.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/nfsctl.c             |   18 +++----
 ./fs/nfsd/nfssvc.c             |   93 ++++++++++++++++++++++-------------------
 ./include/linux/nfsd/nfsd.h    |    4 +
 ./include/linux/nfsd/syscall.h |   17 -------
 4 files changed, 62 insertions(+), 70 deletions(-)

diff .prev/fs/nfsd/nfsctl.c ./fs/nfsd/nfsctl.c
--- .prev/fs/nfsd/nfsctl.c	2006-07-24 15:17:36.000000000 +1000
+++ ./fs/nfsd/nfsctl.c	2006-07-24 15:17:36.000000000 +1000
@@ -35,8 +35,6 @@
 
 #include <asm/uaccess.h>
 
-unsigned int nfsd_versbits = ~0;
-
 /*
  *	We have a single directory with 9 nodes in it.
  */
@@ -372,6 +370,10 @@ static ssize_t write_versions(struct fil
 
 	if (size>0) {
 		if (nfsd_serv)
+			/* Cannot change versions without updating
+			 * nfsd_serv->sv_xdrsize, and reallocing
+			 * rq_argp and rq_resp
+			 */
 			return -EBUSY;
 		if (buf[size-1] != '\n')
 			return -EINVAL;
@@ -390,10 +392,7 @@ static ssize_t write_versions(struct fil
 			case 2:
 			case 3:
 			case 4:
-				if (sign != '-')
-					NFSCTL_VERSET(nfsd_versbits, num);
-				else
-					NFSCTL_VERUNSET(nfsd_versbits, num);
+				nfsd_vers(num, sign == '-' ? NFSD_CLEAR : NFSD_SET);
 				break;
 			default:
 				return -EINVAL;
@@ -404,16 +403,15 @@ static ssize_t write_versions(struct fil
 		/* If all get turned off, turn them back on, as
 		 * having no versions is BAD
 		 */
-		if ((nfsd_versbits & NFSCTL_VERALL)==0)
-			nfsd_versbits = NFSCTL_VERALL;
+		nfsd_reset_versions();
 	}
 	/* Now write current state into reply buffer */
 	len = 0;
 	sep = "";
 	for (num=2 ; num <= 4 ; num++)
-		if (NFSCTL_VERISSET(NFSCTL_VERALL, num)) {
+		if (nfsd_vers(num, NFSD_AVAIL)) {
 			len += sprintf(buf+len, "%s%c%d", sep,
-				       NFSCTL_VERISSET(nfsd_versbits, num)?'+':'-',
+				       nfsd_vers(num, NFSD_TEST)?'+':'-',
 				       num);
 			sep = " ";
 		}

diff .prev/fs/nfsd/nfssvc.c ./fs/nfsd/nfssvc.c
--- .prev/fs/nfsd/nfssvc.c	2006-07-24 15:15:04.000000000 +1000
+++ ./fs/nfsd/nfssvc.c	2006-07-24 15:17:36.000000000 +1000
@@ -117,6 +117,32 @@ struct svc_program		nfsd_program = {
 
 };
 
+int nfsd_vers(int vers, enum vers_op change)
+{
+	if (vers < NFSD_MINVERS || vers >= NFSD_NRVERS)
+		return -1;
+	switch(change) {
+	case NFSD_SET:
+		nfsd_versions[vers] = nfsd_version[vers];
+		break;
+#if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
+		if (vers < NFSD_ACL_NRVERS)
+			nfsd_acl_version[vers] = nfsd_acl_version[vers];
+#endif
+	case NFSD_CLEAR:
+		nfsd_versions[vers] = NULL;
+#if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
+		if (vers < NFSD_ACL_NRVERS)
+			nfsd_acl_version[vers] = NULL;
+#endif
+		break;
+	case NFSD_TEST:
+		return nfsd_versions[vers] != NULL;
+	case NFSD_AVAIL:
+		return nfsd_version[vers] != NULL;
+	}
+	return 0;
+}
 /*
  * Maximum number of nfsd processes
  */
@@ -147,16 +173,36 @@ static void nfsd_last_thread(struct svc_
 		nfsd_export_flush();
 	}
 }
+
+void nfsd_reset_versions(void)
+{
+	int found_one = 0;
+	int i;
+
+	for (i = NFSD_MINVERS; i < NFSD_NRVERS; i++) {
+		if (nfsd_program.pg_vers[i])
+			found_one = 1;
+	}
+
+	if (!found_one) {
+		for (i = NFSD_MINVERS; i < NFSD_NRVERS; i++)
+			nfsd_program.pg_vers[i] = nfsd_version[i];
+#if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
+		for (i = NFSD_ACL_MINVERS; i < NFSD_ACL_NRVERS; i++)
+			nfsd_acl_program.pg_vers[i] =
+				nfsd_acl_version[i];
+#endif
+	}
+}
+
 int
 nfsd_svc(unsigned short port, int nrservs)
 {
 	int	error;
-	int	found_one, i;
 	struct list_head *victim;
 	
 	lock_kernel();
-	dprintk("nfsd: creating service: vers 0x%x\n",
-		nfsd_versbits);
+	dprintk("nfsd: creating service\n");
 	error = -EINVAL;
 	if (nrservs <= 0)
 		nrservs = 0;
@@ -171,46 +217,7 @@ nfsd_svc(unsigned short port, int nrserv
 	if (error<0)
 		goto out;
 	if (!nfsd_serv) {
-		/*
-		 * Use the nfsd_ctlbits to define which
-		 * versions that will be advertised.
-		 * If nfsd_ctlbits doesn't list any version,
-		 * export them all.
-		 */
-		found_one = 0;
-
-		for (i = NFSD_MINVERS; i < NFSD_NRVERS; i++) {
-			if (NFSCTL_VERISSET(nfsd_versbits, i)) {
-				nfsd_program.pg_vers[i] = nfsd_version[i];
-				found_one = 1;
-			} else
-				nfsd_program.pg_vers[i] = NULL;
-		}
-
-		if (!found_one) {
-			for (i = NFSD_MINVERS; i < NFSD_NRVERS; i++)
-				nfsd_program.pg_vers[i] = nfsd_version[i];
-		}
-
-
-#if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
-		found_one = 0;
-
-		for (i = NFSD_ACL_MINVERS; i < NFSD_ACL_NRVERS; i++) {
-			if (NFSCTL_VERISSET(nfsd_versbits, i)) {
-				nfsd_acl_program.pg_vers[i] =
-					nfsd_acl_version[i];
-				found_one = 1;
-			} else
-				nfsd_acl_program.pg_vers[i] = NULL;
-		}
-
-		if (!found_one) {
-			for (i = NFSD_ACL_MINVERS; i < NFSD_ACL_NRVERS; i++)
-				nfsd_acl_program.pg_vers[i] =
-					nfsd_acl_version[i];
-		}
-#endif
+		nfsd_reset_versions();
 
 		atomic_set(&nfsd_busy, 0);
 		error = -ENOMEM;

diff .prev/include/linux/nfsd/nfsd.h ./include/linux/nfsd/nfsd.h
--- .prev/include/linux/nfsd/nfsd.h	2006-07-24 15:17:36.000000000 +1000
+++ ./include/linux/nfsd/nfsd.h	2006-07-24 15:17:36.000000000 +1000
@@ -140,6 +140,10 @@ struct posix_acl *nfsd_get_posix_acl(str
 int nfsd_set_posix_acl(struct svc_fh *, int, struct posix_acl *);
 #endif
 
+enum vers_op {NFSD_SET, NFSD_CLEAR, NFSD_TEST, NFSD_AVAIL };
+int nfsd_vers(int vers, enum vers_op change);
+void nfsd_reset_versions(void);
+
 
 /* 
  * NFSv4 State

diff .prev/include/linux/nfsd/syscall.h ./include/linux/nfsd/syscall.h
--- .prev/include/linux/nfsd/syscall.h	2006-07-24 15:17:36.000000000 +1000
+++ ./include/linux/nfsd/syscall.h	2006-07-24 15:17:36.000000000 +1000
@@ -38,21 +38,6 @@
 #define NFSCTL_GETFD		7	/* get an fh by path (used by mountd) */
 #define	NFSCTL_GETFS		8	/* get an fh by path with max FH len */
 
-/*
- * Macros used to set version
- */
-#define NFSCTL_VERSET(_cltbits, _v)   ((_cltbits) |=  (1 << (_v)))
-#define NFSCTL_VERUNSET(_cltbits, _v) ((_cltbits) &= ~(1 << (_v)))
-#define NFSCTL_VERISSET(_cltbits, _v) ((_cltbits) & (1 << (_v)))
-
-#if defined(CONFIG_NFSD_V4)
-#define	NFSCTL_VERALL	(0x1c /* 0b011100 */)
-#elif defined(CONFIG_NFSD_V3)
-#define	NFSCTL_VERALL	(0x0c /* 0b001100 */)
-#else
-#define	NFSCTL_VERALL	(0x04 /* 0b000100 */)
-#endif
-
 /* SVC */
 struct nfsctl_svc {
 	unsigned short		svc_port;
@@ -134,8 +119,6 @@ extern int		exp_delclient(struct nfsctl_
 extern int		exp_export(struct nfsctl_export *nxp);
 extern int		exp_unexport(struct nfsctl_export *nxp);
 
-extern unsigned int nfsd_versbits;
-
 #endif /* __KERNEL__ */
 
 #endif /* NFSD_SYSCALL_H */
