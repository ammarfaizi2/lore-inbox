Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423262AbWANCLH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423262AbWANCLH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 21:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423276AbWANCK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 21:10:28 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:23058 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1423272AbWANCKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 21:10:22 -0500
Date: Sat, 14 Jan 2006 03:10:22 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jeff Garzik <jgarzik@pobox.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [2.6 patch] drivers/net/arcnet/: possible cleanups
Message-ID: <20060114021022.GE29663@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make needlessly global code static
- arcnet.c: remove the unneeded EXPORT_SYMBOL(arc_proto_null)
- arcnet.c: remove the unneeded EXPORT_SYMBOL(arcnet_dump_packet)

To make Jeff happy, arcnet.c still prints
  arcnet: v3.93 BETA 2000/04/29 - by Avery Pennarun et al.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/arcnet/arc-rawmode.c |    2 +-
 drivers/net/arcnet/arcnet.c      |   15 +++++++++------
 drivers/net/arcnet/rfc1051.c     |    2 +-
 drivers/net/arcnet/rfc1201.c     |    2 +-
 include/linux/arcdevice.h        |   10 ----------
 5 files changed, 12 insertions(+), 19 deletions(-)
      
diff -puN drivers/net/arcnet/arcnet.c~drivers-net-arcnet-possible-cleanups drivers/net/arcnet/arcnet.c
--- devel/drivers/net/arcnet/arcnet.c~drivers-net-arcnet-possible-cleanups	2005-07-09 01:24:43.000000000 -0700
+++ devel-akpm/drivers/net/arcnet/arcnet.c	2005-07-09 01:24:43.000000000 -0700
@@ -61,6 +59,7 @@ static int null_build_header(struct sk_b
 static int null_prepare_tx(struct net_device *dev, struct archdr *pkt,
 			   int length, int bufnum);
 
+static void arcnet_rx(struct net_device *dev, int bufnum);
 
 /*
  * one ArcProto per possible proto ID.  None of the elements of
@@ -71,7 +70,7 @@ static int null_prepare_tx(struct net_de
  struct ArcProto *arc_proto_map[256], *arc_proto_default,
    *arc_bcast_proto, *arc_raw_proto;
 
-struct ArcProto arc_proto_null =
+static struct ArcProto arc_proto_null =
 {
 	.suffix		= '?',
 	.mtu		= XMTU,
@@ -90,7 +89,6 @@ EXPORT_SYMBOL(arc_proto_map);
 EXPORT_SYMBOL(arc_proto_default);
 EXPORT_SYMBOL(arc_bcast_proto);
 EXPORT_SYMBOL(arc_raw_proto);
-EXPORT_SYMBOL(arc_proto_null);
 EXPORT_SYMBOL(arcnet_unregister_proto);
 EXPORT_SYMBOL(arcnet_debug);
 EXPORT_SYMBOL(alloc_arcdev);
@@ -118,7 +116,7 @@ static int __init arcnet_init(void)
 
 	arcnet_debug = debug;
 
-	printk(VERSION);
+	printk("arcnet loaded.\n");
 
 #ifdef ALPHA_WARNING
 	BUGLVL(D_EXTRA) {
@@ -178,8 +176,8 @@ EXPORT_SYMBOL(arcnet_dump_skb);
  * Dump the contents of an ARCnet buffer
  */
 #if (ARCNET_DEBUG_MAX & (D_RX | D_TX))
-void arcnet_dump_packet(struct net_device *dev, int bufnum, char *desc,
-			int take_arcnet_lock)
+static void arcnet_dump_packet(struct net_device *dev, int bufnum,
+			       char *desc, int take_arcnet_lock)
 {
 	struct arcnet_local *lp = dev->priv;
 	int i, length;
@@ -208,7 +206,10 @@ void arcnet_dump_packet(struct net_devic
 
 }
 
-EXPORT_SYMBOL(arcnet_dump_packet);
+#else
+
+#define arcnet_dump_packet(dev, bufnum, desc,take_arcnet_lock) do { } while (0)
+
 #endif
 
 
@@ -987,7 +988,7 @@ irqreturn_t arcnet_interrupt(int irq, vo
  * This is a generic packet receiver that calls arcnet??_rx depending on the
  * protocol ID found.
  */
-void arcnet_rx(struct net_device *dev, int bufnum)
+static void arcnet_rx(struct net_device *dev, int bufnum)
 {
 	struct arcnet_local *lp = dev->priv;
 	struct archdr pkt;
diff -puN drivers/net/arcnet/arc-rawmode.c~drivers-net-arcnet-possible-cleanups drivers/net/arcnet/arc-rawmode.c
--- devel/drivers/net/arcnet/arc-rawmode.c~drivers-net-arcnet-possible-cleanups	2005-07-09 01:24:43.000000000 -0700
+++ devel-akpm/drivers/net/arcnet/arc-rawmode.c	2005-07-09 01:24:43.000000000 -0700
@@ -42,7 +42,7 @@ static int build_header(struct sk_buff *
 static int prepare_tx(struct net_device *dev, struct archdr *pkt, int length,
 		      int bufnum);
 
-struct ArcProto rawmode_proto =
+static struct ArcProto rawmode_proto =
 {
 	.suffix		= 'r',
 	.mtu		= XMTU,
diff -puN drivers/net/arcnet/rfc1051.c~drivers-net-arcnet-possible-cleanups drivers/net/arcnet/rfc1051.c
--- devel/drivers/net/arcnet/rfc1051.c~drivers-net-arcnet-possible-cleanups	2005-07-09 01:24:43.000000000 -0700
+++ devel-akpm/drivers/net/arcnet/rfc1051.c	2005-07-09 01:24:43.000000000 -0700
@@ -43,7 +43,7 @@ static int prepare_tx(struct net_device 
 		      int bufnum);
 
 
-struct ArcProto rfc1051_proto =
+static struct ArcProto rfc1051_proto =
 {
 	.suffix		= 's',
 	.mtu		= XMTU - RFC1051_HDR_SIZE,
diff -puN drivers/net/arcnet/rfc1201.c~drivers-net-arcnet-possible-cleanups drivers/net/arcnet/rfc1201.c
--- devel/drivers/net/arcnet/rfc1201.c~drivers-net-arcnet-possible-cleanups	2005-07-09 01:24:43.000000000 -0700
+++ devel-akpm/drivers/net/arcnet/rfc1201.c	2005-07-09 01:24:43.000000000 -0700
@@ -43,7 +43,7 @@ static int prepare_tx(struct net_device 
 		      int bufnum);
 static int continue_tx(struct net_device *dev, int bufnum);
 
-struct ArcProto rfc1201_proto =
+static struct ArcProto rfc1201_proto =
 {
 	.suffix		= 'a',
 	.mtu		= 1500,	/* could be more, but some receivers can't handle it... */
diff -puN include/linux/arcdevice.h~drivers-net-arcnet-possible-cleanups include/linux/arcdevice.h
--- devel/include/linux/arcdevice.h~drivers-net-arcnet-possible-cleanups	2005-07-09 01:24:43.000000000 -0700
+++ devel-akpm/include/linux/arcdevice.h	2005-07-09 01:24:43.000000000 -0700
@@ -206,7 +206,6 @@ struct ArcProto {
 
 extern struct ArcProto *arc_proto_map[256], *arc_proto_default,
 	*arc_bcast_proto, *arc_raw_proto;
-extern struct ArcProto arc_proto_null;
 
 
 /*
@@ -334,17 +333,9 @@ void arcnet_dump_skb(struct net_device *
 #define arcnet_dump_skb(dev,skb,desc) ;
 #endif
 
-#if (ARCNET_DEBUG_MAX & D_RX) || (ARCNET_DEBUG_MAX & D_TX)
-void arcnet_dump_packet(struct net_device *dev, int bufnum, char *desc,
-			int take_arcnet_lock);
-#else
-#define arcnet_dump_packet(dev, bufnum, desc,take_arcnet_lock) ;
-#endif
-
 void arcnet_unregister_proto(struct ArcProto *proto);
 irqreturn_t arcnet_interrupt(int irq, void *dev_id, struct pt_regs *regs);
 struct net_device *alloc_arcdev(char *name);
-void arcnet_rx(struct net_device *dev, int bufnum);
 
 #endif				/* __KERNEL__ */
 #endif				/* _LINUX_ARCDEVICE_H */
_
