Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030346AbWHXGhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030346AbWHXGhY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 02:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030337AbWHXGhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 02:37:07 -0400
Received: from cantor2.suse.de ([195.135.220.15]:27570 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030339AbWHXGgx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 02:36:53 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 24 Aug 2006 16:36:54 +1000
Message-Id: <1060824063654.4969@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 005 of 11] knfsd: Fixed handling of lockd fail when adding nfsd socket.
References: <20060824162917.3600.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Arrgg.. 
We cannot 'lockd_up' before 'svc_addsock' as we don't know
the protocol yet....
So switch it around again and save the name of the
created sockets so that it can be closed if lock_up fails.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/nfsctl.c     |   12 ++++++------
 ./net/sunrpc/svcsock.c |    3 +++
 2 files changed, 9 insertions(+), 6 deletions(-)

diff .prev/fs/nfsd/nfsctl.c ./fs/nfsd/nfsctl.c
--- .prev/fs/nfsd/nfsctl.c	2006-08-24 16:24:47.000000000 +1000
+++ ./fs/nfsd/nfsctl.c	2006-08-24 16:24:56.000000000 +1000
@@ -523,11 +523,11 @@ static ssize_t write_ports(struct file *
 		err = nfsd_create_serv();
 		if (!err) {
 			int proto = 0;
-			err = lockd_up(proto);
-			if (!err) {
-				err = svc_addsock(nfsd_serv, fd, buf, &proto);
-				if (err)
-					lockd_down();
+			err = svc_addsock(nfsd_serv, fd, buf, &proto);
+			if (err >= 0) {
+				err = lockd_up(proto);
+				if (err < 0)
+					svc_sock_names(buf+strlen(buf)+1, nfsd_serv, buf);
 			}
 			/* Decrease the count, but don't shutdown the
 			 * the service
@@ -536,7 +536,7 @@ static ssize_t write_ports(struct file *
 			nfsd_serv->sv_nrthreads--;
 			unlock_kernel();
 		}
-		return err;
+		return err < 0 ? err : 0;
 	}
 	if (buf[0] == '-') {
 		char *toclose = kstrdup(buf+1, GFP_KERNEL);

diff .prev/net/sunrpc/svcsock.c ./net/sunrpc/svcsock.c
--- .prev/net/sunrpc/svcsock.c	2006-08-24 16:24:21.000000000 +1000
+++ ./net/sunrpc/svcsock.c	2006-08-24 16:24:56.000000000 +1000
@@ -492,6 +492,9 @@ svc_sock_names(char *buf, struct svc_ser
 	}
 	spin_unlock(&serv->sv_lock);
 	if (closesk)
+		/* Should unregister with portmap, but you cannot
+		 * unregister just one protocol...
+		 */
 		svc_delete_socket(closesk);
 	else if (toclose)
 		return -ENOENT;
