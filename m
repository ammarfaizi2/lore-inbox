Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130843AbQKQTtl>; Fri, 17 Nov 2000 14:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131112AbQKQTtb>; Fri, 17 Nov 2000 14:49:31 -0500
Received: from mhaaksma-3.dsl.speakeasy.net ([64.81.17.226]:62987 "EHLO
	mail.neruo.com") by vger.kernel.org with ESMTP id <S131111AbQKQTt0>;
	Fri, 17 Nov 2000 14:49:26 -0500
Subject: Re: [linux-fbdev] Re: Video driver bug (fwd)
From: Brad Douglas <brad@neruo.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Frame Buffer Device Development 
	<linux-fbdev@vuser.vu.union.edu>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.05.10011171036070.20673-100000@callisto.of.borg>
Content-Type: text/plain
X-Mailer: Evolution 0.6 (Developer Preview)
Date: 18 Nov 2000 03:18:59 +0800
Mime-Version: 1.0
Message-Id: <20001117194929Z131111-28370+63@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The aty128fb patch is good.

> Did anybody test these patches? Currently any user can crash the kernel by
> abusing this bug.
> 
> Gr{oetje,eeting}s,
> 
>                                               Geert
> 
> ---------- Forwarded message ----------
> Date: Sat, 14 Oct 2000 18:21:25 +0200 (CEST)
> From: Geert Uytterhoeven <geert@linux-m68k.org>
> To: Samuel Rydh <samuel@ibrium.se>
> Cc: Linux Frame Buffer Device Development <linux-fbdev@vuser.vu.union.edu>,
>      Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>, olh@suse.de
> Subject: Re: [linux-fbdev] Re: Video driver bug
> 
> On Sat, 7 Oct 2000, Geert Uytterhoeven wrote:
> > On Sat, 7 Oct 2000, Samuel Rydh wrote:
> > > Certain 2.4 video drivers (aty128, aty, platinum, tdfx, iga)
> > > appear to be buggy. More specifically, the problem is the
> > > following:
> > > 
> > > In the set_disp function, info->dispsw is initialized and disp->dispsw
> > > is given the address of info->dispsw:
> > > 
> > >   static void aty128_set_disp(..)
> > >   {
> > >     switch(bpp) {
> > >       case 8:
> > >           info->dispsw = accel ? fbcon_aty128_8 : fbcon_cfb8;
> > >           disp->dispsw = &info->dispsw;
> > >           break;
> > >      ...
> > >   }
> > > 
> > > The problem is that the info struct is shared by all virtual consoles.
> > > Thus if the video mode is set on a console which is not active, the
> > > active console will be affected too. This typically results in a kernel
> > > panic (the wrong set of console output functions is used).
> > 
> > You're right. *_set_disp() may be called for non-active VTs, changing
> > info->dispsw for the active VT.
> 
> Here are my fixes for aty128fb, atyfb, platinumfb, and tdfxfb.
> 
> Igafb is not affected since it sets disp during initialization only.
> 
> Can someone please test these patches so I can send them to Linus? I'm unable
> to test any of them (besides a simple compile test). Thanks!
> 
> --- linux-dispsw-fix-2.4.0-test10-pre2/drivers/video/atyfb.c  Sun Sep 17 20:04:17 2000
> +++ geert-dispsw-fix-2.4.0-test10-pre2/drivers/video/atyfb.c  Sat Oct 14 18:17:40 2000
> @@ -466,8 +466,8 @@
>  static int encode_fix(struct fb_fix_screeninfo *fix,
>                     const struct atyfb_par *par,
>                     const struct fb_info_aty *info);
> -static void atyfb_set_disp(struct display *disp, struct fb_info_aty *info,
> -                        int bpp, int accel);
> +static void atyfb_set_dispsw(struct display *disp, struct fb_info_aty *info,
> +                          int bpp, int accel);
>  static int atyfb_getcolreg(u_int regno, u_int *red, u_int *green, u_int *blue,
>                        u_int *transp, struct fb_info *fb);
>  static int atyfb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
> @@ -2826,8 +2826,8 @@
>  }
>  
>  
> -static void atyfb_set_disp(struct display *disp, struct fb_info_aty *info,
> -                        int bpp, int accel)
> +static void atyfb_set_dispsw(struct display *disp, struct fb_info_aty *info,
> +                          int bpp, int accel)
>  {
>           switch (bpp) {
>  #ifdef FBCON_HAS_CFB8
> @@ -2898,6 +2898,7 @@
>       oldbpp = display->var.bits_per_pixel;
>       oldaccel = display->var.accel_flags;
>       display->var = *var;
> +     accel = var->accel_flags & FB_ACCELF_TEXT;
>       if (oldxres != var->xres || oldyres != var->yres ||
>           oldvxres != var->xres_virtual || oldvyres != var->yres_virtual ||
>           oldbpp != var->bits_per_pixel || oldaccel != var->accel_flags) {
> @@ -2913,8 +2914,6 @@
>           display->line_length = fix.line_length;
>           display->can_soft_blank = 1;
>           display->inverse = 0;
> -         accel = var->accel_flags & FB_ACCELF_TEXT;
> -         atyfb_set_disp(display, info, par.crtc.bpp, accel);
>           if (accel)
>               display->scrollmode = (info->bus_type == PCI) ? SCROLL_YNOMOVE : 0;
>           else
> @@ -2923,8 +2922,10 @@
>               (*info->fb_info.changevar)(con);
>       }
>       if (!info->fb_info.display_fg ||
> -         info->fb_info.display_fg->vc_num == con)
> +         info->fb_info.display_fg->vc_num == con) {
>           atyfb_set_par(&par, info);
> +         atyfb_set_dispsw(display, info, par.crtc.bpp, accel);
> +     }
>       if (oldbpp != var->bits_per_pixel) {
>           if ((err = fb_alloc_cmap(&display->cmap, 0, 0)))
>               return err;
> @@ -4241,8 +4242,8 @@
>  
>      atyfb_decode_var(&fb_display[con].var, &par, info);
>      atyfb_set_par(&par, info);
> -    atyfb_set_disp(&fb_display[con], info, par.crtc.bpp,
> -                par.accel_flags & FB_ACCELF_TEXT);
> +    atyfb_set_dispsw(&fb_display[con], info, par.crtc.bpp,
> +                  par.accel_flags & FB_ACCELF_TEXT);
>  
>      /* Install new colormap */
>      do_install_cmap(con, fb);
> --- linux-dispsw-fix-2.4.0-test10-pre2/drivers/video/tdfxfb.c Fri Jul 28 21:19:20 2000
> +++ geert-dispsw-fix-2.4.0-test10-pre2/drivers/video/tdfxfb.c Sat Oct 14 17:29:21 2000
> @@ -327,7 +327,6 @@
>    struct tdfxfb_par default_par;
>    struct tdfxfb_par current_par;
>    struct display disp;
> -  struct display_switch dispsw;
>  #if defined(FBCON_HAS_CFB16) || defined(FBCON_HAS_CFB24) || defined(FBCON_HAS_CFB32)  
>    union {
>  #ifdef FBCON_HAS_CFB16
> @@ -412,10 +411,10 @@
>  static int  tdfxfb_encode_fix(struct fb_fix_screeninfo* fix,
>                             const struct tdfxfb_par* par,
>                             const struct fb_info_tdfx* info);
> -static void tdfxfb_set_disp(struct display* disp, 
> -                         struct fb_info_tdfx* info,
> -                         int bpp, 
> -                         int accel);
> +static void tdfxfb_set_dispsw(struct display* disp, 
> +                           struct fb_info_tdfx* info,
> +                           int bpp, 
> +                           int accel);
>  static int  tdfxfb_getcolreg(u_int regno,
>                            u_int* red, 
>                            u_int* green, 
> @@ -1640,48 +1639,43 @@
>    return 0;
>  }
>   
> -static void tdfxfb_set_disp(struct display *disp, 
> -                         struct fb_info_tdfx *info,
> -                         int bpp, 
> -                         int accel) {
> +static void tdfxfb_set_dispsw(struct display *disp, 
> +                           struct fb_info_tdfx *info,
> +                           int bpp, 
> +                           int accel) {
>  
>    if (disp->dispsw && disp->conp) 
>       fb_con.con_cursor(disp->conp, CM_ERASE);
>    switch(bpp) {
>  #ifdef FBCON_HAS_CFB8
>    case 8:
> -    info->dispsw = noaccel ? fbcon_cfb8 : fbcon_banshee8;
> -    disp->dispsw = &info->dispsw;
> +    disp->dispsw = noaccel ? &fbcon_cfb8 : &fbcon_banshee8;
>      if (nohwcursor) fbcon_banshee8.cursor = NULL;
>      break;
>  #endif
>  #ifdef FBCON_HAS_CFB16
>    case 16:
> -    info->dispsw = noaccel ? fbcon_cfb16 : fbcon_banshee16;
> -    disp->dispsw = &info->dispsw;
> +    disp->dispsw = noaccel ? &fbcon_cfb16 : &fbcon_banshee16;
>      disp->dispsw_data = info->fbcon_cmap.cfb16;
>      if (nohwcursor) fbcon_banshee16.cursor = NULL;
>      break;
>  #endif
>  #ifdef FBCON_HAS_CFB24
>    case 24:
> -    info->dispsw = noaccel ? fbcon_cfb24 : fbcon_banshee24; 
> -    disp->dispsw = &info->dispsw;
> +    disp->dispsw = noaccel ? &fbcon_cfb24 : &fbcon_banshee24; 
>      disp->dispsw_data = info->fbcon_cmap.cfb24;
>      if (nohwcursor) fbcon_banshee24.cursor = NULL;
>      break;
>  #endif
>  #ifdef FBCON_HAS_CFB32
>    case 32:
> -    info->dispsw = noaccel ? fbcon_cfb32 : fbcon_banshee32;
> -    disp->dispsw = &info->dispsw;
> +    disp->dispsw = noaccel ? &fbcon_cfb32 : &fbcon_banshee32;
>      disp->dispsw_data = info->fbcon_cmap.cfb32;
>      if (nohwcursor) fbcon_banshee32.cursor = NULL;
>      break;
>  #endif
>    default:
> -    info->dispsw = fbcon_dummy;
> -    disp->dispsw = &info->dispsw;
> +    disp->dispsw = &fbcon_dummy;
>    }
>     
>  }
> @@ -1735,7 +1729,7 @@
>        display->can_soft_blank = 1;
>        display->inverse        = inverse;
>        accel = var->accel_flags & FB_ACCELF_TEXT;
> -      tdfxfb_set_disp(display, info, par.bpp, accel);
> +      tdfxfb_set_dispsw(display, info, par.bpp, accel);
>        
>        if(nopan) display->scrollmode = SCROLL_YREDRAW;
>       
> @@ -2083,10 +2077,10 @@
>     
>     info->cursor.redraw=1;
>     
> -   tdfxfb_set_disp(&fb_display[con], 
> -                info, 
> -                par.bpp,
> -                par.accel_flags & FB_ACCELF_TEXT);
> +   tdfxfb_set_dispsw(&fb_display[con], 
> +                  info, 
> +                  par.bpp,
> +                  par.accel_flags & FB_ACCELF_TEXT);
>     
>     tdfxfb_install_cmap(&fb_display[con], fb);
>     tdfxfb_updatevar(con, fb);
> --- linux-dispsw-fix-2.4.0-test10-pre2/drivers/video/aty128fb.c       Sun Sep 17 20:04:17 2000
> +++ geert-dispsw-fix-2.4.0-test10-pre2/drivers/video/aty128fb.c       Sat Oct 14 17:32:10 2000
> @@ -283,7 +283,6 @@
>      const struct aty128_meminfo *mem;   /* onboard mem info    */
>      struct aty128fb_par default_par, current_par;
>      struct display disp;
> -    struct display_switch dispsw;       /* for cursor and font */
>      struct { u8 red, green, blue, pad; } palette[256];
>      union {
>  #ifdef FBCON_HAS_CFB16
> @@ -347,7 +346,7 @@
>  static void aty128_encode_fix(struct fb_fix_screeninfo *fix,
>                               struct aty128fb_par *par,
>                               const struct fb_info_aty128 *info);
> -static void aty128_set_disp(struct display *disp,
> +static void aty128_set_dispsw(struct display *disp,
>                       struct fb_info_aty128 *info, int bpp, int accel);
>  static int aty128_getcolreg(u_int regno, u_int *red, u_int *green, u_int *blue,
>                               u_int *transp, struct fb_info *info);
> @@ -1392,7 +1391,7 @@
>       display->inverse = 0;
>  
>       accel = var->accel_flags & FB_ACCELF_TEXT;
> -        aty128_set_disp(display, info, par.crtc.bpp, accel);
> +        aty128_set_dispsw(display, info, par.crtc.bpp, accel);
>  
>       if (accel)
>           display->scrollmode = SCROLL_YNOMOVE;
> @@ -1417,35 +1416,31 @@
>  
>  
>  static void
> -aty128_set_disp(struct display *disp,
> +aty128_set_dispsw(struct display *disp,
>                       struct fb_info_aty128 *info, int bpp, int accel)
>  {
>      switch (bpp) {
>  #ifdef FBCON_HAS_CFB8
>      case 8:
> -     info->dispsw = accel ? fbcon_aty128_8 : fbcon_cfb8;
> -        disp->dispsw = &info->dispsw;
> +     disp->dispsw = accel ? &fbcon_aty128_8 : &fbcon_cfb8;
>       break;
>  #endif
>  #ifdef FBCON_HAS_CFB16
>      case 15:
>      case 16:
> -     info->dispsw = accel ? fbcon_aty128_16 : fbcon_cfb16;
> -        disp->dispsw = &info->dispsw;
> +     disp->dispsw = accel ? &fbcon_aty128_16 : &fbcon_cfb16;
>       disp->dispsw_data = info->fbcon_cmap.cfb16;
>       break;
>  #endif
>  #ifdef FBCON_HAS_CFB24
>      case 24:
> -     info->dispsw = accel ? fbcon_aty128_24 : fbcon_cfb24;
> -        disp->dispsw = &info->dispsw;
> +     disp->dispsw = accel ? &fbcon_aty128_24 : &fbcon_cfb24;
>       disp->dispsw_data = info->fbcon_cmap.cfb24;
>       break;
>  #endif
>  #ifdef FBCON_HAS_CFB32
>      case 32:
> -     info->dispsw = accel ? fbcon_aty128_32 : fbcon_cfb32;
> -        disp->dispsw = &info->dispsw;
> +     disp->dispsw = accel ? &fbcon_aty128_32 : &fbcon_cfb32;
>       disp->dispsw_data = info->fbcon_cmap.cfb32;
>       break;
>  #endif
> @@ -2135,7 +2130,7 @@
>      aty128_decode_var(&fb_display[con].var, &par, info);
>      aty128_set_par(&par, info);
>  
> -    aty128_set_disp(&fb_display[con], info, par.crtc.bpp,
> +    aty128_set_dispsw(&fb_display[con], info, par.crtc.bpp,
>          par.accel_flags & FB_ACCELF_TEXT);
>  
>      do_install_cmap(con, fb);
> --- linux-dispsw-fix-2.4.0-test10-pre2/drivers/video/platinumfb.c     Sat Aug  5 14:20:03 2000
> +++ geert-dispsw-fix-2.4.0-test10-pre2/drivers/video/platinumfb.c     Sat Oct 14 17:30:22 2000
> @@ -65,7 +65,6 @@
>  struct fb_info_platinum {
>       struct fb_info                  fb_info;
>       struct display                  disp;
> -     struct display_switch           dispsw;
>       struct fb_par_platinum          default_par;
>       struct fb_par_platinum          current_par;
>  
> @@ -140,8 +139,9 @@
>  static int platinum_encode_fix(struct fb_fix_screeninfo *fix,
>                              const struct fb_par_platinum *par,
>                              const struct fb_info_platinum *info);
> -static void platinum_set_disp(struct display *disp, struct fb_info_platinum *info,
> -                           int cmode, int accel);
> +static void platinum_set_dispsw(struct display *disp,
> +                             struct fb_info_platinum *info, int cmode,
> +                             int accel);
>  static int platinum_getcolreg(u_int regno, u_int *red, u_int *green, u_int *blue,
>                             u_int *transp, struct fb_info *fb);
>  static int platinum_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
> @@ -193,27 +193,25 @@
>       return 0;
>  }
>  
> -static void platinum_set_disp(struct display *disp, struct fb_info_platinum *info,
> -                           int cmode, int accel)
> +static void platinum_set_dispsw(struct display *disp,
> +                             struct fb_info_platinum *info, int cmode,
> +                             int accel)
>  {
>       switch(cmode) {
>  #ifdef FBCON_HAS_CFB8
>           case CMODE_8:
> -             info->dispsw = fbcon_cfb8;
> -             disp->dispsw = &info->dispsw;
> +             disp->dispsw = &fbcon_cfb8;
>               break;
>  #endif
>  #ifdef FBCON_HAS_CFB16
>           case CMODE_16:
> -             info->dispsw = fbcon_cfb16;
> -             disp->dispsw = &info->dispsw;
> +             disp->dispsw = &fbcon_cfb16;
>               disp->dispsw_data = info->fbcon_cmap.cfb16;
>               break;
>  #endif
>  #ifdef FBCON_HAS_CFB32
>           case CMODE_32:
> -             info->dispsw = fbcon_cfb32;
> -             disp->dispsw = &info->dispsw;
> +             disp->dispsw = &fbcon_cfb32;
>               disp->dispsw_data = info->fbcon_cmap.cfb32;
>               break;
>  #endif
> @@ -271,7 +269,7 @@
>           display->line_length = fix.line_length;
>           display->can_soft_blank = 1;
>           display->inverse = 0;
> -         platinum_set_disp(display, info, par.cmode, 0);
> +         platinum_set_dispsw(display, info, par.cmode, 0);
>           display->scrollmode = SCROLL_YREDRAW;
>           if (info->fb_info.changevar)
>             (*info->fb_info.changevar)(con);
> @@ -341,7 +339,7 @@
>  
>       platinum_var_to_par(&fb_display[con].var, &par, info);
>       platinum_set_par(&par, info);
> -     platinum_set_disp(&fb_display[con], info, par.cmode, 0);
> +     platinum_set_dispsw(&fb_display[con], info, par.cmode, 0);
>       do_install_cmap(con, fb);
>  
>       return 1;
> 
> Gr{oetje,eeting}s,
> 
>                                               Geert

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
