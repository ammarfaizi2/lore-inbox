Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261681AbVDBEih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbVDBEih (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 23:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261687AbVDBEig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 23:38:36 -0500
Received: from 64-30-195-78.dsl.linkline.com ([64.30.195.78]:49876 "EHLO
	jg555.com") by vger.kernel.org with ESMTP id S261681AbVDBEiQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 23:38:16 -0500
Message-ID: <424E21AC.6000206@jg555.com>
Date: Fri, 01 Apr 2005 20:38:04 -0800
From: Jim Gifford <maillist@jg555.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_server-21380-1112416694-0001-2"
To: Grant Grundler <grundler@parisc-linux.org>
CC: LKML <linux-kernel@vger.kernel.org>, jgarzik@pobox.com,
       pdh@colonel-panic.org
Subject: Re: 64bit build of tulip driver
References: <424AE9E0.8040601@jg555.com> <20050331161206.GB19219@colo.lackof.org> <424CC566.3080007@jg555.com> <20050401065120.GD29734@colo.lackof.org> <424D7AE9.5050100@jg555.com> <20050401182609.GB8178@colo.lackof.org>
In-Reply-To: <20050401182609.GB8178@colo.lackof.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_server-21380-1112416694-0001-2
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

With Grant's help I was able to get the tulip driver to work with 64 bit 
MIPS.

Again Thanx Grant. Attached is the patch I used.



--=_server-21380-1112416694-0001-2
Content-Type: text/x-diff; name="tulip-kernel[1].patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tulip-kernel[1].patch"

diff -Naur linux-2.6.11.6/drivers/net/tulip/eeprom.c linux-2.6.11.6/drivers/net/tulip/eeprom.c
--- linux-2.6.11.6/drivers/net/tulip/eeprom.c	2005-03-25 19:28:37 -0800
+++ linux-2.6.11.6/drivers/net/tulip/eeprom.c	2005-04-01 09:13:39 -0800
@@ -63,6 +63,22 @@
 	 */
 	{ 0x1e00, 0x0000, 0x000b, 0x8f01, 0x0103, 0x0300, 0x0821, 0x000, 0x0001, 0x0000, 0x01e1 }
   },
+  {"Cobalt Microserver", 0, 0x10, 0xE0, {0x1e00, /* 0 == controller #, 1e == offset	*/
+					 0x0000, /* 0 == high offset, 0 == gap		*/
+					 0x0800, /* Default Autoselect			*/
+					 0x8001, /* 1 leaf, extended type, bogus len	*/
+					 0x0003, /* Type 3 (MII), PHY #0		*/
+					 0x0400, /* 0 init instr, 4 reset instr		*/
+					 0x0801, /* Set control mode, GP0 output	*/
+					 0x0000, /* Drive GP0 Low (RST is active low)	*/
+					 0x0800, /* control mode, GP0 input (undriven)	*/
+					 0x0000, /* clear control mode			*/
+					 0x7800, /* 100TX FDX + HDX, 10bT FDX + HDX	*/
+					 0x01e0, /* Advertise all above			*/
+					 0x5000, /* FDX all above			*/
+					 0x1800, /* Set fast TTM in 100bt modes		*/
+					 0x0000, /* PHY cannot be unplugged		*/
+  }},
   {NULL}};
 
 
diff -Naur linux-2.6.11.6/drivers/net/tulip/interrupt.c linux-2.6.11.6/drivers/net/tulip/interrupt.c
--- linux-2.6.11.6/drivers/net/tulip/interrupt.c	2005-03-25 19:28:40 -0800
+++ linux-2.6.11.6/drivers/net/tulip/interrupt.c	2005-04-01 08:59:41 -0800
@@ -26,7 +26,7 @@
 #define MIT_SIZE 15
 #define MIT_TABLE 15 /* We use 0 or max */
 
-unsigned int mit_table[MIT_SIZE+1] =
+static unsigned int mit_table[MIT_SIZE+1] =
 {
         /*  CRS11 21143 hardware Mitigation Control Interrupt
             We use only RX mitigation we other techniques for
diff -Naur linux-2.6.11.6/drivers/net/tulip/media.c linux-2.6.11.6/drivers/net/tulip/media.c
--- linux-2.6.11.6/drivers/net/tulip/media.c	2005-03-25 19:28:17 -0800
+++ linux-2.6.11.6/drivers/net/tulip/media.c	2005-04-01 08:57:20 -0800
@@ -44,8 +44,10 @@
 
 /* MII transceiver control section.
    Read and write the MII registers using software-generated serial
-   MDIO protocol.  See the MII specifications or DP83840A data sheet
-   for details. */
+   MDIO protocol.
+   See IEEE 802.3-2002.pdf (Section 2, Chapter "22.2.4 Management functions")
+   or DP83840A data sheet for more details.
+   */
 
 int tulip_mdio_read(struct net_device *dev, int phy_id, int location)
 {
@@ -88,7 +90,7 @@
 		value = ioread32(ioaddr + CSR9);
 		iowrite32(value & 0xFFEFFFFF, ioaddr + CSR9);
 		
-		value = (phy_id << 21) | (location << 16) | 0x80000000;
+		value = (phy_id << 21) | (location << 16) | 0x08000000;
 		iowrite32(value, ioaddr + CSR10);
 		
 		while(--i > 0) {
@@ -166,7 +168,7 @@
 		value = ioread32(ioaddr + CSR9);
 		iowrite32(value & 0xFFEFFFFF, ioaddr + CSR9);
 		
-		value = (phy_id << 21) | (location << 16) | 0x40000000 | (val & 0xFFFF);
+		value = (phy_id << 21) | (location << 16) | 0x04000000 | (val & 0xFFFF);
 		iowrite32(value, ioaddr + CSR10);
 		
 		while(--i > 0) {
@@ -307,13 +309,29 @@
 				int reset_length = p[2 + init_length];
 				misc_info = (u16*)(reset_sequence + reset_length);
 				if (startup) {
+					int timeout = 10;	/* max 1 ms */
 					iowrite32(mtable->csr12dir | 0x100, ioaddr + CSR12);
 					for (i = 0; i < reset_length; i++)
 						iowrite32(reset_sequence[i], ioaddr + CSR12);
+
+					/* flush posted writes */
+					ioread32(ioaddr + CSR12);
+
+					/* Sect 3.10.3 in DP83840A.pdf (p39) */
+					udelay(500);
+
+					/* Section 4.2 in DP83840A.pdf (p43) */
+					/* and IEEE 802.3 "22.2.4.1.1 Reset" */
+					while (timeout-- &&
+						(tulip_mdio_read (dev, phy_num, MII_BMCR) & BMCR_RESET))
+						udelay(100);
 				}
 				for (i = 0; i < init_length; i++)
 					iowrite32(init_sequence[i], ioaddr + CSR12);
+
+				ioread32(ioaddr + CSR12);	/* flush posted writes */
 			}
+
 			tmp_info = get_u16(&misc_info[1]);
 			if (tmp_info)
 				tp->advertising[phy_num] = tmp_info | 1;
diff -Naur linux-2.6.11.6/drivers/net/tulip/tulip.h linux-2.6.11.6/drivers/net/tulip/tulip.h
--- linux-2.6.11.6/drivers/net/tulip/tulip.h	2005-03-25 19:28:36 -0800
+++ linux-2.6.11.6/drivers/net/tulip/tulip.h	2005-04-01 09:01:07 -0800
@@ -475,8 +475,11 @@
 			udelay(10);
 
 		if (!i)
-			printk(KERN_DEBUG "%s: tulip_stop_rxtx() failed\n",
-					tp->pdev->slot_name);
+			printk(KERN_DEBUG "%s: tulip_stop_rxtx() failed"
+					" (CSR5 0x%x CSR6 0x%x)\n",
+					pci_name(tp->pdev),
+					ioread32(ioaddr + CSR5),
+					ioread32(ioaddr + CSR6));
 	}
 }
 
diff -Naur linux-2.6.11.6/drivers/net/tulip/tulip_core.c linux-2.6.11.6/drivers/net/tulip/tulip_core.c
--- linux-2.6.11.6/drivers/net/tulip/tulip_core.c	2005-03-25 19:28:22 -0800
+++ linux-2.6.11.6/drivers/net/tulip/tulip_core.c	2005-04-01 09:01:54 -0800
@@ -22,7 +22,7 @@
 #else
 #define DRV_VERSION	"1.1.13"
 #endif
-#define DRV_RELDATE	"May 11, 2002"
+#define DRV_RELDATE	"December 15, 2004"
 
 
 #include <linux/module.h>
@@ -1102,15 +1102,18 @@
 			entry = tp->cur_tx++ % TX_RING_SIZE;
 
 			if (entry != 0) {
-				/* Avoid a chip errata by prefixing a dummy entry. */
-				tp->tx_buffers[entry].skb = NULL;
-				tp->tx_buffers[entry].mapping = 0;
-				tp->tx_ring[entry].length =
-					(entry == TX_RING_SIZE-1) ? cpu_to_le32(DESC_RING_WRAP) : 0;
-				tp->tx_ring[entry].buffer1 = 0;
-				/* Must set DescOwned later to avoid race with chip */
-				dummy = entry;
-				entry = tp->cur_tx++ % TX_RING_SIZE;
+				/* Avoid a chip errata by prefixing a dummy entry. Don't do
+				   this on the ULI526X as it triggers a different problem */
+				if (!(tp->chip_id == ULI526X && (tp->revision = 0x40 || tp->revision == 0x50))) {
+					tp->tx_buffers[entry].skb = NULL;
+					tp->tx_buffers[entry].mapping = 0;
+					tp->tx_ring[entry].length =
+						(entry == TX_RING_SIZE-1) ? cpu_to_le32(DESC_RING_WRAP) : 0;
+					tp->tx_ring[entry].buffer1 = 0;
+					/* Must set DescOwned later to avoid race with chip */
+					dummy = entry;
+					entry = tp->cur_tx++ % TX_RING_SIZE;
+				}
 			}
 
 			tp->tx_buffers[entry].skb = NULL;
@@ -1749,7 +1752,7 @@
 
 #ifdef CONFIG_PM
 
-static int tulip_suspend (struct pci_dev *pdev, u32 state)
+static int tulip_suspend (struct pci_dev *pdev, pm_message_t state)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 

--=_server-21380-1112416694-0001-2--
