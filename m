Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272882AbTG3N4F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 09:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272881AbTG3N4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 09:56:05 -0400
Received: from ifi.informatik.uni-stuttgart.de ([129.69.211.1]:56266 "EHLO
	ifi.informatik.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id S272883AbTG3Nz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 09:55:56 -0400
Date: Wed, 30 Jul 2003 15:55:54 +0200
From: "Marcelo E. Magallon" <marcelo.magallon@bigfoot.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] [2.4] AGPGART support for intel 7205/7505 chipsets
Message-ID: <20030730135554.GA9232@informatik.uni-stuttgart.de>
Mail-Followup-To: "Marcelo E. Magallon" <marcelo.magallon@bigfoot.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
X-Operating-System: Linux techno 2.4.21-ck1
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

 please Cc: mmagallo@debian.org, I'm not subscribed to the list.

 [ sorry about the duplicate, I forgot the patch ... obviously ]

 Attached is a small backport from 2.6 to 2.4 to add support for Intel's
 7205 and 7505 chipsets.  The patch has been tested and works using
 NVIDIA's binary-only drivers with a GeForce 4200 in AGP 8x mode.  We
 haven't been able to get a Radeon card to work yet.  The last version
 of the kernel that I've used for testing is 2.4.22-pre6-ac1.

 The machine where this has been tested has 4 GB of RAM installed and
 the kernel sets up, right after booting, 8 MTRR regions leaving none
 for the AGP aperture or the graphics card memory.  In that situation
 the NVIDIA driver fails to set up AGP properly and disables it
 altogether.  The last two regions look like this:

reg06: base=0x400000000 (16384MB), size=16384MB: write-back, count=1
reg07: base=0x800000000 (32768MB), size=32768MB: write-back, count=1

 by disabling them and then starting the X server everything works fine.

 Cheers,

 Marcelo

--IS0zKkzwUGydFO0o
Content-Type: video/x-dv
Content-Disposition: attachment; filename="linux-2.4.21_15_agpgart.dif"
Content-Transfer-Encoding: quoted-printable

diff -ruN linux-2.4.21/drivers/char/agp/agp.h linux-2.4.22-pre4+p4/drivers/=
char/agp/agp.h=0A--- linux-2.4.21/drivers/char/agp/agp.h	2003-07-15 11:38:5=
0.000000000 +0200=0A+++ linux-2.4.22-pre4+p4/drivers/char/agp/agp.h	2003-07=
-15 11:28:34.000000000 +0200=0A@@ -223,6 +223,12 @@=0A #ifndef PCI_DEVICE_I=
D_INTEL_860_0=0A #define PCI_DEVICE_ID_INTEL_860_0     0x2531=0A #endif=0A+=
#ifndef PCI_DEVICE_ID_INTEL_7205_0=0A+#define PCI_DEVICE_ID_INTEL_7205_0   =
  0x255d=0A+#endif=0A+#ifndef PCI_DEVICE_ID_INTEL_7505_0=0A+#define PCI_DEV=
ICE_ID_INTEL_7505_0     0x2550=0A+#endif=0A #ifndef PCI_DEVICE_ID_INTEL_810=
_DC100_0=0A #define PCI_DEVICE_ID_INTEL_810_DC100_0 0x7122=0A #endif=0A@@ -=
366,6 +372,10 @@=0A #define INTEL_I860_MCHCFG	0x50=0A #define INTEL_I860_ER=
RSTS	0xc8=0A =0A+/* intel i7505 registers */=0A+#define INTEL_I7505_MCHCFG	=
0x50=0A+#define INTEL_I7505_ERRSTS	0x42=0A+=0A /* intel i810 registers */=
=0A #define I810_GMADDR 0x10=0A #define I810_MMADDR 0x14=0Adiff -ruN linux-=
2.4.21/drivers/char/agp/agpgart_be.c linux-2.4.22-pre4+p4/drivers/char/agp/=
agpgart_be.c=0A--- linux-2.4.21/drivers/char/agp/agpgart_be.c	2003-07-15 11=
:38:50.000000000 +0200=0A+++ linux-2.4.22-pre4+p4/drivers/char/agp/agpgart_=
be.c	2003-07-15 11:31:11.000000000 +0200=0A@@ -1817,6 +1817,37 @@=0A }=0A =
=0A =0A+static int intel_7505_configure(void)=0A+{=0A+	u32 temp;=0A+	u16 te=
mp2;=0A+	aper_size_info_8 *current_size;=0A+=0A+	current_size =3D A_SIZE_8(=
agp_bridge.current_size);=0A+=0A+	/* aperture size */=0A+	pci_write_config_=
byte(agp_bridge.dev, INTEL_APSIZE,=0A+			      current_size->size_value);=
=0A+=0A+	/* address to map to */=0A+	pci_read_config_dword(agp_bridge.dev, =
INTEL_APBASE, &temp);=0A+	agp_bridge.gart_bus_addr =3D (temp & PCI_BASE_ADD=
RESS_MEM_MASK);=0A+=0A+	/* attbase - aperture base */=0A+	pci_write_config_=
dword(agp_bridge.dev, INTEL_ATTBASE,=0A+			       agp_bridge.gatt_bus_addr)=
;=0A+=0A+	/* agpctrl */=0A+	pci_write_config_dword(agp_bridge.dev, INTEL_AG=
PCTRL, 0x0000);=0A+=0A+	/* mcgcfg */=0A+	pci_read_config_word(agp_bridge.de=
v, INTEL_I7505_MCHCFG, &temp2);=0A+	pci_write_config_word(agp_bridge.dev, I=
NTEL_I7505_MCHCFG,=0A+			      temp2 | (1 << 9));=0A+	return 0;=0A+}=0A+=0A=
+=0A static unsigned long intel_mask_memory(unsigned long addr, int type)=
=0A {=0A 	/* Memory type is ignored */=0A@@ -2126,6 +2157,38 @@=0A 	(void) =
pdev; /* unused */=0A }=0A =0A+static int __init intel_7505_setup (struct p=
ci_dev *pdev)=0A+{=0A+	agp_bridge.masks =3D intel_generic_masks;=0A+	agp_br=
idge.aperture_sizes =3D (void *) intel_8xx_sizes;=0A+	agp_bridge.size_type =
=3D U8_APER_SIZE;=0A+	agp_bridge.num_aperture_sizes =3D 7;=0A+	agp_bridge.d=
ev_private_data =3D NULL;=0A+	agp_bridge.needs_scratch_page =3D FALSE;=0A+	=
agp_bridge.configure =3D intel_7505_configure;=0A+	agp_bridge.fetch_size =
=3D intel_8xx_fetch_size;=0A+	agp_bridge.cleanup =3D intel_8xx_cleanup;=0A+=
	agp_bridge.tlb_flush =3D intel_8xx_tlbflush;=0A+	agp_bridge.mask_memory =
=3D intel_mask_memory;=0A+	agp_bridge.agp_enable =3D agp_generic_agp_enable=
;=0A+	agp_bridge.cache_flush =3D global_cache_flush;=0A+	agp_bridge.create_=
gatt_table =3D agp_generic_create_gatt_table;=0A+	agp_bridge.free_gatt_tabl=
e =3D agp_generic_free_gatt_table;=0A+	agp_bridge.insert_memory =3D agp_gen=
eric_insert_memory;=0A+	agp_bridge.remove_memory =3D agp_generic_remove_mem=
ory;=0A+	agp_bridge.alloc_by_type =3D agp_generic_alloc_by_type;=0A+	agp_br=
idge.free_by_type =3D agp_generic_free_by_type;=0A+	agp_bridge.agp_alloc_pa=
ge =3D agp_generic_alloc_page;=0A+	agp_bridge.agp_destroy_page =3D agp_gene=
ric_destroy_page;=0A+	agp_bridge.suspend =3D agp_generic_suspend;=0A+	agp_b=
ridge.resume =3D agp_generic_resume;=0A+	agp_bridge.cant_use_aperture =3D 0=
;=0A+=0A+	return 0;=0A+=0A+	(void) pdev; /* unused */=0A+}=0A+=0A #endif /*=
 CONFIG_AGP_INTEL */=0A =0A #ifdef CONFIG_AGP_VIA=0A@@ -4942,6 +5005,18 @@=
=0A 		"Intel",=0A 		"i860",=0A 		intel_860_setup },=0A+	{ PCI_DEVICE_ID_INT=
EL_7205_0,=0A+		PCI_VENDOR_ID_INTEL,=0A+		INTEL_I7205,=0A+		"Intel",=0A+		"=
i7205",=0A+		intel_7505_setup },=0A+	{ PCI_DEVICE_ID_INTEL_7505_0,=0A+		PCI=
_VENDOR_ID_INTEL,=0A+		INTEL_I7505,=0A+		"Intel",=0A+		"i7505",=0A+		intel_=
7505_setup },=0A 	{ 0,=0A 		PCI_VENDOR_ID_INTEL,=0A 		INTEL_GENERIC,=0Adiff=
 -ruN linux-2.4.21/include/linux/agp_backend.h linux-2.4.22-pre4+p4/include=
/linux/agp_backend.h=0A--- linux-2.4.21/include/linux/agp_backend.h	2003-07=
-15 11:39:15.000000000 +0200=0A+++ linux-2.4.22-pre4+p4/include/linux/agp_b=
ackend.h	2003-07-15 11:30:11.000000000 +0200=0A@@ -55,6 +55,8 @@=0A 	INTEL_=
I855_PM,=0A 	INTEL_I860,=0A 	INTEL_I865_G,=0A+	INTEL_I7205,=0A+	INTEL_I7505=
,=0A 	VIA_GENERIC,=0A 	VIA_VP3,=0A 	VIA_MVP3,=0A
--IS0zKkzwUGydFO0o--
