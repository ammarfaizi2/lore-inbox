Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261729AbULOBid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261729AbULOBid (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 20:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261822AbULOBgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 20:36:21 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:43534 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261828AbULOBXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 20:23:54 -0500
Date: Wed, 15 Dec 2004 02:23:47 +0100
From: Adrian Bunk <bunk@stusta.de>
To: ralf@linux-mips.org
Cc: linux-hams@vger.kernel.org, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] net/rose/: misc possible cleanups
Message-ID: <20041215012347.GF12937@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below contains the following possible cleanups:
- make some needlessly global code static
- remove the followingunused global functions:
  - rose_dev.c: rose_rx_ip
  - rose_link.c: rose_transmit_diagnostic

Please comment on which of these changes are correct and which conflict
with pending patches.


diffstat output:
 include/net/rose.h    |    8 --------
 net/rose/af_rose.c    |    2 +-
 net/rose/rose_dev.c   |   32 --------------------------------
 net/rose/rose_link.c  |   39 +++++++--------------------------------
 net/rose/rose_route.c |    4 ++--
 net/rose/rose_subr.c  |    4 +++-
 6 files changed, 13 insertions(+), 76 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc3-mm1-full/include/net/rose.h.old	2004-12-14 21:51:28.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/include/net/rose.h	2004-12-14 21:55:21.000000000 +0100
@@ -162,7 +162,6 @@
 extern void rose_destroy_socket(struct sock *);
 
 /* rose_dev.c */
-extern int  rose_rx_ip(struct sk_buff *, struct net_device *);
 extern void  rose_setup(struct net_device *);
 
 /* rose_in.c */
@@ -170,15 +169,10 @@
 
 /* rose_link.c */
 extern void rose_start_ftimer(struct rose_neigh *);
-extern void rose_start_t0timer(struct rose_neigh *);
 extern void rose_stop_ftimer(struct rose_neigh *);
 extern void rose_stop_t0timer(struct rose_neigh *);
 extern int  rose_ftimer_running(struct rose_neigh *);
-extern int  rose_t0timer_running(struct rose_neigh *);
 extern void rose_link_rx_restart(struct sk_buff *, struct rose_neigh *, unsigned short);
-extern void rose_transmit_restart_request(struct rose_neigh *);
-extern void rose_transmit_restart_confirmation(struct rose_neigh *);
-extern void rose_transmit_diagnostic(struct rose_neigh *, unsigned char);
 extern void rose_transmit_clear_request(struct rose_neigh *, unsigned int, unsigned char, unsigned char);
 extern void rose_transmit_link(struct sk_buff *, struct rose_neigh *);
 
@@ -205,7 +199,6 @@
 extern struct net_device *rose_dev_first(void);
 extern struct net_device *rose_dev_get(rose_address *);
 extern struct rose_route *rose_route_free_lci(unsigned int, struct rose_neigh *);
-extern struct net_device *rose_ax25_dev_get(char *);
 extern struct rose_neigh *rose_get_neigh(rose_address *, unsigned char *, unsigned char *);
 extern int  rose_rt_ioctl(unsigned int, void __user *);
 extern void rose_link_failed(ax25_cb *, int);
@@ -220,7 +213,6 @@
 extern void rose_write_internal(struct sock *, int);
 extern int  rose_decode(struct sk_buff *, int *, int *, int *, int *, int *);
 extern int  rose_parse_facilities(unsigned char *, struct rose_facilities_struct *);
-extern int  rose_create_facilities(unsigned char *, rose_cb *);
 extern void rose_disconnect(struct sock *, int, int, int);
 
 /* rose_timer.c */
--- linux-2.6.10-rc3-mm1-full/net/rose/af_rose.c.old	2004-12-14 21:51:01.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/rose/af_rose.c	2004-12-14 21:51:09.000000000 +0100
@@ -59,7 +59,7 @@
 int sysctl_rose_window_size             = ROSE_DEFAULT_WINDOW_SIZE;
 
 static HLIST_HEAD(rose_list);
-spinlock_t rose_list_lock = SPIN_LOCK_UNLOCKED;
+static spinlock_t rose_list_lock = SPIN_LOCK_UNLOCKED;
 
 static struct proto_ops rose_proto_ops;
 
--- linux-2.6.10-rc3-mm1-full/net/rose/rose_dev.c.old	2004-12-14 21:51:42.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/rose/rose_dev.c	2004-12-14 21:52:08.000000000 +0100
@@ -37,38 +37,6 @@
 #include <net/ax25.h>
 #include <net/rose.h>
 
-/*
- *	Only allow IP over ROSE frames through if the netrom device is up.
- */
-
-int rose_rx_ip(struct sk_buff *skb, struct net_device *dev)
-{
-	struct net_device_stats *stats = (struct net_device_stats *)dev->priv;
-
-#ifdef CONFIG_INET
-	if (!netif_running(dev)) {
-		stats->rx_errors++;
-		return 0;
-	}
-
-	stats->rx_packets++;
-	stats->rx_bytes += skb->len;
-
-	skb->protocol = htons(ETH_P_IP);
-
-	/* Spoof incoming device */
-	skb->dev      = dev;
-	skb->h.raw    = skb->data;
-	skb->nh.raw   = skb->data;
-	skb->pkt_type = PACKET_HOST;
-
-	ip_rcv(skb, skb->dev, NULL);
-#else
-	kfree_skb(skb);
-#endif
-	return 1;
-}
-
 static int rose_header(struct sk_buff *skb, struct net_device *dev, unsigned short type,
 	void *daddr, void *saddr, unsigned len)
 {
--- linux-2.6.10-rc3-mm1-full/net/rose/rose_link.c.old	2004-12-14 21:52:37.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/rose/rose_link.c	2004-12-14 21:54:23.000000000 +0100
@@ -31,6 +31,9 @@
 static void rose_ftimer_expiry(unsigned long);
 static void rose_t0timer_expiry(unsigned long);
 
+static void rose_transmit_restart_confirmation(struct rose_neigh *neigh);
+static void rose_transmit_restart_request(struct rose_neigh *neigh);
+
 void rose_start_ftimer(struct rose_neigh *neigh)
 {
 	del_timer(&neigh->ftimer);
@@ -42,7 +45,7 @@
 	add_timer(&neigh->ftimer);
 }
 
-void rose_start_t0timer(struct rose_neigh *neigh)
+static void rose_start_t0timer(struct rose_neigh *neigh)
 {
 	del_timer(&neigh->t0timer);
 
@@ -68,7 +71,7 @@
 	return timer_pending(&neigh->ftimer);
 }
 
-int rose_t0timer_running(struct rose_neigh *neigh)
+static int rose_t0timer_running(struct rose_neigh *neigh)
 {
 	return timer_pending(&neigh->t0timer);
 }
@@ -165,7 +168,7 @@
 /*
  *	This routine is called when a Restart Request is needed
  */
-void rose_transmit_restart_request(struct rose_neigh *neigh)
+static void rose_transmit_restart_request(struct rose_neigh *neigh)
 {
 	struct sk_buff *skb;
 	unsigned char *dptr;
@@ -194,7 +197,7 @@
 /*
  * This routine is called when a Restart Confirmation is needed
  */
-void rose_transmit_restart_confirmation(struct rose_neigh *neigh)
+static void rose_transmit_restart_confirmation(struct rose_neigh *neigh)
 {
 	struct sk_buff *skb;
 	unsigned char *dptr;
@@ -219,34 +222,6 @@
 }
 
 /*
- * This routine is called when a Diagnostic is required.
- */
-void rose_transmit_diagnostic(struct rose_neigh *neigh, unsigned char diag)
-{
-	struct sk_buff *skb;
-	unsigned char *dptr;
-	int len;
-
-	len = AX25_BPQ_HEADER_LEN + AX25_MAX_HEADER_LEN + ROSE_MIN_LEN + 2;
-
-	if ((skb = alloc_skb(len, GFP_ATOMIC)) == NULL)
-		return;
-
-	skb_reserve(skb, AX25_BPQ_HEADER_LEN + AX25_MAX_HEADER_LEN);
-
-	dptr = skb_put(skb, ROSE_MIN_LEN + 2);
-
-	*dptr++ = AX25_P_ROSE;
-	*dptr++ = ROSE_GFI;
-	*dptr++ = 0x00;
-	*dptr++ = ROSE_DIAGNOSTIC;
-	*dptr++ = diag;
-
-	if (!rose_send_frame(skb, neigh))
-		kfree_skb(skb);
-}
-
-/*
  * This routine is called when a Clear Request is needed outside of the context
  * of a connected socket.
  */
--- linux-2.6.10-rc3-mm1-full/net/rose/rose_route.c.old	2004-12-14 21:54:45.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/rose/rose_route.c	2004-12-14 21:55:09.000000000 +0100
@@ -41,7 +41,7 @@
 
 static struct rose_node  *rose_node_list;
 static spinlock_t rose_node_list_lock = SPIN_LOCK_UNLOCKED;
-struct rose_neigh *rose_neigh_list;
+static struct rose_neigh *rose_neigh_list;
 static spinlock_t rose_neigh_list_lock = SPIN_LOCK_UNLOCKED;
 static struct rose_route *rose_route_list;
 static spinlock_t rose_route_list_lock = SPIN_LOCK_UNLOCKED;
@@ -587,7 +587,7 @@
 /*
  *	Check that the device given is a valid AX.25 interface that is "up".
  */
-struct net_device *rose_ax25_dev_get(char *devname)
+static struct net_device *rose_ax25_dev_get(char *devname)
 {
 	struct net_device *dev;
 
--- linux-2.6.10-rc3-mm1-full/net/rose/rose_subr.c.old	2004-12-14 21:55:28.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/rose/rose_subr.c	2004-12-14 21:55:42.000000000 +0100
@@ -28,6 +28,8 @@
 #include <linux/interrupt.h>
 #include <net/rose.h>
 
+static int rose_create_facilities(unsigned char *buffer, rose_cb *rose);
+
 /*
  *	This routine purges all of the queues of frames.
  */
@@ -394,7 +396,7 @@
 	return 1;
 }
 
-int rose_create_facilities(unsigned char *buffer, rose_cb *rose)
+static int rose_create_facilities(unsigned char *buffer, rose_cb *rose)
 {
 	unsigned char *p = buffer + 1;
 	char *callsign;

