Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262152AbTKCSRa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 13:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbTKCSRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 13:17:30 -0500
Received: from adsl-ull-75-87.42-151.net24.it ([151.42.87.75]:53767 "EHLO
	gateway.milesteg.arr") by vger.kernel.org with ESMTP
	id S262152AbTKCSRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 13:17:25 -0500
Date: Mon, 3 Nov 2003 19:17:21 +0100
From: Daniele Venzano <webvenza@libero.it>
To: Andrew Morton <akpm@osdl.org>
Cc: mochel@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add PM support to sis900 network driver
Message-ID: <20031103181721.GC852@picchio.gall.it>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, mochel@osdl.org,
	linux-kernel@vger.kernel.org
References: <20031102182852.GC18017@picchio.gall.it> <20031102111254.481bcbfd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
In-Reply-To: <20031102111254.481bcbfd.akpm@osdl.org>
X-Operating-System: Debian GNU/Linux on kernel Linux 2.4.22
X-Copyright: Forwarding or publishing without permission is prohibited.
X-Truth: La vita e' una questione di culo, o ce l'hai o te lo fanno.
X-GPG-Fingerprint: 642A A345 1CEF B6E3 925C  23CE DAB9 8764 25B3 57ED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 02, 2003 at 11:12:54AM -0800, Andrew Morton wrote:
> pci_set_power_state() can sleep, so we shouldn't be calling it
> under spin_lock_irqsave().  Is it necessary to hold the lock
> here?

New patch with locking completely removed, since in a similar
function none was used.

I think also the 8139too driver has the same locking problem in
rtl8139_suspend, do you want a patch ?

-- 
------------------------------
Daniele Venzano
Web: http://teg.homeunix.org

--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sis900.diff"

diff -Naur -X /home/venza/dontdiff linux-2.6.0-test9/drivers/net/sis900.c linux-2.6.0-test9-dv/drivers/net/sis900.c
--- linux-2.6.0-test9/drivers/net/sis900.c	2003-09-28 15:26:42.000000000 +0200
+++ linux-2.6.0-test9-dv/drivers/net/sis900.c	2003-11-03 18:44:26.000000000 +0100
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
 
@@ -2184,11 +2186,73 @@
 	pci_set_drvdata(pci_dev, NULL);
 }
 
+#ifdef CONFIG_PM
+
+static int sis900_suspend(struct pci_dev *pci_dev, u32 state)
+{
+	struct net_device *net_dev = pci_get_drvdata(pci_dev);
+	struct sis900_private *sis_priv = net_dev->priv;
+	long ioaddr = net_dev->base_addr;
+
+	if(!netif_running(net_dev))
+		return 0;
+	netif_stop_queue(net_dev);
+	
+	netif_device_detach(net_dev);
+
+	/* Stop the chip's Tx and Rx Status Machine */
+	outl(RxDIS | TxDIS | inl(ioaddr + cr), ioaddr + cr);
+	
+	pci_set_power_state(pci_dev, 3);
+	pci_save_state(pci_dev, sis_priv->pci_state);
+
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

--ZPt4rx8FFjLCG7dd--
