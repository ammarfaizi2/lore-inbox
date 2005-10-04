Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932335AbVJDDFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbVJDDFK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 23:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbVJDDFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 23:05:09 -0400
Received: from havoc.gtf.org ([69.61.125.42]:58015 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932335AbVJDDFH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 23:05:07 -0400
Date: Mon, 3 Oct 2005 23:05:03 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] 2.6.x net driver fixes
Message-ID: <20051004030503.GA11363@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-fixes' branch of
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git

to obtain the following fixes:

 drivers/net/Kconfig                  |    8 -
 drivers/net/bonding/bond_main.c      |  280 ++++++++---------------------------
 drivers/net/bonding/bonding.h        |    4 
 drivers/net/ibm_emac/ibm_emac_core.c |   31 +++
 drivers/net/ns83820.c                |    2 
 drivers/net/pcmcia/smc91c92_cs.c     |    2 
 drivers/net/skge.c                   |   24 ++-
 drivers/net/starfire.c               |   46 +++--
 drivers/net/tulip/21142.c            |    2 
 drivers/s390/net/qeth.h              |    2 
 drivers/s390/net/qeth_main.c         |   37 ++--
 net/ieee80211/ieee80211_tx.c         |    2 
 12 files changed, 169 insertions(+), 271 deletions(-)


Grant Coady:
  net/Kconfig: convert pocket_adapter ISA to PARPORT

Ion Badulescu:
  [netdrvr starfire] fix highmem and broken firmware issues

Jay Vosburgh:
  fix bonding crash, remove old ABI support

Komuro:
  [netdrvr] fix smc91c92_cs multicast bug

Philippe De Muyter:
  tulip DC21143 rev 48 10Mbit HDX fix

Randy Dunlap:
  ns83820: fix gfp flags type
  ieee80211: fix gfp flags type

Stephen Hemminger:
  skge: set mac address oops with bonding

Ursula Braun:
  s390: qeth driver fixes

Wade Farnsworth:
  emac: add support for platform-specific unsupported PHY features

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -1655,7 +1655,7 @@ config LAN_SAA9730
 
 config NET_POCKET
 	bool "Pocket and portable adapters"
-	depends on NET_ETHERNET && ISA
+	depends on NET_ETHERNET && PARPORT
 	---help---
 	  Cute little network (Ethernet) devices which attach to the parallel
 	  port ("pocket adapters"), commonly used with laptops. If you have
@@ -1679,7 +1679,7 @@ config NET_POCKET
 
 config ATP
 	tristate "AT-LAN-TEC/RealTek pocket adapter support"
-	depends on NET_POCKET && ISA && X86
+	depends on NET_POCKET && PARPORT && X86
 	select CRC32
 	---help---
 	  This is a network (Ethernet) device which attaches to your parallel
@@ -1694,7 +1694,7 @@ config ATP
 
 config DE600
 	tristate "D-Link DE600 pocket adapter support"
-	depends on NET_POCKET && ISA
+	depends on NET_POCKET && PARPORT
 	---help---
 	  This is a network (Ethernet) device which attaches to your parallel
 	  port. Read <file:Documentation/networking/DLINK.txt> as well as the
@@ -1709,7 +1709,7 @@ config DE600
 
 config DE620
 	tristate "D-Link DE620 pocket adapter support"
-	depends on NET_POCKET && ISA
+	depends on NET_POCKET && PARPORT
 	---help---
 	  This is a network (Ethernet) device which attaches to your parallel
 	  port. Read <file:Documentation/networking/DLINK.txt> as well as the
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -487,6 +487,8 @@
  *	  * Added xmit_hash_policy_layer34()
  *	- Modified by Jay Vosburgh <fubar@us.ibm.com> to also support mode 4.
  *	  Set version to 2.6.3.
+ * 2005/09/26 - Jay Vosburgh <fubar@us.ibm.com>
+ *	- Removed backwards compatibility for old ifenslaves.  Version 2.6.4.
  */
 
 //#define BONDING_DEBUG 1
@@ -595,14 +597,7 @@ static int arp_ip_count	= 0;
 static int bond_mode	= BOND_MODE_ROUNDROBIN;
 static int xmit_hashtype= BOND_XMIT_POLICY_LAYER2;
 static int lacp_fast	= 0;
-static int app_abi_ver	= 0;
-static int orig_app_abi_ver = -1; /* This is used to save the first ABI version
-				   * we receive from the application. Once set,
-				   * it won't be changed, and the module will
-				   * refuse to enslave/release interfaces if the
-				   * command comes from an application using
-				   * another ABI version.
-				   */
+
 struct bond_parm_tbl {
 	char *modename;
 	int mode;
@@ -1702,51 +1697,29 @@ static int bond_enslave(struct net_devic
 		}
 	}
 
-	if (app_abi_ver >= 1) {
-		/* The application is using an ABI, which requires the
-		 * slave interface to be closed.
-		 */
-		if ((slave_dev->flags & IFF_UP)) {
-			printk(KERN_ERR DRV_NAME
-			       ": Error: %s is up\n",
-			       slave_dev->name);
-			res = -EPERM;
-			goto err_undo_flags;
-		}
-
-		if (slave_dev->set_mac_address == NULL) {
-			printk(KERN_ERR DRV_NAME
-			       ": Error: The slave device you specified does "
-			       "not support setting the MAC address.\n");
-			printk(KERN_ERR
-			       "Your kernel likely does not support slave "
-			       "devices.\n");
+	/*
+	 * Old ifenslave binaries are no longer supported.  These can
+	 * be identified with moderate accurary by the state of the slave:
+	 * the current ifenslave will set the interface down prior to
+	 * enslaving it; the old ifenslave will not.
+	 */
+	if ((slave_dev->flags & IFF_UP)) {
+		printk(KERN_ERR DRV_NAME ": %s is up. "
+		       "This may be due to an out of date ifenslave.\n",
+		       slave_dev->name);
+		res = -EPERM;
+		goto err_undo_flags;
+	}
 
-			res = -EOPNOTSUPP;
-			goto err_undo_flags;
-		}
-	} else {
-		/* The application is not using an ABI, which requires the
-		 * slave interface to be open.
-		 */
-		if (!(slave_dev->flags & IFF_UP)) {
-			printk(KERN_ERR DRV_NAME
-			       ": Error: %s is not running\n",
-			       slave_dev->name);
-			res = -EINVAL;
-			goto err_undo_flags;
-		}
+	if (slave_dev->set_mac_address == NULL) {
+		printk(KERN_ERR DRV_NAME
+		       ": Error: The slave device you specified does "
+		       "not support setting the MAC address.\n");
+		printk(KERN_ERR
+		       "Your kernel likely does not support slave devices.\n");
 
-		if ((bond->params.mode == BOND_MODE_8023AD) ||
-		    (bond->params.mode == BOND_MODE_TLB)    ||
-		    (bond->params.mode == BOND_MODE_ALB)) {
-			printk(KERN_ERR DRV_NAME
-			       ": Error: to use %s mode, you must upgrade "
-			       "ifenslave.\n",
-			       bond_mode_name(bond->params.mode));
-			res = -EOPNOTSUPP;
-			goto err_undo_flags;
-		}
+		res = -EOPNOTSUPP;
+		goto err_undo_flags;
 	}
 
 	new_slave = kmalloc(sizeof(struct slave), GFP_KERNEL);
@@ -1762,41 +1735,36 @@ static int bond_enslave(struct net_devic
 	 */
 	new_slave->original_flags = slave_dev->flags;
 
-	if (app_abi_ver >= 1) {
-		/* save slave's original ("permanent") mac address for
-		 * modes that needs it, and for restoring it upon release,
-		 * and then set it to the master's address
-		 */
-		memcpy(new_slave->perm_hwaddr, slave_dev->dev_addr, ETH_ALEN);
+	/*
+	 * Save slave's original ("permanent") mac address for modes
+	 * that need it, and for restoring it upon release, and then
+	 * set it to the master's address
+	 */
+	memcpy(new_slave->perm_hwaddr, slave_dev->dev_addr, ETH_ALEN);
 
-		/* set slave to master's mac address
-		 * The application already set the master's
-		 * mac address to that of the first slave
-		 */
-		memcpy(addr.sa_data, bond_dev->dev_addr, bond_dev->addr_len);
-		addr.sa_family = slave_dev->type;
-		res = dev_set_mac_address(slave_dev, &addr);
-		if (res) {
-			dprintk("Error %d calling set_mac_address\n", res);
-			goto err_free;
-		}
+	/*
+	 * Set slave to master's mac address.  The application already
+	 * set the master's mac address to that of the first slave
+	 */
+	memcpy(addr.sa_data, bond_dev->dev_addr, bond_dev->addr_len);
+	addr.sa_family = slave_dev->type;
+	res = dev_set_mac_address(slave_dev, &addr);
+	if (res) {
+		dprintk("Error %d calling set_mac_address\n", res);
+		goto err_free;
+	}
 
-		/* open the slave since the application closed it */
-		res = dev_open(slave_dev);
-		if (res) {
-			dprintk("Openning slave %s failed\n", slave_dev->name);
-			goto err_restore_mac;
-		}
+	/* open the slave since the application closed it */
+	res = dev_open(slave_dev);
+	if (res) {
+		dprintk("Openning slave %s failed\n", slave_dev->name);
+		goto err_restore_mac;
 	}
 
 	res = netdev_set_master(slave_dev, bond_dev);
 	if (res) {
 		dprintk("Error %d calling netdev_set_master\n", res);
-		if (app_abi_ver < 1) {
-			goto err_free;
-		} else {
-			goto err_close;
-		}
+		goto err_close;
 	}
 
 	new_slave->dev = slave_dev;
@@ -1997,39 +1965,6 @@ static int bond_enslave(struct net_devic
 
 	write_unlock_bh(&bond->lock);
 
-	if (app_abi_ver < 1) {
-		/*
-		 * !!! This is to support old versions of ifenslave.
-		 * We can remove this in 2.5 because our ifenslave takes
-		 * care of this for us.
-		 * We check to see if the master has a mac address yet.
-		 * If not, we'll give it the mac address of our slave device.
-		 */
-		int ndx = 0;
-
-		for (ndx = 0; ndx < bond_dev->addr_len; ndx++) {
-			dprintk("Checking ndx=%d of bond_dev->dev_addr\n",
-				ndx);
-			if (bond_dev->dev_addr[ndx] != 0) {
-				dprintk("Found non-zero byte at ndx=%d\n",
-					ndx);
-				break;
-			}
-		}
-
-		if (ndx == bond_dev->addr_len) {
-			/*
-			 * We got all the way through the address and it was
-			 * all 0's.
-			 */
-			dprintk("%s doesn't have a MAC address yet.  \n",
-				bond_dev->name);
-			dprintk("Going to give assign it from %s.\n",
-				slave_dev->name);
-			bond_sethwaddr(bond_dev, slave_dev);
-		}
-	}
-
 	printk(KERN_INFO DRV_NAME
 	       ": %s: enslaving %s as a%s interface with a%s link.\n",
 	       bond_dev->name, slave_dev->name,
@@ -2227,12 +2162,10 @@ static int bond_release(struct net_devic
 	/* close slave before restoring its mac address */
 	dev_close(slave_dev);
 
-	if (app_abi_ver >= 1) {
-		/* restore original ("permanent") mac address */
-		memcpy(addr.sa_data, slave->perm_hwaddr, ETH_ALEN);
-		addr.sa_family = slave_dev->type;
-		dev_set_mac_address(slave_dev, &addr);
-	}
+	/* restore original ("permanent") mac address */
+	memcpy(addr.sa_data, slave->perm_hwaddr, ETH_ALEN);
+	addr.sa_family = slave_dev->type;
+	dev_set_mac_address(slave_dev, &addr);
 
 	/* restore the original state of the
 	 * IFF_NOARP flag that might have been
@@ -2320,12 +2253,10 @@ static int bond_release_all(struct net_d
 		/* close slave before restoring its mac address */
 		dev_close(slave_dev);
 
-		if (app_abi_ver >= 1) {
-			/* restore original ("permanent") mac address*/
-			memcpy(addr.sa_data, slave->perm_hwaddr, ETH_ALEN);
-			addr.sa_family = slave_dev->type;
-			dev_set_mac_address(slave_dev, &addr);
-		}
+		/* restore original ("permanent") mac address*/
+		memcpy(addr.sa_data, slave->perm_hwaddr, ETH_ALEN);
+		addr.sa_family = slave_dev->type;
+		dev_set_mac_address(slave_dev, &addr);
 
 		/* restore the original state of the IFF_NOARP flag that might have
 		 * been set by bond_set_slave_inactive_flags()
@@ -2423,57 +2354,6 @@ static int bond_ioctl_change_active(stru
 	return res;
 }
 
-static int bond_ethtool_ioctl(struct net_device *bond_dev, struct ifreq *ifr)
-{
-	struct ethtool_drvinfo info;
-	void __user *addr = ifr->ifr_data;
-	uint32_t cmd;
-
-	if (get_user(cmd, (uint32_t __user *)addr)) {
-		return -EFAULT;
-	}
-
-	switch (cmd) {
-	case ETHTOOL_GDRVINFO:
-		if (copy_from_user(&info, addr, sizeof(info))) {
-			return -EFAULT;
-		}
-
-		if (strcmp(info.driver, "ifenslave") == 0) {
-			int new_abi_ver;
-			char *endptr;
-
-			new_abi_ver = simple_strtoul(info.fw_version,
-						     &endptr, 0);
-			if (*endptr) {
-				printk(KERN_ERR DRV_NAME
-				       ": Error: got invalid ABI "
-				       "version from application\n");
-
-				return -EINVAL;
-			}
-
-			if (orig_app_abi_ver == -1) {
-				orig_app_abi_ver  = new_abi_ver;
-			}
-
-			app_abi_ver = new_abi_ver;
-		}
-
-		strncpy(info.driver,  DRV_NAME, 32);
-		strncpy(info.version, DRV_VERSION, 32);
-		snprintf(info.fw_version, 32, "%d", BOND_ABI_VERSION);
-
-		if (copy_to_user(addr, &info, sizeof(info))) {
-			return -EFAULT;
-		}
-
-		return 0;
-	default:
-		return -EOPNOTSUPP;
-	}
-}
-
 static int bond_info_query(struct net_device *bond_dev, struct ifbond *info)
 {
 	struct bonding *bond = bond_dev->priv;
@@ -3442,16 +3322,11 @@ static void bond_info_show_slave(struct 
 	seq_printf(seq, "Link Failure Count: %d\n",
 		   slave->link_failure_count);
 
-	if (app_abi_ver >= 1) {
-		seq_printf(seq,
-			   "Permanent HW addr: %02x:%02x:%02x:%02x:%02x:%02x\n",
-			   slave->perm_hwaddr[0],
-			   slave->perm_hwaddr[1],
-			   slave->perm_hwaddr[2],
-			   slave->perm_hwaddr[3],
-			   slave->perm_hwaddr[4],
-			   slave->perm_hwaddr[5]);
-	}
+	seq_printf(seq,
+		   "Permanent HW addr: %02x:%02x:%02x:%02x:%02x:%02x\n",
+		   slave->perm_hwaddr[0], slave->perm_hwaddr[1],
+		   slave->perm_hwaddr[2], slave->perm_hwaddr[3],
+		   slave->perm_hwaddr[4], slave->perm_hwaddr[5]);
 
 	if (bond->params.mode == BOND_MODE_8023AD) {
 		const struct aggregator *agg
@@ -4010,15 +3885,12 @@ static int bond_do_ioctl(struct net_devi
 	struct ifslave k_sinfo;
 	struct ifslave __user *u_sinfo = NULL;
 	struct mii_ioctl_data *mii = NULL;
-	int prev_abi_ver = orig_app_abi_ver;
 	int res = 0;
 
 	dprintk("bond_ioctl: master=%s, cmd=%d\n",
 		bond_dev->name, cmd);
 
 	switch (cmd) {
-	case SIOCETHTOOL:
-		return bond_ethtool_ioctl(bond_dev, ifr);
 	case SIOCGMIIPHY:
 		mii = if_mii(ifr);
 		if (!mii) {
@@ -4090,21 +3962,6 @@ static int bond_do_ioctl(struct net_devi
 		return -EPERM;
 	}
 
-	if (orig_app_abi_ver == -1) {
-		/* no orig_app_abi_ver was provided yet, so we'll use the
-		 * current one from now on, even if it's 0
-		 */
-		orig_app_abi_ver = app_abi_ver;
-
-	} else if (orig_app_abi_ver != app_abi_ver) {
-		printk(KERN_ERR DRV_NAME
-		       ": Error: already using ifenslave ABI version %d; to "
-		       "upgrade ifenslave to version %d, you must first "
-		       "reload bonding.\n",
-		       orig_app_abi_ver, app_abi_ver);
-		return -EINVAL;
-	}
-
 	slave_dev = dev_get_by_name(ifr->ifr_slave);
 
 	dprintk("slave_dev=%p: \n", slave_dev);
@@ -4137,14 +3994,6 @@ static int bond_do_ioctl(struct net_devi
 		dev_put(slave_dev);
 	}
 
-	if (res < 0) {
-		/* The ioctl failed, so there's no point in changing the
-		 * orig_app_abi_ver. We'll restore it's value just in case
-		 * we've changed it earlier in this function.
-		 */
-		orig_app_abi_ver = prev_abi_ver;
-	}
-
 	return res;
 }
 
@@ -4578,9 +4427,18 @@ static inline void bond_set_mode_ops(str
 	}
 }
 
+static void bond_ethtool_get_drvinfo(struct net_device *bond_dev,
+				    struct ethtool_drvinfo *drvinfo)
+{
+	strncpy(drvinfo->driver, DRV_NAME, 32);
+	strncpy(drvinfo->version, DRV_VERSION, 32);
+	snprintf(drvinfo->fw_version, 32, "%d", BOND_ABI_VERSION);
+}
+
 static struct ethtool_ops bond_ethtool_ops = {
 	.get_tx_csum		= ethtool_op_get_tx_csum,
 	.get_sg			= ethtool_op_get_sg,
+	.get_drvinfo		= bond_ethtool_get_drvinfo,
 };
 
 /*
diff --git a/drivers/net/bonding/bonding.h b/drivers/net/bonding/bonding.h
--- a/drivers/net/bonding/bonding.h
+++ b/drivers/net/bonding/bonding.h
@@ -40,8 +40,8 @@
 #include "bond_3ad.h"
 #include "bond_alb.h"
 
-#define DRV_VERSION	"2.6.3"
-#define DRV_RELDATE	"June 8, 2005"
+#define DRV_VERSION	"2.6.4"
+#define DRV_RELDATE	"September 26, 2005"
 #define DRV_NAME	"bonding"
 #define DRV_DESCRIPTION	"Ethernet Channel Bonding Driver"
 
diff --git a/drivers/net/ibm_emac/ibm_emac_core.c b/drivers/net/ibm_emac/ibm_emac_core.c
--- a/drivers/net/ibm_emac/ibm_emac_core.c
+++ b/drivers/net/ibm_emac/ibm_emac_core.c
@@ -1875,6 +1875,9 @@ static int emac_init_device(struct ocp_d
 		rc = -ENODEV;
 		goto bail;
 	}
+	
+	/* Disable any PHY features not supported by the platform */
+	ep->phy_mii.def->features &= ~emacdata->phy_feat_exc;
 
 	/* Setup initial PHY config & startup aneg */
 	if (ep->phy_mii.def->ops->init)
@@ -1882,6 +1885,34 @@ static int emac_init_device(struct ocp_d
 	netif_carrier_off(ndev);
 	if (ep->phy_mii.def->features & SUPPORTED_Autoneg)
 		ep->want_autoneg = 1;
+	else {
+		ep->want_autoneg = 0;
+		
+		/* Select highest supported speed/duplex */
+		if (ep->phy_mii.def->features & SUPPORTED_1000baseT_Full) {
+			ep->phy_mii.speed = SPEED_1000;
+			ep->phy_mii.duplex = DUPLEX_FULL;
+		} else if (ep->phy_mii.def->features & 
+			   SUPPORTED_1000baseT_Half) {
+			ep->phy_mii.speed = SPEED_1000;
+			ep->phy_mii.duplex = DUPLEX_HALF;
+		} else if (ep->phy_mii.def->features & 
+			   SUPPORTED_100baseT_Full) {
+			ep->phy_mii.speed = SPEED_100;
+			ep->phy_mii.duplex = DUPLEX_FULL;
+		} else if (ep->phy_mii.def->features & 
+			   SUPPORTED_100baseT_Half) {
+			ep->phy_mii.speed = SPEED_100;
+			ep->phy_mii.duplex = DUPLEX_HALF;
+		} else if (ep->phy_mii.def->features & 
+			   SUPPORTED_10baseT_Full) {
+			ep->phy_mii.speed = SPEED_10;
+			ep->phy_mii.duplex = DUPLEX_FULL;
+		} else {
+			ep->phy_mii.speed = SPEED_10;
+			ep->phy_mii.duplex = DUPLEX_HALF;
+		}
+	}
 	emac_start_link(ep, NULL);
 
 	/* read the MAC Address */
diff --git a/drivers/net/ns83820.c b/drivers/net/ns83820.c
--- a/drivers/net/ns83820.c
+++ b/drivers/net/ns83820.c
@@ -584,7 +584,7 @@ static inline int ns83820_add_rx_skb(str
 	return 0;
 }
 
-static inline int rx_refill(struct net_device *ndev, int gfp)
+static inline int rx_refill(struct net_device *ndev, unsigned int gfp)
 {
 	struct ns83820 *dev = PRIV(ndev);
 	unsigned i;
diff --git a/drivers/net/pcmcia/smc91c92_cs.c b/drivers/net/pcmcia/smc91c92_cs.c
--- a/drivers/net/pcmcia/smc91c92_cs.c
+++ b/drivers/net/pcmcia/smc91c92_cs.c
@@ -1832,7 +1832,7 @@ static void fill_multicast_tbl(int count
 {
     struct dev_mc_list	*mc_addr;
 
-    for (mc_addr = addrs;  mc_addr && --count > 0;  mc_addr = mc_addr->next) {
+    for (mc_addr = addrs;  mc_addr && count-- > 0;  mc_addr = mc_addr->next) {
 	u_int position = ether_crc(6, mc_addr->dmi_addr);
 #ifndef final_version		/* Verify multicast address. */
 	if ((mc_addr->dmi_addr[0] & 1) == 0)
diff --git a/drivers/net/skge.c b/drivers/net/skge.c
--- a/drivers/net/skge.c
+++ b/drivers/net/skge.c
@@ -2837,21 +2837,29 @@ static void skge_netpoll(struct net_devi
 static int skge_set_mac_address(struct net_device *dev, void *p)
 {
 	struct skge_port *skge = netdev_priv(dev);
-	struct sockaddr *addr = p;
-	int err = 0;
+	struct skge_hw *hw = skge->hw;
+	unsigned port = skge->port;
+	const struct sockaddr *addr = p;
 
 	if (!is_valid_ether_addr(addr->sa_data))
 		return -EADDRNOTAVAIL;
 
-	skge_down(dev);
+	spin_lock_bh(&hw->phy_lock);
 	memcpy(dev->dev_addr, addr->sa_data, ETH_ALEN);
-	memcpy_toio(skge->hw->regs + B2_MAC_1 + skge->port*8,
+	memcpy_toio(hw->regs + B2_MAC_1 + port*8,
 		    dev->dev_addr, ETH_ALEN);
-	memcpy_toio(skge->hw->regs + B2_MAC_2 + skge->port*8,
+	memcpy_toio(hw->regs + B2_MAC_2 + port*8,
 		    dev->dev_addr, ETH_ALEN);
-	if (dev->flags & IFF_UP)
-		err = skge_up(dev);
-	return err;
+
+	if (hw->chip_id == CHIP_ID_GENESIS)
+		xm_outaddr(hw, port, XM_SA, dev->dev_addr);
+	else {
+		gma_set_addr(hw, port, GM_SRC_ADDR_1L, dev->dev_addr);
+		gma_set_addr(hw, port, GM_SRC_ADDR_2L, dev->dev_addr);
+	}
+	spin_unlock_bh(&hw->phy_lock);
+
+	return 0;
 }
 
 static const struct {
diff --git a/drivers/net/starfire.c b/drivers/net/starfire.c
--- a/drivers/net/starfire.c
+++ b/drivers/net/starfire.c
@@ -133,14 +133,18 @@
 	- finally added firmware (GPL'ed by Adaptec)
 	- removed compatibility code for 2.2.x
 
+	LK1.4.2.1 (Ion Badulescu)
+	- fixed 32/64 bit issues on i386 + CONFIG_HIGHMEM
+	- added 32-bit padding to outgoing skb's, removed previous workaround
+
 TODO:	- fix forced speed/duplexing code (broken a long time ago, when
 	somebody converted the driver to use the generic MII code)
 	- fix VLAN support
 */
 
 #define DRV_NAME	"starfire"
-#define DRV_VERSION	"1.03+LK1.4.2"
-#define DRV_RELDATE	"January 19, 2005"
+#define DRV_VERSION	"1.03+LK1.4.2.1"
+#define DRV_RELDATE	"October 3, 2005"
 
 #include <linux/config.h>
 #include <linux/version.h>
@@ -165,6 +169,14 @@ TODO:	- fix forced speed/duplexing code 
  * of length 1. If and when this is fixed, the #define below can be removed.
  */
 #define HAS_BROKEN_FIRMWARE
+
+/*
+ * If using the broken firmware, data must be padded to the next 32-bit boundary.
+ */
+#ifdef HAS_BROKEN_FIRMWARE
+#define PADDING_MASK 3
+#endif
+
 /*
  * Define this if using the driver with the zero-copy patch
  */
@@ -257,9 +269,10 @@ static int full_duplex[MAX_UNITS] = {0, 
  * This SUCKS.
  * We need a much better method to determine if dma_addr_t is 64-bit.
  */
-#if (defined(__i386__) && defined(CONFIG_HIGHMEM) && (LINUX_VERSION_CODE > 0x20500 || defined(CONFIG_HIGHMEM64G))) || defined(__x86_64__) || defined (__ia64__) || defined(__mips64__) || (defined(__mips__) && defined(CONFIG_HIGHMEM) && defined(CONFIG_64BIT_PHYS_ADDR))
+#if (defined(__i386__) && defined(CONFIG_HIGHMEM64G)) || defined(__x86_64__) || defined (__ia64__) || defined(__mips64__) || (defined(__mips__) && defined(CONFIG_HIGHMEM) && defined(CONFIG_64BIT_PHYS_ADDR))
 /* 64-bit dma_addr_t */
 #define ADDR_64BITS	/* This chip uses 64 bit addresses. */
+#define netdrv_addr_t u64
 #define cpu_to_dma(x) cpu_to_le64(x)
 #define dma_to_cpu(x) le64_to_cpu(x)
 #define RX_DESC_Q_ADDR_SIZE RxDescQAddr64bit
@@ -268,6 +281,7 @@ static int full_duplex[MAX_UNITS] = {0, 
 #define TX_COMPL_Q_ADDR_SIZE TxComplQAddr64bit
 #define RX_DESC_ADDR_SIZE RxDescAddr64bit
 #else  /* 32-bit dma_addr_t */
+#define netdrv_addr_t u32
 #define cpu_to_dma(x) cpu_to_le32(x)
 #define dma_to_cpu(x) le32_to_cpu(x)
 #define RX_DESC_Q_ADDR_SIZE RxDescQAddr32bit
@@ -1333,21 +1347,10 @@ static int start_tx(struct sk_buff *skb,
 	}
 
 #if defined(ZEROCOPY) && defined(HAS_BROKEN_FIRMWARE)
-	{
-		int has_bad_length = 0;
-
-		if (skb_first_frag_len(skb) == 1)
-			has_bad_length = 1;
-		else {
-			for (i = 0; i < skb_shinfo(skb)->nr_frags; i++)
-				if (skb_shinfo(skb)->frags[i].size == 1) {
-					has_bad_length = 1;
-					break;
-				}
-		}
-
-		if (has_bad_length)
-			skb_checksum_help(skb, 0);
+	if (skb->ip_summed == CHECKSUM_HW) {
+		skb = skb_padto(skb, (skb->len + PADDING_MASK) & ~PADDING_MASK);
+		if (skb == NULL)
+			return NETDEV_TX_OK;
 	}
 #endif /* ZEROCOPY && HAS_BROKEN_FIRMWARE */
 
@@ -2127,13 +2130,12 @@ static int __init starfire_init (void)
 #endif
 #endif
 
-#ifndef ADDR_64BITS
 	/* we can do this test only at run-time... sigh */
-	if (sizeof(dma_addr_t) == sizeof(u64)) {
-		printk("This driver has not been ported to this 64-bit architecture yet\n");
+	if (sizeof(dma_addr_t) != sizeof(netdrv_addr_t)) {
+		printk("This driver has dma_addr_t issues, please send email to maintainer\n");
 		return -ENODEV;
 	}
-#endif /* not ADDR_64BITS */
+
 	return pci_module_init (&starfire_driver);
 }
 
diff --git a/drivers/net/tulip/21142.c b/drivers/net/tulip/21142.c
--- a/drivers/net/tulip/21142.c
+++ b/drivers/net/tulip/21142.c
@@ -172,7 +172,7 @@ void t21142_lnk_change(struct net_device
 			int i;
 			for (i = 0; i < tp->mtable->leafcount; i++)
 				if (tp->mtable->mleaf[i].media == dev->if_port) {
-					int startup = ! ((tp->chip_id == DC21143 && tp->revision == 65));
+					int startup = ! ((tp->chip_id == DC21143 && (tp->revision == 48 || tp->revision == 65)));
 					tp->cur_index = i;
 					tulip_select_media(dev, startup);
 					setup_done = 1;
diff --git a/drivers/s390/net/qeth.h b/drivers/s390/net/qeth.h
--- a/drivers/s390/net/qeth.h
+++ b/drivers/s390/net/qeth.h
@@ -686,6 +686,7 @@ struct qeth_seqno {
 	__u32 pdu_hdr;
 	__u32 pdu_hdr_ack;
 	__u16 ipa;
+	__u32 pkt_seqno;
 };
 
 struct qeth_reply {
@@ -848,6 +849,7 @@ qeth_realloc_headroom(struct qeth_card *
                                   "on interface %s", QETH_CARD_IFNAME(card));
                         return -ENOMEM;
                 }
+		kfree_skb(*skb);
                 *skb = new_skb;
 	}
 	return 0;
diff --git a/drivers/s390/net/qeth_main.c b/drivers/s390/net/qeth_main.c
--- a/drivers/s390/net/qeth_main.c
+++ b/drivers/s390/net/qeth_main.c
@@ -511,7 +511,7 @@ static int
 __qeth_set_offline(struct ccwgroup_device *cgdev, int recovery_mode)
 {
 	struct qeth_card *card = (struct qeth_card *) cgdev->dev.driver_data;
-	int rc = 0;
+	int rc = 0, rc2 = 0, rc3 = 0;
 	enum qeth_card_states recover_flag;
 
 	QETH_DBF_TEXT(setup, 3, "setoffl");
@@ -523,11 +523,13 @@ __qeth_set_offline(struct ccwgroup_devic
 			   CARD_BUS_ID(card));
 		return -ERESTARTSYS;
 	}
-	if ((rc = ccw_device_set_offline(CARD_DDEV(card))) ||
-	    (rc = ccw_device_set_offline(CARD_WDEV(card))) ||
-	    (rc = ccw_device_set_offline(CARD_RDEV(card)))) {
+	rc  = ccw_device_set_offline(CARD_DDEV(card));
+	rc2 = ccw_device_set_offline(CARD_WDEV(card));
+	rc3 = ccw_device_set_offline(CARD_RDEV(card));
+	if (!rc)
+		rc = (rc2) ? rc2 : rc3;
+	if (rc)
 		QETH_DBF_TEXT_(setup, 2, "1err%d", rc);
-	}
 	if (recover_flag == CARD_STATE_UP)
 		card->state = CARD_STATE_RECOVER;
 	qeth_notify_processes();
@@ -1046,6 +1048,7 @@ qeth_setup_card(struct qeth_card *card)
 	spin_lock_init(&card->vlanlock);
 	card->vlangrp = NULL;
 #endif
+	spin_lock_init(&card->lock);
 	spin_lock_init(&card->ip_lock);
 	spin_lock_init(&card->thread_mask_lock);
 	card->thread_start_mask = 0;
@@ -1626,16 +1629,6 @@ qeth_cmd_timeout(unsigned long data)
 	spin_unlock_irqrestore(&reply->card->lock, flags);
 }
 
-static void
-qeth_reset_ip_addresses(struct qeth_card *card)
-{
-	QETH_DBF_TEXT(trace, 2, "rstipadd");
-
-	qeth_clear_ip_list(card, 0, 1);
-	/* this function will also schedule the SET_IP_THREAD */
-	qeth_set_multicast_list(card->dev);
-}
-
 static struct qeth_ipa_cmd *
 qeth_check_ipa_data(struct qeth_card *card, struct qeth_cmd_buffer *iob)
 {
@@ -1664,9 +1657,8 @@ qeth_check_ipa_data(struct qeth_card *ca
 					   "IP address reset.\n",
 					   QETH_CARD_IFNAME(card),
 					   card->info.chpid);
-				card->lan_online = 1;
 				netif_carrier_on(card->dev);
-				qeth_reset_ip_addresses(card);
+				qeth_schedule_recovery(card);
 				return NULL;
 			case IPA_CMD_REGISTER_LOCAL_ADDR:
 				QETH_DBF_TEXT(trace,3, "irla");
@@ -2387,6 +2379,7 @@ qeth_layer2_rebuild_skb(struct qeth_card
 		skb_pull(skb, VLAN_HLEN);
 	}
 #endif
+	*((__u32 *)skb->cb) = ++card->seqno.pkt_seqno;
 	return vlan_id;
 }
 
@@ -3014,7 +3007,7 @@ qeth_alloc_buffer_pool(struct qeth_card 
 			return -ENOMEM;
 		}
 		for(j = 0; j < QETH_MAX_BUFFER_ELEMENTS(card); ++j){
-			ptr = (void *) __get_free_page(GFP_KERNEL);
+			ptr = (void *) __get_free_page(GFP_KERNEL|GFP_DMA);
 			if (!ptr) {
 				while (j > 0)
 					free_page((unsigned long)
@@ -3058,7 +3051,8 @@ qeth_alloc_qdio_buffers(struct qeth_card
 	if (card->qdio.state == QETH_QDIO_ALLOCATED)
 		return 0;
 
-	card->qdio.in_q = kmalloc(sizeof(struct qeth_qdio_q), GFP_KERNEL);
+	card->qdio.in_q = kmalloc(sizeof(struct qeth_qdio_q), 
+				  GFP_KERNEL|GFP_DMA);
 	if (!card->qdio.in_q)
 		return - ENOMEM;
 	QETH_DBF_TEXT(setup, 2, "inq");
@@ -3083,7 +3077,7 @@ qeth_alloc_qdio_buffers(struct qeth_card
 	}
 	for (i = 0; i < card->qdio.no_out_queues; ++i){
 		card->qdio.out_qs[i] = kmalloc(sizeof(struct qeth_qdio_out_q),
-					       GFP_KERNEL);
+					       GFP_KERNEL|GFP_DMA);
 		if (!card->qdio.out_qs[i]){
 			while (i > 0)
 				kfree(card->qdio.out_qs[--i]);
@@ -6470,6 +6464,9 @@ qeth_query_ipassists_cb(struct qeth_card
 	if (cmd->hdr.prot_version == QETH_PROT_IPV4) {
 		card->options.ipa4.supported_funcs = cmd->hdr.ipa_supported;
 		card->options.ipa4.enabled_funcs = cmd->hdr.ipa_enabled;
+		/* Disable IPV6 support hard coded for Hipersockets */
+		if(card->info.type == QETH_CARD_TYPE_IQD)
+			card->options.ipa4.supported_funcs &= ~IPA_IPV6;
 	} else {
 #ifdef CONFIG_QETH_IPV6
 		card->options.ipa6.supported_funcs = cmd->hdr.ipa_supported;
diff --git a/net/ieee80211/ieee80211_tx.c b/net/ieee80211/ieee80211_tx.c
--- a/net/ieee80211/ieee80211_tx.c
+++ b/net/ieee80211/ieee80211_tx.c
@@ -207,7 +207,7 @@ void ieee80211_txb_free(struct ieee80211
 }
 
 static struct ieee80211_txb *ieee80211_alloc_txb(int nr_frags, int txb_size,
-						 int gfp_mask)
+						 unsigned int gfp_mask)
 {
 	struct ieee80211_txb *txb;
 	int i;
