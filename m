Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932516AbWCWCUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932516AbWCWCUm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 21:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932526AbWCWCUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 21:20:42 -0500
Received: from nproxy.gmail.com ([64.233.182.207]:18365 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932516AbWCWCUk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 21:20:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=FqZLXhBQS+rLJb8E3j5gOCTgNqLwvFtKpVDB2eVN8L4g0xnGT1SLmVUoVofcqfELbmYLXoSQsuzf8JOnvOu0ThzXFN7uvx/c95vj54qACggUfXvClq7sCfWoR5bstVcKFv2uCqyA1Vb94qS/iax4LOdgfe0nYsvkXVtW9bl3KLI=
Message-ID: <21d7e9970603221820p5c89e46fgbd9878a3c60eac0a@mail.gmail.com>
Date: Thu, 23 Mar 2006 13:20:34 +1100
From: "Dave Airlie" <airlied@gmail.com>
To: "Linux Fbdev development list" 
	<linux-fbdev-devel@lists.sourceforge.net>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: [PATCH] [git tree] Intel i9xx support for intelfb
Cc: sylvain.meyer@worldonline.fr
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_8907_15442742.1143080434624"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_8907_15442742.1143080434624
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

This patch adds support for i915G, i915GM and i945G to the intelfb
driver in the kernel.

It comes from work done by me on an X.org driver to support some
non-VBE modesetting.

This code isn't perfect but I've got no documentation so I cannot
answer some questions on what exactly is going on just yet...

The code is also available in the i915fb branch or
git://git.kernel.org/pub/scm/linux/kernel/git/airlied/intelfb-2.6

It may need more testing on the i945G, and I think adding i945GM
support might only be a few lines of code...

Is there a framebuffer git tree this could go in?

Dave.

------=_Part_8907_15442742.1143080434624
Content-Type: text/x-patch; name=intelfb_i9xx.diff; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Attachment-Id: f_el4gdxaw
Content-Disposition: attachment; filename="intelfb_i9xx.diff"

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index f5079c7..bc8ec78 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -725,7 +725,7 @@ config FB_I810_I2C
=20
 config FB_INTEL
 =09tristate "Intel 830M/845G/852GM/855GM/865G support (EXPERIMENTAL)"
-=09depends on FB && EXPERIMENTAL && PCI && X86_32
+=09depends on FB && EXPERIMENTAL && PCI && X86
 =09select AGP
 =09select AGP_INTEL
 =09select FB_MODE_HELPERS
diff --git a/drivers/video/intelfb/intelfb.h b/drivers/video/intelfb/intelf=
b.h
index da29d00..de9875c 100644
--- a/drivers/video/intelfb/intelfb.h
+++ b/drivers/video/intelfb/intelfb.h
@@ -8,9 +8,9 @@
=20
=20
 /*** Version/name ***/
-#define INTELFB_VERSION=09=09=09"0.9.2"
+#define INTELFB_VERSION=09=09=09"0.9.3"
 #define INTELFB_MODULE_NAME=09=09"intelfb"
-#define SUPPORTED_CHIPSETS=09=09"830M/845G/852GM/855GM/865G/915G/915GM"
+#define SUPPORTED_CHIPSETS=09=09"830M/845G/852GM/855GM/865G/915G/915GM/945=
G"
=20
=20
 /*** Debug/feature defines ***/
@@ -52,6 +52,7 @@
 #define PCI_DEVICE_ID_INTEL_865G=090x2572
 #define PCI_DEVICE_ID_INTEL_915G=090x2582
 #define PCI_DEVICE_ID_INTEL_915GM=090x2592
+#define PCI_DEVICE_ID_INTEL_945G=090x2772
=20
 /* Size of MMIO region */
 #define INTEL_REG_SIZE=09=09=090x80000
@@ -125,7 +126,8 @@ enum intel_chips {
 =09INTEL_855GME,
 =09INTEL_865G,
 =09INTEL_915G,
-=09INTEL_915GM
+=09INTEL_915GM,
+=09INTEL_945G
 };
=20
 struct intelfb_hwstate {
@@ -277,8 +279,13 @@ struct intelfb_info {
=20
 =09/* driver registered */
 =09int registered;
+=09
+=09/* index into plls */
+=09int pll_index;
 };
=20
+#define IS_I9xx(dinfo) (((dinfo)->chipset =3D=3D INTEL_915G)||(dinfo->chip=
set =3D=3D INTEL_915GM)||((dinfo)->chipset =3D=3D INTEL_945G))
+
 /*** function prototypes ***/
=20
 extern int intelfb_var_to_depth(const struct fb_var_screeninfo *var);
diff --git a/drivers/video/intelfb/intelfbdrv.c b/drivers/video/intelfb/int=
elfbdrv.c
index 995b47c..b96001b 100644
--- a/drivers/video/intelfb/intelfbdrv.c
+++ b/drivers/video/intelfb/intelfbdrv.c
@@ -1,11 +1,12 @@
 /*
  * intelfb
  *
- * Linux framebuffer driver for Intel(R) 830M/845G/852GM/855GM/865G/915G/9=
15GM
- * integrated graphics chips.
+ * Linux framebuffer driver for Intel(R) 830M/845G/852GM/855GM/865G/915G/9=
15GM/
+ * 945G integrated graphics chips.
  *
  * Copyright =A9 2002, 2003 David Dawes <dawes@xfree86.org>
  *                   2004 Sylvain Meyer
+ *                   2006 David Airlie
  *
  * This driver consists of two parts.  The first part (intelfbdrv.c) provi=
des
  * the basic fbdev interfaces, is derived in part from the radeonfb and
@@ -182,6 +183,7 @@ static struct pci_device_id intelfb_pci_
 =09{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_865G, PCI_ANY_ID, PCI_ANY_ID=
, PCI_CLASS_DISPLAY_VGA << 8, INTELFB_CLASS_MASK, INTEL_865G },
 =09{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_915G, PCI_ANY_ID, PCI_ANY_ID=
, PCI_CLASS_DISPLAY_VGA << 8, INTELFB_CLASS_MASK, INTEL_915G },
 =09{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_915GM, PCI_ANY_ID, PCI_ANY_I=
D, PCI_CLASS_DISPLAY_VGA << 8, INTELFB_CLASS_MASK, INTEL_915GM },
+=09{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_945G, PCI_ANY_ID, PCI_ANY_ID=
, PCI_CLASS_DISPLAY_VGA << 8, INTELFB_CLASS_MASK, INTEL_945G },
 =09{ 0, }
 };
=20
@@ -546,11 +548,10 @@ intelfb_pci_register(struct pci_dev *pde
=20
 =09/* Set base addresses. */
 =09if ((ent->device =3D=3D PCI_DEVICE_ID_INTEL_915G) ||
-=09=09=09(ent->device =3D=3D PCI_DEVICE_ID_INTEL_915GM)) {
+=09    (ent->device =3D=3D PCI_DEVICE_ID_INTEL_915GM) ||
+=09    (ent->device =3D=3D PCI_DEVICE_ID_INTEL_945G)) {
 =09=09aperture_bar =3D 2;
 =09=09mmio_bar =3D 0;
-=09=09/* Disable HW cursor on 915G/M (not implemented yet) */
-=09=09hwcursor =3D 0;
 =09}
 =09dinfo->aperture.physical =3D pci_resource_start(pdev, aperture_bar);
 =09dinfo->aperture.size     =3D pci_resource_len(pdev, aperture_bar);
@@ -584,8 +585,7 @@ intelfb_pci_register(struct pci_dev *pde
 =09/* Get the chipset info. */
 =09dinfo->pci_chipset =3D pdev->device;
=20
-=09if (intelfbhw_get_chipset(pdev, &dinfo->name, &dinfo->chipset,
-=09=09=09=09  &dinfo->mobile)) {
+=09if (intelfbhw_get_chipset(pdev, dinfo)) {
 =09=09cleanup(dinfo);
 =09=09return -ENODEV;
 =09}
@@ -1467,7 +1467,7 @@ static int
 intelfb_cursor(struct fb_info *info, struct fb_cursor *cursor)
 {
         struct intelfb_info *dinfo =3D GET_DINFO(info);
-
+=09int ret;
 #if VERBOSE > 0
 =09DBG_MSG("intelfb_cursor\n");
 #endif
@@ -1478,7 +1478,12 @@ intelfb_cursor(struct fb_info *info, str
 =09intelfbhw_cursor_hide(dinfo);
=20
 =09/* If XFree killed the cursor - restore it */
-=09if (INREG(CURSOR_A_BASEADDR) !=3D dinfo->cursor.offset << 12) {
+=09if (dinfo->mobile || IS_I9xx(dinfo))
+=09  ret =3D (INREG(CURSOR_A_BASEADDR) !=3D dinfo->cursor.physical);
+=09else
+=09  ret =3D (INREG(CURSOR_A_BASEADDR) !=3D dinfo->cursor.offset << 12);
+
+=09if (ret) {
 =09=09u32 fg, bg;
=20
 =09=09DBG_MSG("the cursor was killed - restore it !!\n");
diff --git a/drivers/video/intelfb/intelfbhw.c b/drivers/video/intelfb/inte=
lfbhw.c
index 624c4bc..92bdde8 100644
--- a/drivers/video/intelfb/intelfbhw.c
+++ b/drivers/video/intelfb/intelfbhw.c
@@ -40,68 +40,99 @@
 #include "intelfb.h"
 #include "intelfbhw.h"
=20
+struct pll_min_max {
+=09int min_m, max_m;
+=09int min_m1, max_m1;
+=09int min_m2, max_m2;
+=09int min_n, max_n;
+=09int min_p, max_p;
+=09int min_p1, max_p1;
+=09int min_vco_freq, max_vco_freq;
+=09int p_transition_clock;
+=09int p_inc_lo, p_inc_hi;
+};
+
+#define PLLS_I8xx 0
+#define PLLS_I9xx 1
+#define PLLS_MAX 2
+
+struct pll_min_max plls[PLLS_MAX] =3D {
+=09{ 108, 140, 18, 26, 6, 16, 3, 16, 4, 128, 0, 31, 930000, 1400000, 16500=
0, 4, 22 }, //I8xx
+=09{  75, 120, 10, 20, 5, 9, 4,  7, 5, 80, 1, 8, 930000, 2800000, 200000, =
10, 5 }  //I9xx
+};
+
 int
-intelfbhw_get_chipset(struct pci_dev *pdev, const char **name, int *chipse=
t,
-=09=09      int *mobile)
+intelfbhw_get_chipset(struct pci_dev *pdev, struct intelfb_info *dinfo)
 {
 =09u32 tmp;
-
-=09if (!pdev || !name || !chipset || !mobile)
+=09if (!pdev || !dinfo)
 =09=09return 1;
=20
 =09switch (pdev->device) {
 =09case PCI_DEVICE_ID_INTEL_830M:
-=09=09*name =3D "Intel(R) 830M";
-=09=09*chipset =3D INTEL_830M;
-=09=09*mobile =3D 1;
+=09=09dinfo->name =3D "Intel(R) 830M";
+=09=09dinfo->chipset =3D INTEL_830M;
+=09=09dinfo->mobile =3D 1;
+=09=09dinfo->pll_index =3D PLLS_I8xx;
 =09=09return 0;
 =09case PCI_DEVICE_ID_INTEL_845G:
-=09=09*name =3D "Intel(R) 845G";
-=09=09*chipset =3D INTEL_845G;
-=09=09*mobile =3D 0;
+=09=09dinfo->name =3D "Intel(R) 845G";
+=09=09dinfo->chipset =3D INTEL_845G;
+=09=09dinfo->mobile =3D 0;
+=09=09dinfo->pll_index =3D PLLS_I8xx;
 =09=09return 0;
 =09case PCI_DEVICE_ID_INTEL_85XGM:
 =09=09tmp =3D 0;
-=09=09*mobile =3D 1;
+=09=09dinfo->mobile =3D 1;
+=09=09dinfo->pll_index =3D PLLS_I8xx;
 =09=09pci_read_config_dword(pdev, INTEL_85X_CAPID, &tmp);
 =09=09switch ((tmp >> INTEL_85X_VARIANT_SHIFT) &
 =09=09=09INTEL_85X_VARIANT_MASK) {
 =09=09case INTEL_VAR_855GME:
-=09=09=09*name =3D "Intel(R) 855GME";
-=09=09=09*chipset =3D INTEL_855GME;
+=09=09=09dinfo->name =3D "Intel(R) 855GME";
+=09=09=09dinfo->chipset =3D INTEL_855GME;
 =09=09=09return 0;
 =09=09case INTEL_VAR_855GM:
-=09=09=09*name =3D "Intel(R) 855GM";
-=09=09=09*chipset =3D INTEL_855GM;
+=09=09=09dinfo->name =3D "Intel(R) 855GM";
+=09=09=09dinfo->chipset =3D INTEL_855GM;
 =09=09=09return 0;
 =09=09case INTEL_VAR_852GME:
-=09=09=09*name =3D "Intel(R) 852GME";
-=09=09=09*chipset =3D INTEL_852GME;
+=09=09=09dinfo->name =3D "Intel(R) 852GME";
+=09=09=09dinfo->chipset =3D INTEL_852GME;
 =09=09=09return 0;
 =09=09case INTEL_VAR_852GM:
-=09=09=09*name =3D "Intel(R) 852GM";
-=09=09=09*chipset =3D INTEL_852GM;
+=09=09=09dinfo->name =3D "Intel(R) 852GM";
+=09=09=09dinfo->chipset =3D INTEL_852GM;
 =09=09=09return 0;
 =09=09default:
-=09=09=09*name =3D "Intel(R) 852GM/855GM";
-=09=09=09*chipset =3D INTEL_85XGM;
+=09=09=09dinfo->name =3D "Intel(R) 852GM/855GM";
+=09=09=09dinfo->chipset =3D INTEL_85XGM;
 =09=09=09return 0;
 =09=09}
 =09=09break;
 =09case PCI_DEVICE_ID_INTEL_865G:
-=09=09*name =3D "Intel(R) 865G";
-=09=09*chipset =3D INTEL_865G;
-=09=09*mobile =3D 0;
+=09=09dinfo->name =3D "Intel(R) 865G";
+=09=09dinfo->chipset =3D INTEL_865G;
+=09=09dinfo->mobile =3D 0;
+=09=09dinfo->pll_index =3D PLLS_I8xx;
 =09=09return 0;
 =09case PCI_DEVICE_ID_INTEL_915G:
-=09=09*name =3D "Intel(R) 915G";
-=09=09*chipset =3D INTEL_915G;
-=09=09*mobile =3D 0;
+=09=09dinfo->name =3D "Intel(R) 915G";
+=09=09dinfo->chipset =3D INTEL_915G;
+=09=09dinfo->mobile =3D 0;
+=09=09dinfo->pll_index =3D PLLS_I9xx;
 =09=09return 0;
 =09case PCI_DEVICE_ID_INTEL_915GM:
-=09=09*name =3D "Intel(R) 915GM";
-=09=09*chipset =3D INTEL_915GM;
-=09=09*mobile =3D 1;
+=09=09dinfo->name =3D "Intel(R) 915GM";
+=09=09dinfo->chipset =3D INTEL_915GM;
+=09=09dinfo->mobile =3D 1;
+=09=09dinfo->pll_index =3D PLLS_I9xx;
+=09=09return 0;
+=09case PCI_DEVICE_ID_INTEL_945G:
+=09=09dinfo->name =3D "Intel(R) 945G";
+=09=09dinfo->chipset =3D INTEL_945G;
+=09=09dinfo->mobile =3D 0;
+=09=09dinfo->pll_index =3D PLLS_I9xx;
 =09=09return 0;
 =09default:
 =09=09return 1;
@@ -529,14 +560,37 @@ intelfbhw_read_hw_state(struct intelfb_i
 }
=20
=20
+static int calc_vclock3(int index, int m, int n, int p)
+{
+=09if (p =3D=3D 0 || n =3D=3D 0)
+=09=09return 0;
+=09return PLL_REFCLK * m / n / p;
+}
+=09=09      =20
+static int calc_vclock(int index, int m1, int m2, int n, int p1, int p2)
+{
+=09switch(index)
+=09{
+=09case PLLS_I9xx:
+=09=09if (p1 =3D=3D 0)
+=09=09=09return 0;
+=09=09return ((PLL_REFCLK * (5 * (m1 + 2) + (m2 + 2)) / (n + 2) /
+=09=09=09 ((p1)) * (p2 ? 10 : 5)));
+=09case PLLS_I8xx:
+=09default:
+=09=09return ((PLL_REFCLK * (5 * (m1 + 2) + (m2 + 2)) / (n + 2) /=20
+=09=09=09 ((p1+2) * (1 << (p2 + 1)))));
+=09}
+}
+
 void
 intelfbhw_print_hw_state(struct intelfb_info *dinfo, struct intelfb_hwstat=
e *hw)
 {
 #if REGDUMP
 =09int i, m1, m2, n, p1, p2;
-
+=09int index =3D dinfo->pll_index;
 =09DBG_MSG("intelfbhw_print_hw_state\n");
-
+=09
 =09if (!hw || !dinfo)
 =09=09return;
 =09/* Read in as much of the HW state as possible. */
@@ -553,9 +607,10 @@ intelfbhw_print_hw_state(struct intelfb_
 =09=09p1 =3D (hw->vga_pd >> VGAPD_0_P1_SHIFT) & DPLL_P1_MASK;
 =09p2 =3D (hw->vga_pd >> VGAPD_0_P2_SHIFT) & DPLL_P2_MASK;
 =09printk("=09VGA0: (m1, m2, n, p1, p2) =3D (%d, %d, %d, %d, %d)\n",
-=09=09m1, m2, n, p1, p2);
-=09printk("=09VGA0: clock is %d\n", CALC_VCLOCK(m1, m2, n, p1, p2));
-
+=09       m1, m2, n, p1, p2);
+=09printk("=09VGA0: clock is %d\n",=20
+=09       calc_vclock(index, m1, m2, n, p1, p2));
+=09
 =09n =3D (hw->vga1_divisor >> FP_N_DIVISOR_SHIFT) & FP_DIVISOR_MASK;
 =09m1 =3D (hw->vga1_divisor >> FP_M1_DIVISOR_SHIFT) & FP_DIVISOR_MASK;
 =09m2 =3D (hw->vga1_divisor >> FP_M2_DIVISOR_SHIFT) & FP_DIVISOR_MASK;
@@ -565,16 +620,16 @@ intelfbhw_print_hw_state(struct intelfb_
 =09=09p1 =3D (hw->vga_pd >> VGAPD_1_P1_SHIFT) & DPLL_P1_MASK;
 =09p2 =3D (hw->vga_pd >> VGAPD_1_P2_SHIFT) & DPLL_P2_MASK;
 =09printk("=09VGA1: (m1, m2, n, p1, p2) =3D (%d, %d, %d, %d, %d)\n",
-=09=09m1, m2, n, p1, p2);
-=09printk("=09VGA1: clock is %d\n", CALC_VCLOCK(m1, m2, n, p1, p2));
-
+=09       m1, m2, n, p1, p2);
+=09printk("=09VGA1: clock is %d\n", calc_vclock(index, m1, m2, n, p1, p2))=
;
+=09
 =09printk("=09DPLL_A:=09=09=090x%08x\n", hw->dpll_a);
 =09printk("=09DPLL_B:=09=09=090x%08x\n", hw->dpll_b);
 =09printk("=09FPA0:=09=09=090x%08x\n", hw->fpa0);
 =09printk("=09FPA1:=09=09=090x%08x\n", hw->fpa1);
 =09printk("=09FPB0:=09=09=090x%08x\n", hw->fpb0);
 =09printk("=09FPB1:=09=09=090x%08x\n", hw->fpb1);
-
+=09
 =09n =3D (hw->fpa0 >> FP_N_DIVISOR_SHIFT) & FP_DIVISOR_MASK;
 =09m1 =3D (hw->fpa0 >> FP_M1_DIVISOR_SHIFT) & FP_DIVISOR_MASK;
 =09m2 =3D (hw->fpa0 >> FP_M2_DIVISOR_SHIFT) & FP_DIVISOR_MASK;
@@ -584,9 +639,9 @@ intelfbhw_print_hw_state(struct intelfb_
 =09=09p1 =3D (hw->dpll_a >> DPLL_P1_SHIFT) & DPLL_P1_MASK;
 =09p2 =3D (hw->dpll_a >> DPLL_P2_SHIFT) & DPLL_P2_MASK;
 =09printk("=09PLLA0: (m1, m2, n, p1, p2) =3D (%d, %d, %d, %d, %d)\n",
-=09=09m1, m2, n, p1, p2);
-=09printk("=09PLLA0: clock is %d\n", CALC_VCLOCK(m1, m2, n, p1, p2));
-
+=09       m1, m2, n, p1, p2);
+=09printk("=09PLLA0: clock is %d\n", calc_vclock(index, m1, m2, n, p1, p2)=
);
+=09
 =09n =3D (hw->fpa1 >> FP_N_DIVISOR_SHIFT) & FP_DIVISOR_MASK;
 =09m1 =3D (hw->fpa1 >> FP_M1_DIVISOR_SHIFT) & FP_DIVISOR_MASK;
 =09m2 =3D (hw->fpa1 >> FP_M2_DIVISOR_SHIFT) & FP_DIVISOR_MASK;
@@ -596,16 +651,16 @@ intelfbhw_print_hw_state(struct intelfb_
 =09=09p1 =3D (hw->dpll_a >> DPLL_P1_SHIFT) & DPLL_P1_MASK;
 =09p2 =3D (hw->dpll_a >> DPLL_P2_SHIFT) & DPLL_P2_MASK;
 =09printk("=09PLLA1: (m1, m2, n, p1, p2) =3D (%d, %d, %d, %d, %d)\n",
-=09=09m1, m2, n, p1, p2);
-=09printk("=09PLLA1: clock is %d\n", CALC_VCLOCK(m1, m2, n, p1, p2));
-
+=09       m1, m2, n, p1, p2);
+=09printk("=09PLLA1: clock is %d\n", calc_vclock(index, m1, m2, n, p1, p2)=
);
+=09
 #if 0
 =09printk("=09PALETTE_A:\n");
 =09for (i =3D 0; i < PALETTE_8_ENTRIES)
-=09=09printk("=09%3d:=090x%08x\n", i, hw->palette_a[i];
+=09=09printk("=09%3d:=090x%08x\n", i, hw->palette_a[i]);
 =09printk("=09PALETTE_B:\n");
 =09for (i =3D 0; i < PALETTE_8_ENTRIES)
-=09=09printk("=09%3d:=090x%08x\n", i, hw->palette_b[i];
+=09=09printk("=09%3d:=090x%08x\n", i, hw->palette_b[i]);
 #endif
=20
 =09printk("=09HTOTAL_A:=09=090x%08x\n", hw->htotal_a);
@@ -680,12 +735,12 @@ intelfbhw_print_hw_state(struct intelfb_
 =09}
 =09for (i =3D 0; i < 3; i++) {
 =09=09printk("=09SWF3%d=09=09=090x%08x\n", i,
-=09=09=09hw->swf3x[i]);
+=09=09       hw->swf3x[i]);
 =09}
 =09for (i =3D 0; i < 8; i++)
 =09=09printk("=09FENCE%d=09=09=090x%08x\n", i,
-=09=09=09hw->fence[i]);
-
+=09=09       hw->fence[i]);
+=09=09      =20
 =09printk("=09INSTPM=09=09=090x%08x\n", hw->instpm);
 =09printk("=09MEM_MODE=09=090x%08x\n", hw->mem_mode);
 =09printk("=09FW_BLC_0=09=090x%08x\n", hw->fw_blc_0);
@@ -695,57 +750,87 @@ intelfbhw_print_hw_state(struct intelfb_
 #endif
 }
=20
+=09      =20
+
 /* Split the M parameter into M1 and M2. */
 static int
-splitm(unsigned int m, unsigned int *retm1, unsigned int *retm2)
+splitm(int index, unsigned int m, unsigned int *retm1, unsigned int *retm2=
)
 {
 =09int m1, m2;
-
-=09m1 =3D (m - 2 - (MIN_M2 + MAX_M2) / 2) / 5 - 2;
-=09if (m1 < MIN_M1)
-=09=09m1 =3D MIN_M1;
-=09if (m1 > MAX_M1)
-=09=09m1 =3D MAX_M1;
-=09m2 =3D m - 5 * (m1 + 2) - 2;
-=09if (m2 < MIN_M2 || m2 > MAX_M2 || m2 >=3D m1) {
-=09=09return 1;
-=09} else {
+=09int testm;
+=09/* no point optimising too much - brute force m */
+=09for (m1 =3D plls[index].min_m1; m1 < plls[index].max_m1+1; m1++)
+=09{
+=09  for (m2 =3D plls[index].min_m2; m2 < plls[index].max_m2+1; m2++)
+=09  {
+=09    testm  =3D ( 5 * ( m1 + 2 )) + (m2 + 2);
+=09    if (testm =3D=3D m)
+=09    {
 =09=09*retm1 =3D (unsigned int)m1;
-=09=09*retm2 =3D (unsigned int)m2;
+=09=09*retm2 =3D (unsigned int)m2;=09     =20
 =09=09return 0;
+=09    }
+=09  }
 =09}
+=09return 1;
 }
=20
 /* Split the P parameter into P1 and P2. */
 static int
-splitp(unsigned int p, unsigned int *retp1, unsigned int *retp2)
+splitp(int index, unsigned int p, unsigned int *retp1, unsigned int *retp2=
)
 {
 =09int p1, p2;
=20
-=09if (p % 4 =3D=3D 0)
-=09=09p2 =3D 1;
-=09else
-=09=09p2 =3D 0;
-=09p1 =3D (p / (1 << (p2 + 1))) - 2;
-=09if (p % 4 =3D=3D 0 && p1 < MIN_P1) {
-=09=09p2 =3D 0;
-=09=09p1 =3D (p / (1 << (p2 + 1))) - 2;
-=09}
-=09if (p1  < MIN_P1 || p1 > MAX_P1 || (p1 + 2) * (1 << (p2 + 1)) !=3D p) {
-=09=09return 1;
-=09} else {
+=09if (index =3D=3D PLLS_I9xx)
+=09{
+=09=09switch (p) {
+=09=09case 10:
+=09=09=09p1 =3D 2;
+=09=09=09p2 =3D 0;
+=09=09=09break;
+=09=09case 20:
+=09=09=09p1 =3D 1;
+=09=09=09p2 =3D 0;
+=09=09=09break;
+=09=09default:
+=09=09=09p1 =3D (p / 10) + 1;
+=09=09=09p2 =3D 0;
+=09=09=09break;
+=09=09}
+=09=09
 =09=09*retp1 =3D (unsigned int)p1;
 =09=09*retp2 =3D (unsigned int)p2;
 =09=09return 0;
 =09}
+
+=09if (index =3D=3D PLLS_I8xx)
+=09{
+=09=09if (p % 4 =3D=3D 0)
+=09=09=09p2 =3D 1;
+=09=09else
+=09=09=09p2 =3D 0;
+=09=09p1 =3D (p / (1 << (p2 + 1))) - 2;
+=09=09if (p % 4 =3D=3D 0 && p1 < plls[index].min_p1) {
+=09=09=09p2 =3D 0;
+=09=09=09p1 =3D (p / (1 << (p2 + 1))) - 2;
+=09=09}
+=09=09if (p1  < plls[index].min_p1 || p1 > plls[index].max_p1 || (p1 + 2) =
* (1 << (p2 + 1)) !=3D p) {
+=09=09=09return 1;
+=09=09} else {
+=09=09=09*retp1 =3D (unsigned int)p1;
+=09=09=09*retp2 =3D (unsigned int)p2;
+=09=09=09return 0;
+=09=09}
+=09}
+=09return 1;
 }
=20
 static int
-calc_pll_params(int clock, u32 *retm1, u32 *retm2, u32 *retn, u32 *retp1,
+calc_pll_params(int index, int clock, u32 *retm1, u32 *retm2, u32 *retn, u=
32 *retp1,
 =09=09u32 *retp2, u32 *retclock)
 {
-=09u32 m1, m2, n, p1, p2, n1;
-=09u32 f_vco, p, p_best =3D 0, m, f_out;
+=09u32 m1, m2, n, p1, p2, n1, testm;
+=09u32 f_vco, p, p_best =3D 0, m, f_out =3D 0;
 =09u32 err_max, err_target, err_best =3D 10000000;
 =09u32 n_best =3D 0, m_best =3D 0, f_best, f_err;
 =09u32 p_min, p_max, p_inc, div_min, div_max;
@@ -756,58 +841,73 @@ calc_pll_params(int clock, u32 *retm1, u
=20
 =09DBG_MSG("Clock is %d\n", clock);
=20
-=09div_max =3D MAX_VCO_FREQ / clock;
-=09div_min =3D ROUND_UP_TO(MIN_VCO_FREQ, clock) / clock;
+=09div_max =3D plls[index].max_vco_freq / clock;
+=09if (index =3D=3D PLLS_I9xx)
+=09=09div_min =3D 5;
+=09else
+=09=09div_min =3D ROUND_UP_TO(plls[index].min_vco_freq, clock) / clock;
=20
-=09if (clock <=3D P_TRANSITION_CLOCK)
-=09=09p_inc =3D 4;
+=09if (clock <=3D plls[index].p_transition_clock)
+=09=09p_inc =3D plls[index].p_inc_lo;
 =09else
-=09=09p_inc =3D 2;
+=09=09p_inc =3D plls[index].p_inc_hi;
 =09p_min =3D ROUND_UP_TO(div_min, p_inc);
 =09p_max =3D ROUND_DOWN_TO(div_max, p_inc);
-=09if (p_min < MIN_P)
-=09=09p_min =3D 4;
-=09if (p_max > MAX_P)
-=09=09p_max =3D 128;
+=09if (p_min < plls[index].min_p)
+=09=09p_min =3D plls[index].min_p;
+=09if (p_max > plls[index].max_p)
+=09=09p_max =3D plls[index].max_p;
+
+=09if (clock < PLL_REFCLK && index=3D=3DPLLS_I9xx)
+=09{
+=09  p_min =3D 10;
+=09  p_max =3D 20;
+=09  /* this makes 640x480 work it really shouldn't=20
+=09     - SOMEONE WITHOUT DOCS WOZ HERE */
+=09  if (clock < 30000)
+=09    clock *=3D 4;
+=09}
=20
 =09DBG_MSG("p range is %d-%d (%d)\n", p_min, p_max, p_inc);
=20
 =09p =3D p_min;
 =09do {
-=09=09if (splitp(p, &p1, &p2)) {
+=09=09if (splitp(index, p, &p1, &p2)) {
 =09=09=09WRN_MSG("cannot split p =3D %d\n", p);
 =09=09=09p +=3D p_inc;
 =09=09=09continue;
 =09=09}
-=09=09n =3D MIN_N;
+=09=09n =3D plls[index].min_n;
 =09=09f_vco =3D clock * p;
=20
 =09=09do {
 =09=09=09m =3D ROUND_UP_TO(f_vco * n, PLL_REFCLK) / PLL_REFCLK;
-=09=09=09if (m < MIN_M)
-=09=09=09=09m =3D MIN_M;
-=09=09=09if (m > MAX_M)
-=09=09=09=09m =3D MAX_M;
-=09=09=09f_out =3D CALC_VCLOCK3(m, n, p);
-=09=09=09if (splitm(m, &m1, &m2)) {
-=09=09=09=09WRN_MSG("cannot split m =3D %d\n", m);
-=09=09=09=09n++;
-=09=09=09=09continue;
-=09=09=09}
-=09=09=09if (clock > f_out)
-=09=09=09=09f_err =3D clock - f_out;
-=09=09=09else
-=09=09=09=09f_err =3D f_out - clock;
-
-=09=09=09if (f_err < err_best) {
-=09=09=09=09m_best =3D m;
-=09=09=09=09n_best =3D n;
-=09=09=09=09p_best =3D p;
-=09=09=09=09f_best =3D f_out;
-=09=09=09=09err_best =3D f_err;
+=09=09=09if (m < plls[index].min_m)
+=09=09=09=09m =3D plls[index].min_m + 1;
+=09=09=09if (m > plls[index].max_m)
+=09=09=09=09m =3D plls[index].max_m - 1;
+=09=09=09for (testm =3D m - 1; testm <=3D m; testm++) {
+=09=09=09=09f_out =3D calc_vclock3(index, m, n, p);
+=09=09=09=09if (splitm(index, m, &m1, &m2)) {
+=09=09=09=09=09WRN_MSG("cannot split m =3D %d\n", m);
+=09=09=09=09=09n++;
+=09=09=09=09=09continue;
+=09=09=09=09}
+=09=09=09=09if (clock > f_out)
+=09=09=09=09=09f_err =3D clock - f_out;
+=09=09=09=09else/* slightly bias the error for bigger clocks */
+=09=09=09=09=09f_err =3D f_out - clock + 1;
+=09=09=09=09
+=09=09=09=09if (f_err < err_best) {
+=09=09=09=09=09m_best =3D m;
+=09=09=09=09=09n_best =3D n;
+=09=09=09=09=09p_best =3D p;
+=09=09=09=09=09f_best =3D f_out;
+=09=09=09=09=09err_best =3D f_err;
+=09=09=09=09}
 =09=09=09}
 =09=09=09n++;
-=09=09} while ((n <=3D MAX_N) && (f_out >=3D clock));
+=09=09} while ((n <=3D plls[index].max_n) && (f_out >=3D clock));
 =09=09p +=3D p_inc;
 =09} while ((p <=3D p_max));
=20
@@ -818,21 +918,22 @@ calc_pll_params(int clock, u32 *retm1, u
 =09m =3D m_best;
 =09n =3D n_best;
 =09p =3D p_best;
-=09splitm(m, &m1, &m2);
-=09splitp(p, &p1, &p2);
+=09splitm(index, m, &m1, &m2);
+=09splitp(index, p, &p1, &p2);
 =09n1 =3D n - 2;
=20
 =09DBG_MSG("m, n, p: %d (%d,%d), %d (%d), %d (%d,%d), "
 =09=09"f: %d (%d), VCO: %d\n",
 =09=09m, m1, m2, n, n1, p, p1, p2,
-=09=09CALC_VCLOCK3(m, n, p), CALC_VCLOCK(m1, m2, n1, p1, p2),
-=09=09CALC_VCLOCK3(m, n, p) * p);
+=09=09calc_vclock3(index, m, n, p),=20
+=09=09calc_vclock(index, m1, m2, n1, p1, p2),
+=09=09calc_vclock3(index, m, n, p) * p);
 =09*retm1 =3D m1;
 =09*retm2 =3D m2;
 =09*retn =3D n1;
 =09*retp1 =3D p1;
 =09*retp2 =3D p2;
-=09*retclock =3D CALC_VCLOCK(m1, m2, n1, p1, p2);
+=09*retclock =3D calc_vclock(index, m1, m2, n1, p1, p2);
=20
 =09return 0;
 }
@@ -929,7 +1030,7 @@ intelfbhw_mode_to_hw(struct intelfb_info
 =09/* Desired clock in kHz */
 =09clock_target =3D 1000000000 / var->pixclock;
=20
-=09if (calc_pll_params(clock_target, &m1, &m2, &n, &p1, &p2, &clock)) {
+=09if (calc_pll_params(dinfo->pll_index, clock_target, &m1, &m2, &n, &p1, =
&p2, &clock)) {
 =09=09WRN_MSG("calc_pll_params failed\n");
 =09=09return 1;
 =09}
@@ -1087,6 +1188,7 @@ intelfbhw_program_mode(struct intelfb_in
 =09u32 hsync_reg, htotal_reg, hblank_reg;
 =09u32 vsync_reg, vtotal_reg, vblank_reg;
 =09u32 src_size_reg;
+=09u32 count, tmp_val[3];
=20
 =09/* Assume single pipe, display plane A, analog CRT. */
=20
@@ -1155,6 +1257,28 @@ intelfbhw_program_mode(struct intelfb_in
 =09=09src_size_reg =3D SRC_SIZE_A;
 =09}
=20
+=09/* turn off pipe */
+=09tmp =3D INREG(pipe_conf_reg);
+=09tmp &=3D ~PIPECONF_ENABLE;
+=09OUTREG(pipe_conf_reg, tmp);
+=09
+=09count =3D 0;
+=09do{
+=09  tmp_val[count%3] =3D INREG(0x70000);
+=09  if ((tmp_val[0] =3D=3D tmp_val[1]) && (tmp_val[1]=3D=3Dtmp_val[2]))
+=09    break;
+=09  count++;
+=09  udelay(1);
+=09  if (count % 200 =3D=3D 0)
+=09  {
+=09    tmp =3D INREG(pipe_conf_reg);
+=09    tmp &=3D ~PIPECONF_ENABLE;
+=09    OUTREG(pipe_conf_reg, tmp);
+=09  }
+=09} while(count < 2000);
+
+=09OUTREG(ADPA, INREG(ADPA) & ~ADPA_DAC_ENABLE);
+
 =09/* Disable planes A and B. */
 =09tmp =3D INREG(DSPACNTR);
 =09tmp &=3D ~DISPPLANE_PLANE_ENABLE;
@@ -1172,10 +1296,8 @@ intelfbhw_program_mode(struct intelfb_in
 =09tmp |=3D ADPA_DPMS_D3;
 =09OUTREG(ADPA, tmp);
=20
-=09/* turn off pipe */
-=09tmp =3D INREG(pipe_conf_reg);
-=09tmp &=3D ~PIPECONF_ENABLE;
-=09OUTREG(pipe_conf_reg, tmp);
+=09/* do some funky magic - xyzzy */
+=09OUTREG(0x61204, 0xabcd0000);
=20
 =09/* turn off PLL */
 =09tmp =3D INREG(dpll_reg);
@@ -1187,26 +1309,30 @@ intelfbhw_program_mode(struct intelfb_in
 =09OUTREG(fp0_reg, *fp0);
 =09OUTREG(fp1_reg, *fp1);
=20
-=09/* Set pipe parameters */
-=09OUTREG(hsync_reg, *hs);
-=09OUTREG(hblank_reg, *hb);
-=09OUTREG(htotal_reg, *ht);
-=09OUTREG(vsync_reg, *vs);
-=09OUTREG(vblank_reg, *vb);
-=09OUTREG(vtotal_reg, *vt);
-=09OUTREG(src_size_reg, *ss);
+=09/* Enable PLL */
+=09tmp =3D INREG(dpll_reg);
+=09tmp |=3D DPLL_VCO_ENABLE;
+=09OUTREG(dpll_reg, tmp);
=20
 =09/* Set DVOs B/C */
 =09OUTREG(DVOB, hw->dvob);
 =09OUTREG(DVOC, hw->dvoc);
=20
+=09/* undo funky magic */
+=09OUTREG(0x61204, 0x00000000);
+
 =09/* Set ADPA */
+=09OUTREG(ADPA, INREG(ADPA) | ADPA_DAC_ENABLE);
 =09OUTREG(ADPA, (hw->adpa & ~(ADPA_DPMS_CONTROL_MASK)) | ADPA_DPMS_D3);
=20
-=09/* Enable PLL */
-=09tmp =3D INREG(dpll_reg);
-=09tmp |=3D DPLL_VCO_ENABLE;
-=09OUTREG(dpll_reg, tmp);
+=09/* Set pipe parameters */
+=09OUTREG(hsync_reg, *hs);
+=09OUTREG(hblank_reg, *hb);
+=09OUTREG(htotal_reg, *ht);
+=09OUTREG(vsync_reg, *vs);
+=09OUTREG(vblank_reg, *vb);
+=09OUTREG(vtotal_reg, *vt);
+=09OUTREG(src_size_reg, *ss);
=20
 =09/* Enable pipe */
 =09OUTREG(pipe_conf_reg, *pipe_conf | PIPECONF_ENABLE);
@@ -1616,7 +1742,7 @@ intelfbhw_cursor_init(struct intelfb_inf
 =09DBG_MSG("intelfbhw_cursor_init\n");
 #endif
=20
-=09if (dinfo->mobile) {
+=09if (dinfo->mobile || IS_I9xx(dinfo)) {
 =09=09if (!dinfo->cursor.physical)
 =09=09=09return;
 =09=09tmp =3D INREG(CURSOR_A_CONTROL);
@@ -1649,7 +1775,7 @@ intelfbhw_cursor_hide(struct intelfb_inf
 #endif
=20
 =09dinfo->cursor_on =3D 0;
-=09if (dinfo->mobile) {
+=09if (dinfo->mobile || IS_I9xx(dinfo)) {
 =09=09if (!dinfo->cursor.physical)
 =09=09=09return;
 =09=09tmp =3D INREG(CURSOR_A_CONTROL);
@@ -1679,7 +1805,7 @@ intelfbhw_cursor_show(struct intelfb_inf
 =09if (dinfo->cursor_blanked)
 =09=09return;
=20
-=09if (dinfo->mobile) {
+=09if (dinfo->mobile || IS_I9xx(dinfo)) {
 =09=09if (!dinfo->cursor.physical)
 =09=09=09return;
 =09=09tmp =3D INREG(CURSOR_A_CONTROL);
@@ -1713,6 +1839,10 @@ intelfbhw_cursor_setpos(struct intelfb_i
 =09tmp =3D ((x & CURSOR_POS_MASK) << CURSOR_X_SHIFT) |
 =09      ((y & CURSOR_POS_MASK) << CURSOR_Y_SHIFT);
 =09OUTREG(CURSOR_A_POSITION, tmp);
+
+=09if (IS_I9xx(dinfo)) {
+=09=09OUTREG(CURSOR_A_BASEADDR, dinfo->cursor.physical);
+=09}
 }
=20
 void
diff --git a/drivers/video/intelfb/intelfbhw.h b/drivers/video/intelfb/inte=
lfbhw.h
index ba19201..a3ec8f9 100644
--- a/drivers/video/intelfb/intelfbhw.h
+++ b/drivers/video/intelfb/intelfbhw.h
@@ -155,29 +155,8 @@
 /* PLL parameters (these are for 852GM/855GM/865G, check earlier chips). *=
/
 /* Clock values are in units of kHz */
 #define PLL_REFCLK=09=0948000
-#define MIN_VCO_FREQ=09=09930000
-#define MAX_VCO_FREQ=09=091400000
 #define MIN_CLOCK=09=0925000
 #define MAX_CLOCK=09=09350000
-#define P_TRANSITION_CLOCK=09165000
-#define MIN_M=09=09=09108
-#define MAX_M=09=09=09140
-#define MIN_M1=09=09=0918
-#define MAX_M1=09=09=0926
-#define MIN_M2=09=09=096
-#define MAX_M2=09=09=0916
-#define MIN_P=09=09=094
-#define MAX_P=09=09=09128
-#define MIN_P1=09=09=090
-#define MAX_P1=09=09=0931
-#define MIN_N=09=09=093
-#define MAX_N=09=09=0916
-
-#define CALC_VCLOCK(m1, m2, n, p1, p2) \
-        ((PLL_REFCLK * (5 * ((m1) + 2) + ((m2) + 2)) / ((n) + 2)) / \
-        (((p1) + 2) * (1 << (p2 + 1))))
-
-#define CALC_VCLOCK3(m, n, p)=09((PLL_REFCLK * (m) / (n)) / (p))
=20
 /* Two pipes */
 #define PIPE_A=09=09=090
@@ -522,8 +501,7 @@
=20
=20
 /* function protoypes */
-extern int intelfbhw_get_chipset(struct pci_dev *pdev, const char **name,
-=09=09=09=09 int *chipset, int *mobile);
+extern int intelfbhw_get_chipset(struct pci_dev *pdev, struct intelfb_info=
 *dinfo);
 extern int intelfbhw_get_memory(struct pci_dev *pdev, int *aperture_size,
 =09=09=09=09int *stolen_size);
 extern int intelfbhw_check_non_crt(struct intelfb_info *dinfo);




------=_Part_8907_15442742.1143080434624--
