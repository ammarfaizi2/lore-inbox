Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932396AbWGYBzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbWGYBzj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 21:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932397AbWGYBzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 21:55:39 -0400
Received: from mail.suse.de ([195.135.220.2]:13548 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932395AbWGYBzg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 21:55:36 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 25 Jul 2006 11:54:57 +1000
Message-Id: <1060725015457.21981@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 007 of 9] knfsd: Separate out some parts of nfsd_svc, which start nfs servers.
References: <20060725114207.21779.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Separate out the code for creating a new service, and for creating
initial sockets.

Some of these new functions will have multiple callers soon.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/nfssvc.c |   82 ++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 57 insertions(+), 25 deletions(-)

diff .prev/fs/nfsd/nfssvc.c ./fs/nfsd/nfssvc.c
--- .prev/fs/nfsd/nfssvc.c	2006-07-24 15:17:36.000000000 +1000
+++ ./fs/nfsd/nfssvc.c	2006-07-24 15:20:39.000000000 +1000
@@ -195,6 +195,53 @@ void nfsd_reset_versions(void)
 	}
 }
 
+
+static inline int nfsd_create_serv(void)
+{
+	int err = 0;
+	lock_kernel();
+	if (nfsd_serv) {
+		nfsd_serv->sv_nrthreads++;
+		unlock_kernel();
+		return 0;
+	}
+
+	atomic_set(&nfsd_busy, 0);
+	nfsd_serv = svc_create(&nfsd_program, NFSD_BUFSIZE,
+			       nfsd_last_thread);
+	if (nfsd_serv == NULL)
+		err = -ENOMEM;
+	else
+		nfsd_serv->sv_nrthreads++;
+	unlock_kernel();
+	do_gettimeofday(&nfssvc_boot);		/* record boot time */
+	return err;
+}
+
+static inline int nfsd_init_socks(int port)
+{
+	int error;
+	if (!list_empty(&nfsd_serv->sv_permsocks))
+		return 0;
+
+	error = svc_makesock(nfsd_serv, IPPROTO_UDP, port);
+	if (error < 0)
+		return error;
+	error = lockd_up(IPPROTO_UDP);
+	if (error < 0)
+		return error;
+
+#ifdef CONFIG_NFSD_TCP
+	error = svc_makesock(nfsd_serv, IPPROTO_TCP, port);
+	if (error < 0)
+		return error;
+	error = lockd_up(IPPROTO_TCP);
+	if (error < 0)
+		return error;
+#endif
+	return 0;
+}
+
 int
 nfsd_svc(unsigned short port, int nrservs)
 {
@@ -216,32 +263,17 @@ nfsd_svc(unsigned short port, int nrserv
 	error = nfs4_state_start();
 	if (error<0)
 		goto out;
-	if (!nfsd_serv) {
-		nfsd_reset_versions();
 
-		atomic_set(&nfsd_busy, 0);
-		error = -ENOMEM;
-		nfsd_serv = svc_create(&nfsd_program, NFSD_BUFSIZE,
-				       nfsd_last_thread);
-		if (nfsd_serv == NULL)
-			goto out;
-		error = svc_makesock(nfsd_serv, IPPROTO_UDP, port);
-		if (error < 0)
-			goto failure;
-		error = lockd_up(IPPROTO_UDP);
-		if (error < 0)
-			goto failure;
-#ifdef CONFIG_NFSD_TCP
-		error = svc_makesock(nfsd_serv, IPPROTO_TCP, port);
-		if (error < 0)
-			goto failure;
-		error = lockd_up(IPPROTO_TCP);
-		if (error < 0)
-			goto failure;
-#endif
-		do_gettimeofday(&nfssvc_boot);		/* record boot time */
-	} else
-		nfsd_serv->sv_nrthreads++;
+	nfsd_reset_versions();
+
+	error = nfsd_create_serv();
+
+	if (error)
+		goto out;
+	error = nfsd_init_socks(port);
+	if (error)
+		goto failure;
+
 	nrservs -= (nfsd_serv->sv_nrthreads-1);
 	while (nrservs > 0) {
 		nrservs--;
