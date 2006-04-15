Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030246AbWDOOIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030246AbWDOOIw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 10:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030249AbWDOOIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 10:08:52 -0400
Received: from nproxy.gmail.com ([64.233.182.188]:25376 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030246AbWDOOIv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 10:08:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=uTsmYWDcO2XAci4gzU+AL5FZ1/Ldj6IAQdau4knBPFi/FbORtc8UJqZyifLaIqWW2B+rxquOfbW1RzDfBEiVTSV/REwpOx4OoL+xqnmr94U/V86+IDiTfiDLOkmSMfd+9vQpCekFn2ZLICrBcRXS+0NMZ6FG0KJ9xSkX4O6/cj0=
Date: Sat, 15 Apr 2006 16:13:54 +0200
From: Giorgio Lando <patroclo7@gmail.com>
To: benh@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net,
       Joel.Becker@oracle.com, Antti.Andreimann@mail.ee,
       degrenier@easyconnect.fr, vbraun@physics.upenn.edu
Subject: [PATCH 2.6.16] radeonfb: powerdrain issue on IBM thinkpads and suspend-to-D2
Message-ID: <20060415141354.GA27523@clarabella.clarabella>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r802 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Many IBM Thinkpad T4* models and some R* and X* with radeon video cards, when 
suspended to RAM, draw too much power, reducing drastically the battery 
lifetime. The solution is to enable suspend-to-D2 on non-PPC-machines. Since 
this is in general not well documented, suspend-to-D2 is enabled only on 
machines where it is known to work. These machines are identified through 
their DMI strings and listed in a white-list into the patch itself.  

This behaviour can be overriden with module options: through these options
suspend-to-D2 can be:
i) enabled also on non-whitelisted machines (since the white-list is partial 
and can be enlarged in the time);
ii) disabled on whitelisted machines, in case of negative side-effects.

The module options can be passed at boot time including the following 
corresponding parameter in the kernel command line:
i) video=radeonfb:force_sleep=1
ii) video=radeonfb:nosleep=1

Signed-off-by: Antti Andreimann <Antti.Andreimann@mail.ee> 
Acked-by: Volker Braun <vbraun@physics.upenn.edu>
Acked-by: Joel Becker <Joel.Becker@oracle.com>
Signed-off-by: Thomas De Grenier De Latour <degrenier@easyconnect.fr>
Signed-off-by: Giorgio Lando <patroclo7@gmail.com>
---

  linux-2.6.16/drivers/video/aty/radeon_base.c |   17 ++++++++++++++++- 
  linux-2.6.16/drivers/video/aty/radeon_pm.c   |   118 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++- 
  2 files changed, 112 insertions(+), 1 deletion(-)

--- linux-2.6.16/drivers/video/aty/radeon_base.c
+++ linux-2.6.16/drivers/video/aty/radeon_base.c
@@ -272,7 +272,10 @@ static int force_measure_pll = 0;
 #ifdef CONFIG_MTRR
 static int nomtrr = 0;
 #endif
-
+#if defined(CONFIG_PM) && defined(CONFIG_X86)
+int force_sleep = 0;
+int nosleep = 0;
+#endif
 /*
  * prototypes
  */
@@ -2615,6 +2618,12 @@ static int __init radeonfb_setup (char *
 			force_measure_pll = 1;
 		} else if (!strncmp(this_opt, "ignore_edid", 11)) {
 			ignore_edid = 1;
+#if defined(CONFIG_PM) && defined(CONFIG_X86)
+	 	} else if (!strncmp(this_opt, "force_sleep", 11)) {
+			force_sleep = 1;
+		} else if (!strncmp(this_opt, "nosleep", 7)) {
+			nosleep = 1;
+#endif
 		} else
 			mode_option = this_opt;
 	}
@@ -2670,3 +2679,9 @@ module_param(panel_yres, int, 0);
 MODULE_PARM_DESC(panel_yres, "int: set panel yres");
 module_param(mode_option, charp, 0);
 MODULE_PARM_DESC(mode_option, "Specify resolution as \"<xres>x<yres>[-<bpp>][@<refresh>]\" ");
+#if defined(CONFIG_PM) && defined(CONFIG_X86)
+module_param(force_sleep, bool, 0);
+MODULE_PARM_DESC(force_sleep, "bool: force D2 sleep mode on non whitelisted laptops");
+module_param(nosleep, bool, 0);
+MODULE_PARM_DESC(nosleep, "bool: disable D2 sleep mode, ignoring whitelisted laptops");
+#endif
--- linux-2.6.16/drivers/video/aty/radeon_pm.c
+++ /var/abs/local/kernel26/src/linux-2.6.16/drivers/video/aty/radeon_pm.c	
@@ -27,6 +27,95 @@
 
 #include "ati_ids.h"
 
+#if defined(CONFIG_PM) && defined(CONFIG_X86)
+/* DMI is used to detect PC laptops known to support D2 sleep */
+#include <linux/dmi.h>
+
+/* Whitelist of PC laptops known to support D2 sleep */
+static int radeon_sleep_dmi_whitelisted(struct dmi_system_id *id) {
+	printk(KERN_DEBUG "radeonfb: %s detected, enabling D2 sleep\n", id->ident);
+	return 1;
+}
+#define RADEON_SLEEP_THINKPAD_DMI_MATCH_MODEL(model) { \
+	.ident = "IBM ThinkPad " model, \
+	.callback = radeon_sleep_dmi_whitelisted, \
+	.matches = { \
+		DMI_MATCH(DMI_BOARD_VENDOR, "IBM"), \
+		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad " model) \
+	} \
+}
+#define RADEON_SLEEP_THINKPAD_DMI_MATCH_TYPE(type,name) { \
+	.ident = "IBM ThinkPad " name " (" type ")", \
+	.callback = radeon_sleep_dmi_whitelisted, \
+	.matches = { \
+		DMI_MATCH(DMI_BOARD_VENDOR, "IBM"), \
+		DMI_MATCH(DMI_PRODUCT_NAME, type) \
+	} \
+}
+static struct dmi_system_id radeon_sleep_dmi_whitelist[] = {
+	// This models all had at least one positive report and no negative one
+	RADEON_SLEEP_THINKPAD_DMI_MATCH_MODEL("R50"),
+	RADEON_SLEEP_THINKPAD_DMI_MATCH_MODEL("R51"),
+	RADEON_SLEEP_THINKPAD_DMI_MATCH_MODEL("T40p"),
+	RADEON_SLEEP_THINKPAD_DMI_MATCH_MODEL("T40"),
+	RADEON_SLEEP_THINKPAD_DMI_MATCH_MODEL("T41p"),
+	RADEON_SLEEP_THINKPAD_DMI_MATCH_MODEL("T41"),
+	RADEON_SLEEP_THINKPAD_DMI_MATCH_MODEL("T42"),
+	// Same for this ones, but it's still to confirm that the DMI string exists
+	RADEON_SLEEP_THINKPAD_DMI_MATCH_MODEL("T30"),
+	RADEON_SLEEP_THINKPAD_DMI_MATCH_MODEL("R32"),
+	RADEON_SLEEP_THINKPAD_DMI_MATCH_MODEL("X31"),
+	// R40 does not have the version DMI string
+	RADEON_SLEEP_THINKPAD_DMI_MATCH_TYPE("2681","R40"),
+	RADEON_SLEEP_THINKPAD_DMI_MATCH_TYPE("2682","R40"),
+	RADEON_SLEEP_THINKPAD_DMI_MATCH_TYPE("2683","R40"),
+	RADEON_SLEEP_THINKPAD_DMI_MATCH_TYPE("2722","R40"),
+	RADEON_SLEEP_THINKPAD_DMI_MATCH_TYPE("2723","R40"),
+	RADEON_SLEEP_THINKPAD_DMI_MATCH_TYPE("2724","R40"),
+	RADEON_SLEEP_THINKPAD_DMI_MATCH_TYPE("2892","R40"),
+	RADEON_SLEEP_THINKPAD_DMI_MATCH_TYPE("2893","R40"),
+	RADEON_SLEEP_THINKPAD_DMI_MATCH_TYPE("2896","R40"),
+	RADEON_SLEEP_THINKPAD_DMI_MATCH_TYPE("2897","R40"),
+	RADEON_SLEEP_THINKPAD_DMI_MATCH_TYPE("2898","R40"),
+	RADEON_SLEEP_THINKPAD_DMI_MATCH_TYPE("2899","R40"),
+	{ .ident = NULL }
+};
+
+/* Need a blacklist too because DMI matching is done by substrings search */
+#define RADEON_SLEEP_THINKPAD_DMI_UNMATCH_MODEL(model) { \
+	.ident = "IBM ThinkPad " model, \
+	.matches = { \
+		DMI_MATCH(DMI_BOARD_VENDOR, "IBM"), \
+		DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad " model) \
+	} \
+}
+#define RADEON_SLEEP_THINKPAD_DMI_UNMATCH_TYPE(type,name) { \
+	.ident = "IBM ThinkPad " name " (" type ")", \
+	.matches = { \
+		DMI_MATCH(DMI_BOARD_VENDOR, "IBM"), \
+		DMI_MATCH(DMI_PRODUCT_NAME, type) \
+	} \
+}
+static struct dmi_system_id radeon_sleep_dmi_blacklist[] = {
+	// Excluded by lack of positive report, and possibly wrong substring match
+	RADEON_SLEEP_THINKPAD_DMI_UNMATCH_MODEL("R50p"),
+	RADEON_SLEEP_THINKPAD_DMI_UNMATCH_MODEL("R50e"),
+	RADEON_SLEEP_THINKPAD_DMI_UNMATCH_MODEL("R51e"),
+	// T42p excluded because of one negative report and no positive one
+	RADEON_SLEEP_THINKPAD_DMI_UNMATCH_MODEL("T42p"),
+	{ .ident = NULL }
+};
+
+/* Macro for checking DMI infos against the whitelist */
+#define radeon_sleep_match_whitelist() \
+	(! dmi_check_system(radeon_sleep_dmi_blacklist) \
+	 && dmi_check_system(radeon_sleep_dmi_whitelist))
+
+/* Module parameters to ignore the whitelist */
+extern int force_sleep;
+extern int nosleep;
+#endif /* defined(CONFIG_PM) && defined(CONFIG_X86) */
+
 static void radeon_pm_disable_dynamic_mode(struct radeonfb_info *rinfo)
 {
 	u32 tmp;
@@ -852,7 +941,13 @@ static void radeon_pm_setup_for_suspend(
 	/* because both INPLL and OUTPLL take the same lock, that's why. */
 	tmp = INPLL( pllMCLK_MISC) | MCLK_MISC__EN_MCLK_TRISTATE_IN_SUSPEND;
 	OUTPLL( pllMCLK_MISC, tmp);
-	
+
+	/* BUS_CNTL1__MOBILE_PLATORM_SEL setting is northbridge chipset
+	 * and radeon chip dependent. Thus we only enable it on Mac for
+	 * now (until we get more info on how to compute the correct
+	 * value for various X86 bridges).
+	 */
+#ifdef CONFIG_PPC_PMAC	
 	/* AGP PLL control */
 	if (rinfo->family <= CHIP_FAMILY_RV280) {
 		OUTREG(BUS_CNTL1, INREG(BUS_CNTL1) |  BUS_CNTL1__AGPCLK_VALID);
@@ -864,6 +959,7 @@ static void radeon_pm_setup_for_suspend(
 		OUTREG(BUS_CNTL1, INREG(BUS_CNTL1));
 		OUTREG(BUS_CNTL1, (INREG(BUS_CNTL1) & ~0x4000) | 0x8000);
 	}
+#endif
 
 	OUTREG(CRTC_OFFSET_CNTL, (INREG(CRTC_OFFSET_CNTL)
 				  & ~CRTC_OFFSET_CNTL__CRTC_STEREO_SYNC_OUT_EN));
@@ -2789,6 +2885,26 @@ void radeonfb_pm_init(struct radeonfb_in
 #endif
 	}
 #endif /* defined(CONFIG_PPC_PMAC) */
+
+/* The PM code also works on some PC laptops.
+ * We can do D2 on at least M7 and M9 on some IBM ThinkPad models.
+ */
+#if defined(CONFIG_X86)
+	if (!nosleep && (force_sleep || radeon_sleep_match_whitelist())) {
+		if (force_sleep)
+			printk(KERN_DEBUG "radeonfb: forcefully enabling D2 sleep mode\n");
+
+		if (rinfo->is_mobility && rinfo->pm_reg &&
+		    rinfo->family <= CHIP_FAMILY_RV250)
+			rinfo->pm_mode |= radeon_pm_d2;
+
+		/* Power down TV DAC, that saves a significant amount of power,
+		 * we'll have something better once we actually have some TVOut
+		 * support
+		 */
+		OUTREG(TV_DAC_CNTL, INREG(TV_DAC_CNTL) | 0x07000000);
+	}
+#endif /* defined(CONFIG_X86) */
 #endif /* defined(CONFIG_PM) */
 }
 

