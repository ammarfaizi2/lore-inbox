Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbWIAEjm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbWIAEjm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 00:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbWIAEjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 00:39:36 -0400
Received: from mx1.suse.de ([195.135.220.2]:4058 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932152AbWIAEjS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 00:39:18 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 1 Sep 2006 14:39:11 +1000
Message-Id: <1060901043911.27582@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: Olaf Kirch <okir@suse.de>
Subject: [PATCH 012 of 19] knfsd: lockd: Add nlm_destroy_host
References: <20060901141639.27206.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Olaf Kirch <okir@suse.de>

  This patch moves the host destruction code out of nlm_host_gc
  into a function of its own.

Signed-off-by: Olaf Kirch <okir@suse.de>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/lockd/host.c |   45 +++++++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff .prev/fs/lockd/host.c ./fs/lockd/host.c
--- .prev/fs/lockd/host.c	2006-08-31 17:32:46.000000000 +1000
+++ ./fs/lockd/host.c	2006-09-01 11:07:19.000000000 +1000
@@ -164,6 +164,34 @@ out:
 	return host;
 }
 
+/*
+ * Destroy a host
+ */
+static void
+nlm_destroy_host(struct nlm_host *host)
+{
+	struct rpc_clnt	*clnt;
+
+	BUG_ON(!list_empty(&host->h_lockowners));
+	BUG_ON(atomic_read(&host->h_count));
+
+	/*
+	 * Release NSM handle and unmonitor host.
+	 */
+	nsm_unmonitor(host);
+
+	if ((clnt = host->h_rpcclnt) != NULL) {
+		if (atomic_read(&clnt->cl_users)) {
+			printk(KERN_WARNING
+				"lockd: active RPC handle\n");
+			clnt->cl_dead = 1;
+		} else {
+			rpc_destroy_client(host->h_rpcclnt);
+		}
+	}
+	kfree(host);
+}
+
 struct nlm_host *
 nlm_find_client(void)
 {
@@ -400,7 +428,6 @@ nlm_gc_hosts(void)
 	struct hlist_head *chain;
 	struct hlist_node *pos, *next;
 	struct nlm_host	*host;
-	struct rpc_clnt	*clnt;
 
 	dprintk("lockd: host garbage collection\n");
 	for (chain = nlm_hosts; chain < nlm_hosts + NLM_HOST_NRHASH; ++chain) {
@@ -423,21 +450,7 @@ nlm_gc_hosts(void)
 			dprintk("lockd: delete host %s\n", host->h_name);
 			hlist_del_init(&host->h_hash);
 
-			/*
-			 * Unmonitor unless host was invalidated (i.e. lockd restarted)
-			 */
-			nsm_unmonitor(host);
-
-			if ((clnt = host->h_rpcclnt) != NULL) {
-				if (atomic_read(&clnt->cl_users)) {
-					printk(KERN_WARNING
-						"lockd: active RPC handle\n");
-					clnt->cl_dead = 1;
-				} else {
-					rpc_destroy_client(host->h_rpcclnt);
-				}
-			}
-			kfree(host);
+			nlm_destroy_host(host);
 			nrhosts--;
 		}
 	}
