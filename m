Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313336AbSDERwU>; Fri, 5 Apr 2002 12:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312988AbSDERwK>; Fri, 5 Apr 2002 12:52:10 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:15261 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S312986AbSDERwD>;
	Fri, 5 Apr 2002 12:52:03 -0500
Date: Fri, 5 Apr 2002 19:52:00 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200204051752.TAA02715@harpo.it.uu.se>
To: chris@jakdaw.org
Subject: Re: P4/i845 Strange clock drifting
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Apr 2002 13:28:10 +0100, Chris Wilson wrote:
>I've now tried a couple more kernels to no avail - nothing can find APICs.
>Is it even possible for a P4 to not have a local APIC? System is a
>supermicro 5012B*. 
>
>/proc/cpuinfo shows:
>
>flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
>
>(notice no "apic"). Is this normal/correct? If just just removed the check
>from apic.c and tried to enable the apic anyway then are bad things going
>to happen? 

Your P4 does contain a local APIC, but your BIOS chose to disable it.
The following patch should (re)enable it:

--- linux-2.5.7/arch/i386/kernel/apic.c.~1~	Sat Mar  9 12:53:12 2002
+++ linux-2.5.7/arch/i386/kernel/apic.c	Fri Apr  5 19:35:14 2002
@@ -603,7 +603,7 @@
 		goto no_apic;
 	case X86_VENDOR_INTEL:
 		if (boot_cpu_data.x86 == 6 ||
-		    (boot_cpu_data.x86 == 15 && cpu_has_apic) ||
+		    boot_cpu_data.x86 == 15 ||
 		    (boot_cpu_data.x86 == 5 && cpu_has_apic))
 			break;
 		goto no_apic;
@@ -615,7 +615,7 @@
 		/*
 		 * Some BIOSes disable the local APIC in the
 		 * APIC_BASE MSR. This can only be done in
-		 * software for Intel P6 and AMD K7 (Model > 1).
+		 * software for Intel P6/P4 and AMD K7 (Model > 1).
 		 */
 		rdmsr(MSR_IA32_APICBASE, l, h);
 		if (!(l & MSR_IA32_APICBASE_ENABLE)) {

This should work (and is known to work on many P6 and K7 boards),
but your BIOS may have problems with the local APIC.
- does apm --suspend work? does the resume afterwards work?
- if you run something compute-intensive for a while, does it
  continue working ok or does it hang suddenly?
If your box remained stable, great!

If it experienced problems like unexpected hangs, then we'll need to
prevent the local APIC from being enabled on this mainboard.
In this case, please apply the patch below, reconfigure without
local APIC support, rebuild and send me (not the list) the DMI strings
printed during boot -- or the entire boot log if you're not certain
which parts are the DMI strings.

/Mikael

--- linux-2.5.7/arch/i386/kernel/dmi_scan.c.~1~	Tue Mar 19 01:10:03 2002
+++ linux-2.5.7/arch/i386/kernel/dmi_scan.c	Fri Apr  5 19:35:33 2002
@@ -21,8 +21,8 @@
 	u16	handle;
 };
 
-#define dmi_printk(x)
-//#define dmi_printk(x) printk x
+//#define dmi_printk(x)
+#define dmi_printk(x) printk x
 
 static char * __init dmi_string(struct dmi_header *dm, u8 s)
 {
