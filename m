Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264602AbSIVXCy>; Sun, 22 Sep 2002 19:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264596AbSIVXCy>; Sun, 22 Sep 2002 19:02:54 -0400
Received: from M918P024.adsl.highway.telekom.at ([62.47.146.184]:29314 "HELO
	twinny.dyndns.org") by vger.kernel.org with SMTP id <S264603AbSIVXCs>;
	Sun, 22 Sep 2002 19:02:48 -0400
Message-ID: <3D8E4C06.17542139@winischhofer.net>
Date: Mon, 23 Sep 2002 01:02:30 +0200
From: Thomas Winischhofer <thomas@winischhofer.net>
X-Mailer: Mozilla 4.78 [en] (Windows NT 5.0; U)
X-Accept-Language: en,en-GB,en-US,de-AT,de-DE,de-CH,sv
MIME-Version: 1.0
To: bert hubert <ahu@ds9a.nl>
CC: jsimmons@transvirtual.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] botched sisfb fixes for 2.5.38
References: <20020922212234.GA24640@outpost.ds9a.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Bert,

thanks, but: This is not a proper fix. The disp-structure will be
removed soon, and so will the high level console acceleration stuff. It
might be alright for 2.5.38, but I will not include this in my current
driver. (And moving sisfb.h away from the kernel headers will break user
land applications)

Thomas

bert hubert wrote:
> 
> Thomas, James, list,
> 
> The FB API is still not entirely stable according to Thomas and James but I
> really want to get my laptop working with 2.5 and X. 2.5.38 has new sisfb
> code that actually works but it is not quite ready for the current FB API,
> and does not compile.
> 
> This patch is the best I can do right now in fixing that. It compiles, links
> and boots and shows a penguin logo, but it does not run X.
> 
> When starting X it says:
> sisfb: Change mode to 1024x768x16-60Hz
> sisfb: CRT2 type is LCD
> sisfb: (LCDInfo = 0xe9 LCDResInfo = 0x2 LCDTypeInfo = 0xe)
> 
> X says:
> 
> mmap fbmem: Invalid argument
> 
> The diff moves a file around, which is why it is pretty large. The meat is
> in the first file.
> 
> diff -uBbrN linux-2.5.38/drivers/video/sis/sis_main.c linux-ahu/drivers/video/sis/sis_main.c
> --- linux-2.5.38/drivers/video/sis/sis_main.c   Sun Sep 22 23:02:10 2002
> +++ linux-ahu/drivers/video/sis/sis_main.c      Sun Sep 22 22:49:28 2002
> @@ -646,11 +646,19 @@
>         return 0;
>  }
> 
> +static struct fb_fix_screeninfo sisfb_fix __initdata = {
> +       .id     = "SIS VGA",
> +       .type   = FB_TYPE_PACKED_PIXELS,
> +       .accel  = FB_ACCEL_SIS_GLAMOUR,
> +};
> +
> +
>  static void sisfb_set_disp(int con, struct fb_var_screeninfo *var)
>  {
>         struct fb_fix_screeninfo fix;
>         struct display *display;
>         struct display_switch *sw;
> +       static spinlock_t driver_lock = SPIN_LOCK_UNLOCKED;
>         long flags;
> 
>         if (con >= 0)
> @@ -663,18 +671,20 @@
>  #if LINUX_VERSION_CODE <= KERNEL_VERSION(2,5,23)
>         display->screen_base = ivideo.video_vbase;
>  #endif
> -       display->visual = fix.visual;
> -       display->type = fix.type;
> -       display->type_aux = fix.type_aux;
> -       display->ypanstep = fix.ypanstep;
> -       display->ywrapstep = fix.ywrapstep;
> -       display->line_length = fix.line_length;
> +       sisfb_fix.visual = fix.visual;
> +       sisfb_fix.type = fix.type;
> +       sisfb_fix.type_aux = fix.type_aux;
> +       sisfb_fix.ypanstep = fix.ypanstep;
> +       sisfb_fix.ywrapstep = fix.ywrapstep;
> +       sisfb_fix.line_length = fix.line_length;
>         display->next_line = fix.line_length;
>         display->can_soft_blank = 0;
>         display->inverse = sisfb_inverse;
>         display->var = *var;
> 
> -       save_flags(flags);
> +       fb_info.fix=sisfb_fix;
> +
> +       spin_lock_irqsave(&driver_lock, flags);
>         switch (ivideo.video_bpp) {
>  #ifdef FBCON_HAS_CFB8
>            case 8:
> @@ -706,7 +716,7 @@
>         }
>         memcpy(&sisfb_sw, sw, sizeof(*sw));
>         display->dispsw = &sisfb_sw;
> -       restore_flags(flags);
> +       spin_unlock_irqrestore(&driver_lock, flags);
> 
>         display->scrollmode = SCROLL_YREDRAW;
>         sisfb_sw.bmove = fbcon_redraw_bmove;
> @@ -2560,8 +2570,8 @@
> 
>  static struct fb_ops sisfb_ops = {
>         .owner          = THIS_MODULE,
> -       .fb_get_fix     = sisfb_get_fix,
> -       .fb_get_var     = sisfb_get_var,
> +       //      .fb_get_fix     = sisfb_get_fix,
> +       //      .fb_get_var     = sisfb_get_var,
>         .fb_set_var     = sisfb_set_var,
>         .fb_get_cmap    = sisfb_get_cmap,
>         .fb_set_cmap    = sisfb_set_cmap,
> @@ -2627,7 +2637,7 @@
>         return 1;
>  }
> 
> -static void sisfb_blank(int blank, struct fb_info *info)
> +static int sisfb_blank(int blank, struct fb_info *info)
>  {
>         u8 reg;
> 
> @@ -2641,6 +2651,7 @@
> 
>         vgawb(CRTC_ADR, 0x17);
>         vgawb(CRTC_DATA, reg);
> +       return 0;
>  }
> 
>  int sisfb_setup(char *options)
> 
> diff -uBbrN linux-2.5.38/drivers/video/sis/sis_main.h linux-ahu/drivers/video/sis/sis_main.h
> --- linux-2.5.38/drivers/video/sis/sis_main.h   Sun Sep 22 23:01:26 2002
> +++ linux-ahu/drivers/video/sis/sis_main.h      Sun Sep 22 22:42:26 2002
> @@ -717,7 +716,7 @@
>  int sisfb_init(void);
>  static int sisfb_update_var(int con, struct fb_info *info);
>  static int sisfb_switch(int con, struct fb_info *info);
> -static void sisfb_blank(int blank, struct fb_info *info);
> +static int sisfb_blank(int blank, struct fb_info *info);
> 
>  /* hardware access routines */
>  void sisfb_set_reg1(u16 port, u16 index, u16 data);
> 
> diff -uBbrN linux-2.5.38/drivers/video/sis/sisfb.h linux-ahu/drivers/video/sis/sisfb.h
> --- linux-2.5.38/drivers/video/sis/sisfb.h      Sun Sep 22 23:01:26 2002
> +++ linux-ahu/drivers/video/sis/sisfb.h Thu Jan  1 01:00:00 1970
> @@ -1,153 +0,0 @@
> -#ifndef _LINUX_SISFB
> -#define _LINUX_SISFB
> -
> -#include <asm/ioctl.h>
> -#include <asm/types.h>
> -
> -#define DISPTYPE_CRT1       0x00000008L
> -#define DISPTYPE_CRT2       0x00000004L
> -#define DISPTYPE_LCD        0x00000002L
> -#define DISPTYPE_TV         0x00000001L
> -#define DISPTYPE_DISP1      DISPTYPE_CRT1
> -#define DISPTYPE_DISP2      (DISPTYPE_CRT2 | DISPTYPE_LCD | DISPTYPE_TV)
> -#define DISPMODE_SINGLE            0x00000020L
> -#define DISPMODE_MIRROR            0x00000010L
> -#define DISPMODE_DUALVIEW   0x00000040L
> -
> -#define HASVB_NONE             0x00
> -#define HASVB_301              0x01
> -#define HASVB_LVDS             0x02
> -#define HASVB_TRUMPION         0x04
> -#define HASVB_LVDS_CHRONTEL    0x10
> -#define HASVB_302              0x20
> -#define HASVB_303              0x40
> -#define HASVB_CHRONTEL         0x80
> -
> -/* TW: *Never* change the order of the following enum */
> -typedef enum _SIS_CHIP_TYPE {
> -       SIS_VGALegacy = 0,
> -       SIS_300,
> -       SIS_630,
> -       SIS_540,
> -       SIS_730,
> -       SIS_315H,
> -       SIS_315,
> -       SIS_550,
> -       SIS_315PRO,
> -       SIS_640,
> -       SIS_740,
> -       SIS_650,
> -       SIS_330,
> -       MAX_SIS_CHIP
> -} SIS_CHIP_TYPE;
> -
> -typedef enum _TVTYPE {
> -       TVMODE_NTSC = 0,
> -       TVMODE_PAL,
> -       TVMODE_HIVISION,
> -       TVMODE_TOTAL
> -} SIS_TV_TYPE;
> -
> -typedef enum _TVPLUGTYPE {
> -       TVPLUG_Legacy = 0,
> -       TVPLUG_COMPOSITE,
> -       TVPLUG_SVIDEO,
> -       TVPLUG_SCART,
> -       TVPLUG_TOTAL
> -} SIS_TV_PLUG;
> -
> -struct sis_memreq {
> -       unsigned long offset;
> -       unsigned long size;
> -};
> -
> -struct mode_info {
> -       int    bpp;
> -       int    xres;
> -       int    yres;
> -       int    v_xres;
> -       int    v_yres;
> -       int    org_x;
> -       int    org_y;
> -       unsigned int  vrate;
> -};
> -
> -struct ap_data {
> -       struct mode_info minfo;
> -       unsigned long iobase;
> -       unsigned int  mem_size;
> -       unsigned long disp_state;
> -       SIS_CHIP_TYPE chip;
> -       unsigned char hasVB;
> -       SIS_TV_TYPE TV_type;
> -       SIS_TV_PLUG TV_plug;
> -       unsigned long version;
> -       char reserved[256];
> -};
> -
> -struct video_info {
> -       int    chip_id;
> -       unsigned int  video_size;
> -       unsigned long video_base;
> -       char  *video_vbase;
> -       unsigned long mmio_base;
> -       char  *mmio_vbase;
> -       unsigned long vga_base;
> -       unsigned long mtrr;
> -       unsigned long heapstart;
> -
> -       int    video_bpp;
> -       int    video_width;
> -       int    video_height;
> -       int    video_vwidth;
> -       int    video_vheight;
> -       int    org_x;
> -       int    org_y;
> -       unsigned int refresh_rate;
> -
> -       unsigned long disp_state;
> -       unsigned char hasVB;
> -       unsigned char TV_type;
> -       unsigned char TV_plug;
> -
> -       SIS_CHIP_TYPE chip;
> -       unsigned char revision_id;
> -
> -       char reserved[256];
> -};
> -
> -
> -/* TW: Addtional IOCTL for communication sisfb <> X driver                 */
> -/*     If changing this, vgatypes.h must also be changed (for X driver)    */
> -
> -/* TW: ioctl for identifying and giving some info (esp. memory heap start) */
> -#define SISFB_GET_INFO   _IOR('n',0xF8,sizeof(__u32))
> -
> -/* TW: Structure argument for SISFB_GET_INFO ioctl  */
> -typedef struct _SISFB_INFO sisfb_info, *psisfb_info;
> -
> -struct _SISFB_INFO {
> -       unsigned long sisfb_id;         /* for identifying sisfb */
> -#ifndef SISFB_ID
> -#define SISFB_ID         0x53495346    /* Identify myself with 'SISF' */
> -#endif
> -       int    chip_id;                 /* PCI ID of detected chip */
> -       int    memory;                  /* video memory in KB which sisfb manages */
> -       int    heapstart;               /* heap start (= sisfb "mem" argument) in KB */
> -       unsigned char fbvidmode;        /* current sisfb mode */
> -
> -       unsigned char sisfb_version;
> -       unsigned char sisfb_revision;
> -       unsigned char sisfb_patchlevel;
> -
> -       char reserved[253];             /* for future use */
> -};
> -
> -#ifdef __KERNEL__
> -extern struct video_info ivideo;
> -
> -extern void sis_malloc(struct sis_memreq *req);
> -extern void sis_free(unsigned long base);
> -extern void sis_dispinfo(struct ap_data *rec);
> -#endif
> -#endif
> 
> diff -uBbrN linux-2.5.38/include/linux/sisfb.h linux-ahu/include/linux/sisfb.h
> --- linux-2.5.38/include/linux/sisfb.h  Wed Jul 17 01:49:27 2002
> +++ linux-ahu/include/linux/sisfb.h     Fri Sep 20 18:04:55 2002
> @@ -1,6 +1,9 @@
>  #ifndef _LINUX_SISFB
>  #define _LINUX_SISFB
> 
> +#include <asm/ioctl.h>
> +#include <asm/types.h>
> +
>  #define DISPTYPE_CRT1       0x00000008L
>  #define DISPTYPE_CRT2       0x00000004L
>  #define DISPTYPE_LCD        0x00000002L
> @@ -20,6 +23,7 @@
>  #define HASVB_303              0x40
>  #define HASVB_CHRONTEL         0x80
> 
> +/* TW: *Never* change the order of the following enum */
>  typedef enum _SIS_CHIP_TYPE {
>         SIS_VGALegacy = 0,
>         SIS_300,
> @@ -32,6 +36,7 @@
>         SIS_315PRO,
>         SIS_640,
>         SIS_740,
> +       SIS_650,
>         SIS_330,
>         MAX_SIS_CHIP
>  } SIS_CHIP_TYPE;
> @@ -88,6 +93,8 @@
>         unsigned long mmio_base;
>         char  *mmio_vbase;
>         unsigned long vga_base;
> +       unsigned long mtrr;
> +       unsigned long heapstart;
> 
>         int    video_bpp;
>         int    video_width;
> @@ -107,6 +114,33 @@
>         unsigned char revision_id;
> 
>         char reserved[256];
> +};
> +
> +
> +/* TW: Addtional IOCTL for communication sisfb <> X driver                 */
> +/*     If changing this, vgatypes.h must also be changed (for X driver)    */
> +
> +/* TW: ioctl for identifying and giving some info (esp. memory heap start) */
> +#define SISFB_GET_INFO   _IOR('n',0xF8,sizeof(__u32))
> +
> +/* TW: Structure argument for SISFB_GET_INFO ioctl  */
> +typedef struct _SISFB_INFO sisfb_info, *psisfb_info;
> +
> +struct _SISFB_INFO {
> +       unsigned long sisfb_id;         /* for identifying sisfb */
> +#ifndef SISFB_ID
> +#define SISFB_ID         0x53495346    /* Identify myself with 'SISF' */
> +#endif
> +       int    chip_id;                 /* PCI ID of detected chip */
> +       int    memory;                  /* video memory in KB which sisfb manages */
> +       int    heapstart;               /* heap start (= sisfb "mem" argument) in KB */
> +       unsigned char fbvidmode;        /* current sisfb mode */
> +
> +       unsigned char sisfb_version;
> +       unsigned char sisfb_revision;
> +       unsigned char sisfb_patchlevel;
> +
> +       char reserved[253];             /* for future use */
>  };
> 
>  #ifdef __KERNEL__
> 
> 
> --
> http://www.PowerDNS.com          Versatile DNS Software & Services
> http://www.tk                              the dot in .tk
> http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO

-- 
Thomas Winischhofer
Vienna/Austria
mailto:thomas@winischhofer.net          *** http://www.winischhofer.net
