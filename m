Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbUCCXKm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 18:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbUCCXKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 18:10:42 -0500
Received: from gprs40-129.eurotel.cz ([160.218.40.129]:31558 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261248AbUCCXKM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 18:10:12 -0500
Date: Thu, 4 Mar 2004 00:09:59 +0100
From: Pavel Machek <pavel@suse.cz>
To: Dave Jones <davej@redhat.com>,
       Cpufreq mailing list <cpufreq@www.linux.org.uk>,
       kernel list <linux-kernel@vger.kernel.org>, davej@codemonkey.ork.uk,
       paul.devriendt@amd.com
Subject: Re: powernow-k8-acpi driver
Message-ID: <20040303230958.GG222@elf.ucw.cz>
References: <20040303215435.GA467@elf.ucw.cz> <20040303222712.GA16874@redhat.com> <20040303223510.GE222@elf.ucw.cz> <20040303224841.GB16874@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040303224841.GB16874@redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  > We could make that functionality depend on CONFIG_ACPI, and allow
>  > runtime selection only if its defined... But those two drivers are
>  > pretty different just now and acpi-dependend chunk is pretty big. (It
>  > does funny stuff like polling for AC plug removal if we are in
>  > high-power state  and battery would not handle that. Old driver simply
>  > refused to use high-power states on such machines.)
> 
> you're aware of Dominik/Bruno's work on the 'acpilib'[1] stuff in this
> area right ? We'll need that anyway for Powernow-k7 and maybe longhaul too
> and its senseless duplicating this code.
> 
> One thing is bugging me though. Whats wrong with the ACPI P-state cpufreq
> driver ? Does that not work these days ? It's been a long time since I
> even looked at it.

Paul, could you apply this? It fixes some typo (Dave's address was
wrong), and makes header file closer to current version. No code
changes.

							Pavel

--- tmp/linux/arch/i386/kernel/cpu/cpufreq/powernow-k8-acpi.c	2004-03-04 00:01:58.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/powernow-k8-acpi.c	2004-03-03 23:39:28.000000000 +0100
@@ -11,7 +11,7 @@
  *  Support : paul.devriendt@amd.com
  *
  *  Based on the powernow-k7.c module written by Dave Jones.
- *  (c) 2003 Dave Jones <davej@codemonkey.ork.uk> on behalf of SuSE Labs
+ *  (c) 2003 Dave Jones <davej@codemonkey.org.uk> on behalf of SuSE Labs
  *  Licensed under the terms of the GNU GPL License version 2.
  *  Based upon datasheets & sample CPUs kindly provided by AMD.
  *
--- tmp/linux/arch/i386/kernel/cpu/cpufreq/powernow-k8-acpi.h	2004-03-04 00:01:58.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/powernow-k8-acpi.h	2004-03-03 23:57:18.000000000 +0100
@@ -28,7 +28,7 @@
 #define MSR_C_HI_STP_GNT_BENIGN   1
 
 /* status MSR - low part */
-#define MSR_S_LO_CHANGE_PENDING   0x80000000 /* cleared when completed */
+#define MSR_S_LO_CHANGE_PENDING   0x80000000   /* cleared when completed */
 #define MSR_S_LO_MAX_RAMP_VID     0x1f000000
 #define MSR_S_LO_MAX_FID          0x003f0000
 #define MSR_S_LO_START_FID        0x00003f00
@@ -54,12 +54,13 @@
 #define MIN_FREQ 800
 #define MAX_FREQ 5000
 
-#define INVALID_FID_MASK 0xc1
-#define INVALID_VID_MASK 0xe0
+#define INVALID_FID_MASK 0xffffffc1  /* not a valid fid if these bits are set */
+#define INVALID_VID_MASK 0xffffffe0  /* not a valid vid if these bits are set */
+
 
 #define STOP_GRANT_5NS    1 /* min memory access latency for voltage change   */
 #define MAXIMUM_VID_STEPS 1 /* Current cpus only allow a single step of 25mV  */
-#define VST_UNITS_20US   20 /* Voltage Stabalization Time is in units of 20us */
+#define VST_UNITS_20US   20 /* Voltage Stabilization Time is in units of 20us */
 
 #define PLL_LOCK_CONVERSION (1000/5) /* ms to ns, then divide by clock period */
 
@@ -117,7 +118,7 @@
 #define VID_MASK     0x1f
 #define FID_MASK     0x3f
 
-#define POW_AC  0  /* The power suppy states we care about - mains, battery,  */
+#define POW_AC  0  /* The power supply states we care about - mains, battery, */
 #define POW_BAT 1  /* or unknown, which presumably means that there is no     */
 #define POW_UNK 2  /* acpi support for the psr object, so there is no battery.*/
 
@@ -126,7 +127,7 @@
 #define POLLER_UNLOAD      2  /* are on mains power, at a high frequency, and */
 #define POLLER_DEAD        3  /* if there are battery restrictions.           */
 
-#define PFX "powernow-k8: "
+#define PFX "powernow-k8-acpi: "
 #define DFX KERN_DEBUG PFX
 #define IFX KERN_INFO  PFX
 #define EFX KERN_ERR   PFX


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
