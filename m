Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbWIAEjc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbWIAEjc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 00:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932108AbWIAEjB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 00:39:01 -0400
Received: from mx1.suse.de ([195.135.220.2]:64729 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932112AbWIAEiv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 00:38:51 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 1 Sep 2006 14:38:43 +1000
Message-Id: <1060901043843.27500@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: Olaf Kirch <okir@suse.de>
Subject: [PATCH 007 of 19] knfsd: lockd: make the nsm upcalls use the nsm_handle
References: <20060901141639.27206.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Olaf Kirch <okir@suse.de>

  This converts the statd upcalls to use the nsm_handle

  This means that we only register each host once with
  statd, rather than registering each host/vers/protocol triple.

Signed-off-by: Olaf Kirch <okir@suse.de>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/lockd/mon.c                 |   30 ++++++++++++++++++------------
 ./include/linux/lockd/sm_inter.h |    1 -
 2 files changed, 18 insertions(+), 13 deletions(-)

diff .prev/fs/lockd/mon.c ./fs/lockd/mon.c
--- .prev/fs/lockd/mon.c	2006-08-31 17:00:03.000000000 +1000
+++ ./fs/lockd/mon.c	2006-08-31 17:21:30.000000000 +1000
@@ -30,7 +30,7 @@ u32				nsm_local_state;
  * Common procedure for SM_MON/SM_UNMON calls
  */
 static int
-nsm_mon_unmon(struct nlm_host *host, u32 proc, struct nsm_res *res)
+nsm_mon_unmon(struct nsm_handle *nsm, u32 proc, struct nsm_res *res)
 {
 	struct rpc_clnt	*clnt;
 	int		status;
@@ -46,10 +46,10 @@ nsm_mon_unmon(struct nlm_host *host, u32
 		goto out;
 	}
 
-	args.addr = host->h_addr.sin_addr.s_addr;
-	args.proto= (host->h_proto<<1) | host->h_server;
+	memset(&args, 0, sizeof(args));
+	args.addr = nsm->sm_addr.sin_addr.s_addr;
 	args.prog = NLM_PROGRAM;
-	args.vers = host->h_version;
+	args.vers = 3;
 	args.proc = NLMPROC_NSM_NOTIFY;
 	memset(res, 0, sizeof(*res));
 
@@ -80,7 +80,7 @@ nsm_monitor(struct nlm_host *host)
 	if (nsm->sm_monitored)
 		return 0;
 
-	status = nsm_mon_unmon(host, SM_MON, &res);
+	status = nsm_mon_unmon(nsm, SM_MON, &res);
 
 	if (status < 0 || res.status != 0)
 		printk(KERN_NOTICE "lockd: cannot monitor %s\n", host->h_name);
@@ -99,16 +99,20 @@ nsm_unmonitor(struct nlm_host *host)
 	struct nsm_res	res;
 	int		status = 0;
 
-	dprintk("lockd: nsm_unmonitor(%s)\n", host->h_name);
 	if (nsm == NULL)
 		return 0;
 	host->h_nsmhandle = NULL;
 
-	if (!host->h_killed) {
-		status = nsm_mon_unmon(host, SM_UNMON, &res);
+	if (atomic_read(&nsm->sm_count) == 1
+	 && nsm->sm_monitored && !nsm->sm_sticky) {
+		dprintk("lockd: nsm_unmonitor(%s)\n", host->h_name);
+
+		status = nsm_mon_unmon(nsm, SM_UNMON, &res);
 		if (status < 0)
-			printk(KERN_NOTICE "lockd: cannot unmonitor %s\n", host->h_name);
-		nsm->sm_monitored = 0;
+			printk(KERN_NOTICE "lockd: cannot unmonitor %s\n",
+					host->h_name);
+		else
+			nsm->sm_monitored = 0;
 	}
 	nsm_release(nsm);
 	return status;
@@ -171,9 +175,11 @@ xdr_encode_mon(struct rpc_rqst *rqstp, u
 	p = xdr_encode_common(rqstp, p, argp);
 	if (IS_ERR(p))
 		return PTR_ERR(p);
+
+	/* Surprise - there may even be room for an IPv6 address now */
 	*p++ = argp->addr;
-	*p++ = argp->vers;
-	*p++ = argp->proto;
+	*p++ = 0;
+	*p++ = 0;
 	*p++ = 0;
 	rqstp->rq_slen = xdr_adjust_iovec(rqstp->rq_svec, p);
 	return 0;

diff .prev/include/linux/lockd/sm_inter.h ./include/linux/lockd/sm_inter.h
--- .prev/include/linux/lockd/sm_inter.h	2006-08-31 17:21:30.000000000 +1000
+++ ./include/linux/lockd/sm_inter.h	2006-08-31 17:28:45.000000000 +1000
@@ -28,7 +28,6 @@ struct nsm_args {
 	u32		prog;		/* RPC callback info */
 	u32		vers;
 	u32		proc;
-	u32		proto;		/* protocol (udp/tcp) plus server/client flag */
 };
 
 /*
