Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751257AbVLPBIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbVLPBIg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 20:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbVLPBId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 20:08:33 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:53152 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751266AbVLPBIT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 20:08:19 -0500
Date: Thu, 15 Dec 2005 18:08:12 -0700
From: john stultz <johnstul@us.ibm.com>
To: akpm@osdl.org
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>, johnstul@us.ibm.com,
       john stultz <johnstul@us.ibm.com>
Message-Id: <20051216010802.19280.46938.sendpatchset@cog.beaverton.ibm.com>
In-Reply-To: <20051216010700.19280.66934.sendpatchset@cog.beaverton.ibm.com>
References: <20051216010700.19280.66934.sendpatchset@cog.beaverton.ibm.com>
Subject: [PATCH 8/11] Time: i386 Conversion - part 4: ACPI PM variable renaming and config change.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, All,
	The conversion of i386 to use the generic timeofday subsystem 
has been split into 6 parts. This patch, the fourth of six, renames 
some ACPI PM variables and removes the CONFIG_X86_PM_TIMER option. 

It applies on top of my timeofday-arch-i386-part3 patch. This patch is 
part the timeofday-arch-i386 patchset, so without the following parts 
it is not expected to compile.
	
Andrew, please consider for inclusion into your tree.

thanks
-john

Signed-off-by: John Stultz <johnstul@us.ibm.com>

 arch/i386/kernel/acpi/boot.c |   22 ++++++++++------------
 drivers/acpi/Kconfig         |   18 ------------------
 drivers/acpi/osl.c           |    2 --
 3 files changed, 10 insertions(+), 32 deletions(-)

linux-2.6.15-rc5_timeofday-arch-i386-part4_B14.patch
============================================
diff --git a/arch/i386/kernel/acpi/boot.c b/arch/i386/kernel/acpi/boot.c
index 447fa9e..e3318f4 100644
--- a/arch/i386/kernel/acpi/boot.c
+++ b/arch/i386/kernel/acpi/boot.c
@@ -608,9 +608,8 @@ static int __init acpi_parse_hpet(unsign
 #define	acpi_parse_hpet	NULL
 #endif
 
-#ifdef CONFIG_X86_PM_TIMER
-extern u32 pmtmr_ioport;
-#endif
+u32 acpi_pmtmr_ioport;
+int acpi_pmtmr_buggy;
 
 static int __init acpi_parse_fadt(unsigned long phys, unsigned long size)
 {
@@ -629,7 +628,6 @@ static int __init acpi_parse_fadt(unsign
 	acpi_fadt.force_apic_physical_destination_mode =
 	    fadt->force_apic_physical_destination_mode;
 
-#ifdef CONFIG_X86_PM_TIMER
 	/* detect the location of the ACPI PM Timer */
 	if (fadt->revision >= FADT2_REVISION_ID) {
 		/* FADT rev. 2 */
@@ -637,22 +635,22 @@ static int __init acpi_parse_fadt(unsign
 		    ACPI_ADR_SPACE_SYSTEM_IO)
 			return 0;
 
-		pmtmr_ioport = fadt->xpm_tmr_blk.address;
+		acpi_pmtmr_ioport = fadt->xpm_tmr_blk.address;
 		/*
 		 * "X" fields are optional extensions to the original V1.0
 		 * fields, so we must selectively expand V1.0 fields if the
 		 * corresponding X field is zero.
 	 	 */
-		if (!pmtmr_ioport)
-			pmtmr_ioport = fadt->V1_pm_tmr_blk;
+		if (!acpi_pmtmr_ioport)
+			acpi_pmtmr_ioport = fadt->V1_pm_tmr_blk;
 	} else {
 		/* FADT rev. 1 */
-		pmtmr_ioport = fadt->V1_pm_tmr_blk;
+		acpi_pmtmr_ioport = fadt->V1_pm_tmr_blk;
 	}
-	if (pmtmr_ioport)
-		printk(KERN_INFO PREFIX "PM-Timer IO Port: %#x\n",
-		       pmtmr_ioport);
-#endif
+
+	if (acpi_pmtmr_ioport)
+		printk(KERN_INFO PREFIX "PM-Timer IO Port: %#x\n", acpi_pmtmr_ioport);
+
 	return 0;
 }
 
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index fce21c2..45e6274 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -287,24 +287,6 @@ config ACPI_SYSTEM
 	  This driver will enable your system to shut down using ACPI, and
 	  dump your ACPI DSDT table using /proc/acpi/dsdt.
 
-config X86_PM_TIMER
-	bool "Power Management Timer Support"
-	depends on X86
-	depends on !X86_64
-	default y
-	help
-	  The Power Management Timer is available on all ACPI-capable,
-	  in most cases even if ACPI is unusable or blacklisted.
-
-	  This timing source is not affected by powermanagement features
-	  like aggressive processor idling, throttling, frequency and/or
-	  voltage scaling, unlike the commonly used Time Stamp Counter
-	  (TSC) timing source.
-
-	  So, if you see messages like 'Losing too many ticks!' in the
-	  kernel logs, and/or you are using this on a notebook which
-	  does not yet have an HPET, you should say "Y" here.
-
 config ACPI_CONTAINER
 	tristate "ACPI0004,PNP0A05 and PNP0A06 Container Driver (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index e3cd0b1..3f2021c 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -346,9 +346,7 @@ u64 acpi_os_get_timer(void)
 	/* TBD: use HPET if available */
 #endif
 
-#ifdef	CONFIG_X86_PM_TIMER
 	/* TBD: default to PM timer if HPET was not available */
-#endif
 	if (!t)
 		printk(KERN_ERR PREFIX "acpi_os_get_timer() TBD\n");
 
