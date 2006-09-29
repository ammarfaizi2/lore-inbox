Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161141AbWI2DJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161141AbWI2DJU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 23:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161155AbWI2DJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 23:09:10 -0400
Received: from ns1.suse.de ([195.135.220.2]:40081 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161141AbWI2DIu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 23:08:50 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 29 Sep 2006 13:08:45 +1000
Message-Id: <1060929030845.24038@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 002 of 8] knfsd: lockd: fix refount on nsm.
References: <20060929130518.23919.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If nlm_lookup_host finds what it is looking for
it exits with an extra reference on the matching
'nsm' structure.
So don't actually count the reference until we are
(fairly) sure it is going to be used.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/lockd/host.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff .prev/fs/lockd/host.c ./fs/lockd/host.c
--- .prev/fs/lockd/host.c	2006-09-29 11:44:21.000000000 +1000
+++ ./fs/lockd/host.c	2006-09-29 11:55:15.000000000 +1000
@@ -103,8 +103,8 @@ nlm_lookup_host(int server, const struct
 			continue;
 
 		/* See if we have an NSM handle for this client */
-		if (!nsm && (nsm = host->h_nsmhandle) != 0)
-			atomic_inc(&nsm->sm_count);
+		if (!nsm)
+			nsm = host->h_nsmhandle;
 
 		if (host->h_proto != proto)
 			continue;
@@ -120,6 +120,8 @@ nlm_lookup_host(int server, const struct
 		nlm_get_host(host);
 		goto out;
 	}
+	if (nsm)
+		atomic_inc(&nsm->sm_count);
 
 	host = NULL;
 
