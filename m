Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751237AbWD3XkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbWD3XkZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 19:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbWD3XkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 19:40:25 -0400
Received: from pythagoras.zen.co.uk ([212.23.3.140]:58024 "EHLO
	pythagoras.zen.co.uk") by vger.kernel.org with ESMTP
	id S1750788AbWD3XkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 19:40:24 -0400
Message-ID: <44554ADE.8030200@cantab.net>
Date: Mon, 01 May 2006 00:40:14 +0100
From: David Vrabel <dvrabel@cantab.net>
User-Agent: Mail/News 1.5 (X11/20060228)
MIME-Version: 1.0
To: Pekka Enberg <penberg@cs.helsinki.fi>
CC: romieu@fr.zoreil.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       david@pleyades.net
Subject: Re: IP1000 gigabit nic driver
References: <20060427142939.GA31473@fargo>	 <20060427185627.GA30871@electric-eye.fr.zoreil.com>	 <445144FF.4070703@cantab.net> <20060428075725.GA18957@fargo>	 <84144f020604280358ie9990c7h399f4a5588e575f8@mail.gmail.com>	 <20060428113755.GA7419@fargo>	 <Pine.LNX.4.58.0604281458110.19801@sbz-30.cs.Helsinki.FI>	 <1146306567.1642.3.camel@localhost>  <20060429122119.GA22160@fargo>	 <1146342905.11271.3.camel@localhost> <1146389171.11524.1.camel@localhost>
In-Reply-To: <1146389171.11524.1.camel@localhost>
Content-Type: multipart/mixed;
 boundary="------------050209020606060604060506"
X-Originating-Pythagoras-IP: [82.70.146.41]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050209020606060604060506
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit

Pekka Enberg wrote:
> On Sat, 2006-04-29 at 14:21 +0200, David Gómez wrote:
>>> I already had it modified, just needed to create the patch... Anyway,
>>> have you submitted it to netdev?
> 
> On Sat, 2006-04-29 at 23:35 +0300, Pekka Enberg wrote:
>> No, I haven't. I don't have the hardware, so I can't test the driver.
>> Furthermore, there's plenty of stuff to fix before it's in any shape for
>> submission. If someone wants to give this patch a spin, I would love to
>> hear the results.

Thanks for doing this Pekka.  I've fixed up some stuff and given it some 
brief testing on a 100BaseT network and it seems to work now.

> Subject: [PATCH] IP1000 Gigabit Ethernet device driver
> 
> This is a cleaned up fork of the IP1000A device driver:
> 
>   <http://www.icplus.com.tw/driver-pp-IP1000A.html>
> 
> Open issues include but are not limited to:
> 
>   - ipg_probe() looks really fishy and doesn't handle all errors
>     (e.g. ioremap failing).
>   - ipg_nic_do_ioctl() is playing games with user-space pointer.
>     We should use ethtool ioctl instead as suggested by Arjan.

Still pending.  Also:

     - something (PHY reset/auto negotiation?) takes 2-3 seconds and
       appears to be done with interrupts disabled.

>   - For multiple devices, the driver uses a global root_dev and
>     ipg_remove() play some tricks which look fishy.

Killed this.  It was broke and ugly as hell.

Attached is patch with some more changes:

- Remove changelogs
- Remove ether_crc_le() -- use crc32_le() instead.
- No more nonsense with root_dev -- ipg_remove() now works.
- Move PHY and MAC address initialization into the ipg_probe().  It was
   previously filling in the MAC address on open which breaks some user
   space.
- Folded ipg_nic_init into ipg_probe since it was broke otherwise.

Signed-off-by: David Vrabel <dvrabel@cantab.net>

--------------050209020606060604060506
Content-Type: text/plain;
 name="working"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="working"

Index: linux-source-2.6.16/drivers/net/ipg.c
===================================================================
--- linux-source-2.6.16.orig/drivers/net/ipg.c	2006-04-30 22:26:05.788013667 +0100
+++ linux-source-2.6.16/drivers/net/ipg.c	2006-05-01 00:23:28.358641581 +0100
@@ -13,149 +13,14 @@
  * 408 873 4117
  * www.sundanceti.com
  * craig_rich@sundanceti.com
- *
- * Rev  Date     Description
- * --------------------------------------------------------------
- * 0.1  11/8/99  Initial revision work begins.
- *
- * 0.2  11/12/99  Basic operation achieved, continuing work.
- *
- * 0.3  11/19/99  MAC Loop Back for sync problem testing.
- *
- * 0.4  12/22/99  ioctl for diagnotic program 'hunter' support.
- *
- * 0.5  4/13/00   Updates to
- *
- * 0.6  6/14/00   Slight correction to handling TFDDONE, and
- *                preservation of PHYCTRL polarity bits.
- *
- * 0.7  7/27/00   Modifications to accomodate triple speed
- *                autonegotiation. Also change to ioctl routine
- *                to handle unknown PHY address.
- *
- * 0.8  8/11/00   Added change_mtu function.
- *
- * 0.9  8/15/00   Corrected autonegotiation resolution.
- *
- * 0.10 8/30/00   Changed constants to use IPG in place
- *                of RIO. Also, removed most of debug
- *                code in preparation for production release.
- *
- * 0.11 8/31/00   Utilize 64 bit data types where appropriate.
- *
- * 0.12 9/1/00    Move some constants to include file and utilize
- *                RxDMAInt register.
- *
- * 0.13 10/31/00  Several minor modifications to improve stability.
- *
- * 0.14 11/28/00  Added call to nic_tx_free if TFD not available.
- *
- * 0.15 12/5/00   Corrected problem with receive errors, always set
- *                receive buffer address to NULL. Release RX buffers
- *                on errors.
- *
- * 0.16 12/20/00  Corrected autoneg resolution issue, must detect
- *                speed via PHYCTRL register. Also, perform only 1
- *                loop in the nic_txcleanup routine.
- *
- * 0.17 2/7/01    Changed all references of ST2021 to IPG.
- *                When next TFD not available, return -ENOMEM instead
- *                of 0. Removed references to RUBICON.
- *
- * 0.18 2/14/01   Corrected problem when unexpected jumbo frames are
- *                received (now dropped properly.) Changed
- *                "DROP_ON_ERRORS" breaking out Ethernet errors and
- *                TCP/IP errors serparately. Corrected Gigabit
- *                copper PAUSE autonegotiation.
- *
- * 0.19 2/22/01   Changed interrupt handling of RFD_LIST_END,
- *                INT_REQUESTED, and RX_DMA_COMPLETE. Masked off
- *                RMON statistics and unused MIB statistics.
- *                Make sure *all* statistics are accounted for
- *                (either masked or read in get_stats) to avoid
- *                perpetual UpdateStats interrupt from causing
- *                driver to crash.
- *
- * 0.20 3/2/01    Corrected error in nic_stop. Need to set
- *                TxBuff[] = NULL after freeing TxBuff and
- *                RxBuff[] = NULL after freeing RxBuff.
- *
- * 0.21 3/5/01    Correct 10/100Mbit PAUSE autonegotiation.
- *
- * 0.22 3/16/01   Used TxDMAIndicate for 100/1000Mbps modes. Add
- *                "TFD unavailable" and "RFD list end" counters
- *                to assist with performance measurement. Added
- *                check for maxtfdcnt != 0 to while loop within
- *                txcleanup.
- *
- * 0.23 3/22/01   Set the CurrentTxFrameID to 1 upon detecting
- *                a TxDMAComplete to reduce the number of TxDMAComplete.
- *                Also, indicate IP/TCP/UDP checksum is unneseccary
- *                if IPG indicates checksum validates.
- *
- * 0.24 3/23/01   Changed the txfree routine, eliminating the margin
- *                between the last freed TFD and the current TFD.
- *
- * 0.25 4/3/01    Corrected errors in config_autoneg to deal with
- *                fiber flag properly.
- *
- * 0.26 5/1/01    Port for operation with Linux 2.2 or 2.4 kernel.
- *
- * 0.27 5/22/01   Cleaned up some extraneous comments.
- *
- * 0.28 6/20/01   Added auto IP, TCP, and UDP checksum addition
- *                on transmit based on compilation option.
- *
- * 0.29 7/26/01   Comment out #include <asm/spinlock.h> from ipg.h
- *                for compatibility with RedHat 7.1. Unkown reason.
- *
- * 0.30 8/10/01   Added debug message to each function, print function
- *                name when entered. Added DEBUGCTRL register bit 5 for
- *                Rx DMA Poll Now bug work around. Added ifdef IPG_DEBUG
- *                flags to IPG_TFDlistunabvail and IPG_RFDlistend
- *                counters. Removed clearing of sp->stat struct from
- *                nic_open and added check in get_stats to make sure
- *                NIC is initialized before reading statistic registers.
- *                Corrected erroneous MACCTRL setting for Fiber based
- *                10/100 boards. Corrected storage of phyctrlpolarity
- *                variable.
- *
- * 0.31 8/13/01   Incorporate STI or TMI fiber based NIC detection.
- *                Corrected problem with _pciremove_linux2_4 routine.
- *                Corrected setting of IP/TCP/UDP checksumming on receive
- *                and transmit.
- *
- * 0.32 8/15/01   Changed the tmi_fiber_detect routine.
- *
- * 0.33 8/16/01   Changed PHY reset method in nic_open routine. Added
- *                a chip reset in nic_stop to shut down the IPG.
- *
- * 0.34 9/5/01    Corrected some misuage of dev_kfree_skb.
- *
- * 0.35 10/30/01  Unmap register space (IO or memory) in the nic_stop
- *                routine instead of in the cleanup or remove routines.
- *                Corrects driver up/down/up problem when using IO
- *                register mapping.
- *
- * 0.36 10/31/01  Modify the constant IPG_FRAMESBETWEENTXDMACOMPLETES
- *		  from 0x10 to 1.
- * 0.37 11/05/03  Modify the IPG_PHY_1000BASETCONTROL
- *				  in IP1000A this register is without 1000BPS Ability by default
- *				  so enable 1000BPS ability before PHY RESET/RESTART_AN
- * 0.38 11/05/03  update ipg_config_autoneg routine
- * 0.39 11/05/03  add Vendor_ID=13F0/Device_ID=1023 into support_cards
- * 2.05 10/16/04  Remove IPG_IE_RFD_LIST_END for pass SmartBit test.
- *                (see 20041019Jesse_For_SmartBit.)
- * 2.06 10/27/04 Support for kernel 2.6.x
- * 2.06a 11/03/04 remove some compile warring message.
- * 2.09b 06/03/05 Support 4k jumbo  (IC Plus, Jesse)
- * 2.09d 06/22/05 Support 10k jumbo, more than 4k will using copy mode (IC Plus, Jesse)
  */
 #define JUMBO_FRAME_4k_ONLY
 enum {
 	netdev_io_size = 128
 };
 
+#include <linux/crc32.h>
+
 #include "ipg.h"
 #define DRV_NAME	"ipg"
 
@@ -214,14 +79,12 @@
 static int ipg_nic_hard_start_xmit(struct sk_buff *, struct net_device *);
 static struct net_device_stats *ipg_nic_get_stats(struct net_device *);
 static void ipg_nic_set_multicast_list(struct net_device *);
-static int ipg_nic_init(struct net_device *);
 static int ipg_nic_rx(struct net_device *);
 static int ipg_nic_rxrestore(struct net_device *);
 static int init_rfdlist(struct net_device *);
 static int init_tfdlist(struct net_device *);
 static int ipg_get_rxbuff(struct net_device *, int);
 static int ipg_config_autoneg(struct net_device *);
-static unsigned ether_crc_le(int, unsigned char *);
 static int ipg_nic_do_ioctl(struct net_device *, struct ifreq *, int);
 static int ipg_nic_change_mtu(struct net_device *, int);
 
@@ -1637,60 +1500,12 @@
 	 * by ifconfig.
 	 */
 
-	int phyaddr = 0;
 	int error = 0;
-	int i;
 	void __iomem *ioaddr = ipg_ioaddr(dev);
-	u8 revisionid = 0;
 	struct ipg_nic_private *sp = netdev_priv(dev);
 
 	IPG_DEBUG_MSG("_nic_open\n");
 
-	/* Reset all functions within the IPG. Do not assert
-	 * RST_OUT as not compatible with some PHYs.
-	 */
-	i = IPG_AC_GLOBAL_RESET | IPG_AC_RX_RESET |
-	    IPG_AC_TX_RESET | IPG_AC_DMA |
-	    IPG_AC_FIFO | IPG_AC_NETWORK | IPG_AC_HOST | IPG_AC_AUTO_INIT;
-	/* Read/Write and Reset EEPROM Value Jesse20040128EEPROM_VALUE */
-	/* Read LED Mode Configuration from EEPROM */
-	sp->LED_Mode = read_eeprom(dev, 6);
-
-	error = ipg_reset(dev, i);
-	if (error < 0) {
-		return error;
-	}
-
-	/* Reset PHY. */
-	phyaddr = ipg_find_phyaddr(dev);
-
-	if (phyaddr != -1) {
-		u16 mii_phyctrl, mii_1000cr;
-		mii_1000cr = read_phy_register(dev,
-					       phyaddr,
-					       GMII_PHY_1000BASETCONTROL);
-		write_phy_register(dev, phyaddr,
-				   GMII_PHY_1000BASETCONTROL,
-				   mii_1000cr |
-				   GMII_PHY_1000BASETCONTROL_FULL_DUPLEX |
-				   GMII_PHY_1000BASETCONTROL_HALF_DUPLEX |
-				   GMII_PHY_1000BASETCONTROL_PreferMaster);
-
-		mii_phyctrl = read_phy_register(dev, phyaddr, GMII_PHY_CONTROL);
-		/* Set default phyparam */
-		pci_read_config_byte(sp->pdev, PCI_REVISION_ID, &revisionid);
-		ipg_set_phy_default_param(revisionid, dev, phyaddr);
-
-		/* reset Phy */
-		write_phy_register(dev,
-				   phyaddr, GMII_PHY_CONTROL,
-				   (mii_phyctrl | GMII_PHY_CONTROL_RESET |
-				    MII_PHY_CONTROL_RESTARTAN));
-
-	}
-
-	spin_lock_init(&sp->lock);
-
 	/* Check for interrupt line conflicts, and request interrupt
 	 * line for IPG.
 	 *
@@ -1743,26 +1558,6 @@
 		return error;
 	}
 
-	/* Read MAC Address from EERPOM Jesse20040128EEPROM_VALUE */
-	sp->StationAddr0 = read_eeprom(dev, 16);
-	sp->StationAddr1 = read_eeprom(dev, 17);
-	sp->StationAddr2 = read_eeprom(dev, 18);
-	/* Write MAC Address to Station Address */
-	iowrite16(sp->StationAddr0, ioaddr + IPG_STATIONADDRESS0);
-	iowrite16(sp->StationAddr1, ioaddr + IPG_STATIONADDRESS1);
-	iowrite16(sp->StationAddr2, ioaddr + IPG_STATIONADDRESS2);
-
-	/* Set station address in ethernet_device structure. */
-	dev->dev_addr[0] = ioread16(ioaddr + IPG_STATIONADDRESS0) & 0x00FF;
-	dev->dev_addr[1] =
-	    (ioread16(ioaddr + IPG_STATIONADDRESS0) & 0xFF00) >> 8;
-	dev->dev_addr[2] = ioread16(ioaddr + IPG_STATIONADDRESS1) & 0x00FF;
-	dev->dev_addr[3] =
-	    (ioread16(ioaddr + IPG_STATIONADDRESS1) & 0xFF00) >> 8;
-	dev->dev_addr[4] = ioread16(ioaddr + IPG_STATIONADDRESS2) & 0x00FF;
-	dev->dev_addr[5] =
-	    (ioread16(ioaddr + IPG_STATIONADDRESS2) & 0xFF00) >> 8;
-
 	/* Configure IPG I/O registers. */
 	error = ipg_io_config(dev);
 	if (error < 0) {
@@ -2860,7 +2655,8 @@
 	for (mc_list_ptr = dev->mc_list;
 	     mc_list_ptr != NULL; mc_list_ptr = mc_list_ptr->next) {
 		/* Calculate CRC result for each multicast address. */
-		hashindex = ether_crc_le(ETH_ALEN, mc_list_ptr->dmi_addr);
+		hashindex = crc32_le(0xffffffff, mc_list_ptr->dmi_addr,
+				     ETH_ALEN);
 
 		/* Use only the least significant 6 bits. */
 		hashindex = hashindex & 0x3F;
@@ -2883,86 +2679,79 @@
 		      ioread8(ioaddr + IPG_RECEIVEMODE));
 }
 
-/*
- * The following code fragment was authored by Donald Becker.
- */
-
-/* The little-endian AUTODIN II ethernet CRC calculations.
-   A big-endian version is also available.
-   This is slow but compact code.  Do not use this routine for bulk data,
-   use a table-based routine instead.
-   This is common code and should be moved to net/core/crc.c.
-   Chips may use the upper or lower CRC bits, and may reverse and/or invert
-   them.  Select the endian-ness that results in minimal calculations.
-*/
-static unsigned const ethernet_polynomial_le = 0xedb88320U;
-static unsigned ether_crc_le(int length, unsigned char *data)
+static int ipg_hw_init(struct net_device *dev)
 {
-	unsigned int crc = 0xffffffff;	/* Initial value. */
-	while (--length >= 0) {
-		unsigned char current_octet = *data++;
-		int bit;
-		for (bit = 8; --bit >= 0; current_octet >>= 1) {
-			if ((crc ^ current_octet) & 1) {
-				crc >>= 1;
-				crc ^= ethernet_polynomial_le;
-			} else
-				crc >>= 1;
-		}
-	}
-	return crc;
-}
+	int phyaddr = 0;
+	int error = 0;
+	int i;
+	void __iomem *ioaddr = ipg_ioaddr(dev);
+	u8 revisionid = 0;
+	struct ipg_nic_private *sp = netdev_priv(dev);
 
-/*
- * End of code fragment authored by Donald Becker.
- */
+	/* Reset all functions within the IPG. Do not assert
+	 * RST_OUT as not compatible with some PHYs.
+	 */
+	i = IPG_AC_GLOBAL_RESET | IPG_AC_RX_RESET |
+	    IPG_AC_TX_RESET | IPG_AC_DMA |
+	    IPG_AC_FIFO | IPG_AC_NETWORK | IPG_AC_HOST | IPG_AC_AUTO_INIT;
+	/* Read/Write and Reset EEPROM Value Jesse20040128EEPROM_VALUE */
+	/* Read LED Mode Configuration from EEPROM */
+	sp->LED_Mode = read_eeprom(dev, 6);
 
-static int ipg_nic_init(struct net_device *dev)
-{
-	/* Initialize IPG NIC. */
+	error = ipg_reset(dev, i);
+	if (error < 0) {
+		return error;
+	}
 
-	struct ipg_nic_private *sp = NULL;
+	ioaddr = ipg_ioaddr(dev);
 
-	IPG_DEBUG_MSG("_nic_init\n");
+	/* Reset PHY. */
+	phyaddr = ipg_find_phyaddr(dev);
 
-	/* Register the IPG NIC in the list of Ethernet devices. */
-	dev = alloc_etherdev(sizeof(struct ipg_nic_private));
+	if (phyaddr != -1) {
+		u16 mii_phyctrl, mii_1000cr;
+		mii_1000cr = read_phy_register(dev,
+					       phyaddr,
+					       GMII_PHY_1000BASETCONTROL);
+		write_phy_register(dev, phyaddr,
+				   GMII_PHY_1000BASETCONTROL,
+				   mii_1000cr |
+				   GMII_PHY_1000BASETCONTROL_FULL_DUPLEX |
+				   GMII_PHY_1000BASETCONTROL_HALF_DUPLEX |
+				   GMII_PHY_1000BASETCONTROL_PreferMaster);
 
-	if (dev == NULL) {
-		printk(KERN_INFO "Could not initialize IP1000 based NIC.\n");
-		return -ENODEV;
-	}
+		mii_phyctrl = read_phy_register(dev, phyaddr, GMII_PHY_CONTROL);
+		/* Set default phyparam */
+		pci_read_config_byte(sp->pdev, PCI_REVISION_ID, &revisionid);
+		ipg_set_phy_default_param(revisionid, dev, phyaddr);
 
-	/* Reserve memory for ipg_nic_private structure. */
-	sp = kmalloc(sizeof(struct ipg_nic_private), GFP_KERNEL);
+		/* reset Phy */
+		write_phy_register(dev,
+				   phyaddr, GMII_PHY_CONTROL,
+				   (mii_phyctrl | GMII_PHY_CONTROL_RESET |
+				    MII_PHY_CONTROL_RESTARTAN));
 
-	if (sp == NULL) {
-		printk(KERN_INFO
-		       "%s: No memory available for IP1000 private strucutre.\n",
-		       dev->name);
-		return -ENOMEM;
-	} else {
-		/* Fill the allocated memory space with 0s.
-		 * Essentially sets all ipg_nic_private
-		 * structure fields to 0.
-		 */
-		memset(sp, 0, sizeof(*sp));
-		dev->priv = sp;
 	}
 
-	/* Assign the new device to the list of IPG Ethernet devices. */
-	sp->next_dev = root_dev;
-	root_dev = dev;
+	/* Read MAC Address from EERPOM Jesse20040128EEPROM_VALUE */
+	sp->StationAddr0 = read_eeprom(dev, 16);
+	sp->StationAddr1 = read_eeprom(dev, 17);
+	sp->StationAddr2 = read_eeprom(dev, 18);
+	/* Write MAC Address to Station Address */
+	iowrite16(sp->StationAddr0, ioaddr + IPG_STATIONADDRESS0);
+	iowrite16(sp->StationAddr1, ioaddr + IPG_STATIONADDRESS1);
+	iowrite16(sp->StationAddr2, ioaddr + IPG_STATIONADDRESS2);
 
-	/* Declare IPG NIC functions for Ethernet device methods.
-	 */
-	dev->open = &ipg_nic_open;
-	dev->stop = &ipg_nic_stop;
-	dev->hard_start_xmit = &ipg_nic_hard_start_xmit;
-	dev->get_stats = &ipg_nic_get_stats;
-	dev->set_multicast_list = &ipg_nic_set_multicast_list;
-	dev->do_ioctl = &ipg_nic_do_ioctl;
-	dev->change_mtu = &ipg_nic_change_mtu;
+	/* Set station address in ethernet_device structure. */
+	dev->dev_addr[0] = ioread16(ioaddr + IPG_STATIONADDRESS0) & 0x00FF;
+	dev->dev_addr[1] =
+	    (ioread16(ioaddr + IPG_STATIONADDRESS0) & 0xFF00) >> 8;
+	dev->dev_addr[2] = ioread16(ioaddr + IPG_STATIONADDRESS1) & 0x00FF;
+	dev->dev_addr[3] =
+	    (ioread16(ioaddr + IPG_STATIONADDRESS1) & 0xFF00) >> 8;
+	dev->dev_addr[4] = ioread16(ioaddr + IPG_STATIONADDRESS2) & 0x00FF;
+	dev->dev_addr[5] =
+	    (ioread16(ioaddr + IPG_STATIONADDRESS2) & 0xFF00) >> 8;
 
 	return 0;
 }
@@ -3144,99 +2933,23 @@
 
 static void ipg_remove(struct pci_dev *pdev)
 {
-	/* Remove function called when a IPG device is
-	 * to be shut down.
-	 */
-
-	struct net_device *prev_dev = NULL;
-	struct net_device *dev = NULL;
-	struct net_device *dev_to_remove = NULL;
-	struct ipg_nic_private *prev_sp = NULL;
-	struct ipg_nic_private *sp = NULL;
-	struct ipg_nic_private *sp_to_remove = NULL;
-
-	IPG_DEBUG_MSG("_pciremove_linux2_4\n");
-
-	dev = root_dev;
-
-	/* Move through list of Ethernet devices looking for
-	 * a match.
-	 */
-	while (dev) {
-		sp = netdev_priv(dev);
-
-		if (sp->pdev == pdev) {
-			/* Save the pointer to the previous Ethernet
-			 * device.
-			 */
-			dev_to_remove = dev;
-
-			sp_to_remove = sp;
-
-			break;
-		}
-
-		/* Save the "previous" device in the list. */
-		prev_dev = dev;
-
-		/* Retrieve next Ethernet device to be
-		 * released.
-		 */
-		dev = sp->next_dev;
-	}
-
-	/* Check if there is a device to remove. */
-	if (dev_to_remove == NULL) {
-		/* There are no Ethernet devices to remove. */
-		printk(KERN_INFO
-		       "A device remove request does not match with any Ethernet devices.\n");
-
-		return;
-	}
-
-	/* Check to see if we are removing the root device in the list. */
-	if (root_dev == dev_to_remove) {
-		/* Change the root Ethernet device to the next device to be
-		 * released.
-		 */
-		root_dev = sp_to_remove->next_dev;
-	} else if (sp_to_remove->next_dev != NULL)
-		/* Check if we need to re-link the list of devices. */
-	{
-		/* If the "previous" Ethernet device is NULL,
-		 * the device is at the head of the list, and
-		 * no re-linking is needed.
-		 */
-		prev_sp = netdev_priv(prev_dev);
-
-		prev_sp->next_dev = sp_to_remove->next_dev;
-	}
-
-	/* Free memory associated with Ethernet device's
-	 * private data structure.
-	 */
-	if (sp_to_remove) {
-		kfree(sp_to_remove);
-	}
+	struct net_device *dev = pci_get_drvdata(pdev);
+	struct ipg_nic_private *sp = netdev_priv(dev);
 
-	printk(KERN_INFO "Un-registering Ethernet device %s\n",
-	       dev_to_remove->name);
+	IPG_DEBUG_MSG("_remove\n");
 
 	/* Un-register Ethernet device. */
-	unregister_netdev(dev_to_remove);
+	unregister_netdev(dev);
 
 #ifdef USE_IO_OPS
 	ioport_unmap(ioaddr);
 #else
 	iounmap(sp->ioaddr);
 #endif
-
 	pci_release_regions(pdev);
 
-	/* Free memory associated with Ethernet device. */
-	if (dev_to_remove) {
-		kfree(dev_to_remove);
-	}
+	free_netdev(dev);
+	pci_disable_device(pdev);
 	pci_set_drvdata(pdev, NULL);
 }
 
@@ -3269,13 +2982,31 @@
 		goto out;
 	}
 
-	err = ipg_nic_init(dev);
-	if (err) {
-		printk(KERN_INFO "Could not intialize IP1000 based NIC.\n");
+	/*
+	 * Initialize net device.
+	 */
+	dev = alloc_etherdev(sizeof(struct ipg_nic_private));
+	if (!dev) {
+		printk(KERN_ERR "ipg: alloc_etherdev failed\n");
+		err = -ENOMEM;
 		goto out;
 	}
-	dev = root_dev;
+
+	sp = netdev_priv(dev);
+	spin_lock_init(&sp->lock);
+
+	/* Declare IPG NIC functions for Ethernet device methods.
+	 */
+	dev->open = &ipg_nic_open;
+	dev->stop = &ipg_nic_stop;
+	dev->hard_start_xmit = &ipg_nic_hard_start_xmit;
+	dev->get_stats = &ipg_nic_get_stats;
+	dev->set_multicast_list = &ipg_nic_set_multicast_list;
+	dev->do_ioctl = &ipg_nic_do_ioctl;
+	dev->change_mtu = &ipg_nic_change_mtu;
+
 	SET_MODULE_OWNER(dev);
+	SET_NETDEV_DEV(dev, &pdev->dev);
 
 	err = pci_request_regions(pdev, DRV_NAME);
 	if (err)
@@ -3300,13 +3031,17 @@
 		goto out;
 	}
 #endif
-	sp = netdev_priv(root_dev);
+	sp = netdev_priv(dev);
 	/* Save the pointer to the PCI device information. */
 	sp->ioaddr = ioaddr;
 	sp->pdev = pdev;
 
 	pci_set_drvdata(pdev, dev);
 
+	err = ipg_hw_init(dev);
+	if (err)
+		goto out;
+
 	err = register_netdev(dev);
 	if (err)
 		goto out;
Index: linux-source-2.6.16/drivers/net/ipg.h
===================================================================
--- linux-source-2.6.16.orig/drivers/net/ipg.h	2006-04-30 23:02:09.861345105 +0100
+++ linux-source-2.6.16/drivers/net/ipg.h	2006-05-01 00:11:14.974349454 +0100
@@ -15,85 +15,6 @@
  * 408 873 4117
  * www.sundanceti.com
  * craig_rich@sundanceti.com
- *
- * Rev  Date     Description
- * --------------------------------------------------------------
- * 0.1  11/8/99  Initial revision work begins
- *
- * 0.2  12/1/99  Minor update to modversions.h inclusion.
- *
- * 0.3  12/30/99 Updates to fully comply with IPG spec.
- *
- * 0.4  4/24/00  Updates to allow for removal of FCS generation
- *               and verification.
- * 0.5  8/15/00  Updates for MII PHY registers and fields.
- *
- * 0.6  8/31/00  Updates to change to using 64 bit data types
- *
- * 0.7  10/31/00 Added DDEBUG_MSG to allow for easy activation of
- *               individual DEBUG_MSGs.
- *
- * 0.8  11/06/00 Changed LastFreedRxBuff to LastRestoredRxBuff for
- *               clarity.
- *
- * 0.9  11/10/00 Changed Sundance DeviceID to 0x9020
- *
- * 0.10 2/14/01  Changed "DROP_ON_ERRORS", breaking out Ethernet from
- *               TCP/IP errors.
- *
- * 0.11 3/16/01  Changed "IPG_FRAMESBETWEENTXCOMPLETES" to
- *               "IPG_FRAMESBETWEENTXDMACOMPLETES" since will
- *               be using TxDMAIndicate instead of TxIndicate to
- *               improve performance. Added TFDunavailCount and
- *               RFDlistendCount to aid in performance improvement.
- *
- * 0.12 3/22/01  Removed IPG_DROP_ON_RX_TCPIP_ERRORS.
- *
- * 0.13 3/23/01  Removed IPG_TXQUEUE_MARGIN.
- *
- * 0.14 3/30/01  Broke out sections into multiple files and added
- *               OS version specific detection and settings.
- */
-
-/*
- * Linux header utilization:
- *
- * config.h     For PCI support, namely CONFIG_PCI macro.
- *
- * version.h	For Linux kernel version detection.
- *
- * module.h	For modularized driver support.
- *
- * kernel.h     For 'printk'.
- *
- * pci.h        PCI support, including ID, VENDOR, and CLASS
- *              standard definitions; PCI specific structures,
- *              including pci_dev struct.
- *
- * ioport.h     I/O ports, check_region, request_region,
- *              release_region.
- *
- * errno.h      Standard error numbers, e.g. ENODEV.
- *
- * asm/io.h     For reading/writing I/O ports, and for virt_to_bus
- *		function.
- *
- * delay.h      For milisecond delays.
- *
- * types.h      For specific typedefs (i.e. u32, u16, u8).
- *
- * netdevice.h  For device structure needed for network support.
- *
- * etherdevice.h	For ethernet device support.
- *
- * init.h       For __initfunc.
- *
- * skbuff.h	Socket buffer (skbuff) definition.
- *
- * asm/bitops.h	For test_and_set_bit, clear_bit functions.
- *
- * asm/spinlock.h For spin_lock_irqsave, spin_lock_irqrestore functions.
- *
  */
 #ifndef __LINUX_IPG_H
 #define __LINUX_IPG_H
@@ -1000,9 +921,6 @@
  * End miscellaneous macros.
  */
 
-/* IPG Ethernet device structure, used for removing module. */
-struct net_device *root_dev = NULL;
-
 /* Transmit Frame Descriptor. The IPG supports 15 fragments,
  * however Linux requires only a single fragment. Note, each
  * TFD field is 64 bits wide.
@@ -1054,7 +972,6 @@
 	int RxBuffNotReady;
 	struct pci_dev *pdev;
 	struct net_device_stats stats;
-	struct net_device *next_dev;
 	spinlock_t lock;
 	int tenmbpsmode;
 

--------------050209020606060604060506--
