Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287156AbRL2HqM>; Sat, 29 Dec 2001 02:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287153AbRL2HqE>; Sat, 29 Dec 2001 02:46:04 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:15119 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S287155AbRL2Hp7>; Sat, 29 Dec 2001 02:45:59 -0500
Date: Sat, 29 Dec 2001 08:44:54 +0100
From: Jurriaan on Alpha <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com, davej@suse.de, marcelo@conectiva.com.br
Subject: [PATCH] 2.4 and 2.5: tdfxfb (voodoo) framebuffer at high pixelclocks
Message-ID: <20011229074454.GB6208@alpha.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch solves problems with voodoo-cards and framebuffers where the
pixel-clock is over half the maximum clock, and the DAC is set to a
special mode.

I mentioned this to the developers, Hannu Mallat and Attila Kesmarki,
but they seem to have dropped this, and didn't respond. The latest 3dfx
framebuffer patch didn't apply clean to the 2.4 kernels and didn't work
after I cleaned it up. So I elected to just fix the high pixelclock
problem. If these developers read this, and are still interested in this
driver, please get in touch.

This patch moves the DAC-setting and recomputes some screen properties
when setting the 2X mode on the DAC.

The patch applies cleanly to 2.4.17, 2.4.18pre1 and 2.5.2-pre3.
I'm sending this to Linus (fat chance), Dave Jones (please?) and Marcelo
Tosatti (please?) for inclusion.

It's been tested on a pci voodoo 4500, I can boot with framebuffers with
a pixelclock below and above 175 MHz, start X and switch from X to the
console.

Good luck,
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
You do understand that in my culture what you have just said would
constitute deliberate and possibly dangerous insult?
	Michelle West - Sea of Sorrows
GNU/Linux 2.4.18pre1 on Debian/Alpha 64-bits 990 bogomips load:0.10 0.22 0.10
