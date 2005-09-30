Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932205AbVI3CVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbVI3CVu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 22:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbVI3CVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 22:21:50 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:12220 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932205AbVI3CVt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 22:21:49 -0400
Date: Fri, 30 Sep 2005 03:21:45 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] cassini annotations and fixes
Message-ID: <20050930022145.GZ7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	- __user annotations
	- NULL noise removal
	- C99 initializers
	- s/u32/pm_message_t/ in ->suspend()
	- removal of bogus casts in iounmap() arguments
	- if_mii() instead of open-coded variant
Remains to be done: ethtool conversion.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC14-rc2-git6-base/drivers/net/cassini.c current/drivers/net/cassini.c
--- RC14-rc2-git6-base/drivers/net/cassini.c	2005-09-29 18:48:38.000000000 -0400
+++ current/drivers/net/cassini.c	2005-09-29 18:56:57.000000000 -0400
@@ -3244,7 +3244,7 @@
 		goto use_random_mac_addr;
 
 	/* search for beginning of vpd */
-	base = 0;
+	base = NULL;
 	for (i = 2; i < EXPANSION_ROM_SIZE; i++) {
 		/* check for PCIR */
 		if ((readb(p + i + 0) == 0x50) &&
@@ -4564,7 +4564,7 @@
 /* Eventually add support for changing the advertisement
  * on autoneg.
  */
-static int cas_ethtool_ioctl(struct net_device *dev, void *ep_user)
+static int cas_ethtool_ioctl(struct net_device *dev, void __user *ep_user)
 {
 	struct cas *cp = netdev_priv(dev);
 	u16 bmcr;
@@ -4578,7 +4578,7 @@
 		
 	switch(ecmd.cmd) {
         case ETHTOOL_GDRVINFO: {
-		struct ethtool_drvinfo info = { cmd: ETHTOOL_GDRVINFO };
+		struct ethtool_drvinfo info = { .cmd = ETHTOOL_GDRVINFO };
 
 		strncpy(info.driver, DRV_MODULE_NAME,
 			ETHTOOL_BUSINFO_LEN);
@@ -4738,7 +4738,7 @@
 
 	/* get link status */
 	case ETHTOOL_GLINK: {
-		struct ethtool_value edata = { cmd: ETHTOOL_GLINK };
+		struct ethtool_value edata = { .cmd = ETHTOOL_GLINK };
 
 		edata.data = (cp->lstate == link_up);
 		if (copy_to_user(ep_user, &edata, sizeof(edata)))
@@ -4748,7 +4748,7 @@
 
 	/* get message-level */
 	case ETHTOOL_GMSGLVL: {
-		struct ethtool_value edata = { cmd: ETHTOOL_GMSGLVL };
+		struct ethtool_value edata = { .cmd = ETHTOOL_GMSGLVL };
 
 		edata.data = cp->msg_enable;
 		if (copy_to_user(ep_user, &edata, sizeof(edata)))
@@ -4874,7 +4874,7 @@
 static int cas_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 {
 	struct cas *cp = netdev_priv(dev);
-	struct mii_ioctl_data *data = (struct mii_ioctl_data *)&ifr->ifr_data;
+	struct mii_ioctl_data *data = if_mii(ifr);
 	unsigned long flags;
 	int rc = -EOPNOTSUPP;
 	
@@ -5168,7 +5168,7 @@
 		cas_shutdown(cp);
 	up(&cp->pm_sem);
 
-	iounmap((void *) cp->regs);
+	iounmap(cp->regs);
 
 
 err_out_free_res:
@@ -5216,7 +5216,7 @@
 #endif
 	pci_free_consistent(pdev, sizeof(struct cas_init_block),
 			    cp->init_block, cp->block_dvma);
-	iounmap((void *) cp->regs);
+	iounmap(cp->regs);
 	free_netdev(dev);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
@@ -5224,7 +5224,7 @@
 }
 
 #ifdef CONFIG_PM
-static int cas_suspend(struct pci_dev *pdev, u32 state)
+static int cas_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 	struct cas *cp = netdev_priv(dev);
