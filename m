Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbWIAEiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbWIAEiS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 00:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932103AbWIAEiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 00:38:17 -0400
Received: from ns2.suse.de ([195.135.220.15]:16043 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932091AbWIAEiR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 00:38:17 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 1 Sep 2006 14:38:08 +1000
Message-Id: <1060901043808.27427@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: Olaf Kirch <okir@suse.de>
Subject: [PATCH 001 of 19] knfsd: Hide use of lockd's h_monitored flag
References: <20060901141639.27206.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Olaf Kirch <okir@suse.de>

  This patch moves all checks of the h_monitored flag into
  the nsm_monitor/unmonitor functions.
  A subsequent patch will replace the mechanism by which we
  mark a host as being monitored.

  There is still one occurence of h_monitored outside of
  mon.c and that is in clntlock.c where we respond to a
  reboot. The subsequent patch will modify this too.

Signed-off-by: Olaf Kirch <okir@suse.de>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/lockd/clntproc.c |    2 +-
 ./fs/lockd/host.c     |    9 ++++++---
 ./fs/lockd/mon.c      |   19 ++++++++++++-------
 ./fs/lockd/svc4proc.c |    2 +-
 ./fs/lockd/svcproc.c  |    2 +-
 5 files changed, 21 insertions(+), 13 deletions(-)

diff .prev/fs/lockd/clntproc.c ./fs/lockd/clntproc.c
--- .prev/fs/lockd/clntproc.c	2006-08-31 16:12:30.000000000 +1000
+++ ./fs/lockd/clntproc.c	2006-08-31 16:12:30.000000000 +1000
@@ -499,7 +499,7 @@ nlmclnt_lock(struct nlm_rqst *req, struc
 	unsigned char fl_flags = fl->fl_flags;
 	int status = -ENOLCK;
 
-	if (!host->h_monitored && nsm_monitor(host) < 0) {
+	if (nsm_monitor(host) < 0) {
 		printk(KERN_NOTICE "lockd: failed to monitor %s\n",
 					host->h_name);
 		goto out;

diff .prev/fs/lockd/host.c ./fs/lockd/host.c
--- .prev/fs/lockd/host.c	2006-08-31 16:12:30.000000000 +1000
+++ ./fs/lockd/host.c	2006-08-31 16:12:30.000000000 +1000
@@ -331,9 +331,12 @@ nlm_gc_hosts(void)
 			}
 			dprintk("lockd: delete host %s\n", host->h_name);
 			*q = host->h_next;
-			/* Don't unmonitor hosts that have been invalidated */
-			if (host->h_monitored && !host->h_killed)
-				nsm_unmonitor(host);
+
+			/*
+			 * Unmonitor unless host was invalidated (i.e. lockd restarted)
+			 */
+			nsm_unmonitor(host);
+
 			if ((clnt = host->h_rpcclnt) != NULL) {
 				if (atomic_read(&clnt->cl_users)) {
 					printk(KERN_WARNING

diff .prev/fs/lockd/mon.c ./fs/lockd/mon.c
--- .prev/fs/lockd/mon.c	2006-08-31 16:12:30.000000000 +1000
+++ ./fs/lockd/mon.c	2006-08-31 16:12:30.000000000 +1000
@@ -74,6 +74,8 @@ nsm_monitor(struct nlm_host *host)
 	int		status;
 
 	dprintk("lockd: nsm_monitor(%s)\n", host->h_name);
+	if (host->h_monitored)
+		return 0;
 
 	status = nsm_mon_unmon(host, SM_MON, &res);
 
@@ -91,15 +93,18 @@ int
 nsm_unmonitor(struct nlm_host *host)
 {
 	struct nsm_res	res;
-	int		status;
+	int		status = 0;
 
 	dprintk("lockd: nsm_unmonitor(%s)\n", host->h_name);
-
-	status = nsm_mon_unmon(host, SM_UNMON, &res);
-	if (status < 0)
-		printk(KERN_NOTICE "lockd: cannot unmonitor %s\n", host->h_name);
-	else
-		host->h_monitored = 0;
+	if (!host->h_monitored)
+		return 0;
+	host->h_monitored = 0;
+
+	if (!host->h_killed) {
+		status = nsm_mon_unmon(host, SM_UNMON, &res);
+		if (status < 0)
+			printk(KERN_NOTICE "lockd: cannot unmonitor %s\n", host->h_name);
+	}
 	return status;
 }
 

diff .prev/fs/lockd/svc4proc.c ./fs/lockd/svc4proc.c
--- .prev/fs/lockd/svc4proc.c	2006-08-31 16:12:30.000000000 +1000
+++ ./fs/lockd/svc4proc.c	2006-08-31 16:12:30.000000000 +1000
@@ -39,7 +39,7 @@ nlm4svc_retrieve_args(struct svc_rqst *r
 
 	/* Obtain host handle */
 	if (!(host = nlmsvc_lookup_host(rqstp))
-	 || (argp->monitor && !host->h_monitored && nsm_monitor(host) < 0))
+	 || (argp->monitor && nsm_monitor(host) < 0))
 		goto no_locks;
 	*hostp = host;
 

diff .prev/fs/lockd/svcproc.c ./fs/lockd/svcproc.c
--- .prev/fs/lockd/svcproc.c	2006-08-31 16:12:30.000000000 +1000
+++ ./fs/lockd/svcproc.c	2006-08-31 16:12:30.000000000 +1000
@@ -67,7 +67,7 @@ nlmsvc_retrieve_args(struct svc_rqst *rq
 
 	/* Obtain host handle */
 	if (!(host = nlmsvc_lookup_host(rqstp))
-	 || (argp->monitor && !host->h_monitored && nsm_monitor(host) < 0))
+	 || (argp->monitor && nsm_monitor(host) < 0))
 		goto no_locks;
 	*hostp = host;
 
