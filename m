Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946782AbWJTBw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946782AbWJTBw6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 21:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946784AbWJTBw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 21:52:58 -0400
Received: from ns2.suse.de ([195.135.220.15]:10638 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1946782AbWJTBw5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 21:52:57 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 20 Oct 2006 11:52:44 +1000
Message-Id: <1061020015244.26756@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: stable@kernel.org, Adrian Bunk <bunk@stusta.de>
Subject: [PATCH] knfsd: Fix race that can disable NFS server.
References: <20061020114959.26698.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is suitable for just about any 2.6 kernel.
It should go in 2.6.19 and 2.6.18.2 and possible even the .17 and .16
stable series.

### Comments for Changeset

This is a long standing bug that seems to have only recently become
apparent, presumably due to increasing use of NFS over TCP - many
distros seem to be making it the default.

The SK_CONN bit gets set when a listening socket may be ready
for an accept, just as SK_DATA is set when data may be available.

It is entirely possible for svc_tcp_accept to be called with neither
of these set.  It doesn't happen often but there is a small race in
svc_sock_enqueue as SK_CONN and SK_DATA are tested outside the
spin_lock.  They could be cleared immediately after the test and
before the lock is gained.

This normally shouldn't be a problem.  The sockets are non-blocking so
trying to read() or accept() when ther is nothing to do is not a problem.

However: svc_tcp_recvfrom makes the decision "Should I accept() or
should I read()" based on whether SK_CONN is set or not.  This usually
works but is not safe.  The decision should be based on whether it is
a TCP_LISTEN socket or a TCP_CONNECTED socket.


Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./net/sunrpc/svcsock.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff .prev/net/sunrpc/svcsock.c ./net/sunrpc/svcsock.c
--- .prev/net/sunrpc/svcsock.c	2006-10-20 11:49:18.000000000 +1000
+++ ./net/sunrpc/svcsock.c	2006-10-20 11:49:47.000000000 +1000
@@ -1002,7 +1002,7 @@ svc_tcp_recvfrom(struct svc_rqst *rqstp)
 		return 0;
 	}
 
-	if (test_bit(SK_CONN, &svsk->sk_flags)) {
+	if (svsk->sk_sk->sk_state == TCP_LISTEN) {
 		svc_tcp_accept(svsk);
 		svc_sock_received(svsk);
 		return 0;
