Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267765AbUJNWdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267765AbUJNWdP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 18:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268001AbUJNWcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 18:32:06 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:11793 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S267765AbUJNW1V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 18:27:21 -0400
Date: Thu, 14 Oct 2004 23:27:19 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: "mobil@wodkahexe.de" <mobil@wodkahexe.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc4 No local APIC present or hardware disabled
In-Reply-To: <16750.23132.41441.649851@alkaid.it.uu.se>
Message-ID: <Pine.LNX.4.58L.0410142225160.25607@blysk.ds.pg.gda.pl>
References: <20041012195448.2eaabcea.mobil@wodkahexe.de>
 <Pine.LNX.4.58L.0410132311190.17462@blysk.ds.pg.gda.pl>
 <16750.23132.41441.649851@alkaid.it.uu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Oct 2004, Mikael Pettersson wrote:

> There are systems, such as the P3-based Dell Inspirons and Latitutes
> that caused the dmi blacklist to be implemented, that fail whether
> they're using APM or ACPI. So in the interest of consistency, we should
> either always automatically override the BIOS, requiring "nolapic" on
> broken systems, or never automatically override the BIOS, requiring
> "lapic" on systems that work but have stupid BIOSen.

 It's a pity another useful feature gets disfavored due to firmware bugs
in newer systems.

> None of this is ACPI-specific, so I don't like the idea of tying
> auto-enable/disable to ACPI.

 I hope I won't hit the length limit of the command line this way, sigh...

 Anyway, if this is going to stay in, I think code needs to be cleaned up
to get rid of dead bits and inaccurate comments.  Here's my proposal.  
Does it make sense?  I hope so.

  Maciej

patch-2.6.9-rc4-lapic-6
diff -up --recursive --new-file linux-2.6.9-rc4.macro/arch/i386/kernel/apic.c linux-2.6.9-rc4/arch/i386/kernel/apic.c
--- linux-2.6.9-rc4.macro/arch/i386/kernel/apic.c	2004-10-12 23:57:01.000000000 +0000
+++ linux-2.6.9-rc4/arch/i386/kernel/apic.c	2004-10-14 21:42:57.000000000 +0000
@@ -667,7 +667,7 @@ static int __init detect_init_APIC (void
 	u32 h, l, features;
 	extern void get_cpu_vendor(struct cpuinfo_x86*);
 
-	/* Disabled by DMI scan or kernel option? */
+	/* Disabled by kernel option? */
 	if (enable_local_apic < 0)
 		return -1;
 
@@ -681,8 +681,7 @@ static int __init detect_init_APIC (void
 			break;
 		goto no_apic;
 	case X86_VENDOR_INTEL:
-		if (boot_cpu_data.x86 == 6 ||
-		    (boot_cpu_data.x86 == 15 && (cpu_has_apic || enable_local_apic > 0)) ||
+		if (boot_cpu_data.x86 == 6 || boot_cpu_data.x86 == 15 ||
 		    (boot_cpu_data.x86 == 5 && cpu_has_apic))
 			break;
 		goto no_apic;
@@ -692,15 +691,20 @@ static int __init detect_init_APIC (void
 
 	if (!cpu_has_apic) {
 		/*
-		 * Over-ride BIOS and try to enable LAPIC
-		 * only if "lapic" specified
+		 * Over-ride BIOS and try to enable the local
+		 * APIC only if "lapic" specified.
 		 */
-		if (enable_local_apic != 1)
-			goto no_apic;
+		if (enable_local_apic <= 0) {
+			printk("Not enabling local APIC "
+			       "because of frequent BIOS bugs\n");
+			printk("You can enable it with \"lapic\"\n");
+			return -1;
+		}
 		/*
 		 * Some BIOSes disable the local APIC in the
 		 * APIC_BASE MSR. This can only be done in
-		 * software for Intel P6 and AMD K7 (Model > 1).
+		 * software for Intel P6, Intel P4 and AMD K7
+		 * (Model > 1).
 		 */
 		rdmsr(MSR_IA32_APICBASE, l, h);
 		if (!(l & MSR_IA32_APICBASE_ENABLE)) {
