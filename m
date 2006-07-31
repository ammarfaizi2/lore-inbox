Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964798AbWGaAou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbWGaAou (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 20:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbWGaAm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 20:42:28 -0400
Received: from cantor2.suse.de ([195.135.220.15]:44173 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964799AbWGaAmY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 20:42:24 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 31 Jul 2006 10:42:19 +1000
Message-Id: <1060731004219.29255@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 007 of 11] knfsd: add svc_get
References: <20060731103458.29040.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Greg Banks <gnb@melbourne.sgi.com>

knfsd: add svc_get() for those occasions when we need to temporarily
bump up svc_serv->sv_nrthreads as a pseudo refcount.

Signed-off-by: Greg Banks <gnb@melbourne.sgi.com>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/nfssvc.c           |    2 +-
 ./include/linux/sunrpc/svc.h |   11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff .prev/fs/nfsd/nfssvc.c ./fs/nfsd/nfssvc.c
--- .prev/fs/nfsd/nfssvc.c	2006-07-28 15:01:38.000000000 +1000
+++ ./fs/nfsd/nfssvc.c	2006-07-31 10:20:49.000000000 +1000
@@ -200,7 +200,7 @@ int nfsd_create_serv(void)
 	int err = 0;
 	lock_kernel();
 	if (nfsd_serv) {
-		nfsd_serv->sv_nrthreads++;
+		svc_get(nfsd_serv);
 		unlock_kernel();
 		return 0;
 	}

diff .prev/include/linux/sunrpc/svc.h ./include/linux/sunrpc/svc.h
--- .prev/include/linux/sunrpc/svc.h	2006-07-31 10:14:54.000000000 +1000
+++ ./include/linux/sunrpc/svc.h	2006-07-31 10:20:49.000000000 +1000
@@ -71,6 +71,17 @@ struct svc_serv {
 };
 
 /*
+ * We use sv_nrthreads as a reference count.  svc_destroy() drops
+ * this refcount, so we need to bump it up around operations that
+ * change the number of threads.  Horrible, but there it is.
+ * Should be called with the BKL held.
+ */
+static inline void svc_get(struct svc_serv *serv)
+{
+	serv->sv_nrthreads++;
+}
+
+/*
  * Maximum payload size supported by a kernel RPC server.
  * This is use to determine the max number of pages nfsd is
  * willing to return in a single READ operation.
