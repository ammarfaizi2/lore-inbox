Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261432AbVC2VGc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261432AbVC2VGc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 16:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbVC2VGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 16:06:31 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58561 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261446AbVC2VEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 16:04:37 -0500
Message-ID: <4249C2D5.8020509@pobox.com>
Date: Tue, 29 Mar 2005 16:04:21 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
CC: Netdev <netdev@oss.sgi.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [BK PATCHES] 2.6.x net driver fixes
Content-Type: multipart/mixed;
 boundary="------------070401090307000803040802"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070401090307000803040802
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------070401090307000803040802
Content-Type: text/plain;
 name="changelog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="changelog.txt"

Please do a

	bk pull bk://gkernel.bkbits.net/net-drivers-2.6

This will update the following files:

 MAINTAINERS                     |    7 ++++---
 drivers/net/8139too.c           |    8 ++++++--
 drivers/net/Kconfig             |    5 +++--
 drivers/net/arcnet/arcnet.c     |    4 ++--
 drivers/net/bonding/bond_alb.c  |    4 +++-
 drivers/net/depca.c             |    2 +-
 drivers/net/mii.c               |    9 ++++++---
 drivers/net/sis900.c            |    2 ++
 drivers/net/sk98lin/skethtool.c |    3 ---
 drivers/net/via-velocity.c      |    6 ++++--
 drivers/net/wireless/airo.c     |    2 +-
 11 files changed, 32 insertions(+), 20 deletions(-)

through these ChangeSets:

<komurojun-mbn:nifty.com>:
  o net/Kconfig: remove unsupported network adapter names

Adrian Bunk:
  o drivers/net/wireless/airo.c: correct a wrong check
  o drivers/net/sis900.c: fix a warning

Andres Salomon:
  o fix pci_disable_device in 8139too

Andrew Morton:
  o bonding needs inet

Dale Farnsworth:
  o mii: GigE support bug fixes

Daniele Venzano:
  o Maintainer change for the sis900 driver

Domen Puncer:
  o net/sk98lin: remove duplicate delay

John W. Linville:
  o bonding: avoid tx balance for IGMP (alb/tlb mode)

Mikael Pettersson:
  o drivers/net/depca.c gcc4 fix
  o drivers/net/arcnet/arcnet.c gcc4 fixes

Pavel Machek:
  o Fix suspend/resume on via-velocity


--------------070401090307000803040802
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff -Nru a/MAINTAINERS b/MAINTAINERS
--- a/MAINTAINERS	2005-03-29 15:49:53 -05:00
+++ b/MAINTAINERS	2005-03-29 15:49:54 -05:00
@@ -2044,10 +2044,11 @@
 S:	Maintained
 
 SIS 900/7016 FAST ETHERNET DRIVER
-P:	Ollie Lho
-M:	ollie@sis.com.tw
+P:	Daniele Venzano
+M:	venza@brownhat.org
+W:	http://www.brownhat.org/sis900.html
 L:	linux-net@vger.kernel.org
-S:	Supported
+S:	Maintained
 
 SIS FRAMEBUFFER DRIVER
 P:	Thomas Winischhofer
diff -Nru a/drivers/net/8139too.c b/drivers/net/8139too.c
--- a/drivers/net/8139too.c	2005-03-29 15:49:53 -05:00
+++ b/drivers/net/8139too.c	2005-03-29 15:49:53 -05:00
@@ -749,7 +749,6 @@
 	pci_release_regions (pdev);
 
 	free_netdev(dev);
-	pci_disable_device(pdev);
 	pci_set_drvdata (pdev, NULL);
 }
 
@@ -778,7 +777,7 @@
 	struct net_device *dev;
 	struct rtl8139_private *tp;
 	u8 tmp8;
-	int rc;
+	int rc, disable_dev_on_err = 0;
 	unsigned int i;
 	unsigned long pio_start, pio_end, pio_flags, pio_len;
 	unsigned long mmio_start, mmio_end, mmio_flags, mmio_len;
@@ -850,6 +849,7 @@
 	rc = pci_request_regions (pdev, "8139too");
 	if (rc)
 		goto err_out;
+	disable_dev_on_err = 1;
 
 	/* enable PCI bus-mastering */
 	pci_set_master (pdev);
@@ -935,6 +935,8 @@
 
 err_out:
 	__rtl8139_cleanup_dev (dev);
+	if (disable_dev_on_err)
+		pci_disable_device (pdev);
 	return rc;
 }
 
@@ -1112,6 +1114,7 @@
 
 err_out:
 	__rtl8139_cleanup_dev (dev);
+	pci_disable_device (pdev);
 	return i;
 }
 
@@ -1125,6 +1128,7 @@
 	unregister_netdev (dev);
 
 	__rtl8139_cleanup_dev (dev);
+	pci_disable_device (pdev);
 }
 
 
diff -Nru a/drivers/net/Kconfig b/drivers/net/Kconfig
--- a/drivers/net/Kconfig	2005-03-29 15:49:54 -05:00
+++ b/drivers/net/Kconfig	2005-03-29 15:49:54 -05:00
@@ -44,6 +44,7 @@
 config BONDING
 	tristate "Bonding driver support"
 	depends on NETDEVICES
+	depends on INET
 	---help---
 	  Say 'Y' or 'M' if you wish to be able to 'bond' multiple Ethernet
 	  Channels together. This is called 'Etherchannel' by Cisco,
@@ -612,7 +613,7 @@
 	  will be called 3c507.
 
 config EL3
-	tristate "3c509/3c529 (MCA)/3c569B (98)/3c579 \"EtherLink III\" support"
+	tristate "3c509/3c529 (MCA)/3c579 \"EtherLink III\" support"
 	depends on NET_VENDOR_3COM && (ISA || EISA || MCA)
 	---help---
 	  If you have a network (Ethernet) card belonging to the 3Com
@@ -876,7 +877,7 @@
 source "drivers/net/tulip/Kconfig"
 
 config AT1700
-	tristate "AT1700/1720/RE1000Plus(C-Bus) support (EXPERIMENTAL)"
+	tristate "AT1700/1720 support (EXPERIMENTAL)"
 	depends on NET_ETHERNET && (ISA || MCA_LEGACY) && EXPERIMENTAL
 	select CRC32
 	---help---
diff -Nru a/drivers/net/arcnet/arcnet.c b/drivers/net/arcnet/arcnet.c
--- a/drivers/net/arcnet/arcnet.c	2005-03-29 15:49:54 -05:00
+++ b/drivers/net/arcnet/arcnet.c	2005-03-29 15:49:54 -05:00
@@ -253,7 +253,7 @@
 	BUGLVL(D_DURING) {
 		BUGMSG(D_DURING, "release_arcbuf: freed #%d; buffer queue is now: ",
 		       bufnum);
-		for (i = lp->next_buf; i != lp->first_free_buf; i = ++i % 5)
+		for (i = lp->next_buf; i != lp->first_free_buf; i = (i+1) % 5)
 			BUGMSG2(D_DURING, "#%d ", lp->buf_queue[i]);
 		BUGMSG2(D_DURING, "\n");
 	}
@@ -289,7 +289,7 @@
 
 	BUGLVL(D_DURING) {
 		BUGMSG(D_DURING, "get_arcbuf: got #%d; buffer queue is now: ", buf);
-		for (i = lp->next_buf; i != lp->first_free_buf; i = ++i % 5)
+		for (i = lp->next_buf; i != lp->first_free_buf; i = (i+1) % 5)
 			BUGMSG2(D_DURING, "#%d ", lp->buf_queue[i]);
 		BUGMSG2(D_DURING, "\n");
 	}
diff -Nru a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
--- a/drivers/net/bonding/bond_alb.c	2005-03-29 15:49:54 -05:00
+++ b/drivers/net/bonding/bond_alb.c	2005-03-29 15:49:54 -05:00
@@ -54,6 +54,7 @@
 #include <linux/if_ether.h>
 #include <linux/if_bonding.h>
 #include <linux/if_vlan.h>
+#include <linux/in.h>
 #include <net/ipx.h>
 #include <net/arp.h>
 #include <asm/byteorder.h>
@@ -1300,7 +1301,8 @@
 	switch (ntohs(skb->protocol)) {
 	case ETH_P_IP:
 		if ((memcmp(eth_data->h_dest, mac_bcast, ETH_ALEN) == 0) ||
-		    (skb->nh.iph->daddr == ip_bcast)) {
+		    (skb->nh.iph->daddr == ip_bcast) ||
+		    (skb->nh.iph->protocol == IPPROTO_IGMP)) {
 			do_tx_balance = 0;
 			break;
 		}
diff -Nru a/drivers/net/depca.c b/drivers/net/depca.c
--- a/drivers/net/depca.c	2005-03-29 15:49:53 -05:00
+++ b/drivers/net/depca.c	2005-03-29 15:49:53 -05:00
@@ -1827,7 +1827,7 @@
 
 		/* set up the buffer descriptors */
 		len = (skb->len < ETH_ZLEN) ? ETH_ZLEN : skb->len;
-		for (i = entry; i != end; i = (++i) & lp->txRingMask) {
+		for (i = entry; i != end; i = (i+1) & lp->txRingMask) {
 			/* clean out flags */
 			writel(readl(&lp->tx_ring[i].base) & ~T_FLAGS, &lp->tx_ring[i].base);
 			writew(0x0000, &lp->tx_ring[i].misc);	/* clears other error flags */
diff -Nru a/drivers/net/mii.c b/drivers/net/mii.c
--- a/drivers/net/mii.c	2005-03-29 15:49:53 -05:00
+++ b/drivers/net/mii.c	2005-03-29 15:49:53 -05:00
@@ -43,6 +43,9 @@
 	    (SUPPORTED_10baseT_Half | SUPPORTED_10baseT_Full |
 	     SUPPORTED_100baseT_Half | SUPPORTED_100baseT_Full |
 	     SUPPORTED_Autoneg | SUPPORTED_TP | SUPPORTED_MII);
+	if (mii->supports_gmii)
+		ecmd->supported |= SUPPORTED_1000baseT_Half |
+			SUPPORTED_1000baseT_Full;
 
 	/* only supports twisted-pair */
 	ecmd->port = PORT_MII;
@@ -100,7 +103,7 @@
 	} else {
 		ecmd->autoneg = AUTONEG_DISABLE;
 
-		ecmd->speed = ((bmcr2 & BMCR_SPEED1000 && 
+		ecmd->speed = ((bmcr & BMCR_SPEED1000 && 
 				(bmcr & BMCR_SPEED100) == 0) ? SPEED_1000 :
 			       (bmcr & BMCR_SPEED100) ? SPEED_100 : SPEED_10);
 		ecmd->duplex = (bmcr & BMCR_FULLDPLX) ? DUPLEX_FULL : DUPLEX_HALF;
@@ -163,9 +166,9 @@
 			tmp |= ADVERTISE_100FULL;
 		if (mii->supports_gmii) {
 			if (ecmd->advertising & ADVERTISED_1000baseT_Half)
-				advert2 |= ADVERTISE_1000HALF;
+				tmp2 |= ADVERTISE_1000HALF;
 			if (ecmd->advertising & ADVERTISED_1000baseT_Full)
-				advert2 |= ADVERTISE_1000FULL;
+				tmp2 |= ADVERTISE_1000FULL;
 		}
 		if (advert != tmp) {
 			mii->mdio_write(dev, mii->phy_id, MII_ADVERTISE, tmp);
diff -Nru a/drivers/net/sis900.c b/drivers/net/sis900.c
--- a/drivers/net/sis900.c	2005-03-29 15:49:53 -05:00
+++ b/drivers/net/sis900.c	2005-03-29 15:49:53 -05:00
@@ -196,7 +196,9 @@
 MODULE_PARM_DESC(max_interrupt_work, "SiS 900/7016 maximum events handled per interrupt");
 MODULE_PARM_DESC(sis900_debug, "SiS 900/7016 bitmapped debugging message level");
 
+#ifdef CONFIG_NET_POLL_CONTROLLER
 static void sis900_poll(struct net_device *dev);
+#endif
 static int sis900_open(struct net_device *net_dev);
 static int sis900_mii_probe (struct net_device * net_dev);
 static void sis900_init_rxfilter (struct net_device * net_dev);
diff -Nru a/drivers/net/sk98lin/skethtool.c b/drivers/net/sk98lin/skethtool.c
--- a/drivers/net/sk98lin/skethtool.c	2005-03-29 15:49:54 -05:00
+++ b/drivers/net/sk98lin/skethtool.c	2005-03-29 15:49:54 -05:00
@@ -437,9 +437,6 @@
 	pAC->LedsOn = 0;
 	mod_timer(&pAC->BlinkTimer, jiffies);
 	msleep_interruptible(data * 1000);
-
-	set_current_state(TASK_INTERRUPTIBLE);
-	schedule_timeout(data * HZ);
 	del_timer_sync(&pAC->BlinkTimer);
 	toggleLeds(pNet, 0);
 
diff -Nru a/drivers/net/via-velocity.c b/drivers/net/via-velocity.c
--- a/drivers/net/via-velocity.c	2005-03-29 15:49:54 -05:00
+++ b/drivers/net/via-velocity.c	2005-03-29 15:49:54 -05:00
@@ -3212,7 +3212,8 @@
 
 static int velocity_suspend(struct pci_dev *pdev, pm_message_t state)
 {
-	struct velocity_info *vptr = pci_get_drvdata(pdev);
+	struct net_device *dev = pci_get_drvdata(pdev);
+	struct velocity_info *vptr = netdev_priv(dev);
 	unsigned long flags;
 
 	if(!netif_running(vptr->dev))
@@ -3245,7 +3246,8 @@
 
 static int velocity_resume(struct pci_dev *pdev)
 {
-	struct velocity_info *vptr = pci_get_drvdata(pdev);
+	struct net_device *dev = pci_get_drvdata(pdev);
+	struct velocity_info *vptr = netdev_priv(dev);
 	unsigned long flags;
 	int i;
 
diff -Nru a/drivers/net/wireless/airo.c b/drivers/net/wireless/airo.c
--- a/drivers/net/wireless/airo.c	2005-03-29 15:49:53 -05:00
+++ b/drivers/net/wireless/airo.c	2005-03-29 15:49:53 -05:00
@@ -3440,7 +3440,7 @@
 	/* Make sure we got something */
 	if (rxd.rdy && rxd.valid == 0) {
 		len = rxd.len + 12;
-		if (len < 12 && len > 2048)
+		if (len < 12 || len > 2048)
 			goto badrx;
 
 		skb = dev_alloc_skb(len);

--------------070401090307000803040802--
