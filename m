Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265246AbTAJPkt>; Fri, 10 Jan 2003 10:40:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265211AbTAJPkt>; Fri, 10 Jan 2003 10:40:49 -0500
Received: from willow.compass.com.ph ([202.70.96.38]:8453 "EHLO
	willow.compass.com.ph") by vger.kernel.org with ESMTP
	id <S265246AbTAJPkq>; Fri, 10 Jan 2003 10:40:46 -0500
Subject: Re: [Linux-fbdev-devel] [RFC][PATCH][FBDEV]: Setting fbcon's
	windows size
From: Antonino Daplas <adaplas@pol.net>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <1041864838.955.68.camel@localhost.localdomain>
References: <1041864838.955.68.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1042213013.932.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 10 Jan 2003 23:38:51 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-01-06 at 22:54, Antonino Daplas wrote:
> So, what's needed is a function that calculates timing parameters which
> is generic enough to work with the most common monitors.  One solution
> is to use VESA's GTF (Generalized Timing Formula).  Attached is a patch
> that implements the formula.
> 

James,

Attached is a diff against linux-2.5.54 + your latest fbdev.diff. 
Hopefully it's the final installment for the GTF implementation.

The fb_get_mode() function checks for a bit in 'flags' (FB_IGNOREMON) so
it will generate GTF timings regardless of the validity of
info->monspecs.  This way, drivers can still use GTF even if they don't
have the operational limits of the monitor.  They'll just decide what is
a practical safe limit.

This particular code snippet can be inserted in xxxfb_check_var() after
rounding off var->xres and var->yres.

...
if (fb_validate_mode(var, info)) {
	if (!info->monspecs.hfmax || !info->monspecs.vfmax ||
	    !info->monspecs.dclkmax || 
	    info->monspecs.hfmax < info->monspecs.hfmin ||
	    info->monspecs.vfmax < info->monspecs.vfmin ||
	    info->monspecs.dclkmax < info->monspecs.dclkmin) 
		fb_get_mode(FB_IGNOREMON | FB_VSYNCTIMINGS, 60, var, info);
	else 
		if (fb_get_mode(FB_MAXTIMINGS, 0, var, info))
			return -EINVAL;
}
...

With the above, the driver will switch to a 60Hz refresh rate timings
(safe even for low-end monitors up to 1024x768) if monspecs is invalid. 

Other changes:  added a few more fields to fb_info.monspecs.

Tony

diff -Naur linux-2.5.54/drivers/video/fbmon.c linux/drivers/video/fbmon.c
--- linux-2.5.54/drivers/video/fbmon.c	2003-01-10 15:17:22.000000000 +0000
+++ linux/drivers/video/fbmon.c	2003-01-10 15:10:44.000000000 +0000
@@ -511,6 +511,9 @@
  * refresh rate.  Otherwise, it will calculate timings based on
  * the flag and accompanying value.  
  *
+ * If FB_IGNOREMON bit is set in @flags, monitor specs will be 
+ * ignored and @var will be filled with the calculated timings.
+ *
  * All calculations are based on the VESA GTF Spreadsheet
  * available at VESA's public ftp (http://www.vesa.org).
  * 
@@ -527,22 +530,27 @@
 {
 	struct __fb_timings timings;
 	u32 interlace = 1, dscan = 1;
-	u32 hfmin, hfmax, vfmin, vfmax;
+	u32 hfmin, hfmax, vfmin, vfmax, dclkmin, dclkmax;
 
 	/* 
 	 * If monspecs are invalid, use values that are enough
 	 * for 640x480@60
 	 */
-	if ((!info->monspecs.hfmax && !info->monspecs.vfmax) ||
+	if (!info->monspecs.hfmax || !info->monspecs.vfmax ||
+	    !info->monspecs.dclkmax ||
 	    info->monspecs.hfmax < info->monspecs.hfmin ||
-	    info->monspecs.vfmax < info->monspecs.vfmin) {
+	    info->monspecs.vfmax < info->monspecs.vfmin ||
+	    info->monspecs.dclkmax < info->monspecs.dclkmin) {
 		hfmin = 29000; hfmax = 30000;
 		vfmin = 60; vfmax = 60;
+		dclkmin = 0; dclkmax = 25000000;
 	} else {
 		hfmin = info->monspecs.hfmin;
 		hfmax = info->monspecs.hfmax;
 		vfmin = info->monspecs.vfmin;
 		vfmax = info->monspecs.vfmax;
+		dclkmin = info->monspecs.dclkmin;
+		dclkmax = info->monspecs.dclkmax;
 	}
 
 	memset(&timings, 0, sizeof(struct __fb_timings));
@@ -557,8 +565,8 @@
 		dscan = 2;
 	}
 
-	switch (flags) {
-	case 0: /* maximize refresh rate */
+	switch (flags & ~FB_IGNOREMON) {
+	case FB_MAXTIMINGS: /* maximize refresh rate */
 		timings.hfreq = hfmax;
 		fb_timings_hfreq(&timings);
 		if (timings.vfreq > vfmax) {
@@ -566,15 +574,15 @@
 			fb_timings_vfreq(&timings);
 		}
 		break;
-	case 1: /* vrefresh driven */
+	case FB_VSYNCTIMINGS: /* vrefresh driven */
 		timings.vfreq = val;
 		fb_timings_vfreq(&timings);
 		break;
-	case 2: /* hsync driven */
+	case FB_HSYNCTIMINGS: /* hsync driven */
 		timings.hfreq = val;
 		fb_timings_hfreq(&timings);
 		break;
-	case 3: /* pixelclock driven */
+	case FB_DCLKTIMINGS: /* pixelclock driven */
 		timings.dclk = PICOS2KHZ(val) * 1000;
 		fb_timings_dclk(&timings);
 		break;
@@ -583,11 +591,12 @@
 		
 	} 
 	
-	if (timings.vfreq < vfmin || timings.vfreq > vfmax || 
-	    timings.hfreq < hfmin || timings.hfreq > hfmax)
+	if (!(flags & FB_IGNOREMON) && 
+	    (timings.vfreq < vfmin || timings.vfreq > vfmax || 
+	     timings.hfreq < hfmin || timings.hfreq > hfmax ||
+	     timings.dclk < dclkmin || timings.dclk > dclkmax))
 		return -EINVAL;
 
-
 	var->pixclock = KHZ2PICOS(timings.dclk/1000);
 	var->hsync_len = (timings.htotal * 8)/100;
 	var->right_margin = (timings.hblank/2) - var->hsync_len;
@@ -616,22 +625,27 @@
 int fb_validate_mode(struct fb_var_screeninfo *var, struct fb_info *info)
 {
 	u32 hfreq, vfreq, htotal, vtotal, pixclock;
-	u32 hfmin, hfmax, vfmin, vfmax;
+	u32 hfmin, hfmax, vfmin, vfmax, dclkmin, dclkmax;
 
 	/* 
 	 * If monspecs are invalid, use values that are enough
 	 * for 640x480@60
 	 */
-	if ((!info->monspecs.hfmax && !info->monspecs.vfmax) ||
+	if (!info->monspecs.hfmax || !info->monspecs.vfmax ||
+	    !info->monspecs.dclkmax ||
 	    info->monspecs.hfmax < info->monspecs.hfmin ||
-	    info->monspecs.vfmax < info->monspecs.vfmin) {
+	    info->monspecs.vfmax < info->monspecs.vfmin ||
+	    info->monspecs.dclkmax < info->monspecs.dclkmin) {
 		hfmin = 29000; hfmax = 30000;
 		vfmin = 60; vfmax = 60;
+		dclkmin = 0; dclkmax = 25000000;
 	} else {
 		hfmin = info->monspecs.hfmin;
 		hfmax = info->monspecs.hfmax;
 		vfmin = info->monspecs.vfmin;
 		vfmax = info->monspecs.vfmax;
+		dclkmin = info->monspecs.dclkmin;
+		dclkmax = info->monspecs.dclkmax;
 	}
 
 	if (!var->pixclock)
diff -Naur linux-2.5.54/include/linux/fb.h linux/include/linux/fb.h
--- linux-2.5.54/include/linux/fb.h	2003-01-10 15:17:37.000000000 +0000
+++ linux/include/linux/fb.h	2003-01-10 15:19:56.000000000 +0000
@@ -240,6 +240,9 @@
 	__u32 hfmax; 			/* hfreq upper limit (Hz) */
 	__u16 vfmin;			/* vfreq lower limit (Hz) */
 	__u16 vfmax;			/* vfreq upper limit (Hz) */
+	__u32 dclkmin;                  /* pixelclock lower limit (Hz) */
+	__u32 dclkmax;                  /* pixelclock upper limit (Hz) */
+	unsigned gtf  : 1;              /* supports GTF */
 	unsigned dpms : 1;		/* supports DPMS */
 };
 
@@ -465,6 +468,12 @@
 extern int num_registered_fb;
 
 /* drivers/video/fbmon.c */
+#define FB_MAXTIMINGS       0
+#define FB_VSYNCTIMINGS     1
+#define FB_HSYNCTIMINGS     2
+#define FB_DCLKTIMINGS      3
+#define FB_IGNOREMON    0x100
+
 extern int fbmon_valid_timings(u_int pixclock, u_int htotal, u_int vtotal,
 			       const struct fb_info *fb_info);
 extern int fbmon_dpms(const struct fb_info *fb_info);

