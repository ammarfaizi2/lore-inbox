Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267752AbTAHFJF>; Wed, 8 Jan 2003 00:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267753AbTAHFJF>; Wed, 8 Jan 2003 00:09:05 -0500
Received: from willow.compass.com.ph ([202.70.96.38]:60680 "EHLO
	willow.compass.com.ph") by vger.kernel.org with ESMTP
	id <S267752AbTAHFIs>; Wed, 8 Jan 2003 00:08:48 -0500
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
Message-Id: <1042000922.1049.101.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 08 Jan 2003 13:02:50 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James, 

Here's an improved GTF implementation.  I was a bit delayed because I
was trying to find a way to do square roots without using floating
point.  The diff is against linux-2.5.54 + your latest fbdev.diff.

static int fb_get_mode(int flags, u32 val, struct fb_var_screeninfo
		       *var, struct fb_info *info);

if flags == 0:  maximize timings
            1:  vrefresh rate driven calculation
            2.  hscan rate driven calculation
	    3.  pixelclock driven calculation.

The parameter 'val' depends on the parameter 'flags':  ignored if flags
== 0, in Hz if 1 and 2, in picoseconds if 3.

The flags are useful for cases such as a fixed-frequency monitor (pass
flags = 2) or for hardware which only have several sets of dotclocks to
use.  In this case, it will run the GTF first, get the resulting
pixelclock to select a dotclock from the driver's own set, then rerun
the GTF using flags=3, and val = selected dotclock.

Probably still has precision errors, like converting KHZ to picoseconds,
but is more or less usable.  Tested with i810fb and rivafb. (For rivafb,
I have to use a hacked version. The latest one does not work for the
riva128).

BTW, I downloaded the source code of read-edid, and it seems that the
following monitor limits are parsable from the EDID block: HorizSync,
VertRefresh, DotClock, and GTF capability. We may change info->monspecs
to match that. Also, the EDID contains a list of supported modes, but
there's only 4 of them(?).  

Tony

diff -Naur linux-2.5.54/drivers/video/fbmon.c linux/drivers/video/fbmon.c
--- linux-2.5.54/drivers/video/fbmon.c	2003-01-08 04:19:48.000000000 +0000
+++ linux/drivers/video/fbmon.c	2003-01-08 04:18:11.000000000 +0000
@@ -289,7 +289,376 @@
 }
 #endif
 
+/* 
+ * VESA Generalized Timing Formula (GTF) 
+ */
+
+#define FLYBACK                     550
+#define V_FRONTPORCH                1
+#define H_OFFSET                    40
+#define H_SCALEFACTOR               20
+#define H_BLANKSCALE                128
+#define H_GRADIENT                  600
+#define C_VAL                       30
+#define M_VAL                       300
+
+struct __fb_timings {
+	u32 dclk;
+	u32 hfreq;
+	u32 vfreq;
+	u32 hactive;
+	u32 vactive;
+	u32 hblank;
+	u32 vblank;
+	u32 htotal;
+	u32 vtotal;
+};
+
+/*
+ * a simple function to get the square root of integers 
+ */
+static u32 fb_sqrt(int x)
+{
+	register int op, res, one;
+
+	op = x;
+	res = 0;
+
+	one = 1 << 30;
+	while (one > op) one >>= 2;
+
+	while (one != 0) {
+		if (op >= res + one) {
+			op = op - (res + one);
+			res = res +  2 * one;
+		}
+		res /= 2;
+		one /= 4;
+	}
+	return((u32) res);
+}
+
+/**
+ * fb_get_vblank - get vertical blank time
+ * @hfreq: horizontal freq
+ *
+ * DESCRIPTION:
+ * vblank = right_margin + vsync_len + left_margin 
+ *
+ *    given: right_margin = 1 (V_FRONTPORCH)
+ *           vsync_len    = 3
+ *           flyback      = 550
+ *
+ *                          flyback * hfreq
+ *           left_margin  = --------------- - vsync_len
+ *                           1000000
+ */
+static u32 fb_get_vblank(u32 hfreq)
+{
+	u32 vblank;
+
+	vblank = (hfreq * FLYBACK)/1000; 
+	vblank = (vblank + 500)/1000;
+	return (vblank + V_FRONTPORCH);
+}
+
+/** 
+ * fb_get_hblank_by_freq - get horizontal blank time given hfreq
+ * @hfreq: horizontal freq
+ * @xres: horizontal resolution in pixels
+ *
+ * DESCRIPTION:
+ *
+ *           xres * duty_cycle
+ * hblank = ------------------
+ *           100 - duty_cycle
+ *
+ * duty cycle = percent of htotal assigned to inactive display
+ * duty cycle = C - (M/Hfreq)
+ *
+ * where: C = ((offset - scale factor) * blank_scale)
+ *            -------------------------------------- + scale factor
+ *                        256 
+ *        M = blank_scale * gradient
+ *
+ */
+static u32 fb_get_hblank_by_hfreq(u32 hfreq, u32 xres)
+{
+	u32 c_val, m_val, duty_cycle, hblank;
+
+	c_val = (((H_OFFSET - H_SCALEFACTOR) * H_BLANKSCALE)/256 + 
+		 H_SCALEFACTOR) * 1000;
+	m_val = (H_BLANKSCALE * H_GRADIENT)/256;
+	m_val = (m_val * 1000000)/hfreq;
+	duty_cycle = c_val - m_val;
+	hblank = (xres * duty_cycle)/(100000 - duty_cycle);
+	return (hblank);
+}
+
+/** 
+ * fb_get_hblank_by_dclk - get horizontal blank time given pixelclock
+ * @dclk: pixelclock in Hz
+ * @xres: horizontal resolution in pixels
+ *
+ * DESCRIPTION:
+ *
+ *           xres * duty_cycle
+ * hblank = ------------------
+ *           100 - duty_cycle
+ *
+ * duty cycle = percent of htotal assigned to inactive display
+ * duty cycle = C - (M * h_period)
+ * 
+ * where: h_period = SQRT(100 - C + (0.4 * xres * M)/dclk) + C - 100
+ *                   -----------------------------------------------
+ *                                    2 * M
+ *        M = 300;
+ *        C = 30;
+
+ */
+static u32 fb_get_hblank_by_dclk(u32 dclk, u32 xres)
+{
+	u32 duty_cycle, h_period, hblank;;
+
+	dclk /= 1000;
+	h_period = 100 - C_VAL;
+	h_period *= h_period;
+	h_period += (M_VAL * xres * 2 * 1000)/(5 * dclk);
+	h_period *=10000; 
+
+	h_period = fb_sqrt((int) h_period);
+	h_period -= (100 - C_VAL) * 100;
+	h_period *= 1000; 
+	h_period /= 2 * M_VAL;
+
+	duty_cycle = C_VAL * 1000 - (M_VAL * h_period)/100;
+	hblank = (xres * duty_cycle)/(100000 - duty_cycle) + 8;
+	hblank &= ~15;
+	return (hblank);
+}
+	
+/**
+ * fb_get_hfreq - estimate hsync
+ * @vfreq: vertical refresh rate
+ * @yres: vertical resolution
+ *
+ * DESCRIPTION:
+ *
+ *          (yres + front_port) * vfreq * 1000000
+ * hfreq = -------------------------------------
+ *          (1000000 - (vfreq * FLYBACK)
+ * 
+ */
+
+static u32 fb_get_hfreq(u32 vfreq, u32 yres)
+{
+	u32 divisor, hfreq;
+	
+	divisor = (1000000 - (vfreq * FLYBACK))/1000;
+	hfreq = (yres + V_FRONTPORCH) * vfreq  * 1000;
+	return (hfreq/divisor);
+}
+
+static void fb_timings_vfreq(struct __fb_timings *timings)
+{
+	timings->hfreq = fb_get_hfreq(timings->vfreq, timings->vactive);
+	timings->vblank = fb_get_vblank(timings->hfreq);
+	timings->vtotal = timings->vactive + timings->vblank;
+	timings->hblank = fb_get_hblank_by_hfreq(timings->hfreq, 
+						 timings->hactive);
+	timings->htotal = timings->hactive + timings->hblank;
+	timings->dclk = timings->htotal * timings->hfreq;
+}
+
+static void fb_timings_hfreq(struct __fb_timings *timings)
+{
+	timings->vblank = fb_get_vblank(timings->hfreq);
+	timings->vtotal = timings->vactive + timings->vblank;
+	timings->vfreq = timings->hfreq/timings->vtotal;
+	timings->hblank = fb_get_hblank_by_hfreq(timings->hfreq, 
+						 timings->hactive);
+	timings->htotal = timings->hactive + timings->hblank;
+	timings->dclk = timings->htotal * timings->hfreq;
+}
+
+static void fb_timings_dclk(struct __fb_timings *timings)
+{
+	timings->hblank = fb_get_hblank_by_dclk(timings->dclk, 
+						timings->hactive);
+	timings->htotal = timings->hactive + timings->hblank;
+	timings->hfreq = timings->dclk/timings->htotal;
+	timings->vblank = fb_get_vblank(timings->hfreq);
+	timings->vtotal = timings->vactive + timings->vblank;
+	timings->vfreq = timings->hfreq/timings->vtotal;
+}
+
+/*
+ * fb_get_mode - calculates video mode using VESA GTF
+ * @flags: if: 0 - maximize vertical refresh rate
+ *             1 - vrefresh-driven calculation;
+ *             2 - hscan-driven calculation;
+ *             3 - pixelclock-driven calculation;
+ * @val: depending on @flags, ignored, vrefresh, hsync or pixelclock
+ * @var: pointer to fb_var_screeninfo
+ * @info: pointer to fb_info
+ *
+ * DESCRIPTION:
+ * Calculates video mode based on monitor specs using VESA GTF. 
+ * The GTF is best for VESA GTF compliant monitors but is 
+ * specifically formulated to work for older monitors as well.
+ *
+ * If @flag==0, the function will attempt to maximize the 
+ * refresh rate.  Otherwise, it will calculate timings based on
+ * the flag and accompanying value.  
+ *
+ * All calculations are based on the VESA GTF Spreadsheet
+ * available at VESA's public ftp (http://www.vesa.org).
+ * 
+ * NOTES:
+ * The timings generated by the GTF will be different from VESA
+ * DMT.  It might be a good idea to keep a table of standard
+ * VESA modes as well.  The GTF may also not work for some displays,
+ * such as, and especially, analog TV.
+ *   
+ * REQUIRES:
+ * A valid info->monspecs, otherwise 'safe numbers' will be used.
+ */ 
+int fb_get_mode(int flags, u32 val, struct fb_var_screeninfo *var, struct fb_info *info)
+{
+	struct __fb_timings timings;
+	u32 interlace = 1, dscan = 1;
+	u32 hfmin, hfmax, vfmin, vfmax;
+
+	/* 
+	 * If monspecs are invalid, use values that are enough
+	 * for 640x480@60
+	 */
+	if ((!info->monspecs.hfmax && !info->monspecs.vfmax) ||
+	    info->monspecs.hfmax < info->monspecs.hfmin ||
+	    info->monspecs.vfmax < info->monspecs.vfmin) {
+		hfmin = 29000; hfmax = 30000;
+		vfmin = 60; vfmax = 60;
+	} else {
+		hfmin = info->monspecs.hfmin;
+		hfmax = info->monspecs.hfmax;
+		vfmin = info->monspecs.vfmin;
+		vfmax = info->monspecs.vfmax;
+	}
+
+	memset(&timings, 0, sizeof(struct __fb_timings));
+	timings.hactive = var->xres;
+	timings.vactive = var->yres;
+	if (var->vmode & FB_VMODE_INTERLACED) { 
+		timings.vactive /= 2;
+		interlace = 2;
+	}
+	if (var->vmode & FB_VMODE_DOUBLE) {
+		timings.vactive *= 2;
+		dscan = 2;
+	}
+
+	switch (flags) {
+	case 0: /* maximize refresh rate */
+		timings.hfreq = hfmax;
+		fb_timings_hfreq(&timings);
+		if (timings.vfreq > vfmax) {
+			timings.vfreq = vfmax;
+			fb_timings_vfreq(&timings);
+		}
+		break;
+	case 1: /* vrefresh driven */
+		timings.vfreq = val;
+		fb_timings_vfreq(&timings);
+		break;
+	case 2: /* hsync driven */
+		timings.hfreq = val;
+		fb_timings_hfreq(&timings);
+		break;
+	case 3: /* pixelclock driven */
+		timings.dclk = PICOS2KHZ(val) * 1000;
+		fb_timings_dclk(&timings);
+		break;
+	default:
+		return -EINVAL;
+		
+	} 
+	
+	if (timings.vfreq < vfmin || timings.vfreq > vfmax || 
+	    timings.hfreq < hfmin || timings.hfreq > hfmax)
+		return -EINVAL;
+
+
+	var->pixclock = KHZ2PICOS(timings.dclk/1000);
+	var->hsync_len = (timings.htotal * 8)/100;
+	var->right_margin = (timings.hblank/2) - var->hsync_len;
+	var->left_margin = timings.hblank - var->right_margin - var->hsync_len;
+	
+	var->vsync_len = (3 * interlace)/dscan;
+	var->lower_margin = (1 * interlace)/dscan;
+	var->upper_margin = (timings.vblank * interlace)/dscan - 
+		(var->vsync_len + var->lower_margin);
+	
+	return 0;
+}
+	
+/*
+ * fb_validate_mode - validates var against monitor capabilities
+ * @var: pointer to fb_var_screeninfo
+ * @info: pointer to fb_info
+ *
+ * DESCRIPTION:
+ * Validates video mode against monitor capabilities specified in
+ * info->monspecs.
+ *
+ * REQUIRES:
+ * A valid info->monspecs.
+ */
+int fb_validate_mode(struct fb_var_screeninfo *var, struct fb_info *info)
+{
+	u32 hfreq, vfreq, htotal, vtotal, pixclock;
+	u32 hfmin, hfmax, vfmin, vfmax;
+
+	/* 
+	 * If monspecs are invalid, use values that are enough
+	 * for 640x480@60
+	 */
+	if ((!info->monspecs.hfmax && !info->monspecs.vfmax) ||
+	    info->monspecs.hfmax < info->monspecs.hfmin ||
+	    info->monspecs.vfmax < info->monspecs.vfmin) {
+		hfmin = 29000; hfmax = 30000;
+		vfmin = 60; vfmax = 60;
+	} else {
+		hfmin = info->monspecs.hfmin;
+		hfmax = info->monspecs.hfmax;
+		vfmin = info->monspecs.vfmin;
+		vfmax = info->monspecs.vfmax;
+	}
+
+	if (!var->pixclock)
+		return -EINVAL;
+	pixclock = PICOS2KHZ(var->pixclock) * 1000;
+	   
+	htotal = var->xres + var->right_margin + var->hsync_len + 
+		var->left_margin;
+	vtotal = var->yres + var->lower_margin + var->vsync_len + 
+		var->upper_margin;
+
+	if (var->vmode & FB_VMODE_INTERLACED)
+		vtotal /= 2;
+	if (var->vmode & FB_VMODE_DOUBLE)
+		vtotal *= 2;
+
+	hfreq = pixclock/htotal;
+	vfreq = hfreq/vtotal;
+
+	return (vfreq < vfmin || vfreq > vfmax || 
+		hfreq < hfmin || hfreq > hfmax) ?
+		-EINVAL : 0;
+}
+
 EXPORT_SYMBOL(parse_edid);
 #ifdef CONFIG_PCI
 EXPORT_SYMBOL(get_EDID);
 #endif
+EXPORT_SYMBOL(fb_get_mode);
+EXPORT_SYMBOL(fb_validate_mode);
diff -Naur linux-2.5.54/include/linux/fb.h linux/include/linux/fb.h
--- linux-2.5.54/include/linux/fb.h	2003-01-08 04:20:07.000000000 +0000
+++ linux/include/linux/fb.h	2003-01-08 04:19:26.000000000 +0000
@@ -468,6 +468,10 @@
 extern int fbmon_valid_timings(u_int pixclock, u_int htotal, u_int vtotal,
 			       const struct fb_info *fb_info);
 extern int fbmon_dpms(const struct fb_info *fb_info);
+extern int fb_get_mode(int flags, u32 val, struct fb_var_screeninfo *var,
+		       struct fb_info *info);
+extern int fb_validate_mode(struct fb_var_screeninfo *var,
+			    struct fb_info *info);
 
 /* drivers/video/fbcmap.c */
 extern int fb_alloc_cmap(struct fb_cmap *cmap, int len, int transp);

