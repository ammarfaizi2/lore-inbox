Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932582AbWG1FK5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932582AbWG1FK5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 01:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932588AbWG1FK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 01:10:57 -0400
Received: from cantor2.suse.de ([195.135.220.15]:48336 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932582AbWG1FKe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 01:10:34 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 28 Jul 2006 15:09:51 +1000
Message-Id: <1060728050951.453@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: "J. Bruce Fields" <bfields@fieldses.org>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 002 of 4] knfsd: Check return value of lockd_up in write_ports
References: <20060728150606.29533.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We should be checking the return value of lockd_up when
adding a new socket to nfsd.
So move the lockd_up before the svc_addsock and check
the return value.
The move is because lockd_down is easy, but there is no easy
way to remove a recently added socket.

Cc: "J. Bruce Fields" <bfields@fieldses.org>

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/nfsctl.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff .prev/fs/nfsd/nfsctl.c ./fs/nfsd/nfsctl.c
--- .prev/fs/nfsd/nfsctl.c	2006-07-28 11:34:33.000000000 +1000
+++ ./fs/nfsd/nfsctl.c	2006-07-28 12:07:35.000000000 +1000
@@ -454,12 +454,15 @@ static ssize_t write_ports(struct file *
 		err = nfsd_create_serv();
 		if (!err) {
 			int proto = 0;
-			err = svc_addsock(nfsd_serv, fd, buf, &proto);
+			err = lockd_up(proto);
+			if (!err) {
+				err = svc_addsock(nfsd_serv, fd, buf, &proto);
+				if (err)
+					lockd_down();
+			}
 			/* Decrease the count, but don't shutdown the
 			 * the service
 			 */
-			if (err >= 0)
-				lockd_up(proto);
 			nfsd_serv->sv_nrthreads--;
 		}
 		return err;
