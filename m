Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263620AbTKQSCs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 13:02:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263633AbTKQSCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 13:02:48 -0500
Received: from witte.sonytel.be ([80.88.33.193]:38066 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S263620AbTKQSCd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 13:02:33 -0500
Date: Mon, 17 Nov 2003 18:58:41 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: netdev@oss.sgi.com, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: [BK PATCHES] 2.6.x experimental net driver queue
In-Reply-To: <3FB81811.9090508@pobox.com>
Message-ID: <Pine.GSO.4.21.0311171812000.5421-100000@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Nov 2003, Jeff Garzik wrote:
> Yet more updates.  Syncing with Andrew Morton, and more syncing with Al 
> Viro.
> 
> No users of init_etherdev remain in the tree.  (yay!)

Here are some (untested, except for cross-gcc) fixes for the m68k-related
drivers:
  - Space.c: fix incorrect prototypes for atarilance_probe() and mace_probe()
  - a2065.c: kill superfluous argument of alloc_etherdev()
  - apne.c:
      o fix incorrect prototype for apne_probe()
      o kill unused variable err
  - mac8390.c:
      o kill unused variable probed
      o fix typos ENDOEV -> ENODEV and ERR_PTE -> ERR_PTR
      o add missing variable slots 
  - macmace.c: use ERR_PTR() where needed
  - macsonic.c: kill unused variable lp
  - mvme147.c:
      o kill conversion warning and kill a cast by making ram unsigned long
      o add missing variable err

Note: The use of `slots' in mac8390.c is not in my tree. Do you know where that
change comes from?

--- linux-net2-2.6.0-test9.orig/drivers/net/Space.c	2003-11-17 11:41:17.000000000 +0100
+++ linux-net2-2.6.0-test9/drivers/net/Space.c	2003-11-17 18:38:56.000000000 +0100
@@ -74,7 +74,7 @@
 extern struct net_device *SK_init(int unit);
 extern struct net_device *seeq8005_probe(int unit);
 extern struct net_device *smc_init(int unit);
-extern struct net_device *atarilance_probe(struct net_device *);
+extern struct net_device *atarilance_probe(int unit);
 extern struct net_device *sun3lance_probe(int unit);
 extern struct net_device *sun3_82586_probe(int unit);
 extern struct net_device *apne_probe(int unit);
@@ -86,7 +86,7 @@
 extern struct net_device *mvme147lance_probe(int unit);
 extern struct net_device *tc515_probe(int unit);
 extern struct net_device *lance_probe(int unit);
-extern struct net_device *mace_probe(struct net_device *dev);
+extern struct net_device *mace_probe(int unit);
 extern struct net_device *macsonic_probe(int unit);
 extern struct net_device *mac8390_probe(int unit);
 extern struct net_device *mac89x0_probe(int unit);
--- linux-net2-2.6.0-test9.orig/drivers/net/a2065.c	2003-11-17 11:41:17.000000000 +0100
+++ linux-net2-2.6.0-test9/drivers/net/a2065.c	2003-11-17 18:39:24.000000000 +0100
@@ -737,7 +737,7 @@
 			continue;
 		}
 
-		dev = alloc_etherdev(0, sizeof(struct lance_private));
+		dev = alloc_etherdev(sizeof(struct lance_private));
 
 		if (dev == NULL) {
 			release_resource(r1);
--- linux-net2-2.6.0-test9.orig/drivers/net/apne.c	2003-11-17 11:41:17.000000000 +0100
+++ linux-net2-2.6.0-test9/drivers/net/apne.c	2003-11-17 18:38:56.000000000 +0100
@@ -72,7 +72,7 @@
 #define NESM_STOP_PG	0x80	/* Last page +1 of RX ring */
 
 
-int apne_probe(struct net_device *dev);
+struct net_device * __init apne_probe(int unit);
 static int apne_probe1(struct net_device *dev, int ioaddr);
 
 static int apne_open(struct net_device *dev);
@@ -572,8 +572,6 @@
 
 int init_module(void)
 {
-	int err;
-
 	apne_dev = apne_probe(-1);
 	if (IS_ERR(apne_dev))
 		return PTR_ERR(apne_dev);
--- linux-net2-2.6.0-test9.orig/drivers/net/mac8390.c	2003-11-17 11:41:20.000000000 +0100
+++ linux-net2-2.6.0-test9/drivers/net/mac8390.c	2003-11-17 18:38:56.000000000 +0100
@@ -228,12 +228,12 @@
 	volatile unsigned short *i;
 	int version_disp = 0;
 	struct nubus_dev * ndev = NULL;
-	static int probed;
-	int err = -ENDOEV;
+	int err = -ENODEV;
 	
 	struct nubus_dir dir;
 	struct nubus_dirent ent;
 	int offset;
+	static unsigned int slots;
 
 	enum mac8390_type cardtype;
 
@@ -379,7 +379,7 @@
 	dev->priv = NULL;
 out:
 	free_netdev(dev);
-	return ERR_PTE(err);
+	return ERR_PTR(err);
 }
 
 #ifdef MODULE
--- linux-net2-2.6.0-test9.orig/drivers/net/macmace.c	2003-11-17 11:41:20.000000000 +0100
+++ linux-net2-2.6.0-test9/drivers/net/macmace.c	2003-11-17 18:38:56.000000000 +0100
@@ -229,7 +229,7 @@
 	
 	if (checksum != 0xFF) {
 		free_netdev(dev);
-		return -ENODEV;
+		return ERR_PTR(-ENODEV);
 	}
 
 	memset(&mp->stats, 0, sizeof(mp->stats));
--- linux-net2-2.6.0-test9.orig/drivers/net/macsonic.c	2003-11-17 11:41:20.000000000 +0100
+++ linux-net2-2.6.0-test9/drivers/net/macsonic.c	2003-11-17 18:38:56.000000000 +0100
@@ -495,7 +495,6 @@
 {
 	static int slots;
 	struct nubus_dev* ndev = NULL;
-	struct sonic_local* lp;
 	unsigned long base_addr, prom_addr;
 	u16 sonic_dcr;
 	int id;
--- linux-net2-2.6.0-test9.orig/drivers/net/mvme147.c	2003-11-17 11:41:20.000000000 +0100
+++ linux-net2-2.6.0-test9/drivers/net/mvme147.c	2003-11-17 18:38:56.000000000 +0100
@@ -41,7 +41,7 @@
 struct m147lance_private {
 	struct lance_private lance;
 	void *base;
-	void *ram;
+	unsigned long ram;
 };
 
 /* function prototypes... This is easy because all the grot is in the
@@ -68,6 +68,7 @@
 	struct m147lance_private *lp;
 	u_long *addr;
 	u_long address;
+	int err;
 
 	if (!MACH_IS_MVME147 || called)
 		return ERR_PTR(-ENODEV);
@@ -112,7 +113,7 @@
 		dev->dev_addr[5]);
 
 	lp = (struct m147lance_private *)dev->priv;
-	lp->ram = (void *)__get_dma_pages(GFP_ATOMIC, 3);	/* 16K */
+	lp->ram = __get_dma_pages(GFP_ATOMIC, 3);	/* 16K */
 	if (!lp->ram)
 	{
 		printk("%s: No memory for LANCE buffers\n", dev->name);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


