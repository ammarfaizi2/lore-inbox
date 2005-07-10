Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262053AbVGJWyV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262053AbVGJWyV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 18:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262066AbVGJTi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:38:29 -0400
Received: from mx1.suse.de ([195.135.220.2]:19091 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262014AbVGJTgM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:36:12 -0400
Date: Sun, 10 Jul 2005 19:36:10 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: Antonino Daplas <adaplas@pol.net>
Subject: [PATCH 62/82] remove linux/version.h from drivers/video/sis
Message-ID: <20050710193610.62.QvUXYb3922.2247.olh@nectarine.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
In-Reply-To: <20050710193508.0.PmFpst2252.2247.olh@nectarine.suse.de>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


changing CONFIG_LOCALVERSION rebuilds too much, for no appearent reason.

remove code for obsolete kernels:
#error "This version of sisfb requires at least 2.6.3"

FBCON_HAS_CFB8, FBCON_HAS_CFB16 and FBCON_HAS_CFB32 is appearently from 2.4

there is odd code like:
-          outSISIDXREG(SISSR,0x14,0x??);  /* 8MB, 64bit default */
+          outSISIDXREG(SISSR,0x14,0x00);  /* 8MB, 64bit default */


Signed-off-by: Olaf Hering <olh@suse.de>

drivers/video/sis/init.h      |    5
drivers/video/sis/init301.h   |    5
drivers/video/sis/sis.h       |   46 --
drivers/video/sis/sis_accel.c |  171 ---------
drivers/video/sis/sis_accel.h |   13
drivers/video/sis/sis_main.c  |  784 ------------------------------------------
drivers/video/sis/sis_main.h  |   55 --
drivers/video/sis/vgatypes.h  |    3
8 files changed, 1 insertion(+), 1081 deletions(-)

Index: linux-2.6.13-rc2-mm1/drivers/video/sis/init.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/video/sis/init.h
+++ linux-2.6.13-rc2-mm1/drivers/video/sis/init.h
@@ -68,16 +68,11 @@
#undef SIS_CP
#endif
#include <linux/config.h>
-#include <linux/version.h>
#include <linux/types.h>
#include <asm/io.h>
#include <linux/fb.h>
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-#include <linux/sisfb.h>
-#else
#include <video/sisfb.h>
#endif
-#endif

/* Mode numbers */
static const USHORT ModeIndex_320x200[]      = {0x59, 0x41, 0x00, 0x4f};
Index: linux-2.6.13-rc2-mm1/drivers/video/sis/init301.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/video/sis/init301.h
+++ linux-2.6.13-rc2-mm1/drivers/video/sis/init301.h
@@ -68,15 +68,10 @@
#undef SIS_CP
#endif
#include <linux/config.h>
-#include <linux/version.h>
#include <asm/io.h>
#include <linux/types.h>
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-#include <linux/sisfb.h>
-#else
#include <video/sisfb.h>
#endif
-#endif

static const UCHAR SiS_YPbPrTable[3][64] = {
{
Index: linux-2.6.13-rc2-mm1/drivers/video/sis/sis.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/video/sis/sis.h
+++ linux-2.6.13-rc2-mm1/drivers/video/sis/sis.h
@@ -23,14 +23,9 @@
#define _SIS_H

#include <linux/config.h>
-#include <linux/version.h>

#include "osdef.h"
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
#include <video/sisfb.h>
-#else
-#include <linux/sisfb.h>
-#endif

#include "vgatypes.h"
#include "vstruct.h"
@@ -41,29 +36,15 @@

#undef SIS_CONFIG_COMPAT

-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
#include <linux/spinlock.h>
#ifdef CONFIG_COMPAT
#include <linux/ioctl32.h>
#define SIS_CONFIG_COMPAT
#endif
-#elif LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,19)
-#ifdef __x86_64__
-/* Shouldn't we check for CONFIG_IA32_EMULATION here? */
-#include <asm/ioctl32.h>
-#define SIS_CONFIG_COMPAT
-#endif
-#endif

-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,8)
#define SIS_IOTYPE1 void __iomem
#define SIS_IOTYPE2 __iomem
#define SISINITSTATIC static
-#else
-#define SIS_IOTYPE1 unsigned char
-#define SIS_IOTYPE2
-#define SISINITSTATIC
-#endif

#undef SISFBDEBUG

@@ -382,26 +363,8 @@ struct sis_video_info {

struct fb_var_screeninfo default_var;

-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
struct fb_fix_screeninfo sisfb_fix;
u32 		pseudo_palette[17];
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-	struct display 		 sis_disp;
-	struct display_switch 	 sisfb_sw;
-	struct {
-		u16 red, green, blue, pad;
-	} 		sis_palette[256];
-	union {
-#ifdef FBCON_HAS_CFB16
-		u16 cfb16[16];
-#endif
-#ifdef FBCON_HAS_CFB32
-		u32 cfb32[16];
-#endif
-	} 		sis_fbcon_cmap;
-#endif

struct sisfb_monitor {
u16 hmin;
@@ -420,10 +383,6 @@ struct sis_video_info {

int		mni;	/* Mode number index */

-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-	int  		currcon;
-#endif
-
unsigned long	video_size;
unsigned long 	video_base;
unsigned long	mmio_size;
@@ -457,9 +416,6 @@ struct sis_video_info {
int		sisfb_tvstd;
int		sisfb_filter;
int		sisfb_nocrt2rate;
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-	int		sisfb_inverse;
-#endif

u32 		heapstart;        	/* offset  */
SIS_IOTYPE1  	*sisfb_heap_start; 	/* address */
@@ -520,9 +476,7 @@ struct sis_video_info {
int    		modechanged;
unsigned char 	modeprechange;

-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
u8 		sisfb_lastrates[128];
-#endif

int  		newrom;
int  		registered;
Index: linux-2.6.13-rc2-mm1/drivers/video/sis/sis_accel.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/video/sis/sis_accel.c
+++ linux-2.6.13-rc2-mm1/drivers/video/sis/sis_accel.c
@@ -27,7 +27,6 @@
*/

#include <linux/config.h>
-#include <linux/version.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/errno.h>
@@ -41,14 +40,6 @@

#include <asm/io.h>

-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-#include <video/fbcon.h>
-#include <video/fbcon-cfb8.h>
-#include <video/fbcon-cfb16.h>
-#include <video/fbcon-cfb24.h>
-#include <video/fbcon-cfb32.h>
-#endif
-
#include "sis.h"
#include "sis_accel.h"

@@ -92,11 +83,9 @@ static const u8 sisPatALUConv[] =
0xFF,       /* dest = 0xFF;         1,      GXset,          0xF */
};

-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,34)
static const int myrops[] = {
3, 10, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3
};
-#endif

/* 300 series ----------------------------------------------------- */
#ifdef CONFIG_FB_SIS_300
@@ -312,8 +301,6 @@ void sisfb_syncaccel(struct sis_video_in
}
}

-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)  /* --------------- 2.5 --------------- */
-
int fbcon_sis_sync(struct fb_info *info)
{
struct sis_video_info *ivideo = (struct sis_video_info *)info->par;
@@ -447,71 +434,6 @@ void fbcon_sis_copyarea(struct fb_info *
}
}

-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)  /* -------------- 2.4 --------------- */
-
-void fbcon_sis_bmove(struct display *p, int srcy, int srcx,
-			    int dsty, int dstx, int height, int width)
-{
-	struct sis_video_info *ivideo = (struct sis_video_info *)p->fb_info->par;
-
-	CRITFLAGS
-
-	if(!ivideo->accel) {
-	    switch(ivideo->video_bpp) {
-	    case 8:
-#ifdef FBCON_HAS_CFB8
-	       fbcon_cfb8_bmove(p, srcy, srcx, dsty, dstx, height, width);
-#endif
-	       break;
-	    case 16:
-#ifdef FBCON_HAS_CFB16
-	       fbcon_cfb16_bmove(p, srcy, srcx, dsty, dstx, height, width);
-#endif
-	       break;
-	    case 32:
-#ifdef FBCON_HAS_CFB32
-	       fbcon_cfb32_bmove(p, srcy, srcx, dsty, dstx, height, width);
-#endif
-	       break;
-            }
-	    return;
-	}
-
-	srcx *= fontwidth(p);
-	srcy *= fontheight(p);
-	dstx *= fontwidth(p);
-	dsty *= fontheight(p);
-	width *= fontwidth(p);
-	height *= fontheight(p);
-
-	if(ivideo->sisvga_engine == SIS_300_VGA) {
-#ifdef CONFIG_FB_SIS_300
-	   int xdir, ydir;
-
-	   if(srcx < dstx) xdir = 0;
-	   else            xdir = 1;
-	   if(srcy < dsty) ydir = 0;
-	   else            ydir = 1;
-
-	   CRITBEGIN
-	   SiS300SetupForScreenToScreenCopy(ivideo, xdir, ydir, 3, -1);
-	   SiS300SubsequentScreenToScreenCopy(ivideo, srcx, srcy, dstx, dsty, width, height);
-	   CRITEND
-	   SiS300Sync(ivideo);
-#endif
-	} else {
-#ifdef CONFIG_FB_SIS_315
-	   CRITBEGIN
-	   SiS310SetupForScreenToScreenCopy(ivideo, 3, -1);
-	   SiS310SubsequentScreenToScreenCopy(ivideo, srcx, srcy, dstx, dsty, width, height);
-	   CRITEND
-	   SiS310Sync(ivideo);
-#endif
-	}
-}
-
static void fbcon_sis_clear(struct vc_data *conp, struct display *p,
int srcy, int srcx, int height, int width, int color)
{
@@ -549,9 +471,6 @@ void fbcon_sis_clear8(struct vc_data *co
u32 bgx;

if(!ivideo->accel) {
-#ifdef FBCON_HAS_CFB8
-	    fbcon_cfb8_clear(conp, p, srcy, srcx, height, width);
-#endif
return;
}

@@ -566,9 +485,6 @@ void fbcon_sis_clear16(struct vc_data *c
u32 bgx;

if(!ivideo->accel) {
-#ifdef FBCON_HAS_CFB16
-	    fbcon_cfb16_clear(conp, p, srcy, srcx, height, width);
-#endif
return;
}

@@ -583,96 +499,9 @@ void fbcon_sis_clear32(struct vc_data *c
u32 bgx;

if(!ivideo->accel) {
-#ifdef FBCON_HAS_CFB32
-	    fbcon_cfb32_clear(conp, p, srcy, srcx, height, width);
-#endif
return;
}

bgx = ((u_int32_t*)p->dispsw_data)[attr_bgcol_ec(p, conp)];
fbcon_sis_clear(conp, p, srcy, srcx, height, width, bgx);
}
-
-void fbcon_sis_revc(struct display *p, int srcx, int srcy)
-{
-	struct sis_video_info *ivideo = (struct sis_video_info *)p->fb_info->par;
-	CRITFLAGS
-
-	if(!ivideo->accel) {
-	    switch(ivideo->video_bpp) {
-	    case 16:
-#ifdef FBCON_HAS_CFB16
-	       fbcon_cfb16_revc(p, srcx, srcy);
-#endif
-	       break;
-	    case 32:
-#ifdef FBCON_HAS_CFB32
-	       fbcon_cfb32_revc(p, srcx, srcy);
-#endif
-	       break;
-            }
-	    return;
-	}
-
-	srcx *= fontwidth(p);
-	srcy *= fontheight(p);
-
-	if(ivideo->sisvga_engine == SIS_300_VGA) {
-#ifdef CONFIG_FB_SIS_300
-	   CRITBEGIN
-	   SiS300SetupForSolidFill(ivideo, 0, 0x0a);
-	   SiS300SubsequentSolidFillRect(ivideo, srcx, srcy, fontwidth(p), fontheight(p));
-	   CRITEND
-	   SiS300Sync(ivideo);
-#endif
-	} else {
-#ifdef CONFIG_FB_SIS_315
-	   CRITBEGIN
-	   SiS310SetupForSolidFill(ivideo, 0, 0x0a);
-	   SiS310SubsequentSolidFillRect(ivideo, srcx, srcy, fontwidth(p), fontheight(p));
-	   CRITEND
-	   SiS310Sync(ivideo);
-#endif
-	}
-}
-
-#ifdef FBCON_HAS_CFB8
-struct display_switch fbcon_sis8 = {
-	.setup		= fbcon_cfb8_setup,
-	.bmove		= fbcon_sis_bmove,
-	.clear		= fbcon_sis_clear8,
-	.putc		= fbcon_cfb8_putc,
-	.putcs		= fbcon_cfb8_putcs,
-	.revc		= fbcon_cfb8_revc,
-	.clear_margins	= fbcon_cfb8_clear_margins,
-	.fontwidthmask	= FONTWIDTH(4)|FONTWIDTH(8)|FONTWIDTH(12)|FONTWIDTH(16)
-};
-#endif
-#ifdef FBCON_HAS_CFB16
-struct display_switch fbcon_sis16 = {
-	.setup		= fbcon_cfb16_setup,
-	.bmove		= fbcon_sis_bmove,
-	.clear		= fbcon_sis_clear16,
-	.putc		= fbcon_cfb16_putc,
-	.putcs		= fbcon_cfb16_putcs,
-	.revc		= fbcon_sis_revc,
-	.clear_margins	= fbcon_cfb16_clear_margins,
-	.fontwidthmask	= FONTWIDTH(4)|FONTWIDTH(8)|FONTWIDTH(12)|FONTWIDTH(16)
-};
-#endif
-#ifdef FBCON_HAS_CFB32
-struct display_switch fbcon_sis32 = {
-	.setup		= fbcon_cfb32_setup,
-	.bmove		= fbcon_sis_bmove,
-	.clear		= fbcon_sis_clear32,
-	.putc		= fbcon_cfb32_putc,
-	.putcs		= fbcon_cfb32_putcs,
-	.revc		= fbcon_sis_revc,
-	.clear_margins	= fbcon_cfb32_clear_margins,
-	.fontwidthmask	= FONTWIDTH(4)|FONTWIDTH(8)|FONTWIDTH(12)|FONTWIDTH(16)
-};
-#endif
-
-#endif /* KERNEL VERSION */
-
-
Index: linux-2.6.13-rc2-mm1/drivers/video/sis/sis_accel.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/video/sis/sis_accel.h
+++ linux-2.6.13-rc2-mm1/drivers/video/sis/sis_accel.h
@@ -390,20 +390,7 @@
int  sisfb_initaccel(struct sis_video_info *ivideo);
void sisfb_syncaccel(struct sis_video_info *ivideo);

-#if LINUX_VERSION_CODE <= KERNEL_VERSION(2,5,33)
-void fbcon_sis_bmove(struct display *p, int srcy, int srcx, int dsty,
-			int dstx, int height, int width);
-void fbcon_sis_revc(struct display *p, int srcy, int srcx);
-void fbcon_sis_clear8(struct vc_data *conp, struct display *p, int srcy,
-			int srcx, int height, int width);
-void fbcon_sis_clear16(struct vc_data *conp, struct display *p, int srcy,
-			int srcx, int height, int width);
-void fbcon_sis_clear32(struct vc_data *conp, struct display *p, int srcy,
-			int srcx, int height, int width);
-#endif
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,34)
void fbcon_sis_fillrect(struct fb_info *info, const struct fb_fillrect *rect);
void fbcon_sis_copyarea(struct fb_info *info, const struct fb_copyarea *area);
-#endif

#endif
Index: linux-2.6.13-rc2-mm1/drivers/video/sis/sis_main.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/video/sis/sis_main.c
+++ linux-2.6.13-rc2-mm1/drivers/video/sis/sis_main.c
@@ -33,11 +33,8 @@
*/

#include <linux/config.h>
-#include <linux/version.h>
#include <linux/module.h>
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
#include <linux/moduleparam.h>
-#endif
#include <linux/kernel.h>
#include <linux/smp_lock.h>
#include <linux/spinlock.h>
@@ -65,35 +62,9 @@
#include <asm/mtrr.h>
#endif

-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-#include <video/fbcon.h>
-#include <video/fbcon-cfb8.h>
-#include <video/fbcon-cfb16.h>
-#include <video/fbcon-cfb24.h>
-#include <video/fbcon-cfb32.h>
-#endif
-
#include "sis.h"
#include "sis_main.h"

-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,3)
-#error "This version of sisfb requires at least 2.6.3"
-#endif
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-#ifdef FBCON_HAS_CFB8
-extern struct display_switch fbcon_sis8;
-#endif
-#ifdef FBCON_HAS_CFB16
-extern struct display_switch fbcon_sis16;
-#endif
-#ifdef FBCON_HAS_CFB32
-extern struct display_switch fbcon_sis32;
-#endif
-#endif
-
/* ------------------ Internal helper routines ----------------- */

static void __init
@@ -106,17 +77,7 @@ sisfb_setdefaultparms(void)
sisfb_max 		= -1;
sisfb_userom    	= -1;
sisfb_useoem    	= -1;
-#ifdef MODULE
-	/* Module: "None" for 2.4, default mode for 2.5+ */
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
-	sisfb_mode_idx 		= -1;
-#else
-	sisfb_mode_idx  	= MODE_INDEX_NONE;
-#endif
-#else
-	/* Static: Default mode */
sisfb_mode_idx  	= -1;
-#endif
sisfb_parm_rate 	= -1;
sisfb_crt1off 		= 0;
sisfb_forcecrt1 	= -1;
@@ -135,10 +96,6 @@ sisfb_setdefaultparms(void)
sisfb_tvyposoffset 	= 0;
sisfb_filter 		= -1;
sisfb_nocrt2rate 	= 0;
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-	sisfb_inverse   	= 0;
-	sisfb_fontname[0] 	= 0;
-#endif
#if !defined(__i386__) && !defined(__x86_64__)
sisfb_resetcard 	= 0;
sisfb_videoram  	= 0;
@@ -153,14 +110,10 @@ sisfb_search_vesamode(unsigned int vesam
/* BEWARE: We don't know the hardware specs yet and there is no ivideo */

if(vesamode == 0) {
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-		sisfb_mode_idx = MODE_INDEX_NONE;
-#else
if(!quiet) {
printk(KERN_ERR "sisfb: Invalid mode. Using default.n");
}
sisfb_mode_idx = DEFAULT_MODE;
-#endif
return;
}

@@ -203,7 +156,6 @@ sisfb_search_mode(char *name, BOOLEAN qu
return;
}

-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
if(!strnicmp(name, sisbios_mode[MODE_INDEX_NONE].name, strlen(name))) {
if(!quiet) {
printk(KERN_ERR "sisfb: Mode 'none' not supported anymore. Using default.n");
@@ -211,7 +163,6 @@ sisfb_search_mode(char *name, BOOLEAN qu
sisfb_mode_idx = DEFAULT_MODE;
return;
}
-#endif
if(strlen(name) <= 19) {
strcpy(strbuf1, name);
for(i=0; i<strlen(strbuf1); i++) {
@@ -1129,20 +1080,7 @@ sisfb_do_set_var(struct fb_var_screeninf
ivideo->refresh_rate = 60;
}

-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-	if(ivideo->sisfb_thismonitor.datavalid) {
-	   if(!sisfb_verify_rate(ivideo, &ivideo->sisfb_thismonitor, ivideo->sisfb_mode_idx,
-	                         ivideo->rate_idx, ivideo->refresh_rate)) {
-	      printk(KERN_INFO "sisfb: WARNING: Refresh rate exceeds monitor specs!n");
-	   }
-	}
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-	if(((var->activate & FB_ACTIVATE_MASK) == FB_ACTIVATE_NOW) && isactive) {
-#else
if(isactive) {
-#endif
sisfb_pre_setmode(ivideo);

if(SiSSetMode(&ivideo->SiS_Pr, &ivideo->sishw_ext, ivideo->mode_no) == 0) {
@@ -1185,9 +1123,7 @@ sisfb_do_set_var(struct fb_var_screeninf
ivideo->current_linelength = ivideo->video_linelength;
ivideo->current_pixclock = var->pixclock;
ivideo->current_refresh_rate = ivideo->refresh_rate;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
ivideo->sisfb_lastrates[ivideo->mode_no] = ivideo->refresh_rate;
-#endif
}

return 0;
@@ -1240,524 +1176,6 @@ sisfb_pan_var(struct sis_video_info *ivi
return 0;
}

-/* ------------ FBDev related routines for 2.4 series ----------- */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-
-static void
-sisfb_crtc_to_var(struct sis_video_info *ivideo, struct fb_var_screeninfo *var)
-{
-	u16 VRE, VBE, VRS, VBS, VDE, VT;
-	u16 HRE, HBE, HRS, HBS, HDE, HT;
-	u8  sr_data, cr_data, cr_data2, cr_data3, mr_data;
-	int A, B, C, D, E, F, temp;
-	unsigned int hrate, drate, maxyres;
-
-	inSISIDXREG(SISSR, IND_SIS_COLOR_MODE, sr_data);
-
-	if(sr_data & SIS_INTERLACED_MODE)
-	   var->vmode = FB_VMODE_INTERLACED;
-	else
-	   var->vmode = FB_VMODE_NONINTERLACED;
-
-	switch((sr_data & 0x1C) >> 2) {
-	case SIS_8BPP_COLOR_MODE:
-		var->bits_per_pixel = 8;
-		break;
-	case SIS_16BPP_COLOR_MODE:
-		var->bits_per_pixel = 16;
-		break;
-	case SIS_32BPP_COLOR_MODE:
-		var->bits_per_pixel = 32;
-		break;
-	}
-
-	sisfb_bpp_to_var(ivideo, var);
-
-	inSISIDXREG(SISSR, 0x0A, sr_data);
-        inSISIDXREG(SISCR, 0x06, cr_data);
-        inSISIDXREG(SISCR, 0x07, cr_data2);
-
-	VT = (cr_data & 0xFF) |
-	     ((u16) (cr_data2 & 0x01) << 8) |
-	     ((u16) (cr_data2 & 0x20) << 4) |
-	     ((u16) (sr_data  & 0x01) << 10);
-	A = VT + 2;
-
-	inSISIDXREG(SISCR, 0x12, cr_data);
-
-	VDE = (cr_data & 0xff) |
-	      ((u16) (cr_data2 & 0x02) << 7) |
-	      ((u16) (cr_data2 & 0x40) << 3) |
-	      ((u16) (sr_data  & 0x02) << 9);
-	E = VDE + 1;
-
-	inSISIDXREG(SISCR, 0x10, cr_data);
-
-	VRS = (cr_data & 0xff) |
-	      ((u16) (cr_data2 & 0x04) << 6) |
-	      ((u16) (cr_data2 & 0x80) << 2) |
-	      ((u16) (sr_data  & 0x08) << 7);
-	F = VRS + 1 - E;
-
-	inSISIDXREG(SISCR, 0x15, cr_data);
-	inSISIDXREG(SISCR, 0x09, cr_data3);
-
-	if(cr_data3 & 0x80) var->vmode = FB_VMODE_DOUBLE;
-
-	VBS = (cr_data & 0xff) |
-	      ((u16) (cr_data2 & 0x08) << 5) |
-	      ((u16) (cr_data3 & 0x20) << 4) |
-	      ((u16) (sr_data & 0x04) << 8);
-
-	inSISIDXREG(SISCR, 0x16, cr_data);
-
-	VBE = (cr_data & 0xff) | ((u16) (sr_data & 0x10) << 4);
-	temp = VBE - ((E - 1) & 511);
-	B = (temp > 0) ? temp : (temp + 512);
-
-	inSISIDXREG(SISCR, 0x11, cr_data);
-
-	VRE = (cr_data & 0x0f) | ((sr_data & 0x20) >> 1);
-	temp = VRE - ((E + F - 1) & 31);
-	C = (temp > 0) ? temp : (temp + 32);
-
-	D = B - F - C;
-
-        var->yres = E;
-	var->upper_margin = D;
-	var->lower_margin = F;
-	var->vsync_len = C;
-
-	if((var->vmode & FB_VMODE_MASK) == FB_VMODE_INTERLACED) {
-	   var->yres <<= 1;
-	   var->upper_margin <<= 1;
-	   var->lower_margin <<= 1;
-	   var->vsync_len <<= 1;
-	} else if((var->vmode & FB_VMODE_MASK) == FB_VMODE_DOUBLE) {
-	   var->yres >>= 1;
-	   var->upper_margin >>= 1;
-	   var->lower_margin >>= 1;
-	   var->vsync_len >>= 1;
-	}
-
-	inSISIDXREG(SISSR, 0x0b, sr_data);
-	inSISIDXREG(SISCR, 0x00, cr_data);
-
-	HT = (cr_data & 0xff) | ((u16) (sr_data & 0x03) << 8);
-	A = HT + 5;
-
-	inSISIDXREG(SISCR, 0x01, cr_data);
-
-	HDE = (cr_data & 0xff) | ((u16) (sr_data & 0x0C) << 6);
-	E = HDE + 1;
-
-	inSISIDXREG(SISCR, 0x04, cr_data);
-
-	HRS = (cr_data & 0xff) | ((u16) (sr_data & 0xC0) << 2);
-	F = HRS - E - 3;
-
-	inSISIDXREG(SISCR, 0x02, cr_data);
-
-	HBS = (cr_data & 0xff) | ((u16) (sr_data & 0x30) << 4);
-
-	inSISIDXREG(SISSR, 0x0c, sr_data);
-	inSISIDXREG(SISCR, 0x03, cr_data);
-	inSISIDXREG(SISCR, 0x05, cr_data2);
-
-	HBE = (cr_data & 0x1f) |
-	      ((u16) (cr_data2 & 0x80) >> 2) |
-	      ((u16) (sr_data  & 0x03) << 6);
-	HRE = (cr_data2 & 0x1f) | ((sr_data & 0x04) << 3);
-
-	temp = HBE - ((E - 1) & 255);
-	B = (temp > 0) ? temp : (temp + 256);
-
-	temp = HRE - ((E + F + 3) & 63);
-	C = (temp > 0) ? temp : (temp + 64);
-
-	D = B - F - C;
-
-	var->xres = E * 8;
-	if(var->xres_virtual < var->xres) {
-		var->xres_virtual = var->xres;
-	}
-
-	if((var->xres == 320) &&
-	   (var->yres == 200 || var->yres == 240)) {
-		/* Terrible hack, but the correct CRTC data for
-	  	 * these modes only produces a black screen...
-	  	 */
-       		var->left_margin = (400 - 376);
-       		var->right_margin = (328 - 320);
-       		var->hsync_len = (376 - 328);
-	} else {
-	   	var->left_margin = D * 8;
-	   	var->right_margin = F * 8;
-	   	var->hsync_len = C * 8;
-	}
-	var->activate = FB_ACTIVATE_NOW;
-
-	var->sync = 0;
-
-	mr_data = inSISREG(SISMISCR);
-	if(mr_data & 0x80)
-	   var->sync &= ~FB_SYNC_VERT_HIGH_ACT;
-	else
-	   var->sync |= FB_SYNC_VERT_HIGH_ACT;
-
-	if(mr_data & 0x40)
-	   var->sync &= ~FB_SYNC_HOR_HIGH_ACT;
-	else
-	   var->sync |= FB_SYNC_HOR_HIGH_ACT;
-
-	VT += 2;
-	VT <<= 1;
-	HT = (HT + 5) * 8;
-
-	if((var->vmode & FB_VMODE_MASK) == FB_VMODE_INTERLACED) {
-	   VT <<= 1;
-	}
-	hrate = ivideo->refresh_rate * VT / 2;
-	drate = (hrate * HT) / 1000;
-	var->pixclock = (u32) (1000000000 / drate);
-
-	if(ivideo->sisfb_ypan) {
-	   maxyres = sisfb_calc_maxyres(ivideo, var);
-	   if(ivideo->sisfb_max) {
-	      var->yres_virtual = maxyres;
-	   } else {
-	      if(var->yres_virtual > maxyres) {
-	         var->yres_virtual = maxyres;
-	      }
-	   }
-	   if(var->yres_virtual <= var->yres) {
-	      var->yres_virtual = var->yres;
-	   }
-	} else {
-	   var->yres_virtual = var->yres;
-	}
-
-}
-
-static int
-sis_getcolreg(unsigned regno, unsigned *red, unsigned *green, unsigned *blue,
-			 unsigned *transp, struct fb_info *info)
-{
-	struct sis_video_info *ivideo = (struct sis_video_info *)info->par;
-
-	if(regno >= ivideo->video_cmap_len) return 1;
-
-	*red   = ivideo->sis_palette[regno].red;
-	*green = ivideo->sis_palette[regno].green;
-	*blue  = ivideo->sis_palette[regno].blue;
-	*transp = 0;
-
-	return 0;
-}
-
-static int
-sisfb_setcolreg(unsigned regno, unsigned red, unsigned green, unsigned blue,
-                           unsigned transp, struct fb_info *info)
-{
-	struct sis_video_info *ivideo = (struct sis_video_info *)info->par;
-
-	if(regno >= ivideo->video_cmap_len) return 1;
-
-	ivideo->sis_palette[regno].red   = red;
-	ivideo->sis_palette[regno].green = green;
-	ivideo->sis_palette[regno].blue  = blue;
-
-	switch(ivideo->video_bpp) {
-#ifdef FBCON_HAS_CFB8
-	case 8:
-	        outSISREG(SISDACA, regno);
-		outSISREG(SISDACD, (red >> 10));
-		outSISREG(SISDACD, (green >> 10));
-		outSISREG(SISDACD, (blue >> 10));
-		if(ivideo->currentvbflags & VB_DISPTYPE_DISP2) {
-		        outSISREG(SISDAC2A, regno);
-			outSISREG(SISDAC2D, (red >> 8));
-			outSISREG(SISDAC2D, (green >> 8));
-			outSISREG(SISDAC2D, (blue >> 8));
-		}
-		break;
-#endif
-#ifdef FBCON_HAS_CFB16
-	case 16:
-		ivideo->sis_fbcon_cmap.cfb16[regno] =
-		    ((red & 0xf800)) | ((green & 0xfc00) >> 5) | ((blue & 0xf800) >> 11);
-		break;
-#endif
-#ifdef FBCON_HAS_CFB32
-	case 32:
-		red   >>= 8;
-		green >>= 8;
-		blue  >>= 8;
-		ivideo->sis_fbcon_cmap.cfb32[regno] = (red << 16) | (green << 8) | (blue);
-		break;
-#endif
-	}
-
-	return 0;
-}
-
-static void
-sisfb_set_disp(int con, struct fb_var_screeninfo *var, struct fb_info *info)
-{
-	struct sis_video_info    *ivideo = (struct sis_video_info *)info->par;
-	struct display           *display;
-	struct display_switch    *sw;
-	struct fb_fix_screeninfo fix;
-	long   flags;
-
-	display = (con >= 0) ? &fb_display[con] : &ivideo->sis_disp;
-
-	sisfb_get_fix(&fix, con, info);
-
-	display->var = *var;
-	display->screen_base = (char *)ivideo->video_vbase;
-	display->visual = fix.visual;
-	display->type = fix.type;
-	display->type_aux = fix.type_aux;
-	display->ypanstep = fix.ypanstep;
-	display->ywrapstep = fix.ywrapstep;
-	display->line_length = fix.line_length;
-	display->can_soft_blank = 1;
-	display->inverse = ivideo->sisfb_inverse;
-	display->next_line = fix.line_length;
-
-	save_flags(flags);
-
-	switch(ivideo->video_bpp) {
-#ifdef FBCON_HAS_CFB8
-	case 8:	sw = ivideo->accel ? &fbcon_sis8 : &fbcon_cfb8;
-		break;
-#endif
-#ifdef FBCON_HAS_CFB16
-	case 16:sw = ivideo->accel ? &fbcon_sis16 : &fbcon_cfb16;
-		display->dispsw_data = &ivideo->sis_fbcon_cmap.cfb16;
-		break;
-#endif
-#ifdef FBCON_HAS_CFB32
-	case 32:sw = ivideo->accel ? &fbcon_sis32 : &fbcon_cfb32;
-		display->dispsw_data = &ivideo->sis_fbcon_cmap.cfb32;
-		break;
-#endif
-	default:sw = &fbcon_dummy;
-		break;
-	}
-	memcpy(&ivideo->sisfb_sw, sw, sizeof(*sw));
-	display->dispsw = &ivideo->sisfb_sw;
-
-	restore_flags(flags);
-
-        if(ivideo->sisfb_ypan) {
-  	    /* display->scrollmode = 0;  */
-	} else {
-	    display->scrollmode = SCROLL_YREDRAW;
-	    ivideo->sisfb_sw.bmove = fbcon_redraw_bmove;
-	}
-}
-
-static void
-sisfb_do_install_cmap(int con, struct fb_info *info)
-{
-	struct sis_video_info *ivideo = (struct sis_video_info *)info->par;
-
-        if(con != ivideo->currcon) return;
-
-        if(fb_display[con].cmap.len) {
-		fb_set_cmap(&fb_display[con].cmap, 1, sisfb_setcolreg, info);
-        } else {
-		int size = sisfb_get_cmap_len(&fb_display[con].var);
-		fb_set_cmap(fb_default_cmap(size), 1, sisfb_setcolreg, info);
-	}
-}
-
-static int
-sisfb_get_var(struct fb_var_screeninfo *var, int con, struct fb_info *info)
-{
-	struct sis_video_info *ivideo = (struct sis_video_info *)info->par;
-
-	if(con == -1) {
-		memcpy(var, &ivideo->default_var, sizeof(struct fb_var_screeninfo));
-	} else {
-		*var = fb_display[con].var;
-	}
-
-	if(ivideo->sisfb_fstn) {
-	   	if(var->xres == 320 && var->yres == 480) var->yres = 240;
-        }
-
-	return 0;
-}
-
-static int
-sisfb_set_var(struct fb_var_screeninfo *var, int con, struct fb_info *info)
-{
-	struct sis_video_info *ivideo = (struct sis_video_info *)info->par;
-	int err;
-
-	fb_display[con].var.activate = FB_ACTIVATE_NOW;
-
-        if(sisfb_do_set_var(var, con == ivideo->currcon, info)) {
-		sisfb_crtc_to_var(ivideo, var);
-		return -EINVAL;
-	}
-
-	sisfb_crtc_to_var(ivideo, var);
-
-	sisfb_set_disp(con, var, info);
-
-	if(info->changevar) {
-		(*info->changevar)(con);
-	}
-
-	if((err = fb_alloc_cmap(&fb_display[con].cmap, 0, 0))) {
-		return err;
-	}
-
-	sisfb_do_install_cmap(con, info);
-
-#if 0	/* Why was this called here? */
-	unsigned int cols, rows;
-	cols = sisbios_mode[ivideo->sisfb_mode_idx].cols;
-	rows = sisbios_mode[ivideo->sisfb_mode_idx].rows;
- 	vc_resize_con(rows, cols, fb_display[con].conp->vc_num);
-#endif
-	return 0;
-}
-
-static int
-sisfb_get_cmap(struct fb_cmap *cmap, int kspc, int con, struct fb_info *info)
-{
-	struct sis_video_info *ivideo = (struct sis_video_info *)info->par;
-	struct display *display;
-
-	display = (con >= 0) ? &fb_display[con] : &ivideo->sis_disp;
-
-        if(con == ivideo->currcon) {
-
-		return fb_get_cmap(cmap, kspc, sis_getcolreg, info);
-
-	} else if(display->cmap.len) {
-
-		fb_copy_cmap(&display->cmap, cmap, kspc ? 0 : 2);
-
-	} else {
-
-		int size = sisfb_get_cmap_len(&display->var);
-		fb_copy_cmap(fb_default_cmap(size), cmap, kspc ? 0 : 2);
-
-	}
-
-	return 0;
-}
-
-static int
-sisfb_set_cmap(struct fb_cmap *cmap, int kspc, int con, struct fb_info *info)
-{
-	struct sis_video_info *ivideo = (struct sis_video_info *)info->par;
-	struct display *display;
-	int err, size;
-
-	display = (con >= 0) ? &fb_display[con] : &ivideo->sis_disp;
-
-	size = sisfb_get_cmap_len(&display->var);
-	if(display->cmap.len != size) {
-		err = fb_alloc_cmap(&display->cmap, size, 0);
-		if(err)	return err;
-	}
-
-	if(con == ivideo->currcon) {
-		return fb_set_cmap(cmap, kspc, sisfb_setcolreg, info);
-	} else {
-		fb_copy_cmap(cmap, &display->cmap, kspc ? 0 : 1);
-	}
-
-	return 0;
-}
-
-static int
-sisfb_pan_display(struct fb_var_screeninfo *var, int con, struct fb_info* info)
-{
-	struct sis_video_info *ivideo = (struct sis_video_info *)info->par;
-	int err;
-
-	if(var->vmode & FB_VMODE_YWRAP) return -EINVAL;
-
-	if((var->xoffset+fb_display[con].var.xres > fb_display[con].var.xres_virtual) ||
-	   (var->yoffset+fb_display[con].var.yres > fb_display[con].var.yres_virtual)) {
-		return -EINVAL;
-	}
-
-        if(con == ivideo->currcon) {
-	   	if((err = sisfb_pan_var(ivideo, var)) < 0) return err;
-	}
-
-	fb_display[con].var.xoffset = var->xoffset;
-	fb_display[con].var.yoffset = var->yoffset;
-
-	return 0;
-}
-
-static int
-sisfb_update_var(int con, struct fb_info *info)
-{
-	struct sis_video_info *ivideo = (struct sis_video_info *)info->par;
-
-        return(sisfb_pan_var(ivideo, &fb_display[con].var));
-}
-
-static int
-sisfb_switch(int con, struct fb_info *info)
-{
-	struct sis_video_info *ivideo = (struct sis_video_info *)info->par;
-	int cols, rows;
-
-        if(fb_display[ivideo->currcon].cmap.len) {
-		fb_get_cmap(&fb_display[ivideo->currcon].cmap, 1, sis_getcolreg, info);
-	}
-
-	fb_display[con].var.activate = FB_ACTIVATE_NOW;
-
-	if(!memcmp(&fb_display[con].var, &fb_display[ivideo->currcon].var,
-	                           	sizeof(struct fb_var_screeninfo))) {
-		ivideo->currcon = con;
-		return 1;
-	}
-
-	ivideo->currcon = con;
-
-	sisfb_do_set_var(&fb_display[con].var, 1, info);
-
-	sisfb_set_disp(con, &fb_display[con].var, info);
-
-	sisfb_do_install_cmap(con, info);
-
-	cols = sisbios_mode[ivideo->sisfb_mode_idx].cols;
-	rows = sisbios_mode[ivideo->sisfb_mode_idx].rows;
-	vc_resize_con(rows, cols, fb_display[con].conp->vc_num);
-
-	sisfb_update_var(con, info);
-
-	return 1;
-}
-
-static void
-sisfb_blank(int blank, struct fb_info *info)
-{
-	struct sis_video_info *ivideo = (struct sis_video_info *)info->par;
-
-	sisfb_myblank(ivideo, blank);
-}
-#endif
-
-/* ------------ FBDev related routines for 2.6 series ----------- */
-
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
-
static int
sisfb_open(struct fb_info *info, int user)
{
@@ -1814,11 +1232,7 @@ sisfb_set_par(struct fb_info *info)
if((err = sisfb_do_set_var(&info->var, 1, info))) {
return err;
}
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,10)
-	sisfb_get_fix(&info->fix, info->currcon, info);
-#else
sisfb_get_fix(&info->fix, -1, info);
-#endif
return 0;
}

@@ -2043,16 +1457,11 @@ sisfb_blank(int blank, struct fb_info *i
return(sisfb_myblank(ivideo, blank));
}

-#endif
-
/* ----------- FBDev related routines for all series ---------- */

static int
sisfb_ioctl(struct inode *inode, struct file *file,
unsigned int cmd, unsigned long arg,
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-	    int con,
-#endif
struct fb_info *info)
{
struct sis_video_info	*ivideo = (struct sis_video_info *)info->par;
@@ -2060,9 +1469,6 @@ sisfb_ioctl(struct inode *inode, struct
struct fb_vblank  	sisvbblank;
sisfb_info        	x;
u32			gpu32 = 0;
-#ifndef __user
-#define __user
-#endif
u32 __user 		*argp = (u32 __user *)arg;

switch (cmd) {
@@ -2243,20 +1649,6 @@ sisfb_get_fix(struct fb_fix_screeninfo *

/* ----------------  fb_ops structures ----------------- */

-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-static struct fb_ops sisfb_ops = {
-	.owner		= THIS_MODULE,
-	.fb_get_fix	= sisfb_get_fix,
-	.fb_get_var	= sisfb_get_var,
-	.fb_set_var	= sisfb_set_var,
-	.fb_get_cmap	= sisfb_get_cmap,
-	.fb_set_cmap	= sisfb_set_cmap,
-        .fb_pan_display = sisfb_pan_display,
-	.fb_ioctl	= sisfb_ioctl
-};
-#endif
-
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
static struct fb_ops sisfb_ops = {
.owner          = THIS_MODULE,
.fb_open        = sisfb_open,
@@ -2276,7 +1668,6 @@ static struct fb_ops sisfb_ops = {
.fb_compat_ioctl = sisfb_compat_ioctl,
#endif
};
-#endif

/* ---------------- Chip generation dependent routines ---------------- */

@@ -3887,16 +3278,6 @@ SISINITSTATIC int __init sisfb_setup(cha
sisfb_search_mode(this_opt + 5, FALSE);
} else if(!strnicmp(this_opt, "vesa:", 5)) {
sisfb_search_vesamode(simple_strtoul(this_opt + 5, NULL, 0), FALSE);
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-		} else if(!strnicmp(this_opt, "inverse", 7)) {
-			sisfb_inverse = 1;
-			/* fb_invert_cmaps(); */
-		} else if(!strnicmp(this_opt, "font:", 5)) {
-		        if(strlen(this_opt + 5) < 40) {
-			   strncpy(sisfb_fontname, this_opt + 5, sizeof(sisfb_fontname) - 1);
-			   sisfb_fontname[sizeof(sisfb_fontname) - 1] = '0';
-			}
-#endif
} else if(!strnicmp(this_opt, "rate:", 5)) {
sisfb_parm_rate = simple_strtoul(this_opt + 5, NULL, 0);
} else if(!strnicmp(this_opt, "filter:", 7)) {
@@ -4744,7 +4125,7 @@ static void __devinit sisfb_post_sis3153
iounmap(ivideo->video_vbase);
} else {
printk(KERN_DEBUG "sisfb: Failed to map memory for size detection, assuming 8MBn");
-	   outSISIDXREG(SISSR,0x14,0x??);  /* 8MB, 64bit default */
+	   outSISIDXREG(SISSR,0x14,0x00);  /* 8MB, 64bit default */
}

/* AGP (Missing: Checks for VIA and AMD hosts) */
@@ -4774,15 +4155,8 @@ static int __devinit sisfb_probe(struct

if(sisfb_off) return -ENXIO;

-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,3))
sis_fb_info = framebuffer_alloc(sizeof(*ivideo), &pdev->dev);
if(!sis_fb_info) return -ENOMEM;
-#else
-	sis_fb_info = kmalloc(sizeof(*sis_fb_info) + sizeof(*ivideo), GFP_KERNEL);
-	if(!sis_fb_info) return -ENOMEM;
-	memset(sis_fb_info, 0, sizeof(*sis_fb_info) + sizeof(*ivideo));
-	sis_fb_info->par = ((char *)sis_fb_info + sizeof(*sis_fb_info));
-#endif

ivideo = (struct sis_video_info *)sis_fb_info->par;
ivideo->memyselfandi = sis_fb_info;
@@ -4848,9 +4222,6 @@ static int __devinit sisfb_probe(struct
ivideo->tvypos = sisfb_tvyposoffset;
ivideo->sisfb_filter = sisfb_filter;
ivideo->sisfb_nocrt2rate = sisfb_nocrt2rate;
-#if LINUX_VERSION_CODE <= KERNEL_VERSION(2,5,0)
-	ivideo->sisfb_inverse = sisfb_inverse;
-#endif

ivideo->refresh_rate = 0;
if(ivideo->sisfb_parm_rate != -1) {
@@ -4920,10 +4291,6 @@ static int __devinit sisfb_probe(struct
}
}

-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-	strcpy(sis_fb_info->modename, ivideo->myid);
-#endif
-
ivideo->sishw_ext.jChipType = ivideo->chip;

#ifdef CONFIG_FB_SIS_315
@@ -4993,19 +4360,6 @@ static int __devinit sisfb_probe(struct
#endif
}

-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-#ifdef MODULE
-	if((reg & 0x80) && (reg != 0xff)) {
-	   if((sisbios_mode[ivideo->sisfb_mode_idx].mode_no[ivideo->mni]) != 0xFF) {
-	      printk(KERN_INFO "sisfb: Cannot initialize display mode, X server is activen");
-	      pci_set_drvdata(pdev, NULL);
-	      kfree(sis_fb_info);
-	      return -EBUSY;
-	   }
-	}
-#endif
-#endif
-
ivideo->sishw_ext.bIntegratedMMEnabled = TRUE;
#ifdef CONFIG_FB_SIS_300
if(ivideo->sisvga_engine == SIS_300_VGA) {
@@ -5455,65 +4809,6 @@ static int __devinit sisfb_probe(struct

sisfb_set_vparms(ivideo);

-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-
-		/* ---------------- For 2.4: Now switch the mode ------------------ */
-
-		printk(KERN_INFO "sisfb: Mode is %dx%dx%d (%dHz)n",
-	       		ivideo->video_width, ivideo->video_height, ivideo->video_bpp,
-			ivideo->refresh_rate);
-
-		sisfb_pre_setmode(ivideo);
-
-		if(SiSSetMode(&ivideo->SiS_Pr, &ivideo->sishw_ext, ivideo->mode_no) == 0) {
-			printk(KERN_ERR "sisfb: Fatal error: Setting mode[0x%x] failedn",
-									ivideo->mode_no);
-			iounmap(ivideo->video_vbase);
-			iounmap(ivideo->mmio_vbase);
-			release_mem_region(ivideo->video_base, ivideo->video_size);
-			release_mem_region(ivideo->mmio_base, ivideo->mmio_size);
-			if(ivideo->bios_abase) vfree(ivideo->bios_abase);
-			pci_set_drvdata(pdev, NULL);
-			kfree(sis_fb_info);
-			return -EINVAL;
-		}
-
-		outSISIDXREG(SISSR, IND_SIS_PASSWORD, SIS_PASSWORD);
-
-		sisfb_post_setmode(ivideo);
-
-		/* Maximize regardless of sisfb_max at startup */
-		ivideo->default_var.yres_virtual = 32767;
-
-		/* Force reset of x virtual in crtc_to_var */
-		ivideo->default_var.xres_virtual = 0;
-
-		sisfb_crtc_to_var(ivideo, &ivideo->default_var);
-
-		sisfb_calc_pitch(ivideo, &ivideo->default_var);
-		sisfb_set_pitch(ivideo);
-
-		ivideo->accel = 0;
-		if(ivideo->sisfb_accel) {
-		   ivideo->accel = -1;
-		   ivideo->default_var.accel_flags |= FB_ACCELF_TEXT;
-		}
-		sisfb_initaccel(ivideo);
-
-		sis_fb_info->node  = -1;
-		sis_fb_info->flags = FBINFO_FLAG_DEFAULT;
-		sis_fb_info->fbops = &sisfb_ops;
-		sis_fb_info->disp  = &ivideo->sis_disp;
-		sis_fb_info->blank = &sisfb_blank;
-		sis_fb_info->switch_con = &sisfb_switch;
-		sis_fb_info->updatevar  = &sisfb_update_var;
-		sis_fb_info->changevar  = NULL;
-		strcpy(sis_fb_info->fontname, sisfb_fontname);
-
-		sisfb_set_disp(-1, &ivideo->default_var, sis_fb_info);
-
-#else		/* --------- For 2.6: Setup a somewhat sane default var ------------ */
-
printk(KERN_INFO "sisfb: Default mode is %dx%dx%d (%dHz)n",
ivideo->video_width, ivideo->video_height, ivideo->video_bpp,
ivideo->refresh_rate);
@@ -5573,7 +4868,6 @@ static int __devinit sisfb_probe(struct
sis_fb_info->pseudo_palette = ivideo->pseudo_palette;

fb_alloc_cmap(&sis_fb_info->cmap, 256 , 0);
-#endif		/* 2.6 */

printk(KERN_DEBUG "sisfb: Initial vbflags 0x%lxn", (unsigned long)ivideo->vbflags);

@@ -5585,10 +4879,6 @@ static int __devinit sisfb_probe(struct
}
#endif

-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-		vc_resize_con(1, 1, 0);
-#endif
-
if(register_framebuffer(sis_fb_info) < 0) {
printk(KERN_ERR "sisfb: Fatal error: Failed to register framebuffern");
iounmap(ivideo->video_vbase);
@@ -5614,11 +4904,7 @@ static int __devinit sisfb_probe(struct


printk(KERN_INFO "fb%d: %s frame buffer device, Version %d.%d.%dn",
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-	       		GET_FB_IDX(sis_fb_info->node),
-#else
sis_fb_info->node,
-#endif
ivideo->myid, VER_MAJOR, VER_MINOR, VER_LEVEL);

printk(KERN_INFO "sisfb: (C) 2001-2004 Thomas Winischhofer.n");
@@ -5657,11 +4943,7 @@ static void __devexit sisfb_remove(struc
/* Unregister the framebuffer */
if(ivideo->registered) {
unregister_framebuffer(sis_fb_info);
-#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,3))
framebuffer_release(sis_fb_info);
-#else
-		kfree(sis_fb_info);
-#endif
}

pci_set_drvdata(pdev, NULL);
@@ -5687,7 +4969,6 @@ static struct pci_driver sisfb_driver =

SISINITSTATIC int __init sisfb_init(void)
{
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,8)
#ifndef MODULE
char *options = NULL;

@@ -5695,15 +4976,12 @@ SISINITSTATIC int __init sisfb_init(void
return -ENODEV;
sisfb_setup(options);
#endif
-#endif
return(pci_register_driver(&sisfb_driver));
}

-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,8)
#ifndef MODULE
module_init(sisfb_init);
#endif
-#endif

/*****************************************************/
/*                      MODULE                       */
@@ -5723,9 +5001,6 @@ static int          pdc1 = -1;
static int          noaccel = -1;
static int          noypan  = -1;
static int	    nomax = -1;
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-static int          inverse = 0;
-#endif
static int          userom = -1;
static int          useoem = -1;
static char         *tvstandard = NULL;
@@ -5744,36 +5019,7 @@ MODULE_DESCRIPTION("SiS 300/540/630/730/
MODULE_LICENSE("GPL");
MODULE_AUTHOR("Thomas Winischhofer <thomas@winischhofer.net>, Others");

-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-MODULE_PARM(mem, "i");
-MODULE_PARM(noaccel, "i");
-MODULE_PARM(noypan, "i");
-MODULE_PARM(nomax, "i");
-MODULE_PARM(userom, "i");
-MODULE_PARM(useoem, "i");
-MODULE_PARM(mode, "s");
-MODULE_PARM(vesa, "i");
-MODULE_PARM(rate, "i");
-MODULE_PARM(forcecrt1, "i");
-MODULE_PARM(forcecrt2type, "s");
-MODULE_PARM(scalelcd, "i");
-MODULE_PARM(pdc, "i");
-MODULE_PARM(pdc1, "i");
-MODULE_PARM(specialtiming, "s");
-MODULE_PARM(lvdshl, "i");
-MODULE_PARM(tvstandard, "s");
-MODULE_PARM(tvxposoffset, "i");
-MODULE_PARM(tvyposoffset, "i");
-MODULE_PARM(filter, "i");
-MODULE_PARM(nocrt2rate, "i");
-MODULE_PARM(inverse, "i");
-#if !defined(__i386__) && !defined(__x86_64__)
-MODULE_PARM(resetcard, "i");
-MODULE_PARM(videoram, "i");
-#endif
-#endif

-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
module_param(mem, int, 0);
module_param(noaccel, int, 0);
module_param(noypan, int, 0);
@@ -5799,7 +5045,6 @@ module_param(nocrt2rate, int, 0);
module_param(resetcard, int, 0);
module_param(videoram, int, 0);
#endif
-#endif

MODULE_PARM_DESC(mem,
"nDetermines the beginning of the video memory heap in KB. This heap is usedn"
@@ -5825,23 +5070,7 @@ MODULE_PARM_DESC(nomax,
"enable the user to positively specify a virtual Y size of the screen usingn"
"fbset. (default: 0)n");

-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-MODULE_PARM_DESC(mode,
-        "nSelects the desired display mode in the format [X]x[Y]x[Depth], eg.n"
-          "1024x768x16. Other formats supported include XxY-Depth andn"
- 	  "XxY-Depth@Rate. If the parameter is only one (decimal or hexadecimal)n"
-	  "number, it will be interpreted as a VESA mode number. (default: none ifn"
-	  "sisfb is a module; this leaves the console untouched and the driver willn"
-	  "only do the video memory management for eg. DRM/DRI; 800x600x8 if sisfbn"
-	  "is in the kernel)n");
-MODULE_PARM_DESC(vesa,
-        "nSelects the desired display mode by VESA defined mode number, eg. 0x117n"
-          "(default: 0x0000 if sisfb is a module; this leaves the console untouchedn"
-	  "and the driver will only do the video memory management for eg. DRM/DRI;n"
-	  "0x0103 if sisfb is in the kernel)n");
-#endif

-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
MODULE_PARM_DESC(mode,
"nSelects the desired default display mode in the format XxYxDepth,n"
"eg. 1024x768x16. Other formats supported include XxY-Depth andn"
@@ -5851,7 +5080,6 @@ MODULE_PARM_DESC(mode,
MODULE_PARM_DESC(vesa,
"nSelects the desired default display mode by VESA defined mode number, eg.n"
"0x117 (default: 0x0103)n");
-#endif

MODULE_PARM_DESC(rate,
"nSelects the desired vertical refresh rate for CRT1 (external VGA) in Hz.n"
@@ -5921,12 +5149,6 @@ MODULE_PARM_DESC(nocrt2rate,
"nSetting this to 1 will force the driver to use the default refresh rate forn"
"CRT2 if CRT2 type is VGA. (default: 0, use same rate as CRT1)n");

-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-MODULE_PARM_DESC(inverse,
-        "nSetting this to anything but 0 should invert the display colors, but thisn"
-	  "does not seem to work. (default: 0)n");
-#endif
-
#if !defined(__i386__) && !defined(__x86_64__)
#ifdef CONFIG_FB_SIS_300
MODULE_PARM_DESC(resetcard,
@@ -5979,10 +5201,6 @@ static int __devinit sisfb_init_module(v
if(nomax == 1)        sisfb_max = 0;
else if(nomax == 0)   sisfb_max = 1;

-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-	if(inverse)           sisfb_inverse = 1;
-#endif
-
if(mem)		      sisfb_parm_mem = mem;

if(userom != -1)      sisfb_userom = userom;
Index: linux-2.6.13-rc2-mm1/drivers/video/sis/sis_main.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/video/sis/sis_main.h
+++ linux-2.6.13-rc2-mm1/drivers/video/sis/sis_main.h
@@ -68,15 +68,7 @@ static int sisfb_ypan = -1;
static int sisfb_max = -1;
static int sisfb_userom = 1;
static int sisfb_useoem = -1;
-#ifdef MODULE
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
-static int sisfb_mode_idx = -1;
-#else
-static int sisfb_mode_idx = MODE_INDEX_NONE;  /* Don't use a mode by default if we are a module */
-#endif
-#else
static int sisfb_mode_idx = -1;               /* Use a default mode if we are inside the kernel */
-#endif
static int sisfb_parm_rate = -1;
static int sisfb_crt1off = 0;
static int sisfb_forcecrt1 = -1;
@@ -95,10 +87,6 @@ static int sisfb_tvxposoffset = 0;
static int sisfb_tvyposoffset = 0;
static int sisfb_filter = -1;
static int sisfb_nocrt2rate = 0;
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-static int  sisfb_inverse = 0;
-static char sisfb_fontname[40];
-#endif
#if !defined(__i386__) && !defined(__x86_64__)
static int sisfb_resetcard = 0;
static int sisfb_videoram = 0;
@@ -816,46 +804,6 @@ SISINITSTATIC int sisfb_init(void);
static int      sisfb_get_fix(struct fb_fix_screeninfo *fix, int con,
struct fb_info *info);

-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-static int      sisfb_get_fix(struct fb_fix_screeninfo *fix,
-			      int con,
-			      struct fb_info *info);
-static int      sisfb_get_var(struct fb_var_screeninfo *var,
-			      int con,
-			      struct fb_info *info);
-static int      sisfb_set_var(struct fb_var_screeninfo *var,
-			      int con,
-			      struct fb_info *info);
-static void     sisfb_crtc_to_var(struct sis_video_info *ivideo,
-			          struct fb_var_screeninfo *var);
-static int      sisfb_get_cmap(struct fb_cmap *cmap,
-			       int kspc,
-			       int con,
-			       struct fb_info *info);
-static int      sisfb_set_cmap(struct fb_cmap *cmap,
-			       int kspc,
-			       int con,
-			       struct fb_info *info);
-static int      sisfb_update_var(int con,
-				 struct fb_info *info);
-static int      sisfb_switch(int con,
-			     struct fb_info *info);
-static void     sisfb_blank(int blank,
-			    struct fb_info *info);
-static void     sisfb_set_disp(int con,
-			       struct fb_var_screeninfo *var,
-                               struct fb_info *info);
-static int      sis_getcolreg(unsigned regno, unsigned *red, unsigned *green,
-			      unsigned *blue, unsigned *transp,
-			      struct fb_info *fb_info);
-static void     sisfb_do_install_cmap(int con,
-                                      struct fb_info *info);
-static int      sisfb_ioctl(struct inode *inode, struct file *file,
-		       	    unsigned int cmd, unsigned long arg, int con,
-		       	    struct fb_info *info);
-#endif
-
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
static int      sisfb_ioctl(struct inode *inode, struct file *file,
unsigned int cmd, unsigned long arg,
struct fb_info *info);
@@ -867,7 +815,6 @@ extern void     fbcon_sis_fillrect(struc
extern void     fbcon_sis_copyarea(struct fb_info *info,
const struct fb_copyarea *area);
extern int      fbcon_sis_sync(struct fb_info *info);
-#endif

/* Internal 2D accelerator functions */
extern int      sisfb_initaccel(struct sis_video_info *ivideo);
@@ -926,14 +873,12 @@ extern BOOLEAN  SiSDetermineROMLayout661

extern BOOLEAN  sisfb_gettotalfrommode(SiS_Private *SiS_Pr, PSIS_HW_INFO HwDeviceExtension,
unsigned char modeno, int *htotal, int *vtotal, unsigned char rateindex);
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
extern int	sisfb_mode_rate_to_dclock(SiS_Private *SiS_Pr,
PSIS_HW_INFO HwDeviceExtension,
unsigned char modeno, unsigned char rateindex);
extern int      sisfb_mode_rate_to_ddata(SiS_Private *SiS_Pr, PSIS_HW_INFO HwDeviceExtension,
unsigned char modeno, unsigned char rateindex,
struct fb_var_screeninfo *var);
-#endif

/* Chrontel TV, DDC and DPMS functions */
extern USHORT 	SiS_GetCH700x(SiS_Private *SiS_Pr, USHORT tempbx);
Index: linux-2.6.13-rc2-mm1/drivers/video/sis/vgatypes.h
===================================================================
--- linux-2.6.13-rc2-mm1.orig/drivers/video/sis/vgatypes.h
+++ linux-2.6.13-rc2-mm1/drivers/video/sis/vgatypes.h
@@ -55,7 +55,6 @@

#ifdef LINUX_KERNEL  /* We don't want the X driver to depend on kernel source */
#include <linux/ioctl.h>
-#include <linux/version.h>
#endif

#ifndef FALSE
@@ -102,12 +101,10 @@ typedef unsigned char BOOLEAN;

#ifdef LINUX_KERNEL
typedef unsigned long SISIOADDRESS;
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,8)
#include <linux/types.h>  /* Need __iomem */
#undef SISIOMEMTYPE
#define SISIOMEMTYPE __iomem
#endif
-#endif

#ifdef LINUX_XF86
#if XF86_VERSION_CURRENT < XF86_VERSION_NUMERIC(4,2,0,0,0)
