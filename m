Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262022AbSJNQlq>; Mon, 14 Oct 2002 12:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261945AbSJNQlq>; Mon, 14 Oct 2002 12:41:46 -0400
Received: from conure.mail.pas.earthlink.net ([207.217.120.54]:40578 "EHLO
	conure.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S262022AbSJNQkd>; Mon, 14 Oct 2002 12:40:33 -0400
Date: Mon, 14 Oct 2002 09:39:31 -0700 (PDT)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCHS] fbdev updates.
In-Reply-To: <Pine.GSO.4.21.0210141209590.9580-100000@vervain.sonytel.be>
Message-ID: <Pine.LNX.4.33.0210140937040.4264-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Sun, 13 Oct 2002, James Simmons wrote:
> > This is nearly the last of the fbdev api changes (90% of them). Alot of
> > driver fixes as well. The console related stuff in each fbdev driver
> > is nearly gone!!! Please do a pull. Thank you.
> >
> > bk://fbdev.bkbits.net/fbdev-2.5
>
> Please add the output of diffstat, so we know which files you changed.

Better yet here is the BK patch via email.

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.782.2.11, 2002-10-12 12:53:47-07:00, jsimmons@maxwell.earthlink.net
  Removed last console and old api related things. Removed experimental flags.


 drivers/video/Config.in           |  181 +++++------------------
 drivers/video/Makefile            |    1
 drivers/video/anakinfb.c          |    1
 drivers/video/aty/atyfb_base.c    |   20 --
 drivers/video/aty/mach64_ct.c     |    2
 drivers/video/aty/mach64_cursor.c |    2
 drivers/video/aty/mach64_gx.c     |    2
 drivers/video/clps711xfb.c        |    2
 drivers/video/dnfb.c              |    1
 drivers/video/fbcon.c             |  168 +--------------------
 drivers/video/fbgen.c             |   16 --
 drivers/video/fbmem.c             |    9 -
 drivers/video/fm2fb.c             |    1
 drivers/video/g364fb.c            |    7
 drivers/video/hitfb.c             |    3
 drivers/video/hpfb.c              |    1
 drivers/video/macfb.c             |    5
 drivers/video/maxinefb.c          |    3
 drivers/video/modedb.c            |    8 -
 drivers/video/neofb.c             |    7
 drivers/video/offb.c              |    2
 drivers/video/pmag-ba-fb.c        |    3
 drivers/video/pmagb-b-fb.c        |    3
 drivers/video/q40fb.c             |    1
 drivers/video/sgivwfb.c           |    3
 drivers/video/skeletonfb.c        |    5
 drivers/video/tdfxfb.c            |  293 +++++++++++++++++++-------------------
 drivers/video/tx3912fb.c          |    2
 drivers/video/vesafb.c            |    4
 drivers/video/vfb.c               |    5
 include/linux/fb.h                |    7
 31 files changed, 229 insertions(+), 539 deletions(-)


diff -Nru a/drivers/video/Config.in b/drivers/video/Config.in
--- a/drivers/video/Config.in	Mon Oct 14 09:36:34 2002
+++ b/drivers/video/Config.in	Mon Oct 14 09:36:34 2002
@@ -5,7 +5,7 @@
 mainmenu_option next_comment
 comment 'Frame-buffer support'

-bool 'Support for frame buffer devices (EXPERIMENTAL)' CONFIG_FB
+bool 'Support for frame buffer devices ' CONFIG_FB

 if [ "$CONFIG_FB" = "y" ]; then
    define_bool CONFIG_DUMMY_CONSOLE y
@@ -97,7 +97,7 @@
    if [ "$CONFIG_X86" = "y" ]; then
       bool '  VESA VGA graphics console' CONFIG_FB_VESA
       tristate '  VGA 16-color graphics console' CONFIG_FB_VGA16
-      tristate '  Hercules mono graphics console (EXPERIMENTAL)' CONFIG_FB_HGA
+      tristate '  Hercules mono graphics console ' CONFIG_FB_HGA
       define_bool CONFIG_VIDEO_SELECT y
    fi
    if [ "$CONFIG_VISWS" = "y" ]; then
@@ -123,47 +123,45 @@
          hex '    Framebuffer Base Address' CONFIG_E1355_FB_BASE a8200000
       fi
    fi
-   if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
-      if [ "$CONFIG_PCI" != "n" ]; then
-	 tristate '  nVidia Riva support (EXPERIMENTAL)' CONFIG_FB_RIVA
-	 tristate '  Matrox acceleration (EXPERIMENTAL)' CONFIG_FB_MATROX
-	 if [ "$CONFIG_FB_MATROX" != "n" ]; then
-	    bool '    Millennium I/II support' CONFIG_FB_MATROX_MILLENIUM
-	    bool '    Mystique support' CONFIG_FB_MATROX_MYSTIQUE
-	    bool '    G100/G200/G400/G450/G550 support' CONFIG_FB_MATROX_G450
-	    if [ "$CONFIG_FB_MATROX_G450" = "n" ]; then
-	       bool '    G100/G200/G400 support' CONFIG_FB_MATROX_G100A
+   if [ "$CONFIG_PCI" != "n" ]; then
+      tristate '  nVidia Riva support ' CONFIG_FB_RIVA
+      tristate '  Matrox acceleration ' CONFIG_FB_MATROX
+      if [ "$CONFIG_FB_MATROX" != "n" ]; then
+	 bool '    Millennium I/II support' CONFIG_FB_MATROX_MILLENIUM
+	 bool '    Mystique support' CONFIG_FB_MATROX_MYSTIQUE
+	 bool '    G100/G200/G400/G450/G550 support' CONFIG_FB_MATROX_G450
+	 if [ "$CONFIG_FB_MATROX_G450" = "n" ]; then
+	    bool '    G100/G200/G400 support' CONFIG_FB_MATROX_G100A
+	 fi
+	 if [ "$CONFIG_FB_MATROX_G450" = "y" -o "$CONFIG_FB_MATROX_G100A" = "y" ]; then
+	    define_bool CONFIG_FB_MATROX_G100 y
+	 fi
+	 if [ "$CONFIG_I2C" != "n" ]; then
+	    dep_tristate '      Matrox I2C support' CONFIG_FB_MATROX_I2C $CONFIG_FB_MATROX $CONFIG_I2C_ALGOBIT
+	    if [ "$CONFIG_FB_MATROX_G100" = "y" ]; then
+	       dep_tristate '      G400 second head support' CONFIG_FB_MATROX_MAVEN $CONFIG_FB_MATROX_I2C
 	    fi
-	    if [ "$CONFIG_FB_MATROX_G450" = "y" -o "$CONFIG_FB_MATROX_G100A" = "y" ]; then
-	       define_bool CONFIG_FB_MATROX_G100 y
-	    fi
-            if [ "$CONFIG_I2C" != "n" ]; then
-	       dep_tristate '      Matrox I2C support' CONFIG_FB_MATROX_I2C $CONFIG_FB_MATROX $CONFIG_I2C_ALGOBIT
-	       if [ "$CONFIG_FB_MATROX_G100" = "y" ]; then
-	          dep_tristate '      G400 second head support' CONFIG_FB_MATROX_MAVEN $CONFIG_FB_MATROX_I2C
-	       fi
-            fi
-	    bool '    Multihead support' CONFIG_FB_MATROX_MULTIHEAD
-	 fi
-	 tristate '  ATI Mach64 display support (EXPERIMENTAL)' CONFIG_FB_ATY
-	 if [ "$CONFIG_FB_ATY" != "n" ]; then
-	    bool '    Mach64 GX support (EXPERIMENTAL)' CONFIG_FB_ATY_GX
-	    bool '    Mach64 CT/VT/GT/LT (incl. 3D RAGE) support' CONFIG_FB_ATY_CT
 	 fi
- 	 tristate '  ATI Radeon display support (EXPERIMENTAL)' CONFIG_FB_RADEON
-	 tristate '  ATI Rage128 display support (EXPERIMENTAL)' CONFIG_FB_ATY128
-	 tristate '  SIS acceleration (EXPERIMENTAL)' CONFIG_FB_SIS
-	 if [ "$CONFIG_FB_SIS" != "n" ]; then
-	    bool '    SIS 630/540/730 support' CONFIG_FB_SIS_300
-	    bool '    SIS 315H/315 support' CONFIG_FB_SIS_315
-	 fi
-	 tristate '  NeoMagic display support (EXPERIMENTAL)' CONFIG_FB_NEOMAGIC
-	 tristate '  3Dfx Banshee/Voodoo3 display support (EXPERIMENTAL)' CONFIG_FB_3DFX
-	 tristate '  3Dfx Voodoo Graphics (sst1) support (EXPERIMENTAL)' CONFIG_FB_VOODOO1
-	 tristate '  Trident support (EXPERIMENTAL)' CONFIG_FB_TRIDENT
-	 tristate '  Permedia3 support (EXPERIMENTAL)' CONFIG_FB_PM3
+	 bool '    Multihead support' CONFIG_FB_MATROX_MULTIHEAD
       fi
-   fi
+      tristate '  ATI Mach64 display support ' CONFIG_FB_ATY
+      if [ "$CONFIG_FB_ATY" != "n" ]; then
+	 bool '    Mach64 GX support ' CONFIG_FB_ATY_GX
+	 bool '    Mach64 CT/VT/GT/LT (incl. 3D RAGE) support' CONFIG_FB_ATY_CT
+      fi
+      tristate '  ATI Radeon display support ' CONFIG_FB_RADEON
+      tristate '  ATI Rage128 display support ' CONFIG_FB_ATY128
+      tristate '  SIS acceleration ' CONFIG_FB_SIS
+      if [ "$CONFIG_FB_SIS" != "n" ]; then
+	 bool '    SIS 630/540/730 support' CONFIG_FB_SIS_300
+	 bool '    SIS 315H/315 support' CONFIG_FB_SIS_315
+      fi
+      tristate '  NeoMagic display support ' CONFIG_FB_NEOMAGIC
+      tristate '  3Dfx Banshee/Voodoo3 display support ' CONFIG_FB_3DFX
+      tristate '  3Dfx Voodoo Graphics (sst1) support ' CONFIG_FB_VOODOO1
+      tristate '  Trident support ' CONFIG_FB_TRIDENT
+      tristate '  Permedia3 support ' CONFIG_FB_PM3
+   fi
    if [ "$CONFIG_SPARC32" = "y" -o "$CONFIG_SPARC64" = "y" ]; then
       bool '  SBUS and UPA framebuffers' CONFIG_FB_SBUS
       if [ "$CONFIG_FB_SBUS" != "n" ]; then
@@ -220,12 +218,7 @@
    bool '  Advanced low level driver options' CONFIG_FBCON_ADVANCED
    if [ "$CONFIG_FBCON_ADVANCED" = "y" ]; then
       tristate '    Monochrome support' CONFIG_FBCON_MFB
-      tristate '    2 bpp packed pixels support' CONFIG_FBCON_CFB2
-      tristate '    4 bpp packed pixels support' CONFIG_FBCON_CFB4
-      tristate '    8 bpp packed pixels support' CONFIG_FBCON_CFB8
-      tristate '    16 bpp packed pixels support' CONFIG_FBCON_CFB16
       tristate '    24 bpp packed pixels support' CONFIG_FBCON_CFB24
-      tristate '    32 bpp packed pixels support' CONFIG_FBCON_CFB32
       tristate '    Hardware acceleration support' CONFIG_FBCON_ACCEL
       tristate '    Amiga bitplanes support' CONFIG_FBCON_AFB
       tristate '    Amiga interleaved bitplanes support' CONFIG_FBCON_ILBM
@@ -234,85 +227,8 @@
       tristate '    Atari interleaved bitplanes (8 planes) support' CONFIG_FBCON_IPLAN2P8
 #      tristate '    Atari interleaved bitplanes (16 planes) support' CONFIG_FBCON_IPLAN2P16
       tristate '    VGA 16-color planar support' CONFIG_FBCON_VGA_PLANES
-      tristate '    HGA monochrome support (EXPERIMENTAL)' CONFIG_FBCON_HGA
+      tristate '    HGA monochrome support ' CONFIG_FBCON_HGA
    else
-      # Guess what we need
-      if [ "$CONFIG_FB_ACORN" = "y" -o "$CONFIG_FB_AMIGA" = "y" -o \
-	   "$CONFIG_FB_ATARI" = "y" -o "$CONFIG_FB_CYBER" = "y" -o \
-	   "$CONFIG_FB_BWTWO" = "y" -o "$CONFIG_FB_RETINAZ3" = "y" -o \
-	   "$CONFIG_FB_VIRGE" = "y" -o "$CONFIG_FB_CLGEN" = "y" ]; then
-	 define_tristate CONFIG_FBCON_MFB y
-      else
-	 if [ "$CONFIG_FB_ACORN" = "m" -o "$CONFIG_FB_AMIGA" = "m" -o \
-	      "$CONFIG_FB_ATARI" = "m" -o "$CONFIG_FB_CYBER" = "m" -o \
-	      "$CONFIG_FB_BWTWO" = "m" -o "$CONFIG_FB_RETINAZ3" = "m" -o \
-	      "$CONFIG_FB_VIRGE" = "m" -o "$CONFIG_FB_CLGEN" = "m" ]; then
-	    define_tristate CONFIG_FBCON_MFB m
-	 fi
-      fi
-      if [ "$CONFIG_FB_ACORN" = "y" -o "$CONFIG_FB_SA1100" = "y" ]; then
-	 define_tristate CONFIG_FBCON_CFB2 y
-	 define_tristate CONFIG_FBCON_CFB4 y
-      else
-	 if [ "$CONFIG_FB_ACORN" = "m" -o "$CONFIG_FB_SA1100" = "m" ]; then
-	    define_tristate CONFIG_FBCON_CFB2 m
-	    define_tristate CONFIG_FBCON_CFB4 m
-	 fi
-      fi
-      if [ "$CONFIG_FB_ACORN" = "y" -o "$CONFIG_FB_ATARI" = "y" -o \
-	   "$CONFIG_FB_P9100" = "y" -o "$CONFIG_FB_CYBER2000" = "y" -o \
-	   "$CONFIG_FB_RADEON" = "y" -o "$CONFIG_FB_TGA" = "y" -o \
-	   "$CONFIG_FB_SIS" = "y" -o "$CONFIG_FB_PM3" = "y" -o \
-	   "$CONFIG_FB_TCX" = "y" -o "$CONFIG_FB_CGTHREE" = "y" -o \
-	   "$CONFIG_FB_CONTROL" = "y" -o "$CONFIG_FB_CLGEN" = "y" -o \
-	   "$CONFIG_FB_CGFOURTEEN" = "y" -o "$CONFIG_FB_TRIDENT" = "y" -o \
-	   "$CONFIG_FB_VIRGE" = "y" -o "$CONFIG_FB_CYBER" = "y" -o \
-	   "$CONFIG_FB_VALKYRIE" = "y" -o "$CONFIG_FB_PLATINUM" = "y" -o \
-           "$CONFIG_FB_IGA" = "y" -o "$CONFIG_FB_MATROX" = "y" -o \
-	   "$CONFIG_FB_CT65550" = "y" -o "$CONFIG_FB_PM2" = "y" -o \
-	   "$CONFIG_FB_SA1100" = "y" ]; then
-	 define_tristate CONFIG_FBCON_CFB8 y
-      else
-	 if [ "$CONFIG_FB_ACORN" = "m" -o "$CONFIG_FB_ATARI" = "m" -o \
-	      "$CONFIG_FB_P9100" = "m" -o "$CONFIG_FB_CYBER2000" = "m" -o \
-	      "$CONFIG_FB_RADEON" = "m" -o "$CONFIG_FB_TGA" = "m" -o \
-	      "$CONFIG_FB_SIS" = "m" -o "$CONFIG_FB_PM3" = "m" -o \
-	      "$CONFIG_FB_TCX" = "m" -o "$CONFIG_FB_CGTHREE" = "m" -o \
-	      "$CONFIG_FB_CONTROL" = "m" -o "$CONFIG_FB_CLGEN" = "m" -o \
-	      "$CONFIG_FB_CGFOURTEEN" = "m" -o "$CONFIG_FB_TRIDENT" = "m" -o \
-	      "$CONFIG_FB_VIRGE" = "m" -o "$CONFIG_FB_CYBER" = "m" -o \
-	      "$CONFIG_FB_VALKYRIE" = "m" -o "$CONFIG_FB_PLATINUM" = "m" -o \
-              "$CONFIG_FB_IGA" = "m" -o "$CONFIG_FB_MATROX" = "m" -o \
-	      "$CONFIG_FB_CT65550" = "m" -o "$CONFIG_FB_PM2" = "m" -o \
-	      "$CONFIG_FB_SA1100" = "m" ]; then
-	    define_tristate CONFIG_FBCON_CFB8 m
-	 fi
-      fi
-      if [ "$CONFIG_FB_ATARI" = "y" -o "$CONFIG_FB_PM3" = "y" -o \
-	   "$CONFIG_FB_SIS" = "y" -o "$CONFIG_FB_PVR2" = "y" -o \
-	   "$CONFIG_FB_TRIDENT" = "y" -o "$CONFIG_FB_TBOX" = "y" -o \
-	   "$CONFIG_FB_VOODOO1" = "y" -o "$CONFIG_FB_RADEON" = "y" -o \
-	   "$CONFIG_FB_CONTROL" = "y" -o "$CONFIG_FB_CLGEN" = "y" -o \
-	   "$CONFIG_FB_VIRGE" = "y" -o "$CONFIG_FB_CYBER" = "y" -o \
-	   "$CONFIG_FB_VALKYRIE" = "y" -o "$CONFIG_FB_PLATINUM" = "y" -o \
-	   "$CONFIG_FB_CT65550" = "y" -o "$CONFIG_FB_MATROX" = "y" -o \
-	   "$CONFIG_FB_PM2" = "y" -o "$CONFIG_FB_CYBER2000" = "y" -o \
-	   "$CONFIG_FB_SA1100" = "y" ]; then
-	 define_tristate CONFIG_FBCON_CFB16 y
-      else
-	 if [ "$CONFIG_FB_ATARI" = "m" -o "$CONFIG_FB_SIS" = "m" -o \
-	      "$CONFIG_FB_RADEON" = "m" -o "$CONFIG_FB_PVR2" = "m" -o \
-	      "$CONFIG_FB_TRIDENT" = "m" -o "$CONFIG_FB_TBOX" = "m" -o \
-	      "$CONFIG_FB_VOODOO1" = "m" -o "$CONFIG_FB_PM3" = "m" -o \
-	      "$CONFIG_FB_CONTROL" = "m" -o "$CONFIG_FB_CLGEN" = "m" -o \
-	      "$CONFIG_FB_VIRGE" = "m" -o "$CONFIG_FB_CYBER" = "m" -o \
-	      "$CONFIG_FB_VALKYRIE" = "m" -o "$CONFIG_FB_PLATINUM" = "m" -o \
-	      "$CONFIG_FB_CT65550" = "m" -o "$CONFIG_FB_MATROX" = "m" -o \
-	      "$CONFIG_FB_PM2" = "m" -o "$CONFIG_FB_CYBER2000" = "m" -o \
-	      "$CONFIG_FB_SA1100" = "y" ]; then
-	    define_tristate CONFIG_FBCON_CFB16 m
-	 fi
-      fi
       if [ "$CONFIG_FB_CYBER2000" = "y" -o "$CONFIG_FB_VOODOO1" = "y" -o \
 	   "$CONFIG_FB_CLGEN" = "y" -o "$CONFIG_FB_PVR2" = "y" -o \
 	   "$CONFIG_FB_MATROX" = "y" -o "$CONFIG_FB_PM2" = "y" -o \
@@ -324,25 +240,6 @@
 	      "$CONFIG_FB_ATY128" = "m" -o "$CONFIG_FB_RADEON" = "m" -o \
 	      "$CONFIG_FB_CYBER2000" = "m" -o "$CONFIG_FB_PVR2" = "m" ]; then
 	    define_tristate CONFIG_FBCON_CFB24 m
-	 fi
-      fi
-      if [ "$CONFIG_FB_ATARI" = "y" -o "$CONFIG_FB_RADEON" = "y" -o \
-	   "$CONFIG_FB_VOODOO1" = "y" -o "$CONFIG_FB_TRIDENT" = "y" -o \
-	   "$CONFIG_FB_CONTROL" = "y" -o "$CONFIG_FB_CLGEN" = "y" -o \
-	   "$CONFIG_FB_TGA" = "y" -o "$CONFIG_FB_PLATINUM" = "y" -o \
-	   "$CONFIG_FB_MATROX" = "y" -o "$CONFIG_FB_PM2" = "y" -o \
-	   "$CONFIG_FB_PVR2" = "y" -o "$CONFIG_FB_PM3" = "y" -o \
-	   "$CONFIG_FB_SIS" = "y" ]; then
-	 define_tristate CONFIG_FBCON_CFB32 y
-      else
-	 if [ "$CONFIG_FB_ATARI" = "m" -o "$CONFIG_FB_RADEON" = "m" -o \
-	      "$CONFIG_FB_VOODOO1" = "m" -o "$CONFIG_FB_TRIDENT" = "m" -o \
-	      "$CONFIG_FB_CONTROL" = "m" -o "$CONFIG_FB_CLGEN" = "m" -o \
-	      "$CONFIG_FB_TGA" = "m" -o "$CONFIG_FB_PLATINUM" = "m" -o \
-	      "$CONFIG_FB_MATROX" = "m" -o "$CONFIG_FB_PM2" = "m" -o \
-	      "$CONFIG_FB_SIS" = "m" -o "$CONFIG_FB_PVR2" = "m" -o \
-	      "$CONFIG_FB_PM3" = "m" ]; then
-	    define_tristate CONFIG_FBCON_CFB32 m
 	 fi
       fi
       if [ "$CONFIG_FB_NEOMAGIC" = "y" -o "$CONFIG_FB_VESA" = "y" -o \
diff -Nru a/drivers/video/Makefile b/drivers/video/Makefile
--- a/drivers/video/Makefile	Mon Oct 14 09:36:34 2002
+++ b/drivers/video/Makefile	Mon Oct 14 09:36:34 2002
@@ -106,7 +106,6 @@
 obj-$(CONFIG_FBCON_IPLAN2P2)      += fbcon-iplan2p2.o
 obj-$(CONFIG_FBCON_IPLAN2P4)      += fbcon-iplan2p4.o
 obj-$(CONFIG_FBCON_IPLAN2P8)      += fbcon-iplan2p8.o
-obj-$(CONFIG_FBCON_MFB)           += fbcon-mfb.o
 obj-$(CONFIG_FBCON_HGA)           += fbcon-hga.o
 obj-$(CONFIG_FBCON_STI)           += fbcon-sti.o
 obj-$(CONFIG_FBCON_ACCEL)	  += fbcon-accel.o
diff -Nru a/drivers/video/anakinfb.c b/drivers/video/anakinfb.c
--- a/drivers/video/anakinfb.c	Mon Oct 14 09:36:34 2002
+++ b/drivers/video/anakinfb.c	Mon Oct 14 09:36:34 2002
@@ -62,7 +62,6 @@

 static struct fb_ops anakinfb_ops = {
 	.owner		= THIS_MODULE,
-	.fb_set_var	= gen_set_var,
 	.fb_setcolreg	= anakinfb_setcolreg,
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
diff -Nru a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
--- a/drivers/video/aty/atyfb_base.c	Mon Oct 14 09:36:34 2002
+++ b/drivers/video/aty/atyfb_base.c	Mon Oct 14 09:36:34 2002
@@ -146,11 +146,11 @@
 static int atyfb_set_par(struct fb_info *info);
 static int atyfb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
 			   u_int transp, struct fb_info *info);
-static int atyfb_pan_display(struct fb_var_screeninfo *var, int con,
+static int atyfb_pan_display(struct fb_var_screeninfo *var,
 			     struct fb_info *info);
 static int atyfb_blank(int blank, struct fb_info *info);
 static int atyfb_ioctl(struct inode *inode, struct file *file, u_int cmd,
-		       u_long arg, int con, struct fb_info *info);
+		       u_long arg, struct fb_info *info);
 extern void atyfb_fillrect(struct fb_info *info, struct fb_fillrect *rect);
 extern void atyfb_copyarea(struct fb_info *info, struct fb_copyarea *area);
 extern void atyfb_imageblit(struct fb_info *info, struct fb_image *image);
@@ -195,17 +195,10 @@
 int atyfb_setup(char *);
 #endif

-int gen_get_var(struct fb_var_screeninfo *var, int con, struct fb_info *info)
-{
-        *var = info->var;
-        return 0;
-}
-
 static struct fb_ops atyfb_ops = {
 	.owner		= THIS_MODULE,
 	.fb_open	= atyfb_open,
 	.fb_release	= atyfb_release,
-	.fb_set_var	= gen_set_var,
 	.fb_check_var	= atyfb_check_var,
 	.fb_set_par	= atyfb_set_par,
 	.fb_setcolreg	= atyfb_setcolreg,
@@ -1002,7 +995,7 @@
      *  This call looks only at xoffset, yoffset and the FB_VMODE_YWRAP flag
      */

-static int atyfb_pan_display(struct fb_var_screeninfo *var, int con,
+static int atyfb_pan_display(struct fb_var_screeninfo *var,
 			     struct fb_info *info)
 {
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
@@ -1044,7 +1037,7 @@
 #endif

 static int atyfb_ioctl(struct inode *inode, struct file *file, u_int cmd,
-		       u_long arg, int con, struct fb_info *info)
+		       u_long arg, struct fb_info *info)
 {
 #if defined(__sparc__) || (defined(DEBUG) && defined(CONFIG_FB_ATY_CT))
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
@@ -1829,9 +1822,7 @@
 	info->node = NODEV;
 	info->fbops = &atyfb_ops;
 	info->pseudo_palette = pseudo_palette;
-	info->currcon = -1;
 	strcpy(info->fontname, fontname);
-	info->updatevar = gen_update_var;
 	info->flags = FBINFO_FLAG_DEFAULT;

 #ifdef CONFIG_PMAC_BACKLIGHT
@@ -1955,9 +1946,6 @@
 	info->var = var;

 	fb_alloc_cmap(&info->cmap, 256, 0);
-
-	var.activate = FB_ACTIVATE_NOW;
-	gen_set_var(&var, -1, info);

 	if (register_framebuffer(info) < 0)
 		return 0;
diff -Nru a/drivers/video/aty/mach64_ct.c b/drivers/video/aty/mach64_ct.c
--- a/drivers/video/aty/mach64_ct.c	Mon Oct 14 09:36:34 2002
+++ b/drivers/video/aty/mach64_ct.c	Mon Oct 14 09:36:34 2002
@@ -7,8 +7,6 @@

 #include <asm/io.h>

-#include <video/fbcon.h>
-
 #include <video/mach64.h>
 #include "atyfb.h"

diff -Nru a/drivers/video/aty/mach64_cursor.c b/drivers/video/aty/mach64_cursor.c
--- a/drivers/video/aty/mach64_cursor.c	Mon Oct 14 09:36:34 2002
+++ b/drivers/video/aty/mach64_cursor.c	Mon Oct 14 09:36:34 2002
@@ -11,8 +11,6 @@
 #include <asm/io.h>
 #include <asm/uaccess.h>

-#include <video/fbcon.h>
-
 #ifdef __sparc__
 #include <asm/pbm.h>
 #include <asm/fbio.h>
diff -Nru a/drivers/video/aty/mach64_gx.c b/drivers/video/aty/mach64_gx.c
--- a/drivers/video/aty/mach64_gx.c	Mon Oct 14 09:36:34 2002
+++ b/drivers/video/aty/mach64_gx.c	Mon Oct 14 09:36:34 2002
@@ -9,8 +9,6 @@

 #include <asm/io.h>

-#include <video/fbcon.h>
-
 #include <video/mach64.h>
 #include "atyfb.h"

diff -Nru a/drivers/video/clps711xfb.c b/drivers/video/clps711xfb.c
--- a/drivers/video/clps711xfb.c	Mon Oct 14 09:36:34 2002
+++ b/drivers/video/clps711xfb.c	Mon Oct 14 09:36:34 2002
@@ -194,7 +194,6 @@
 	.owner		= THIS_MODULE,
 	.fb_check_var	= clps7111fb_check_var,
 	.fb_set_par	= clps7111fb_set_par,
-	.fb_set_var	= gen_set_var,
 	.fb_setcolreg	= clps7111fb_setcolreg,
 	.fb_blank	= clps7111fb_blank,
 	.fb_fillrect	= cfb_fillrect,
@@ -322,7 +321,6 @@
 		clps_writeb(clps_readb(PDDR) | EDB_PD3_LCDBL, PDDR);
 	}

-	gen_set_var(&cfb->var, -1, cfb);
 	err = register_framebuffer(cfb);

 out:	return err;
diff -Nru a/drivers/video/dnfb.c b/drivers/video/dnfb.c
--- a/drivers/video/dnfb.c	Mon Oct 14 09:36:34 2002
+++ b/drivers/video/dnfb.c	Mon Oct 14 09:36:34 2002
@@ -117,7 +117,6 @@

 static struct fb_ops dn_fb_ops = {
 	.owner		= THIS_MODULE,
-	.fb_set_var	= gen_set_var,
 	.fb_blank	= dnfb_blank,
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= dnfb_copyarea,
diff -Nru a/drivers/video/fbcon.c b/drivers/video/fbcon.c
--- a/drivers/video/fbcon.c	Mon Oct 14 09:36:34 2002
+++ b/drivers/video/fbcon.c	Mon Oct 14 09:36:34 2002
@@ -335,14 +335,14 @@
     int unit, err;

     var->activate |= FB_ACTIVATE_TEST;
-    err = fb->fb_set_var(var, PROC_CONSOLE(info), info);
+    err = gen_set_var(var, PROC_CONSOLE(info), info);
     var->activate &= ~FB_ACTIVATE_TEST;
     gen_set_disp(PROC_CONSOLE(info), info);
     if (err)
             return err;
     for (unit = 0; unit < MAX_NR_CONSOLES; unit++)
             if (fb_display[unit].conp && con2fb_map[unit] == fbidx) {
-                    fb->fb_set_var(var, unit, info);
+                    gen_set_var(var, unit, info);
 		    gen_set_disp(unit, info);
 	    }
     return 0;
@@ -503,7 +503,6 @@
     return display_desc;
 }

-
 static void fbcon_init(struct vc_data *conp, int init)
 {
     int unit = conp->vc_num;
@@ -512,6 +511,10 @@
     /* on which frame buffer will we open this console? */
     info = registered_fb[(int)con2fb_map[unit]];

+    /* We trust the mode the driver supplies. */
+    if (info->fbops->fb_set_par)
+	info->fbops->fb_set_par(info);
+
     gen_set_disp(unit, info);
     DPRINTK("mode:   %s\n",info->modename);
     DPRINTK("visual: %d\n",info->fix.visual);
@@ -991,7 +994,7 @@
     info->var.xoffset = 0;
     info->var.yoffset = p->yscroll*fontheight(p);
     info->var.vmode |= FB_VMODE_YWRAP;
-    info->updatevar(unit, info);
+    gen_update_var(unit, info);
     scrollback_max += count;
     if (scrollback_max > scrollback_phys_max)
 	scrollback_max = scrollback_phys_max;
@@ -1009,7 +1012,7 @@
     info->var.xoffset = 0;
     info->var.yoffset = p->yscroll*fontheight(p);
     info->var.vmode |= FB_VMODE_YWRAP;
-    info->updatevar(unit, info);
+    gen_update_var(unit, info);
     scrollback_max -= count;
     if (scrollback_max < 0)
 	scrollback_max = 0;
@@ -1030,7 +1033,7 @@
     info->var.xoffset = 0;
     info->var.yoffset = p->yscroll*fontheight(p);
     info->var.vmode &= ~FB_VMODE_YWRAP;
-    info->updatevar(unit, info);
+    gen_update_var(unit, info);
     if (p->dispsw->clear_margins)
 	p->dispsw->clear_margins(conp, p, 1);
     scrollback_max += count;
@@ -1054,7 +1057,7 @@
     info->var.xoffset = 0;
     info->var.yoffset = p->yscroll*fontheight(p);
     info->var.vmode &= ~FB_VMODE_YWRAP;
-    info->updatevar(unit, info);
+    gen_update_var(unit, info);
     if (p->dispsw->clear_margins)
 	p->dispsw->clear_margins(conp, p, 1);
     scrollback_max -= count;
@@ -2145,7 +2148,7 @@
 	offset -= limit;
     info->var.xoffset = 0;
     info->var.yoffset = offset*fontheight(p);
-    info->updatevar(unit, info);
+    gen_update_var(unit, info);
     if (!scrollback_current)
 	fbcon_cursor(conp, CM_DRAW);
     return 0;
@@ -2268,154 +2271,6 @@
 	image.dx = x;
 	info->fbops->fb_imageblit(info, &image);
 	done = 1;
-#else
-#if defined(CONFIG_FBCON_CFB16) || defined(CONFIG_FBCON_CFB24) || \
-    defined(CONFIG_FBCON_CFB32) || defined(CONFIG_FB_SBUS)
-        if (info->fix.visual == FB_VISUAL_DIRECTCOLOR) {
-	    unsigned int val;		/* max. depth 32! */
-	    int bdepth;
-	    int redshift, greenshift, blueshift;
-
-	    /* Bug: Doesn't obey msb_right ... (who needs that?) */
-	    redshift   = info->var.red.offset;
-	    greenshift = info->var.green.offset;
-	    blueshift  = info->var.blue.offset;
-
-	    if (depth >= 24 && (depth % 8) == 0) {
-		/* have at least 8 bits per color */
-		src = logo;
-		bdepth = depth/8;
-		for( y1 = 0; y1 < LOGO_H; y1++ ) {
-		    dst = fb + y1*line + x*bdepth;
-		    for( x1 = 0; x1 < LOGO_W; x1++, src++ ) {
-			val = (*src << redshift) |
-			      (*src << greenshift) |
-			      (*src << blueshift);
-			if (bdepth == 4 && !((long)dst & 3)) {
-			    /* Some cards require 32bit access */
-			    fb_writel (val, dst);
-			    dst += 4;
-			} else if (bdepth == 2 && !((long)dst & 1)) {
-			    /* others require 16bit access */
-			    fb_writew (val,dst);
-			    dst +=2;
-			} else {
-#ifdef __LITTLE_ENDIAN
-			    for( i = 0; i < bdepth; ++i )
-#else
-			    for( i = bdepth-1; i >= 0; --i )
-#endif
-			        fb_writeb (val >> (i*8), dst++);
-			}
-		    }
-		}
-	    }
-	    else if (depth >= 12 && depth <= 23) {
-	        /* have 4..7 bits per color, using 16 color image */
-		unsigned int pix;
-		src = linux_logo16;
-		bdepth = (depth+7)/8;
-		for( y1 = 0; y1 < LOGO_H; y1++ ) {
-		    dst = fb + y1*line + x*bdepth;
-		    for( x1 = 0; x1 < LOGO_W/2; x1++, src++ ) {
-			pix = *src >> 4; /* upper nibble */
-			val = (pix << redshift) |
-			      (pix << greenshift) |
-			      (pix << blueshift);
-#ifdef __LITTLE_ENDIAN
-			for( i = 0; i < bdepth; ++i )
-#else
-			for( i = bdepth-1; i >= 0; --i )
-#endif
-			    fb_writeb (val >> (i*8), dst++);
-			pix = *src & 0x0f; /* lower nibble */
-			val = (pix << redshift) |
-			      (pix << greenshift) |
-			      (pix << blueshift);
-#ifdef __LITTLE_ENDIAN
-			for( i = 0; i < bdepth; ++i )
-#else
-			for( i = bdepth-1; i >= 0; --i )
-#endif
-			    fb_writeb (val >> (i*8), dst++);
-		    }
-		}
-	    }
-	    done = 1;
-        }
-#endif
-#if defined(CONFIG_FBCON_CFB16) || defined(CONFIG_FBCON_CFB24) || \
-    defined(CONFIG_FBCON_CFB32) || defined(CONFIG_FB_SBUS)
-	if ((depth % 8 == 0) && (info->fix.visual == FB_VISUAL_TRUECOLOR)) {
-	    /* Modes without color mapping, needs special data transformation... */
-	    unsigned int val;		/* max. depth 32! */
-	    int bdepth = depth/8;
-	    unsigned char mask[9] = { 0,0x80,0xc0,0xe0,0xf0,0xf8,0xfc,0xfe,0xff };
-	    unsigned char redmask, greenmask, bluemask;
-	    int redshift, greenshift, blueshift;
-
-	    /* Bug: Doesn't obey msb_right ... (who needs that?) */
-	    redmask   = mask[info->var.red.length   < 8 ? info->var.red.length   : 8];
-	    greenmask = mask[info->var.green.length < 8 ? info->var.green.length : 8];
-	    bluemask  = mask[info->var.blue.length  < 8 ? info->var.blue.length  : 8];
-	    redshift   = info->var.red.offset   - (8 - info->var.red.length);
-	    greenshift = info->var.green.offset - (8 - info->var.green.length);
-	    blueshift  = info->var.blue.offset  - (8 - info->var.blue.length);
-
-	    src = logo;
-	    for( y1 = 0; y1 < LOGO_H; y1++ ) {
-		dst = fb + y1*line + x*bdepth;
-		for( x1 = 0; x1 < LOGO_W; x1++, src++ ) {
-		    val = safe_shift((linux_logo_red[*src-32]   & redmask), redshift) |
-		          safe_shift((linux_logo_green[*src-32] & greenmask), greenshift) |
-		          safe_shift((linux_logo_blue[*src-32]  & bluemask), blueshift);
-		    if (bdepth == 4 && !((long)dst & 3)) {
-			/* Some cards require 32bit access */
-			fb_writel (val, dst);
-			dst += 4;
-		    } else if (bdepth == 2 && !((long)dst & 1)) {
-			/* others require 16bit access */
-			fb_writew (val,dst);
-			dst +=2;
-		    } else {
-#ifdef __LITTLE_ENDIAN
-			for( i = 0; i < bdepth; ++i )
-#else
-			for( i = bdepth-1; i >= 0; --i )
-#endif
-			    fb_writeb (val >> (i*8), dst++);
-		    }
-		}
-	    }
-	    done = 1;
-	}
-#endif
-#if defined(CONFIG_FBCON_CFB4)
-	if (depth == 4 && info->fix.type == FB_TYPE_PACKED_PIXELS) {
-		src = logo;
-		for( y1 = 0; y1 < LOGO_H; y1++) {
-			dst = fb + y1*line + x/2;
-			for( x1 = 0; x1 < LOGO_W/2; x1++) {
-				u8 q = *src++;
-				q = (q << 4) | (q >> 4);
-				fb_writeb (q, dst++);
-			}
-		}
-		done = 1;
-	}
-#endif
-#if defined(CONFIG_FBCON_CFB8) || defined(CONFIG_FB_SBUS)
-	if (depth == 8 && info->fix.type == FB_TYPE_PACKED_PIXELS) {
-	    /* depth 8 or more, packed, with color registers */
-
-	    src = logo;
-	    for( y1 = 0; y1 < LOGO_H; y1++ ) {
-		dst = fb + y1*line + x;
-		for( x1 = 0; x1 < LOGO_W; x1++ )
-		    fb_writeb (*src++, dst++);
-	    }
-	    done = 1;
-	}
 #endif
 #if defined(CONFIG_FBCON_AFB) || defined(CONFIG_FBCON_ILBM) || \
     defined(CONFIG_FBCON_IPLAN2P2) || defined(CONFIG_FBCON_IPLAN2P4) || \
@@ -2526,7 +2381,6 @@
 		done = 1;
 	}
 #endif
-#endif	/* CONFIG_FBCON_ACCEL */
     }

     if (info->fbops->fb_rasterimg)
diff -Nru a/drivers/video/fbgen.c b/drivers/video/fbgen.c
--- a/drivers/video/fbgen.c	Mon Oct 14 09:36:34 2002
+++ b/drivers/video/fbgen.c	Mon Oct 14 09:36:34 2002
@@ -43,7 +43,7 @@
 					info->fbops->fb_set_par(info);

 				if (info->fbops->fb_pan_display)
-					info->fbops->fb_pan_display(&info->var, con, info);
+					info->fbops->fb_pan_display(&info->var, info);
 				fb_set_cmap(&info->cmap, 1, info);
 			}
 		}
@@ -51,8 +51,7 @@
 	return 0;
 }

-int fbgen_pan_display(struct fb_var_screeninfo *var, int con,
-		      struct fb_info *info)
+int fbgen_pan_display(struct fb_var_screeninfo *var, struct fb_info *info)
 {
     int xoffset = var->xoffset;
     int yoffset = var->yoffset;
@@ -62,12 +61,11 @@
 	xoffset + info->var.xres > info->var.xres_virtual ||
 	yoffset + info->var.yres > info->var.yres_virtual)
 	return -EINVAL;
-    if (con == info->currcon) {
-	if (info->fbops->fb_pan_display) {
-	    if ((err = info->fbops->fb_pan_display(var, con, info)))
+    if (info->fbops->fb_pan_display) {
+    	if ((err = info->fbops->fb_pan_display(var, info)))
 		return err;
-	} else
-	    return -EINVAL;
+	else
+	    	return -EINVAL;
     }
     info->var.xoffset = var->xoffset;
     info->var.yoffset = var->yoffset;
@@ -87,7 +85,7 @@

 	if (con == info->currcon) {
 		if (info->fbops->fb_pan_display) {
-			if ((err = info->fbops->fb_pan_display(&info->var, con, info)))
+			if ((err = info->fbops->fb_pan_display(&info->var, info)))
 				return err;
 		}
 	}
diff -Nru a/drivers/video/fbmem.c b/drivers/video/fbmem.c
--- a/drivers/video/fbmem.c	Mon Oct 14 09:36:34 2002
+++ b/drivers/video/fbmem.c	Mon Oct 14 09:36:34 2002
@@ -377,7 +377,7 @@
 		if (*fi)
 			clen += sprintf(buf + clen, "%d %s\n",
 				        GET_FB_IDX((*fi)->node),
-				        (*fi)->modename);
+				        (*fi)->fix.id);
 	*start = buf + offset;
 	if (clen > offset)
 		clen -= offset;
@@ -485,7 +485,7 @@
 			i = set_all_vcs(fbidx, fb, &var, info);
 			if (i) return i;
 		} else {
-			i = fb->fb_set_var(&var, PROC_CONSOLE(info), info);
+			i = gen_set_var(&var, PROC_CONSOLE(info), info);
 			if (i) return i;
 			gen_set_disp(PROC_CONSOLE(info), info);
 		}
@@ -507,7 +507,7 @@
 			return -EFAULT;
 		if (fb->fb_pan_display == NULL)
 			return (var.xoffset || var.yoffset) ? -EINVAL : 0;
-		if ((i=fb->fb_pan_display(&var, PROC_CONSOLE(info), info)))
+		if ((i=fb->fb_pan_display(&var, info)))
 			return i;
 		if (copy_to_user((void *) arg, &var, sizeof(var)))
 			return -EFAULT;
@@ -547,8 +547,7 @@
 	default:
 		if (fb->fb_ioctl == NULL)
 			return -EINVAL;
-		return fb->fb_ioctl(inode, file, cmd, arg, PROC_CONSOLE(info),
-				    info);
+		return fb->fb_ioctl(inode, file, cmd, arg, info);
 	}
 }

diff -Nru a/drivers/video/fm2fb.c b/drivers/video/fm2fb.c
--- a/drivers/video/fm2fb.c	Mon Oct 14 09:36:34 2002
+++ b/drivers/video/fm2fb.c	Mon Oct 14 09:36:34 2002
@@ -173,7 +173,6 @@

 static struct fb_ops fm2fb_ops = {
 	.owner		= THIS_MODULE,
-	.fb_set_var	= gen_set_var,
 	.fb_setcolreg	= fm2fb_setcolreg,
 	.fb_blank	= fm2fb_blank,
 	.fb_fillrect	= cfb_fillrect,
diff -Nru a/drivers/video/g364fb.c b/drivers/video/g364fb.c
--- a/drivers/video/g364fb.c	Mon Oct 14 09:36:34 2002
+++ b/drivers/video/g364fb.c	Mon Oct 14 09:36:34 2002
@@ -31,8 +31,6 @@
 #include <asm/io.h>
 #include <asm/jazz.h>

-#include <video/fbcon.h>
-
 /*
  * Various defines for the G364
  */
@@ -108,7 +106,7 @@
  */
 int g364fb_init(void);

-static int g364fb_pan_display(struct fb_var_screeninfo *var, int con,
+static int g364fb_pan_display(struct fb_var_screeninfo *var,
 			      struct fb_info *info);
 static int g364fb_setcolreg(u_int regno, u_int red, u_int green,
 			    u_int blue, u_int transp,
@@ -117,7 +115,6 @@

 static struct fb_ops g364fb_ops = {
 	.owner		= THIS_MODULE,
-	.fb_set_var	= gen_set_var,
 	.fb_setcolreg	= g364fb_setcolreg,
 	.fb_pan_display	= g364fb_pan_display,
 	.fb_blank	= g364fb_blank,
@@ -148,7 +145,7 @@
  *
  *  This call looks only at xoffset, yoffset and the FB_VMODE_YWRAP flag
  */
-static int g364fb_pan_display(struct fb_var_screeninfo *var, int con,
+static int g364fb_pan_display(struct fb_var_screeninfo *var,
 			      struct fb_info *info)
 {
 	if (var->xoffset || var->yoffset + var->yres > var->yres_virtual)
diff -Nru a/drivers/video/hitfb.c b/drivers/video/hitfb.c
--- a/drivers/video/hitfb.c	Mon Oct 14 09:36:34 2002
+++ b/drivers/video/hitfb.c	Mon Oct 14 09:36:34 2002
@@ -122,7 +122,6 @@

 static struct fb_ops hitfb_ops = {
 	.owner		= THIS_MODULE,
-	.fb_set_var	= gen_set_var,
 	.fb_check_var	= hitfb_check_var,
 	.fb_set_par	= hitfb_set_par,
 	.fb_setcolreg	= hitfb_setcolreg,
@@ -167,8 +166,6 @@
 	size = (fb_info.var.bits_per_pixel == 8) ? 256 : 16;
 	fb_alloc_cmap(&fb_info.cmap, size, 0);

-	gen_set_var(&fb_info.var, -1, &fb_info);
-
 	if (register_framebuffer(&fb_info) < 0)
 		return -EINVAL;

diff -Nru a/drivers/video/hpfb.c b/drivers/video/hpfb.c
--- a/drivers/video/hpfb.c	Mon Oct 14 09:36:34 2002
+++ b/drivers/video/hpfb.c	Mon Oct 14 09:36:34 2002
@@ -101,7 +101,6 @@

 static struct fb_ops hpfb_ops = {
 	.owner		= THIS_MODULE,
-	.fb_set_var	= gen_set_var,
 	.fb_setcolreg	= hpfb_setcolreg,
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= hpfb_copyarea,
diff -Nru a/drivers/video/macfb.c b/drivers/video/macfb.c
--- a/drivers/video/macfb.c	Mon Oct 14 09:36:34 2002
+++ b/drivers/video/macfb.c	Mon Oct 14 09:36:34 2002
@@ -222,7 +222,7 @@

 	local_irq_save(flags);

-	/* fbcon will set an entire colourmap, but X won't.  Hopefully
+	/* fbdev will set an entire colourmap, but X won't.  Hopefully
 	   this should accomodate both of them */
 	if (regno != lastreg+1) {
 		int i;
@@ -585,7 +585,6 @@

 static struct fb_ops macfb_ops = {
 	.owner		= THIS_MODULE,
-	.fb_set_var	= gen_set_var,
 	.fb_setcolreg	= macfb_setcolreg,
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
@@ -951,8 +950,6 @@
 	fb_info.fbops		= &macfb_ops;
 	fb_info.var		= macfb_defined;
 	fb_info.fix		= macfb_fix;
-	fb_info.currcon		= -1;
-	fb_info.updatevar	= gen_update_var;
 	fb_info.pseudo_palette	= pseudo_palette;
 	fb_info.flags		= FBINFO_FLAG_DEFAULT;

diff -Nru a/drivers/video/maxinefb.c b/drivers/video/maxinefb.c
--- a/drivers/video/maxinefb.c	Mon Oct 14 09:36:34 2002
+++ b/drivers/video/maxinefb.c	Mon Oct 14 09:36:34 2002
@@ -111,7 +111,6 @@

 static struct fb_ops maxinefb_ops = {
 	.owner		= THIS_MODULE,
-	.fb_set_var	= gen_set_var,
 	.fb_setcolreg	= maxinefb_setcolreg,
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
@@ -158,8 +157,6 @@
 	fb_info.screen_base = (char *) maxinefb_fix.smem_start;
 	fb_info.var = maxinefb_defined;
 	fb_info.fix = maxinefb_fix;
-	fb_info.currcon = -1;
-	fb_info.updatevar = gen_update_var;
 	fb_info.flags = FBINFO_FLAG_DEFAULT;

 	fb_alloc_cmap(&fb_info.cmap, 256, 0);
diff -Nru a/drivers/video/modedb.c b/drivers/video/modedb.c
--- a/drivers/video/modedb.c	Mon Oct 14 09:36:34 2002
+++ b/drivers/video/modedb.c	Mon Oct 14 09:36:34 2002
@@ -16,8 +16,6 @@
 #include <linux/fb.h>
 #include <linux/sched.h>

-#include <video/fbcon.h>
-
 #undef DEBUG

 #define name_matches(v, s, l) \
@@ -277,7 +275,7 @@
 int __fb_try_mode(struct fb_var_screeninfo *var, struct fb_info *info,
 		  const struct fb_videomode *mode, unsigned int bpp)
 {
-    int err;
+    int err = 1;

     DPRINTK("Trying mode %s %dx%d-%d@%d\n", mode->name ? mode->name : "noname",
 	    mode->xres, mode->yres, bpp, mode->refresh);
@@ -298,9 +296,9 @@
     var->vsync_len = mode->vsync_len;
     var->sync = mode->sync;
     var->vmode = mode->vmode;
-    err = info->fbops->fb_set_var(var, PROC_CONSOLE(info), info);
+    if (info->fbops->fb_check_var)
+    	err = info->fbops->fb_check_var(var, info);
     var->activate &= ~FB_ACTIVATE_TEST;
-    gen_set_disp(PROC_CONSOLE(info), info);
     return !err;
 }

diff -Nru a/drivers/video/neofb.c b/drivers/video/neofb.c
--- a/drivers/video/neofb.c	Mon Oct 14 09:36:34 2002
+++ b/drivers/video/neofb.c	Mon Oct 14 09:36:34 2002
@@ -1164,10 +1164,9 @@
 /*
  *    Pan or Wrap the Display
  */
-static int neofb_pan_display(struct fb_var_screeninfo *var, int con,
-			     struct fb_info *fb)
+static int neofb_pan_display(struct fb_var_screeninfo *var,
+			     struct fb_info *info)
 {
-	struct fb_info *info = (struct fb_info *) fb;
 	u_int y_bottom;

 	y_bottom = var->yoffset;
@@ -1388,7 +1387,6 @@
 	.owner		= THIS_MODULE,
 	.fb_check_var	= neofb_check_var,
 	.fb_set_par	= neofb_set_par,
-	.fb_set_var	= gen_set_var,
 	.fb_setcolreg	= neofb_setcolreg,
 	.fb_pan_display	= neofb_pan_display,
 	.fb_blank	= neofb_blank,
@@ -1758,7 +1756,6 @@
 	par = &default_par;
 	memset(par, 0, sizeof(struct neofb_par));

-	info->currcon = -1;
 	info->fix.accel = id->driver_data;

 	par->pci_burst = !nopciburst;
diff -Nru a/drivers/video/offb.c b/drivers/video/offb.c
--- a/drivers/video/offb.c	Mon Oct 14 09:36:34 2002
+++ b/drivers/video/offb.c	Mon Oct 14 09:36:34 2002
@@ -24,7 +24,6 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/fb.h>
-#include <linux/selection.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <asm/io.h>
@@ -82,7 +81,6 @@

 static struct fb_ops offb_ops = {
 	.owner		= THIS_MODULE,
-	.fb_set_var	= gen_set_var,
 	.fb_setcolreg	= offb_setcolreg,
 	.fb_blank	= offb_blank,
 	.fb_fillrect	= cfb_fillrect,
diff -Nru a/drivers/video/pmag-ba-fb.c b/drivers/video/pmag-ba-fb.c
--- a/drivers/video/pmag-ba-fb.c	Mon Oct 14 09:36:34 2002
+++ b/drivers/video/pmag-ba-fb.c	Mon Oct 14 09:36:34 2002
@@ -108,7 +108,6 @@

 static struct fb_ops pmagbafb_ops = {
 	.owner		= THIS_MODULE,
-	.fb_set_var	= gen_set_var,
 	.fb_setcolreg	= pmagbafb_setcolreg,
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
@@ -140,8 +139,6 @@
 	info->var = pmagbafb_defined;
 	info->fix = pmagbafb_fix;
 	info->screen_base = pmagbafb_fix.smem_start;
-	info->currcon = -1;
-	info->updatevar = gen_update_var;
 	info->flags = FBINFO_FLAG_DEFAULT;

 	fb_alloc_cmap(&fb_info.cmap, 256, 0);
diff -Nru a/drivers/video/pmagb-b-fb.c b/drivers/video/pmagb-b-fb.c
--- a/drivers/video/pmagb-b-fb.c	Mon Oct 14 09:36:34 2002
+++ b/drivers/video/pmagb-b-fb.c	Mon Oct 14 09:36:34 2002
@@ -111,7 +111,6 @@

 static struct fb_ops pmagbbfb_ops = {
 	.owner		= THIS_MODULE,
-	.fb_set_var	= gen_set_var,
 	.fb_setcolreg	= pmagbbfb_setcolreg,
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
@@ -143,8 +142,6 @@
 	info->var = pmagbbfb_defined;
 	info->fix = pmagbbfb_fix;
 	info->screen_base = pmagbbfb_fix.smem_start;
-	info->currcon = -1;
-	info->updatevar = gen_update_var;
 	info->flags = FBINFO_FLAG_DEFAULT;

 	fb_alloc_cmap(&fb_info.cmap, 256, 0);
diff -Nru a/drivers/video/q40fb.c b/drivers/video/q40fb.c
--- a/drivers/video/q40fb.c	Mon Oct 14 09:36:34 2002
+++ b/drivers/video/q40fb.c	Mon Oct 14 09:36:34 2002
@@ -66,7 +66,6 @@

 static struct fb_ops q40fb_ops = {
 	.owner		= THIS_MODULE,
-	.fb_set_var	= gen_set_var,
 	.fb_setcolreg	= q40fb_setcolreg,
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
diff -Nru a/drivers/video/sgivwfb.c b/drivers/video/sgivwfb.c
--- a/drivers/video/sgivwfb.c	Mon Oct 14 09:36:34 2002
+++ b/drivers/video/sgivwfb.c	Mon Oct 14 09:36:34 2002
@@ -729,8 +729,7 @@
 		goto fail_ioremap_fbmem;
 	}

-	/* turn on default video mode */
-	gen_set_var(&fb_info->var, -1, &fb_info);
+	fb_alloc_cmap(&fb_info.cmap, 256, 0);

 	if (register_framebuffer(&fb_info) < 0) {
 		printk(KERN_ERR
diff -Nru a/drivers/video/skeletonfb.c b/drivers/video/skeletonfb.c
--- a/drivers/video/skeletonfb.c	Mon Oct 14 09:36:34 2002
+++ b/drivers/video/skeletonfb.c	Mon Oct 14 09:36:34 2002
@@ -295,7 +295,7 @@
  *      Returns negative errno on error, or zero on success.
  *
  */
-static int xxxfb_pan_display(struct fb_var_screeninfo *var, int con,
+static int xxxfb_pan_display(struct fb_var_screeninfo *var,
 			     const struct fb_info *info)
 {
     /* ... */
@@ -497,9 +497,6 @@
 	.owner		= THIS_MODULE,
 	.fb_open	= xxxfb_open,    /* only if you need it to do something */
 	.fb_release	= xxxfb_release, /* only if you need it to do something */
-	/* Stuff to go away. Use generic functions for now */
-	.fb_set_var	= gen_set_var,
-
 	.fb_check_var	= xxxfb_check_var,
 	.fb_set_par	= xxxfb_set_par,	/* optional */
 	.fb_setcolreg	= xxxfb_setcolreg,
diff -Nru a/drivers/video/tdfxfb.c b/drivers/video/tdfxfb.c
--- a/drivers/video/tdfxfb.c	Mon Oct 14 09:36:34 2002
+++ b/drivers/video/tdfxfb.c	Mon Oct 14 09:36:34 2002
@@ -77,7 +77,6 @@
 #include <linux/spinlock.h>

 #include <video/tdfx.h>
-#include <video/fbcon.h>

 #undef TDFXFB_DEBUG
 #ifdef TDFXFB_DEBUG
@@ -143,10 +142,10 @@
 };

 static struct pci_driver tdfxfb_driver = {
-	.name =		"tdfxfb",
-	.id_table =	tdfxfb_id_table,
-	.probe =	tdfxfb_probe,
-	.remove =	__devexit_p(tdfxfb_remove),
+	.name		= "tdfxfb",
+	.id_table 	= tdfxfb_id_table,
+	.probe 		= tdfxfb_probe,
+	.remove 	= __devexit_p(tdfxfb_remove),
 };

 MODULE_DEVICE_TABLE(pci, tdfxfb_id_table);
@@ -162,14 +161,13 @@
 static int tdfxfb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
 			    u_int transp, struct fb_info *info);
 static int tdfxfb_blank(int blank, struct fb_info *info);
-static int tdfxfb_pan_display(struct fb_var_screeninfo *var, int con, struct fb_info *info);
+static int tdfxfb_pan_display(struct fb_var_screeninfo *var, struct fb_info *info);
 static void tdfxfb_fillrect(struct fb_info *info, struct fb_fillrect *rect);
 static void tdfxfb_copyarea(struct fb_info *info, struct fb_copyarea *area);
 static void tdfxfb_imageblit(struct fb_info *info, struct fb_image *image);

 static struct fb_ops tdfxfb_ops = {
 	.owner		= THIS_MODULE,
-	.fb_set_var	= gen_set_var,
 	.fb_check_var	= tdfxfb_check_var,
 	.fb_set_par	= tdfxfb_set_par,
 	.fb_setcolreg	= tdfxfb_setcolreg,
@@ -184,8 +182,8 @@
  * do_xxx: Hardware-specific functions
  */
 static u32 do_calc_pll(int freq, int *freq_out);
-static void  do_write_regs(struct banshee_reg *reg);
-static unsigned long do_lfb_size(unsigned short);
+static void  do_write_regs(struct tdfx_par *par, struct banshee_reg *reg);
+static unsigned long do_lfb_size(struct tdfx_par *par, unsigned short);

 /*
  * Driver data
@@ -229,77 +227,77 @@
 #endif

 static inline void gra_outb(struct tdfx_par *par, u32 idx, u8 val) {
-	vga_outb(GRA_I, idx); vga_outb(GRA_D, val);
+	vga_outb(par, GRA_I, idx); vga_outb(par, GRA_D, val);
 }

 static inline u8 gra_inb(struct tdfx_par *par, u32 idx) {
-	vga_outb(GRA_I, idx); return vga_inb(GRA_D);
+	vga_outb(par, GRA_I, idx); return vga_inb(par, GRA_D);
 }

 static inline void seq_outb(struct tdfx_par *par, u32 idx, u8 val) {
-	vga_outb(SEQ_I, idx); vga_outb(SEQ_D, val);
+	vga_outb(par, SEQ_I, idx); vga_outb(par, SEQ_D, val);
 }

 static inline u8 seq_inb(struct tdfx_par *par, u32 idx) {
-	vga_outb(SEQ_I, idx); return vga_inb(SEQ_D);
+	vga_outb(par, SEQ_I, idx); return vga_inb(par, SEQ_D);
 }

 static inline void crt_outb(struct tdfx_par *par, u32 idx, u8 val) {
-	vga_outb(CRT_I, idx); vga_outb(CRT_D, val);
+	vga_outb(par, CRT_I, idx); vga_outb(par, CRT_D, val);
 }

 static inline u8 crt_inb(struct tdfx_par *par, u32 idx) {
-	vga_outb(CRT_I, idx); return vga_inb(CRT_D);
+	vga_outb(par, CRT_I, idx); return vga_inb(par, CRT_D);
 }

 static inline void att_outb(struct tdfx_par *par, u32 idx, u8 val)
 {
 	unsigned char tmp;

-	tmp = vga_inb(IS1_R);
-	vga_outb(ATT_IW, idx);
-	vga_outb(ATT_IW, val);
+	tmp = vga_inb(par, IS1_R);
+	vga_outb(par, ATT_IW, idx);
+	vga_outb(par, ATT_IW, val);
 }

 static inline u8 att_inb(struct tdfx_par *par, u32 idx)
 {
 	unsigned char tmp;

-	tmp = vga_inb(IS1_R);
-	vga_outb(ATT_IW, idx);
-	return vga_inb(ATT_IW);
+	tmp = vga_inb(par, IS1_R);
+	vga_outb(par, ATT_IW, idx);
+	return vga_inb(par, ATT_IW);
 }

-static inline void vga_disable_video(void)
+static inline void vga_disable_video(struct tdfx_par *par)
 {
 	unsigned char s;

-	s = seq_inb(0x01) | 0x20;
-	seq_outb(0x00, 0x01);
-	seq_outb(0x01, s);
-	seq_outb(0x00, 0x03);
+	s = seq_inb(par, 0x01) | 0x20;
+	seq_outb(par, 0x00, 0x01);
+	seq_outb(par, 0x01, s);
+	seq_outb(par, 0x00, 0x03);
 }

-static inline void vga_enable_video(void)
+static inline void vga_enable_video(struct tdfx_par *par)
 {
 	unsigned char s;

-	s = seq_inb(0x01) & 0xdf;
-	seq_outb(0x00, 0x01);
-	seq_outb(0x01, s);
-	seq_outb(0x00, 0x03);
+	s = seq_inb(par, 0x01) & 0xdf;
+	seq_outb(par, 0x00, 0x01);
+	seq_outb(par, 0x01, s);
+	seq_outb(par, 0x00, 0x03);
 }

-static inline void vga_disable_palette(void)
+static inline void vga_disable_palette(struct tdfx_par *par)
 {
-	vga_inb(IS1_R);
-	vga_outb(ATT_IW, 0x00);
+	vga_inb(par, IS1_R);
+	vga_outb(par, ATT_IW, 0x00);
 }

 static inline void vga_enable_palette(struct tdfx_par *par)
 {
-	vga_inb(IS1_R);
-	vga_outb(ATT_IW, 0x20);
+	vga_inb(par, IS1_R);
+	vga_outb(par, ATT_IW, 0x20);
 }

 static inline u32 tdfx_inl(struct tdfx_par *par, unsigned int reg)
@@ -321,7 +319,7 @@
 {
 	int i = 0;

-	banshee_make_room(1);
+	banshee_make_room(par, 1);
 	tdfx_outl(par, COMMAND_3D, COMMAND_3D_NOP);

 	while(1) {
@@ -335,7 +333,7 @@
  */
 static inline void do_setpalentry(struct tdfx_par *par, unsigned regno, u32 c)
 {
-	banshee_make_room(2);
+	banshee_make_room(par, 2);
 	tdfx_outl(par, DACADDR, regno);
 	tdfx_outl(par, DACDATA, c);
 }
@@ -369,71 +367,71 @@
 	return (n << 8) | (m << 2) | k;
 }

-static void do_write_regs(struct banshee_reg* reg)
+static void do_write_regs(struct tdfx_par *par, struct banshee_reg* reg)
 {
 	int i;

-	banshee_wait_idle();
+	banshee_wait_idle(par);

-	tdfx_outl(MISCINIT1, tdfx_inl(MISCINIT1) | 0x01);
+	tdfx_outl(par, MISCINIT1, tdfx_inl(par, MISCINIT1) | 0x01);

-	crt_outb(0x11, crt_inb(0x11) & 0x7f); /* CRT unprotect */
+	crt_outb(par, 0x11, crt_inb(par, 0x11) & 0x7f); /* CRT unprotect */

-	banshee_make_room(3);
-	tdfx_outl(VGAINIT1,	reg->vgainit1 &  0x001FFFFF);
-	tdfx_outl(VIDPROCCFG,	reg->vidcfg   & ~0x00000001);
+	banshee_make_room(par, 3);
+	tdfx_outl(par, VGAINIT1,	reg->vgainit1 &  0x001FFFFF);
+	tdfx_outl(par, VIDPROCCFG,	reg->vidcfg   & ~0x00000001);
 #if 0
-	tdfx_outl(PLLCTRL1, reg->mempll);
-	tdfx_outl(PLLCTRL2, reg->gfxpll);
+	tdfx_outl(par, PLLCTRL1, reg->mempll);
+	tdfx_outl(par, PLLCTRL2, reg->gfxpll);
 #endif
-	tdfx_outl(PLLCTRL0,	reg->vidpll);
+	tdfx_outl(par, PLLCTRL0,	reg->vidpll);

-	vga_outb(MISC_W, reg->misc[0x00] | 0x01);
+	vga_outb(par, MISC_W, reg->misc[0x00] | 0x01);

 	for (i = 0; i < 5; i++)
-		seq_outb(i, reg->seq[i]);
+		seq_outb(par, i, reg->seq[i]);

 	for (i = 0; i < 25; i++)
-		crt_outb(i, reg->crt[i]);
+		crt_outb(par, i, reg->crt[i]);

 	for (i = 0; i < 9; i++)
-		gra_outb(i, reg->gra[i]);
+		gra_outb(par, i, reg->gra[i]);

 	for (i = 0; i < 21; i++)
-		att_outb(i, reg->att[i]);
+		att_outb(par, i, reg->att[i]);

-	crt_outb(0x1a, reg->ext[0]);
-	crt_outb(0x1b, reg->ext[1]);
+	crt_outb(par, 0x1a, reg->ext[0]);
+	crt_outb(par, 0x1b, reg->ext[1]);

-	vga_enable_palette();
-	vga_enable_video();
+	vga_enable_palette(par);
+	vga_enable_video(par);

-	banshee_make_room(11);
-	tdfx_outl(VGAINIT0,      reg->vgainit0);
-	tdfx_outl(DACMODE,       reg->dacmode);
-	tdfx_outl(VIDDESKSTRIDE, reg->stride);
-	tdfx_outl(HWCURPATADDR,  0);
+	banshee_make_room(par, 11);
+	tdfx_outl(par, 	VGAINIT0,      reg->vgainit0);
+	tdfx_outl(par,	DACMODE,       reg->dacmode);
+	tdfx_outl(par,	VIDDESKSTRIDE, reg->stride);
+	tdfx_outl(par,	HWCURPATADDR,  0);

-	tdfx_outl(VIDSCREENSIZE,reg->screensize);
-	tdfx_outl(VIDDESKSTART,	reg->startaddr);
-	tdfx_outl(VIDPROCCFG,	reg->vidcfg);
-	tdfx_outl(VGAINIT1,	reg->vgainit1);
-	tdfx_outl(MISCINIT0,	reg->miscinit0);
-
-	banshee_make_room(8);
-	tdfx_outl(SRCBASE,         reg->srcbase);
-	tdfx_outl(DSTBASE,         reg->dstbase);
-	tdfx_outl(COMMANDEXTRA_2D, 0);
-	tdfx_outl(CLIP0MIN,        0);
-	tdfx_outl(CLIP0MAX,        0x0fff0fff);
-	tdfx_outl(CLIP1MIN,        0);
-	tdfx_outl(CLIP1MAX,        0x0fff0fff);
-	tdfx_outl(SRCXY,	   0);
+	tdfx_outl(par,	VIDSCREENSIZE,reg->screensize);
+	tdfx_outl(par,	VIDDESKSTART,	reg->startaddr);
+	tdfx_outl(par,	VIDPROCCFG,	reg->vidcfg);
+	tdfx_outl(par,	VGAINIT1,	reg->vgainit1);
+	tdfx_outl(par,	MISCINIT0,	reg->miscinit0);
+
+	banshee_make_room(par,	8);
+	tdfx_outl(par,	SRCBASE,         reg->srcbase);
+	tdfx_outl(par,	DSTBASE,         reg->dstbase);
+	tdfx_outl(par,	COMMANDEXTRA_2D, 0);
+	tdfx_outl(par,	CLIP0MIN,        0);
+	tdfx_outl(par,	CLIP0MAX,        0x0fff0fff);
+	tdfx_outl(par,	CLIP1MIN,        0);
+	tdfx_outl(par,	CLIP1MAX,        0x0fff0fff);
+	tdfx_outl(par,	SRCXY,	   0);

-	banshee_wait_idle();
+	banshee_wait_idle(par);
 }

-static unsigned long do_lfb_size(unsigned short dev_id)
+static unsigned long do_lfb_size(struct tdfx_par *par, unsigned short dev_id)
 {
 	u32 draminit0 = 0;
 	u32 draminit1 = 0;
@@ -441,8 +439,8 @@
 	u32 lfbsize   = 0;
 	int sgram_p   = 0;

-	draminit0 = tdfx_inl(DRAMINIT0);
-	draminit1 = tdfx_inl(DRAMINIT1);
+	draminit0 = tdfx_inl(par, DRAMINIT0);
+	draminit1 = tdfx_inl(par, DRAMINIT1);

 	if ((dev_id == PCI_DEVICE_ID_3DFX_BANSHEE) ||
 	    (dev_id == PCI_DEVICE_ID_3DFX_VOODOO3)) {
@@ -463,12 +461,12 @@
 		lfbsize <<= 20;
 	}
 	/* disable block writes for SDRAM (why?) */
-	miscinit1 = tdfx_inl(MISCINIT1);
+	miscinit1 = tdfx_inl(par, MISCINIT1);
 	miscinit1 |= sgram_p ? 0 : MISCINIT1_2DBLOCK_DIS;
 	miscinit1 |= MISCINIT1_CLUT_INV;

-	banshee_make_room(1);
-	tdfx_outl(MISCINIT1, miscinit1);
+	banshee_make_room(par, 1);
+	tdfx_outl(par, MISCINIT1, miscinit1);
 	return lfbsize;
 }

@@ -706,7 +704,7 @@
 			VGAINIT0_WAKEUP_3C3   |
 			VGAINIT0_ALT_READBACK |
 			VGAINIT0_EXTSHIFTOUT;
-	reg.vgainit1 = tdfx_inl(VGAINIT1) & 0x1fffff;
+	reg.vgainit1 = tdfx_inl(par, VGAINIT1) & 0x1fffff;

 	reg.cursloc   = 0;

@@ -736,7 +734,7 @@

 	reg.screensize = info->var.xres | (info->var.yres << 12);
 	reg.vidcfg &= ~VIDCFG_HALF_MODE;
-	reg.miscinit0 = tdfx_inl(MISCINIT0);
+	reg.miscinit0 = tdfx_inl(par, MISCINIT0);

 #if defined(__BIG_ENDIAN)
 	switch (info->var.bits_per_pixel) {
@@ -755,7 +753,7 @@
 			break;
 	}
 #endif
-	do_write_regs(&reg);
+	do_write_regs(par, &reg);

 	/* Now change fb_fix_screeninfo according to changes in par */
 	info->fix.line_length = info->var.xres * ((info->var.bits_per_pixel + 7)>>3);
@@ -769,6 +767,7 @@
 static int tdfxfb_setcolreg(unsigned regno, unsigned red, unsigned green,
 			    unsigned blue,unsigned transp,struct fb_info *info)
 {
+	struct tdfx_par *par = (struct tdfx_par *) info->par;
 	u32 rgbcol;

 	if (regno >= info->cmap.len) return 1;
@@ -778,7 +777,7 @@
 			rgbcol =(((u32)red   & 0xff00) << 8) |
 				(((u32)green & 0xff00) << 0) |
 				(((u32)blue  & 0xff00) >> 8);
-			do_setpalentry(regno, rgbcol);
+			do_setpalentry(par, regno, rgbcol);
 			break;
 		/* Truecolor has no hardware color palettes. */
 		case FB_VISUAL_TRUECOLOR:
@@ -801,9 +800,10 @@
 /* 0 unblank, 1 blank, 2 no vsync, 3 no hsync, 4 off */
 static int tdfxfb_blank(int blank, struct fb_info *info)
 {
+	struct tdfx_par *par = (struct tdfx_par *) info->par;
 	u32 dacmode, state = 0, vgablank = 0;

-	dacmode = tdfx_inl(DACMODE);
+	dacmode = tdfx_inl(par, DACMODE);

 	switch (blank) {
 		case 0: /* Screen: On; HSync: On, VSync: On */
@@ -830,21 +830,22 @@

 	dacmode &= ~(BIT(1) | BIT(3));
 	dacmode |= state;
-	banshee_make_room(1);
-	tdfx_outl(DACMODE, dacmode);
+	banshee_make_room(par, 1);
+	tdfx_outl(par, DACMODE, dacmode);
 	if (vgablank)
-		vga_disable_video();
+		vga_disable_video(par);
 	else
-		vga_enable_video();
+		vga_enable_video(par);
 	return 0;
 }

 /*
  * Set the starting position of the visible screen to var->yoffset
  */
-static int tdfxfb_pan_display(struct fb_var_screeninfo *var, int con,
+static int tdfxfb_pan_display(struct fb_var_screeninfo *var,
 			      struct fb_info *info)
 {
+	struct tdfx_par *par = (struct tdfx_par *) info->par;
 	u32 addr;

 	if (nopan || var->xoffset || (var->yoffset > var->yres_virtual))
@@ -853,8 +854,8 @@
 		return -EINVAL;

 	addr = var->yoffset * info->fix.line_length;
-	banshee_make_room(1);
-	tdfx_outl(VIDDESKSTART, addr);
+	banshee_make_room(par, 1);
+	tdfx_outl(par, VIDDESKSTART, addr);

 	info->var.xoffset = var->xoffset;
 	info->var.yoffset = var->yoffset;
@@ -866,6 +867,7 @@
  */
 static void tdfxfb_fillrect(struct fb_info *info, struct fb_fillrect *rect)
 {
+	struct tdfx_par *par = (struct tdfx_par *) info->par;
 	u32 bpp = info->var.bits_per_pixel;
 	u32 stride = info->fix.line_length;
 	u32 fmt= stride | ((bpp+((bpp==8) ? 0 : 8)) << 13);
@@ -876,13 +878,13 @@
 	else
 		tdfx_rop = TDFX_ROP_XOR;

-	banshee_make_room(5);
-	tdfx_outl(DSTFORMAT, fmt);
-	tdfx_outl(COLORFORE, rect->color);
-	tdfx_outl(COMMAND_2D, COMMAND_2D_FILLRECT | (tdfx_rop << 24));
-	tdfx_outl(DSTSIZE,    rect->width | (rect->height << 16));
-	tdfx_outl(LAUNCH_2D,  rect->dx | (rect->dy << 16));
-	banshee_wait_idle();
+	banshee_make_room(par, 5);
+	tdfx_outl(par,	DSTFORMAT, fmt);
+	tdfx_outl(par,	COLORFORE, rect->color);
+	tdfx_outl(par,	COMMAND_2D, COMMAND_2D_FILLRECT | (tdfx_rop << 24));
+	tdfx_outl(par,	DSTSIZE,    rect->width | (rect->height << 16));
+	tdfx_outl(par,	LAUNCH_2D,  rect->dx | (rect->dy << 16));
+	banshee_wait_idle(par);
 }

 /*
@@ -890,6 +892,7 @@
  */
 static void tdfxfb_copyarea(struct fb_info *info, struct fb_copyarea *area)
 {
+	struct tdfx_par *par = (struct tdfx_par *) info->par;
 	u32 bpp = info->var.bits_per_pixel;
 	u32 stride = info->fix.line_length;
 	u32 blitcmd = COMMAND_2D_S2S_BITBLT | (TDFX_ROP_COPY << 24);
@@ -908,19 +911,20 @@
 		area->dy += area->height - 1;
 	}

-	banshee_make_room(6);
+	banshee_make_room(par, 6);

-	tdfx_outl(SRCFORMAT, fmt);
-	tdfx_outl(DSTFORMAT, fmt);
-	tdfx_outl(COMMAND_2D, blitcmd);
-	tdfx_outl(DSTSIZE,   area->width | (area->height << 16));
-	tdfx_outl(DSTXY,     area->dx | (area->dy << 16));
-	tdfx_outl(LAUNCH_2D, area->sx | (area->sy << 16));
-	banshee_wait_idle();
+	tdfx_outl(par,	SRCFORMAT, fmt);
+	tdfx_outl(par,	DSTFORMAT, fmt);
+	tdfx_outl(par,	COMMAND_2D, blitcmd);
+	tdfx_outl(par,	DSTSIZE,   area->width | (area->height << 16));
+	tdfx_outl(par,	DSTXY,     area->dx | (area->dy << 16));
+	tdfx_outl(par,	LAUNCH_2D, area->sx | (area->sy << 16));
+	banshee_wait_idle(par);
 }

 static void tdfxfb_imageblit(struct fb_info *info, struct fb_image *pixmap)
 {
+	struct tdfx_par *par = (struct tdfx_par *) info->par;
 	int size = pixmap->height*((pixmap->width*pixmap->depth + 7)>>3);
 	int i, stride = info->fix.line_length;
 	u32 bpp = info->var.bits_per_pixel;
@@ -929,25 +933,25 @@
 	u32 srcfmt;

 	if (pixmap->depth == 1) {
-		banshee_make_room(8 + ((size + 3) >> 2));
-		tdfx_outl(COLORFORE, pixmap->fg_color);
-		tdfx_outl(COLORBACK, pixmap->bg_color);
+		banshee_make_room(par, 8 + ((size + 3) >> 2));
+		tdfx_outl(par, COLORFORE, pixmap->fg_color);
+		tdfx_outl(par, COLORBACK, pixmap->bg_color);
 		srcfmt = 0x400000;
 	} else {
-		banshee_make_room(6 + ((size + 3) >> 2));
+		banshee_make_room(par, 6 + ((size + 3) >> 2));
 		srcfmt = stride | ((bpp+((bpp==8) ? 0 : 8)) << 13) | 0x400000;
 	}

-	tdfx_outl(SRCXY,     0);
-	tdfx_outl(DSTXY,     pixmap->dx | (pixmap->dy << 16));
-	tdfx_outl(COMMAND_2D, COMMAND_2D_H2S_BITBLT | (TDFX_ROP_COPY << 24));
-	tdfx_outl(SRCFORMAT, srcfmt);
-	tdfx_outl(DSTFORMAT, dstfmt);
-	tdfx_outl(DSTSIZE,   pixmap->width | (pixmap->height << 16));
+	tdfx_outl(par,	SRCXY,     0);
+	tdfx_outl(par,	DSTXY,     pixmap->dx | (pixmap->dy << 16));
+	tdfx_outl(par,	COMMAND_2D, COMMAND_2D_H2S_BITBLT | (TDFX_ROP_COPY << 24));
+	tdfx_outl(par,	SRCFORMAT, srcfmt);
+	tdfx_outl(par,	DSTFORMAT, dstfmt);
+	tdfx_outl(par,	DSTSIZE,   pixmap->width | (pixmap->height << 16));

 	/* Send four bytes at a time of data */
 	for (i = (size >> 2) ; i > 0; i--) {
-		tdfx_outl(LAUNCH_2D,*(u32*)chardata);
+		tdfx_outl(par,	LAUNCH_2D,*(u32*)chardata);
 		chardata += 4;
 	}

@@ -955,11 +959,11 @@
 	i = size%4;
 	switch (i) {
 		case 0: break;
-		case 1:  tdfx_outl(LAUNCH_2D,*chardata); break;
-		case 2:  tdfx_outl(LAUNCH_2D,*(u16*)chardata); break;
-		case 3:  tdfx_outl(LAUNCH_2D,*(u16*)chardata | ((chardata[3]) << 24)); break;
+		case 1:  tdfx_outl(par,	LAUNCH_2D,*chardata); break;
+		case 2:  tdfx_outl(par,	LAUNCH_2D,*(u16*)chardata); break;
+		case 3:  tdfx_outl(par,	LAUNCH_2D,*(u16*)chardata | ((chardata[3]) << 24)); break;
 	}
-	banshee_wait_idle();
+	banshee_wait_idle(par);
 }

 /**
@@ -974,8 +978,8 @@
 static int __devinit tdfxfb_probe(struct pci_dev *pdev,
                                   const struct pci_device_id *id)
 {
+	struct tdfx_par *default_par;
 	struct fb_info *info;
-	struct tdfx_par *par;
 	int size, err;

 	if ((err = pci_enable_device(pdev))) {
@@ -983,33 +987,35 @@
 		return err;
 	}

-	info = kmalloc(sizeof(struct fb_info) + sizeof(struct tdfx_par) +
-			sizeof(u32) * 17, GFP_KERNEL);
+	info = kmalloc(sizeof(struct fb_info) + sizeof(struct display) +
+			sizeof(u32) * 16, GFP_KERNEL);

 	if (!info)	return -ENOMEM;

-	memset(info, 0, sizeof(info) + sizeof(struct tdfx_par) + sizeof(u32) * 17);
-
+	memset(info, 0, sizeof(info) + sizeof(struct display) + sizeof(u32) * 16);
+
+	default_par = kmalloc(sizeof(struct tdfx_par), GFP_KERNEL);
+
 	/* Configure the default fb_fix_screeninfo first */
 	switch (pdev->device) {
 		case PCI_DEVICE_ID_3DFX_BANSHEE:
 			strcat(tdfx_fix.id, " Banshee");
-			par->max_pixclock = BANSHEE_MAX_PIXCLOCK;
+			default_par->max_pixclock = BANSHEE_MAX_PIXCLOCK;
 			break;
 		case PCI_DEVICE_ID_3DFX_VOODOO3:
 			strcat(tdfx_fix.id, " Voodoo3");
-			par->max_pixclock = VOODOO3_MAX_PIXCLOCK;
+			default_par->max_pixclock = VOODOO3_MAX_PIXCLOCK;
 			break;
 		case PCI_DEVICE_ID_3DFX_VOODOO5:
 			strcat(tdfx_fix.id, " Voodoo5");
-			par->max_pixclock = VOODOO5_MAX_PIXCLOCK;
+			default_par->max_pixclock = VOODOO5_MAX_PIXCLOCK;
 			break;
 	}

 	tdfx_fix.mmio_start = pci_resource_start(pdev, 0);
 	tdfx_fix.mmio_len = pci_resource_len(pdev, 0);
-	par->regbase_virt = ioremap_nocache(tdfx_fix.mmio_start, tdfx_fix.mmio_len);
-	if (!par->regbase_virt) {
+	default_par->regbase_virt = ioremap_nocache(tdfx_fix.mmio_start, tdfx_fix.mmio_len);
+	if (!default_par->regbase_virt) {
 		printk("fb: Can't remap %s register area.\n", tdfx_fix.id);
 		goto out_err;
 	}
@@ -1021,7 +1027,7 @@
 	}

 	tdfx_fix.smem_start = pci_resource_start(pdev, 1);
-	if (!(tdfx_fix.smem_len = do_lfb_size(pdev->device))) {
+	if (!(tdfx_fix.smem_len = do_lfb_size(default_par, pdev->device))) {
 		printk("fb: Can't count %s memory.\n", tdfx_fix.id);
 		release_mem_region(pci_resource_start(pdev, 0),
 				   pci_resource_len(pdev, 0));
@@ -1047,7 +1053,7 @@
 		goto out_err;
 	}

-	par->iobase = pci_resource_start(pdev, 2);
+	default_par->iobase = pci_resource_start(pdev, 2);

 	if (!request_region(pci_resource_start(pdev, 2),
 	    pci_resource_len(pdev, 2), "tdfx iobase")) {
@@ -1070,8 +1076,8 @@
 	info->node		= NODEV;
 	info->fbops		= &tdfxfb_ops;
 	info->fix		= tdfx_fix;
-	info->par		= (struct tdfx_par *)(info + 1);
-	info->pseudo_palette	= (void *)(info->par + 1);
+	info->par		= default_par;
+	info->pseudo_palette	= (void *)(info + 1);
 	info->flags		= FBINFO_FLAG_DEFAULT;

 	if (!mode_option)
@@ -1084,8 +1090,6 @@
 	size = (info->var.bits_per_pixel == 8) ? 256 : 16;
 	fb_alloc_cmap(&info->cmap, size, 0);

-	gen_set_var(&info->var, -1, info);
-
 	if (register_framebuffer(info) < 0) {
 		printk("tdfxfb: can't register framebuffer\n");
 		goto out_err;
@@ -1100,11 +1104,10 @@
 	/*
 	 * Cleanup after anything that was remapped/allocated.
 	 */
-	if (par->regbase_virt)
-		iounmap(par->regbase_virt);
+	if (default_par->regbase_virt)
+		iounmap(default_par->regbase_virt);
 	if (info->screen_base)
 		iounmap(info->screen_base);
-	kfree(par);
 	kfree(info);
 	return -ENXIO;
 }
diff -Nru a/drivers/video/tx3912fb.c b/drivers/video/tx3912fb.c
--- a/drivers/video/tx3912fb.c	Mon Oct 14 09:36:34 2002
+++ b/drivers/video/tx3912fb.c	Mon Oct 14 09:36:34 2002
@@ -94,7 +94,6 @@
  */
 static struct fb_ops tx3912fb_ops = {
 	.owner		= THIS_MODULE,
-	.fb_set_var	= gen_set_var,
 	.fb_setcolreg	= tx3912fb_setcolreg,
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
@@ -211,6 +210,7 @@
 int __init tx3912fb_init(void)
 {
 	u_long tx3912fb_paddr = 0;
+	int size = (info->var.bits_per_pixel == 8) ? 256 : 16;

 	/* Disable the video logic */
 	outl(inl(TX3912_VIDEO_CTRL1) &
diff -Nru a/drivers/video/vesafb.c b/drivers/video/vesafb.c
--- a/drivers/video/vesafb.c	Mon Oct 14 09:36:34 2002
+++ b/drivers/video/vesafb.c	Mon Oct 14 09:36:34 2002
@@ -59,7 +59,7 @@

 /* --------------------------------------------------------------------- */

-static int vesafb_pan_display(struct fb_var_screeninfo *var, int con,
+static int vesafb_pan_display(struct fb_var_screeninfo *var,
                               struct fb_info *info)
 {
 	int offset;
@@ -170,7 +170,6 @@

 static struct fb_ops vesafb_ops = {
 	.owner		= THIS_MODULE,
-	.fb_set_var	= gen_set_var,
 	.fb_setcolreg	= vesafb_setcolreg,
 	.fb_pan_display	= vesafb_pan_display,
 	.fb_fillrect	= cfb_fillrect,
@@ -348,7 +347,6 @@
 	fb_info.fbops = &vesafb_ops;
 	fb_info.var = vesafb_defined;
 	fb_info.fix = vesafb_fix;
-	fb_info.updatevar = gen_update_var;
 	fb_info.pseudo_palette = pseudo_palette;
 	fb_info.flags = FBINFO_FLAG_DEFAULT;

diff -Nru a/drivers/video/vfb.c b/drivers/video/vfb.c
--- a/drivers/video/vfb.c	Mon Oct 14 09:36:34 2002
+++ b/drivers/video/vfb.c	Mon Oct 14 09:36:34 2002
@@ -87,13 +87,12 @@
 static int vfb_set_par(struct fb_info *info);
 static int vfb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
 			 u_int transp, struct fb_info *info);
-static int vfb_pan_display(struct fb_var_screeninfo *var, int con,
+static int vfb_pan_display(struct fb_var_screeninfo *var,
 			   struct fb_info *info);
 static int vfb_mmap(struct fb_info *info, struct file *file,
 		    struct vm_area_struct *vma);

 static struct fb_ops vfb_ops = {
-	.fb_set_var	gen_set_var,
 	.fb_check_var	vfb_check_var,
 	.fb_set_par	vfb_set_par,
 	.fb_setcolreg	vfb_setcolreg,
@@ -351,7 +350,7 @@
      *  This call looks only at xoffset, yoffset and the FB_VMODE_YWRAP flag
      */

-static int vfb_pan_display(struct fb_var_screeninfo *var, int con,
+static int vfb_pan_display(struct fb_var_screeninfo *var,
 			   struct fb_info *info)
 {
 	if (var->vmode & FB_VMODE_YWRAP) {
diff -Nru a/include/linux/fb.h b/include/linux/fb.h
--- a/include/linux/fb.h	Mon Oct 14 09:36:34 2002
+++ b/include/linux/fb.h	Mon Oct 14 09:36:34 2002
@@ -317,9 +317,6 @@
     struct module *owner;
     int (*fb_open)(struct fb_info *info, int user);
     int (*fb_release)(struct fb_info *info, int user);
-    /* set settable parameters */
-    int (*fb_set_var)(struct fb_var_screeninfo *var, int con,
-		      struct fb_info *info);
     /* checks var and creates a par based on it */
     int (*fb_check_var)(struct fb_var_screeninfo *var, struct fb_info *info);
     /* set the video mode according to par */
@@ -330,7 +327,7 @@
     /* blank display */
     int (*fb_blank)(int blank, struct fb_info *info);
     /* pan display */
-    int (*fb_pan_display)(struct fb_var_screeninfo *var, int con, struct fb_info *info);
+    int (*fb_pan_display)(struct fb_var_screeninfo *var, struct fb_info *info);
     /* draws a rectangle */
     void (*fb_fillrect)(struct fb_info *info, struct fb_fillrect *rect);
     /* Copy data from area to another */
@@ -341,7 +338,7 @@
     int (*fb_poll)(struct fb_info *info, poll_table *wait);
     /* perform fb specific ioctl (optional) */
     int (*fb_ioctl)(struct inode *inode, struct file *file, unsigned int cmd,
-		    unsigned long arg, int con, struct fb_info *info);
+		    unsigned long arg, struct fb_info *info);
     /* perform fb specific mmap */
     int (*fb_mmap)(struct fb_info *info, struct file *file, struct vm_area_struct *vma);
     /* switch to/from raster image mode */

===================================================================


This BitKeeper patch contains the following changesets:
1.782.2.11
## Wrapped with gzip_uu ##


begin 664 bkpatch4810
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
-(RL^_@O$2-RH/X,`````
`
end

