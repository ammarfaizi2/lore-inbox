Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264282AbTLESa5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 13:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264271AbTLESa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 13:30:57 -0500
Received: from havoc.gtf.org ([63.247.75.124]:5086 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S264289AbTLESai (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 13:30:38 -0500
Date: Fri, 5 Dec 2003 13:30:37 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: torvalds@osdl.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [BK PATCHES] net driver fixes
Message-ID: <20031205183037.GA8536@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please do a

	bk pull bk://gkernel.bkbits.net/net-drivers-2.5

This will update the following files:

 drivers/net/pci-skeleton.c |    7 ---
 drivers/net/pcnet32.c      |    2 
 drivers/net/r8169.c        |    4 -
 drivers/net/sis190.c       |    4 -
 drivers/net/typhoon.c      |   97 ++++++++++++++++++++++++++++++++++++---------
 5 files changed, 78 insertions(+), 36 deletions(-)

through these ChangeSets:

<jgarzik@redhat.com> (03/12/05 1.1499)
   [netdrvr pcnet32] fix oops on unload
   
   Driver was calling pci_unregister_driver for each _device_, and then
   again at the end of the module unload routine.  Remove the call that's
   inside the loop, pci_unregister_driver should only be called once.
   
   Caught by Don Fry (and many others)

<viro@parcelfarce.linux.theplanet.co.uk> (03/12/03 1.1496.1.9)
   [netdrvr] remove manual driver poisoning of net_device
   
   Such poisoning can cause oopses either because the refcount is not
   zero when the poisoning occurs, or due to kernel debugging options
   being enabled.

<dave@thedillows.org> (03/11/26 1.1486.1.1)
   Bug fixes:
   * Avoid short timeouts when waiting for a reset
   * Fix issue with loading runtime image on newer versions of the sleep image
   * Fix link status reporting

diff -Nru a/drivers/net/pci-skeleton.c b/drivers/net/pci-skeleton.c
--- a/drivers/net/pci-skeleton.c	Fri Dec  5 13:22:32 2003
+++ b/drivers/net/pci-skeleton.c	Fri Dec  5 13:22:32 2003
@@ -864,13 +864,6 @@
 
 	pci_release_regions (pdev);
 
-#ifndef NETDRV_NDEBUG
-	/* poison memory before freeing */
-	memset (dev, 0xBC,
-		sizeof (struct net_device) +
-		sizeof (struct netdrv_private));
-#endif /* NETDRV_NDEBUG */
-
 	free_netdev (dev);
 
 	pci_set_drvdata (pdev, NULL);
diff -Nru a/drivers/net/pcnet32.c b/drivers/net/pcnet32.c
--- a/drivers/net/pcnet32.c	Fri Dec  5 13:22:32 2003
+++ b/drivers/net/pcnet32.c	Fri Dec  5 13:22:32 2003
@@ -1766,8 +1766,6 @@
 	next_dev = lp->next;
 	unregister_netdev(pcnet32_dev);
 	release_region(pcnet32_dev->base_addr, PCNET32_TOTAL_SIZE);
-	if (lp->pci_dev)
-	    pci_unregister_driver(&pcnet32_driver);
 	pci_free_consistent(lp->pci_dev, sizeof(*lp), lp, lp->dma_addr);
 	free_netdev(pcnet32_dev);
 	pcnet32_dev = next_dev;
diff -Nru a/drivers/net/r8169.c b/drivers/net/r8169.c
--- a/drivers/net/r8169.c	Fri Dec  5 13:22:32 2003
+++ b/drivers/net/r8169.c	Fri Dec  5 13:22:32 2003
@@ -642,10 +642,6 @@
 	iounmap(tp->mmio_addr);
 	pci_release_regions(pdev);
 
-	// poison memory before freeing 
-	memset(dev, 0xBC,
-	       sizeof (struct net_device) + sizeof (struct rtl8169_private));
-
 	pci_disable_device(pdev);
 	free_netdev(dev);
 	pci_set_drvdata(pdev, NULL);
diff -Nru a/drivers/net/sis190.c b/drivers/net/sis190.c
--- a/drivers/net/sis190.c	Fri Dec  5 13:22:32 2003
+++ b/drivers/net/sis190.c	Fri Dec  5 13:22:32 2003
@@ -703,10 +703,6 @@
 	iounmap(tp->mmio_addr);
 	pci_release_regions(pdev);
 
-	// poison memory before freeing 
-	memset(dev, 0xBC,
-	       sizeof (struct net_device) + sizeof (struct sis190_private));
-
 	free_netdev(dev);
 	pci_set_drvdata(pdev, NULL);
 }
diff -Nru a/drivers/net/typhoon.c b/drivers/net/typhoon.c
--- a/drivers/net/typhoon.c	Fri Dec  5 13:22:32 2003
+++ b/drivers/net/typhoon.c	Fri Dec  5 13:22:32 2003
@@ -85,8 +85,8 @@
 #define PKT_BUF_SZ		1536
 
 #define DRV_MODULE_NAME		"typhoon"
-#define DRV_MODULE_VERSION 	"1.5.1"
-#define DRV_MODULE_RELDATE	"03/06/26"
+#define DRV_MODULE_VERSION 	"1.5.2"
+#define DRV_MODULE_RELDATE	"03/11/25"
 #define PFX			DRV_MODULE_NAME ": "
 #define ERR_PFX			KERN_ERR PFX
 
@@ -127,7 +127,7 @@
 static char version[] __devinitdata =
     "typhoon.c: version " DRV_MODULE_VERSION " (" DRV_MODULE_RELDATE ")\n";
 
-MODULE_AUTHOR("David Dillow <dillowd@y12.doe.gov>");
+MODULE_AUTHOR("David Dillow <dave@thedillows.org>");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("3Com Typhoon Family (3C990, 3CR990, and variants)");
 MODULE_PARM(rx_copybreak, "i");
@@ -146,11 +146,12 @@
 	int capabilities;
 };
 
-#define TYPHOON_CRYPTO_NONE		0
-#define TYPHOON_CRYPTO_DES		1
-#define TYPHOON_CRYPTO_3DES		2
-#define	TYPHOON_CRYPTO_VARIABLE		4
-#define TYPHOON_FIBER			8
+#define TYPHOON_CRYPTO_NONE		0x00
+#define TYPHOON_CRYPTO_DES		0x01
+#define TYPHOON_CRYPTO_3DES		0x02
+#define	TYPHOON_CRYPTO_VARIABLE		0x04
+#define TYPHOON_FIBER			0x08
+#define TYPHOON_WAKEUP_NEEDS_RESET	0x10
 
 enum typhoon_cards {
 	TYPHOON_TX = 0, TYPHOON_TX95, TYPHOON_TX97, TYPHOON_SVR,
@@ -307,7 +308,8 @@
 /* We'll wait up to six seconds for a reset, and half a second normally.
  */
 #define TYPHOON_UDELAY			50
-#define TYPHOON_RESET_TIMEOUT		(6 * HZ)
+#define TYPHOON_RESET_TIMEOUT_SLEEP	(6 * HZ)
+#define TYPHOON_RESET_TIMEOUT_NOSLEEP	((6 * 1000000) / TYPHOON_UDELAY)
 #define TYPHOON_WAIT_TIMEOUT		((1000000 / 2) / TYPHOON_UDELAY)
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 28)
@@ -375,10 +377,12 @@
 typhoon_reset(unsigned long ioaddr, int wait_type)
 {
 	int i, err = 0;
-	int timeout = TYPHOON_RESET_TIMEOUT;
+	int timeout;
 
 	if(wait_type == WaitNoSleep)
-		timeout = (timeout * 1000000) / (HZ * TYPHOON_UDELAY);
+		timeout = TYPHOON_RESET_TIMEOUT_NOSLEEP;
+	else
+		timeout = TYPHOON_RESET_TIMEOUT_SLEEP;
 
 	writel(TYPHOON_INTR_ALL, ioaddr + TYPHOON_REG_INTR_MASK);
 	writel(TYPHOON_INTR_ALL, ioaddr + TYPHOON_REG_INTR_STATUS);
@@ -1858,6 +1862,11 @@
 	if(typhoon_wait_status(ioaddr, TYPHOON_STATUS_SLEEPING) < 0)
 		return -ETIMEDOUT;
 
+	/* Since we cannot monitor the status of the link while sleeping,
+	 * tell the world it went away.
+	 */
+	netif_carrier_off(tp->dev);
+
 	pci_enable_wake(tp->pdev, state, 1);
 	pci_disable_device(pdev);
 	return pci_set_power_state(pdev, state);
@@ -1872,8 +1881,13 @@
 	pci_set_power_state(pdev, 0);
 	pci_restore_state(pdev, tp->pci_state);
 
+	/* Post 2.x.x versions of the Sleep Image require a reset before
+	 * we can download the Runtime Image. But let's not make users of
+	 * the old firmware pay for the reset.
+	 */
 	writel(TYPHOON_BOOTCMD_WAKEUP, ioaddr + TYPHOON_REG_COMMAND);
-	if(typhoon_wait_status(ioaddr, TYPHOON_STATUS_WAITING_FOR_HOST) < 0)
+	if(typhoon_wait_status(ioaddr, TYPHOON_STATUS_WAITING_FOR_HOST) < 0 ||
+			(tp->capabilities & TYPHOON_WAKEUP_NEEDS_RESET))
 		return typhoon_reset(ioaddr, wait_type);
 
 	return 0;
@@ -2251,7 +2265,7 @@
 	void *shared;
 	dma_addr_t shared_dma;
 	struct cmd_desc xp_cmd;
-	struct resp_desc xp_resp;
+	struct resp_desc xp_resp[3];
 	int i;
 	int err = 0;
 
@@ -2380,15 +2394,15 @@
 	}
 
 	INIT_COMMAND_WITH_RESPONSE(&xp_cmd, TYPHOON_CMD_READ_MAC_ADDRESS);
-	if(typhoon_issue_command(tp, 1, &xp_cmd, 1, &xp_resp) < 0) {
+	if(typhoon_issue_command(tp, 1, &xp_cmd, 1, xp_resp) < 0) {
 		printk(ERR_PFX "%s: cannot read MAC address\n",
 		       pci_name(pdev));
 		err = -EIO;
 		goto error_out_reset;
 	}
 
-	*(u16 *)&dev->dev_addr[0] = htons(le16_to_cpu(xp_resp.parm1));
-	*(u32 *)&dev->dev_addr[2] = htonl(le32_to_cpu(xp_resp.parm2));
+	*(u16 *)&dev->dev_addr[0] = htons(le16_to_cpu(xp_resp[0].parm1));
+	*(u32 *)&dev->dev_addr[2] = htonl(le32_to_cpu(xp_resp[0].parm2));
 
 	if(!is_valid_ether_addr(dev->dev_addr)) {
 		printk(ERR_PFX "%s: Could not obtain valid ethernet address, "
@@ -2396,6 +2410,28 @@
 		goto error_out_reset;
 	}
 
+	/* Read the Sleep Image version last, so the response is valid
+	 * later when we print out the version reported.
+	 */
+	INIT_COMMAND_WITH_RESPONSE(&xp_cmd, TYPHOON_CMD_READ_VERSIONS);
+	if(typhoon_issue_command(tp, 1, &xp_cmd, 3, xp_resp) < 0) {
+		printk(ERR_PFX "%s: Could not get Sleep Image version\n",
+			pdev->slot_name);
+		goto error_out_reset;
+	}
+
+	tp->capabilities = typhoon_card_info[card_id].capabilities;
+	tp->xcvr_select = TYPHOON_XCVR_AUTONEG;
+
+	/* Typhoon 1.0 Sleep Images return one response descriptor to the
+	 * READ_VERSIONS command. Those versions are OK after waking up
+	 * from sleep without needing a reset. Typhoon 1.1+ Sleep Images
+	 * seem to need a little extra help to get started. Since we don't
+	 * know how to nudge it along, just kick it.
+	 */
+	if(xp_resp[0].numDesc != 0)
+		tp->capabilities |= TYPHOON_WAKEUP_NEEDS_RESET;
+
 	if(typhoon_sleep(tp, 3, 0) < 0) {
 		printk(ERR_PFX "%s: cannot put adapter to sleep\n",
 		       pci_name(pdev));
@@ -2403,9 +2439,6 @@
 		goto error_out_reset;
 	}
 
-	tp->capabilities = typhoon_card_info[card_id].capabilities;
-	tp->xcvr_select = TYPHOON_XCVR_AUTONEG;
-
 	/* The chip-specific entries in the device structure. */
 	dev->open		= typhoon_open;
 	dev->hard_start_xmit	= typhoon_start_tx;
@@ -2442,6 +2475,32 @@
 		printk("%2.2x:", dev->dev_addr[i]);
 	printk("%2.2x\n", dev->dev_addr[i]);
 
+	/* xp_resp still contains the response to the READ_VERSIONS command.
+	 * For debugging, let the user know what version he has.
+	 */
+	if(xp_resp[0].numDesc == 0) {
+		/* This is the Typhoon 1.0 type Sleep Image, last 16 bits
+		 * of version is Month/Day of build.
+		 */
+		u16 monthday = le32_to_cpu(xp_resp[0].parm2) & 0xffff;
+		printk(KERN_INFO "%s: Typhoon 1.0 Sleep Image built "
+			"%02u/%02u/2000\n", dev->name, monthday >> 8,
+			monthday & 0xff);
+	} else if(xp_resp[0].numDesc == 2) {
+		/* This is the Typhoon 1.1+ type Sleep Image
+		 */
+		u32 sleep_ver = le32_to_cpu(xp_resp[0].parm2);
+		u8 *ver_string = (u8 *) &xp_resp[1];
+		ver_string[25] = 0;
+		printk(KERN_INFO "%s: Typhoon 1.1+ Sleep Image version "
+			"%u.%u.%u.%u %s\n", dev->name, HIPQUAD(sleep_ver),
+			ver_string);
+	} else {
+		printk(KERN_WARNING "%s: Unknown Sleep Image version "
+			"(%u:%04x)\n", dev->name, xp_resp[0].numDesc,
+			le32_to_cpu(xp_resp[0].parm2));
+	}
+		
 	return 0;
 
 error_out_reset:
