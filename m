Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261513AbUJaHLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261513AbUJaHLt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 02:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261515AbUJaHLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 02:11:49 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:38557 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S261513AbUJaHLM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 02:11:12 -0500
Subject: Re: net: generic netdev_ioaddr
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, davem@davemloft.net,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
In-Reply-To: <m3r7nfem2v.fsf@defiant.pm.waw.pl>
References: <1099044244.9566.0.camel@localhost>
	 <20041029131607.GU24336@parcelfarce.linux.theplanet.co.uk>
	 <courier.418290EC.00002E85@courier.cs.helsinki.fi>
	 <m3y8hpbaf9.fsf@defiant.pm.waw.pl>
	 <20041029193827.GV24336@parcelfarce.linux.theplanet.co.uk>
	 <m3u0sdb53f.fsf@defiant.pm.waw.pl> <1099129946.10961.9.camel@localhost>
	 <m3r7nfem2v.fsf@defiant.pm.waw.pl>
Date: Sun, 31 Oct 2004 09:11:09 +0200
Message-Id: <1099206669.9571.10.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 2004-10-31 at 02:02 +0100, Krzysztof Halasa wrote:
> Sure, cops.io= should be fine. Or cops.hw=io,irq,mem etc.
> 
> Still, this is an issue with non-PnP ISA cards only.

Cops already exposes base address and irq as module parameters and yet
it calls netdev_boot_setup_check() to check "netdev=" so I assume
there's a reason for that.  Perhaps something like the (untested) patch
below would make more sense?

		Pekka

Index: 2.6.10-rc1-mm1/drivers/net/appletalk/cops.c
===================================================================
--- 2.6.10-rc1-mm1.orig/drivers/net/appletalk/cops.c	2004-10-31 08:56:31.487324160 +0200
+++ 2.6.10-rc1-mm1/drivers/net/appletalk/cops.c	2004-10-31 09:06:09.273487312 +0200
@@ -171,6 +171,8 @@
 
 struct cops_local
 {
+	unsigned long base_addr;
+	unsigned int irq;
         struct net_device_stats stats;
         int board;			/* Holds what board type is. */
 	int nodeid;			/* Set to 1 once have nodeid. */
@@ -205,20 +207,22 @@
 
 static void cleanup_card(struct net_device *dev)
 {
-	if (dev->irq)
-		free_irq(dev->irq, dev);
-	release_region(dev->base_addr, COPS_IO_EXTENT);
+	struct cops_local *lp = netdev_priv(dev);
+	if (lp->irq)
+		free_irq(lp->irq, dev);
+	release_region(lp->base_addr, COPS_IO_EXTENT);
 }
 
 /*
  *      Check for a network adaptor of this type, and return '0' iff one exists.
- *      If dev->base_addr == 0, probe all likely locations.
- *      If dev->base_addr in [1..0x1ff], always return failure.
+ *      If lp->base_addr == 0, probe all likely locations.
+ *      If lp->base_addr in [1..0x1ff], always return failure.
  *        otherwise go with what we pass in.
  */
 struct net_device * __init cops_probe(int unit)
 {
 	struct net_device *dev;
+	struct cops_local *lp;
 	unsigned *port;
 	int base_addr;
 	int err = 0;
@@ -227,13 +231,23 @@
 	if (!dev)
 		return ERR_PTR(-ENOMEM);
 
+	lp = netdev_priv(dev);
+
 	if (unit >= 0) {
+		struct ifmap *map;
+
+		base_addr = 0;
+		irq = 0;
+
 		sprintf(dev->name, "lt%d", unit);
-		netdev_boot_setup_check(dev);
-		irq = dev->irq;
-		base_addr = dev->base_addr;
+
+		map = netdev_boot_ifmap(dev->name);
+		if (map) {
+			irq = lp->irq = map->irq;
+			base_addr = lp->base_addr = map->base_addr;
+		}
 	} else {
-		base_addr = dev->base_addr = io;
+		base_addr = lp->base_addr = io;
 	}
 
 	SET_MODULE_OWNER(dev);
@@ -273,7 +287,7 @@
  */
 static int __init cops_probe1(struct net_device *dev, int ioaddr)
 {
-        struct cops_local *lp;
+        struct cops_local *lp = netdev_priv(dev);
 	static unsigned version_printed;
 	int board = board_type;
 	int retval;
@@ -292,13 +306,13 @@
          * interrupts are typically not reported by the boards, and we must
          * used AutoIRQ to find them.
 	 */
-	dev->irq = irq;
-	switch (dev->irq)
+	lp->irq = irq;
+	switch (lp->irq)
 	{
 		case 0:
 			/* COPS AutoIRQ routine */
-			dev->irq = cops_irq(ioaddr, board);
-			if (dev->irq)
+			lp->irq = cops_irq(ioaddr, board);
+			if (lp->irq)
 				break;
 			/* No IRQ found on this port, fallthrough */
 		case 1:
@@ -309,7 +323,7 @@
 		 * IRQ 9, or don't know which one to set.
 		 */
 		case 2:
-			dev->irq = 9;
+			lp->irq = 9;
 			break;
 
 		/* Polled operation requested. Although irq of zero passed as
@@ -317,7 +331,7 @@
 		 * overload it to denote polled operation at runtime.
 		 */
 		case 0xff:
-			dev->irq = 0;
+			lp->irq = 0;
 			break;
 
 		default:
@@ -325,16 +339,14 @@
 	}
 
 	/* Reserve any actual interrupt. */
-	if (dev->irq) {
-		retval = request_irq(dev->irq, &cops_interrupt, 0, dev->name, dev);
+	if (lp->irq) {
+		retval = request_irq(lp->irq, &cops_interrupt, 0, dev->name, dev);
 		if (retval)
 			goto err_out;
 	}
 
-	dev->base_addr = ioaddr;
+	lp->base_addr = ioaddr;
 
-        lp = netdev_priv(dev);
-        memset(lp, 0, sizeof(struct cops_local));
         spin_lock_init(&lp->lock);
 
 	/* Copy local board variable to lp struct. */
@@ -354,11 +366,11 @@
 	/* Tell the user where the card is and what mode we're in. */
 	if(board==DAYNA)
 		printk("%s: %s at %#3x, using IRQ %d, in Dayna mode.\n", 
-			dev->name, cardname, ioaddr, dev->irq);
+			dev->name, cardname, ioaddr, lp->irq);
 	if(board==TANGENT) {
-		if(dev->irq)
+		if(lp->irq)
 			printk("%s: %s at %#3x, IRQ %d, in Tangent mode\n", 
-				dev->name, cardname, ioaddr, dev->irq);
+				dev->name, cardname, ioaddr, lp->irq);
 		else
 			printk("%s: %s at %#3x, using polled IO, in Tangent mode.\n", 
 				dev->name, cardname, ioaddr);
@@ -424,7 +436,7 @@
 {
     struct cops_local *lp = netdev_priv(dev);
 
-	if(dev->irq==0)
+	if(lp->irq==0)
 	{
 		/*
 		 * I don't know if the Dayna-style boards support polled 
@@ -491,7 +503,7 @@
 static void cops_reset(struct net_device *dev, int sleep)
 {
         struct cops_local *lp = netdev_priv(dev);
-        int ioaddr=dev->base_addr;
+        int ioaddr=lp->base_addr;
 
         if(lp->board==TANGENT)
         {
@@ -526,7 +538,7 @@
         struct ifreq ifr;
         struct ltfirmware *ltf= (struct ltfirmware *)&ifr.ifr_ifru;
         struct cops_local *lp = netdev_priv(dev);
-        int ioaddr=dev->base_addr;
+        int ioaddr=lp->base_addr;
 	int length, i = 0;
 
         strcpy(ifr.ifr_name,"lt0");
@@ -619,7 +631,7 @@
 static int cops_nodeid (struct net_device *dev, int nodeid)
 {
 	struct cops_local *lp = netdev_priv(dev);
-	int ioaddr = dev->base_addr;
+	int ioaddr = lp->base_addr;
 
 	if(lp->board == DAYNA)
         {
@@ -695,13 +707,14 @@
 	int boguscount = 0;
 
 	struct net_device *dev = (struct net_device *)ltdev;
+	struct cops_local *lp = netdev_priv(dev);
 
 	del_timer(&cops_timer);
 
 	if(dev == NULL)
 		return;	/* We've been downed */
 
-	ioaddr = dev->base_addr;
+	ioaddr = lp->base_addr;
 	do {
 		status=inb(ioaddr+TANG_CARD_STATUS);
 		if(status & TANG_RX_READY)
@@ -725,12 +738,11 @@
 static irqreturn_t cops_interrupt(int irq, void *dev_id, struct pt_regs * regs)
 {
         struct net_device *dev = dev_id;
-        struct cops_local *lp;
+        struct cops_local *lp = netdev_priv(dev);
         int ioaddr, status;
         int boguscount = 0;
 
-        ioaddr = dev->base_addr;
-        lp = netdev_priv(dev);
+        ioaddr = lp->base_addr;
 
 	if(lp->board==DAYNA)
 	{
@@ -766,7 +778,7 @@
         int rsp_type = 0;
         struct sk_buff *skb = NULL;
         struct cops_local *lp = netdev_priv(dev);
-        int ioaddr = dev->base_addr;
+        int ioaddr = lp->base_addr;
         int boguscount = 0;
         unsigned long flags;
 
@@ -870,7 +882,7 @@
 static void cops_timeout(struct net_device *dev)
 {
         struct cops_local *lp = netdev_priv(dev);
-        int ioaddr = dev->base_addr;
+        int ioaddr = lp->base_addr;
 
 	lp->stats.tx_errors++;
         if(lp->board==TANGENT)
@@ -892,7 +904,7 @@
 static int cops_send_packet(struct sk_buff *skb, struct net_device *dev)
 {
         struct cops_local *lp = netdev_priv(dev);
-        int ioaddr = dev->base_addr;
+        int ioaddr = lp->base_addr;
         unsigned long flags;
 
         /*
@@ -1006,7 +1018,7 @@
 
 	/* If we were running polled, yank the timer.
 	 */
-	if(lp->board==TANGENT && dev->irq==0)
+	if(lp->board==TANGENT && lp->irq==0)
 		del_timer(&cops_timer);
 
 	netif_stop_queue(dev);
Index: 2.6.10-rc1-mm1/include/linux/netdevice.h
===================================================================
--- 2.6.10-rc1-mm1.orig/include/linux/netdevice.h	2004-10-31 08:56:31.488324008 +0200
+++ 2.6.10-rc1-mm1/include/linux/netdevice.h	2004-10-31 08:57:41.706649200 +0200
@@ -523,7 +523,9 @@
 extern rwlock_t				dev_base_lock;		/* Device list lock */
 
 extern int			netdev_boot_setup_add(char *name, struct ifmap *map);
-extern int 			netdev_boot_setup_check(struct net_device *dev);
+/* use netdev_boot_ifmap instead */
+extern int __deprecated		netdev_boot_setup_check(struct net_device *dev);
+extern struct ifmap *		netdev_boot_ifmap(const char *name);
 extern unsigned long		netdev_boot_base(const char *prefix, int unit);
 extern struct net_device    *dev_getbyhwaddr(unsigned short type, char *hwaddr);
 extern struct net_device *__dev_getfirstbyhwtype(unsigned short type);
Index: 2.6.10-rc1-mm1/net/core/dev.c
===================================================================
--- 2.6.10-rc1-mm1.orig/net/core/dev.c	2004-10-31 08:56:31.490323704 +0200
+++ 2.6.10-rc1-mm1/net/core/dev.c	2004-10-31 08:56:49.355607768 +0200
@@ -408,6 +408,32 @@
 
 
 /**
+ *	netdev_boot_ifmap	- return boot time settings
+ *	@name: the netdevice name
+ *
+ * 	Check boot time settings for the device.
+ *	The found settings are set for the device to be used
+ *	later in the device probing.
+ *	Returns NULL if no settings found, pointer to struct ifmap if they are.
+ */
+struct ifmap *netdev_boot_ifmap(const char *name)
+{
+	struct netdev_boot_setup *s = dev_boot_setup;
+	struct ifmap *ret = NULL;
+	int i;
+
+	for (i = 0; i < NETDEV_BOOT_SETUP_MAX; i++) {
+		if (s[i].name[0] != '\0' && s[i].name[0] != ' ' &&
+		    !strncmp(name, s[i].name, strlen(s[i].name))) {
+			ret = &s[i].map;
+			break;
+		}
+	}
+	return ret;
+}
+
+
+/**
  *	netdev_boot_base	- get address from boot time settings
  *	@prefix: prefix for network device
  *	@unit: id for network device
@@ -3265,6 +3291,7 @@
 EXPORT_SYMBOL(dev_set_mtu);
 EXPORT_SYMBOL(free_netdev);
 EXPORT_SYMBOL(netdev_boot_setup_check);
+EXPORT_SYMBOL(netdev_boot_ifmap);
 EXPORT_SYMBOL(netdev_set_master);
 EXPORT_SYMBOL(netdev_state_change);
 EXPORT_SYMBOL(netif_receive_skb);


