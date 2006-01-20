Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161250AbWATGtz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161250AbWATGtz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 01:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161253AbWATGty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 01:49:54 -0500
Received: from mail.suse.de ([195.135.220.2]:7566 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161250AbWATGty (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 01:49:54 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 20 Jan 2006 17:49:36 +1100
Message-Id: <1060120064936.9440@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: Andreas Gruenbacher <agruen@suse.de>
Subject: [PATCH] knfsd: Restore recently broken ACL functionality to NFS server
References: <20060120174858.9422.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Andreas Gruenbacher <agruen@suse.de>

A recent patch to 
   Allow run-time selection of NFS versions to export  

meant that NO nfsacl service versions were exported.
This patch restored that functionality.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/nfssvc.c |   76 ++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 49 insertions(+), 27 deletions(-)

diff ./fs/nfsd/nfssvc.c~current~ ./fs/nfsd/nfssvc.c
--- ./fs/nfsd/nfssvc.c~current~	2006-01-20 17:41:12.000000000 +1100
+++ ./fs/nfsd/nfssvc.c	2006-01-20 17:46:24.000000000 +1100
@@ -64,6 +64,32 @@ struct nfsd_list {
 };
 static struct list_head nfsd_list = LIST_HEAD_INIT(nfsd_list);
 
+#if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
+static struct svc_stat	nfsd_acl_svcstats;
+static struct svc_version *	nfsd_acl_version[] = {
+	[2] = &nfsd_acl_version2,
+	[3] = &nfsd_acl_version3,
+};
+
+#define NFSD_ACL_MINVERS            2
+#define NFSD_ACL_NRVERS		(sizeof(nfsd_acl_version)/sizeof(nfsd_acl_version[0]))
+static struct svc_version *nfsd_acl_versions[NFSD_ACL_NRVERS];
+
+static struct svc_program	nfsd_acl_program = {
+	.pg_prog		= NFS_ACL_PROGRAM,
+	.pg_nvers		= NFSD_ACL_NRVERS,
+	.pg_vers		= nfsd_acl_versions,
+	.pg_name		= "nfsd",
+	.pg_class		= "nfsd",
+	.pg_stats		= &nfsd_acl_svcstats,
+	.pg_authenticate	= &svc_set_client,
+};
+
+static struct svc_stat	nfsd_acl_svcstats = {
+	.program	= &nfsd_acl_program,
+};
+#endif /* defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL) */
+
 static struct svc_version *	nfsd_version[] = {
 	[2] = &nfsd_version2,
 #if defined(CONFIG_NFSD_V3)
@@ -79,6 +105,9 @@ static struct svc_version *	nfsd_version
 static struct svc_version *nfsd_versions[NFSD_NRVERS];
 
 struct svc_program		nfsd_program = {
+#if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
+	.pg_next		= &nfsd_acl_program,
+#endif
 	.pg_prog		= NFS_PROGRAM,		/* program number */
 	.pg_nvers		= NFSD_NRVERS,		/* nr of entries in nfsd_version */
 	.pg_vers		= nfsd_versions,	/* version table */
@@ -147,6 +176,26 @@ nfsd_svc(unsigned short port, int nrserv
 				nfsd_program.pg_vers[i] = nfsd_version[i];
 		}
 
+
+#if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
+		found_one = 0;
+
+		for (i = NFSD_ACL_MINVERS; i < NFSD_ACL_NRVERS; i++) {
+			if (NFSCTL_VERISSET(nfsd_versbits, i)) {
+				nfsd_acl_program.pg_vers[i] =
+					nfsd_acl_version[i];
+				found_one = 1;
+			} else
+				nfsd_acl_program.pg_vers[i] = NULL;
+		}
+
+		if (!found_one) {
+			for (i = NFSD_ACL_MINVERS; i < NFSD_ACL_NRVERS; i++)
+				nfsd_acl_program.pg_vers[i] =
+					nfsd_acl_version[i];
+		}
+#endif
+
 		atomic_set(&nfsd_busy, 0);
 		error = -ENOMEM;
 		nfsd_serv = svc_create(&nfsd_program, NFSD_BUFSIZE);
@@ -411,30 +460,3 @@ nfsd_dispatch(struct svc_rqst *rqstp, u3
 	nfsd_cache_update(rqstp, proc->pc_cachetype, statp + 1);
 	return 1;
 }
-
-#if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
-static struct svc_stat	nfsd_acl_svcstats;
-static struct svc_version *	nfsd_acl_version[] = {
-	[2] = &nfsd_acl_version2,
-	[3] = &nfsd_acl_version3,
-};
-
-#define NFSD_ACL_NRVERS		(sizeof(nfsd_acl_version)/sizeof(nfsd_acl_version[0]))
-static struct svc_program	nfsd_acl_program = {
-	.pg_prog		= NFS_ACL_PROGRAM,
-	.pg_nvers		= NFSD_ACL_NRVERS,
-	.pg_vers		= nfsd_acl_version,
-	.pg_name		= "nfsd",
-	.pg_class		= "nfsd",
-	.pg_stats		= &nfsd_acl_svcstats,
-	.pg_authenticate	= &svc_set_client,
-};
-
-static struct svc_stat	nfsd_acl_svcstats = {
-	.program	= &nfsd_acl_program,
-};
-
-#define nfsd_acl_program_p	&nfsd_acl_program
-#else
-#define nfsd_acl_program_p	NULL
-#endif /* defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL) */
