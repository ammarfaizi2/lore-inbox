Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262163AbTIMOkT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 10:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262164AbTIMOkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 10:40:19 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:20133 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262163AbTIMOkL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 10:40:11 -0400
Date: Sat, 13 Sep 2003 16:39:38 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>,
       =?ISO-8859-15?Q?Dani=EBl_Mantione?= <daniel@deadlock.et.tudelft.nl>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.23-pre4: failed at atyfb_base.c
In-Reply-To: <3F631113.4C6368D3@eyal.emu.id.au>
Message-ID: <Pine.GSO.4.21.0309131622000.2634-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Sep 2003, Eyal Lebedinsky wrote:
> Marcelo Tosatti wrote:
> > Here goes -pre4, which contains networking update, IA64 update, PPC
> > update, USB update, bunch of knfsd fixes, amongst others.
> gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-pre/include -Wall
> -Wstrict-pro
> totypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
> -fomit-frame-pointer
>  -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4
> -DMODULE -DM
> ODVERSIONS -include
> /data2/usr/local/src/linux-2.4-pre/include/linux/modversions
> .h  -nostdinc -iwithprefix include -DKBUILD_BASENAME=atyfb_base 
> -DEXPORT_SYMTAB
>  -c atyfb_base.c
> atyfb_base.c: In function `aty_set_crtc':
> atyfb_base.c:501: warning: passing arg 2 of `aty_st_lcd' makes integer
> from pointer without a cast
> atyfb_base.c:501: too few arguments to function `aty_st_lcd'
> atyfb_base.c:504: warning: passing arg 2 of `aty_st_lcd' makes integer
> from pointer without a cast
> atyfb_base.c:504: too few arguments to function `aty_st_lcd'
> make[3]: *** [atyfb_base.o] Error 1
> make[3]: Leaving directory
> `/data2/usr/local/src/linux-2.4-pre/drivers/video/aty'
> 
> I now disabled CONFIG_FB_ATY_GENERIC_LCD and it builds.

Apparently Daniël didn't sent the latest version to Marcelo?

Here are some fixes:

--- linux-2.4.23-pre4/drivers/video/aty/atyfb_base.c.orig	Sat Sep 13 16:29:48 2003
+++ linux-2.4.23-pre4/drivers/video/aty/atyfb_base.c	Fri Sep 12 12:50:36 2003
@@ -313,7 +313,7 @@
     int pll, mclk, xclk;
     u32 features;
 } aty_chips[] __initdata = {
-    /* Note to kernel maintainers: Please resfuse any patch to change a clock rate,
+    /* Note to kernel maintainers: Please REFUSE any patch to change a clock rate,
        unless someone proves that a value is incorrect for him with a dump of
        the driver information table in the BIOS. Patches accepted in the past have
        caused chips to be overclocked by as much as 50%!
@@ -498,10 +498,12 @@
      * off. It is a Rage Mobility M1, but doesn't happen on these chips
      * in general. (Daniel Mantione, 26 june 2003)
      */
-      aty_st_lcd(aty_ld_lcd(LCD_GEN_CTRL, info) | SHADOW_RW_EN, info);
+      aty_st_lcd(LCD_GEN_CTRL, aty_ld_lcd(LCD_GEN_CTRL, info) | SHADOW_RW_EN,
+		 info);
       aty_st_le32(CRTC_H_TOTAL_DISP, crtc->h_tot_disp, info);
       aty_st_le32(CRTC_H_SYNC_STRT_WID, crtc->h_sync_strt_wid, info);
-      aty_st_lcd(aty_ld_lcd(LCD_GEN_CTRL, info) & ~SHADOW_RW_EN, info);
+      aty_st_lcd(LCD_GEN_CTRL, aty_ld_lcd(LCD_GEN_CTRL, info) & ~SHADOW_RW_EN,
+		 info);
     /* End hack */
 #endif
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

