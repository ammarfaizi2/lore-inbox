Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313682AbSDZGuN>; Fri, 26 Apr 2002 02:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313687AbSDZGuM>; Fri, 26 Apr 2002 02:50:12 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:60427 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S313682AbSDZGuK>; Fri, 26 Apr 2002 02:50:10 -0400
Date: Fri, 26 Apr 2002 08:49:46 +0200
From: Jurriaan on Alpha <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Cc: davej@suse.com
Subject: tdfxfb.c framebuffer patch for high resolutions not in 2.5.10, already accepted in 2.4
Message-ID: <20020426064946.GA20934@alpha.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is necessary to use framebuffers where the pixelclock is over
half the maximum pixelclock on voodoo cards. It's been in 2.4 for a
while, but it's not in 2.5 yet. As 2.5 is starting to be able to compile
on my Alpha, I'd like it to be in 2.5 also.

It still applies without problems to 2.5.10.

[waves hands in complex movement, hoping for miracle]: Please apply!

Thanks,
Jurriaan


--- linux-2.4.17/drivers/video/tdfxfb.c	Fri Dec 28 18:51:22 2001
+++ linux-2.4.17-tdfxfb/drivers/video/tdfxfb.c	Fri Dec 28 18:54:15 2001
@@ -401,7 +401,7 @@
 /*
  *  Internal routines
  */
-static void tdfxfb_set_par(const struct tdfxfb_par* par,
+static void tdfxfb_set_par(struct tdfxfb_par* par,
 			   struct fb_info_tdfx* 
 			   info);
 static int  tdfxfb_decode_var(const struct fb_var_screeninfo *var,
@@ -1275,7 +1275,7 @@
 
 /* ------------------------------------------------------------------------- */
 
-static void tdfxfb_set_par(const struct tdfxfb_par* par,
+static void tdfxfb_set_par(struct tdfxfb_par* par,
 			   struct fb_info_tdfx*     info) {
   struct fb_info_tdfx* i = (struct fb_info_tdfx*)info;
   struct banshee_reg reg;
@@ -1290,6 +1290,28 @@
 
   cpp = (par->bpp + 7)/8;
   
+  reg.vidcfg = 
+    VIDCFG_VIDPROC_ENABLE |
+    VIDCFG_DESK_ENABLE    |
+    VIDCFG_CURS_X11 |
+    ((cpp - 1) << VIDCFG_PIXFMT_SHIFT) |
+    (cpp != 1 ? VIDCFG_CLUT_BYPASS : 0);
+
+  /* PLL settings */
+  freq = par->pixclock;
+
+  reg.dacmode = 0;
+  reg.vidcfg  &= ~VIDCFG_2X;
+
+  if(freq > i->max_pixclock/2) {
+    freq = freq > i->max_pixclock ? i->max_pixclock : freq;
+    reg.dacmode |= DACMODE_2X;
+    reg.vidcfg  |= VIDCFG_2X;
+    par->hdispend >>= 1;
+    par->hsyncsta >>= 1;
+    par->hsyncend >>= 1;
+    par->htotal   >>= 1;
+  }
   wd = (par->hdispend >> 3) - 1;
 
   hd  = (par->hdispend >> 3) - 1;
@@ -1356,9 +1378,7 @@
   reg.crt[0x02] = hbs;
   reg.crt[0x03] = 0x80 | (hbe & 0x1f);
   reg.crt[0x04] = hs;
-  reg.crt[0x05] = 
-    ((hbe & 0x20) << 2) | 
-    (he & 0x1f);
+  reg.crt[0x05] = ((hbe & 0x20) << 2) | (he & 0x1f);
   reg.crt[0x06] = vt;
   reg.crt[0x07] = 
     ((vs & 0x200) >> 2) |
@@ -1380,9 +1400,7 @@
   reg.crt[0x0e] = 0x00;
   reg.crt[0x0f] = 0x00;
   reg.crt[0x10] = vs;
-  reg.crt[0x11] = 
-    (ve & 0x0f) |
-    0x20;
+  reg.crt[0x11] = (ve & 0x0f) | 0x20;
   reg.crt[0x12] = vd;
   reg.crt[0x13] = wd;
   reg.crt[0x14] = 0x00;
@@ -1411,13 +1429,6 @@
     VGAINIT0_EXTSHIFTOUT;
   reg.vgainit1 = tdfx_inl(VGAINIT1) & 0x1fffff;
 
-  reg.vidcfg = 
-    VIDCFG_VIDPROC_ENABLE |
-    VIDCFG_DESK_ENABLE    |
-    VIDCFG_CURS_X11 |
-    ((cpp - 1) << VIDCFG_PIXFMT_SHIFT) |
-    (cpp != 1 ? VIDCFG_CLUT_BYPASS : 0);
-  
   fb_info.cursor.enable=reg.vidcfg | VIDCFG_HWCURSOR_ENABLE;
   fb_info.cursor.disable=reg.vidcfg;
    
@@ -1433,16 +1444,6 @@
   reg.srcbase   = reg.startaddr;
   reg.dstbase   = reg.startaddr;
 
-  /* PLL settings */
-  freq = par->pixclock;
-
-  reg.dacmode &= ~DACMODE_2X;
-  reg.vidcfg  &= ~VIDCFG_2X;
-  if(freq > i->max_pixclock/2) {
-    freq = freq > i->max_pixclock ? i->max_pixclock : freq;
-    reg.dacmode |= DACMODE_2X;
-    reg.vidcfg  |= VIDCFG_2X;
-  }
   reg.vidpll = do_calc_pll(freq, &fout);
 #if 0
   reg.mempll = do_calc_pll(..., &fout);
@@ -1473,9 +1474,13 @@
 #endif
 
   do_write_regs(&reg);
-
+  if (reg.vidcfg & VIDCFG_2X) {
+    par->hdispend <<= 1;
+    par->hsyncsta <<= 1;
+    par->hsyncend <<= 1;
+    par->htotal   <<= 1;
+  }
   i->current_par = *par;
-
 }
 
 static int tdfxfb_decode_var(const struct fb_var_screeninfo* var,
-- 
But what can you do with it?
	ubiquitous cry from Linux-user partner
GNU/Linux 2.4.19p7 on Debian/Alpha 990 bogomips load:0.00 0.11 0.08
