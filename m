Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129610AbRAKM6F>; Thu, 11 Jan 2001 07:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131546AbRAKM5z>; Thu, 11 Jan 2001 07:57:55 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:49878 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S131542AbRAKM5t>;
	Thu, 11 Jan 2001 07:57:49 -0500
Date: Thu, 11 Jan 2001 13:56:32 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200101111256.NAA07824@harpo.it.uu.se>
To: dwmw2@infradead.org, mingo@redhat.com
Subject: Re: Oops in 2.4.0-ac5
Cc: alan@lxorguk.ukuu.org.uk, faceprint@faceprint.com, grobh@sun.ac.za,
        kaos@ocs.com.au, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:

>mingo@redhat.com said:
>>  i prefer clear oopses and bug reports instead of ignoring them. A
>> failed MSR write is not something to be taken easily. MSR writes if
>> fail mean that there is a serious kernel bug - we want to stop the
>> kernel and complain ASAP. And correct code will be much more readable
>> that way.
>
>The bug here seems to be that we're using the same bit (X86_FEATURE_APIC) to
>report two _different_ features. 
>
>We don't represent X86_FEATURE_CXMMX and X86_FEATURE_MMX with the same bit, 
>even though they are supposed to provide the same functionality - because 
>they are in fact different. Likewise we shouldn't use the same bit for the 
>two different types of APIC, IMO.

No, both workarounds are wrong, IMNSHO. The local APIC feature flag
isn't the problem, it's the kernel which at one point incorrectly
deduces "use Intel P6 MSRs" from "local APIC enabled".

The correct fix is to qualify the deduction using boot_cpu_data.
Patch below against -ac6.

/Mikael

--- linux-2.4.0-ac6/arch/i386/kernel/nmi.c.~1~	Thu Jan 11 13:18:33 2001
+++ linux-2.4.0-ac6/arch/i386/kernel/nmi.c	Thu Jan 11 13:31:11 2001
@@ -84,6 +84,14 @@
 {
 	int value;
 
+	/* bail out if we're not on a P6 -- this code doesn't
+	   yet work on K7s */
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL ||
+	    boot_cpu_data.x86 != 6) {
+		nmi_watchdog = NMI_NONE;
+		return;
+	}
+
 	/* clear performance counters 0, 1 */
 
 	wrmsr(MSR_IA32_EVNTSEL0, 0, 0);
--- linux-2.4.0-ac6/arch/i386/kernel/setup.c.~1~	Thu Jan 11 13:18:33 2001
+++ linux-2.4.0-ac6/arch/i386/kernel/setup.c	Thu Jan 11 13:25:26 2001
@@ -1911,13 +1911,6 @@
 		      (int *)&c->x86_vendor_id[4]);
 		
 		get_cpu_vendor(c);
-		/*
-		 * Athlons have an APIC, but the APIC-programming
-		 * MSRs are in different places. If you want NMI-watchdog
-		 * on Athlons, please fix setup_apic_nmi_watchdog().
-		 */
-		if (c->x86_vendor == X86_VENDOR_AMD)
-			clear_bit(X86_FEATURE_APIC, &c->x86_capability);
 
 		/* Initialize the standard set of capabilities */
 		/* Note that the vendor-specific code below might override */
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
