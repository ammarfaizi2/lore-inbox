Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281174AbRKHAAx>; Wed, 7 Nov 2001 19:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281162AbRKHAAr>; Wed, 7 Nov 2001 19:00:47 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:19976 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S281161AbRKHAAk>; Wed, 7 Nov 2001 19:00:40 -0500
Date: Thu, 8 Nov 2001 01:00:24 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: <davem@redhat.com>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Andrew Morton <andrewm@uow.edu.au>,
        <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Andreas Dilger <adilger@turbolabs.com>,
        Networking Team <netdev@oss.sgi.com>, Andi Kleen <ak@muc.de>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Subject: [PATCH] net/ipv4/*, net/core/neighbour.c jiffies cleanup
Message-ID: <Pine.LNX.4.30.0111080003320.29364-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

jiffies cleanup patch of the day follows. Mostly boring changes of jiffies
comparisons to use time_{before,after} in order to handle jiffies
wraparound correctly.

However, two interesting points:

 - deciding on whether or not it is a problem on 64 bit platforms to
   declare the jiffies argument to ic_bootp_send_if as u32.
   Result: It's probably not a big deal to impose the condition on alphas,
   that DHCP/BOOTP must succeed within 48 days. On the other hand, it
   doesn't hurt to change it to unsigned long either, so I did that.

 - syn_flood_warning. No big deal that it did not warn within
   the first 60 seconds after boot. However, it also turns of
   warnings after 248 days on 32 bit platforms.
   While pretty much any other event may safely be assumed to happen more
   often than that, less than one synflood attack per year seems totally
   reasonable (desirable, in fact).

   I did not do anything about that yet. When I have submitted the patch
   to supply a get_jiffies64() routine, we should probably reexamine
   whether or not a call to a locking get_jiffies64() is acceptable
   in this place.

Extra measures taken this time to not again loose a compiler message ;-)

Tim



--- linux-2.4.14/net/core/neighbour.c	Mon Oct  1 18:19:56 2001
+++ linux-2.4.14-jiffies64/net/core/neighbour.c	Wed Nov  7 23:37:36 2001
@@ -136,7 +136,7 @@
 			if (atomic_read(&n->refcnt) == 1 &&
 			    !(n->nud_state&NUD_PERMANENT) &&
 			    (n->nud_state != NUD_INCOMPLETE ||
-			     jiffies - n->used > n->parms->retrans_time)) {
+			     time_after(jiffies, n->used + n->parms->retrans_time))) {
 				*np = n->next;
 				n->dead = 1;
 				shrunk = 1;
@@ -234,7 +234,7 @@

 	if (tbl->entries > tbl->gc_thresh3 ||
 	    (tbl->entries > tbl->gc_thresh2 &&
-	     now - tbl->last_flush > 5*HZ)) {
+	     time_after(now, tbl->last_flush + 5*HZ))) {
 		if (neigh_forced_gc(tbl) == 0 &&
 		    tbl->entries > tbl->gc_thresh3)
 			return NULL;
@@ -533,12 +533,12 @@
 	if (state&(NUD_NOARP|NUD_PERMANENT))
 		return;
 	if (state&NUD_REACHABLE) {
-		if (now - n->confirmed > n->parms->reachable_time) {
+		if (time_after(now, n->confirmed + n->parms->reachable_time)) {
 			n->nud_state = NUD_STALE;
 			neigh_suspect(n);
 		}
 	} else if (state&NUD_VALID) {
-		if (now - n->confirmed < n->parms->reachable_time) {
+		if (time_before(now, n->confirmed + n->parms->reachable_time)) {
 			neigh_del_timer(n);
 			n->nud_state = NUD_REACHABLE;
 			neigh_connect(n);
@@ -559,7 +559,7 @@
 	 *	periodicly recompute ReachableTime from random function
 	 */

-	if (now - tbl->last_rand > 300*HZ) {
+	if (time_after(now, tbl->last_rand + 300*HZ)) {
 		struct neigh_parms *p;
 		tbl->last_rand = now;
 		for (p=&tbl->parms; p; p = p->next)
@@ -585,7 +585,7 @@
 				n->used = n->confirmed;

 			if (atomic_read(&n->refcnt) == 1 &&
-			    (state == NUD_FAILED || now - n->used > n->parms->gc_staletime)) {
+			    (state == NUD_FAILED || time_after(now, n->used + n->parms->gc_staletime))) {
 				*np = n->next;
 				n->dead = 1;
 				write_unlock(&n->lock);
@@ -594,7 +594,7 @@
 			}

 			if (n->nud_state&NUD_REACHABLE &&
-			    now - n->confirmed > n->parms->reachable_time) {
+			    time_after(now, n->confirmed + n->parms->reachable_time)) {
 				n->nud_state = NUD_STALE;
 				neigh_suspect(n);
 			}
@@ -646,7 +646,7 @@
 	}

 	if ((state&NUD_VALID) &&
-	    now - neigh->confirmed < neigh->parms->reachable_time) {
+	    time_before(now, neigh->confirmed + neigh->parms->reachable_time)) {
 		neigh->nud_state = NUD_REACHABLE;
 		NEIGH_PRINTK2("neigh %p is still alive.\n", neigh);
 		neigh_connect(neigh);
--- linux-2.4.14/net/ipv4/arp.c	Fri Sep  7 20:01:20 2001
+++ linux-2.4.14-jiffies64/net/ipv4/arp.c	Wed Nov  7 22:35:19 2001
@@ -811,7 +811,7 @@
 		   agents are active. Taking the first reply prevents
 		   arp trashing and chooses the fastest router.
 		 */
-		if (jiffies - n->updated >= n->parms->locktime)
+		if (time_after_eq(jiffies, n->updated + n->parms->locktime))
 			override = 1;

 		/* Broadcast replies and request packets
--- linux-2.4.14/net/ipv4/route.c	Wed Oct 31 00:08:12 2001
+++ linux-2.4.14-jiffies64/net/ipv4/route.c	Wed Nov  7 22:51:23 2001
@@ -346,7 +346,7 @@
 		goto out;

 	ret = 1;
-	if (rth->u.dst.expires && (long)(rth->u.dst.expires - jiffies) <= 0)
+	if (rth->u.dst.expires && time_after_eq(jiffies, rth->u.dst.expires))
 		goto out;

 	age = jiffies - rth->u.dst.lastuse;
@@ -377,7 +377,7 @@
 		while ((rth = *rthp) != NULL) {
 			if (rth->u.dst.expires) {
 				/* Entry is expired even if it is in use */
-				if ((long)(now - rth->u.dst.expires) <= 0) {
+				if (time_before_eq(now, rth->u.dst.expires)) {
 					tmo >>= 1;
 					rthp = &rth->u.rt_next;
 					continue;
@@ -395,7 +395,7 @@
 		write_unlock(&rt_hash_table[i].lock);

 		/* Fallback loop breaker. */
-		if ((jiffies - now) > 0)
+		if (time_after(jiffies, now))
 			break;
 	}
 	rover = i;
@@ -499,7 +499,7 @@
 	 * Garbage collection is pretty expensive,
 	 * do not make it too frequently.
 	 */
-	if (now - last_gc < ip_rt_gc_min_interval &&
+	if (time_before(now, last_gc + ip_rt_gc_min_interval) &&
 	    atomic_read(&ipv4_dst_ops.entries) < ip_rt_max_size)
 		goto out;

@@ -522,7 +522,7 @@
 		equilibrium = atomic_read(&ipv4_dst_ops.entries) - goal;
 	}

-	if (now - last_gc >= ip_rt_gc_min_interval)
+	if (time_after_eq(now, last_gc + ip_rt_gc_min_interval))
 		last_gc = now;

 	if (goal <= 0) {
@@ -578,7 +578,7 @@

 		if (atomic_read(&ipv4_dst_ops.entries) < ip_rt_max_size)
 			goto out;
-	} while (!in_softirq() && jiffies - now < 1);
+	} while (!in_softirq() && !time_after(jiffies, now));

 	if (atomic_read(&ipv4_dst_ops.entries) < ip_rt_max_size)
 		goto out;
@@ -949,8 +949,8 @@
 	/* Check for load limit; set rate_last to the latest sent
 	 * redirect.
 	 */
-	if (jiffies - rt->u.dst.rate_last >
-	    (ip_rt_redirect_load << rt->u.dst.rate_tokens)) {
+	if (time_after(jiffies, rt->u.dst.rate_last +
+	                        (ip_rt_redirect_load << rt->u.dst.rate_tokens))) {
 		icmp_send(skb, ICMP_REDIRECT, ICMP_REDIR_HOST, rt->rt_gateway);
 		rt->u.dst.rate_last = jiffies;
 		++rt->u.dst.rate_tokens;
--- linux-2.4.14/net/ipv4/igmp.c	Sat Jul 28 21:12:38 2001
+++ linux-2.4.14-jiffies64/net/ipv4/igmp.c	Wed Nov  7 22:55:00 2001
@@ -121,7 +121,7 @@
  * contradict to specs provided this delay is small enough.
  */

-#define IGMP_V1_SEEN(in_dev) ((in_dev)->mr_v1_seen && (long)(jiffies - (in_dev)->mr_v1_seen) < 0)
+#define IGMP_V1_SEEN(in_dev) ((in_dev)->mr_v1_seen && time_before(jiffies, (in_dev)->mr_v1_seen))

 #endif

@@ -165,7 +165,7 @@
 	spin_lock_bh(&im->lock);
 	im->unsolicit_count = 0;
 	if (del_timer(&im->timer)) {
-		if ((long)(im->timer.expires-jiffies) < max_delay) {
+		if (time_before(im->timer.expires, jiffies + max_delay)) {
 			add_timer(&im->timer);
 			im->tm_running=1;
 			spin_unlock_bh(&im->lock);
--- linux-2.4.14/net/ipv4/ip_gre.c	Wed Oct 31 00:08:12 2001
+++ linux-2.4.14-jiffies64/net/ipv4/ip_gre.c	Wed Nov  7 22:56:37 2001
@@ -390,7 +390,7 @@
 	if (t->parms.iph.ttl == 0 && type == ICMP_TIME_EXCEEDED)
 		goto out;

-	if (jiffies - t->err_time < IPTUNNEL_ERR_TIMEO)
+	if (time_before(jiffies, t->err_time + IPTUNNEL_ERR_TIMEO))
 		t->err_count++;
 	else
 		t->err_count = 1;
@@ -796,7 +796,7 @@
 #endif

 	if (tunnel->err_count > 0) {
-		if (jiffies - tunnel->err_time < IPTUNNEL_ERR_TIMEO) {
+		if (time_before(jiffies, tunnel->err_time + IPTUNNEL_ERR_TIMEO)) {
 			tunnel->err_count--;

 			dst_link_failure(skb);
--- linux-2.4.14/net/ipv4/ipmr.c	Thu Sep 20 23:12:56 2001
+++ linux-2.4.14-jiffies64/net/ipv4/ipmr.c	Wed Nov  7 22:58:00 2001
@@ -1268,7 +1268,7 @@
 		       large chunk of pimd to kernel. Ough... --ANK
 		     */
 		    (mroute_do_pim || cache->mfc_un.res.ttls[true_vifi] < 255) &&
-		    jiffies - cache->mfc_un.res.last_assert > MFC_ASSERT_THRESH) {
+		    time_after(jiffies, cache->mfc_un.res.last_assert + MFC_ASSERT_THRESH)) {
 			cache->mfc_un.res.last_assert = jiffies;
 			ipmr_cache_report(skb, true_vifi, IGMPMSG_WRONGVIF);
 		}
--- linux-2.4.14/net/ipv4/tcp_timer.c	Mon Oct  1 18:19:57 2001
+++ linux-2.4.14-jiffies64/net/ipv4/tcp_timer.c	Wed Nov  7 23:01:23 2001
@@ -227,7 +227,7 @@
 	if (sk->state == TCP_CLOSE || !(tp->ack.pending&TCP_ACK_TIMER))
 		goto out;

-	if ((long)(tp->ack.timeout - jiffies) > 0) {
+	if (time_before(jiffies, tp->ack.timeout)) {
 		if (!mod_timer(&tp->delack_timer, tp->ack.timeout))
 			sock_hold(sk);
 		goto out;
@@ -429,7 +429,7 @@
 	if (sk->state == TCP_CLOSE || !tp->pending)
 		goto out;

-	if ((long)(tp->timeout - jiffies) > 0) {
+	if (time_before(jiffies, tp->timeout)) {
 		if (!mod_timer(&tp->retransmit_timer, tp->timeout))
 			sock_hold(sk);
 		goto out;
@@ -509,7 +509,7 @@
 	do {
 		reqp=&lopt->syn_table[i];
 		while ((req = *reqp) != NULL) {
-			if ((long)(now - req->expires) >= 0) {
+			if (time_after_eq(now, req->expires)) {
 				if ((req->retrans < thresh ||
 				     (req->acked && req->retrans < max_retries))
 				    && !req->class->rtx_syn_ack(sk, req, NULL)) {
--- linux-2.4.14/net/ipv4/tcp_ipv4.c	Mon Nov  5 18:46:12 2001
+++ linux-2.4.14-jiffies64/net/ipv4/tcp_ipv4.c	Wed Nov  7 23:10:21 2001
@@ -1213,10 +1213,10 @@

 static inline void syn_flood_warning(struct sk_buff *skb)
 {
-	static unsigned long warntime;
+	static unsigned long next_warntime;

-	if (jiffies - warntime > HZ*60) {
-		warntime = jiffies;
+	if (time_after(jiffies, next_warntime)) {
+		next_warntime = jiffies + 60*HZ;
 		printk(KERN_INFO
 		       "possible SYN flooding on port %d. Sending cookies.\n",
 		       ntohs(skb->h.th->dest));
--- linux-2.4.14/net/ipv4/ipconfig.c	Wed Oct 31 00:08:12 2001
+++ linux-2.4.14-jiffies64/net/ipv4/ipconfig.c	Wed Nov  7 23:28:47 2001
@@ -630,7 +630,7 @@
 /*
  *  Send DHCP/BOOTP request to single interface.
  */
-static void __init ic_bootp_send_if(struct ic_device *d, u32 jiffies)
+static void __init ic_bootp_send_if(struct ic_device *d, unsigned long jiffies)
 {
 	struct net_device *dev = d->dev;
 	struct sk_buff *skb;
@@ -1000,7 +1000,7 @@
 #endif

 		jiff = jiffies + (d->next ? CONF_INTER_TIMEOUT : timeout);
-		while (jiffies < jiff && !ic_got_reply)
+		while (time_before(jiffies, jiff) && !ic_got_reply)
 			barrier();
 #ifdef IPCONFIG_DHCP
 		/* DHCP isn't done until we get a DHCPACK. */
@@ -1113,7 +1113,7 @@
  try_try_again:
 	/* Give hardware a chance to settle */
 	jiff = jiffies + CONF_PRE_OPEN;
-	while (jiffies < jiff)
+	while (time_before(jiffies, jiff))
 		;

 	/* Setup all network devices */
@@ -1122,7 +1122,7 @@

 	/* Give drivers a chance to settle */
 	jiff = jiffies + CONF_POST_OPEN;
-	while (jiffies < jiff)
+	while (time_before(jiffies, jiff))
 			;

 	/*
--- linux-2.4.14/net/ipv4/tcp_minisocks.c	Mon Oct  1 18:19:57 2001
+++ linux-2.4.14-jiffies64/net/ipv4/tcp_minisocks.c	Thu Nov  8 00:40:37 2001
@@ -562,7 +562,7 @@
 			tcp_twcal_timer.expires = tcp_twcal_jiffie + (slot<<TCP_TW_RECYCLE_TICK);
 			add_timer(&tcp_twcal_timer);
 		} else {
-			if ((long)(tcp_twcal_timer.expires - jiffies) > (slot<<TCP_TW_RECYCLE_TICK))
+			if (time_after(tcp_twcal_timer.expires, jiffies + (slot<<TCP_TW_RECYCLE_TICK)))
 				mod_timer(&tcp_twcal_timer, jiffies + (slot<<TCP_TW_RECYCLE_TICK));
 			slot = (tcp_twcal_hand + slot)&(TCP_TW_RECYCLE_SLOTS-1);
 		}
@@ -595,7 +595,7 @@
 	j = tcp_twcal_jiffie;

 	for (n=0; n<TCP_TW_RECYCLE_SLOTS; n++) {
-		if ((long)(j - now) <= 0) {
+		if (time_before(j, now)) {
 			struct tcp_tw_bucket *tw;

 			while((tw = tcp_twcal_row[slot]) != NULL) {


