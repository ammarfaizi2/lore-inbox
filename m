Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261695AbVDOAvS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbVDOAvS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 20:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbVDOAtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 20:49:35 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:60167 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261692AbVDOAsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 20:48:43 -0400
Date: Fri, 15 Apr 2005 02:48:41 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/arcnet/: possible cleanups
Message-ID: <20050415004841.GH20400@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make needlessly global code static
- arcnet.c: remove the outdated VERSION
- arcnet.c: remove the unneeded EXPORT_SYMBOL(arc_proto_null)
- arcnet.c: remove the unneeded EXPORT_SYMBOL(arcnet_dump_packet)

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 24 Mar 2005

 drivers/net/arcnet/arc-rawmode.c |    2 +-
 drivers/net/arcnet/arcnet.c      |   19 ++++++++++---------
 drivers/net/arcnet/rfc1051.c     |    2 +-
 drivers/net/arcnet/rfc1201.c     |    3 +--
 include/linux/arcdevice.h        |    9 ---------
 5 files changed, 13 insertions(+), 22 deletions(-)

--- linux-2.6.11-rc3-mm2-full/drivers/net/arcnet/arc-rawmode.c.old	2005-02-16 15:16:38.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/arcnet/arc-rawmode.c	2005-02-16 15:16:51.000000000 +0100
@@ -42,7 +42,7 @@
 static int prepare_tx(struct net_device *dev, struct archdr *pkt, int length,
 		      int bufnum);
 
-struct ArcProto rawmode_proto =
+static struct ArcProto rawmode_proto =
 {
 	.suffix		= 'r',
 	.mtu		= XMTU,
--- linux-2.6.11-rc3-mm2-full/include/linux/arcdevice.h.old	2005-02-16 15:17:26.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/include/linux/arcdevice.h	2005-02-16 15:20:57.000000000 +0100
@@ -206,7 +206,6 @@
 
 extern struct ArcProto *arc_proto_map[256], *arc_proto_default,
 	*arc_bcast_proto, *arc_raw_proto;
-extern struct ArcProto arc_proto_null;
 
 
 /*
@@ -334,17 +333,9 @@
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
--- linux-2.6.11-rc3-mm2-full/drivers/net/arcnet/arcnet.c.old	2005-02-16 15:17:47.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/arcnet/arcnet.c	2005-02-16 15:21:20.000000000 +0100
@@ -41,8 +41,6 @@
  *     <jojo@repas.de>
  */
 
-#define VERSION "arcnet: v3.93 BETA 2000/04/29 - by Avery Pennarun et al.\n"
-
 #include <linux/module.h>
 #include <linux/config.h>
 #include <linux/types.h>
@@ -61,6 +59,7 @@
 static int null_prepare_tx(struct net_device *dev, struct archdr *pkt,
 			   int length, int bufnum);
 
+static void arcnet_rx(struct net_device *dev, int bufnum);
 
 /*
  * one ArcProto per possible proto ID.  None of the elements of
@@ -71,7 +70,7 @@
  struct ArcProto *arc_proto_map[256], *arc_proto_default,
    *arc_bcast_proto, *arc_raw_proto;
 
-struct ArcProto arc_proto_null =
+static struct ArcProto arc_proto_null =
 {
 	.suffix		= '?',
 	.mtu		= XMTU,
@@ -90,7 +89,6 @@
 EXPORT_SYMBOL(arc_proto_default);
 EXPORT_SYMBOL(arc_bcast_proto);
 EXPORT_SYMBOL(arc_raw_proto);
-EXPORT_SYMBOL(arc_proto_null);
 EXPORT_SYMBOL(arcnet_unregister_proto);
 EXPORT_SYMBOL(arcnet_debug);
 EXPORT_SYMBOL(alloc_arcdev);
@@ -118,8 +116,8 @@
 
 	arcnet_debug = debug;
 
-	printk(VERSION);
+	printk("arcnet loaded.\n");

 #ifdef ALPHA_WARNING
 	BUGLVL(D_EXTRA) {
 		printk("arcnet: ***\n"
@@ -178,8 +174,8 @@
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
@@ -208,7 +204,10 @@
 
 }
 
-EXPORT_SYMBOL(arcnet_dump_packet);
+#else
+
+#define arcnet_dump_packet(dev, bufnum, desc,take_arcnet_lock) do { } while (0)
+
 #endif
 
 
@@ -987,7 +986,7 @@
  * This is a generic packet receiver that calls arcnet??_rx depending on the
  * protocol ID found.
  */
-void arcnet_rx(struct net_device *dev, int bufnum)
+static void arcnet_rx(struct net_device *dev, int bufnum)
 {
 	struct arcnet_local *lp = dev->priv;
 	struct archdr pkt;
--- linux-2.6.11-rc3-mm2-full/drivers/net/arcnet/rfc1051.c.old	2005-02-16 15:22:16.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/arcnet/rfc1051.c	2005-02-16 15:22:23.000000000 +0100
@@ -43,7 +43,7 @@
 		      int bufnum);
 
 
-struct ArcProto rfc1051_proto =
+static struct ArcProto rfc1051_proto =
 {
 	.suffix		= 's',
 	.mtu		= XMTU - RFC1051_HDR_SIZE,
--- linux-2.6.11-rc3-mm2-full/drivers/net/arcnet/rfc1201.c.old	2005-02-16 15:22:35.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/arcnet/rfc1201.c	2005-02-16 15:22:46.000000000 +0100
@@ -43,7 +43,7 @@
 		      int bufnum);
 static int continue_tx(struct net_device *dev, int bufnum);
 
-struct ArcProto rfc1201_proto =
+static struct ArcProto rfc1201_proto =
 {
 	.suffix		= 'a',
 	.mtu		= 1500,	/* could be more, but some receivers can't handle it... */

