Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964789AbWIAElN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbWIAElN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 00:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964781AbWIAEkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 00:40:12 -0400
Received: from ns2.suse.de ([195.135.220.15]:32939 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932165AbWIAEj4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 00:39:56 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 1 Sep 2006 14:39:48 +1000
Message-Id: <1060901043948.27677@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: Olaf Kirch <okir@suse.de>
Subject: [PATCH 019 of 19] knfsd: Register all RPC programs with portmapper by default
References: <20060901141639.27206.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Olaf Kirch <okir@suse.de>

  The NFSACL patches introduced support for multiple RPC services
  listening on the same transport. However, only the first of these
  services was registered with portmapper. This was perfectly fine
  for nfsacl, as you traditionally do not want these to show up in a
  portmapper listing.

  The patch below changes the default behavior to always register
  all services listening on a given transport, but retains the
  old behavior for nfsacl services.

Signed-off-by: Olaf Kirch <okir@suse.de>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/nfs2acl.c          |    1 +
 ./fs/nfsd/nfs3acl.c          |    1 +
 ./include/linux/sunrpc/svc.h |    3 +++
 ./net/sunrpc/svc.c           |   37 +++++++++++++++++++++++--------------
 4 files changed, 28 insertions(+), 14 deletions(-)

diff .prev/fs/nfsd/nfs2acl.c ./fs/nfsd/nfs2acl.c
--- .prev/fs/nfsd/nfs2acl.c	2006-09-01 12:22:10.000000000 +1000
+++ ./fs/nfsd/nfs2acl.c	2006-09-01 12:22:11.000000000 +1000
@@ -333,4 +333,5 @@ struct svc_version	nfsd_acl_version2 = {
 		.vs_proc	= nfsd_acl_procedures2,
 		.vs_dispatch	= nfsd_dispatch,
 		.vs_xdrsize	= NFS3_SVC_XDRSIZE,
+		.vs_hidden	= 1,
 };

diff .prev/fs/nfsd/nfs3acl.c ./fs/nfsd/nfs3acl.c
--- .prev/fs/nfsd/nfs3acl.c	2006-09-01 12:22:10.000000000 +1000
+++ ./fs/nfsd/nfs3acl.c	2006-09-01 12:22:11.000000000 +1000
@@ -263,5 +263,6 @@ struct svc_version	nfsd_acl_version3 = {
 		.vs_proc	= nfsd_acl_procedures3,
 		.vs_dispatch	= nfsd_dispatch,
 		.vs_xdrsize	= NFS3_SVC_XDRSIZE,
+		.vs_hidden	= 1,
 };
 

diff .prev/include/linux/sunrpc/svc.h ./include/linux/sunrpc/svc.h
--- .prev/include/linux/sunrpc/svc.h	2006-09-01 12:22:10.000000000 +1000
+++ ./include/linux/sunrpc/svc.h	2006-09-01 12:22:11.000000000 +1000
@@ -304,6 +304,9 @@ struct svc_version {
 	struct svc_procedure *	vs_proc;	/* per-procedure info */
 	u32			vs_xdrsize;	/* xdrsize needed for this version */
 
+	unsigned int		vs_hidden : 1;	/* Don't register with portmapper.
+						 * Only used for nfsacl so far. */
+
 	/* Override dispatch function (e.g. when caching replies).
 	 * A return value of 0 means drop the request. 
 	 * vs_dispatch == NULL means use default dispatcher.

diff .prev/net/sunrpc/svc.c ./net/sunrpc/svc.c
--- .prev/net/sunrpc/svc.c	2006-09-01 12:22:11.000000000 +1000
+++ ./net/sunrpc/svc.c	2006-09-01 12:22:11.000000000 +1000
@@ -644,23 +644,32 @@ svc_register(struct svc_serv *serv, int 
 	unsigned long		flags;
 	int			i, error = 0, dummy;
 
-	progp = serv->sv_program;
-
-	dprintk("RPC: svc_register(%s, %s, %d)\n",
-		progp->pg_name, proto == IPPROTO_UDP? "udp" : "tcp", port);
-
 	if (!port)
 		clear_thread_flag(TIF_SIGPENDING);
 
-	for (i = 0; i < progp->pg_nvers; i++) {
-		if (progp->pg_vers[i] == NULL)
-			continue;
-		error = rpc_register(progp->pg_prog, i, proto, port, &dummy);
-		if (error < 0)
-			break;
-		if (port && !dummy) {
-			error = -EACCES;
-			break;
+	for (progp = serv->sv_program; progp; progp = progp->pg_next) {
+		for (i = 0; i < progp->pg_nvers; i++) {
+			if (progp->pg_vers[i] == NULL)
+				continue;
+
+			dprintk("RPC: svc_register(%s, %s, %d, %d)%s\n",
+					progp->pg_name,
+					proto == IPPROTO_UDP?  "udp" : "tcp",
+					port,
+					i,
+					progp->pg_vers[i]->vs_hidden?
+						" (but not telling portmap)" : "");
+
+			if (progp->pg_vers[i]->vs_hidden)
+				continue;
+
+			error = rpc_register(progp->pg_prog, i, proto, port, &dummy);
+			if (error < 0)
+				break;
+			if (port && !dummy) {
+				error = -EACCES;
+				break;
+			}
 		}
 	}
 
