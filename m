Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261268AbTCFXZE>; Thu, 6 Mar 2003 18:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261271AbTCFXZD>; Thu, 6 Mar 2003 18:25:03 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:18087 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S261268AbTCFXZA>; Thu, 6 Mar 2003 18:25:00 -0500
Date: Fri, 7 Mar 2003 00:32:28 +0100
From: Dominik Brodowski <linux@brodo.de>
To: CaT <cat@zip.com.au>
Cc: cpufreq@www.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.5.64 - cpu freq not turned on
Message-ID: <20030306233228.GK1016@brodo.de>
References: <20030306152616.GB432@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030306152616.GB432@zip.com.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Mar 07, 2003 at 02:26:16AM +1100, CaT wrote:
> There was a 2.5.x kernel that allowed me to use cpufreq with it but the
> recent ones just give me this message:
> 
> cpufreq: Intel(R) SpeedStep(TM) for this chipset not (yet) available.
> 
> Now I know it worked before cos I noticed it and played about with the 8
> speed steps I had available to me (and I thought I only had 2).

Actually, SpeedStep is (so far, Banias isn't out to the public market yet)
only 2 states. What you had running was probably the p4-clockmod driver for
Intel Pentium 4 processors. But that does only throttle the CPU, which
causes (at best) linear energy saving while real "speedstep" is much better
than that. You can see what cpufreq driver is loaded by cat'ting
scaling_driver in the cpufreq sysfs directory for that cpu. 

This directory moved in 2.5.64 - and that's why you probably think there was
some regression (in fact, there is, but patches to fix that are on their
way...) - the sysfs interface to cpufreq is now in 
/sys/devices/sys/cpu0/cpufreq/ 		or
/sys/class/cpu/cpufreq/cpu0/cpufreq/

> What information is needed about my chipset to make the code detect it
> properly?

lspci -- maybe it's a ich4-m southbridge, then the attached patch (also sent to
Linus a few moments ago) might help.

	Dominik

diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/speedstep.c linux/arch/i386/kernel/cpu/cpufreq/speedstep.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/speedstep.c	2003-03-06 21:56:18.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/speedstep.c	2003-03-06 21:57:07.000000000 +0100
@@ -29,6 +29,9 @@
 
 #include <asm/msr.h>
 
+#ifndef PCI_DEVICE_ID_INTEL_82801DB_12
+#define PCI_DEVICE_ID_INTEL_82801DB_12  0x24cc
+#endif
 
 /* speedstep_chipset:
  *   It is necessary to know which chipset is used. As accesses to 
@@ -40,7 +43,7 @@
 
 #define SPEEDSTEP_CHIPSET_ICH2M         0x00000002
 #define SPEEDSTEP_CHIPSET_ICH3M         0x00000003
-
+#define SPEEDSTEP_CHIPSET_ICH4M         0x00000004
 
 /* speedstep_processor
  */
@@ -106,6 +109,7 @@
 	switch (speedstep_chipset) {
 	case SPEEDSTEP_CHIPSET_ICH2M:
 	case SPEEDSTEP_CHIPSET_ICH3M:
+	case SPEEDSTEP_CHIPSET_ICH4M:
 		/* get PMBASE */
 		pci_read_config_dword(speedstep_chipset_dev, 0x40, &pmbase);
 		if (!(pmbase & 0x01))
@@ -166,6 +170,7 @@
 	switch (speedstep_chipset) {
 	case SPEEDSTEP_CHIPSET_ICH2M:
 	case SPEEDSTEP_CHIPSET_ICH3M:
+	case SPEEDSTEP_CHIPSET_ICH4M:
 		/* get PMBASE */
 		pci_read_config_dword(speedstep_chipset_dev, 0x40, &pmbase);
 		if (!(pmbase & 0x01))
@@ -245,6 +250,7 @@
 	switch (speedstep_chipset) {
 	case SPEEDSTEP_CHIPSET_ICH2M:
 	case SPEEDSTEP_CHIPSET_ICH3M:
+	case SPEEDSTEP_CHIPSET_ICH4M:
 	{
 		u16             value = 0;
 
@@ -277,6 +283,14 @@
 static unsigned int speedstep_detect_chipset (void)
 {
 	speedstep_chipset_dev = pci_find_subsys(PCI_VENDOR_ID_INTEL,
+			      PCI_DEVICE_ID_INTEL_82801DB_12, 
+			      PCI_ANY_ID,
+			      PCI_ANY_ID,
+			      NULL);
+	if (speedstep_chipset_dev)
+		return SPEEDSTEP_CHIPSET_ICH4M;
+
+	speedstep_chipset_dev = pci_find_subsys(PCI_VENDOR_ID_INTEL,
 			      PCI_DEVICE_ID_INTEL_82801CA_12, 
 			      PCI_ANY_ID,
 			      PCI_ANY_ID,
