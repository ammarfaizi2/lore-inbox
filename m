Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275841AbRJFXsE>; Sat, 6 Oct 2001 19:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275848AbRJFXr4>; Sat, 6 Oct 2001 19:47:56 -0400
Received: from SSH.ChaoticDreams.ORG ([64.162.95.164]:34234 "EHLO
	ssh.chaoticdreams.org") by vger.kernel.org with ESMTP
	id <S275841AbRJFXro>; Sat, 6 Oct 2001 19:47:44 -0400
Date: Sat, 6 Oct 2001 16:47:34 -0700
From: Paul Mundt <lethal@ChaoticDreams.ORG>
To: Robert Love <rml@tech9.net>
Cc: David Weinehall <tao@acc.umu.se>,
        Christof Efkemann <efkemann@uni-bremen.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Intel 830 support for agpgart
Message-ID: <20011006164734.B26380@ChaoticDreams.ORG>
In-Reply-To: <20011002033227.6e047544.efkemann@uni-bremen.de> <1001988137.2780.53.camel@phantasy> <20011002151051.488306ee.efkemann@uni-bremen.de> <1002066345.1003.66.camel@phantasy> <20011003021658.O7800@khan.acc.umu.se> <1002075650.1237.2.camel@phantasy>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="NU0Ex4SbNnrxsi6C"
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <1002075650.1237.2.camel@phantasy>; from rml@tech9.net on Tue, Oct 02, 2001 at 10:20:43PM -0400
Organization: Chaotic Dreams Development Team
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NU0Ex4SbNnrxsi6C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 02, 2001 at 10:20:43PM -0400, Robert Love wrote:
> I suppose we could, and this is a good idea -- although we'd be
> reapproaching the size of the current implementation which would be
> theoretically faster, too.
>=20
> There are only 3 possibilities right now (i830, i840, and everything
> else).
>=20
Make that i830, i840, i850, i860 and everything else. A better way for
dealing with specialized configure routines for these various chipsets
would definately seem to be in order. Between i840/i850/i860, there's
very little difference except for what bits to clear in the ERRSTS register.

It would be nice to be able to get the 840/850/860 down to just a few lines
of code a peice instead of this huge overlap of generic routines thats
happening currently.

Here's a patch for i860..

Regards,

--=20
Paul Mundt <lethal@chaoticdreams.org>


--NU0Ex4SbNnrxsi6C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.4.10-i860-agpgart.diff"
Content-Transfer-Encoding: quoted-printable

diff -urN linux.orig/drivers/char/Config.in linux/drivers/char/Config.in
--- linux.orig/drivers/char/Config.in	Sun Sep 23 12:52:38 2001
+++ linux/drivers/char/Config.in	Fri Oct  5 16:40:16 2001
@@ -205,7 +205,7 @@
=20
 dep_tristate '/dev/agpgart (AGP Support)' CONFIG_AGP $CONFIG_DRM_AGP
 if [ "$CONFIG_AGP" !=3D "n" ]; then
-   bool '  Intel 440LX/BX/GX and I815/I840/I850 support' CONFIG_AGP_INTEL
+   bool '  Intel 440LX/BX/GX and I815/I840/I850/I860 support' CONFIG_AGP_I=
NTEL
    bool '  Intel I810/I815 (on-board) support' CONFIG_AGP_I810
    bool '  VIA chipset support' CONFIG_AGP_VIA
    bool '  AMD Irongate, 761, and 762 support' CONFIG_AGP_AMD
diff -urN linux.orig/drivers/char/agp/agp.h linux/drivers/char/agp/agp.h
--- linux.orig/drivers/char/agp/agp.h	Sun Sep 23 12:52:38 2001
+++ linux/drivers/char/agp/agp.h	Fri Oct  5 16:52:00 2001
@@ -172,6 +172,9 @@
 #ifndef PCI_DEVICE_ID_INTEL_850_0
 #define PCI_DEVICE_ID_INTEL_850_0     0x2530
 #endif
+#ifndef PCI_DEVICE_ID_INTEL_860_0
+#define PCI_DEVICE_ID_INTEL_860_0	0x2532
+#endif
 #ifndef PCI_DEVICE_ID_INTEL_810_DC100_0
 #define PCI_DEVICE_ID_INTEL_810_DC100_0 0x7122
 #endif
@@ -248,6 +251,10 @@
 /* intel i850 registers */
 #define INTEL_I850_MCHCFG   0x50
 #define INTEL_I850_ERRSTS   0xc8
+
+/* intel i860 registers */
+#define INTEL_I860_MCHCFG	0x50
+#define INTEL_I860_ERRSTS	0xc8
=20
 /* intel i810 registers */
 #define I810_GMADDR 0x10
diff -urN linux.orig/drivers/char/agp/agpgart_be.c linux/drivers/char/agp/a=
gpgart_be.c
--- linux.orig/drivers/char/agp/agpgart_be.c	Sun Sep 23 12:52:38 2001
+++ linux/drivers/char/agp/agpgart_be.c	Fri Oct  5 17:14:09 2001
@@ -387,7 +387,7 @@
 /*=20
  * Driver routines - start
  * Currently this module supports the following chipsets:
- * i810, i815, 440lx, 440bx, 440gx, i840, i850, via vp3, via mvp3,
+ * i810, i815, 440lx, 440bx, 440gx, i840, i850, i860, via vp3, via mvp3,
  * via kx133, via kt133, amd irongate, amd 761, amd 762, ALi M1541,
  * and generic support for the SiS chipsets.
  */
@@ -1252,6 +1252,38 @@
 	return 0;
 }
=20
+static int intel_860_configure(void)
+{
+	u32 temp;
+	u16 temp2;
+	aper_size_info_16 *current_size;
+
+	current_size =3D A_SIZE_16(agp_bridge.current_size);
+
+	/* aperture size */
+	pci_write_config_byte(agp_bridge.dev, INTEL_APSIZE,
+			      (char)current_size->size_value);
+
+	/* address to map to */
+	pci_read_config_dword(agp_bridge.dev, INTEL_APBASE, &temp);
+	agp_bridge.gart_bus_addr =3D (temp & PCI_BASE_ADDRESS_MEM_MASK);
+
+	/* attbase - aperture base */
+	pci_write_config_dword(agp_bridge.dev, INTEL_ATTBASE,
+			       agp_bridge.gatt_bus_addr);
+
+	/* agpctrl */
+	pci_write_config_dword(agp_bridge.dev, INTEL_AGPCTRL, 0x0000);
+
+	/* mcgcfg */
+	pci_read_config_word(agp_bridge.dev, INTEL_I860_MCHCFG, &temp2);
+	pci_write_config_word(agp_bridge.dev, INTEL_I860_MCHCFG,
+			      temp2 | (1 << 9));
+	/* clear any possible AGP-related error conditions */
+	pci_write_config_word(agp_bridge.dev, INTEL_I860_ERRSTS, 0xf700);
+	return 0;
+}
+
 static unsigned long intel_mask_memory(unsigned long addr, int type)
 {
 	/* Memory type is ignored */
@@ -1380,6 +1412,39 @@
 	(void) pdev; /* unused */
 }
=20
+static int __init intel_860_setup (struct pci_dev *pdev)
+{
+	agp_bridge.masks =3D intel_generic_masks;
+	agp_bridge.num_of_masks =3D 1;
+	agp_bridge.aperture_sizes =3D (void *) intel_generic_sizes;
+	agp_bridge.size_type =3D U16_APER_SIZE;
+	agp_bridge.num_aperture_sizes =3D 7;
+	agp_bridge.dev_private_data =3D NULL;
+	agp_bridge.needs_scratch_page =3D FALSE;
+	agp_bridge.configure =3D intel_860_configure;
+	agp_bridge.fetch_size =3D intel_fetch_size;
+	agp_bridge.cleanup =3D intel_cleanup;
+	agp_bridge.tlb_flush =3D intel_tlbflush;
+	agp_bridge.mask_memory =3D intel_mask_memory;
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
+
+	return 0;
+
+	(void) pdev; /* unused */
+}
+
 #endif /* CONFIG_AGP_INTEL */
=20
 #ifdef CONFIG_AGP_VIA
@@ -2988,6 +3053,12 @@
 	        "Intel",
 	        "i850",
 	        intel_850_setup },
+	{ PCI_DEVICE_ID_INTEL_860_0,
+		PCI_VENDOR_ID_INTEL,
+		INTEL_I860,
+		"Intel",
+		"i860",
+		intel_860_setup },
 	{ 0,
 		PCI_VENDOR_ID_INTEL,
 		INTEL_GENERIC,
diff -urN linux.orig/include/linux/agp_backend.h linux/include/linux/agp_ba=
ckend.h
--- linux.orig/include/linux/agp_backend.h	Sun Sep 23 12:52:38 2001
+++ linux/include/linux/agp_backend.h	Fri Oct  5 16:44:22 2001
@@ -48,6 +48,7 @@
 	INTEL_I815,
 	INTEL_I840,
 	INTEL_I850,
+	INTEL_I860,
 	VIA_GENERIC,
 	VIA_VP3,
 	VIA_MVP3,

--NU0Ex4SbNnrxsi6C--
