Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266795AbSK1Wtu>; Thu, 28 Nov 2002 17:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266817AbSK1Wtt>; Thu, 28 Nov 2002 17:49:49 -0500
Received: from [195.39.17.254] ([195.39.17.254]:26372 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S266795AbSK1Wtq>;
	Thu, 28 Nov 2002 17:49:46 -0500
Date: Thu, 28 Nov 2002 21:13:35 +0100
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>,
       perex@suse.cz
Subject: HP100 cleanups and coax problems
Message-ID: <20021128201335.GA9337@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This cleans up hp100 a bit -- two copies of "checking LAN" code do not
look too nice to me.

And.. I have a problem. I have two of these cards, 2970-800001A and
2970-800001B, and they both work fine in twisted pair mode, but fail
to work when coax is attached [Act LED blinks on attempts to transmit,
Link LED stays off]. Is there a way to help me?

Please apply [patch against 2.5.49],
								Pavel

--- clean/drivers/net/hp100.c	2002-11-23 19:55:22.000000000 +0100
+++ linux-swsusp/drivers/net/hp100.c	2002-11-28 21:01:08.000000000 +0100
@@ -285,7 +285,6 @@
 
 #define HP100_PCI_IDS_SIZE	(sizeof(hp100_pci_ids)/sizeof(struct hp100_pci_id))
 
-#if LINUX_VERSION_CODE >= 0x20400
 static struct pci_device_id hp100_pci_tbl[] __initdata = {
 	{PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_J2585A, PCI_ANY_ID, PCI_ANY_ID,},
 	{PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_J2585B, PCI_ANY_ID, PCI_ANY_ID,},
@@ -294,7 +293,6 @@
 	{}			/* Terminating entry */
 };
 MODULE_DEVICE_TABLE(pci, hp100_pci_tbl);
-#endif				/* LINUX_VERSION_CODE >= 0x20400 */
 
 static int hp100_rx_ratio = HP100_DEFAULT_RX_RATIO;
 static int hp100_priority_tx = HP100_DEFAULT_PRIORITY_TX;
@@ -1515,6 +1513,24 @@
 	/* Busmaster mode should be shut down now. */
 }
 
+static int hp100_check_lan(struct net_device *dev)
+{
+	struct hp100_private *lp = (struct hp100_private *) dev->priv;
+
+	if (lp->lan_type < 0) {	/* no LAN type detected yet? */
+		hp100_stop_interface(dev);
+		if ((lp->lan_type = hp100_sense_lan(dev)) < 0) {
+			printk("hp100: %s: no connection found - check wire\n", dev->name);
+			hp100_start_interface(dev);	/* 10Mb/s RX packets maybe handled */
+			return -EIO;
+		}
+		if (lp->lan_type == HP100_LAN_100)
+			lp->hub_status = hp100_login_to_vg_hub(dev, FALSE);	/* relogin */
+		hp100_start_interface(dev);
+	}
+	return 0;
+}
+
 /* 
  *  transmit functions
  */
@@ -1550,17 +1566,8 @@
 		if (jiffies - dev->trans_start < HZ)
 			return -EAGAIN;
 
-		if (lp->lan_type < 0) {	/* no LAN type detected yet? */
-			hp100_stop_interface(dev);
-			if ((lp->lan_type = hp100_sense_lan(dev)) < 0) {
-				printk("hp100: %s: no connection found - check wire\n", dev->name);
-				hp100_start_interface(dev);	/* 10Mb/s RX pkts maybe handled */
-				return -EIO;
-			}
-			if (lp->lan_type == HP100_LAN_100)
-				lp->hub_status = hp100_login_to_vg_hub(dev, FALSE);	/* relogin */
-			hp100_start_interface(dev);
-		}
+		if (hp100_check_lan(dev))
+			return -EIO;
 
 		if (lp->lan_type == HP100_LAN_100 && lp->hub_status < 0) {
 			/* we have a 100Mb/s adapter but it isn't connected to hub */
@@ -1577,7 +1584,7 @@
 			if (i == HP100_LAN_ERR)
 				printk("hp100: %s: link down detected\n", dev->name);
 			else if (lp->lan_type != i) {	/* cable change! */
-				/* it's very hard - all network setting must be changed!!! */
+				/* it's very hard - all network settings must be changed!!! */
 				printk("hp100: %s: cable change 10Mb/s <-> 100Mb/s detected\n", dev->name);
 				lp->lan_type = i;
 				hp100_stop_interface(dev);
@@ -1699,17 +1706,8 @@
 	if (skb->len <= 0)
 		return 0;
 
-	if (lp->lan_type < 0) {	/* no LAN type detected yet? */
-		hp100_stop_interface(dev);
-		if ((lp->lan_type = hp100_sense_lan(dev)) < 0) {
-			printk("hp100: %s: no connection found - check wire\n", dev->name);
-			hp100_start_interface(dev);	/* 10Mb/s RX packets maybe handled */
-			return -EIO;
-		}
-		if (lp->lan_type == HP100_LAN_100)
-			lp->hub_status = hp100_login_to_vg_hub(dev, FALSE);	/* relogin */
-		hp100_start_interface(dev);
-	}
+	if (hp100_check_lan(dev))
+		return -EIO;
 
 	/* If there is not enough free memory on the card... */
 	i = hp100_inl(TX_MEM_FREE) & 0x7fffffff;

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
