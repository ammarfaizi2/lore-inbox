Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbTKBSyU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 13:54:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261774AbTKBSyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 13:54:20 -0500
Received: from adsl-ull-75-87.42-151.net24.it ([151.42.87.75]:34052 "EHLO
	gateway.milesteg.arr") by vger.kernel.org with ESMTP
	id S261773AbTKBSyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 13:54:15 -0500
Date: Sun, 2 Nov 2003 19:28:52 +0100
From: Daniele Venzano <webvenza@libero.it>
To: Patrick Mochel <mochel@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       acpi-devel@lists.sorceforge.net
Subject: [PATCH] Add PM support to sis900 network driver
Message-ID: <20031102182852.GC18017@picchio.gall.it>
Mail-Followup-To: Patrick Mochel <mochel@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	acpi-devel@lists.sorceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The attached patch adds support for suspend/resume to the sis900 driver.
With this patch on resume the NIC is fully configured and operational,
before a module reload was needed because of the complete lack of
suspend/resume callbacks.

I added two functions, sis900_suspend and sis900_resume, with their
pointers in struct pci_driver. A vector of 16 u32 was then needed to the
to keep PCI data during suspend. I added it in struct sis900_private.
I updated the revision number to reflect my changes. 
Looking at the code I also killed three typos.

The patch doesn't touch any other code.

Since I don't know anything on ethernet drivers the rule 'works for me'
is fully valid.

Please consider this patch for inclusion when the freeze is over, the
sis900 driver is not updated since 2002 (looking at the changelog) and
the email address listed in the MAINTAINERS file bounces.

I'll try to keep the patch updated on new kernel releases at:
http://teg.homeunix.org/kernel_patches.html

Bye.

-- 
------------------------------
Daniele Venzano
Web: http://teg.homeunix.org

--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sis900.diff"

diff -Naur -X /home/venza/dontdiff linux-2.6.0-test9/drivers/net/sis900.c linux-2.6.0-test9-dv/drivers/net/sis900.c
--- linux-2.6.0-test9/drivers/net/sis900.c	2003-09-28 15:26:42.000000000 +0200
+++ linux-2.6.0-test9-dv/drivers/net/sis900.c	2003-11-02 18:33:39.000000000 +0100
@@ -18,10 +18,11 @@
    preliminary Rev. 1.0 Jan. 18, 1998
    http://www.sis.com.tw/support/databook.htm
 
+   Rev 1.08.07 Nov.  2 2003 Daniele Venzano <webvenza@libero.it> add suspend/resume support
    Rev 1.08.06 Sep. 24 2002 Mufasa Yang bug fix for Tx timeout & add SiS963 support
-   Rev 1.08.05 Jun. 6 2002 Mufasa Yang bug fix for read_eeprom & Tx descriptor over-boundary 
+   Rev 1.08.05 Jun.  6 2002 Mufasa Yang bug fix for read_eeprom & Tx descriptor over-boundary 
    Rev 1.08.04 Apr. 25 2002 Mufasa Yang <mufasa@sis.com.tw> added SiS962 support
-   Rev 1.08.03 Feb. 1 2002 Matt Domsch <Matt_Domsch@dell.com> update to use library crc32 function
+   Rev 1.08.03 Feb.  1 2002 Matt Domsch <Matt_Domsch@dell.com> update to use library crc32 function
    Rev 1.08.02 Nov. 30 2001 Hui-Fen Hsu workaround for EDB & bug fix for dhcp problem
    Rev 1.08.01 Aug. 25 2001 Hui-Fen Hsu update for 630ET & workaround for ICS1893 PHY
    Rev 1.08.00 Jun. 11 2001 Hui-Fen Hsu workaround for RTL8201 PHY and some bug fix
@@ -72,7 +73,7 @@
 #include "sis900.h"
 
 #define SIS900_MODULE_NAME "sis900"
-#define SIS900_DRV_VERSION "v1.08.06 9/24/2002"
+#define SIS900_DRV_VERSION "v1.08.07 11/02/2003"
 
 static char version[] __devinitdata =
 KERN_INFO "sis900.c: " SIS900_DRV_VERSION "\n";
@@ -169,6 +170,7 @@
 
 	unsigned int tx_full;			/* The Tx queue is full.    */
 	u8 host_bridge_rev;
+	u32 pci_state[16];
 };
 
 MODULE_AUTHOR("Jim Huang <cmhuang@sis.com.tw>, Ollie Lho <ollie@sis.com.tw>");
@@ -305,7 +307,7 @@
 		*( ((u16 *)net_dev->dev_addr) + i) = inw(ioaddr + rfdr);
 	}
 
-	/* enable packet filitering */
+	/* enable packet filtering */
 	outl(rfcrSave | RFEN, rfcr + ioaddr);
 
 	return 1;
@@ -994,7 +996,7 @@
 		}
 	}
 
-	/* enable packet filitering */
+	/* enable packet filtering */
 	outl(rfcrSave | RFEN, rfcr + ioaddr);
 }
 
@@ -1466,7 +1468,7 @@
  *	@net_dev: the net device to transmit with
  *
  *	Set the transmit buffer descriptor, 
- *	and write TxENA to enable transimt state machine.
+ *	and write TxENA to enable transmit state machine.
  *	tell upper layer if the buffer is full
  */
 
@@ -2184,11 +2186,78 @@
 	pci_set_drvdata(pci_dev, NULL);
 }
 
+#ifdef CONFIG_PM
+
+static int sis900_suspend(struct pci_dev *pci_dev, u32 state)
+{
+	struct net_device *net_dev = pci_get_drvdata(pci_dev);
+	struct sis900_private *sis_priv = net_dev->priv;
+	long ioaddr = net_dev->base_addr;
+	unsigned long flags;
+
+	if(!netif_running(net_dev))
+		return 0;
+	netif_stop_queue(net_dev);
+	
+	netif_device_detach(net_dev);
+	spin_lock_irqsave(&sis_priv->lock, flags);
+
+	/* Stop the chip's Tx and Rx Status Machine */
+	outl(RxDIS | TxDIS | inl(ioaddr + cr), ioaddr + cr);
+	
+	pci_set_power_state(pci_dev, 3);
+	pci_save_state(pci_dev, sis_priv->pci_state);
+
+	spin_unlock_irqrestore(&sis_priv->lock, flags);
+	return 0;
+}
+
+static int sis900_resume(struct pci_dev *pci_dev)
+{
+	struct net_device *net_dev = pci_get_drvdata(pci_dev);
+	struct sis900_private *sis_priv = net_dev->priv;
+	long ioaddr = net_dev->base_addr;
+
+	if(!netif_running(net_dev))
+		return 0;
+	pci_restore_state(pci_dev, sis_priv->pci_state);
+	pci_set_power_state(pci_dev, 0);
+
+//	/* Soft reset the chip */
+//	sis900_reset(net_dev);
+	sis900_init_rxfilter(net_dev);
+
+	sis900_init_tx_ring(net_dev);
+	sis900_init_rx_ring(net_dev);
+
+	set_rx_mode(net_dev);
+
+	netif_device_attach(net_dev);
+	netif_start_queue(net_dev);
+
+	/* Workaround for EDB */
+	sis900_set_mode(ioaddr, HW_SPEED_10_MBPS, FDX_CAPABLE_HALF_SELECTED);
+
+	/* Enable all known interrupts by setting the interrupt mask. */
+	outl((RxSOVR|RxORN|RxERR|RxOK|TxURN|TxERR|TxIDLE), ioaddr + imr);
+	outl(RxENA | inl(ioaddr + cr), ioaddr + cr);
+	outl(IE, ioaddr + ier);
+
+	sis900_check_mode(net_dev, sis_priv->mii);
+
+	return 0;
+}
+#endif /* CONFIG_PM */
+
 static struct pci_driver sis900_pci_driver = {
 	.name		= SIS900_MODULE_NAME,
 	.id_table	= sis900_pci_tbl,
 	.probe		= sis900_probe,
 	.remove		= __devexit_p(sis900_remove),
+#ifdef CONFIG_PM
+	.suspend	= sis900_suspend,
+	.resume		= sis900_resume,
+#endif /* CONFIG_PM */
 };
 
 static int __init sis900_init_module(void)

--AqsLC8rIMeq19msA--
