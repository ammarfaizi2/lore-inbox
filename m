Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129294AbRBHFEx>; Thu, 8 Feb 2001 00:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129763AbRBHFEo>; Thu, 8 Feb 2001 00:04:44 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:38788 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S129294AbRBHFEi>;
	Thu, 8 Feb 2001 00:04:38 -0500
Date: Thu, 8 Feb 2001 06:04:18 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200102080504.GAA23507@harpo.it.uu.se>
To: hpa@transmeta.com, macro@ds2.pg.gda.pl
Subject: [PATCH] Re: UP APIC reenabling vs. cpu type detection ordering
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, vandrove@vc.cvut.cz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:

>"Maciej W. Rozycki" wrote:
>...
>>  It might be viable just to delete the test altogether, though and just
>> trap #GP(0) on the MSR access.  For the sake of simplicity.  If a problem
>> with a system ever arizes, we may handle it then.
>> 
>>  Note that we still have to choose appropriate vendor-specific PeMo
>> handling and an event for the NMI watchdog anyway.
>> 
>
>Right... if that is the case then it seems reasonable.

No, poking into MSRs not explicitly defined on the current CPU is
inherently unsafe. I have several x86 CPU data sheets here in front
of me which say the same thing: "Don't write to undocumented MSRs."
You cannot assume that every single x86 out there stays clear of
all Intel-defined MSRs. Intel has also expanded this set over time:
older designs may not even have known about the APIC_BASE MSR.

No, the problem we're facing here is a phase ordering issue.
There are actually several bugs lurking here:

1. identify_cpu() (and more importantly get_cpu_vendor()) is called
   very late (init/main.c's check_bugs()), while we obviously need
   that info much earlier. Thus, boot_cpu_data.x86_vendor is still
   uninitialised (zero by .bss) when we read it for the purpose of
   setting up the local APIC.

2. include/asm-i386/processor.h #defines X86_VENDOR_INTEL as 0.
   Thus, we may accidentally believe that the CPU is an Intel, if
   we read x86_vendor before identify_cpu() had done its deed.
   This explains why Petr Vandrovec's testing on K7 succeeded (the
   APIC-enabling code mistook his K7 for a P6). Change Intel's
   vendor id to something non-zero and you'll see that on
   UP P6 the local APIC doesn't get initialised.

3. init/main.c calls time_init() before check_bugs() and thus
   identify_cpu(). time_init() calls dodgy_tsc() which calls
   get_cpu_vendor(). However, get_cpu_vendor() only works on
   CPUID-enabled CPUs, so dodgy_tsc()'s call to init_cyrix()
   isn't guaranteed to happen. (init_cyrix() will be called later,
   but that may be too late.)
   Also, time_init() checks cpu_has_tsc, but since this is before
   identify_cpu() has done its thing, the capabilities are still
   the raw ones from head.S's CPUID calls.

4. The cpu detection code rewrite in 2.4.0-test<something>
   introduced a bug. The capabilities field was expanded from
   one to four words, which changed the starting offset of
   the vendor_id string. But the offsets in head.S weren't
   updated, causing head.S's initial vendor_id data to be stored
   in the wrong place. This hasn't been noticed yet since
   identify_cpu() does this work again correctly, but it does
   mean that calling get_cpu_vendor() before identify_cpu()
   doesn't work any more.

Below is a patch against 2.4.1-ac5 which fixes CPU detection
as far as the UP_APIC stuff is concerned. I had to add a
get_cpu_vendor() call to detect_init_APIC(), so that our
detection code gets a chance to work. I also fixed the field
ordering and offsets in processor.h and head.S. The resulting
kernel works ok on my UP P6.
(Petr: can you check that it still works on your K7?)

Ideally, identify_cpu() should be run before init_apic_mappings(),
but my attempts to do so has so far had some weird side-effects
(lost interrupts, incorrect bogomips, apparently stuck watchdog,
and keyboard timeouts), so I won't touch that stuff.

/Mikael

--- linux-2.4.1-ac5/arch/i386/kernel/apic.c.~1~	Thu Feb  8 02:01:39 2001
+++ linux-2.4.1-ac5/arch/i386/kernel/apic.c	Thu Feb  8 05:28:21 2001
@@ -388,21 +388,23 @@
 {
 	u32 h, l, dummy, features;
 
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL) {
-		printk("No APIC support for non-Intel processors.\n");
-		return -1;
-	}
+	get_cpu_vendor(&boot_cpu_data);
 
-	if (boot_cpu_data.x86 < 5) {
-		printk("No local APIC on pre-Pentium Intel processors.\n");
-		return -1;
+	switch (boot_cpu_data.x86_vendor) {
+	case X86_VENDOR_AMD:
+		if (boot_cpu_data.x86 == 6 && boot_cpu_data.x86_model > 1)
+			break;
+		goto no_apic;
+	case X86_VENDOR_INTEL:
+		if (boot_cpu_data.x86 == 6 ||
+		    (boot_cpu_data.x86 == 5 && cpu_has_apic))
+			break;
+		goto no_apic;
+	default:
+		goto no_apic;
 	}
 
 	if (!cpu_has_apic) {
-		if (boot_cpu_data.x86 == 5) {
-			printk("APIC turned off by hardware.\n");
-			return -1;
-		}
 		/*
 		 * Some BIOSes disable the local APIC in the
 		 * APIC_BASE MSR. This can only be done in
@@ -434,6 +436,10 @@
 	printk("Found and enabled local APIC!\n");
 
 	return 0;
+
+no_apic:
+	printk("No local APIC present or hardware disabled\n");
+	return -1;
 }
 
 void __init init_apic_mappings(void)
--- linux-2.4.1-ac5/arch/i386/kernel/head.S.~1~	Tue Dec 12 13:57:57 2000
+++ linux-2.4.1-ac5/arch/i386/kernel/head.S	Thu Feb  8 05:31:12 2001
@@ -33,8 +33,8 @@
 #define X86_MASK	CPU_PARAMS+3
 #define X86_HARD_MATH	CPU_PARAMS+6
 #define X86_CPUID	CPU_PARAMS+8
-#define X86_CAPABILITY	CPU_PARAMS+12
-#define X86_VENDOR_ID	CPU_PARAMS+16
+#define X86_VENDOR_ID	CPU_PARAMS+12
+#define X86_CAPABILITY	CPU_PARAMS+28
 
 /*
  * swapper_pg_dir is the main page directory, address 0x00101000
--- linux-2.4.1-ac5/include/asm-i386/processor.h.~1~	Thu Feb  8 02:01:44 2001
+++ linux-2.4.1-ac5/include/asm-i386/processor.h	Thu Feb  8 05:29:59 2001
@@ -39,8 +39,8 @@
 	char	hard_math;
 	char	rfu;
        	int	cpuid_level;	/* Maximum supported CPUID level, -1=no CPUID */
-	__u32	x86_capability[NCAPINTS];
 	char	x86_vendor_id[16];
+	__u32	x86_capability[NCAPINTS];
 	char	x86_model_id[64];
 	int 	x86_cache_size;  /* in KB - valid for CPUS which support this
 				    call  */
@@ -54,15 +54,17 @@
 	unsigned long pgtable_cache_sz;
 };
 
-#define X86_VENDOR_INTEL 0
-#define X86_VENDOR_CYRIX 1
-#define X86_VENDOR_AMD 2
-#define X86_VENDOR_UMC 3
-#define X86_VENDOR_NEXGEN 4
-#define X86_VENDOR_CENTAUR 5
-#define X86_VENDOR_RISE 6
-#define X86_VENDOR_TRANSMETA 7
-#define X86_VENDOR_UNKNOWN 0xff
+enum {
+	X86_VENDOR_UNKNOWN = 0, /* zero must be the "unknown" case */
+	X86_VENDOR_INTEL,
+	X86_VENDOR_CYRIX,
+	X86_VENDOR_AMD,
+	X86_VENDOR_UMC,
+	X86_VENDOR_NEXGEN,
+	X86_VENDOR_CENTAUR,
+	X86_VENDOR_RISE,
+	X86_VENDOR_TRANSMETA,
+};
 
 /*
  * capabilities of CPUs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
