Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964792AbWIAEoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbWIAEoK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 00:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932129AbWIAEir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 00:38:47 -0400
Received: from mx1.suse.de ([195.135.220.2]:62681 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932103AbWIAEik (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 00:38:40 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 1 Sep 2006 14:38:32 +1000
Message-Id: <1060901043832.27476@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: Olaf Kirch <okir@suse.de>
Subject: [PATCH 005 of 19] knfsd: Misc minor fixes, indentation changes
References: <20060901141639.27206.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Olaf Kirch <okir@suse.de>

This cleans up some code in lockd/host.c, fixes an error printk
and makes it a fatal BUG if nlmsvc_free_host_resources fails.

Signed-off-by: Olaf Kirch <okir@suse.de>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/lockd/host.c    |   15 ++++++---------
 ./fs/lockd/svcsubs.c |    8 +++++---
 2 files changed, 11 insertions(+), 12 deletions(-)

diff .prev/fs/lockd/host.c ./fs/lockd/host.c
--- .prev/fs/lockd/host.c	2006-08-31 17:00:03.000000000 +1000
+++ ./fs/lockd/host.c	2006-08-31 17:01:00.000000000 +1000
@@ -110,16 +110,13 @@ nlm_lookup_host(int server, const struct
 		if (host->h_server != server)
 			continue;
 
-		{
-			if (hp != nlm_hosts + hash) {
-				*hp = host->h_next;
-				host->h_next = nlm_hosts[hash];
-				nlm_hosts[hash] = host;
-			}
-			nlm_get_host(host);
-			mutex_unlock(&nlm_host_mutex);
-			return host;
+		if (hp != nlm_hosts + hash) {
+			*hp = host->h_next;
+			host->h_next = nlm_hosts[hash];
+			nlm_hosts[hash] = host;
 		}
+		nlm_get_host(host);
+		goto out;
 	}
 
 	/* Sadly, the host isn't in our hash table yet. See if

diff .prev/fs/lockd/svcsubs.c ./fs/lockd/svcsubs.c
--- .prev/fs/lockd/svcsubs.c	2006-08-31 17:01:00.000000000 +1000
+++ ./fs/lockd/svcsubs.c	2006-08-31 17:01:00.000000000 +1000
@@ -115,7 +115,7 @@ nlm_lookup_file(struct svc_rqst *rqstp, 
 	 * the file.
 	 */
 	if ((nfserr = nlmsvc_ops->fopen(rqstp, f, &file->f_file)) != 0) {
-		dprintk("lockd: open failed (nfserr %d)\n", ntohl(nfserr));
+		dprintk("lockd: open failed (error %d)\n", nfserr);
 		goto out_free;
 	}
 
@@ -313,10 +313,12 @@ nlmsvc_free_host_resources(struct nlm_ho
 {
 	dprintk("lockd: nlmsvc_free_host_resources\n");
 
-	if (nlm_traverse_files(host, NLM_ACT_UNLOCK))
+	if (nlm_traverse_files(host, NLM_ACT_UNLOCK)) {
 		printk(KERN_WARNING
-			"lockd: couldn't remove all locks held by %s",
+			"lockd: couldn't remove all locks held by %s\n",
 			host->h_name);
+		BUG();
+	}
 }
 
 /*
