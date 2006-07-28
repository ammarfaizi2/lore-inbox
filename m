Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932583AbWG1FLC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932583AbWG1FLC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 01:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932585AbWG1FK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 01:10:58 -0400
Received: from ns.suse.de ([195.135.220.2]:15008 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932583AbWG1FKk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 01:10:40 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 28 Jul 2006 15:09:57 +1000
Message-Id: <1060728050957.503@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: "J. Bruce Fields" <bfields@fieldses.org>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 003 of 4] knfsd: Move makesock failed warning into make_socks.
References: <20060728150606.29533.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thus it is printed for any path that leads to failure (make_socks is
called from two places).

Cc: "J. Bruce Fields" <bfields@fieldses.org>

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/lockd/svc.c |   18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff .prev/fs/lockd/svc.c ./fs/lockd/svc.c
--- .prev/fs/lockd/svc.c	2006-07-28 15:00:55.000000000 +1000
+++ ./fs/lockd/svc.c	2006-07-28 15:01:30.000000000 +1000
@@ -227,15 +227,19 @@ static int make_socks(struct svc_serv *s
 	 * If nlm_udpport or nlm_tcpport were set as module
 	 * options, make those sockets unconditionally
 	 */
+	static int		warned;
 	int err = 0;
 	if (proto == IPPROTO_UDP || nlm_udpport)
 		if (!find_socket(serv, IPPROTO_UDP))
 			err = svc_makesock(serv, IPPROTO_UDP, nlm_udpport);
-	if (err)
-		return err;
-	if (proto == IPPROTO_TCP || nlm_tcpport)
+	if (err == 0 && (proto == IPPROTO_TCP || nlm_tcpport))
 		if (!find_socket(serv, IPPROTO_TCP))
 			err= svc_makesock(serv, IPPROTO_TCP, nlm_tcpport);
+	if (!err)
+		warned = 0;
+	else if (warned++ == 0)
+		printk(KERN_WARNING
+		       "lockd_up: makesock failed, error=%d\n", err);
 	return err;
 }
 
@@ -245,7 +249,6 @@ static int make_socks(struct svc_serv *s
 int
 lockd_up(int proto) /* Maybe add a 'family' option when IPv6 is supported ?? */
 {
-	static int		warned;
 	struct svc_serv *	serv;
 	int			error = 0;
 
@@ -278,13 +281,8 @@ lockd_up(int proto) /* Maybe add a 'fami
 		goto out;
 	}
 
-	if ((error = make_socks(serv, proto)) < 0) {
-		if (warned++ == 0) 
-			printk(KERN_WARNING
-				"lockd_up: makesock failed, error=%d\n", error);
+	if ((error = make_socks(serv, proto)) < 0)
 		goto destroy_and_out;
-	} 
-	warned = 0;
 
 	/*
 	 * Create the kernel thread and wait for it to start.
