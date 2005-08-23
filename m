Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932246AbVHWRne@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbVHWRne (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 13:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbVHWRne
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 13:43:34 -0400
Received: from 64-247-12-127.site5.com ([64.247.12.127]:39625 "EHLO
	pyxis.site5.com") by vger.kernel.org with ESMTP id S932246AbVHWRnd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 13:43:33 -0400
Message-ID: <005d01c5a80a$33fff940$6401a8c0@elixry>
From: "ttye0" <ttye0@binarii.com>
To: <linux-kernel@vger.kernel.org>
Subject: Console Resolution Support Request - 1024x480
Date: Tue, 23 Aug 2005 10:43:42 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pyxis.site5.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - binarii.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,
 After seeing many many posts and no solutions anywhere regarding having a 
full screen console on a Sony Vaio Picturebook with an ATI Rage Mobility 
video chip on a kernel anywhere near the current version....~inhale~....I 
finally made an attempt with a kernel-2.4.17 diff patch to manually change 
the nessecery source code in order to make 1024x480 supported. If there is 
any info that you might need I might be able to get it for you but my 
experience is limited unfortunately. My attempt to fix this manually was a 
failure. I managed to find all the code and made all of the proper 
adjustments, but when I made the adjustments to 
../drivers/video/aty/mach64_ct.c there were problems with pll and mpostdiv 
being undefined. I attempted anxiouslly to work around this by leaving the 
code as it was originally or even replacing the nessecery code to make it 
similar (by theory), but there was no success. It did compile, however after 
booting into the kernel with vga=0x301 the screen was terribly unreadable, 
missized (large), and flashing. I wish I could manage this on my own, but 
I'm not capable and have made no progress. I'm surprised that no one has 
taken the older patch and implemented it into the kernel so this would not 
have been an issue except in 2.4.17 and earlier. I do know that if I use 
Windows XP ont his machine, in order to get fullscreen usage I needed to use 
NeoMagic drivers (if you need these, contact me for the exact drivers that 
made mine work) when my video card is in fact an ATI Rage Mobility chip. 
Please, even if you can't help with this, give me some information that may 
lead to a positive outcome for any/all picturebook users. Thank you in 
advance!

Note: I attempted this fix on linux-2.4.28-r9 kernel.

If you would like to see my attempted patch I will show you that as well, it 
works fantastic on terms of patching but the code however does not work.
Here is the patch for the 2.4.17 kernel:


      Code:

      diff -Nur linux-2.4.17/drivers/video/Config.in 
linux/drivers/video/Config.in
      --- linux-2.4.17/drivers/video/Config.in   Thu Nov 15 10:16:31 2001
      +++ linux/drivers/video/Config.in   Fri Jan 11 16:13:37 2002
      @@ -135,6 +135,9 @@
           if [ "$CONFIG_FB_ATY" != "n" ]; then
              bool '    Mach64 GX support (EXPERIMENTAL)' CONFIG_FB_ATY_GX
              bool '    Mach64 CT/VT/GT/LT (incl. 3D RAGE) support' 
CONFIG_FB_ATY_CT
      +               if [ "$CONFIG_FB_ATY_CT" = "y" ]; then
      +                  bool '      Sony Vaio C1VE 1024x480 LCD support' 
CONFIG_FB_ATY_CT_VAIO_LCD
      +               fi
           fi
            tristate '  ATI Radeon display support (EXPERIMENTAL)' 
CONFIG_FB_RADEON
           tristate '  ATI Rage128 display support (EXPERIMENTAL)' 
CONFIG_FB_ATY128
      diff -Nur linux-2.4.17/drivers/video/aty/atyfb_base.c 
linux/drivers/video/aty/atyfb_base.c
      --- linux-2.4.17/drivers/video/aty/atyfb_base.c   Fri Dec 21 21:37:11 
2001
      +++ linux/drivers/video/aty/atyfb_base.c   Sat Dec 22 02:39:12 2001
      @@ -353,6 +353,7 @@

           /* 3D RAGE Mobility */
           { 0x4c4d, 0x4c4d, 0x00, 0x00, m64n_mob_p,   230,  50, M64F_GT | 
M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_MOBIL_BUS },
      +    { 0x4c52, 0x4c52, 0x00, 0x00, m64n_mob_p,   230,  40, M64F_GT | 
M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_MOBIL_BUS | 
M64F_MAGIC_POSTDIV | M64F_SDRAM_MAGIC_PLL | M64F_XL_DLL },
           { 0x4c4e, 0x4c4e, 0x00, 0x00, m64n_mob_a,   230,  50, M64F_GT | 
M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_MOBIL_BUS },
       #endif /* CONFIG_FB_ATY_CT */
       };
      @@ -423,7 +424,7 @@

       #endif /* defined(CONFIG_PPC) */

      -#if defined(CONFIG_PMAC_PBOOK) || defined(CONFIG_PMAC_BACKLIGHT)
      +#if defined(CONFIG_PMAC_PBOOK) || defined(CONFIG_PMAC_BACKLIGHT) || 
defined(CONFIG_FB_ATY_CT_VAIO_LCD)
       static void aty_st_lcd(int index, u32 val, const struct fb_info_aty 
*info)
       {
           unsigned long temp;
      @@ -445,7 +446,7 @@
           /* read the register value */
           return aty_ld_le32(LCD_DATA, info);
       }
      -#endif /* CONFIG_PMAC_PBOOK || CONFIG_PMAC_BACKLIGHT */
      +#endif /* CONFIG_PMAC_PBOOK || CONFIG_PMAC_BACKLIGHT || 
CONFIG_FB_ATY_CT_VAIO_LCD */

       /* ------------------------------------------------------------------------- 
*/

      @@ -1744,6 +1745,9 @@
       #if defined(CONFIG_PPC)
           int sense;
       #endif
      +#if defined(CONFIG_FB_ATY_CT_VAIO_LCD)
      +    u32 pm, hs;
      +#endif
           u8 pll_ref_div;

           info->aty_cmap_regs = (struct aty_cmap_regs 
*)(info->ati_regbase+0xc0);
      @@ -2068,6 +2072,35 @@
          var = default_var;
       #endif /* !__sparc__ */
       #endif /* !CONFIG_PPC */
      +#if defined(CONFIG_FB_ATY_CT_VAIO_LCD)
      +       /* Power Management */
      +       pm=aty_ld_lcd(POWER_MANAGEMENT, info);
      +       pm=(pm & ~PWR_MGT_MODE_MASK) | PWR_MGT_MODE_PCI;
      +       pm|=PWR_MGT_ON;
      +       aty_st_lcd(POWER_MANAGEMENT, pm, info);
      +       udelay(10);
      +
      +       /* OVR_WID_LEFT_RIGHT */
      +       hs=aty_ld_le32(OVR_WID_LEFT_RIGHT,info);
      +       hs &= ~0x003F003F;
      +       aty_st_le32(OVR_WID_LEFT_RIGHT, hs, info);
      +       udelay(10);
      +
      +       /* CONFIG_PANEL */
      +       hs=aty_ld_lcd(CONFIG_PANEL,info);
      +       hs|=DONT_SHADOW_HEND ;
      +       aty_st_lcd(CONFIG_PANEL, hs, info);
      +       udelay(10);
      +
      +#if defined(DEBUG)
      +       printk("LCD_INDEX CONFIG_PANEL LCD_GEN_CTRL 
POWER_MANAGEMENT\n"
      +       "%08x  %08x     %08x     %08x\n",
      +       aty_ld_le32(LCD_INDEX, info),
      +       aty_ld_lcd(CONFIG_PANEL, info),
      +       aty_ld_lcd(LCD_GEN_CTRL, info),
      +       aty_ld_lcd(POWER_MANAGEMENT, info),
      +#endif /* DEBUG */
      +#endif /* CONFIG_FB_ATY_CT_VAIO_LCD */
       #endif /* !MODULE */
           if (noaccel)
               var.accel_flags &= ~FB_ACCELF_TEXT;
      @@ -2676,6 +2709,23 @@
           /*
            *  Blank the display.
            */
      +#if defined(CONFIG_FB_ATY_CT_VAIO_LCD)
      +static int set_backlight_enable(int on, struct fb_info_aty *info)
      +{
      +       unsigned int reg = aty_ld_lcd(POWER_MANAGEMENT, info);
      +       if(on) {
      +               reg=(reg & ~SUSPEND_NOW) | PWR_BLON;
      +       } else {
      +               reg=(reg & ~PWR_BLON) | SUSPEND_NOW;
      +       }
      +       aty_st_lcd(POWER_MANAGEMENT, reg, info);
      +       udelay(10);
      +#ifdef DEBUG
      +               printk(KERN_INFO "set_backlight_enable(%i): %08x\n", 
on, aty_ld_lcd(POWER_MANAGEMENT, info) );
      +#endif
      +       return 0;
      +}
      +#endif /* CONFIG_FB_ATY_CT_VAIO_LCD */

       static void atyfbcon_blank(int blank, struct fb_info *fb)
       {
      @@ -2687,6 +2737,9 @@
              set_backlight_enable(0);
       #endif /* CONFIG_PMAC_BACKLIGHT */

      +#if defined(CONFIG_FB_ATY_CT_VAIO_LCD)
      +       set_backlight_enable(!blank, info);
      +#endif /* CONFIG_FB_ATY_CT_VAIO_LCD */
           gen_cntl = aty_ld_8(CRTC_GEN_CNTL, info);
           if (blank > 0)
          switch (blank-1) {
      diff -Nur linux-2.4.17/drivers/video/aty/mach64.h 
linux/drivers/video/aty/mach64.h
      --- linux-2.4.17/drivers/video/aty/mach64.h   Tue Jul 31 23:43:29 2001
      +++ linux/drivers/video/aty/mach64.h   Sat Dec 22 00:24:16 2001
      @@ -1148,6 +1148,8 @@
       #define APC_LUT_MN      0x39
       #define APC_LUT_OP      0x3A

      +/* Values in CONFIG_PANEL */
      +#define DONT_SHADOW_HEND       0x00004000

       /* Values in LCD_MISC_CNTL */
       #define BIAS_MOD_LEVEL_MASK   0x0000ff00
      diff -Nur linux-2.4.17/drivers/video/aty/mach64_ct.c 
linux/drivers/video/aty/mach64_ct.c
      --- linux-2.4.17/drivers/video/aty/mach64_ct.c   Wed Aug  1 07:43:29 
2001
      +++ linux/drivers/video/aty/mach64_ct.c   Fri Jan 11 16:13:37 2002
      @@ -178,10 +178,16 @@
           }
           pll->pll_gen_cntl |= mpostdiv<<4;   /* mclk */

      -    if (M64_HAS(MAGIC_POSTDIV))
      -   pll->pll_ext_cntl = 0;
      -    else
      +#if defined(CONFIG_FB_ATY_CT_VAIO_LCD)
              pll->pll_ext_cntl = mpostdiv;   /* xclk == mclk */
      +#else
      +       if ( M64_HAS(MAGIC_POSTDIV) )
      +               pll->pll_ext_cntl = 0;
      +       else
      +               pll->pll_ext_cntl = mpostdiv;   /* xclk == mclk */
      +#endif
      +
      +

           switch (pll->vclk_post_div_real) {
          case 2:
      diff -Nur linux-2.4.17/drivers/video/modedb.c 
linux/drivers/video/modedb.c
      --- linux-2.4.17/drivers/video/modedb.c   Sat Dec 22 04:41:55 2001
      +++ linux/drivers/video/modedb.c   Fri Jan 11 16:13:37 2002
      @@ -42,6 +42,13 @@
       #define DEFAULT_MODEDB_INDEX   0

       static struct fb_videomode modedb[] __initdata = {
      +#if defined(CONFIG_FB_ATY_CT_VAIO_LCD)
      +    {
      +        /* 1024x480 @ 65 Hz */
      +        NULL, 65, 1024, 480, 25203, 24, 24, 1, 17, 144, 4,
      +        0, FB_VMODE_NONINTERLACED
      +    },
      +#endif /* CONFIG_FB_ATY_CT_VAIO_LCD */
           {
          /* 640x400 @ 70 Hz, 31.5 kHz hsync */
          NULL, 70, 640, 400, 39721, 40, 24, 39, 9, 96, 2,


    -Paul / ttye0 

