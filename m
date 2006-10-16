Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422931AbWJPXai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422931AbWJPXai (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 19:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbWJPXai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 19:30:38 -0400
Received: from ns.suse.de ([195.135.220.2]:45969 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1422931AbWJPXaa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 19:30:30 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 17 Oct 2006 09:30:25 +1000
Message-Id: <1061016233025.11354@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 004 of 5] knfsd: Fix bug in recent lockd patches that can cause reclaim to fail.
References: <20061017092702.11224.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When an nfs server shuts down, lockd needs to release all the locks
even though the client still holds them.

It should therefore not 'unmonitor' the clients, so that the files in
nfs/sm will still be there when the nfs server restarts, so that those
clients will be told to reclaim their locks.

However the hosts are fully unmonitored, so statd may well remove the
files.

lockd has a test for 'sm_sticky' and avoid the unmonitor call if it is
set, but it is currently not set.

So set it when tearing down lockd.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/lockd/svcsubs.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff .prev/fs/lockd/svcsubs.c ./fs/lockd/svcsubs.c
--- .prev/fs/lockd/svcsubs.c	2006-10-17 09:10:39.000000000 +1000
+++ ./fs/lockd/svcsubs.c	2006-10-17 09:10:40.000000000 +1000
@@ -324,7 +324,17 @@ nlmsvc_same_host(struct nlm_host *host, 
 static int
 nlmsvc_is_client(struct nlm_host *host, struct nlm_host *dummy)
 {
-	return host->h_server;
+	if (host->h_server)
+	{
+		/* we are destroying locks even though the client
+		 * hasn't asked us too, so don't unmonitor the
+		 * client
+		 */
+		if (host->h_nsmhandle)
+			host->h_nsmhandle->sm_sticky = 1;
+		return 1;
+	} else
+		return 0;
 }
 
 /*
