Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263139AbVCDW1C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263139AbVCDW1C (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 17:27:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263144AbVCDWYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 17:24:11 -0500
Received: from mail.kroah.org ([69.55.234.183]:23976 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263168AbVCDVHf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 16:07:35 -0500
Date: Fri, 4 Mar 2005 13:07:14 -0800
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       davej@redhat.com
Subject: Re: [PATCH] convert pci_dev->slot_name usage to pci_name()
Message-ID: <20050304210714.GA426@kroah.com>
References: <11099696352086@kroah.com> <4228CC6D.8040606@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4228CC6D.8040606@pobox.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 04:00:29PM -0500, Jeff Garzik wrote:
> Greg KH wrote:
> >ChangeSet 1.1998.11.6, 2005/02/07 14:36:14-08:00, davej@redhat.com
> >
> >[PATCH] convert pci_dev->slot_name usage to pci_name()
> >
> >Prepare for removal of pci_dev->slot_name
> 
> Can you split this up and send me the drivers/net/* portion?

Here ya go.

thanks,

greg k-h

-----

[PATCH] convert pci_dev->slot_name usage to pci_name()

Prepare for removal of pci_dev->slot_name

Signed-off-by: Dave Jones <davej@redhat.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>

diff -Nru a/drivers/net/defxx.c b/drivers/net/defxx.c
--- a/drivers/net/defxx.c	2005-03-04 12:43:34 -08:00
+++ b/drivers/net/defxx.c	2005-03-04 12:43:34 -08:00
@@ -420,7 +420,7 @@
 	}
 
 	if (pdev != NULL)
-		print_name = pdev->slot_name;
+		print_name = pci_name(pdev);
 
 	dev = alloc_fddidev(sizeof(*bp));
 	if (!dev) {
diff -Nru a/drivers/net/r8169.c b/drivers/net/r8169.c
--- a/drivers/net/r8169.c	2005-03-04 12:43:34 -08:00
+++ b/drivers/net/r8169.c	2005-03-04 12:43:34 -08:00
@@ -1146,7 +1146,7 @@
 	// enable device (incl. PCI PM wakeup and hotplug setup)
 	rc = pci_enable_device(pdev);
 	if (rc) {
-		printk(KERN_ERR PFX "%s: enable failure\n", pdev->slot_name);
+		printk(KERN_ERR PFX "%s: enable failure\n", pci_name(pdev));
 		goto err_out_free_dev;
 	}
 
@@ -1184,7 +1184,7 @@
 	rc = pci_request_regions(pdev, MODULENAME);
 	if (rc) {
 		printk(KERN_ERR PFX "%s: could not request regions.\n",
-		       pdev->slot_name);
+		       pci_name(pdev));
 		goto err_out_mwi;
 	}
 
diff -Nru a/drivers/net/s2io.c b/drivers/net/s2io.c
--- a/drivers/net/s2io.c	2005-03-04 12:43:34 -08:00
+++ b/drivers/net/s2io.c	2005-03-04 12:43:34 -08:00
@@ -3192,7 +3192,7 @@
 	strncpy(info->version, s2io_driver_version,
 		sizeof(s2io_driver_version));
 	strncpy(info->fw_version, "", 32);
-	strncpy(info->bus_info, sp->pdev->slot_name, 32);
+	strncpy(info->bus_info, pci_name(sp->pdev), 32);
 	info->regdump_len = XENA_REG_SPACE;
 	info->eedump_len = XENA_EEPROM_SPACE;
 	info->testinfo_len = S2IO_TEST_LEN;
diff -Nru a/drivers/net/sk98lin/skethtool.c b/drivers/net/sk98lin/skethtool.c
--- a/drivers/net/sk98lin/skethtool.c	2005-03-04 12:43:34 -08:00
+++ b/drivers/net/sk98lin/skethtool.c	2005-03-04 12:43:34 -08:00
@@ -257,7 +257,7 @@
 	strlcpy(info->driver, DRIVER_FILE_NAME, sizeof(info->driver));
 	strcpy(info->version, vers);
 	strcpy(info->fw_version, "N/A");
-	strlcpy(info->bus_info, pAC->PciDev->slot_name, ETHTOOL_BUSINFO_LEN);
+	strlcpy(info->bus_info, pci_name(pAC->PciDev), ETHTOOL_BUSINFO_LEN);
 }
 
 /*
diff -Nru a/drivers/net/sk98lin/skge.c b/drivers/net/sk98lin/skge.c
--- a/drivers/net/sk98lin/skge.c	2005-03-04 12:43:34 -08:00
+++ b/drivers/net/sk98lin/skge.c	2005-03-04 12:43:34 -08:00
@@ -3058,7 +3058,7 @@
 		*/
 		* ((SK_U32 *)pMemBuf) = 0;
 		* ((SK_U32 *)pMemBuf + 1) = pdev->bus->number;
-		* ((SK_U32 *)pMemBuf + 2) = ParseDeviceNbrFromSlotName(pdev->slot_name);
+		* ((SK_U32 *)pMemBuf + 2) = ParseDeviceNbrFromSlotName(pci_name(pdev));
 		if(copy_to_user(Ioctl.pData, pMemBuf, Length) ) {
 			Err = -EFAULT;
 			goto fault_diag;
diff -Nru a/drivers/net/tulip/tulip.h b/drivers/net/tulip/tulip.h
--- a/drivers/net/tulip/tulip.h	2005-03-04 12:43:34 -08:00
+++ b/drivers/net/tulip/tulip.h	2005-03-04 12:43:34 -08:00
@@ -476,7 +476,7 @@
 
 		if (!i)
 			printk(KERN_DEBUG "%s: tulip_stop_rxtx() failed\n",
-					tp->pdev->slot_name);
+					pci_name(tp->pdev));
 	}
 }
 
diff -Nru a/drivers/net/typhoon.c b/drivers/net/typhoon.c
--- a/drivers/net/typhoon.c	2005-03-04 12:43:34 -08:00
+++ b/drivers/net/typhoon.c	2005-03-04 12:43:34 -08:00
@@ -2438,7 +2438,7 @@
 	INIT_COMMAND_WITH_RESPONSE(&xp_cmd, TYPHOON_CMD_READ_VERSIONS);
 	if(typhoon_issue_command(tp, 1, &xp_cmd, 3, xp_resp) < 0) {
 		printk(ERR_PFX "%s: Could not get Sleep Image version\n",
-			pdev->slot_name);
+			pci_name(pdev));
 		goto error_out_reset;
 	}
 
diff -Nru a/drivers/net/via-velocity.c b/drivers/net/via-velocity.c
--- a/drivers/net/via-velocity.c	2005-03-04 12:43:34 -08:00
+++ b/drivers/net/via-velocity.c	2005-03-04 12:43:34 -08:00
@@ -2898,7 +2898,7 @@
 	struct velocity_info *vptr = dev->priv;
 	strcpy(info->driver, VELOCITY_NAME);
 	strcpy(info->version, VELOCITY_VERSION);
-	strcpy(info->bus_info, vptr->pdev->slot_name);
+	strcpy(info->bus_info, pci_name(vptr->pdev));
 }
 
 static void velocity_ethtool_get_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
diff -Nru a/drivers/net/wan/wanxl.c b/drivers/net/wan/wanxl.c
--- a/drivers/net/wan/wanxl.c	2005-03-04 12:43:34 -08:00
+++ b/drivers/net/wan/wanxl.c	2005-03-04 12:43:34 -08:00
@@ -72,7 +72,7 @@
 	u8 irq;
 
 	u8 __iomem *plx;	/* PLX PCI9060 virtual base address */
-	struct pci_dev *pdev;	/* for pdev->slot_name */
+	struct pci_dev *pdev;	/* for pci_name(pdev) */
 	int rx_in;
 	struct sk_buff *rx_skbs[RX_QUEUE_LENGTH];
 	card_status_t *status;	/* shared between host and card */
@@ -88,12 +88,6 @@
 }
 
 
-static inline const char* card_name(struct pci_dev *pdev)
-{
-	return pdev->slot_name;
-}
-
-
 static inline port_status_t* get_status(port_t *port)
 {
 	return &port->card->status->port_status[port->node];
@@ -107,7 +101,7 @@
 	dma_addr_t addr = pci_map_single(pdev, ptr, size, direction);
 	if (addr + size > 0x100000000LL)
 		printk(KERN_CRIT "wanXL %s: pci_map_single() returned memory"
-		       " at 0x%LX!\n", card_name(pdev),
+		       " at 0x%LX!\n", pci_name(pdev),
 		       (unsigned long long)addr);
 	return addr;
 }
@@ -201,7 +195,7 @@
 	       desc->stat != PACKET_EMPTY) {
 		if ((desc->stat & PACKET_PORT_MASK) > card->n_ports)
 			printk(KERN_CRIT "wanXL %s: received packet for"
-			       " nonexistent port\n", card_name(card->pdev));
+			       " nonexistent port\n", pci_name(card->pdev));
 		else {
 			struct sk_buff *skb = card->rx_skbs[card->rx_in];
 			port_t *port = &card->ports[desc->stat &
@@ -604,7 +598,7 @@
 	card = kmalloc(alloc_size, GFP_KERNEL);
 	if (card == NULL) {
 		printk(KERN_ERR "wanXL %s: unable to allocate memory\n",
-		       card_name(pdev));
+		       pci_name(pdev));
 		pci_release_regions(pdev);
 		pci_disable_device(pdev);
 		return -ENOBUFS;
@@ -623,7 +617,7 @@
 
 #ifdef DEBUG_PCI
 	printk(KERN_DEBUG "wanXL %s: pci_alloc_consistent() returned memory"
-	       " at 0x%LX\n", card_name(pdev),
+	       " at 0x%LX\n", pci_name(pdev),
 	       (unsigned long long)card->status_address);
 #endif
 
@@ -649,7 +643,7 @@
 	while ((stat = readl(card->plx + PLX_MAILBOX_0)) != 0) {
 		if (time_before(timeout, jiffies)) {
 			printk(KERN_WARNING "wanXL %s: timeout waiting for"
-			       " PUTS to complete\n", card_name(pdev));
+			       " PUTS to complete\n", pci_name(pdev));
 			wanxl_pci_remove_one(pdev);
 			return -ENODEV;
 		}
@@ -661,7 +655,7 @@
 
 		default:
 			printk(KERN_WARNING "wanXL %s: PUTS test 0x%X"
-			       " failed\n", card_name(pdev), stat & 0x30);
+			       " failed\n", pci_name(pdev), stat & 0x30);
 			wanxl_pci_remove_one(pdev);
 			return -ENODEV;
 		}
@@ -681,7 +675,7 @@
 	    (TX_BUFFERS + RX_BUFFERS) * BUFFER_LENGTH * ports) {
 		printk(KERN_WARNING "wanXL %s: no enough on-board RAM"
 		       " (%u bytes detected, %u bytes required)\n",
-		       card_name(pdev), ramsize, BUFFERS_ADDR +
+		       pci_name(pdev), ramsize, BUFFERS_ADDR +
 		       (TX_BUFFERS + RX_BUFFERS) * BUFFER_LENGTH * ports);
 		wanxl_pci_remove_one(pdev);
 		return -ENODEV;
@@ -689,7 +683,7 @@
 
 	if (wanxl_puts_command(card, MBX1_CMD_BSWAP)) {
 		printk(KERN_WARNING "wanXL %s: unable to Set Byte Swap"
-		       " Mode\n", card_name(pdev));
+		       " Mode\n", pci_name(pdev));
 		wanxl_pci_remove_one(pdev);
 		return -ENODEV;
 	}
@@ -720,7 +714,7 @@
 
 	if (wanxl_puts_command(card, MBX1_CMD_ABORTJ)) {
 		printk(KERN_WARNING "wanXL %s: unable to Abort and Jump\n",
-		       card_name(pdev));
+		       pci_name(pdev));
 		wanxl_pci_remove_one(pdev);
 		return -ENODEV;
 	}
@@ -735,7 +729,7 @@
 
 	if (!stat) {
 		printk(KERN_WARNING "wanXL %s: timeout while initializing card"
-		       "firmware\n", card_name(pdev));
+		       "firmware\n", pci_name(pdev));
 		wanxl_pci_remove_one(pdev);
 		return -ENODEV;
 	}
@@ -745,12 +739,12 @@
 #endif
 
 	printk(KERN_INFO "wanXL %s: at 0x%X, %u KB of RAM at 0x%X, irq %u\n",
-	       card_name(pdev), plx_phy, ramsize / 1024, mem_phy, pdev->irq);
+	       pci_name(pdev), plx_phy, ramsize / 1024, mem_phy, pdev->irq);
 
 	/* Allocate IRQ */
 	if (request_irq(pdev->irq, wanxl_intr, SA_SHIRQ, "wanXL", card)) {
 		printk(KERN_WARNING "wanXL %s: could not allocate IRQ%i.\n",
-		       card_name(pdev), pdev->irq);
+		       pci_name(pdev), pdev->irq);
 		wanxl_pci_remove_one(pdev);
 		return -EBUSY;
 	}
@@ -762,7 +756,7 @@
 		struct net_device *dev = alloc_hdlcdev(port);
 		if (!dev) {
 			printk(KERN_ERR "wanXL %s: unable to allocate"
-			       " memory\n", card_name(pdev));
+			       " memory\n", pci_name(pdev));
 			wanxl_pci_remove_one(pdev);
 			return -ENOMEM;
 		}
@@ -783,7 +777,7 @@
 		get_status(port)->clocking = CLOCK_EXT;
 		if (register_hdlc_device(dev)) {
 			printk(KERN_ERR "wanXL %s: unable to register hdlc"
-			       " device\n", card_name(pdev));
+			       " device\n", pci_name(pdev));
 			free_netdev(dev);
 			wanxl_pci_remove_one(pdev);
 			return -ENOBUFS;
@@ -791,7 +785,7 @@
 		card->n_ports++;
 	}
 
-	printk(KERN_INFO "wanXL %s: port", card_name(pdev));
+	printk(KERN_INFO "wanXL %s: port", pci_name(pdev));
 	for (i = 0; i < ports; i++)
 		printk("%s #%i: %s", i ? "," : "", i,
 		       card->ports[i].dev->name);
