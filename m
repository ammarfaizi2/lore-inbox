Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264254AbTKZRK1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 12:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264257AbTKZRK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 12:10:27 -0500
Received: from eva.fit.vutbr.cz ([147.229.10.14]:45828 "EHLO eva.fit.vutbr.cz")
	by vger.kernel.org with ESMTP id S264254AbTKZRJ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 12:09:58 -0500
Date: Wed, 26 Nov 2003 18:09:51 +0100
From: David Jez <dave.jez@seznam.cz>
To: davej@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [patch] AGP3 experimental support
Message-ID: <20031126170951.GA14887@stud.fit.vutbr.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RASg3xLB4tUQ4RcS"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RASg3xLB4tUQ4RcS
Content-Type: multipart/mixed; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

  Hi,

  this is port of AGP3 support from 2.6.0-test9. I ported _agp3 functions a=
nd
rewrite via_generic_setup(). It seems working, but mybe is necessary to che=
ck
AGP3 tests and rewrite agp_generic_enable() function.
  Sugestions are welcome.
Regards,
--=20
-------------------------------------------------------
  David "Dave" Jez                Brno, CZ, Europe
 E-mail: dave.jez@seznam.cz
PGP key: finger xjezda00@eva.fit.vutbr.cz
---------=3D[ ~EOF ]=3D------------------------------------

--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="agpgart-agp3.diff"
Content-Transfer-Encoding: quoted-printable


 linux/drivers/char/agp/agp.h        |    9 +++++++++
 linux/drivers/char/agp/agpgart_be.c |  147 +++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++++---
 2 files changed, 153 insertions(+), 3 deletions(-)

diff -urN linux.orig/drivers/char/agp/agp.h linux/drivers/char/agp/agp.h
--- linux.orig/drivers/char/agp/agp.h	Mon Nov 24 16:19:35 2003
+++ linux/drivers/char/agp/agp.h	Mon Nov 24 19:57:36 2003
@@ -332,6 +332,9 @@
 #define PCI_DEVICE_ID_ATI_RS300_200	0x5833
 #endif
=20
+/* Chipset independant registers (from AGP Spec) */
+#define AGP_APBASE      0x10
+
 /* intel register */
 #define INTEL_APBASE    0x10
 #define INTEL_APSIZE    0xb4
@@ -442,6 +445,12 @@
 #define VIA_GARTCTRL    0x80
 #define VIA_APSIZE      0x84
 #define VIA_ATTBASE     0x88
+
+/* VIA KT400 */
+#define VIA_AGP3_GARTCTRL       0x90
+#define VIA_AGP3_APSIZE         0x94
+#define VIA_AGP3_ATTBASE        0x98
+#define VIA_AGPSEL              0xfd
=20
 /* SiS registers */
 #define SIS_APBASE      0x10
diff -urN linux.orig/drivers/char/agp/agpgart_be.c linux/drivers/char/agp/a=
gpgart_be.c
--- linux.orig/drivers/char/agp/agpgart_be.c	Mon Nov 24 16:20:07 2003
+++ linux/drivers/char/agp/agpgart_be.c	Mon Nov 24 19:58:30 2003
@@ -2790,6 +2790,72 @@
=20
 #ifdef CONFIG_AGP_VIA
=20
+static int via_fetch_size_agp3(void)
+{
+	int i;
+	u16 temp;
+	aper_size_info_16 *values;
+
+	values =3D A_SIZE_16(agp_bridge.aperture_sizes);
+	pci_read_config_word(agp_bridge.dev, VIA_AGP3_APSIZE, &temp);
+	temp &=3D 0xfff;
+
+	for (i =3D 0; i < agp_bridge.num_aperture_sizes; i++) {
+		if (temp =3D=3D values[i].size_value) {
+			agp_bridge.previous_size =3D
+			    agp_bridge.current_size =3D (void *) (values + i);
+			agp_bridge.aperture_size_idx =3D i;
+			return values[i].size;
+		}
+	}
+	return 0;
+}
+
+static int via_configure_agp3(void)
+{
+	u32 temp;
+	aper_size_info_16 *current_size;
+
+	current_size =3D A_SIZE_16(agp_bridge.current_size);
+
+	/* address to map too */
+	pci_read_config_dword(agp_bridge.dev, AGP_APBASE, &temp);
+	agp_bridge.gart_bus_addr =3D (temp & PCI_BASE_ADDRESS_MEM_MASK);
+
+	/* attbase - aperture GATT base */
+	pci_write_config_dword(agp_bridge.dev, VIA_AGP3_ATTBASE,
+		agp_bridge.gatt_bus_addr & 0xfffff000);
+
+	/* 1. Enable GTLB in RX90<7>, all AGP aperture access needs to fetch
+	 *    translation table first.
+	 * 2. Enable AGP aperture in RX91<0>. This bit controls the enabling of
+the
+	 *    graphics AGP aperture for the AGP3.0 port.
+	 */
+	pci_read_config_dword(agp_bridge.dev, VIA_AGP3_GARTCTRL, &temp);
+	pci_write_config_dword(agp_bridge.dev, VIA_AGP3_GARTCTRL,
+		temp | (3<<7));
+	return 0;
+}
+
+static void via_cleanup_agp3(void)
+{
+	aper_size_info_16 *previous_size;
+
+	previous_size =3D A_SIZE_16(agp_bridge.previous_size);
+	pci_write_config_byte(agp_bridge.dev, VIA_APSIZE,
+		previous_size->size_value);
+}
+static void via_tlbflush_agp3(agp_memory *mem)
+{
+        u32 temp;
+
+        pci_read_config_dword(agp_bridge.dev, VIA_AGP3_GARTCTRL, &temp);
+        pci_write_config_dword(agp_bridge.dev, VIA_AGP3_GARTCTRL,
+		temp & ~(1<<7));
+        pci_write_config_dword(agp_bridge.dev, VIA_AGP3_GARTCTRL, temp);
+}
+
 static int via_fetch_size(void)
 {
 	int i;
@@ -2857,6 +2923,20 @@
 	return addr | agp_bridge.masks[0].mask;
 }
=20
+static aper_size_info_16 via_generic_agp3_sizes[11] =3D
+{
+	{ 4,     1024,  0, 1<<11|1<<10|1<<9|1<<8|1<<5|1<<4|1<<3|1<<2|1<<1|1<<0 },
+	{ 8,     2048,  1, 1<<11|1<<10|1<<9|1<<8|1<<5|1<<4|1<<3|1<<2|1<<1},
+	{ 16,    4096,  2, 1<<11|1<<10|1<<9|1<<8|1<<5|1<<4|1<<3|1<<2},
+	{ 32,    8192,  3, 1<<11|1<<10|1<<9|1<<8|1<<5|1<<4|1<<3},
+	{ 64,   16384,  4, 1<<11|1<<10|1<<9|1<<8|1<<5|1<<4},
+	{ 128,  32768,  5, 1<<11|1<<10|1<<9|1<<8|1<<5},
+	{ 256,  65536,  6, 1<<11|1<<10|1<<9|1<<8},
+	{ 512,  131072, 7, 1<<11|1<<10|1<<9},
+	{ 1024, 262144, 8, 1<<11|1<<10},
+	{ 2048, 524288, 9, 1<<11}	/* 2GB <- Max supported */
+};
+
 static aper_size_info_8 via_generic_sizes[7] =3D
 {
 	{256, 65536, 6, 0},
@@ -2873,8 +2953,72 @@
 	{0x00000000, 0}
 };
=20
+static int __init via_generic_setup_agp3 (struct pci_dev *pdev)
+{
+	agp_bridge.masks =3D via_generic_masks;
+	agp_bridge.aperture_sizes =3D (void *) via_generic_agp3_sizes;
+	agp_bridge.size_type =3D U8_APER_SIZE;
+	agp_bridge.num_aperture_sizes =3D 10;
+	agp_bridge.dev_private_data =3D NULL;
+	agp_bridge.needs_scratch_page =3D FALSE;
+	agp_bridge.configure =3D via_configure_agp3;
+	agp_bridge.fetch_size =3D via_fetch_size_agp3;
+	agp_bridge.cleanup =3D via_cleanup_agp3;
+	agp_bridge.tlb_flush =3D via_tlbflush_agp3;
+	agp_bridge.mask_memory =3D via_mask_memory;
+	agp_bridge.agp_enable =3D agp_generic_agp_enable;
+	agp_bridge.cache_flush =3D global_cache_flush;
+	agp_bridge.create_gatt_table =3D agp_generic_create_gatt_table;
+	agp_bridge.free_gatt_table =3D agp_generic_free_gatt_table;
+	agp_bridge.insert_memory =3D agp_generic_insert_memory;
+	agp_bridge.remove_memory =3D agp_generic_remove_memory;
+	agp_bridge.alloc_by_type =3D agp_generic_alloc_by_type;
+	agp_bridge.free_by_type =3D agp_generic_free_by_type;
+	agp_bridge.agp_alloc_page =3D agp_generic_alloc_page;
+	agp_bridge.agp_destroy_page =3D agp_generic_destroy_page;
+	agp_bridge.suspend =3D agp_generic_suspend;
+	agp_bridge.resume =3D agp_generic_resume;
+	agp_bridge.cant_use_aperture =3D 0;
+	return 0;
+}
+
+/*
+ * VIA's AGP3 chipsets do magick to put the AGP bridge compliant
+ * with the same standards version as the graphics card.
+ */
+static void check_via_agp3 (struct pci_dev *pdev)
+{
+        u8 reg;
+
+        pci_read_config_byte(pdev, VIA_AGPSEL, &reg);
+        /* Check AGP 2.0 compatibility mode. */
+        if ((reg & (1<<1))=3D=3D0)
+                via_generic_setup_agp3(pdev);
+}
+
 static int __init via_generic_setup (struct pci_dev *pdev)
 {
+	u32 reg;
+
+        /*
+         * Garg, there are KT400s with KT266 IDs.
+         */
+        if (pdev->device =3D=3D PCI_DEVICE_ID_VIA_8367_0) {
+                /* Is there a KT400 subsystem ? */
+                if (pdev->subsystem_device =3D=3D PCI_DEVICE_ID_VIA_8377_0=
) {
+                        printk(KERN_INFO PFX "Found KT400 in disguise as a=
 KT266.\n");
+                        check_via_agp3(pdev);
+			return 0;
+                }
+        }
+
+        /* If this is an AGP3 bridge, check which mode its in and adjust. =
*/
+	pci_read_config_dword(pdev, VIA_AGPSEL, &reg);
+        if (((reg >> 20) & 0xf) >=3D 3) {
+                check_via_agp3(pdev);
+		return 0;
+	}
+
 	agp_bridge.masks =3D via_generic_masks;
 	agp_bridge.aperture_sizes =3D (void *) via_generic_sizes;
 	agp_bridge.size_type =3D U8_APER_SIZE;
@@ -2899,10 +3043,7 @@
 	agp_bridge.suspend =3D agp_generic_suspend;
 	agp_bridge.resume =3D agp_generic_resume;
 	agp_bridge.cant_use_aperture =3D 0;
-
 	return 0;
-=09
-	(void) pdev; /* unused */
 }
=20
 #endif /* CONFIG_AGP_VIA */

--bg08WKrSYDhXBjb5--

--RASg3xLB4tUQ4RcS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/xN5dr2Hs6iMo1GgRAhObAJ0b5JPAMyNIWtaf260Qhse+zZC4swCfbRVc
Mw5eHMUIg63bz3fgyP4p9s0=
=fkhr
-----END PGP SIGNATURE-----

--RASg3xLB4tUQ4RcS--
