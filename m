Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278037AbRJIWoz>; Tue, 9 Oct 2001 18:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278036AbRJIWoq>; Tue, 9 Oct 2001 18:44:46 -0400
Received: from patan.Sun.COM ([192.18.98.43]:12282 "EHLO patan.sun.com")
	by vger.kernel.org with ESMTP id <S278039AbRJIWoc>;
	Tue, 9 Oct 2001 18:44:32 -0400
From: sethg@eng.sun.com
Date: Tue, 9 Oct 2001 15:44:04 -0700 (PDT)
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Robert Vojta <vojta@pharocom.net>, seth goldberg <seth.goldberg@sun.com>,
        <linux-kernel@vger.kernel.org>, <davem@redhat.com>
Subject: Re: sis900 does not work in 2.4.10
In-Reply-To: <Pine.LNX.3.96.1011009152114.22253A-100000@mandrakesoft.mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0110091543410.3118-100000@bergsoft.eng.sun.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  Installing the 2.4.10-ac10 patch fixed this problem 100%.  Thanks ver
much for the help.

 --Seth

On Tue, 9 Oct 2001, Jeff Garzik wrote:

}FWIW I just checked in this patch, which was going to go to Linus today
}or tomorrow, which contains updates for 630ET and ICS1893 PHY
}
}
}diff -urN linux-2.4.10/drivers/net/sis900.c linux-2.4.10-sis900/drivers/net/sis900.c
}--- linux-2.4.10/drivers/net/sis900.c	Mon Sep 10 01:45:43 2001
}+++ linux-2.4.10-sis900/drivers/net/sis900.c	Wed Sep 26 10:34:44 2001
}@@ -1,6 +1,6 @@
} /* sis900.c: A SiS 900/7016 PCI Fast Ethernet driver for Linux.
}    Copyright 1999 Silicon Integrated System Corporation
}-   Revision:	1.08.00	Jun. 11 2001
}+   Revision:	1.08.01	Aug. 25 2001
}
}    Modified from the driver which is originally written by Donald Becker.
}
}@@ -18,8 +18,9 @@
}    preliminary Rev. 1.0 Jan. 18, 1998
}    http://www.sis.com.tw/support/databook.htm
}
}+   Rev 1.08.01 Aug. 25 2001 Hui-Fen Hsu update for 630ET & workaround for ICS1893 PHY
}    Rev 1.08.00 Jun. 11 2001 Hui-Fen Hsu workaround for RTL8201 PHY and some bug fix
}-   Rev 1.07.11 Apr.  2 2001 Hui-Fen Hsu  updates PCI drivers to use the new pci_set_dma_mask for kernel 2.4.3
}+   Rev 1.07.11 Apr.  2 2001 Hui-Fen Hsu updates PCI drivers to use the new pci_set_dma_mask for kernel 2.4.3
}    Rev 1.07.10 Mar.  1 2001 Hui-Fen Hsu <hfhsu@sis.com.tw> some bug fix & 635M/B support
}    Rev 1.07.09 Feb.  9 2001 Dave Jones <davej@suse.de> PCI enable cleanup
}    Rev 1.07.08 Jan.  8 2001 Lei-Chun Chang added RTL8201 PHY support
}@@ -65,7 +66,7 @@
} #include "sis900.h"
}
} static char version[] __devinitdata =
}-KERN_INFO "sis900.c: v1.08.00  6/11/2001\n";
}+KERN_INFO "sis900.c: v1.08.01  9/25/2001\n";
}
} static int max_interrupt_work = 40;
} static int multicast_filter_limit = 128;
}@@ -404,8 +405,12 @@
} 		ret = -ENODEV;
} 		goto err_out_unregister;
} 	}
}+
}+	/* 630ET : set the mii access mode as software-mode */
}+	if (revision == SIS630ET_900_REV)
}+		outl(ACCESSMODE | inl(ioaddr + cr), ioaddr + cr);
}
}-	/* probe for mii transciver */
}+	/* probe for mii transceiver */
} 	if (sis900_mii_probe(net_dev) == 0) {
} 		ret = -ENODEV;
} 		goto err_out_unregister;
}@@ -513,6 +518,11 @@
}         if ((sis_priv->mii->phy_id0 == 0x001D) &&
} 	    ((sis_priv->mii->phy_id1&0xFFF0) == 0x8000))
}         	status = sis900_reset_phy(net_dev, sis_priv->cur_phy);
}+
}+        /* workaround for ICS1893 PHY */
}+        if ((sis_priv->mii->phy_id0 == 0x0015) &&
}+            ((sis_priv->mii->phy_id1&0xFFF0) == 0xF440))
}+            	mdio_write(net_dev, sis_priv->cur_phy, 0x0018, 0xD200);
}
} 	if(status & MII_STAT_LINK){
} 		while (poll_bit) {
}@@ -860,7 +870,7 @@
}
} 	/* Enable all known interrupts by setting the interrupt mask. */
} 	outl((RxSOVR|RxORN|RxERR|RxOK|TxURN|TxERR|TxIDLE), ioaddr + imr);
}-	outl(RxENA, ioaddr + cr);
}+	outl(RxENA | inl(ioaddr + cr), ioaddr + cr);
} 	outl(IE, ioaddr + ier);
}
} 	sis900_check_mode(net_dev, sis_priv->mii);
}@@ -1037,7 +1047,7 @@
} 	struct pci_dev *dev=NULL;
}
} 	if ( !(revision == SIS630E_900_REV || revision == SIS630EA1_900_REV ||
}-	       revision == SIS630A_900_REV) )
}+	       revision == SIS630A_900_REV || revision ==  SIS630ET_900_REV) )
} 		return;
}
} 	dev = pci_find_device(PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_630, dev);
}@@ -1055,7 +1065,8 @@
} 			min_value=(eq_value < min_value) ? eq_value : min_value;
} 		}
} 		/* 630E rule to determine the equalizer value */
}-		if (revision == SIS630E_900_REV || revision == SIS630EA1_900_REV) {
}+		if (revision == SIS630E_900_REV || revision == SIS630EA1_900_REV ||
}+		    revision == SIS630ET_900_REV) {
} 			if (max_value < 5)
} 				eq_value=max_value;
} 			else if (max_value >= 5 && max_value < 15)
}@@ -1371,7 +1382,7 @@
} 	net_dev->trans_start = jiffies;
}
} 	/* FIXME: Should we restart the transmission thread here  ?? */
}-	outl(TxENA, ioaddr + cr);
}+	outl(TxENA | inl(ioaddr + cr), ioaddr + cr);
}
} 	/* Enable all known interrupts by setting the interrupt mask. */
} 	outl((RxSOVR|RxORN|RxERR|RxOK|TxURN|TxERR|TxIDLE), ioaddr + imr);
}@@ -1406,7 +1417,7 @@
} 	sis_priv->tx_ring[entry].bufptr = pci_map_single(sis_priv->pci_dev,
} 		skb->data, skb->len, PCI_DMA_TODEVICE);
} 	sis_priv->tx_ring[entry].cmdsts = (OWN | skb->len);
}-	outl(TxENA, ioaddr + cr);
}+	outl(TxENA | inl(ioaddr + cr), ioaddr + cr);
}
} 	if (++sis_priv->cur_tx - sis_priv->dirty_tx < NUM_TX_DESC) {
} 		/* Typical path, tell upper layer that more transmission is possible */
}@@ -1622,7 +1633,7 @@
} 		}
} 	}
} 	/* re-enable the potentially idle receive state matchine */
}-	outl(RxENA , ioaddr + cr );
}+	outl(RxENA | inl(ioaddr + cr), ioaddr + cr );
}
} 	return 0;
} }
}@@ -1720,7 +1731,7 @@
} 	outl(0x0000, ioaddr + ier);
}
} 	/* Stop the chip's Tx and Rx Status Machine */
}-	outl(RxDIS | TxDIS, ioaddr + cr);
}+	outl(RxDIS | TxDIS | inl(ioaddr + cr), ioaddr + cr);
}
} 	del_timer(&sis_priv->timer);
}
}@@ -2036,7 +2047,7 @@
} 	outl(0, ioaddr + imr);
} 	outl(0, ioaddr + rfcr);
}
}-	outl(RxRESET | TxRESET | RESET, ioaddr + cr);
}+	outl(RxRESET | TxRESET | RESET | inl(ioaddr + cr), ioaddr + cr);
}
} 	/* Check that the chip has finished the reset. */
} 	while (status && (i++ < 1000)) {
}diff -urN linux-2.4.10/drivers/net/sis900.h linux-2.4.10-sis900/drivers/net/sis900.h
}--- linux-2.4.10/drivers/net/sis900.h	Wed Jul 18 09:53:55 2001
}+++ linux-2.4.10-sis900/drivers/net/sis900.h	Wed Sep 26 10:34:45 2001
}@@ -41,7 +41,7 @@
}
} /* Symbolic names for bits in various registers */
} enum sis900_command_register_bits {
}-	RELOAD  = 0x00000400,
}+	RELOAD  = 0x00000400, ACCESSMODE = 0x00000200,/* ET */
} 	RESET   = 0x00000100, SWI = 0x00000080, RxRESET = 0x00000020,
} 	TxRESET = 0x00000010, RxDIS = 0x00000008, RxENA = 0x00000004,
} 	TxDIS   = 0x00000002, TxENA = 0x00000001
}@@ -239,7 +239,8 @@
} enum sis900_revision_id {
} 	SIS630A_900_REV = 0x80,		SIS630E_900_REV = 0x81,
} 	SIS630S_900_REV = 0x82,		SIS630EA1_900_REV = 0x83,
}-	SIS635A_900_REV = 0x90,		SIS900B_900_REV = 0x03
}+	SIS630ET_900_REV = 0x84,	SIS635A_900_REV = 0x90,
}+	SIS900B_900_REV = 0x03
} };
}
} enum sis630_revision_id {
}
}

