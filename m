Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266487AbSLDNEZ>; Wed, 4 Dec 2002 08:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266507AbSLDNEY>; Wed, 4 Dec 2002 08:04:24 -0500
Received: from willow.compass.com.ph ([202.70.96.38]:26635 "EHLO
	willow.compass.com.ph") by vger.kernel.org with ESMTP
	id <S266487AbSLDNEI>; Wed, 4 Dec 2002 08:04:08 -0500
Subject: [PATCH 3/3] FBDEV: rivafb + save/restore state
From: Antonino Daplas <adaplas@pol.net>
To: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-Px0yh0nrfTnU24ou0BU7"
Message-Id: <1039017461.1012.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 04 Dec 2002 21:02:03 +0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Px0yh0nrfTnU24ou0BU7
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

Attached is a patch against linux-2.5.50 + James Simmons fbdev.diff.

Added support to save and restore vgacon's text mode.  Can also restore
VGA graphics mode.

Tony



--=-Px0yh0nrfTnU24ou0BU7
Content-Disposition: attachment; filename=rivafb_state.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=rivafb_state.diff; charset=UTF-8

diff -Naur linux-2.5.50-js/drivers/video/Makefile linux/drivers/video/Makef=
ile
--- linux-2.5.50-js/drivers/video/Makefile	2002-12-04 15:22:38.000000000 +0=
000
+++ linux/drivers/video/Makefile	2002-12-04 15:24:50.000000000 +0000
@@ -69,7 +69,8 @@
 obj-$(CONFIG_FB_TX3912)           +=3D tx3912fb.o cfbfillrect.o cfbcopyare=
a.o cfbimgblt.o
=20
 obj-$(CONFIG_FB_MATROX)		  +=3D matrox/
-obj-$(CONFIG_FB_RIVA)		  +=3D riva/ cfbfillrect.o cfbcopyarea.o cfbimgblt.=
o
+obj-$(CONFIG_FB_RIVA)		  +=3D riva/ cfbfillrect.o cfbcopyarea.o \
+	                             cfbimgblt.o vgastate.o
 obj-$(CONFIG_FB_SIS)		  +=3D sis/
 obj-$(CONFIG_FB_ATY)		  +=3D aty/ cfbimgblt.o
=20
diff -Naur linux-2.5.50-js/drivers/video/riva/fbdev.c linux/drivers/video/r=
iva/fbdev.c
--- linux-2.5.50-js/drivers/video/riva/fbdev.c	2002-12-04 15:26:25.00000000=
0 +0000
+++ linux/drivers/video/riva/fbdev.c	2002-12-04 15:25:32.000000000 +0000
@@ -42,6 +42,7 @@
 #ifdef CONFIG_MTRR
 #include <asm/mtrr.h>
 #endif
+
 #include "rivafb.h"
 #include "nvreg.h"
=20
@@ -246,15 +247,12 @@
=20
 /* command line data, set in rivafb_setup() */
 static u32  pseudo_palette[17];
-static char nomove =3D 0;
 #ifdef CONFIG_MTRR
 static char nomtrr __initdata =3D 0;
 #endif
=20
 #ifndef MODULE
 static char *mode_option __initdata =3D NULL;
-#else
-static char *font =3D NULL;
 #endif
=20
 static struct fb_fix_screeninfo rivafb_fix =3D {
@@ -428,7 +426,7 @@
 		m =3D *((u32 *)mask)++;
 		for (j =3D 0; j < w/2; j++) {
 			tmp =3D 0;
-#if defined (__BIG_ENDIAN)=20
+#if defined (__BIG_ENDIAN__)=20
 			if (m & (1 << 31))
 				tmp =3D (b & (1 << 31)) ? fg << 16 : bg << 16;
 			b <<=3D 1;
@@ -1162,6 +1160,46 @@
  * framebuffer operations
  *
  * -----------------------------------------------------------------------=
-- */
+static int rivafb_open(struct fb_info *info, int user)
+{
+	struct riva_par *par =3D (struct riva_par *) info->par;
+	int cnt =3D atomic_read(&par->ref_count);
+
+	if (!cnt) {
+		memset(&par->state, 0, sizeof(struct fb_vgastate));
+		par->state.flags =3D VGA_SAVE_MODE  | VGA_SAVE_FONTS;
+		/* save the DAC for Riva128 */
+		if (par->riva.Architecture =3D=3D NV_ARCH_03)
+			par->state.flags |=3D VGA_SAVE_CMAP;
+		fb_save_vga(&par->state);
+
+		RivaGetConfig(&par->riva);
+		riva_save_state(par, &par->initial_state);
+	}
+=09
+	atomic_inc(&par->ref_count);
+	return 0;
+}
+
+static int rivafb_release(struct fb_info *info, int user)
+{
+	struct riva_par *par =3D (struct riva_par *) info->par;
+	int cnt =3D atomic_read(&par->ref_count);
+
+	if (!cnt)
+		return -EINVAL;
+	if (cnt =3D=3D 1) {
+		par->riva.LockUnlock(&par->riva, 0);
+		par->riva.LoadStateExt(&par->riva, &par->initial_state.ext);
+
+		fb_restore_vga(&par->state);
+		par->riva.LockUnlock(&par->riva, 1);
+	}
+
+	atomic_dec(&par->ref_count);
+
+	return 0;
+}
=20
 static int rivafb_check_var(struct fb_var_screeninfo *var,
                             struct fb_info *info)
@@ -1493,6 +1531,8 @@
 /* kernel interface */
 static struct fb_ops riva_fb_ops =3D {
 	.owner =3D	THIS_MODULE,
+	.fb_open =3D      rivafb_open,
+	.fb_release =3D   rivafb_release,
 	.fb_check_var =3D	rivafb_check_var,
 	.fb_set_par =3D	rivafb_set_par,
 	.fb_setcolreg =3D	rivafb_setcolreg,
@@ -1535,6 +1575,106 @@
  *
  * -----------------------------------------------------------------------=
-- */
=20
+static void __devinit rivafb_get_mem_len(struct riva_par *par,
+					 struct fb_fix_screeninfo *fix)
+{
+	RIVA_HW_INST *chip =3D &par->riva;
+
+	switch (chip->Architecture) {
+	case NV_ARCH_03:
+		if (chip->PFB[0x00000000/4] & 0x00000020) {
+			if (((chip->PMC[0x00000000/4] & 0xF0) =3D=3D 0x20)
+			    && ((chip->PMC[0x00000000/4] & 0x0F) >=3D 0x02)) {  =20
+				/*
+				 * SDRAM 128 ZX.
+				 */
+				switch (chip->PFB[0x00000000/4] & 0x03) {
+				case 2:
+					fix->smem_len =3D 1024 * 1024 * 4;
+					break;
+				case 1:
+					fix->smem_len =3D 1024 * 1024 * 2;
+					break;
+				default:
+					fix->smem_len =3D 1024 * 1024 * 8;
+					break;
+				}
+			}           =20
+			else  {
+				fix->smem_len =3D 1024 * 1024 * 8;
+			}           =20
+		}
+		else {
+			/*
+			 * SGRAM 128.
+			 */
+			switch (chip->PFB[0x00000000/4] & 0x00000003) {
+			case 0:
+				fix->smem_len =3D 1024 * 1024 * 8;
+				break;
+			case 2:
+				fix->smem_len =3D 1024 * 1024 * 4;
+				break;
+			default:
+				fix->smem_len =3D 1024 * 1024 * 2;
+				break;
+			}
+		}
+		break;
+	case NV_ARCH_04:
+		if (chip->PFB[0x00000000/4] & 0x00000100) {
+			fix->smem_len =3D (((chip->PFB[0x00000000/4] >> 12)
+					 & 0x0F) * 1024 * 2 + 1024 * 2) * 1024;
+		}
+		else {
+			switch (chip->PFB[0x00000000/4] & 0x00000003) {
+			case 0:
+				fix->smem_len =3D 1024 * 1024 * 32;
+				break;
+			case 1:
+				fix->smem_len =3D 1024 * 1024 * 4;
+				break;
+			case 2:
+				fix->smem_len =3D 1024 * 1024 * 8;
+				break;
+			case 3:
+			default:
+				fix->smem_len =3D 1024 * 1024 * 16;
+				break;
+			}
+		}
+		break;
+	case NV_ARCH_10:
+	case NV_ARCH_20:
+		switch ((chip->PFB[0x0000020C/4] >> 20) & 0x000000FF) {
+		case 0x02:
+			fix->smem_len =3D 1024 * 1024 * 2;
+			break;
+		case 0x04:
+			fix->smem_len =3D 1024 * 1024 * 4;
+			break;
+		case 0x08:
+			fix->smem_len =3D 1024 * 1024 * 8;
+			break;
+		case 0x10:
+			fix->smem_len =3D 1024 * 1024 * 16;
+			break;
+		case 0x20:
+			fix->smem_len =3D 1024 * 1024 * 32;
+			break;
+		case 0x40:
+			fix->smem_len =3D 1024 * 1024 * 64;
+			break;
+		case 0x80:
+			fix->smem_len =3D 1024 * 1024 * 128;
+			break;
+		default:
+			fix->smem_len =3D 1024 * 1024 * 16;
+			break;
+		}
+	}
+}
+
 static int __devinit rivafb_init_one(struct pci_dev *pd,
 				     const struct pci_device_id *ent)
 {
@@ -1586,14 +1726,22 @@
 	}
 =09
 	default_par->riva.EnableIRQ =3D 0;
-	default_par->riva.PRAMDAC =3D (unsigned *)(default_par->ctrl_base + 0x006=
80000);
-	default_par->riva.PFB =3D (unsigned *)(default_par->ctrl_base + 0x0010000=
0);
-	default_par->riva.PFIFO =3D (unsigned *)(default_par->ctrl_base + 0x00002=
000);
-	default_par->riva.PGRAPH =3D (unsigned *)(default_par->ctrl_base + 0x0040=
0000);
-	default_par->riva.PEXTDEV =3D (unsigned *)(default_par->ctrl_base + 0x001=
01000);
-	default_par->riva.PTIMER =3D (unsigned *)(default_par->ctrl_base + 0x0000=
9000);
-	default_par->riva.PMC =3D (unsigned *)(default_par->ctrl_base + 0x0000000=
0);
-	default_par->riva.FIFO =3D (unsigned *)(default_par->ctrl_base + 0x008000=
00);
+	default_par->riva.PRAMDAC =3D (unsigned *)(default_par->ctrl_base +=20
+						 0x00680000);
+	default_par->riva.PFB =3D (unsigned *)(default_par->ctrl_base +=20
+					     0x00100000);
+	default_par->riva.PFIFO =3D (unsigned *)(default_par->ctrl_base +=20
+					       0x00002000);
+	default_par->riva.PGRAPH =3D (unsigned *)(default_par->ctrl_base +=20
+						0x00400000);
+	default_par->riva.PEXTDEV =3D (unsigned *)(default_par->ctrl_base +
+						 0x00101000);
+	default_par->riva.PTIMER =3D (unsigned *)(default_par->ctrl_base +=20
+						0x00009000);
+	default_par->riva.PMC =3D (unsigned *)(default_par->ctrl_base +=20
+					     0x00000000);
+	default_par->riva.FIFO =3D (unsigned *)(default_par->ctrl_base +=20
+					      0x00800000);
=20
 	default_par->riva.PCIO =3D (U008 *)(default_par->ctrl_base + 0x00601000);
 	default_par->riva.PDIO =3D (U008 *)(default_par->ctrl_base + 0x00681000);
@@ -1603,22 +1751,26 @@
=20
 	switch (default_par->riva.Architecture) {
 	case NV_ARCH_03:
-		default_par->riva.PRAMIN =3D (unsigned *)(info->screen_base + 0x00C00000=
);
+		default_par->riva.PRAMIN =3D (unsigned *)(info->screen_base +=20
+							0x00C00000);
+		default_par->dclk_max =3D 256000000;
 		rivafb_fix.accel =3D FB_ACCEL_NV3;
 		break;
 	case NV_ARCH_04:
 	case NV_ARCH_10:
 	case NV_ARCH_20:
-		default_par->riva.PCRTC =3D (unsigned *)(default_par->ctrl_base + 0x0060=
0000);
-		default_par->riva.PRAMIN =3D (unsigned *)(default_par->ctrl_base + 0x007=
10000);
+		default_par->riva.PCRTC =3D (unsigned *)(default_par->ctrl_base=20
+						       + 0x00600000);
+		default_par->riva.PRAMIN =3D (unsigned *)(default_par->ctrl_base
+							+ 0x00710000);
+		default_par->dclk_max =3D 250000000;
 		rivafb_fix.accel =3D FB_ACCEL_NV4;
 		break;
 	}
=20
-	RivaGetConfig(&default_par->riva);
+	rivafb_get_mem_len(default_par, &rivafb_fix);
=20
-	rivafb_fix.smem_len =3D default_par->riva.RamAmountKBytes * 1024;
-	default_par->dclk_max =3D default_par->riva.MaxVClockFreqKHz * 1000;
+	info->par =3D default_par;
=20
 	if (!request_mem_region(rivafb_fix.smem_start,
 				rivafb_fix.smem_len, "rivafb")) {
@@ -1648,14 +1800,6 @@
 	}
 #endif /* CONFIG_MTRR */
=20
-	/* unlock io */
-	CRTCout(default_par, 0x11, 0xFF);/* vgaHWunlock() + riva unlock(0x7F) */
-	default_par->riva.LockUnlock(&default_par->riva, 0);
-=09
-	info->par =3D default_par;
-
-	riva_save_state(default_par, &default_par->initial_state);
-
 	if (riva_set_fbinfo(info) < 0) {
 		printk(KERN_ERR PFX "error setting initial video mode\n");
 		goto err_out_cursor;
@@ -1680,7 +1824,6 @@
 	return 0;
=20
 err_out_load_state:
-	riva_load_state(default_par, &default_par->initial_state);
 err_out_cursor:
 /* err_out_iounmap_fb: */
 	iounmap(info->screen_base);
@@ -1704,8 +1847,6 @@
 	if (!info)
 		return;
=20
-	riva_load_state(par, &par->initial_state);
-
 	unregister_framebuffer(info);
=20
 #ifdef CONFIG_MTRR
@@ -1773,9 +1914,7 @@
 int __init rivafb_init(void)
 {
 	int err;
-#ifdef MODULE
-	if (font) strncpy(fontname, font, sizeof(fontname)-1);
-#endif
+
 	err =3D pci_module_init(&rivafb_driver);
 	if (err)
 		return err;
diff -Naur linux-2.5.50-js/drivers/video/riva/rivafb.h linux/drivers/video/=
riva/rivafb.h
--- linux-2.5.50-js/drivers/video/riva/rivafb.h	2002-12-04 15:26:30.0000000=
00 +0000
+++ linux/drivers/video/riva/rivafb.h	2002-12-04 15:25:11.000000000 +0000
@@ -34,7 +34,8 @@
=20
 	struct riva_regs initial_state;	/* initial startup video mode */
 	struct riva_regs current_state;
-
+	struct fb_vgastate state;
+	atomic_t ref_count;
 	riva_cfb8_cmap_t cmap[256];	/* VGA DAC palette cache */
 	u32 riva_palette[16];
 	u32 cursor_data[32 * 32/4];

--=-Px0yh0nrfTnU24ou0BU7--

