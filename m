Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261428AbVA1Dhh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbVA1Dhh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 22:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261430AbVA1Dhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 22:37:37 -0500
Received: from NK210-202-245-3.vdsl.static.apol.com.tw ([210.202.245.3]:4839
	"EHLO uli.com.tw") by vger.kernel.org with ESMTP id S261428AbVA1DhH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 22:37:07 -0500
Subject: [patch] net/tulip: Modify a bug for ULi M526X(kernel 2.6.10)
To: jgarzik@pobox.com
Cc: alan@redhat.com, linux-kernel@vger.kernel.org,
       andrebalsa@mailingaddress.org, Peer.Chen@uli.com.tw,
       Emily.Jiang@uli.com.tw, Eric.Lo@uli.com.tw
X-Mailer: Lotus Notes R5.0 (Intl) 30 March 1999
Message-ID: <OF10E6966D.582973D8-ON48256F97.0011D8ED@uli.com.tw>
From: Clear.Zhang@uli.com.tw
Date: Fri, 28 Jan 2005 11:36:52 +0800
MIME-Version: 1.0
X-MIMETrack: Serialize by Router on ulicnm01/ULI(Release 5.0.11  |July 24, 2002) at 2005/01/28
 11:36:54 AM,
	Itemize by SMTP Server on ulim01/ULI(Release 5.0.11  |July 24, 2002) at
 2005/01/28 11:36:54 AM,
	Serialize by Router on ulim01/ULI(Release 5.0.11  |July 24, 2002) at 2005/01/28
 11:36:59 AM,
	Serialize complete at 2005/01/28 11:36:59 AM
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jeff

There is a bug about ULi M526X. It cannot deal with the dummy descriptor.

For example:
Des0:0x80000000
Des1:0
Des2:0
Des3:pointer to next descriptor

This patch is applied to kernel 2.6.10. Please apply to new kernels. Thanks
a lot.

Signed-off-by: Clear Zhang <Clear.Zhang@uli.com.tw>


BRs,
Clear


diff -uprN linux-2.6.10-vanilla/drivers/net/tulip/media.c
linux-2.6.10/drivers/net/tulip/media.c
--- linux-2.6.10-vanilla/drivers/net/tulip/media.c    2004-12-25
05:34:27.000000000 +0800
+++ linux-2.6.10/drivers/net/tulip/media.c      2005-01-28
10:57:13.000000000 +0800
@@ -81,6 +81,25 @@ int tulip_mdio_read(struct net_device *d
            return retval & 0xffff;
      }

+     if(tp->chip_id == ULI526X && tp->revision >= 0x40) {
+           int value;
+           int i = 1000;
+
+           value = ioread32(ioaddr + CSR9);
+           iowrite32(value & 0xFFEFFFFF, ioaddr + CSR9);
+
+           value = (phy_id << 21) | (location << 16) | 0x8000000;
+           iowrite32(value, ioaddr + CSR10);
+
+           while(--i > 0) {
+                 mdio_delay();
+                 if(ioread32(ioaddr + CSR10) & 0x10000000)
+                       break;
+           }
+           retval = ioread32(ioaddr + CSR10);
+           spin_unlock_irqrestore(&tp->mii_lock, flags);
+           return retval & 0xFFFF;
+     }
      /* Establish sync by sending at least 32 logic ones. */
      for (i = 32; i >= 0; i--) {
            iowrite32(MDIO_ENB | MDIO_DATA_WRITE1, mdio_addr);
@@ -140,7 +159,24 @@ void tulip_mdio_write(struct net_device
            spin_unlock_irqrestore(&tp->mii_lock, flags);
            return;
      }
-
+
+     if (tp->chip_id == ULI526X && tp->revision >= 0x40) {
+           int value;
+           int i = 1000;
+
+           value = ioread32(ioaddr + CSR9);
+           iowrite32(value & 0xFFEFFFFF, ioaddr + CSR9);
+
+           value = (phy_id << 21) | (location << 16) | 0x4000000 | (val &
0xFFFF);
+           iowrite32(value, ioaddr + CSR10);
+
+           while(--i > 0) {
+                 if (ioread32(ioaddr + CSR10) & 0x10000000)
+                       break;
+           }
+           spin_unlock_irqrestore(&tp->mii_lock, flags);
+     }
+
      /* Establish sync by sending 32 logic ones. */
      for (i = 32; i >= 0; i--) {
            iowrite32(MDIO_ENB | MDIO_DATA_WRITE1, mdio_addr);
diff -uprN linux-2.6.10-vanilla/drivers/net/tulip/timer.c
linux-2.6.10/drivers/net/tulip/timer.c
--- linux-2.6.10-vanilla/drivers/net/tulip/timer.c    2004-12-25
05:33:47.000000000 +0800
+++ linux-2.6.10/drivers/net/tulip/timer.c      2005-01-28
10:57:14.000000000 +0800
@@ -39,6 +39,7 @@ void tulip_timer(unsigned long data)
      case MX98713:
      case COMPEX9881:
      case DM910X:
+     case ULI526X:
      default: {
            struct medialeaf *mleaf;
            unsigned char *p;
diff -uprN linux-2.6.10-vanilla/drivers/net/tulip/tulip_core.c
linux-2.6.10/drivers/net/tulip/tulip_core.c
--- linux-2.6.10-vanilla/drivers/net/tulip/tulip_core.c     2004-12-25
05:34:58.000000000 +0800
+++ linux-2.6.10/drivers/net/tulip/tulip_core.c 2005-01-28
10:57:14.000000000 +0800
@@ -197,6 +197,10 @@ struct tulip_chip_table tulip_tbl[] = {
   /* RS7112 */
   { "Conexant LANfinity", 256, 0x0001ebef,
      HAS_MII | HAS_ACPI, tulip_timer },
+
+  /* ULi526X */
+  { "ULi M5261/M5263", 128, 0x0001ebef,
+        HAS_MII | HAS_MEDIA_TABLE | CSR12_IN_SROM | HAS_ACPI, tulip_timer
},
 };


@@ -233,7 +237,8 @@ static struct pci_device_id tulip_pci_tb
      { 0x1737, 0xAB09, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMET },
      { 0x1737, 0xAB08, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMET },
      { 0x17B3, 0xAB08, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMET },
-     { 0x10b9, 0x5261, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DM910X },   /* ALi
1563 integrated ethernet */
+     { 0x10b9, 0x5261, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ULI526X },  /* ALi
1563 integrated ethernet */
+     { 0x10b9, 0x5263, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ULI526X },  /* ALi
1563 integrated ethernet */
      { 0x10b7, 0x9300, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMET }, /* 3Com
3CSOHO100B-TX */
      { } /* terminate list */
 };
@@ -514,7 +519,7 @@ static void tulip_tx_timeout(struct net_
                           dev->name);
      } else if (tp->chip_id == DC21140 || tp->chip_id == DC21142
                     || tp->chip_id == MX98713 || tp->chip_id == COMPEX9881
-                    || tp->chip_id == DM910X) {
+                    || tp->chip_id == DM910X || tp->chip_id == ULI526X) {
            printk(KERN_WARNING "%s: 21140 transmit timed out, status
%8.8x, "
                     "SIA %8.8x %8.8x %8.8x %8.8x, resetting...\n",
                     dev->name, ioread32(ioaddr + CSR5), ioread32(ioaddr +
CSR12),
@@ -1094,6 +1099,8 @@ static void set_rx_mode(struct net_devic

                  entry = tp->cur_tx++ % TX_RING_SIZE;

+                 if( !(tp->chip_id==ULI526X && (tp->revision == 0x40 ||
tp->revision == 0x50)) )
+                 {
                  if (entry != 0) {
                        /* Avoid a chip errata by prefixing a dummy entry.
*/
                        tp->tx_buffers[entry].skb = NULL;
@@ -1105,6 +1112,7 @@ static void set_rx_mode(struct net_devic
                        dummy = entry;
                        entry = tp->cur_tx++ % TX_RING_SIZE;
                  }
+                 }

                  tp->tx_buffers[entry].skb = NULL;
                  tp->tx_buffers[entry].mapping =
@@ -1304,13 +1312,13 @@ static int __devinit tulip_init_one (str

      /* DM9102A has troubles with MRM & clear reserved bits 24:22, 20, 16,
7:1 */
      if ((pdev->vendor == 0x1282 && pdev->device == 0x9102)
-           || (pdev->vendor == 0x10b9 && pdev->device == 0x5261))
+           || (pdev->vendor == 0x10b9 && (pdev->device == 0x5261 ||
pdev->device == 0x5263)))
            csr0 &= ~0x01f100ff;

 #if defined(__sparc__)
         /* DM9102A needs 32-dword alignment/burst length on sparc - chip
bug? */
      if ((pdev->vendor == 0x1282 && pdev->device == 0x9102)
-           || (pdev->vendor == 0x10b9 && pdev->device == 0x5261))
+           || (pdev->vendor == 0x10b9 && (pdev->device == 0x5261 ||
pdev->device == 0x5263)))
                 csr0 = (csr0 & ~0xff00) | 0xe000;
 #endif

@@ -1658,6 +1666,7 @@ static int __devinit tulip_init_one (str
      switch (chip_idx) {
      case DC21140:
      case DM910X:
+     case ULI526X:
      default:
            if (tp->mtable)
                  iowrite32(tp->mtable->csr12dir | 0x100, ioaddr + CSR12);
diff -uprN linux-2.6.10-vanilla/drivers/net/tulip/tulip.h
linux-2.6.10/drivers/net/tulip/tulip.h
--- linux-2.6.10-vanilla/drivers/net/tulip/tulip.h    2004-12-25
05:35:28.000000000 +0800
+++ linux-2.6.10/drivers/net/tulip/tulip.h      2005-01-28
10:57:20.000000000 +0800
@@ -88,6 +88,7 @@ enum chips {
      I21145,
      DM910X,
      CONEXANT,
+     ULI526X
 };


@@ -481,8 +482,11 @@ static inline void tulip_stop_rxtx(struc

 static inline void tulip_restart_rxtx(struct tulip_private *tp)
 {
-     tulip_stop_rxtx(tp);
-     udelay(5);
+     if(!(tp->chip_id == ULI526X &&
+           (tp->revision == 0x40 || tp->revision == 0x50))) {
+           tulip_stop_rxtx(tp);
+           udelay(5);
+     }
      tulip_start_rxtx(tp);
 }



