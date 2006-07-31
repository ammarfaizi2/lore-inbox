Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932494AbWGaAl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932494AbWGaAl5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 20:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbWGaAl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 20:41:56 -0400
Received: from ns2.suse.de ([195.135.220.15]:38029 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932494AbWGaAl4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 20:41:56 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 31 Jul 2006 10:41:47 +1000
Message-Id: <1060731004147.29183@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 001 of 11] knfsd: move tempsock aging to a timer
References: <20060731103458.29040.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Greg Banks <gnb@melbourne.sgi.com>

knfsd: Move the aging of RPC/TCP connection sockets from the main
svc_recv() loop to a timer which uses a mark-and-sweep algorithm
every 6 minutes.  This reduces the amount of work that needs to be
done in the main RPC loop and the length of time we need to hold
the (effectively global) svc_serv->sv_lock.


Signed-off-by: Greg Banks <gnb@melbourne.sgi.com>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./include/linux/sunrpc/svc.h     |    1 
 ./include/linux/sunrpc/svcsock.h |    2 
 ./net/sunrpc/svc.c               |    3 +
 ./net/sunrpc/svcsock.c           |   96 ++++++++++++++++++++++++++++-----------
 4 files changed, 76 insertions(+), 26 deletions(-)

diff .prev/include/linux/sunrpc/svc.h ./include/linux/sunrpc/svc.h
--- .prev/include/linux/sunrpc/svc.h	2006-07-28 11:54:16.000000000 +1000
+++ ./include/linux/sunrpc/svc.h	2006-07-31 09:56:44.000000000 +1000
@@ -40,6 +40,7 @@ struct svc_serv {
 	struct list_head	sv_permsocks;	/* all permanent sockets */
 	struct list_head	sv_tempsocks;	/* all temporary sockets */
 	int			sv_tmpcnt;	/* count of temporary sockets */
+	struct timer_list	sv_temptimer;	/* timer for aging temporary sockets */
 
 	char *			sv_name;	/* service name */
 

diff .prev/include/linux/sunrpc/svcsock.h ./include/linux/sunrpc/svcsock.h
--- .prev/include/linux/sunrpc/svcsock.h	2006-07-28 11:54:40.000000000 +1000
+++ ./include/linux/sunrpc/svcsock.h	2006-07-31 09:56:44.000000000 +1000
@@ -31,6 +31,8 @@ struct svc_sock {
 #define	SK_DEAD		6			/* socket closed */
 #define	SK_CHNGBUF	7			/* need to change snd/rcv buffer sizes */
 #define	SK_DEFERRED	8			/* request on sk_deferred */
+#define	SK_OLD		9			/* used for temp socket aging mark+sweep */
+#define	SK_DETACHED	10			/* detached from tempsocks list */
 
 	int			sk_reserved;	/* space on outq that is reserved */
 

diff .prev/net/sunrpc/svc.c ./net/sunrpc/svc.c
--- .prev/net/sunrpc/svc.c	2006-07-28 11:53:47.000000000 +1000
+++ ./net/sunrpc/svc.c	2006-07-31 09:56:44.000000000 +1000
@@ -59,6 +59,7 @@ svc_create(struct svc_program *prog, uns
 	INIT_LIST_HEAD(&serv->sv_sockets);
 	INIT_LIST_HEAD(&serv->sv_tempsocks);
 	INIT_LIST_HEAD(&serv->sv_permsocks);
+	init_timer(&serv->sv_temptimer);
 	spin_lock_init(&serv->sv_lock);
 
 	/* Remove any stale portmap registrations */
@@ -87,6 +88,8 @@ svc_destroy(struct svc_serv *serv)
 	} else
 		printk("svc_destroy: no threads for serv=%p!\n", serv);
 
+	del_timer_sync(&serv->sv_temptimer);
+
 	while (!list_empty(&serv->sv_tempsocks)) {
 		svsk = list_entry(serv->sv_tempsocks.next,
 				  struct svc_sock,

diff .prev/net/sunrpc/svcsock.c ./net/sunrpc/svcsock.c
--- .prev/net/sunrpc/svcsock.c	2006-07-28 11:55:15.000000000 +1000
+++ ./net/sunrpc/svcsock.c	2006-07-31 09:56:44.000000000 +1000
@@ -74,6 +74,13 @@ static struct svc_deferred_req *svc_defe
 static int svc_deferred_recv(struct svc_rqst *rqstp);
 static struct cache_deferred_req *svc_defer(struct cache_req *req);
 
+/* apparently the "standard" is that clients close
+ * idle connections after 5 minutes, servers after
+ * 6 minutes
+ *   http://www.connectathon.org/talks96/nfstcp.pdf
+ */
+static int svc_conn_age_period = 6*60;
+
 /*
  * Queue up an idle server thread.  Must have serv->sv_lock held.
  * Note: this is really a stack rather than a queue, so that we only
@@ -1230,24 +1237,7 @@ svc_recv(struct svc_rqst *rqstp, long ti
 		return -EINTR;
 
 	spin_lock_bh(&serv->sv_lock);
-	if (!list_empty(&serv->sv_tempsocks)) {
-		svsk = list_entry(serv->sv_tempsocks.next,
-				  struct svc_sock, sk_list);
-		/* apparently the "standard" is that clients close
-		 * idle connections after 5 minutes, servers after
-		 * 6 minutes
-		 *   http://www.connectathon.org/talks96/nfstcp.pdf 
-		 */
-		if (get_seconds() - svsk->sk_lastrecv < 6*60
-		    || test_bit(SK_BUSY, &svsk->sk_flags))
-			svsk = NULL;
-	}
-	if (svsk) {
-		set_bit(SK_BUSY, &svsk->sk_flags);
-		set_bit(SK_CLOSE, &svsk->sk_flags);
-		rqstp->rq_sock = svsk;
-		svsk->sk_inuse++;
-	} else if ((svsk = svc_sock_dequeue(serv)) != NULL) {
+	if ((svsk = svc_sock_dequeue(serv)) != NULL) {
 		rqstp->rq_sock = svsk;
 		svsk->sk_inuse++;
 		rqstp->rq_reserved = serv->sv_bufsz;	
@@ -1292,13 +1282,7 @@ svc_recv(struct svc_rqst *rqstp, long ti
 		return -EAGAIN;
 	}
 	svsk->sk_lastrecv = get_seconds();
-	if (test_bit(SK_TEMP, &svsk->sk_flags)) {
-		/* push active sockets to end of list */
-		spin_lock_bh(&serv->sv_lock);
-		if (!list_empty(&svsk->sk_list))
-			list_move_tail(&svsk->sk_list, &serv->sv_tempsocks);
-		spin_unlock_bh(&serv->sv_lock);
-	}
+	clear_bit(SK_OLD, &svsk->sk_flags);
 
 	rqstp->rq_secure  = ntohs(rqstp->rq_addr.sin_port) < 1024;
 	rqstp->rq_chandle.defer = svc_defer;
@@ -1358,6 +1342,58 @@ svc_send(struct svc_rqst *rqstp)
 }
 
 /*
+ * Timer function to close old temporary sockets, using
+ * a mark-and-sweep algorithm.
+ */
+static void
+svc_age_temp_sockets(unsigned long closure)
+{
+	struct svc_serv *serv = (struct svc_serv *)closure;
+	struct svc_sock *svsk;
+	struct list_head *le, *next;
+	LIST_HEAD(to_be_aged);
+
+	dprintk("svc_age_temp_sockets\n");
+
+	if (!spin_trylock_bh(&serv->sv_lock)) {
+		/* busy, try again 1 sec later */
+		dprintk("svc_age_temp_sockets: busy\n");
+		mod_timer(&serv->sv_temptimer, jiffies + HZ);
+		return;
+	}
+
+	list_for_each_safe(le, next, &serv->sv_tempsocks) {
+		svsk = list_entry(le, struct svc_sock, sk_list);
+
+		if (!test_and_set_bit(SK_OLD, &svsk->sk_flags))
+			continue;
+		if (svsk->sk_inuse || test_bit(SK_BUSY, &svsk->sk_flags))
+			continue;
+		svsk->sk_inuse++;
+		list_move(le, &to_be_aged);
+		set_bit(SK_CLOSE, &svsk->sk_flags);
+		set_bit(SK_DETACHED, &svsk->sk_flags);
+	}
+	spin_unlock_bh(&serv->sv_lock);
+
+	while (!list_empty(&to_be_aged)) {
+		le = to_be_aged.next;
+		/* fiddling the sk_list node is safe 'cos we're SK_DETACHED */
+		list_del_init(le);
+		svsk = list_entry(le, struct svc_sock, sk_list);
+
+		dprintk("queuing svsk %p for closing, %lu seconds old\n",
+			svsk, get_seconds() - svsk->sk_lastrecv);
+
+		/* a thread will dequeue and close it soon */
+		svc_sock_enqueue(svsk);
+		svc_sock_put(svsk);
+	}
+
+	mod_timer(&serv->sv_temptimer, jiffies + svc_conn_age_period * HZ);
+}
+
+/*
  * Initialize socket for RPC use and create svc_sock struct
  * XXX: May want to setsockopt SO_SNDBUF and SO_RCVBUF.
  */
@@ -1410,6 +1446,13 @@ svc_setup_socket(struct svc_serv *serv, 
 		set_bit(SK_TEMP, &svsk->sk_flags);
 		list_add(&svsk->sk_list, &serv->sv_tempsocks);
 		serv->sv_tmpcnt++;
+		if (serv->sv_temptimer.function == NULL) {
+			/* setup timer to age temp sockets */
+			serv->sv_temptimer.function = svc_age_temp_sockets;
+			serv->sv_temptimer.data = (unsigned long)serv;
+			serv->sv_temptimer.expires = jiffies + svc_conn_age_period * HZ;
+			add_timer(&serv->sv_temptimer);
+		}
 	} else {
 		clear_bit(SK_TEMP, &svsk->sk_flags);
 		list_add(&svsk->sk_list, &serv->sv_permsocks);
@@ -1525,7 +1568,8 @@ svc_delete_socket(struct svc_sock *svsk)
 
 	spin_lock_bh(&serv->sv_lock);
 
-	list_del_init(&svsk->sk_list);
+	if (!test_and_set_bit(SK_DETACHED, &svsk->sk_flags))
+		list_del_init(&svsk->sk_list);
 	list_del_init(&svsk->sk_ready);
 	if (!test_and_set_bit(SK_DEAD, &svsk->sk_flags))
 		if (test_bit(SK_TEMP, &svsk->sk_flags))
