Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbTJ0Jxc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 04:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbTJ0Jxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 04:53:31 -0500
Received: from smtp6.arnet.com.ar ([200.45.191.24]:41706 "HELO
	smtp6.arnet.com.ar") by vger.kernel.org with SMTP id S261276AbTJ0Juh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 04:50:37 -0500
Date: Mon, 27 Oct 2003 06:50:23 -0300
From: Javier Villavicencio <jvillavicencio@arnet.com.ar>
To: James Simmons <jsimmons@infradead.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] new fbdev & radeonfb_setup
Message-Id: <20031027065023.2b31b70d.jvillavicencio@arnet.com.ar>
X-Mailer: Sylpheed version 0.9.0claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Mon__27_Oct_2003_06:50:23_-0300_082c98a0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Mon__27_Oct_2003_06:50:23_-0300_082c98a0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Simple patch to the new radeon fb driver to make it set modes/resolutions,
and take the other parameters.
Extracted some code from the matroxfb driver. Added radeonfb_setup function.

Also, with the new fbdev driver and with or without this little fix, tested in -test8 and
-test9 I cannot get my console framebuffer back when I switch from X, system working ok,
but the console is distorted. I have a Radeon 9600 Pro.

Salu2.

Javier Villavicencio.


--Multipart_Mon__27_Oct_2003_06:50:23_-0300_082c98a0
Content-Type: text/x-diff;
 name="radeonfb_setup.diff"
Content-Disposition: attachment;
 filename="radeonfb_setup.diff"
Content-Transfer-Encoding: 7bit

diff -urN linux.radeonfb/drivers/video/aty/radeon_base.c linux-2.6.0-test9/drivers/video/aty/radeon_base.c
--- linux.radeonfb/drivers/video/aty/radeon_base.c	2003-10-27 06:23:11.799945343 -0300
+++ linux-2.6.0-test9/drivers/video/aty/radeon_base.c	2003-10-27 06:04:24.973721058 -0300
@@ -236,8 +236,8 @@
  * globals
  */
         
-static char *mode_option;
-static char *monitor_layout;
+static char mode_option[64]; 		/* "radeonfb:mode_option:xxxxx" or "radeonfb:xxxxx" */
+static char monitor_layout[64];		/* "radeonfb:mode_layout:xxxxx" */
 static int noaccel = 0;
 static int nomodeset = 0;
 static int ignore_edid = 0;
@@ -2367,6 +2367,40 @@
 #endif /* CONFIG_PM */
 };
 
+int __init radeonfb_setup (char *options) {
+	char *this_opt;
+
+	if (!options || !*options)
+		return 0;
+
+	while ((this_opt = strsep(&options, ",")) != NULL) {
+		if (!*this_opt) continue;
+
+		printk("radeonfb_setup: option %s\n", this_opt);
+		
+		if (!strncmp(this_opt, "noaccel:", 8))
+			noaccel = simple_strtoul(this_opt+8, NULL, 0);
+		else if (!strncmp(this_opt, "nomodeset:", 10))
+			nomodeset = simple_strtoul(this_opt+10, NULL, 0);
+		else if (!strncmp(this_opt, "panel_yres:", 11))
+			panel_yres = simple_strtoul(this_opt+11, NULL, 0);
+		else if (!strncmp(this_opt, "force_dfp:", 9))
+		        force_dfp = simple_strtoul(this_opt+9, NULL, 0);
+		else if (!strncmp(this_opt, "ignore_edid:", 11))
+			ignore_edid = simple_strtoul(this_opt+11, NULL, 0);
+		else if (!strncmp(this_opt, "force_measure_pll:", 17))
+			force_measure_pll = simple_strtoul(this_opt+17, NULL, 0);
+		else if (!strncmp(this_opt, "nomtrr:", 7))
+			nomtrr = simple_strtoul(this_opt+7, NULL, 0);
+		else if (!strncmp(this_opt, "monitor_layout:", 15))
+			strlcpy(monitor_layout, this_opt+15, sizeof(monitor_layout));
+		else if (!strncmp(this_opt, "mode_option:", 12))
+			strlcpy(mode_option, this_opt+12, sizeof(mode_option));
+                else 
+			strlcpy(mode_option, this_opt, sizeof(mode_option));
+	}
+	return 0;
+}
 
 int __init radeonfb_init (void)
 {
@@ -2406,6 +2440,6 @@
 MODULE_PARM_DESC(nomtrr, "bool: disable use of MTRR registers");
 #endif
 module_param(panel_yres, int, 0);
-MODULE_PARM_DESC(force_dfp, "int: set panel yres");
+MODULE_PARM_DESC(panel_yres, "int: set panel yres");
 module_param(mode_option, charp, 0);
 MODULE_PARM_DESC(mode_option, "Specify resolution as \"<xres>x<yres>[-<bpp>][@<refresh>]\" ");
diff -urN linux.radeonfb/drivers/video/aty/radeon_monitor.c linux-2.6.0-test9/drivers/video/aty/radeon_monitor.c
--- linux.radeonfb/drivers/video/aty/radeon_monitor.c	2003-10-27 06:23:11.804944612 -0300
+++ linux-2.6.0-test9/drivers/video/aty/radeon_monitor.c	2003-10-27 06:15:41.079084942 -0300
@@ -7,10 +7,22 @@
 #endif /* CONFIG_PPC_OF */
 
 static struct fb_var_screeninfo radeonfb_default_var = {
-        640, 480, 640, 480, 0, 0, 8, 0,
-        {0, 6, 0}, {0, 6, 0}, {0, 6, 0}, {0, 0, 0},
-        0, 0, -1, -1, 0, 39721, 40, 24, 32, 11, 96, 2,
-        0, FB_VMODE_NONINTERLACED
+        640,480,640,480,/* W,H, W, H (virtual) load xres,xres_virtual*/
+        0,0,            /* virtual -> visible no offset */
+        8,              /* depth -> load bits_per_pixel */
+        0,              /* greyscale ? */
+        {0,0,0},        /* R */
+        {0,0,0},        /* G */
+        {0,0,0},        /* B */
+        {0,0,0},        /* transparency */
+        0,              /* standard pixel format */
+        FB_ACTIVATE_NOW,
+        -1,-1,
+        FB_ACCELF_TEXT, /* accel flags */
+        39721L,48L,16L,33L,10L,
+        96L,2L,~0,      /* No sync info */
+        FB_VMODE_NONINTERLACED,
+        0, {0,0,0,0,0}
 };
 
 static char *radeon_get_mon_name(int type)
@@ -288,7 +300,7 @@
  * Parse the "monitor_layout" string if any. This code is mostly
  * copied from XFree's radeon driver
  */
-static int __devinit radeon_parse_monitor_layout(struct radeonfb_info *rinfo, const char *monitor_layout)
+static int __devinit radeon_parse_monitor_layout(struct radeonfb_info *rinfo, const char monitor_layout[64])
 {
 	char s1[5], s2[5];
 	int i = 0, second = 0;
@@ -348,7 +360,7 @@
  * driver
  */
 void __devinit radeon_probe_screens(struct radeonfb_info *rinfo,
-				    const char *monitor_layout, int ignore_edid)
+				    const char monitor_layout[64], int ignore_edid)
 {
 	int ddc_crt2_used = 0;
 	int tmp, i;
@@ -584,7 +596,7 @@
  * Build the modedb for head 1 (head 2 will come later), check panel infos
  * from either BIOS or EDID, and pick up the default mode
  */
-void __devinit radeon_check_modes(struct radeonfb_info *rinfo, const char *mode_option)
+void __devinit radeon_check_modes(struct radeonfb_info *rinfo, const char mode_option[64])
 {
 	int has_default_mode = 0;
 
@@ -698,11 +710,12 @@
 		struct fb_videomode default_mode;
 		if (has_default_mode)
 			radeon_var_to_videomode(&default_mode, &rinfo->info.var);
-		else
-			radeon_var_to_videomode(&default_mode, &radeonfb_default_var);
-		if (fb_find_mode(&rinfo->info.var, &rinfo->info, mode_option,
-				 rinfo->mon1_modedb, rinfo->mon1_dbsize, &default_mode, 8) == 0)
+		else {
+			printk("radeonfb: mode_option %s \n", mode_option);
+			fb_find_mode(&radeonfb_default_var, &rinfo->info, mode_option[0]?mode_option:NULL, 
+				     rinfo->mon1_modedb, rinfo->mon1_dbsize, &default_mode, 8);
 			rinfo->info.var = radeonfb_default_var;
+			radeon_var_to_videomode(&default_mode, &radeonfb_default_var);
+		}
 	}
-
 }

--Multipart_Mon__27_Oct_2003_06:50:23_-0300_082c98a0--
