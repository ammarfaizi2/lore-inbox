Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbTEKAgq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 20:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261787AbTEKAgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 20:36:46 -0400
Received: from fronta-d.sezampro.yu ([194.106.188.51]:22027 "HELO
	fronta-d.sezampro.yu") by vger.kernel.org with SMTP id S261741AbTEKAgj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 20:36:39 -0400
From: Toplica =?utf-8?q?Tanaskovi=C4=87?= <toptan@sezampro.yu>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.21-rc2 Radeon 9000 fb update
Date: Sun, 11 May 2003 02:47:04 +0200
User-Agent: KMail/1.5.1
Cc: marcelo@conectiva.com.br
MIME-Version: 1.0
Message-Id: <200305110240.36869.toptan@sezampro.yu>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_I2Zv+cztXpcVwer"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_I2Zv+cztXpcVwer
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

	This patch adds RV250 Radeon 9000 if ID to framebuffer driver, and fixes b=
ug=20
in radeonfb.c for Radeon PM in radeonfb_pci_register (missing break in case=
).

	Marcello, please apply.
=2D-=20
Best wishes,
Tanaskovi=C4=87 Toplica











--Boundary-00=_I2Zv+cztXpcVwer
Content-Type: text/x-diff;
  charset="utf-8";
  name="radeon_fb.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="radeon_fb.diff"

diff -ruN orig/linux-2.4.21-rc2/drivers/video/radeonfb.c linux-2.4.21-rc2/d=
rivers/video/radeonfb.c
=2D-- orig/linux-2.4.21-rc2/drivers/video/radeonfb.c	2003-05-11 01:24:04.00=
0000000 +0200
+++ linux-2.4.21-rc2/drivers/video/radeonfb.c	2003-05-11 01:42:11.000000000=
 +0200
@@ -101,7 +101,8 @@
 	RADEON_LW,	/* Radeon Mobility M7 */
 	RADEON_LY,	/* Radeon Mobility M6 */
 	RADEON_LZ,	/* Radeon Mobility M6 */
=2D	RADEON_PM	/* Radeon Mobility P/M */
+	RADEON_PM,	/* Radeon Mobility P/M */
+	RADEON_IF	/* Radeon RV250 (9000) */
 };
=20
=20
@@ -129,6 +130,7 @@
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_RADEON_LY, PCI_ANY_ID, PCI_ANY_ID, 0, =
0, RADEON_LY},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_RADEON_LZ, PCI_ANY_ID, PCI_ANY_ID, 0, =
0, RADEON_LZ},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_RADEON_PM, PCI_ANY_ID, PCI_ANY_ID, 0, =
0, RADEON_PM},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_RADEON_IF, PCI_ANY_ID, PCI_ANY_ID, 0, =
0, RADEON_IF},
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, radeonfb_pci_table);
@@ -861,6 +863,11 @@
 	        case PCI_DEVICE_ID_RADEON_PM:
 			strcpy(rinfo->name, "Radeon P/M ");
 			rinfo->hasCRTC2 =3D 1;
+			break;
+		case PCI_DEVICE_ID_RADEON_IF:
+			strcpy(rinfo->name, "Radeon 9000 ");
+			rinfo->hasCRTC2 =3D 1;
+			break;
 		default:
 			return -ENODEV;
 	}
@@ -893,7 +900,7 @@
 			rinfo->ram.cl =3D 2;
 			rinfo->ram.loop_latency =3D 16;
 			rinfo->ram.rloop =3D 16;
=2D=09
+
 			break;
 		case 1:
 			/* DDR SGRAM */
@@ -1053,18 +1060,18 @@
 static void __devexit radeonfb_pci_unregister (struct pci_dev *pdev)
 {
         struct radeonfb_info *rinfo =3D pci_get_drvdata(pdev);
=2D=20
+
         if (!rinfo)
                 return;
=2D=20
+
 	/* restore original state */
         radeon_write_mode (rinfo, &rinfo->init_state);
=2D=20
+
         unregister_framebuffer ((struct fb_info *) rinfo);
=2D               =20
+
         iounmap ((void*)rinfo->mmio_base);
         iounmap ((void*)rinfo->fb_base);
=2D=20
+
 	release_mem_region (rinfo->mmio_base_phys,
 			    pci_resource_len(pdev, 2));
 	release_mem_region (rinfo->fb_base_phys,
diff -ruN orig/linux-2.4.21-rc2/drivers/video/radeon.h linux-2.4.21-rc2/dri=
vers/video/radeon.h
=2D-- orig/linux-2.4.21-rc2/drivers/video/radeon.h	2003-05-11 02:21:56.0000=
00000 +0200
+++ linux-2.4.21-rc2/drivers/video/radeon.h	2003-05-11 01:36:07.000000000 +=
0200
@@ -9,6 +9,7 @@
 #define PCI_DEVICE_ID_RADEON_QG		0x5147
 #define PCI_DEVICE_ID_RADEON_QY		0x5159
 #define PCI_DEVICE_ID_RADEON_QZ		0x515a
+#define PCI_DEVICE_ID_RADEON_IF		0x4966
 #define PCI_DEVICE_ID_RADEON_LW		0x4c57
 #define PCI_DEVICE_ID_RADEON_LY		0x4c59
 #define PCI_DEVICE_ID_RADEON_LZ		0x4c5a

--Boundary-00=_I2Zv+cztXpcVwer--


