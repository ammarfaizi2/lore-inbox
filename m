Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964800AbWGaAm2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbWGaAm2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 20:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964797AbWGaAmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 20:42:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:41869 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932502AbWGaAmN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 20:42:13 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 31 Jul 2006 10:42:08 +1000
Message-Id: <1060731004208.29231@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 005 of 11] knfsd: test and set SK_BUSY atomically
References: <20060731103458.29040.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Greg Banks <gnb@melbourne.sgi.com>

knfsd: The SK_BUSY bit in svc_sock->sk_flags ensures that we do not
attempt to enqueue a socket twice.  Currently, setting and clearing
the bit is protected by svc_serv->sv_lock.  As I intend to reduce the
data that the lock protects so it's not held when svc_sock_enqueue()
tests and sets SK_BUSY, that test and set needs to be atomic.

Signed-off-by: Greg Banks <gnb@melbourne.sgi.com>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./net/sunrpc/svcsock.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff .prev/net/sunrpc/svcsock.c ./net/sunrpc/svcsock.c
--- .prev/net/sunrpc/svcsock.c	2006-07-31 10:00:44.000000000 +1000
+++ ./net/sunrpc/svcsock.c	2006-07-31 10:01:07.000000000 +1000
@@ -46,14 +46,13 @@
 
 /* SMP locking strategy:
  *
- * 	svc_serv->sv_lock protects most stuff for that service.
+ *	svc_serv->sv_lock protects most stuff for that service.
  *	svc_sock->sk_defer_lock protects the svc_sock->sk_deferred list
+ *	svc_sock->sk_flags.SK_BUSY prevents a svc_sock being enqueued multiply.
  *
  *	Some flags can be set to certain values at any time
  *	providing that certain rules are followed:
  *
- *	SK_BUSY  can be set to 0 at any time.  
- *		svc_sock_enqueue must be called afterwards
  *	SK_CONN, SK_DATA, can be set or cleared at any time.
  *		after a set, svc_sock_enqueue must be called.	
  *		after a clear, the socket must be read/accepted
@@ -170,8 +169,13 @@ svc_sock_enqueue(struct svc_sock *svsk)
 		goto out_unlock;
 	}
 
-	if (test_bit(SK_BUSY, &svsk->sk_flags)) {
-		/* Don't enqueue socket while daemon is receiving */
+	/* Mark socket as busy. It will remain in this state until the
+	 * server has processed all pending data and put the socket back
+	 * on the idle list.  We update SK_BUSY atomically because
+	 * it also guards against trying to enqueue the svc_sock twice.
+	 */
+	if (test_and_set_bit(SK_BUSY, &svsk->sk_flags)) {
+		/* Don't enqueue socket while already enqueued */
 		dprintk("svc: socket %p busy, not enqueued\n", svsk->sk_sk);
 		goto out_unlock;
 	}
@@ -185,15 +189,11 @@ svc_sock_enqueue(struct svc_sock *svsk)
 		dprintk("svc: socket %p  no space, %d*2 > %ld, not enqueued\n",
 			svsk->sk_sk, atomic_read(&svsk->sk_reserved)+serv->sv_bufsz,
 			svc_sock_wspace(svsk));
+		clear_bit(SK_BUSY, &svsk->sk_flags);
 		goto out_unlock;
 	}
 	clear_bit(SOCK_NOSPACE, &svsk->sk_sock->flags);
 
-	/* Mark socket as busy. It will remain in this state until the
-	 * server has processed all pending data and put the socket back
-	 * on the idle list.
-	 */
-	set_bit(SK_BUSY, &svsk->sk_flags);
 
 	if (!list_empty(&serv->sv_threads)) {
 		rqstp = list_entry(serv->sv_threads.next,
