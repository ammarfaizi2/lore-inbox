Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274305AbRJQCt2>; Tue, 16 Oct 2001 22:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274255AbRJQCtK>; Tue, 16 Oct 2001 22:49:10 -0400
Received: from jpnsmtp1w.core.hp.com ([128.88.255.114]:58377 "HELO
	jpnsmtp1w.core.hp.com") by vger.kernel.org with SMTP
	id <S274248AbRJQCsx>; Tue, 16 Oct 2001 22:48:53 -0400
Message-Id: <200110170247.f9H2l7g23588@hpujffg8.jpn.hp.com>
To: linux-kernel@vger.kernel.org
Subject: New virtual ethernet driver submitting...
Date: Wed, 17 Oct 2001 11:47:07 +0900
From: Katsuyuki Yumoto <yumoto@jpn.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I've already written new two drivers of virtual ethernet. These
aggregate(bundle) plural physical or virtual ethernet devices to
single.

1. Link aggregation driver based on IEEE 802.3ad spec.
2. Link redundancy driver based on my original specification (but
   simple and easy to use).

These can be accessed via my WWW site.
http://www.st.rim.or.jp/~yumo
 -> veth-0.4.0.tar.gz (link aggregation)
 -> lr-0.4.0.tar.gz (link redundancy)

I think these are useful for improving performance and availability of
Linux machines. I'd like to submit those, but there are some issues.

- They need a small patch for network core codes(see below), which
  does intercept all the packets incoming via physical interfaces.

  Also, especially link aggregation driver need to get property of
  physical ethernet devices correctly by standard method. -- E.g. link
  status (up or down), link speed and duplex mode. However at this
  time point, each ethernet driver does not report such property by
  standard method. Therefore my small patch introduces such common data
  structure.

- Patch for 2.2.x contains also physical device driver module locking
  code using module reference count. (Patch for 2.4.x does not contain
  it because 2.4.x already has such function.)

  Purpose of this additional patch is avoiding fault because of
  deletion of physical driver module by user before virtual ethernet
  driver release them.

I'd like comments or advices to submit them.

Regards,
Yumo (Katsuyuki Yumoto)

----- Patch for 2.4.0 -----
diff -u -N -r linux.b/include/linux/if_ether.h linux/include/linux/if_ether.h
--- linux.b/include/linux/if_ether.h	Sat Oct 28 03:03:14 2000
+++ linux/include/linux/if_ether.h	Tue May  1 12:23:44 2001
@@ -82,6 +82,7 @@
 #define ETH_P_CONTROL	0x0016		/* Card specific control frames */
 #define ETH_P_IRDA	0x0017		/* Linux-IrDA			*/
 #define ETH_P_ECONET	0x0018		/* Acorn Econet			*/
+#define ETH_P_VETH	0x0019		/* Linux Link Aggregation	*/
 
 /*
  *	This is an Ethernet frame header.
diff -u -N -r linux.b/include/linux/netdevice.h linux/include/linux/netdevice.h
--- linux.b/include/linux/netdevice.h	Fri Jan  5 07:51:20 2001
+++ linux/include/linux/netdevice.h	Tue May  1 12:23:44 2001
@@ -121,6 +121,12 @@
 	/* for cslip etc */
 	unsigned long	rx_compressed;
 	unsigned long	tx_compressed;
+
+	/* for Ethernet devices */
+	unsigned long	media;
+	unsigned long	duplex_mode;
+	int		link_stat;
+
 };
 
 
@@ -132,7 +138,24 @@
         IF_PORT_AUI,
         IF_PORT_100BASET,
         IF_PORT_100BASETX,
-        IF_PORT_100BASEFX
+        IF_PORT_100BASEFX,
+	IF_PORT_1000BASET,
+	IF_PORT_1000BASESX,
+	IF_PORT_1000BASELX
+};
+
+/* Ethernet device link status */
+enum {
+	IF_PORT_LINK_UNKNOWN = 0,
+	IF_PORT_LINK_DOWN,
+	IF_PORT_LINK_UP
+};
+
+/* Ethernet device duplex mode status */
+enum {
+	IF_PORT_DUPLEX_UNKNOWN = 0,
+	IF_PORT_DUPLEX_HALF,
+	IF_PORT_DUPLEX_FULL
 };
 
 #ifdef __KERNEL__
@@ -320,6 +343,9 @@
 	struct Qdisc		*qdisc_list;
 	struct Qdisc		*qdisc_ingress;
 	unsigned long		tx_queue_len;	/* Max frames per queue allowed */
+
+	/* Intercepted ptype */
+	unsigned short		intercepted_ptype;		
 
 	/* hard_start_xmit synchronizer */
 	spinlock_t		xmit_lock;
diff -u -N -r linux.b/net/core/dev.c linux/net/core/dev.c
--- linux.b/net/core/dev.c	Tue Dec 12 06:29:35 2000
+++ linux/net/core/dev.c	Tue May  1 12:23:44 2001
@@ -1346,9 +1346,20 @@
 		{
 			struct packet_type *ptype, *pt_prev;
 			unsigned short type = skb->protocol;
+			unsigned short i_ptype;
 
 			pt_prev = NULL;
-			for (ptype = ptype_all; ptype; ptype = ptype->next) {
+			i_ptype = skb->dev->intercepted_ptype;
+			if (i_ptype){
+				for (ptype = ptype_base[i_ptype&15]; ptype != NULL; ptype = ptype->next) {
+					if (ntohs(ptype->type) == i_ptype) {
+						/* Remember the current last to do */
+						pt_prev=ptype;
+					}
+				}
+			}
+
+			for (ptype = ptype_all; !i_ptype && ptype; ptype = ptype->next) {
 				if (!ptype->dev || ptype->dev == skb->dev) {
 					if (pt_prev) {
 						if (!pt_prev->data) {
@@ -1379,7 +1390,7 @@
 			}
 #endif
 
-			for (ptype=ptype_base[ntohs(type)&15];ptype;ptype=ptype->next) {
+			for (ptype=ptype_base[ntohs(type)&15]; !i_ptype && ptype;ptype=ptype->next) {
 				if (ptype->type == type &&
 				    (!ptype->dev || ptype->dev == skb->dev)) {
 					if (pt_prev) {
@@ -2341,6 +2352,7 @@
 			}
 		}
 		dev->next = NULL;
+		dev->intercepted_ptype = 0;
 		write_lock_bh(&dev_base_lock);
 		*dp = dev;
 		dev_hold(dev);
----- End fo patch for 2.4.0---

----- Patch for 2.2.19 -----
diff -u -N -r linux.b/include/linux/if_ether.h linux/include/linux/if_ether.h
--- linux.b/include/linux/if_ether.h	Mon Mar 26 01:31:03 2001
+++ linux/include/linux/if_ether.h	Fri Oct 12 07:28:13 2001
@@ -79,6 +79,7 @@
 #define ETH_P_MOBITEX	0x0015		/* Mobitex (kaz@cafe.net)	*/
 #define ETH_P_CONTROL	0x0016		/* Card specific control frames */
 #define ETH_P_IRDA	0x0017		/* Linux/IR			*/
+#define ETH_P_VETH	0x0018		/* Linux Link Aggregation	*/
 
 /*
  *	This is an Ethernet frame header.
diff -u -N -r linux.b/include/linux/module.h linux/include/linux/module.h
--- linux.b/include/linux/module.h	Mon Mar 26 01:31:04 2001
+++ linux/include/linux/module.h	Fri Oct 12 07:30:30 2001
@@ -146,6 +146,7 @@
 static inline unsigned long get_module_symbol(char *A, char *B) { return 0; };
 #else
 extern unsigned long get_module_symbol(char *, char *);
+extern struct module *find_module(const char *);
 #endif
 #if defined(MODULE) && !defined(__GENKSYMS__)
 
diff -u -N -r linux.b/include/linux/netdevice.h linux/include/linux/netdevice.h
--- linux.b/include/linux/netdevice.h	Mon Mar 26 01:31:03 2001
+++ linux/include/linux/netdevice.h	Fri Oct 12 07:28:13 2001
@@ -105,6 +105,12 @@
 	/* for cslip etc */
 	unsigned long	rx_compressed;
 	unsigned long	tx_compressed;
+
+	/* for Ethernet devices */
+	unsigned long	media;
+	unsigned long	duplex_mode;
+	int		link_stat;
+
 };
 
 #ifdef CONFIG_NET_FASTROUTE
@@ -125,7 +131,24 @@
         IF_PORT_AUI,
         IF_PORT_100BASET,
         IF_PORT_100BASETX,
-        IF_PORT_100BASEFX
+        IF_PORT_100BASEFX,
+	IF_PORT_1000BASET,
+	IF_PORT_1000BASESX,
+	IF_PORT_1000BASELX
+};
+
+/* Ethernet device link status */
+enum {
+	IF_PORT_LINK_UNKNOWN = 0,
+	IF_PORT_LINK_DOWN,
+	IF_PORT_LINK_UP
+};
+
+/* Ethernet device duplex mode status */
+enum {
+	IF_PORT_DUPLEX_UNKNOWN = 0,
+	IF_PORT_DUPLEX_HALF,
+	IF_PORT_DUPLEX_FULL
 };
 
 #ifdef __KERNEL__
@@ -269,6 +292,9 @@
 	struct Qdisc		*qdisc_sleeping;
 	struct Qdisc		*qdisc_list;
 	unsigned long		tx_queue_len;	/* Max frames per queue allowed */
+
+	/* Intercepted ptype */
+	unsigned short		intercepted_ptype;		
 
 	/* Bridge stuff */
 	int			bridge_port_id;		
diff -u -N -r linux.b/kernel/ksyms.c linux/kernel/ksyms.c
--- linux.b/kernel/ksyms.c	Mon Mar 26 01:31:02 2001
+++ linux/kernel/ksyms.c	Fri Oct 12 07:28:13 2001
@@ -81,6 +81,7 @@
 
 #ifdef CONFIG_MODULES
 EXPORT_SYMBOL(get_module_symbol);
+EXPORT_SYMBOL(find_module);
 #endif
 EXPORT_SYMBOL(get_options);
 
diff -u -N -r linux.b/kernel/module.c linux/kernel/module.c
--- linux.b/kernel/module.c	Mon Mar 26 01:31:02 2001
+++ linux/kernel/module.c	Fri Oct 12 07:28:13 2001
@@ -50,7 +50,7 @@
 
 static long get_mod_name(const char *user_name, char **buf);
 static void put_mod_name(char *buf);
-static struct module *find_module(const char *name);
+/*struct module *find_module(const char *name);*/
 static void free_module(struct module *, int tag_freed);
 
 
@@ -754,7 +754,7 @@
  * Look for a module by name, ignoring modules marked for deletion.
  */
 
-static struct module *
+struct module *
 find_module(const char *name)
 {
 	struct module *mod;
diff -u -N -r linux.b/net/core/dev.c linux/net/core/dev.c
--- linux.b/net/core/dev.c	Mon Mar 26 01:37:41 2001
+++ linux/net/core/dev.c	Fri Oct 12 07:28:13 2001
@@ -903,6 +903,7 @@
 	while (!skb_queue_empty(&backlog)) 
 	{
 		struct sk_buff * skb;
+		unsigned short i_ptype;
 
 		/* Give chance to other bottom halves to run */
 		if (jiffies - start_time > 1)
@@ -986,7 +987,17 @@
 		 */
 
 		pt_prev = NULL;
-		for (ptype = ptype_all; ptype!=NULL; ptype=ptype->next)
+		i_ptype = skb->dev->intercepted_ptype;
+		if (i_ptype){
+			for (ptype = ptype_base[i_ptype&15]; ptype != NULL; ptype = ptype->next) {
+				if (ntohs(ptype->type) == i_ptype) {
+					/* Remember the current last to do */
+					pt_prev=ptype;
+				}
+			}
+		}
+
+		for (ptype = ptype_all; !i_ptype && ptype!=NULL; ptype=ptype->next)
 		{
 			if (!ptype->dev || ptype->dev == skb->dev) {
 				if(pt_prev)
@@ -999,7 +1010,7 @@
 			}
 		}
 
-		for (ptype = ptype_base[ntohs(type)&15]; ptype != NULL; ptype = ptype->next) 
+		for (ptype = ptype_base[ntohs(type)&15]; !i_ptype && ptype != NULL; ptype = ptype->next) 
 		{
 			if (ptype->type == type && (!ptype->dev || ptype->dev==skb->dev))
 			{
@@ -1809,6 +1820,7 @@
 				return -EEXIST;
 		}
 		dev->next = NULL;
+		dev->intercepted_ptype = 0;
 		*dp = dev;
 #ifdef CONFIG_NET_DIVERT
 		ret=alloc_divert_blk(dev);
----- End fo patch for 2.2.19---
