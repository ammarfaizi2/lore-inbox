Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275120AbSITGKl>; Fri, 20 Sep 2002 02:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275139AbSITGKl>; Fri, 20 Sep 2002 02:10:41 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49158 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S275120AbSITGKj>;
	Fri, 20 Sep 2002 02:10:39 -0400
Message-ID: <3D8ABCEF.9060207@mandrakesoft.com>
Date: Fri, 20 Sep 2002 02:15:11 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Felipe W Damasio <felipewd@terra.com.br>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
Subject: ALTPATCH: 8139cp: LinkChg support
References: <1032487254.247.7.camel@tank>
Content-Type: multipart/mixed;
 boundary="------------060401040508060002020305"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060401040508060002020305
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Felipe,

Here is the patch I just committed, instead of your patch.  I wanted a 
more generic solution, that is easily pluggable into other drivers.

Please test and let me know if you find bugs, or want additions...

	Jeff




--------------060401040508060002020305
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff -Nru a/drivers/net/8139cp.c b/drivers/net/8139cp.c
--- a/drivers/net/8139cp.c	Fri Sep 20 02:13:15 2002
+++ b/drivers/net/8139cp.c	Fri Sep 20 02:13:15 2002
@@ -22,11 +22,11 @@
 	
 		Wake-on-LAN support - Felipe Damasio <felipewd@terra.com.br>
 		PCI suspend/resume  - Felipe Damasio <felipewd@terra.com.br>
+		LinkChg interrupt   - Felipe Damasio <felipewd@terra.com.br>
 			
 	TODO, in rough priority order:
 	* Test Tx checksumming thoroughly
 	* dev->tx_timeout
-	* LinkChg interrupt
 	* Support forcing media type with a module parameter,
 	  like dl2k.c/sundance.c
 	* Constants (module parms?) for Rx work limit
@@ -677,6 +677,8 @@
 		cp_rx(cp);
 	if (status & (TxOK | TxErr | TxEmpty | SWInt))
 		cp_tx(cp);
+	if (status & LinkChg)
+		mii_check_media(&cp->mii_if, netif_msg_link(cp));
 
 	if (status & PciErr) {
 		u16 pci_status;
@@ -1192,6 +1194,8 @@
 	if (rc)
 		goto err_out_hw;
 
+	netif_carrier_off(dev);
+	mii_check_media(&cp->mii_if, netif_msg_link(cp));
 	netif_start_queue(dev);
 
 	return 0;
@@ -1210,6 +1214,7 @@
 		printk(KERN_DEBUG "%s: disabling interface\n", dev->name);
 
 	netif_stop_queue(dev);
+	netif_carrier_off(dev);
 
 	spin_lock_irq(&cp->lock);
 	cp_stop_hw(cp);
diff -Nru a/drivers/net/mii.c b/drivers/net/mii.c
--- a/drivers/net/mii.c	Fri Sep 20 02:13:15 2002
+++ b/drivers/net/mii.c	Fri Sep 20 02:13:15 2002
@@ -170,6 +170,75 @@
 	return r;
 }
 
+void mii_check_link (struct mii_if_info *mii)
+{
+	if (mii_link_ok(mii))
+		netif_carrier_on(mii->dev);
+	else
+		netif_carrier_off(mii->dev);
+}
+
+unsigned int mii_check_media (struct mii_if_info *mii, unsigned int ok_to_print)
+{
+	unsigned int old_carrier, new_carrier;
+	int advertise, lpa, media, duplex;
+
+	/* if forced media, go no further */
+	if (mii->duplex_lock)
+		return 0; /* duplex did not change */
+
+	/* check current and old link status */
+	old_carrier = netif_carrier_ok(mii->dev) ? 1 : 0;
+	new_carrier = (unsigned int) mii_link_ok(mii);
+
+	/* if carrier state did not change, this is a "bounce",
+	 * just exit as everything is already set correctly
+	 */
+	if (old_carrier == new_carrier)
+		return 0; /* duplex did not change */
+
+	/* no carrier, nothing much to do */
+	if (!new_carrier) {
+		netif_carrier_off(mii->dev);
+		if (ok_to_print)
+			printk(KERN_INFO "%s: link down\n", mii->dev->name);
+		return 0; /* duplex did not change */
+	}
+
+	/*
+	 * we have carrier, see who's on the other end
+	 */
+	netif_carrier_on(mii->dev);
+
+	/* get MII advertise and LPA values */
+	if (mii->advertising)
+		advertise = mii->advertising;
+	else {
+		advertise = mii->mdio_read(mii->dev, mii->phy_id, MII_ADVERTISE);
+		mii->advertising = advertise;
+	}
+	lpa = mii->mdio_read(mii->dev, mii->phy_id, MII_LPA);
+
+	/* figure out media and duplex from advertise and LPA values */
+	media = mii_nway_result(lpa & advertise);
+	duplex = (media & (ADVERTISE_100FULL | ADVERTISE_10FULL)) ? 1 : 0;
+
+	if (ok_to_print)
+		printk(KERN_INFO "%s: link up, %sMbps, %s-duplex, lpa 0x%04X\n",
+		       mii->dev->name,
+		       media & (ADVERTISE_100FULL | ADVERTISE_100HALF) ?
+		       		"100" : "10",
+		       duplex ? "full" : "half",
+		       lpa);
+
+	if (mii->full_duplex != duplex) {
+		mii->full_duplex = duplex;
+		return 1; /* duplex changed */
+	}
+
+	return 0; /* duplex did not change */
+}
+
 MODULE_AUTHOR ("Jeff Garzik <jgarzik@mandrakesoft.com>");
 MODULE_DESCRIPTION ("MII hardware support library");
 MODULE_LICENSE("GPL");
@@ -178,3 +247,6 @@
 EXPORT_SYMBOL(mii_nway_restart);
 EXPORT_SYMBOL(mii_ethtool_gset);
 EXPORT_SYMBOL(mii_ethtool_sset);
+EXPORT_SYMBOL(mii_check_link);
+EXPORT_SYMBOL(mii_check_media);
+
diff -Nru a/include/linux/mii.h b/include/linux/mii.h
--- a/include/linux/mii.h	Fri Sep 20 02:13:15 2002
+++ b/include/linux/mii.h	Fri Sep 20 02:13:15 2002
@@ -118,10 +118,12 @@
 
 struct ethtool_cmd;
 
-int mii_link_ok (struct mii_if_info *mii);
-int mii_nway_restart (struct mii_if_info *mii);
-int mii_ethtool_gset(struct mii_if_info *mii, struct ethtool_cmd *ecmd);
-int mii_ethtool_sset(struct mii_if_info *mii, struct ethtool_cmd *ecmd);
+extern int mii_link_ok (struct mii_if_info *mii);
+extern int mii_nway_restart (struct mii_if_info *mii);
+extern int mii_ethtool_gset(struct mii_if_info *mii, struct ethtool_cmd *ecmd);
+extern int mii_ethtool_sset(struct mii_if_info *mii, struct ethtool_cmd *ecmd);
+extern void mii_check_link (struct mii_if_info *mii);
+extern unsigned int mii_check_media (struct mii_if_info *mii, unsigned int ok_to_print);
 
 
 /* This structure is used in all SIOCxMIIxxx ioctl calls */

--------------060401040508060002020305--

