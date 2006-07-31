Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964801AbWGaAou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbWGaAou (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 20:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932501AbWGaAmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 20:42:15 -0400
Received: from cantor.suse.de ([195.135.220.2]:59041 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932498AbWGaAmD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 20:42:03 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 31 Jul 2006 10:41:58 +1000
Message-Id: <1060731004158.29207@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 003 of 11] knfsd: use new lock for svc_sock deferred list
References: <20060731103458.29040.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Greg Banks <gnb@melbourne.sgi.com>

knfsd: Protect the svc_sock->sk_deferred list with a new
lock svc_sock->sk_defer_lock instead of svc_serv->sv_lock.
Using the more fine-grained lock reduces the number of places
we need to take the svc_serv lock.

Signed-off-by: Greg Banks <gnb@melbourne.sgi.com>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./include/linux/sunrpc/svcsock.h |    1 +
 ./net/sunrpc/svcsock.c           |   12 ++++++------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff .prev/include/linux/sunrpc/svcsock.h ./include/linux/sunrpc/svcsock.h
--- .prev/include/linux/sunrpc/svcsock.h	2006-07-31 09:58:07.000000000 +1000
+++ ./include/linux/sunrpc/svcsock.h	2006-07-31 10:00:30.000000000 +1000
@@ -36,6 +36,7 @@ struct svc_sock {
 
 	int			sk_reserved;	/* space on outq that is reserved */
 
+	spinlock_t		sk_defer_lock;	/* protects sk_deferred */
 	struct list_head	sk_deferred;	/* deferred requests that need to
 						 * be revisted */
 	struct mutex		sk_mutex;	/* to serialize sending data */

diff .prev/net/sunrpc/svcsock.c ./net/sunrpc/svcsock.c
--- .prev/net/sunrpc/svcsock.c	2006-07-31 09:58:07.000000000 +1000
+++ ./net/sunrpc/svcsock.c	2006-07-31 10:00:30.000000000 +1000
@@ -47,6 +47,7 @@
 /* SMP locking strategy:
  *
  * 	svc_serv->sv_lock protects most stuff for that service.
+ *	svc_sock->sk_defer_lock protects the svc_sock->sk_deferred list
  *
  *	Some flags can be set to certain values at any time
  *	providing that certain rules are followed:
@@ -1426,6 +1427,7 @@ svc_setup_socket(struct svc_serv *serv, 
 	svsk->sk_server = serv;
 	atomic_set(&svsk->sk_inuse, 0);
 	svsk->sk_lastrecv = get_seconds();
+	spin_lock_init(&svsk->sk_defer_lock);
 	INIT_LIST_HEAD(&svsk->sk_deferred);
 	INIT_LIST_HEAD(&svsk->sk_ready);
 	mutex_init(&svsk->sk_mutex);
@@ -1606,7 +1608,6 @@ svc_makesock(struct svc_serv *serv, int 
 static void svc_revisit(struct cache_deferred_req *dreq, int too_many)
 {
 	struct svc_deferred_req *dr = container_of(dreq, struct svc_deferred_req, handle);
-	struct svc_serv *serv = dreq->owner;
 	struct svc_sock *svsk;
 
 	if (too_many) {
@@ -1617,9 +1618,9 @@ static void svc_revisit(struct cache_def
 	dprintk("revisit queued\n");
 	svsk = dr->svsk;
 	dr->svsk = NULL;
-	spin_lock_bh(&serv->sv_lock);
+	spin_lock_bh(&svsk->sk_defer_lock);
 	list_add(&dr->handle.recent, &svsk->sk_deferred);
-	spin_unlock_bh(&serv->sv_lock);
+	spin_unlock_bh(&svsk->sk_defer_lock);
 	set_bit(SK_DEFERRED, &svsk->sk_flags);
 	svc_sock_enqueue(svsk);
 	svc_sock_put(svsk);
@@ -1679,11 +1680,10 @@ static int svc_deferred_recv(struct svc_
 static struct svc_deferred_req *svc_deferred_dequeue(struct svc_sock *svsk)
 {
 	struct svc_deferred_req *dr = NULL;
-	struct svc_serv	*serv = svsk->sk_server;
 	
 	if (!test_bit(SK_DEFERRED, &svsk->sk_flags))
 		return NULL;
-	spin_lock_bh(&serv->sv_lock);
+	spin_lock_bh(&svsk->sk_defer_lock);
 	clear_bit(SK_DEFERRED, &svsk->sk_flags);
 	if (!list_empty(&svsk->sk_deferred)) {
 		dr = list_entry(svsk->sk_deferred.next,
@@ -1692,6 +1692,6 @@ static struct svc_deferred_req *svc_defe
 		list_del_init(&dr->handle.recent);
 		set_bit(SK_DEFERRED, &svsk->sk_flags);
 	}
-	spin_unlock_bh(&serv->sv_lock);
+	spin_unlock_bh(&svsk->sk_defer_lock);
 	return dr;
 }
