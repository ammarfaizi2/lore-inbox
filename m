Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261632AbVAHVla@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261632AbVAHVla (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 16:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbVAHVl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 16:41:29 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:29188 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261632AbVAHVkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 16:40:10 -0500
Date: Sat, 8 Jan 2005 22:40:03 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: patrick@tykepenguin.com, Steve Whitehouse <SteveW@ACM.org>,
       linux-decnet-user@lists.sourceforge.net, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] net/decnet/: misc possible cleanups (fwd)
Message-ID: <20050108214003.GS14108@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch forwarded below (already ACK'ed by Patrick Caulfield) still 
applies and compiles against 2.6.10-mm2.

Please apply.


----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Tue, 14 Dec 2004 13:58:38 +0100
From: Adrian Bunk <bunk@stusta.de>
To: patrick@tykepenguin.com, Steve Whitehouse <SteveW@ACM.org>
Cc: linux-decnet-user@lists.sourceforge.net, netdev@oss.sgi.com,
	linux-kernel@vger.kernel.org
Subject: [2.6 patch] net/decnet/: misc possible cleanups

The patch below contains the following possible cleanups:
- make needlessly global code static
- dn_fib.c: remove the write-only global variable dn_fib_info_cnt
- dn_fib.c: remove the unused global function dn_fib_rt_message
- dn_neigh.c: remove the unused global function dn_neigh_pointopoint_notify
- dn_timer.c: remove the fast timer code that isn't used

Please review and comment on this patch.


diffstat output:
 include/net/dn.h       |    2 -
 include/net/dn_fib.h   |    1 
 net/decnet/af_decnet.c |    6 +----
 net/decnet/dn_fib.c    |   15 -------------
 net/decnet/dn_neigh.c  |    8 ------
 net/decnet/dn_route.c  |    6 ++---
 net/decnet/dn_timer.c  |   47 -----------------------------------------
 7 files changed, 5 insertions(+), 80 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc3-mm1-full/net/decnet/af_decnet.c.old	2004-12-14 03:30:13.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/decnet/af_decnet.c	2004-12-14 03:47:00.000000000 +0100
@@ -246,7 +246,7 @@
 	write_unlock_bh(&dn_hash_lock);
 }
 
-struct hlist_head *listen_hash(struct sockaddr_dn *addr)
+static struct hlist_head *listen_hash(struct sockaddr_dn *addr)
 {
 	int i;
 	unsigned hash = addr->sdn_objnum;
@@ -447,7 +447,7 @@
 	dst_release(xchg(&sk->sk_dst_cache, NULL));
 }
 
-struct sock *dn_alloc_sock(struct socket *sock, int gfp)
+static struct sock *dn_alloc_sock(struct socket *sock, int gfp)
 {
 	struct dn_scp *scp;
 	struct sock *sk = sk_alloc(PF_DECnet, gfp, sizeof(struct dn_sock),
@@ -578,7 +578,6 @@
 	if (sk->sk_socket)
 		return 0;
 
-	dn_stop_fast_timer(sk); /* unlikely, but possible that this is runninng */
 	if ((jiffies - scp->stamp) >= (HZ * decnet_time_wait)) {
 		dn_unhash_sock(sk);
 		sock_put(sk);
@@ -631,7 +630,6 @@
 		default:
 			printk(KERN_DEBUG "DECnet: dn_destroy_sock passed socket in invalid state\n");
 		case DN_O:
-			dn_stop_fast_timer(sk);
 			dn_stop_slow_timer(sk);
 
 			dn_unhash_sock_bh(sk);
--- linux-2.6.10-rc3-mm1-full/include/net/dn_fib.h.old	2004-12-14 03:32:14.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/include/net/dn_fib.h	2004-12-14 03:32:19.000000000 +0100
@@ -117,7 +117,6 @@
 extern void dn_fib_init(void);
 extern void dn_fib_cleanup(void);
 
-extern int dn_fib_rt_message(struct sk_buff *skb);
 extern int dn_fib_ioctl(struct socket *sock, unsigned int cmd, 
 			unsigned long arg);
 extern struct dn_fib_info *dn_fib_create_info(const struct rtmsg *r, 
--- linux-2.6.10-rc3-mm1-full/net/decnet/dn_fib.c.old	2004-12-14 03:31:33.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/decnet/dn_fib.c	2004-12-14 03:32:31.000000000 +0100
@@ -60,7 +60,6 @@
 static spinlock_t dn_fib_multipath_lock = SPIN_LOCK_UNLOCKED;
 static struct dn_fib_info *dn_fib_info_list;
 static rwlock_t dn_fib_info_lock = RW_LOCK_UNLOCKED;
-int dn_fib_info_cnt;
 
 static struct
 {
@@ -93,7 +92,6 @@
 			dev_put(nh->nh_dev);
 		nh->nh_dev = NULL;
 	} endfor_nexthops(fi);
-	dn_fib_info_cnt--;
 	kfree(fi);
 }
 
@@ -388,7 +386,6 @@
 	if (dn_fib_info_list)
 		dn_fib_info_list->fib_prev = fi;
 	dn_fib_info_list = fi;
-	dn_fib_info_cnt++;
 	write_unlock(&dn_fib_info_lock);
 	return fi;
 
@@ -486,18 +483,6 @@
 }
 
 
-/*
- * Punt to user via netlink for example, but for now
- * we just drop it.
- */
-int dn_fib_rt_message(struct sk_buff *skb)
-{
-	kfree_skb(skb);
-
-	return 0;
-}
-
-
 static int dn_fib_check_attr(struct rtmsg *r, struct rtattr **rta)
 {
 	int i;
--- linux-2.6.10-rc3-mm1-full/net/decnet/dn_neigh.c.old	2004-12-14 03:32:55.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/decnet/dn_neigh.c	2004-12-14 03:33:29.000000000 +0100
@@ -355,14 +355,6 @@
  * basically does a neigh_lookup(), but without comparing the device
  * field. This is required for the On-Ethernet cache
  */
-/*
- * Any traffic on a pointopoint link causes the timer to be reset
- * for the entry in the neighbour table.
- */
-void dn_neigh_pointopoint_notify(struct sk_buff *skb)
-{
-	return;
-}
 
 /*
  * Pointopoint link receives a hello message
--- linux-2.6.10-rc3-mm1-full/net/decnet/dn_route.c.old	2004-12-14 03:33:53.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/decnet/dn_route.c	2004-12-14 03:34:54.000000000 +0100
@@ -99,9 +99,9 @@
 
 static unsigned char dn_hiord_addr[6] = {0xAA,0x00,0x04,0x00,0x00,0x00};
 
-int dn_rt_min_delay = 2 * HZ;
-int dn_rt_max_delay = 10 * HZ;
-int dn_rt_mtu_expires = 10 * 60 * HZ;
+static const int dn_rt_min_delay = 2 * HZ;
+static const int dn_rt_max_delay = 10 * HZ;
+static const int dn_rt_mtu_expires = 10 * 60 * HZ;
 
 static unsigned long dn_rt_deadline;
 
--- linux-2.6.10-rc3-mm1-full/include/net/dn.h.old	2004-12-14 03:35:13.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/include/net/dn.h	2004-12-14 03:46:38.000000000 +0100
@@ -220,8 +220,6 @@
 
 extern void dn_start_slow_timer(struct sock *sk);
 extern void dn_stop_slow_timer(struct sock *sk);
-extern void dn_start_fast_timer(struct sock *sk);
-extern void dn_stop_fast_timer(struct sock *sk);
 
 extern dn_address decnet_address;
 extern int decnet_debug_level;
--- linux-2.6.10-rc3-mm1-full/net/decnet/dn_timer.c.old	2004-12-14 03:35:29.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/decnet/dn_timer.c	2004-12-14 03:48:49.000000000 +0100
@@ -27,11 +27,9 @@
 #include <net/dn.h>
 
 /*
- * Fast timer is for delayed acks (200mS max)
  * Slow timer is for everything else (n * 500mS)
  */
 
-#define FAST_INTERVAL (HZ/5)
 #define SLOW_INTERVAL (HZ/2)
 
 static void dn_slow_timer(unsigned long arg);
@@ -109,48 +107,3 @@
 	bh_unlock_sock(sk);
 	sock_put(sk);
 }
-
-static void dn_fast_timer(unsigned long arg)
-{
-	struct sock *sk = (struct sock *)arg;
-	struct dn_scp *scp = DN_SK(sk);
-
-	bh_lock_sock(sk);
-	if (sock_owned_by_user(sk)) {
-		scp->delack_timer.expires = jiffies + HZ / 20;
-		add_timer(&scp->delack_timer);
-		goto out;
-	}
-
-	scp->delack_pending = 0;
-
-	if (scp->delack_fxn)
-		scp->delack_fxn(sk);
-out:
-	bh_unlock_sock(sk);
-}
-
-void dn_start_fast_timer(struct sock *sk)
-{
-	struct dn_scp *scp = DN_SK(sk);
-
-	if (!scp->delack_pending) {
-		scp->delack_pending = 1;
-		init_timer(&scp->delack_timer);
-		scp->delack_timer.expires = jiffies + FAST_INTERVAL;
-		scp->delack_timer.data = (unsigned long)sk;
-		scp->delack_timer.function = dn_fast_timer;
-		add_timer(&scp->delack_timer);
-	}
-}
-
-void dn_stop_fast_timer(struct sock *sk)
-{
-	struct dn_scp *scp = DN_SK(sk);
-
-	if (scp->delack_pending) {
-		scp->delack_pending = 0;
-		del_timer(&scp->delack_timer);
-	}
-}
-

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

