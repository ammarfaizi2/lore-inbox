Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268307AbUH2Umt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268307AbUH2Umt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 16:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268306AbUH2Ule
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 16:41:34 -0400
Received: from ipx10602.ipxserver.de ([80.190.249.152]:38151 "EHLO taytron.net")
	by vger.kernel.org with ESMTP id S268305AbUH2UkV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 16:40:21 -0400
From: Florian Schirmer <jolt@tuxbox.org>
To: Pekka Pietikainen <pp@ee.oulu.fi>
Subject: [PATCH][4/4] b44: Add bcm47xx support
Date: Sun, 29 Aug 2004 22:39:50 +0200
User-Agent: KMail/1.7
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
References: <200408292218.00756.jolt@tuxbox.org>
In-Reply-To: <200408292218.00756.jolt@tuxbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2900989.SpQvQGFGbN";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200408292239.53601.jolt@tuxbox.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2900989.SpQvQGFGbN
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

finally add bcm47xx support using the infrastructure created by the earlier=
 patches.

Regards,
   Florian

Signed-off-by: Florian Schirmer <jolt@tuxbox.org>


=2D-- linux/drivers/net/b44.c-old4 2004-08-29 17:24:23.000000000 +0200
+++ linux/drivers/net/b44.c 2004-08-29 18:48:45.000000000 +0200
@@ -1,7 +1,8 @@
=2D/* b44.c: Broadcom 4400 device driver.
+/* b44.c: Broadcom 4400/47xx device driver.
  *
  * Copyright (C) 2002 David S. Miller (davem@redhat.com)
=2D * Fixed by Pekka Pietikainen (pp@ee.oulu.fi)
+ * Copyright (C) 2004 Pekka Pietikainen (pp@ee.oulu.fi)
+ * Copyright (C) 2004 Florian Schirmer (jolt@tuxbox.org)
  *
  * Distribute under GPL.
  */
@@ -75,7 +76,7 @@ static char version[] __devinitdata =3D
  DRV_MODULE_NAME ".c:v" DRV_MODULE_VERSION " (" DRV_MODULE_RELDATE ")\n";
=20
 MODULE_AUTHOR("David S. Miller (davem@redhat.com)");
=2DMODULE_DESCRIPTION("Broadcom 4400 10/100 PCI ethernet driver");
+MODULE_DESCRIPTION("Broadcom 4400/47xx 10/100 PCI ethernet driver");
 MODULE_LICENSE("GPL");
 MODULE_PARM(b44_debug, "i");
 MODULE_PARM_DESC(b44_debug, "B44 bitmapped debugging message enable value"=
);
@@ -89,6 +90,8 @@ static struct pci_device_id b44_pci_tbl[
    PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
  { PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_BCM4401B1,
    PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
+ { PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_BCM4713,
+   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
  { } /* terminate list with empty entry */
 };
=20
@@ -202,29 +205,14 @@ static void ssb_core_reset(struct b44 *b
  udelay(1);
 }
=20
+static int b44_4713_instance;
+
 static int ssb_core_unit(struct b44 *bp)
 {
=2D#if 0
=2D u32 val =3D br32(B44_SBADMATCH0);
=2D u32 base;
=2D
=2D type =3D val & SBADMATCH0_TYPE_MASK;
=2D switch (type) {
=2D case 0:
=2D  base =3D val & SBADMATCH0_BS0_MASK;
=2D  break;
=2D
=2D case 1:
=2D  base =3D val & SBADMATCH0_BS1_MASK;
=2D  break;
=2D
=2D case 2:
=2D default:
=2D  base =3D val & SBADMATCH0_BS2_MASK;
=2D  break;
=2D };
=2D#endif
=2D return 0;
+ if (bp->pdev->device =3D=3D PCI_DEVICE_ID_BCM4713)
+  return b44_4713_instance++;
+ else
+  return 0;
 }
=20
 static int ssb_is_core_up(struct b44 *bp)
@@ -233,6 +221,28 @@ static int ssb_is_core_up(struct b44 *bp
   =3D=3D SBTMSLOW_CLOCK);
 }
=20
+static void __b44_cam_read(struct b44 *bp, unsigned char *data, int index)
+{
+ u32 val;
+
+ bw32(B44_CAM_CTRL, (CAM_CTRL_READ |
+       (index << CAM_CTRL_INDEX_SHIFT)));
+
+ b44_wait_bit(bp, B44_CAM_CTRL, CAM_CTRL_BUSY, 100, 1);=20
+
+ val =3D br32(B44_CAM_DATA_LO);
+
+ data[2] =3D (val >> 24) & 0xFF;
+ data[3] =3D (val >> 16) & 0xFF;
+ data[4] =3D (val >> 8) & 0xFF;
+ data[5] =3D (val >> 0) & 0xFF;
+
+ val =3D br32(B44_CAM_DATA_HI);
+=20
+ data[0] =3D (val >> 8) & 0xFF;
+ data[1] =3D (val >> 0) & 0xFF;
+}
+
 static void __b44_cam_write(struct b44 *bp, unsigned char *data, int index)
 {
  u32 val;
@@ -1110,6 +1120,8 @@ static void b44_clear_stats(struct b44 *
 /* bp->lock is held. */
 static void b44_chip_reset(struct b44 *bp)
 {
+ unsigned int sb_clock;
+
  if (ssb_is_core_up(bp)) {
   bw32(B44_RCV_LAZY, 0);
   bw32(B44_ENET_CTRL, ENET_CTRL_DISABLE);
@@ -1123,9 +1135,10 @@ static void b44_chip_reset(struct b44 *b
   bw32(B44_DMARX_CTRL, 0);
   bp->rx_prod =3D bp->rx_cons =3D 0;
  } else {
=2D  ssb_pci_setup(bp, (bp->core_unit =3D=3D 0 ?
=2D       SBINTVEC_ENET0 :
=2D       SBINTVEC_ENET1));
+  if (bp->pdev->device !=3D PCI_DEVICE_ID_BCM4713)
+   ssb_pci_setup(bp, (bp->core_unit =3D=3D 0 ?
+        SBINTVEC_ENET0 :
+        SBINTVEC_ENET1));
  }
=20
  ssb_core_reset(bp);
@@ -1133,8 +1146,14 @@ static void b44_chip_reset(struct b44 *b
  b44_clear_stats(bp);
=20
  /* Make PHY accessible. */
+ if (bp->pdev->device =3D=3D PCI_DEVICE_ID_BCM4713)
+  sb_clock =3D 100000000; /* 100 MHz */
+ else
+  sb_clock =3D 62500000; /* 62.5 MHz */
+
  bw32(B44_MDIO_CTRL, (MDIO_CTRL_PREAMBLE |
=2D        (0x0d & MDIO_CTRL_MAXF_MASK)));
+        (((sb_clock + (B44_MDC_RATIO / 2)) / B44_MDC_RATIO)
+        & MDIO_CTRL_MAXF_MASK)));
  br32(B44_MDIO_CTRL);
=20
  if (!(br32(B44_DEVCTRL) & DEVCTRL_IPP)) {
@@ -1654,19 +1673,41 @@ static int __devinit b44_get_invariants(
 {
  u8 eeprom[128];
  int err;
+ unsigned long flags;
=20
=2D err =3D b44_read_eeprom(bp, &eeprom[0]);
=2D if (err)
=2D  goto out;
=2D
=2D bp->dev->dev_addr[0] =3D eeprom[79];
=2D bp->dev->dev_addr[1] =3D eeprom[78];
=2D bp->dev->dev_addr[2] =3D eeprom[81];
=2D bp->dev->dev_addr[3] =3D eeprom[80];
=2D bp->dev->dev_addr[4] =3D eeprom[83];
=2D bp->dev->dev_addr[5] =3D eeprom[82];
=2D
=2D bp->phy_addr =3D eeprom[90] & 0x1f;
+ if (bp->pdev->device =3D=3D PCI_DEVICE_ID_BCM4713) {
+  /*=20
+   * BCM47xx boards don't have a EEPROM. The MAC is stored in
+   * a NVRAM area somewhere in the flash memory. As we don't
+   * know the location and/or the format of the NVRAM area
+   * here, we simply rely on the bootloader to write the
+   * MAC into the CAM.
+   */
+  spin_lock_irqsave(&bp->lock, flags);
+  __b44_cam_read(bp, bp->dev->dev_addr, 0);
+  spin_unlock_irqrestore(&bp->lock, flags);
+
+  /*=20
+   * BCM47xx boards don't have a PHY. Usually there is a switch
+   * chip with multiple PHYs connected to the PHY port.
+   */
+  bp->phy_addr =3D B44_PHY_ADDR_NO_PHY;
+  bp->dma_offset =3D 0;
+ } else {
+  err =3D b44_read_eeprom(bp, &eeprom[0]);
+  if (err)
+   return err;
+
+  bp->dev->dev_addr[0] =3D eeprom[79];
+  bp->dev->dev_addr[1] =3D eeprom[78];
+  bp->dev->dev_addr[2] =3D eeprom[81];
+  bp->dev->dev_addr[3] =3D eeprom[80];
+  bp->dev->dev_addr[4] =3D eeprom[83];
+  bp->dev->dev_addr[5] =3D eeprom[82];
+
+  bp->phy_addr =3D eeprom[90] & 0x1f;
+  bp->dma_offset =3D SB_PCI_DMA;
+ }=20
=20
  /* With this, plus the rx_header prepended to the data by the
   * hardware, we'll land the ethernet header on a 2-byte boundary.
@@ -1676,13 +1717,12 @@ static int __devinit b44_get_invariants(
  bp->imask =3D IMASK_DEF;
=20
  bp->core_unit =3D ssb_core_unit(bp);
=2D bp->dma_offset =3D SB_PCI_DMA;
=20
  /* XXX - really required?=20
     bp->flags |=3D B44_FLAG_BUGGY_TXPTR;
          */
=2Dout:
=2D return err;
+
+ return 0;
 }
=20
 static int __devinit b44_init_one(struct pci_dev *pdev,
@@ -1811,7 +1851,8 @@ static int __devinit b44_init_one(struct
=20
  pci_save_state(bp->pdev, bp->pci_cfg_state);
=20
=2D printk(KERN_INFO "%s: Broadcom 4400 10/100BaseT Ethernet ", dev->name);
+ printk(KERN_INFO "%s: Broadcom %s 10/100BaseT Ethernet ", dev->name,
+  (pdev->device =3D=3D PCI_DEVICE_ID_BCM4713) ? "47xx" : "4400");
  for (i =3D 0; i < 6; i++)
   printk("%2.2x%c", dev->dev_addr[i],
          i =3D=3D 5 ? '\n' : ':');
=2D-- linux/drivers/net/b44.h-old4 2004-08-29 17:24:53.000000000 +0200
+++ linux/drivers/net/b44.h 2004-08-29 18:42:56.000000000 +0200
@@ -363,6 +363,7 @@ struct ring_info {
=20
 #define B44_MCAST_TABLE_SIZE 32
 #define B44_PHY_ADDR_NO_PHY 30
+#define B44_MDC_RATIO  5000000
=20
 /* SW copy of device statistics, kept up to date by periodic timer
  * which probes HW values.  Must have same relative layout as HW


--nextPart2900989.SpQvQGFGbN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBMj8ZXRF2vHoIlBsRAg5hAKCZeRnTtZq/RAKJqbXhy2rSvpal8ACguam3
PYdcWx3/uhC3PJ5ctmFqYkI=
=Iq4P
-----END PGP SIGNATURE-----

--nextPart2900989.SpQvQGFGbN--
