Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264502AbUE2SO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264502AbUE2SO4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 14:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264652AbUE2SO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 14:14:56 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19669 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264502AbUE2SOb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 14:14:31 -0400
Message-ID: <40B8D2F8.6090905@pobox.com>
Date: Sat, 29 May 2004 14:14:16 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Netdev <netdev@oss.sgi.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       "David S. Miller" <davem@redhat.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Arjan van de Ven <arjanv@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] remove net driver ugliness that sparse complains about
Content-Type: multipart/mixed;
 boundary="------------060107040802050700030303"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060107040802050700030303
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Patch just for comment, do not apply.

In network land, there exists struct ifreq, which passed contains 
per-ioctl data passed to the net driver.  Recently, I marked the user 
pointer component with '__user',

struct ifreq
{
...
         union {
                 struct  sockaddr ifru_addr;
                 struct  sockaddr ifru_dstaddr;
                 struct  sockaddr ifru_broadaddr;
                 struct  sockaddr ifru_netmask;
                 struct  sockaddr ifru_hwaddr;
                 short   ifru_flags;
                 int     ifru_ivalue;
                 int     ifru_mtu;
                 struct  ifmap ifru_map;
                 char    ifru_slave[IFNAMSIZ];   /* Just fits the size */
                 char    ifru_newname[IFNAMSIZ];
                 char __user *   ifru_data;
                 struct  if_settings ifru_settings;
         } ifr_ifru;
};

However, Al noticed that network drivers were doing

	struct mii_ioctl_data *data =
		(struct mii_ioctl_data *) &ifr->ifr_data;

So, we have some code that will copy_to_user from the pointer stored in 
->ifr_data [aka ifr_ifru.ifru_data], and other code that uses the 
address of irf_data to indicate an anonymous BLOB of data stored in the 
union.

I'm a bit curious why sparse complained about taking the _address_ of 
pointer, but nonetheless it's an ugliness that should be contained 
before it spreads :)  Attached is a proposed cleanup patch for comment. 
  The ugliness is confined to include/linux/mii.h, and I avoid use the 
ifru_data field completely.

Untested, but compiles.

	Jeff




--------------060107040802050700030303
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

===== arch/cris/arch-v10/drivers/ethernet.c 1.14 vs edited =====
--- 1.14/arch/cris/arch-v10/drivers/ethernet.c	2004-01-10 19:16:53 -05:00
+++ edited/arch/cris/arch-v10/drivers/ethernet.c	2004-05-29 13:54:18 -04:00
@@ -1251,8 +1251,8 @@
 static int
 e100_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 {
-	struct mii_ioctl_data *data = (struct mii_ioctl_data *)&ifr->ifr_data;
-	struct net_local *np = (struct net_local *)dev->priv;
+	struct mii_ioctl_data *data = if_mii(ifr);
+	struct net_local *np = netdev_priv(dev);
 
 	spin_lock(&np->lock); /* Preempt protection */
 	switch (cmd) {
===== drivers/net/3c59x.c 1.51 vs edited =====
--- 1.51/drivers/net/3c59x.c	2004-05-28 17:35:12 -04:00
+++ edited/drivers/net/3c59x.c	2004-05-29 13:12:50 -04:00
@@ -2873,7 +2873,7 @@
 {
 	struct vortex_private *vp = netdev_priv(dev);
 	long ioaddr = dev->base_addr;
-	struct mii_ioctl_data *data = (struct mii_ioctl_data *)&rq->ifr_data;
+	struct mii_ioctl_data *data = if_mii(rq);
 	int phy = vp->phys[0] & 0x1f;
 	int retval;
 
===== drivers/net/8139cp.c 1.65 vs edited =====
--- 1.65/drivers/net/8139cp.c	2004-04-06 05:22:25 -04:00
+++ edited/drivers/net/8139cp.c	2004-05-29 13:13:03 -04:00
@@ -1546,7 +1546,6 @@
 static int cp_ioctl (struct net_device *dev, struct ifreq *rq, int cmd)
 {
 	struct cp_private *cp = netdev_priv(dev);
-	struct mii_ioctl_data *mii = (struct mii_ioctl_data *) &rq->ifr_data;
 	int rc;
 	unsigned long flags;
 
@@ -1554,7 +1553,7 @@
 		return -EINVAL;
 
 	spin_lock_irqsave(&cp->lock, flags);
-	rc = generic_mii_ioctl(&cp->mii_if, mii, cmd, NULL);
+	rc = generic_mii_ioctl(&cp->mii_if, if_mii(rq), cmd, NULL);
 	spin_unlock_irqrestore(&cp->lock, flags);
 	return rc;
 }
===== drivers/net/8139too.c 1.91 vs edited =====
--- 1.91/drivers/net/8139too.c	2004-05-27 12:53:38 -04:00
+++ edited/drivers/net/8139too.c	2004-05-29 13:13:12 -04:00
@@ -2458,14 +2458,13 @@
 static int netdev_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 {
 	struct rtl8139_private *np = dev->priv;
-	struct mii_ioctl_data *data = (struct mii_ioctl_data *) & rq->ifr_data;
 	int rc;
 
 	if (!netif_running(dev))
 		return -EINVAL;
 
 	spin_lock_irq(&np->lock);
-	rc = generic_mii_ioctl(&np->mii, data, cmd, NULL);
+	rc = generic_mii_ioctl(&np->mii, if_mii(rq), cmd, NULL);
 	spin_unlock_irq(&np->lock);
 
 	return rc;
===== drivers/net/amd8111e.c 1.18 vs edited =====
--- 1.18/drivers/net/amd8111e.c	2004-03-29 12:46:32 -05:00
+++ edited/drivers/net/amd8111e.c	2004-05-29 13:13:23 -04:00
@@ -1694,7 +1694,7 @@
 }
 static int amd8111e_ioctl(struct net_device * dev , struct ifreq *ifr, int cmd)
 {
-	struct mii_ioctl_data *data = (struct mii_ioctl_data *)&ifr->ifr_data;
+	struct mii_ioctl_data *data = if_mii(ifr);
 	struct amd8111e_priv *lp = netdev_priv(dev);
 	int err;
 	u32 mii_regval;
===== drivers/net/b44.c 1.24 vs edited =====
--- 1.24/drivers/net/b44.c	2004-05-27 13:51:15 -04:00
+++ edited/drivers/net/b44.c	2004-05-29 13:13:35 -04:00
@@ -1633,7 +1633,7 @@
 
 static int b44_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 {
-	struct mii_ioctl_data __user *data = (struct mii_ioctl_data __user *)&ifr->ifr_data;
+	struct mii_ioctl_data *data = if_mii(ifr);
 	struct b44 *bp = netdev_priv(dev);
 	int err;
 
===== drivers/net/e100.c 1.14 vs edited =====
--- 1.14/drivers/net/e100.c	2004-05-18 19:34:19 -04:00
+++ edited/drivers/net/e100.c	2004-05-29 13:13:50 -04:00
@@ -2075,9 +2075,8 @@
 static int e100_do_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
 {
 	struct nic *nic = netdev_priv(netdev);
-	struct mii_ioctl_data *mii = (struct mii_ioctl_data *)&ifr->ifr_data;
 
-	return generic_mii_ioctl(&nic->mii, mii, cmd, NULL);
+	return generic_mii_ioctl(&nic->mii, if_mii(ifr), cmd, NULL);
 }
 
 static int e100_alloc(struct nic *nic)
===== drivers/net/eepro100.c 1.74 vs edited =====
--- 1.74/drivers/net/eepro100.c	2004-05-22 04:23:01 -04:00
+++ edited/drivers/net/eepro100.c	2004-05-29 13:13:56 -04:00
@@ -2096,7 +2096,7 @@
 static int speedo_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 {
 	struct speedo_private *sp = netdev_priv(dev);
-	struct mii_ioctl_data *data = (struct mii_ioctl_data *)&rq->ifr_data;
+	struct mii_ioctl_data *data = if_mii(rq);
 	int phy = sp->phy[0] & 0x1f;
 	int saved_acpi;
 	int t;
===== drivers/net/epic100.c 1.37 vs edited =====
--- 1.37/drivers/net/epic100.c	2004-03-14 01:54:58 -05:00
+++ edited/drivers/net/epic100.c	2004-05-29 13:14:02 -04:00
@@ -1440,7 +1440,7 @@
 {
 	struct epic_private *np = dev->priv;
 	long ioaddr = dev->base_addr;
-	struct mii_ioctl_data *data = (struct mii_ioctl_data *)&rq->ifr_data;
+	struct mii_ioctl_data *data = if_mii(rq);
 	int rc;
 
 	/* power-up, if interface is down */
===== drivers/net/fealnx.c 1.48 vs edited =====
--- 1.48/drivers/net/fealnx.c	2004-05-19 09:39:36 -04:00
+++ edited/drivers/net/fealnx.c	2004-05-29 13:14:18 -04:00
@@ -1923,14 +1923,13 @@
 static int mii_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 {
 	struct netdev_private *np = dev->priv;
-	struct mii_ioctl_data *data = (struct mii_ioctl_data *) & rq->ifr_data;
 	int rc;
 
 	if (!netif_running(dev))
 		return -EINVAL;
 
 	spin_lock_irq(&np->lock);
-	rc = generic_mii_ioctl(&np->mii, data, cmd, NULL);
+	rc = generic_mii_ioctl(&np->mii, if_mii(rq), cmd, NULL);
 	spin_unlock_irq(&np->lock);
 
 	return rc;
===== drivers/net/hamachi.c 1.32 vs edited =====
--- 1.32/drivers/net/hamachi.c	2004-03-14 01:54:58 -05:00
+++ edited/drivers/net/hamachi.c	2004-05-29 13:14:24 -04:00
@@ -1937,7 +1937,7 @@
 static int netdev_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 {
 	struct hamachi_private *np = dev->priv;
-	struct mii_ioctl_data *data = (struct mii_ioctl_data *) & rq->ifr_data;
+	struct mii_ioctl_data *data = if_mii(rq);
 	int rc;
 
 	if (!netif_running(dev))
===== drivers/net/ioc3-eth.c 1.25 vs edited =====
--- 1.25/drivers/net/ioc3-eth.c	2004-04-19 11:20:48 -04:00
+++ edited/drivers/net/ioc3-eth.c	2004-05-29 13:14:35 -04:00
@@ -1529,12 +1529,11 @@
 
 static int ioc3_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 {
-	struct mii_ioctl_data *data = (struct mii_ioctl_data *) & rq->ifr_data;
 	struct ioc3_private *ip = netdev_priv(dev);
 	int rc;
 
 	spin_lock_irq(&ip->ioc3_lock);
-	rc = generic_mii_ioctl(&ip->mii, data, cmd, NULL);
+	rc = generic_mii_ioctl(&ip->mii, if_mii(rq), cmd, NULL);
 	spin_unlock_irq(&ip->ioc3_lock);
 
 	return rc;
===== drivers/net/natsemi.c 1.60 vs edited =====
--- 1.60/drivers/net/natsemi.c	2004-04-06 05:22:41 -04:00
+++ edited/drivers/net/natsemi.c	2004-05-29 13:14:45 -04:00
@@ -2417,7 +2417,7 @@
 
 static int netdev_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 {
-	struct mii_ioctl_data *data = (struct mii_ioctl_data *)&rq->ifr_data;
+	struct mii_ioctl_data *data = if_mii(rq);
 
 	switch(cmd) {
 	case SIOCETHTOOL:
===== drivers/net/pci-skeleton.c 1.28 vs edited =====
--- 1.28/drivers/net/pci-skeleton.c	2004-01-10 10:31:38 -05:00
+++ edited/drivers/net/pci-skeleton.c	2004-05-29 13:14:55 -04:00
@@ -1778,7 +1778,7 @@
 static int netdrv_ioctl (struct net_device *dev, struct ifreq *rq, int cmd)
 {
 	struct netdrv_private *tp = dev->priv;
-	struct mii_ioctl_data *data = (struct mii_ioctl_data *) & rq->ifr_data;
+	struct mii_ioctl_data *data = if_mii(rq);
 	unsigned long flags;
 	int rc = 0;
 
===== drivers/net/pcnet32.c 1.73 vs edited =====
--- 1.73/drivers/net/pcnet32.c	2004-05-26 10:01:00 -04:00
+++ edited/drivers/net/pcnet32.c	2004-05-29 13:15:08 -04:00
@@ -2170,14 +2170,13 @@
 static int pcnet32_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 {
     struct pcnet32_private *lp = dev->priv;
-    struct mii_ioctl_data *data = (struct mii_ioctl_data *)&rq->ifr_data;
     int rc;
     unsigned long flags;
 
     /* SIOC[GS]MIIxxx ioctls */
     if (lp->mii) {
 	spin_lock_irqsave(&lp->lock, flags);
-	rc = generic_mii_ioctl(&lp->mii_if, data, cmd, NULL);
+	rc = generic_mii_ioctl(&lp->mii_if, if_mii(rq), cmd, NULL);
 	spin_unlock_irqrestore(&lp->lock, flags);
     } else {
 	rc = -EOPNOTSUPP;
===== drivers/net/sis900.c 1.52 vs edited =====
--- 1.52/drivers/net/sis900.c	2004-05-19 19:52:19 -04:00
+++ edited/drivers/net/sis900.c	2004-05-29 13:15:15 -04:00
@@ -1893,7 +1893,7 @@
 static int mii_ioctl(struct net_device *net_dev, struct ifreq *rq, int cmd)
 {
 	struct sis900_private *sis_priv = net_dev->priv;
-	struct mii_ioctl_data *data = (struct mii_ioctl_data *)&rq->ifr_data;
+	struct mii_ioctl_data *data = if_mii(rq);
 
 	switch(cmd) {
 	case SIOCGMIIPHY:		/* Get address of MII PHY in use. */
===== drivers/net/starfire.c 1.35 vs edited =====
--- 1.35/drivers/net/starfire.c	2004-03-14 01:54:58 -05:00
+++ edited/drivers/net/starfire.c	2004-05-29 14:02:44 -04:00
@@ -2079,7 +2079,6 @@
 static int netdev_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 {
 	struct netdev_private *np = dev->priv;
-	struct mii_ioctl_data *data = (struct mii_ioctl_data *) & rq->ifr_data;
 	int rc;
 
 	if (!netif_running(dev))
@@ -2089,6 +2088,7 @@
 		rc = netdev_ethtool_ioctl(dev, (void *) rq->ifr_data);
 
 	else {
+		struct mii_ioctl_data *data = if_mii(rq);
 		spin_lock_irq(&np->lock);
 		rc = generic_mii_ioctl(&np->mii_if, data, cmd, NULL);
 		spin_unlock_irq(&np->lock);
===== drivers/net/sundance.c 1.54 vs edited =====
--- 1.54/drivers/net/sundance.c	2004-03-14 01:54:58 -05:00
+++ edited/drivers/net/sundance.c	2004-05-29 13:15:40 -04:00
@@ -1659,7 +1659,6 @@
 static int netdev_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 {
 	struct netdev_private *np = dev->priv;
-	struct mii_ioctl_data *data = (struct mii_ioctl_data *) & rq->ifr_data;
 	int rc;
 	int i;
 	long ioaddr = dev->base_addr;
@@ -1672,7 +1671,7 @@
 
 	else {
 		spin_lock_irq(&np->lock);
-		rc = generic_mii_ioctl(&np->mii_if, data, cmd, NULL);
+		rc = generic_mii_ioctl(&np->mii_if, if_mii(rq), cmd, NULL);
 		spin_unlock_irq(&np->lock);
 	}
 	switch (cmd) {
===== drivers/net/sungem.c 1.53 vs edited =====
--- 1.53/drivers/net/sungem.c	2004-03-14 01:54:58 -05:00
+++ edited/drivers/net/sungem.c	2004-05-29 13:15:51 -04:00
@@ -2510,7 +2510,7 @@
 static int gem_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 {
 	struct gem *gp = dev->priv;
-	struct mii_ioctl_data *data = (struct mii_ioctl_data *)&ifr->ifr_data;
+	struct mii_ioctl_data *data = if_mii(ifr);
 	int rc = -EOPNOTSUPP;
 	
 	/* Hold the PM semaphore while doing ioctl's or we may collide
===== drivers/net/tg3.c 1.179 vs edited =====
--- 1.179/drivers/net/tg3.c	2004-05-25 16:06:06 -04:00
+++ edited/drivers/net/tg3.c	2004-05-29 13:16:00 -04:00
@@ -6678,7 +6678,7 @@
 
 static int tg3_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 {
-	struct mii_ioctl_data *data = (struct mii_ioctl_data *)&ifr->ifr_data;
+	struct mii_ioctl_data *data = if_mii(ifr);
 	struct tg3 *tp = netdev_priv(dev);
 	int err;
 
===== drivers/net/tlan.c 1.32 vs edited =====
--- 1.32/drivers/net/tlan.c	2004-05-15 02:11:57 -04:00
+++ edited/drivers/net/tlan.c	2004-05-29 13:16:07 -04:00
@@ -984,7 +984,7 @@
 static int TLan_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 {
 	TLanPrivateInfo *priv = dev->priv;
-	struct mii_ioctl_data *data = (struct mii_ioctl_data *)&rq->ifr_data;
+	struct mii_ioctl_data *data = if_mii(rq);
 	u32 phy   = priv->phy[priv->phyNum];
 	
 	if (!priv->phyOnline)
===== drivers/net/via-rhine.c 1.57 vs edited =====
--- 1.57/drivers/net/via-rhine.c	2004-05-23 10:42:27 -04:00
+++ edited/drivers/net/via-rhine.c	2004-05-29 13:16:17 -04:00
@@ -1875,14 +1875,13 @@
 static int netdev_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 {
 	struct rhine_private *rp = netdev_priv(dev);
-	struct mii_ioctl_data *data = (struct mii_ioctl_data *) & rq->ifr_data;
 	int rc;
 
 	if (!netif_running(dev))
 		return -EINVAL;
 
 	spin_lock_irq(&rp->lock);
-	rc = generic_mii_ioctl(&rp->mii_if, data, cmd, NULL);
+	rc = generic_mii_ioctl(&rp->mii_if, if_mii(rq), cmd, NULL);
 	spin_unlock_irq(&rp->lock);
 
 	return rc;
===== drivers/net/yellowfin.c 1.29 vs edited =====
--- 1.29/drivers/net/yellowfin.c	2004-03-14 01:54:58 -05:00
+++ edited/drivers/net/yellowfin.c	2004-05-29 13:16:24 -04:00
@@ -1433,7 +1433,7 @@
 {
 	struct yellowfin_private *np = dev->priv;
 	long ioaddr = dev->base_addr;
-	struct mii_ioctl_data *data = (struct mii_ioctl_data *)&rq->ifr_data;
+	struct mii_ioctl_data *data = if_mii(rq);
 
 	switch(cmd) {
 	case SIOCETHTOOL:
===== drivers/net/bonding/bond_main.c 1.81 vs edited =====
--- 1.81/drivers/net/bonding/bond_main.c	2004-02-18 22:42:38 -05:00
+++ edited/drivers/net/bonding/bond_main.c	2004-05-29 13:55:04 -04:00
@@ -1103,7 +1103,7 @@
 
 		/* Yes, the mii is overlaid on the ifreq.ifr_ifru */
 		strncpy(ifr.ifr_name, slave_dev->name, IFNAMSIZ);
-		mii = (struct mii_ioctl_data *)&ifr.ifr_data;
+		mii = if_mii(&ifr);
 		if (IOCTL(slave_dev, &ifr, SIOCGMIIPHY) == 0) {
 			mii->reg_num = MII_BMSR;
 			if (IOCTL(slave_dev, &ifr, SIOCGMIIREG) == 0) {
@@ -3680,7 +3680,7 @@
 	case SIOCETHTOOL:
 		return bond_ethtool_ioctl(bond_dev, ifr);
 	case SIOCGMIIPHY:
-		mii = (struct mii_ioctl_data *)&ifr->ifr_data;
+		mii = if_mii(&ifr);
 		if (!mii) {
 			return -EINVAL;
 		}
@@ -3691,7 +3691,7 @@
 		 * We do this again just in case we were called by SIOCGMIIREG
 		 * instead of SIOCGMIIPHY.
 		 */
-		mii = (struct mii_ioctl_data *)&ifr->ifr_data;
+		mii = if_mii(&ifr);
 		if (!mii) {
 			return -EINVAL;
 		}
===== drivers/net/e1000/e1000_main.c 1.116 vs edited =====
--- 1.116/drivers/net/e1000/e1000_main.c	2004-05-25 04:51:31 -04:00
+++ edited/drivers/net/e1000/e1000_main.c	2004-05-29 13:55:13 -04:00
@@ -2503,7 +2503,7 @@
 e1000_mii_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
 {
 	struct e1000_adapter *adapter = netdev->priv;
-	struct mii_ioctl_data *data = (struct mii_ioctl_data *)&ifr->ifr_data;
+	struct mii_ioctl_data *data = if_mii(ifr);
 	int retval;
 	uint16_t mii_reg;
 	uint16_t spddplx;
===== drivers/net/pcmcia/smc91c92_cs.c 1.30 vs edited =====
--- 1.30/drivers/net/pcmcia/smc91c92_cs.c	2004-03-07 20:26:49 -05:00
+++ edited/drivers/net/pcmcia/smc91c92_cs.c	2004-05-29 13:55:22 -04:00
@@ -2221,7 +2221,7 @@
     u_short saved_bank;
     ioaddr_t ioaddr = dev->base_addr;
 
-    mii = (struct mii_ioctl_data *) &rq->ifr_data;
+    mii = if_mii(rq);
     if (!netif_running(dev))
     	return -EINVAL;
 
===== drivers/net/tulip/tulip_core.c 1.60 vs edited =====
--- 1.60/drivers/net/tulip/tulip_core.c	2004-05-27 14:04:54 -04:00
+++ edited/drivers/net/tulip/tulip_core.c	2004-05-29 13:55:30 -04:00
@@ -859,7 +859,7 @@
 {
 	struct tulip_private *tp = netdev_priv(dev);
 	long ioaddr = dev->base_addr;
-	struct mii_ioctl_data *data = (struct mii_ioctl_data *) & rq->ifr_data;
+	struct mii_ioctl_data *data = if_mii(rq);
 	const unsigned int phy_idx = 0;
 	int phy = tp->phys[phy_idx] & 0x1f;
 	unsigned int regnum = data->reg_num;
===== drivers/net/tulip/winbond-840.c 1.41 vs edited =====
--- 1.41/drivers/net/tulip/winbond-840.c	2004-05-27 12:52:00 -04:00
+++ edited/drivers/net/tulip/winbond-840.c	2004-05-29 13:55:44 -04:00
@@ -1526,8 +1526,8 @@
 
 static int netdev_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 {
-	struct mii_ioctl_data *data = (struct mii_ioctl_data *)&rq->ifr_data;
-	struct netdev_private *np = dev->priv;
+	struct mii_ioctl_data *data = if_mii(rq);
+	struct netdev_private *np = netdev_priv(dev);
 
 	switch(cmd) {
 	case SIOCGMIIPHY:		/* Get address of MII PHY in use. */
===== drivers/s390/net/qeth_main.c 1.5 vs edited =====
--- 1.5/drivers/s390/net/qeth_main.c	2004-05-19 12:03:02 -04:00
+++ edited/drivers/s390/net/qeth_main.c	2004-05-29 13:56:15 -04:00
@@ -4478,11 +4478,11 @@
 	case SIOC_QETH_GET_CARD_TYPE:
 		break;
 	case SIOCGMIIPHY:
-		mii_data = (struct mii_ioctl_data *) &rq->ifr_ifru.ifru_data;
+		mii_data = if_mii(rq);
 		mii_data->phy_id = 0;
 		break;
 	case SIOCGMIIREG:
-		mii_data = (struct mii_ioctl_data *) &rq->ifr_ifru.ifru_data;
+		mii_data = if_mii(rq);
 		if (mii_data->phy_id != 0)
 			rc = -EINVAL;
 		else
@@ -4497,7 +4497,7 @@
 			rc = -EPERM;
 			break;
 		}
-		mii_data = (struct mii_ioctl_data *) &rq->ifr_ifru.ifru_data;
+		mii_data = if_mii(rq);
 		if (mii_data->phy_id != 0)
 			rc = -EINVAL;
 		else
===== drivers/usb/net/usbnet.c 1.93 vs edited =====
--- 1.93/drivers/usb/net/usbnet.c	2004-05-18 11:56:54 -04:00
+++ edited/drivers/usb/net/usbnet.c	2004-05-29 13:56:31 -04:00
@@ -2668,9 +2668,7 @@
 	struct usbnet *dev = (struct usbnet *)net->priv;
 
 	if (dev->mii.mdio_read != NULL && dev->mii.mdio_write != NULL)
-		return generic_mii_ioctl(&dev->mii,
-				(struct mii_ioctl_data *) &rq->ifr_data,
-				cmd, NULL);
+		return generic_mii_ioctl(&dev->mii, if_mii(rq), cmd, NULL);
 	}
 #endif
 	return -EOPNOTSUPP;
===== include/linux/mii.h 1.10 vs edited =====
--- 1.10/include/linux/mii.h	2002-09-29 04:16:54 -04:00
+++ edited/include/linux/mii.h	2004-05-29 14:00:20 -04:00
@@ -9,6 +9,7 @@
 #define __LINUX_MII_H__
 
 #include <linux/types.h>
+#include <linux/if.h>
 
 /* Generic MII registers. */
 
@@ -142,6 +143,12 @@
 	u16		val_in;
 	u16		val_out;
 };
+
+
+static inline struct mii_ioctl_data *if_mii(struct ifreq *rq)
+{
+	return (struct mii_ioctl_data *) &rq->ifr_ifru;
+}
 
 
 /**

--------------060107040802050700030303--
