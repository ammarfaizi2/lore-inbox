Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261297AbVCKDz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbVCKDz0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 22:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262723AbVCKDxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 22:53:32 -0500
Received: from thunk.org ([69.25.196.29]:1983 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261475AbVCKDqd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 22:46:33 -0500
Date: Thu, 10 Mar 2005 22:46:15 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Moritz Muehlenhoff <jmm@inutil.org>
Cc: Martin Josefsson <gandalf@wlug.westbo.se>, linux-kernel@vger.kernel.org
Subject: Re: Average power consumption in S3?
Message-ID: <20050311034615.GA314@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Moritz Muehlenhoff <jmm@inutil.org>,
	Martin Josefsson <gandalf@wlug.westbo.se>,
	linux-kernel@vger.kernel.org
References: <20050309142612.GA6049@informatik.uni-bremen.de> <1110388970.1076.48.camel@tux.rsn.bth.se> <20050310180826.GA6795@informatik.uni-bremen.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
In-Reply-To: <20050310180826.GA6795@informatik.uni-bremen.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 10, 2005 at 07:08:26PM +0100, Moritz Muehlenhoff wrote:
> I've got the e100 and with WOL disabled and Matthew's hacked radeontool
> power consumption decreases to 970 mWh.

I have a T40p, and with the following patches (versus 2.6.11) and the
following sleep script, I have power consuption down to 580 mWh.

The 05-radeonfb-Thinkpad-Power.patch will have to patched with your
specific Thinkpad model number, or booted with the force_sleep option.
See the Linux thinkpad mailing list (linux-thinkpad@linux-thinkpad.org) 
archives for more information.

Warning: The 05-radeonfb-Thinkpad-Power.patch is not quite ready for
merging, but compared to completely pathetic battery life when using
ACPI's suspend-to-memory without them, it's definitely worth it.

						- Ted

--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="01-acpi-sleep-while-atomic-during-s3-resume-from-ram.patch"


From: Christian Borntraeger <linux-kernel@borntraeger.net>

During the wakeup from suspend-to-ram I get several warnings.

Signed-off-by: Christian Borntraeger <linux-kernel@borntraeger.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/acpi/osl.c      |    4 ++--
 25-akpm/drivers/acpi/pci_link.c |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff -puN drivers/acpi/osl.c~acpi-sleep-while-atomic-during-s3-resume-from-ram drivers/acpi/osl.c
--- 25/drivers/acpi/osl.c~acpi-sleep-while-atomic-during-s3-resume-from-ram	2005-01-16 00:45:23.784364208 -0800
+++ 25-akpm/drivers/acpi/osl.c	2005-01-16 00:45:23.789363448 -0800
@@ -145,7 +145,7 @@ acpi_os_vprintf(const char *fmt, va_list
 void *
 acpi_os_allocate(acpi_size size)
 {
-	return kmalloc(size, GFP_KERNEL);
+	return kmalloc(size, GFP_ATOMIC);
 }
 
 void
@@ -905,7 +905,7 @@ acpi_os_wait_semaphore(
 
 	ACPI_DEBUG_PRINT ((ACPI_DB_MUTEX, "Waiting for semaphore[%p|%d|%d]\n", handle, units, timeout));
 
-	if (in_atomic())
+	if (in_atomic() || irqs_disabled())
 		timeout = 0;
 
 	switch (timeout)
diff -puN drivers/acpi/pci_link.c~acpi-sleep-while-atomic-during-s3-resume-from-ram drivers/acpi/pci_link.c
--- 25/drivers/acpi/pci_link.c~acpi-sleep-while-atomic-during-s3-resume-from-ram	2005-01-16 00:45:23.785364056 -0800
+++ 25-akpm/drivers/acpi/pci_link.c	2005-01-16 00:45:23.790363296 -0800
@@ -315,7 +315,7 @@ acpi_pci_link_set (
 	if (!link || !irq)
 		return_VALUE(-EINVAL);
 
-	resource = kmalloc( sizeof(*resource)+1, GFP_KERNEL);
+	resource = kmalloc( sizeof(*resource)+1, GFP_ATOMIC);
 	if(!resource)
 		return_VALUE(-ENOMEM);
 
_

--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="02-acpi-sleep-while-atomic.patch"

This is needed to remove another sleeping function called from invalid 
context error message when resuming from sleep.

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>


Index: src/drivers/acpi/utils.c
===================================================================
--- src.orig/drivers/acpi/utils.c	2005-03-03 13:08:44.000000000 -0500
+++ src/drivers/acpi/utils.c	2005-03-03 13:10:04.000000000 -0500
@@ -252,7 +252,7 @@
 	if (!data)
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
 
-	element = kmalloc(sizeof(union acpi_object), GFP_KERNEL);
+	element = kmalloc(sizeof(union acpi_object), GFP_ATOMIC);
 	if(!element)
 		return_ACPI_STATUS(AE_NO_MEMORY);
 

--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="05-radeonfb-Thinkpad-Power.patch"

===== drivers/video/aty/radeon_base.c 1.40 vs edited =====
--- 1.40/drivers/video/aty/radeon_base.c	2005-02-15 21:25:30 -05:00
+++ edited/drivers/video/aty/radeon_base.c	2005-02-17 20:30:48 -05:00
@@ -273,6 +273,9 @@
 #ifdef CONFIG_MTRR
 static int nomtrr = 0;
 #endif
+#if defined(CONFIG_PM) && defined(CONFIG_X86)
+int radeon_force_sleep = 0;
+#endif
 
 /*
  * prototypes
@@ -2535,6 +2538,10 @@
 			force_measure_pll = 1;
 		} else if (!strncmp(this_opt, "ignore_edid", 11)) {
 			ignore_edid = 1;
+#if defined(CONFIG_PM) && defined(CONFIG_X86)
+		} else if (!strncmp(this_opt, "force_sleep", 11)) {
+			radeon_force_sleep = 1;
+#endif
 		} else
 			mode_option = this_opt;
 	}
@@ -2574,3 +2581,5 @@
 MODULE_PARM_DESC(panel_yres, "int: set panel yres");
 module_param(mode_option, charp, 0);
 MODULE_PARM_DESC(mode_option, "Specify resolution as \"<xres>x<yres>[-<bpp>][@<refresh>]\" ");
+module_param(radeon_force_sleep, int, 0);
+MODULE_PARM_DESC(radeon_force_sleep, "bool: force ACPI sleep mode on untested machines");
===== drivers/video/aty/radeon_pm.c 1.10 vs edited =====
--- 1.10/drivers/video/aty/radeon_pm.c	2005-02-12 23:01:11 -05:00
+++ edited/drivers/video/aty/radeon_pm.c	2005-02-17 20:23:57 -05:00
@@ -25,8 +25,97 @@
 #include <asm/pmac_feature.h>
 #endif
 
+/* For detecting supported PC laptops */
+#ifdef CONFIG_X86
+#include <linux/dmi.h>
+#endif
+
 #include "ati_ids.h"
 
+#ifdef CONFIG_X86
+/* This array holds a list of supported PC laptops.
+ * Currently only few IBM models are tested.
+ * If you want to experiment, use dmidecode to find out
+ * vendor and product codes for Your laptop.
+ */
+static struct dmi_system_id __devinitdata radeonfb_dmi_table[] = {
+	{
+		.ident = "IBM ThinkPad R40 (2722-B3G)",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "IBM"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "2722B3G"),
+		},
+	},
+	{
+		.ident = "IBM ThinkPad R51 (1829-9MG)",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "IBM"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "18299MG"),
+  	      },
+	},
+	{
+		.ident = "IBM ThinkPad T40 (2373-92G)",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "IBM"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "237392G"),
+  	      },
+	},
+	{
+		.ident = "IBM ThinkPad T40 (2373-8CG)",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "IBM"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "23738CG"),
+		},
+	},
+	{
+		.ident = "IBM ThinkPad T40 (2373-94U)",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "IBM"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "237394U"),
+		},
+	},
+	{
+		.ident = "IBM ThinkPad T40p (2373-G1U)",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "IBM"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "2373G1U"),
+		},
+	},
+	{
+		.ident = "IBM ThinkPad T41 (2373-2FG)",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "IBM"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "23732FG"),
+		},
+	},
+	{
+		.ident = "IBM ThinkPad T41 (2378-DEU)",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "IBM"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "2378DEU"),
+		},
+	},
+	{
+		/* Reported by Volker Braun <vbraun@physics.upenn.edu> */
+		.ident = "IBM ThinkPad T41 (2379-DJU)",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "IBM"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "2379DJU"),
+		},
+	},
+	{
+		.ident = "IBM ThinkPad T42 (2373-FWG)",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "IBM"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "2373FWG"),
+		},
+	},
+	{ },
+};
+
+extern int radeon_force_sleep;
+#endif
+
 void radeon_pm_disable_dynamic_mode(struct radeonfb_info *rinfo)
 {
 	u32 tmp;
@@ -853,6 +942,13 @@
 	tmp = INPLL( pllMCLK_MISC) | MCLK_MISC__EN_MCLK_TRISTATE_IN_SUSPEND;
 	OUTPLL( pllMCLK_MISC, tmp);
 	
+ 	/* BUS_CNTL1__MOBILE_PLATORM_SEL setting is northbridge chipset
+ 	 * and radeon chip dependent. Thus we only enable it on Mac for
+ 	 * now (until we get more info on how to compute the correct 
+ 	 * value for various X86 bridges).
+ 	 */
+ 
+#ifdef CONFIG_PPC_PMAC
 	/* AGP PLL control */
 	if (rinfo->family <= CHIP_FAMILY_RV280) {
 		OUTREG(BUS_CNTL1, INREG(BUS_CNTL1) |  BUS_CNTL1__AGPCLK_VALID);
@@ -864,6 +960,7 @@
 		OUTREG(BUS_CNTL1, INREG(BUS_CNTL1));
 		OUTREG(BUS_CNTL1, (INREG(BUS_CNTL1) & ~0x4000) | 0x8000);
 	}
+#endif
 
 	OUTREG(CRTC_OFFSET_CNTL, (INREG(CRTC_OFFSET_CNTL)
 				  & ~CRTC_OFFSET_CNTL__CRTC_STEREO_SYNC_OUT_EN));
@@ -2750,6 +2847,29 @@
 #endif
 	}
 #endif /* defined(CONFIG_PM) && defined(CONFIG_PPC_OF) */
+
+/* The PM code also works on some PC laptops.
+ * Only a few models are actually tested so Your mileage may vary.
+ * We can do D2 on at least M7 and M9 on some IBM ThinkPad T41 models.
+ */
+#if defined(CONFIG_PM) && defined(CONFIG_X86)
+	if (radeon_force_sleep || dmi_check_system(radeonfb_dmi_table)) {
+		if (radeon_force_sleep)
+			printk("radeonfb: forcefully enabling sleep mode\n");
+		else
+			printk("radeonfb: enabling sleep mode\n");
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
+#endif /* defined(CONFIG_PM) && defined(CONFIG_X86) */
 }
 
 void radeonfb_pm_exit(struct radeonfb_info *rinfo)

--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=suspend-mem

#!/bin/bash

echo "--------" >> /tmp/suspend.log
echo "Suspending to memory..." >> /tmp/suspend.log
date >> /tmp/suspend.log
cat /proc/acpi/battery/BAT0/state >> /tmp/suspend.log


echo "7 blink" >/proc/acpi/ibm/led
echo "4 off" >/proc/acpi/ibm/led

/sbin/hotplug stop 

/sbin/hwclock --systohc

statedir=/root/s3/state
curcons=`fgconsole`
fuser /dev/tty$curcons 2>/dev/null|xargs ps -o comm= -p|grep -q X && chvt 2
cat /dev/vcsa >$statedir/vcsa
ethtool -s ethX wol d
sync
echo 3 >/proc/acpi/sleep

echo "Resuming... " >> /tmp/suspend.log
date >> /tmp/suspend.log
cat /proc/acpi/battery/BAT0/state >> /tmp/suspend.log

sync

/sbin/hwclock --hctosys

/sbin/hotplug start

echo "4 on" >/proc/acpi/ibm/led
echo "7 off" >/proc/acpi/ibm/led

vbetool post
vbetool vbestate restore <$statedir/vbe
cat $statedir/vcsa >/dev/vcsa
#rckbd restart
chvt $[curcons%6+1]
chvt $curcons

echo "Resume finished... " >> /tmp/suspend.log
date >> /tmp/suspend.log
cat /proc/acpi/battery/BAT0/state >> /tmp/suspend.log



--x+6KMIRAuhnl3hBn--
