Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030283AbVKRFWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030283AbVKRFWz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 00:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030327AbVKRFWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 00:22:55 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:39431 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030271AbVKRFWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 00:22:54 -0500
Date: Fri, 18 Nov 2005 06:22:52 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Matt Mackall <mpm@selenic.com>, acme@conectiva.com.br
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: [2.6 patch] move some code to net/ipx/af_ipx.c
Message-ID: <20051118052252.GG11494@stusta.de>
References: <6.282480653@selenic.com> <7.282480653@selenic.com> <20051114015707.GB5735@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051114015707.GB5735@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2005 at 02:57:07AM +0100, Adrian Bunk wrote:
> On Fri, Nov 11, 2005 at 02:35:51AM -0600, Matt Mackall wrote:
> > trivial: drop unused 802.3 code if we compile without IPX
> > 
> > (originally from http://wohnheim.fh-wedel.de/~joern/software/kernel/je/25/)
> > 
> > Signed-off-by: Matt Mackall <mpm@selenic.com>
> > 
> > Index: tiny/net/802/Makefile
> > ===================================================================
> > --- tiny.orig/net/802/Makefile	2005-03-15 00:24:59.000000000 -0600
> > +++ tiny/net/802/Makefile	2005-03-15 00:25:48.000000000 -0600
> > @@ -2,8 +2,6 @@
> >  # Makefile for the Linux 802.x protocol layers.
> >  #
> >  
> > -obj-y			:= p8023.o
> > -
> >  # Check the p8022 selections against net/core/Makefile.
> >  obj-$(CONFIG_SYSCTL)	+= sysctl_net_802.o
> >  obj-$(CONFIG_LLC)	+= p8022.o psnap.o
> > @@ -11,5 +9,5 @@ obj-$(CONFIG_TR)	+= p8022.o psnap.o tr.o
> >  obj-$(CONFIG_NET_FC)	+=                 fc.o
> >  obj-$(CONFIG_FDDI)	+=                 fddi.o
> >  obj-$(CONFIG_HIPPI)	+=                 hippi.o
> > -obj-$(CONFIG_IPX)	+= p8022.o psnap.o
> > +obj-$(CONFIG_IPX)	+= p8022.o psnap.o p8023.o
> >  obj-$(CONFIG_ATALK)	+= p8022.o psnap.o
> 
> This patch isn't bad, but looking closer we could move the contents of 
> p8023.c as well as the contents of at least p8022.c and pe2.c into 
> af_ipx.c.
> 
> Is the contents of any of these three files expected to be used
> outside IPX (closest candidate would be appletalk)?


Below is a patch implementing what I was thinking of.

cu
Adrian


<--  snip  -->


This patch moves some code only used in this file to net/ipx/af_ipx.c .


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/net/p8022.h   |   13 -----
 net/802/Makefile      |   17 ++-----
 net/802/p8022.c       |   66 ---------------------------
 net/802/p8023.c       |   61 -------------------------
 net/8021q/vlan.c      |    1 
 net/8021q/vlan_dev.c  |    1 
 net/ethernet/Makefile |    2 
 net/ethernet/pe2.c    |   39 ----------------
 net/ipx/af_ipx.c      |  102 ++++++++++++++++++++++++++++++++++++++++--
 9 files changed, 106 insertions(+), 196 deletions(-)

--- linux-2.6.15-rc1-mm1-full/net/802/Makefile.old	2005-11-18 02:14:35.000000000 +0100
+++ linux-2.6.15-rc1-mm1-full/net/802/Makefile	2005-11-18 02:15:06.000000000 +0100
@@ -2,14 +2,11 @@
 # Makefile for the Linux 802.x protocol layers.
 #
 
-obj-y			:= p8023.o
-
-# Check the p8022 selections against net/core/Makefile.
 obj-$(CONFIG_SYSCTL)	+= sysctl_net_802.o
-obj-$(CONFIG_LLC)	+= p8022.o psnap.o
-obj-$(CONFIG_TR)	+= p8022.o psnap.o tr.o sysctl_net_802.o
-obj-$(CONFIG_NET_FC)	+=                 fc.o
-obj-$(CONFIG_FDDI)	+=                 fddi.o
-obj-$(CONFIG_HIPPI)	+=                 hippi.o
-obj-$(CONFIG_IPX)	+= p8022.o psnap.o
-obj-$(CONFIG_ATALK)	+= p8022.o psnap.o
+obj-$(CONFIG_LLC)	+= psnap.o
+obj-$(CONFIG_TR)	+= psnap.o tr.o sysctl_net_802.o
+obj-$(CONFIG_NET_FC)	+=         fc.o
+obj-$(CONFIG_FDDI)	+=         fddi.o
+obj-$(CONFIG_HIPPI)	+=         hippi.o
+obj-$(CONFIG_IPX)	+= psnap.o
+obj-$(CONFIG_ATALK)	+= psnap.o
--- linux-2.6.15-rc1-mm1-full/net/ethernet/Makefile.old	2005-11-18 02:15:17.000000000 +0100
+++ linux-2.6.15-rc1-mm1-full/net/ethernet/Makefile	2005-11-18 02:15:22.000000000 +0100
@@ -4,5 +4,3 @@
 
 obj-y					+= eth.o
 obj-$(CONFIG_SYSCTL)			+= sysctl_net_ether.o
-obj-$(subst m,y,$(CONFIG_IPX))		+= pe2.o
-obj-$(subst m,y,$(CONFIG_ATALK))	+= pe2.o
--- linux-2.6.15-rc1-mm1-full/net/8021q/vlan.c.old	2005-11-18 02:19:40.000000000 +0100
+++ linux-2.6.15-rc1-mm1-full/net/8021q/vlan.c	2005-11-18 02:19:46.000000000 +0100
@@ -26,7 +26,6 @@
 #include <linux/mm.h>
 #include <linux/in.h>
 #include <linux/init.h>
-#include <net/p8022.h>
 #include <net/arp.h>
 #include <linux/rtnetlink.h>
 #include <linux/notifier.h>
--- linux-2.6.15-rc1-mm1-full/net/8021q/vlan_dev.c.old	2005-11-18 02:19:55.000000000 +0100
+++ linux-2.6.15-rc1-mm1-full/net/8021q/vlan_dev.c	2005-11-18 02:19:58.000000000 +0100
@@ -29,7 +29,6 @@
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <net/datalink.h>
-#include <net/p8022.h>
 #include <net/arp.h>
 
 #include "vlan.h"
--- linux-2.6.15-rc1-mm1-full/net/ipx/af_ipx.c.old	2005-11-18 02:17:00.000000000 +0100
+++ linux-2.6.15-rc1-mm1-full/net/ipx/af_ipx.c	2005-11-18 02:26:01.000000000 +0100
@@ -48,10 +48,10 @@
 #include <linux/termios.h>
 
 #include <net/ipx.h>
-#include <net/p8022.h>
 #include <net/psnap.h>
 #include <net/sock.h>
 #include <net/tcp_states.h>
+#include <net/llc.h>
 
 #include <asm/uaccess.h>
 
@@ -1939,8 +1939,104 @@
 	.notifier_call	= ipxitf_device_event,
 };
 
-extern struct datalink_proto *make_EII_client(void);
-extern void destroy_EII_client(struct datalink_proto *);
+static int p8022_request(struct datalink_proto *dl, struct sk_buff *skb,
+			 unsigned char *dest)
+{
+	llc_build_and_send_ui_pkt(dl->sap, skb, dest, dl->sap->laddr.lsap);
+	return 0;
+}
+
+static struct datalink_proto *register_8022_client(unsigned char type,
+					    int (*func)(struct sk_buff *skb,
+							struct net_device *dev,
+							struct packet_type *pt,
+							struct net_device *orig_dev))
+{
+	struct datalink_proto *proto;
+
+	proto = kmalloc(sizeof(*proto), GFP_ATOMIC);
+	if (proto) {
+		proto->type[0]		= type;
+		proto->header_length	= 3;
+		proto->request		= p8022_request;
+		proto->sap = llc_sap_open(type, func);
+		if (!proto->sap) {
+			kfree(proto);
+			proto = NULL;
+		}
+	}
+	return proto;
+}
+
+static void unregister_8022_client(struct datalink_proto *proto)
+{
+	llc_sap_put(proto->sap);
+	kfree(proto);
+}
+
+/*
+ *	Place an 802.3 header on a packet. The driver will do the mac
+ *	addresses, we just need to give it the buffer length.
+ */
+static int p8023_request(struct datalink_proto *dl,
+			 struct sk_buff *skb, unsigned char *dest_node)
+{
+	struct net_device *dev = skb->dev;
+
+	dev->hard_header(skb, dev, ETH_P_802_3, dest_node, NULL, skb->len);
+	return dev_queue_xmit(skb);
+}
+
+/*
+ *	Create an 802.3 client. Note there can be only one 802.3 client
+ */
+static struct datalink_proto *make_8023_client(void)
+{
+	struct datalink_proto *proto = kmalloc(sizeof(*proto), GFP_ATOMIC);
+
+	if (proto) {
+		proto->header_length = 0;
+		proto->request	     = p8023_request;
+	}
+	return proto;
+}
+
+/*
+ *	Destroy the 802.3 client.
+ */
+static void destroy_8023_client(struct datalink_proto *dl)
+{
+	kfree(dl);
+}
+
+static int pEII_request(struct datalink_proto *dl,
+			struct sk_buff *skb, unsigned char *dest_node)
+{
+	struct net_device *dev = skb->dev;
+
+	skb->protocol = htons(ETH_P_IPX);
+	if (dev->hard_header)
+		dev->hard_header(skb, dev, ETH_P_IPX,
+				 dest_node, NULL, skb->len);
+	return dev_queue_xmit(skb);
+}
+
+static struct datalink_proto *make_EII_client(void)
+{
+	struct datalink_proto *proto = kmalloc(sizeof(*proto), GFP_ATOMIC);
+
+	if (proto) {
+		proto->header_length = 0;
+		proto->request = pEII_request;
+	}
+
+	return proto;
+}
+
+static void destroy_EII_client(struct datalink_proto *dl)
+{
+	kfree(dl);
+}
 
 static unsigned char ipx_8022_type = 0xE0;
 static unsigned char ipx_snap_id[5] = { 0x0, 0x0, 0x0, 0x81, 0x37 };
--- linux-2.6.15-rc1-mm1-full/include/net/p8022.h	2005-10-28 02:02:08.000000000 +0200
+++ /dev/null	2005-11-08 19:07:57.000000000 +0100
@@ -1,13 +0,0 @@
-#ifndef _NET_P8022_H
-#define _NET_P8022_H
-extern struct datalink_proto *
-	register_8022_client(unsigned char type,
-			     int (*func)(struct sk_buff *skb,
-					 struct net_device *dev,
-					 struct packet_type *pt,
-					 struct net_device *orig_dev));
-extern void unregister_8022_client(struct datalink_proto *proto);
-
-extern struct datalink_proto *make_8023_client(void);
-extern void destroy_8023_client(struct datalink_proto *dl);
-#endif
--- linux-2.6.15-rc1-mm1-full/net/ethernet/pe2.c	2005-11-17 21:30:56.000000000 +0100
+++ /dev/null	2005-11-08 19:07:57.000000000 +0100
@@ -1,39 +0,0 @@
-#include <linux/in.h>
-#include <linux/mm.h>
-#include <linux/module.h>
-#include <linux/netdevice.h>
-#include <linux/skbuff.h>
-
-#include <net/datalink.h>
-
-static int pEII_request(struct datalink_proto *dl,
-			struct sk_buff *skb, unsigned char *dest_node)
-{
-	struct net_device *dev = skb->dev;
-
-	skb->protocol = htons(ETH_P_IPX);
-	if (dev->hard_header)
-		dev->hard_header(skb, dev, ETH_P_IPX,
-				 dest_node, NULL, skb->len);
-	return dev_queue_xmit(skb);
-}
-
-struct datalink_proto *make_EII_client(void)
-{
-	struct datalink_proto *proto = kmalloc(sizeof(*proto), GFP_ATOMIC);
-
-	if (proto) {
-		proto->header_length = 0;
-		proto->request = pEII_request;
-	}
-
-	return proto;
-}
-
-void destroy_EII_client(struct datalink_proto *dl)
-{
-	kfree(dl);
-}
-
-EXPORT_SYMBOL(destroy_EII_client);
-EXPORT_SYMBOL(make_EII_client);
--- linux-2.6.15-rc1-mm1-full/net/802/p8022.c	2005-10-28 02:02:08.000000000 +0200
+++ /dev/null	2005-11-08 19:07:57.000000000 +0100
@@ -1,66 +0,0 @@
-/*
- *	NET3:	Support for 802.2 demultiplexing off Ethernet (Token ring
- *		is kept separate see p8022tr.c)
- *		This program is free software; you can redistribute it and/or
- *		modify it under the terms of the GNU General Public License
- *		as published by the Free Software Foundation; either version
- *		2 of the License, or (at your option) any later version.
- *
- *		Demultiplex 802.2 encoded protocols. We match the entry by the
- *		SSAP/DSAP pair and then deliver to the registered datalink that
- *		matches. The control byte is ignored and handling of such items
- *		is up to the routine passed the frame.
- *
- *		Unlike the 802.3 datalink we have a list of 802.2 entries as
- *		there are multiple protocols to demux. The list is currently
- *		short (3 or 4 entries at most). The current demux assumes this.
- */
-#include <linux/module.h>
-#include <linux/netdevice.h>
-#include <linux/skbuff.h>
-#include <net/datalink.h>
-#include <linux/mm.h>
-#include <linux/in.h>
-#include <linux/init.h>
-#include <net/llc.h>
-#include <net/p8022.h>
-
-static int p8022_request(struct datalink_proto *dl, struct sk_buff *skb,
-			 unsigned char *dest)
-{
-	llc_build_and_send_ui_pkt(dl->sap, skb, dest, dl->sap->laddr.lsap);
-	return 0;
-}
-
-struct datalink_proto *register_8022_client(unsigned char type,
-					    int (*func)(struct sk_buff *skb,
-							struct net_device *dev,
-							struct packet_type *pt,
-							struct net_device *orig_dev))
-{
-	struct datalink_proto *proto;
-
-	proto = kmalloc(sizeof(*proto), GFP_ATOMIC);
-	if (proto) {
-		proto->type[0]		= type;
-		proto->header_length	= 3;
-		proto->request		= p8022_request;
-		proto->sap = llc_sap_open(type, func);
-		if (!proto->sap) {
-			kfree(proto);
-			proto = NULL;
-		}
-	}
-	return proto;
-}
-
-void unregister_8022_client(struct datalink_proto *proto)
-{
-	llc_sap_put(proto->sap);
-	kfree(proto);
-}
-
-EXPORT_SYMBOL(register_8022_client);
-EXPORT_SYMBOL(unregister_8022_client);
-
-MODULE_LICENSE("GPL");
--- linux-2.6.15-rc1-mm1-full/net/802/p8023.c	2005-11-17 21:30:55.000000000 +0100
+++ /dev/null	2005-11-08 19:07:57.000000000 +0100
@@ -1,61 +0,0 @@
-/*
- *	NET3:	802.3 data link hooks used for IPX 802.3
- *
- *	This program is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU General Public License
- *	as published by the Free Software Foundation; either version
- *	2 of the License, or (at your option) any later version.
- *
- *	802.3 isn't really a protocol data link layer. Some old IPX stuff
- *	uses it however. Note that there is only one 802.3 protocol layer
- *	in the system. We don't currently support different protocols
- *	running raw 802.3 on different devices. Thankfully nobody else
- *	has done anything like the old IPX.
- */
-
-#include <linux/in.h>
-#include <linux/mm.h>
-#include <linux/module.h>
-#include <linux/netdevice.h>
-#include <linux/skbuff.h>
-
-#include <net/datalink.h>
-#include <net/p8022.h>
-
-/*
- *	Place an 802.3 header on a packet. The driver will do the mac
- *	addresses, we just need to give it the buffer length.
- */
-static int p8023_request(struct datalink_proto *dl,
-			 struct sk_buff *skb, unsigned char *dest_node)
-{
-	struct net_device *dev = skb->dev;
-
-	dev->hard_header(skb, dev, ETH_P_802_3, dest_node, NULL, skb->len);
-	return dev_queue_xmit(skb);
-}
-
-/*
- *	Create an 802.3 client. Note there can be only one 802.3 client
- */
-struct datalink_proto *make_8023_client(void)
-{
-	struct datalink_proto *proto = kmalloc(sizeof(*proto), GFP_ATOMIC);
-
-	if (proto) {
-		proto->header_length = 0;
-		proto->request	     = p8023_request;
-	}
-	return proto;
-}
-
-/*
- *	Destroy the 802.3 client.
- */
-void destroy_8023_client(struct datalink_proto *dl)
-{
-	kfree(dl);
-}
-
-EXPORT_SYMBOL(destroy_8023_client);
-EXPORT_SYMBOL(make_8023_client);

