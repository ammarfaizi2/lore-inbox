Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265366AbUEUErr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265366AbUEUErr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 00:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265394AbUEUErr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 00:47:47 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:60894 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S265366AbUEUEqG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 00:46:06 -0400
Date: Fri, 21 May 2004 00:46:54 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH][2.6-mm] Make i386 boot not so chatty
Message-ID: <Pine.LNX.4.58.0405210032160.2864@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch silences the default i386 boot by putting a lot of development
related printks under KERN_DEBUG loglevel, allowing the normal chatty mode
to be turned on by using the 'debug' kernel parameter. I have avoided
changing files which have external development repositories, like cpufreq and ACPI.

 arch/i386/kernel/apic.c               |   42 +++++++++++++++--------------
 arch/i386/kernel/apm.c                |   13 ++++-----
 arch/i386/kernel/bootflag.c           |    2 -
 arch/i386/kernel/cpu/amd.c            |   12 ++++----
 arch/i386/kernel/cpu/centaur.c        |   10 +++---
 arch/i386/kernel/cpu/common.c         |    8 ++---
 arch/i386/kernel/cpu/cyrix.c          |   12 ++++----
 arch/i386/kernel/cpu/intel.c          |   20 ++++++-------
 arch/i386/kernel/cpu/mcheck/k7.c      |    4 +-
 arch/i386/kernel/cpu/mcheck/p4.c      |    8 ++---
 arch/i386/kernel/cpu/mcheck/p5.c      |    4 +-
 arch/i386/kernel/cpu/mcheck/p6.c      |    4 +-
 arch/i386/kernel/cpu/mcheck/winchip.c |    2 -
 arch/i386/kernel/cpu/mtrr/cyrix.c     |    6 ++--
 arch/i386/kernel/cpu/mtrr/generic.c   |    4 +-
 arch/i386/kernel/cpu/mtrr/main.c      |   10 +++---
 arch/i386/kernel/cpu/transmeta.c      |    6 ++--
 arch/i386/kernel/dmi_scan.c           |   36 ++++++++++++------------
 arch/i386/kernel/efi.c                |   18 ++++++------
 arch/i386/kernel/io_apic.c            |   34 +++++++++++------------
 arch/i386/kernel/irq.c                |   17 +++++------
 arch/i386/kernel/mca.c                |    6 +---
 arch/i386/kernel/microcode.c          |    8 ++---
 arch/i386/kernel/mpparse.c            |   28 +++++++++----------
 arch/i386/kernel/nmi.c                |    2 -
 arch/i386/kernel/scx200.c             |    4 --
 arch/i386/kernel/setup.c              |    6 ++--
 arch/i386/kernel/smpboot.c            |   49 ++++++++++++++++++----------------
 arch/i386/kernel/summit.c             |    2 -
 arch/i386/kernel/time.c               |    5 +--
 arch/i386/mm/fault.c                  |    2 -
 arch/i386/mm/init.c                   |    6 ++--
 arch/i386/pci/acpi.c                  |    2 -
 arch/i386/pci/direct.c                |    4 +-
 arch/i386/pci/fixup.c                 |    2 -
 arch/i386/pci/irq.c                   |   26 +++++++++---------
 arch/i386/pci/legacy.c                |    8 ++---
 arch/i386/pci/mmconfig.c              |    2 -
 arch/i386/pci/pcbios.c                |    2 -
 arch/i386/pci/visws.c                 |    2 -
 include/asm-i386/bugs.h               |   10 +++---
 41 files changed, 222 insertions(+), 226 deletions(-)

Index: linux-2.6.6-mm4/arch/i386/kernel/apic.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.6-mm4/arch/i386/kernel/apic.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 apic.c
--- linux-2.6.6-mm4/arch/i386/kernel/apic.c	19 May 2004 12:28:16 -0000	1.1.1.1
+++ linux-2.6.6-mm4/arch/i386/kernel/apic.c	21 May 2004 02:55:39 -0000
@@ -162,7 +162,7 @@ void __init connect_bsp_APIC(void)
 		 * PIC mode, enable APIC mode in the IMCR, i.e.
 		 * connect BSP's local APIC to INT and NMI lines.
 		 */
-		printk("leaving PIC mode, enabling APIC mode.\n");
+		printk(KERN_DEBUG "leaving PIC mode, enabling APIC mode.\n");
 		outb(0x70, 0x22);
 		outb(0x01, 0x23);
 	}
@@ -178,7 +178,7 @@ void disconnect_bsp_APIC(void)
 		 * interrupts, including IPIs, won't work beyond
 		 * this point!  The only exception are INIT IPIs.
 		 */
-		printk("disabling APIC mode, entering PIC mode.\n");
+		printk(KERN_DEBUG "disabling APIC mode, entering PIC mode.\n");
 		outb(0x70, 0x22);
 		outb(0x00, 0x23);
 	}
@@ -416,10 +416,12 @@ void __init setup_local_APIC (void)
 	value = apic_read(APIC_LVT0) & APIC_LVT_MASKED;
 	if (!smp_processor_id() && (pic_mode || !value)) {
 		value = APIC_DM_EXTINT;
-		printk("enabled ExtINT on CPU#%d\n", smp_processor_id());
+		printk(KERN_DEBUG "enabled ExtINT on CPU#%d\n",
+			smp_processor_id());
 	} else {
 		value = APIC_DM_EXTINT | APIC_LVT_MASKED;
-		printk("masked ExtINT on CPU#%d\n", smp_processor_id());
+		printk(KERN_DEBUG "masked ExtINT on CPU#%d\n",
+			smp_processor_id());
 	}
 	apic_write_around(APIC_LVT0, value);

@@ -439,7 +441,8 @@ void __init setup_local_APIC (void)
 		if (maxlvt > 3)		/* Due to the Pentium erratum 3AP. */
 			apic_write(APIC_ESR, 0);
 		value = apic_read(APIC_ESR);
-		printk("ESR value before enabling vector: %08lx\n", value);
+		printk(KERN_DEBUG "ESR value before enabling vector: %08lx\n",
+			value);

 		value = ERROR_APIC_VECTOR;      // enables sending errors
 		apic_write_around(APIC_LVTERR, value);
@@ -449,7 +452,8 @@ void __init setup_local_APIC (void)
 		if (maxlvt > 3)
 			apic_write(APIC_ESR, 0);
 		value = apic_read(APIC_ESR);
-		printk("ESR value after enabling vector: %08lx\n", value);
+		printk(KERN_DEBUG "ESR value after enabling vector: %08lx\n",
+			value);
 	} else {
 		if (esr_disable)
 			/*
@@ -458,9 +462,9 @@ void __init setup_local_APIC (void)
 			 * ESR disabled - we can't do anything useful with the
 			 * errors anyway - mbligh
 			 */
-			printk("Leaving ESR disabled.\n");
+			printk(KERN_DEBUG "Leaving ESR disabled.\n");
 		else
-			printk("No ESR for 82489DX.\n");
+			printk(KERN_DEBUG "No ESR for 82489DX.\n");
 	}

 	if (nmi_watchdog == NMI_LOCAL_APIC)
@@ -660,7 +664,7 @@ static int __init detect_init_APIC (void
 		 */
 		rdmsr(MSR_IA32_APICBASE, l, h);
 		if (!(l & MSR_IA32_APICBASE_ENABLE)) {
-			printk("Local APIC disabled by BIOS -- reenabling.\n");
+			printk(KERN_DEBUG "Local APIC disabled by BIOS -- reenabling.\n");
 			l &= ~MSR_IA32_APICBASE_BASE;
 			l |= MSR_IA32_APICBASE_ENABLE | APIC_DEFAULT_PHYS_BASE;
 			wrmsr(MSR_IA32_APICBASE, l, h);
@@ -673,7 +677,7 @@ static int __init detect_init_APIC (void
 	 */
 	features = cpuid_edx(1);
 	if (!(features & (1 << X86_FEATURE_APIC))) {
-		printk("Could not enable APIC!\n");
+		printk(KERN_DEBUG "Could not enable APIC!\n");
 		return -1;
 	}
 	set_bit(X86_FEATURE_APIC, boot_cpu_data.x86_capability);
@@ -687,14 +691,14 @@ static int __init detect_init_APIC (void
 	if (nmi_watchdog != NMI_NONE)
 		nmi_watchdog = NMI_LOCAL_APIC;

-	printk("Found and enabled local APIC!\n");
+	printk(KERN_DEBUG "Found and enabled local APIC!\n");

 	apic_pm_activate();

 	return 0;

 no_apic:
-	printk("No local APIC present or hardware disabled\n");
+	printk(KERN_DEBUG "No local APIC present or hardware disabled\n");
 	return -1;
 }

@@ -883,7 +887,7 @@ int __init calibrate_APIC_clock(void)
 	int i;
 	const int LOOPS = HZ/10;

-	printk("calibrating APIC timer ...\n");
+	printk(KERN_DEBUG "calibrating APIC timer ...\n");

 	/*
 	 * Put whatever arbitrary (but long enough) timeout
@@ -928,11 +932,11 @@ int __init calibrate_APIC_clock(void)
 	result = (tt1-tt2)*APIC_DIVISOR/LOOPS;

 	if (cpu_has_tsc)
-		printk("..... CPU clock speed is %ld.%04ld MHz.\n",
+		printk(KERN_DEBUG "..... CPU clock speed is %ld.%04ld MHz.\n",
 			((long)(t2-t1)/LOOPS)/(1000000/HZ),
 			((long)(t2-t1)/LOOPS)%(1000000/HZ));

-	printk("..... host bus clock speed is %ld.%04ld MHz.\n",
+	printk(KERN_DEBUG "..... host bus clock speed is %ld.%04ld MHz.\n",
 		result/(1000000/HZ),
 		result%(1000000/HZ));

@@ -943,7 +947,7 @@ static unsigned int calibration_result;

 void __init setup_boot_APIC_clock(void)
 {
-	printk("Using local APIC timer interrupts.\n");
+	printk(KERN_DEBUG "Using local APIC timer interrupts.\n");
 	using_apic_timer = 1;

 	local_irq_disable();
@@ -1117,7 +1121,7 @@ asmlinkage void smp_spurious_interrupt(v
 		ack_APIC_irq();

 	/* see sw-dev-man vol 3, chapter 7.4.13.5 */
-	printk(KERN_INFO "spurious APIC interrupt on CPU#%d, should never happen.\n",
+	printk(KERN_ERR "spurious APIC interrupt on CPU#%d, should never happen.\n",
 			smp_processor_id());
 	irq_exit();
 }
@@ -1148,7 +1152,7 @@ asmlinkage void smp_error_interrupt(void
 	   6: Received illegal vector
 	   7: Illegal register address
 	*/
-	printk (KERN_INFO "APIC error on CPU%d: %02lx(%02lx)\n",
+	printk (KERN_ERR "APIC error on CPU%d: %02lx(%02lx)\n",
 	        smp_processor_id(), v , v1);
 	irq_exit();
 }
@@ -1169,7 +1173,7 @@ int __init APIC_init_uniprocessor (void)
 	 * Complain if the BIOS pretends there is one.
 	 */
 	if (!cpu_has_apic && APIC_INTEGRATED(apic_version[boot_cpu_physical_apicid])) {
-		printk(KERN_ERR "BIOS bug, local APIC #%d not detected!...\n",
+		printk(KERN_DEBUG "BIOS bug, local APIC #%d not detected!...\n",
 			boot_cpu_physical_apicid);
 		return -1;
 	}
Index: linux-2.6.6-mm4/arch/i386/kernel/apm.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.6-mm4/arch/i386/kernel/apm.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 apm.c
--- linux-2.6.6-mm4/arch/i386/kernel/apm.c	19 May 2004 12:28:16 -0000	1.1.1.1
+++ linux-2.6.6-mm4/arch/i386/kernel/apm.c	21 May 2004 02:20:16 -0000
@@ -1732,7 +1732,7 @@ static int apm(void *unused)
 	}

 	if (debug)
-		printk(KERN_INFO "apm: Connection version %d.%d\n",
+		printk(KERN_DEBUG "apm: Connection version %d.%d\n",
 			(apm_info.connection_version >> 8) & 0xff,
 			apm_info.connection_version & 0xff);

@@ -1900,18 +1900,17 @@ static int __init apm_init(void)
 	int ret;
 	int i;

-	if (apm_info.bios.version == 0) {
-		printk(KERN_INFO "apm: BIOS not found.\n");
+	if (apm_info.bios.version == 0)
 		return -ENODEV;
-	}
-	printk(KERN_INFO
+
+	printk(KERN_DEBUG
 		"apm: BIOS version %d.%d Flags 0x%02x (Driver version %s)\n",
 		((apm_info.bios.version >> 8) & 0xff),
 		(apm_info.bios.version & 0xff),
 		apm_info.bios.flags,
 		driver_version);
 	if ((apm_info.bios.flags & APM_32_BIT_SUPPORT) == 0) {
-		printk(KERN_INFO "apm: no 32 bit BIOS support\n");
+		printk(KERN_DEBUG "apm: no 32 bit BIOS support\n");
 		return -ENODEV;
 	}

@@ -1937,7 +1936,7 @@ static int __init apm_init(void)
 		apm_info.bios.cseg_16_len = 0; /* 64k */

 	if (debug) {
-		printk(KERN_INFO "apm: entry %x:%lx cseg16 %x dseg %x",
+		printk(KERN_DEBUG "apm: entry %x:%lx cseg16 %x dseg %x",
 			apm_info.bios.cseg, apm_info.bios.offset,
 			apm_info.bios.cseg_16, apm_info.bios.dseg);
 		if (apm_info.bios.version > 0x100)
Index: linux-2.6.6-mm4/arch/i386/kernel/bootflag.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.6-mm4/arch/i386/kernel/bootflag.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 bootflag.c
--- linux-2.6.6-mm4/arch/i386/kernel/bootflag.c	19 May 2004 12:28:16 -0000	1.1.1.1
+++ linux-2.6.6-mm4/arch/i386/kernel/bootflag.c	21 May 2004 02:28:44 -0000
@@ -48,7 +48,7 @@ static void __init sbf_write(u8 v)
 		if(!parity(v))
 			v|=SBF_PARITY;

-		printk(KERN_INFO "Simple Boot Flag at 0x%x set to 0x%x\n", sbf_port, v);
+		printk(KERN_DEBUG "Simple Boot Flag at 0x%x set to 0x%x\n", sbf_port, v);

 		spin_lock_irqsave(&rtc_lock, flags);
 		CMOS_WRITE(v, sbf_port);
Index: linux-2.6.6-mm4/arch/i386/kernel/dmi_scan.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.6-mm4/arch/i386/kernel/dmi_scan.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 dmi_scan.c
--- linux-2.6.6-mm4/arch/i386/kernel/dmi_scan.c	19 May 2004 12:28:16 -0000	1.1.1.1
+++ linux-2.6.6-mm4/arch/i386/kernel/dmi_scan.c	21 May 2004 01:44:12 -0000
@@ -123,13 +123,13 @@ static int __init dmi_iterate(void (*dec
 			 * the SMBIOS version, which we don't know at this point.
 			 */
 			if(buf[14]!=0)
-				printk(KERN_INFO "DMI %d.%d present.\n",
+				printk(KERN_DEBUG "DMI %d.%d present.\n",
 					buf[14]>>4, buf[14]&0x0F);
 			else
-				printk(KERN_INFO "DMI present.\n");
-			dmi_printk((KERN_INFO "%d structures occupying %d bytes.\n",
+				printk(KERN_DEBUG "DMI present.\n");
+			dmi_printk((KERN_DEBUG "%d structures occupying %d bytes.\n",
 				num, len));
-			dmi_printk((KERN_INFO "DMI table at 0x%08X.\n",
+			dmi_printk((KERN_DEBUG "DMI table at 0x%08X.\n",
 				base));
 			if(dmi_table(base,len, num, decode)==0)
 				return 0;
@@ -211,7 +211,7 @@ static __init int set_bios_reboot(struct
 	if (reboot_thru_bios == 0)
 	{
 		reboot_thru_bios = 1;
-		printk(KERN_INFO "%s series board detected. Selecting BIOS-method for reboots.\n", d->ident);
+		printk(KERN_DEBUG "%s series board detected. Selecting BIOS-method for reboots.\n", d->ident);
 	}
 	return 0;
 }
@@ -226,7 +226,7 @@ static __init int set_smp_reboot(struct
 	if (reboot_smp == 0)
 	{
 		reboot_smp = 1;
-		printk(KERN_INFO "%s series board detected. Selecting SMP-method for reboots.\n", d->ident);
+		printk(KERN_DEBUG "%s series board detected. Selecting SMP-method for reboots.\n", d->ident);
 	}
 #endif
 	return 0;
@@ -251,7 +251,7 @@ static __init int set_realmode_power_off
        if (apm_info.realmode_power_off == 0)
        {
                apm_info.realmode_power_off = 1;
-               printk(KERN_INFO "%s bios detected. Using realmode poweroff only.\n", d->ident);
+               printk(KERN_DEBUG "%s bios detected. Using realmode poweroff only.\n", d->ident);
        }
        return 0;
 }
@@ -266,7 +266,7 @@ static __init int set_apm_ints(struct dm
 	if (apm_info.allow_ints == 0)
 	{
 		apm_info.allow_ints = 1;
-		printk(KERN_INFO "%s machine detected. Enabling interrupts during APM calls.\n", d->ident);
+		printk(KERN_DEBUG "%s machine detected. Enabling interrupts during APM calls.\n", d->ident);
 	}
 	return 0;
 }
@@ -280,7 +280,7 @@ static __init int apm_is_horked(struct d
 	if (apm_info.disabled == 0)
 	{
 		apm_info.disabled = 1;
-		printk(KERN_INFO "%s machine detected. Disabling APM.\n", d->ident);
+		printk(KERN_DEBUG "%s machine detected. Disabling APM.\n", d->ident);
 	}
 	return 0;
 }
@@ -289,9 +289,9 @@ static __init int apm_is_horked_d850md(s
 {
 	if (apm_info.disabled == 0) {
 		apm_info.disabled = 1;
-		printk(KERN_INFO "%s machine detected. Disabling APM.\n", d->ident);
-		printk(KERN_INFO "This bug is fixed in bios P15 which is available for \n");
-		printk(KERN_INFO "download from support.intel.com \n");
+		printk(KERN_DEBUG "%s machine detected. Disabling APM.\n", d->ident);
+		printk(KERN_DEBUG "This bug is fixed in bios P15 which is available for \n");
+		printk(KERN_DEBUG "download from support.intel.com \n");
 	}
 	return 0;
 }
@@ -304,7 +304,7 @@ static __init int apm_likes_to_melt(stru
 {
 	if (apm_info.forbid_idle == 0) {
 		apm_info.forbid_idle = 1;
-		printk(KERN_INFO "%s machine detected. Disabling APM idle calls.\n", d->ident);
+		printk(KERN_DEBUG "%s machine detected. Disabling APM idle calls.\n", d->ident);
 	}
 	return 0;
 }
@@ -337,7 +337,7 @@ static __init int disable_smbus(struct d
 {
 	if (is_unsafe_smbus == 0) {
 		is_unsafe_smbus = 1;
-		printk(KERN_INFO "%s machine detected. Disabling SMBus accesses.\n", d->ident);
+		printk(KERN_DEBUG "%s machine detected. Disabling SMBus accesses.\n", d->ident);
 	}
 	return 0;
 }
@@ -353,7 +353,7 @@ static __init int fix_broken_hp_bios_irq
 	if (broken_hp_bios_irq9 == 0)
 	{
 		broken_hp_bios_irq9 = 1;
-		printk(KERN_INFO "%s detected - fixing broken IRQ routing\n", d->ident);
+		printk(KERN_DEBUG "%s detected - fixing broken IRQ routing\n", d->ident);
 	}
 #endif
 	return 0;
@@ -395,7 +395,7 @@ static __init int sony_vaio_laptop(struc
 	if (is_sony_vaio_laptop == 0)
 	{
 		is_sony_vaio_laptop = 1;
-		printk(KERN_INFO "%s laptop detected.\n", d->ident);
+		printk(KERN_DEBUG "%s laptop detected.\n", d->ident);
 	}
 	return 0;
 }
@@ -461,7 +461,7 @@ static __init int reset_videomode_after_

 static __init int broken_ps2_resume(struct dmi_blacklist *d)
 {
-	printk(KERN_INFO "%s machine detected. Mousepad Resume Bug workaround hopefully not needed.\n", d->ident);
+	printk(KERN_DEBUG "%s machine detected. Mousepad Resume Bug workaround hopefully not needed.\n", d->ident);
 	return 0;
 }

@@ -1152,7 +1152,7 @@ void __init dmi_scan_machine(void)
 	if(err == 0)
 		dmi_check_blacklist();
 	else
-		printk(KERN_INFO "DMI not present.\n");
+		printk(KERN_DEBUG "DMI not present.\n");
 }

 EXPORT_SYMBOL(is_unsafe_smbus);
Index: linux-2.6.6-mm4/arch/i386/kernel/efi.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.6-mm4/arch/i386/kernel/efi.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 efi.c
--- linux-2.6.6-mm4/arch/i386/kernel/efi.c	19 May 2004 12:28:16 -0000	1.1.1.1
+++ linux-2.6.6-mm4/arch/i386/kernel/efi.c	21 May 2004 02:21:34 -0000
@@ -247,7 +247,7 @@ void __init print_efi_memmap(void)

 	for (i = 0; i < memmap.nr_map; i++) {
 		md = &memmap.map[i];
-		printk(KERN_INFO "mem%02u: type=%u, attr=0x%llx, "
+		printk(KERN_DEBUG "mem%02u: type=%u, attr=0x%llx, "
 			"range=[0x%016llx-0x%016llx) (%lluMB)\n",
 			i, md->type, md->attribute, md->phys_addr,
 			md->phys_addr + (md->num_pages << EFI_PAGE_SHIFT),
@@ -284,7 +284,7 @@ void efi_memmap_walk(efi_freemem_callbac
 			prev_valid = 1;
 		} else {
 			if (curr.start < prev.start)
-				printk(KERN_INFO PFX "Unordered memory map\n");
+				printk(KERN_DEBUG PFX "Unordered memory map\n");
 			if (prev.end == curr.start)
 				prev.end = curr.end;
 			else {
@@ -359,7 +359,7 @@ void __init efi_init(void)
 	} else
 		printk(KERN_ERR PFX "Could not map the firmware vendor!\n");

-	printk(KERN_INFO PFX "EFI v%u.%.02u by %s \n",
+	printk(KERN_DEBUG PFX "EFI v%u.%.02u by %s \n",
 	       efi.systab->hdr.revision >> 16,
 	       efi.systab->hdr.revision & 0xffff, vendor);

@@ -376,27 +376,27 @@ void __init efi_init(void)
 	for (i = 0; i < num_config_tables; i++) {
 		if (efi_guidcmp(config_tables[i].guid, MPS_TABLE_GUID) == 0) {
 			efi.mps = (void *)config_tables[i].table;
-			printk(KERN_INFO " MPS=0x%lx ", config_tables[i].table);
+			printk(KERN_DEBUG " MPS=0x%lx ", config_tables[i].table);
 		} else
 		    if (efi_guidcmp(config_tables[i].guid, ACPI_20_TABLE_GUID) == 0) {
 			efi.acpi20 = __va(config_tables[i].table);
-			printk(KERN_INFO " ACPI 2.0=0x%lx ", config_tables[i].table);
+			printk(KERN_DEBUG " ACPI 2.0=0x%lx ", config_tables[i].table);
 		} else
 		    if (efi_guidcmp(config_tables[i].guid, ACPI_TABLE_GUID) == 0) {
 			efi.acpi = __va(config_tables[i].table);
-			printk(KERN_INFO " ACPI=0x%lx ", config_tables[i].table);
+			printk(KERN_DEBUG " ACPI=0x%lx ", config_tables[i].table);
 		} else
 		    if (efi_guidcmp(config_tables[i].guid, SMBIOS_TABLE_GUID) == 0) {
 			efi.smbios = (void *) config_tables[i].table;
-			printk(KERN_INFO " SMBIOS=0x%lx ", config_tables[i].table);
+			printk(KERN_DEBUG " SMBIOS=0x%lx ", config_tables[i].table);
 		} else
 		    if (efi_guidcmp(config_tables[i].guid, HCDP_TABLE_GUID) == 0) {
 			efi.hcdp = (void *)config_tables[i].table;
-			printk(KERN_INFO " HCDP=0x%lx ", config_tables[i].table);
+			printk(KERN_DEBUG " HCDP=0x%lx ", config_tables[i].table);
 		} else
 		    if (efi_guidcmp(config_tables[i].guid, UGA_IO_PROTOCOL_GUID) == 0) {
 			efi.uga = (void *)config_tables[i].table;
-			printk(KERN_INFO " UGA=0x%lx ", config_tables[i].table);
+			printk(KERN_DEBUG " UGA=0x%lx ", config_tables[i].table);
 		}
 	}
 	printk("\n");
Index: linux-2.6.6-mm4/arch/i386/kernel/io_apic.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.6-mm4/arch/i386/kernel/io_apic.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 io_apic.c
--- linux-2.6.6-mm4/arch/i386/kernel/io_apic.c	19 May 2004 12:28:16 -0000	1.1.1.1
+++ linux-2.6.6-mm4/arch/i386/kernel/io_apic.c	21 May 2004 02:57:00 -0000
@@ -660,7 +660,6 @@ static int __init balanced_irq_init(void
 		memset(irq_cpu_data[i].last_irq,0,sizeof(unsigned long) * NR_IRQS);
 	}

-	printk(KERN_INFO "Starting balanced_irq\n");
 	if (kernel_thread(balanced_irq, NULL, CLONE_KERNEL) >= 0)
 		return 0;
 	else
@@ -745,7 +744,7 @@ static int __init ioapic_pirq_setup(char
 		pirq_entries[i] = -1;

 	pirqs_enabled = 1;
-	printk(KERN_INFO "PIRQ redirection, working around broken MP-BIOS.\n");
+	printk(KERN_DEBUG "PIRQ redirection, working around broken MP-BIOS.\n");
 	max = MAX_PIRQS;
 	if (ints[0] < MAX_PIRQS)
 		max = ints[0];
@@ -815,7 +814,7 @@ int IO_APIC_get_PCI_irq_vector(int bus,
 	Dprintk("querying PCI -> IRQ mapping bus:%d, slot:%d, pin:%d.\n",
 		bus, slot, pin);
 	if (mp_bus_id_to_pci_bus[bus] == -1) {
-		printk(KERN_WARNING "PCI BIOS passed nonexistent PCI bus %d!\n", bus);
+		printk(KERN_DEBUG "PCI BIOS passed nonexistent PCI bus %d!\n", bus);
 		return -1;
 	}
 	for (i = 0; i < mp_irq_entries; i++) {
@@ -881,7 +880,7 @@ static int __init EISA_ELCR(unsigned int
 		unsigned int port = 0x4d0 + (irq >> 3);
 		return (inb(port) >> (irq & 7)) & 1;
 	}
-	printk(KERN_INFO "Broken MPtable reports ISA irq %d\n", irq);
+	printk(KERN_DEBUG "Broken MPtable reports ISA irq %d\n", irq);
 	return 0;
 }

@@ -1348,7 +1347,7 @@ void __init print_IO_APIC(void)
 	 * We are a bit conservative about what we expect.  We have to
 	 * know about every hardware change ASAP.
 	 */
-	printk(KERN_INFO "testing the IO APIC.......................\n");
+	printk(KERN_DEBUG "testing the IO APIC.......................\n");

 	for (apic = 0; apic < nr_ioapics; apic++) {

@@ -1466,7 +1465,7 @@ void __init print_IO_APIC(void)
 		printk("\n");
 	}

-	printk(KERN_INFO ".................................... done.\n");
+	printk(KERN_DEBUG ".................................... done.\n");

 	return;
 }
@@ -1496,9 +1495,9 @@ void /*__init*/ print_local_APIC(void *
 	printk("\n" KERN_DEBUG "printing local APIC contents on CPU#%d/%d:\n",
 		smp_processor_id(), hard_smp_processor_id());
 	v = apic_read(APIC_ID);
-	printk(KERN_INFO "... APIC ID:      %08x (%01x)\n", v, GET_APIC_ID(v));
+	printk(KERN_DEBUG "... APIC ID:      %08x (%01x)\n", v, GET_APIC_ID(v));
 	v = apic_read(APIC_LVR);
-	printk(KERN_INFO "... APIC VERSION: %08x\n", v);
+	printk(KERN_DEBUG "... APIC VERSION: %08x\n", v);
 	ver = GET_APIC_VERSION(v);
 	maxlvt = get_maxlvt();

@@ -1715,7 +1714,8 @@ static void __init setup_ioapic_ids_from
 		} else {
 			physid_mask_t tmp;
 			tmp = apicid_to_cpu_present(mp_ioapics[apic].mpc_apicid);
-			printk("Setting %d in the phys_id_present_map\n", mp_ioapics[apic].mpc_apicid);
+			printk(KERN_DEBUG "Setting %d in the phys_id_present_map\n",
+				mp_ioapics[apic].mpc_apicid);
 			physids_or(phys_id_present_map, phys_id_present_map, tmp);
 		}

@@ -1734,7 +1734,7 @@ static void __init setup_ioapic_ids_from
 		 * Read the right value from the MPC table and
 		 * write it into the ID register.
 	 	 */
-		printk(KERN_INFO "...changing IO-APIC physical APIC ID to %d ...",
+		printk(KERN_DEBUG "...changing IO-APIC physical APIC ID to %d ...",
 					mp_ioapics[apic].mpc_apicid);

 		reg_00.bits.ID = mp_ioapics[apic].mpc_apicid;
@@ -2085,7 +2085,7 @@ static void setup_nmi (void)
 	 * is from Maciej W. Rozycki - so we do not have to EOI from
 	 * the NMI handler or the timer interrupt.
 	 */
-	printk(KERN_INFO "activating NMI Watchdog ...");
+	printk(KERN_DEBUG "activating NMI Watchdog ...");

 	on_each_cpu(enable_NMI_through_LVT0, NULL, 1, 1);

@@ -2187,7 +2187,7 @@ static inline void check_timer(void)
 	pin1 = find_isa_irq_pin(0, mp_INT);
 	pin2 = find_isa_irq_pin(0, mp_ExtINT);

-	printk(KERN_INFO "..TIMER: vector=0x%02X pin1=%d pin2=%d\n", vector, pin1, pin2);
+	printk(KERN_DEBUG "..TIMER: vector=0x%02X pin1=%d pin2=%d\n", vector, pin1, pin2);

 	if (pin1 != -1) {
 		/*
@@ -2207,7 +2207,7 @@ static inline void check_timer(void)
 		printk(KERN_ERR "..MP-BIOS bug: 8254 timer not connected to IO-APIC\n");
 	}

-	printk(KERN_INFO "...trying to set up timer (IRQ0) through the 8259A ... ");
+	printk(KERN_DEBUG "...trying to set up timer (IRQ0) through the 8259A ... ");
 	if (pin2 != -1) {
 		printk("\n..... (found pin %d) ...", pin2);
 		/*
@@ -2238,7 +2238,7 @@ static inline void check_timer(void)
 		nmi_watchdog = 0;
 	}

-	printk(KERN_INFO "...trying to set up timer as Virtual Wire IRQ...");
+	printk(KERN_DEBUG "...trying to set up timer as Virtual Wire IRQ...");

 	disable_8259A_irq(0);
 	irq_desc[0].handler = &lapic_irq_type;
@@ -2252,7 +2252,7 @@ static inline void check_timer(void)
 	apic_write_around(APIC_LVT0, APIC_LVT_MASKED | APIC_DM_FIXED | vector);
 	printk(" failed.\n");

-	printk(KERN_INFO "...trying to set up timer as ExtINT IRQ...");
+	printk(KERN_DEBUG "...trying to set up timer as ExtINT IRQ...");

 	timer_ack = 0;
 	init_8259A(0);
@@ -2287,7 +2287,7 @@ void __init setup_IO_APIC(void)
 	else
 		io_apic_irqs = ~PIC_IRQS;

-	printk("ENABLING IO-APIC IRQs\n");
+	printk(KERN_DEBUG "ENABLING IO-APIC IRQs\n");

 	/*
 	 * Set up IO-APIC IRQ routing.
@@ -2390,7 +2390,7 @@ int __init io_apic_get_unique_id (int io
 			panic("IOAPIC[%d]: Unable change apic_id!\n", ioapic);
 	}

-	printk(KERN_INFO "IOAPIC[%d]: Assigned apic_id %d\n", ioapic, apic_id);
+	printk(KERN_DEBUG "IOAPIC[%d]: Assigned apic_id %d\n", ioapic, apic_id);

 	return apic_id;
 }
Index: linux-2.6.6-mm4/arch/i386/kernel/irq.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.6-mm4/arch/i386/kernel/irq.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 irq.c
--- linux-2.6.6-mm4/arch/i386/kernel/irq.c	19 May 2004 12:28:16 -0000	1.1.1.1
+++ linux-2.6.6-mm4/arch/i386/kernel/irq.c	21 May 2004 02:09:12 -0000
@@ -100,8 +100,7 @@ static void ack_none(unsigned int irq)
  * each architecture has to answer this themselves, it doesn't deserve
  * a generic callback i think.
  */
-#ifdef CONFIG_X86
-	printk("unexpected IRQ trap at vector %02x\n", irq);
+	printk(KERN_ERR "unexpected IRQ trap at vector %02x\n", irq);
 #ifdef CONFIG_X86_LOCAL_APIC
 	/*
 	 * Currently unexpected vectors happen only on SMP and APIC.
@@ -113,7 +112,6 @@ static void ack_none(unsigned int irq)
 	 */
 	ack_APIC_irq();
 #endif
-#endif
 }

 /* startup is the same as "enable", shutdown is same as "disable" */
@@ -271,7 +269,7 @@ static int noirqdebug;
 static int __init noirqdebug_setup(char *str)
 {
 	noirqdebug = 1;
-	printk("IRQ lockup detection disabled\n");
+	printk(KERN_DEBUG "IRQ lockup detection disabled\n");
 	return 1;
 }

@@ -400,7 +398,7 @@ void enable_irq(unsigned int irq)
 		desc->depth--;
 		break;
 	case 0:
-		printk("enable_irq(%u) unbalanced from %p\n", irq,
+		printk(KERN_DEBUG "enable_irq(%u) unbalanced from %p\n", irq,
 		       __builtin_return_address(0));
 	}
 	spin_unlock_irqrestore(&desc->lock, flags);
@@ -438,7 +436,7 @@ asmlinkage unsigned int do_IRQ(struct pt
 		__asm__ __volatile__("andl %%esp,%0" :
 					"=r" (esp) : "0" (THREAD_SIZE - 1));
 		if (unlikely(esp < (sizeof(struct thread_info) + STACK_WARN))) {
-			printk("do_IRQ: stack overflow: %ld\n",
+			printk(KERN_WARNING "do_IRQ: stack overflow: %ld\n",
 				esp - sizeof(struct thread_info));
 			dump_stack();
 		}
@@ -618,7 +616,8 @@ int request_irq(unsigned int irq,
 	 */
 	if (irqflags & SA_SHIRQ) {
 		if (!dev_id)
-			printk("Bad boy: %s (at 0x%x) called us without a dev_id!\n", devname, (&irq)[-1]);
+			printk(KERN_DEBUG "Bad boy: %s (at 0x%x) called us without a dev_id!\n",
+				devname, (&irq)[-1]);
 	}
 #endif

@@ -695,7 +694,7 @@ void free_irq(unsigned int irq, void *de
 			kfree(action);
 			return;
 		}
-		printk("Trying to free free IRQ%d\n",irq);
+		printk(KERN_DEBUG "Trying to free free IRQ%d\n",irq);
 		spin_unlock_irqrestore(&desc->lock,flags);
 		return;
 	}
@@ -1130,7 +1129,7 @@ void irq_ctx_init(int cpu)

 	softirq_ctx[cpu] = irqctx;

-	printk("CPU %u irqstacks, hard=%p soft=%p\n",
+	printk(KERN_DEBUG "CPU %u irqstacks, hard=%p soft=%p\n",
 		cpu,hardirq_ctx[cpu],softirq_ctx[cpu]);
 }

Index: linux-2.6.6-mm4/arch/i386/kernel/mca.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.6-mm4/arch/i386/kernel/mca.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 mca.c
--- linux-2.6.6-mm4/arch/i386/kernel/mca.c	19 May 2004 12:28:16 -0000	1.1.1.1
+++ linux-2.6.6-mm4/arch/i386/kernel/mca.c	21 May 2004 02:28:03 -0000
@@ -258,15 +258,13 @@ static int __init mca_init(void)

 	/* Make sure the MCA bus is present */

-	if (mca_system_init()) {
-		printk(KERN_ERR "MCA bus system initialisation failed\n");
+	if (mca_system_init())
 		return -ENODEV;
-	}

 	if (!MCA_bus)
 		return -ENODEV;

-	printk(KERN_INFO "Micro Channel bus detected.\n");
+	printk(KERN_DEBUG "Micro Channel bus detected.\n");

 	/* All MCA systems have at least a primary bus */
 	bus = mca_attach_bus(MCA_PRIMARY_BUS);
Index: linux-2.6.6-mm4/arch/i386/kernel/microcode.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.6-mm4/arch/i386/kernel/microcode.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 microcode.c
--- linux-2.6.6-mm4/arch/i386/kernel/microcode.c	19 May 2004 12:28:16 -0000	1.1.1.1
+++ linux-2.6.6-mm4/arch/i386/kernel/microcode.c	21 May 2004 02:22:31 -0000
@@ -363,7 +363,7 @@ static void do_update_one (void * unused
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu_num;

 	if (uci->mc == NULL) {
-		printk(KERN_INFO "microcode: No suitable data for cpu %d\n", cpu_num);
+		printk(KERN_DEBUG "microcode: No suitable data for cpu %d\n", cpu_num);
 		return;
 	}

@@ -383,7 +383,7 @@ static void do_update_one (void * unused
 	/* notify the caller of success on this cpu */
 	uci->err = MC_SUCCESS;
 	spin_unlock_irqrestore(&microcode_update_lock, flags);
-	printk(KERN_INFO "microcode: CPU%d updated from revision "
+	printk(KERN_DEBUG "microcode: CPU%d updated from revision "
 	       "0x%x to 0x%x, date = %08x \n",
 	       cpu_num, uci->rev, val[1], uci->mc->hdr.date);
 	return;
@@ -494,7 +494,7 @@ static int __init microcode_init (void)
 		return error;
 	}

-	printk(KERN_INFO
+	printk(KERN_DEBUG
 		"IA-32 Microcode Update Driver: v%s <tigran@veritas.com>\n",
 		MICROCODE_VERSION);
 	return 0;
@@ -503,8 +503,6 @@ static int __init microcode_init (void)
 static void __exit microcode_exit (void)
 {
 	misc_deregister(&microcode_dev);
-	printk(KERN_INFO "IA-32 Microcode Update Driver v%s unregistered\n",
-			MICROCODE_VERSION);
 }

 module_init(microcode_init)
Index: linux-2.6.6-mm4/arch/i386/kernel/mpparse.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.6-mm4/arch/i386/kernel/mpparse.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 mpparse.c
--- linux-2.6.6-mm4/arch/i386/kernel/mpparse.c	19 May 2004 12:28:16 -0000	1.1.1.1
+++ linux-2.6.6-mm4/arch/i386/kernel/mpparse.c	21 May 2004 02:12:14 -0000
@@ -234,7 +234,7 @@ static void __init MP_ioapic_info (struc
 	if (!(m->mpc_flags & MPC_APIC_USABLE))
 		return;

-	printk(KERN_INFO "I/O APIC #%d Version %d at 0x%lX.\n",
+	printk(KERN_DEBUG "I/O APIC #%d Version %d at 0x%lX.\n",
 		m->mpc_apicid, m->mpc_apicver, m->mpc_apicaddr);
 	if (nr_ioapics >= MAX_IO_APICS) {
 		printk(KERN_CRIT "Max # of I/O APICs (%d) exceeded (found %d).\n",
@@ -287,7 +287,7 @@ static void __init MP_lintsrc_info (stru
 #ifdef CONFIG_X86_NUMAQ
 static void __init MP_translation_info (struct mpc_config_translation *m)
 {
-	printk(KERN_INFO "Translation: record %d, type %d, quad %d, global %d, local %d\n", mpc_record, m->trans_type, m->trans_quad, m->trans_global, m->trans_local);
+	printk(KERN_DEBUG "Translation: record %d, type %d, quad %d, global %d, local %d\n", mpc_record, m->trans_type, m->trans_quad, m->trans_global, m->trans_local);

 	if (mpc_record >= MAX_MPC_ENTRY)
 		printk(KERN_ERR "MAX_MPC_ENTRY exceeded!\n");
@@ -308,7 +308,7 @@ static void __init smp_read_mpc_oem(stru
 	unsigned char *oemptr = ((unsigned char *)oemtable)+count;

 	mpc_record = 0;
-	printk(KERN_INFO "Found an OEM MPC table at %8p - parsing it ... \n", oemtable);
+	printk(KERN_DEBUG "Found an OEM MPC table at %8p - parsing it ... \n", oemtable);
 	if (memcmp(oemtable->oem_signature,MPC_OEM_SIGNATURE,4))
 	{
 		printk(KERN_WARNING "SMP mpc oemtable: bad signature [%c%c%c%c]!\n",
@@ -348,7 +348,7 @@ static inline void mps_oem_check(struct
 		char *productid)
 {
 	if (strncmp(oem, "IBM NUMA", 8))
-		printk("Warning!  May not be a NUMA-Q system!\n");
+		printk(KERN_WARNING "Warning!  May not be a NUMA-Q system!\n");
 	if (mpc->mpc_oemptr)
 		smp_read_mpc_oem((struct mp_config_oemtable *) mpc->mpc_oemptr,
 				mpc->mpc_oemsize);
@@ -386,7 +386,7 @@ static int __init smp_read_mpc(struct mp
 	}
 	memcpy(oem,mpc->mpc_oem,8);
 	oem[8]=0;
-	printk(KERN_INFO "OEM ID: %s ",oem);
+	printk(KERN_DEBUG "OEM ID: %s ",oem);

 	memcpy(str,mpc->mpc_productid,12);
 	str[12]=0;
@@ -501,12 +501,12 @@ static void __init construct_default_ioi
 	 *  If it does, we assume it's valid.
 	 */
 	if (mpc_default_type == 5) {
-		printk(KERN_INFO "ISA/PCI bus type with no IRQ information... falling back to ELCR\n");
+		printk(KERN_DEBUG "ISA/PCI bus type with no IRQ information... falling back to ELCR\n");

 		if (ELCR_trigger(0) || ELCR_trigger(1) || ELCR_trigger(2) || ELCR_trigger(13))
 			printk(KERN_WARNING "ELCR contains invalid data... not using ELCR\n");
 		else {
-			printk(KERN_INFO "Using ELCR to identify PCI interrupts\n");
+			printk(KERN_DEBUG "Using ELCR to identify PCI interrupts\n");
 			ELCR_fallback = 1;
 		}
 	}
@@ -645,18 +645,18 @@ void __init get_smp_config (void)
 	 * processors, where MPS only supports physical.
 	 */
 	if (acpi_lapic && acpi_ioapic) {
-		printk(KERN_INFO "Using ACPI (MADT) for SMP configuration information\n");
+		printk(KERN_DEBUG "Using ACPI (MADT) for SMP configuration information\n");
 		return;
 	}
 	else if (acpi_lapic)
-		printk(KERN_INFO "Using ACPI for processor (LAPIC) configuration information\n");
+		printk(KERN_DEBUG "Using ACPI for processor (LAPIC) configuration information\n");

 	printk(KERN_INFO "Intel MultiProcessor Specification v1.%d\n", mpf->mpf_specification);
 	if (mpf->mpf_feature2 & (1<<7)) {
-		printk(KERN_INFO "    IMCR and PIC compatibility mode.\n");
+		printk(KERN_DEBUG "    IMCR and PIC compatibility mode.\n");
 		pic_mode = 1;
 	} else {
-		printk(KERN_INFO "    Virtual Wire compatibility mode.\n");
+		printk(KERN_DEBUG "    Virtual Wire compatibility mode.\n");
 		pic_mode = 0;
 	}

@@ -665,7 +665,7 @@ void __init get_smp_config (void)
 	 */
 	if (mpf->mpf_feature1 != 0) {

-		printk(KERN_INFO "Default MP configuration #%d\n", mpf->mpf_feature1);
+		printk(KERN_DEBUG "Default MP configuration #%d\n", mpf->mpf_feature1);
 		construct_default_ISA_mptable(mpf->mpf_feature1);

 	} else if (mpf->mpf_physptr) {
@@ -725,7 +725,7 @@ static int __init smp_scan_config (unsig
 				|| (mpf->mpf_specification == 4)) ) {

 			smp_found_config = 1;
-			printk(KERN_INFO "found SMP MP-table at %08lx\n",
+			printk(KERN_DEBUG "found SMP MP-table at %08lx\n",
 						virt_to_phys(mpf));
 			reserve_bootmem(virt_to_phys(mpf), PAGE_SIZE);
 			if (mpf->mpf_physptr) {
@@ -911,7 +911,7 @@ void __init mp_register_ioapic (
 	mp_ioapic_routing[idx].gsi_end = gsi_base +
 		io_apic_get_redir_entries(idx);

-	printk("IOAPIC[%d]: apic_id %d, version %d, address 0x%lx, "
+	printk(KERN_DEBUG "IOAPIC[%d]: apic_id %d, version %d, address 0x%lx, "
 		"GSI %d-%d\n", idx, mp_ioapics[idx].mpc_apicid,
 		mp_ioapics[idx].mpc_apicver, mp_ioapics[idx].mpc_apicaddr,
 		mp_ioapic_routing[idx].gsi_base,
Index: linux-2.6.6-mm4/arch/i386/kernel/nmi.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.6-mm4/arch/i386/kernel/nmi.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 nmi.c
--- linux-2.6.6-mm4/arch/i386/kernel/nmi.c	19 May 2004 12:28:16 -0000	1.1.1.1
+++ linux-2.6.6-mm4/arch/i386/kernel/nmi.c	21 May 2004 00:50:33 -0000
@@ -112,7 +112,7 @@ int __init check_nmi_watchdog (void)
 	unsigned int prev_nmi_count[NR_CPUS];
 	int cpu;

-	printk(KERN_INFO "testing NMI watchdog ... ");
+	printk(KERN_DEBUG "testing NMI watchdog ... ");

 	for (cpu = 0; cpu < NR_CPUS; cpu++)
 		prev_nmi_count[cpu] = irq_stat[cpu].__nmi_count;
Index: linux-2.6.6-mm4/arch/i386/kernel/scx200.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.6-mm4/arch/i386/kernel/scx200.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 scx200.c
--- linux-2.6.6-mm4/arch/i386/kernel/scx200.c	19 May 2004 12:28:16 -0000	1.1.1.1
+++ linux-2.6.6-mm4/arch/i386/kernel/scx200.c	21 May 2004 02:30:35 -0000
@@ -82,15 +82,13 @@ int __init scx200_init(void)
 	int bank;
 	unsigned base;

-	printk(KERN_INFO NAME ": NatSemi SCx200 Driver\n");
-
 	if ((bridge = pci_find_device(PCI_VENDOR_ID_NS,
 				      PCI_DEVICE_ID_NS_SCx200_BRIDGE,
 				      NULL)) == NULL)
 		return -ENODEV;

 	base = pci_resource_start(bridge, 0);
-	printk(KERN_INFO NAME ": GPIO base 0x%x\n", base);
+	printk(KERN_DEBUG NAME ": GPIO base 0x%x\n", base);

 	if (request_region(base, SCx200_GPIO_SIZE, "NatSemi SCx200 GPIO") == 0) {
 		printk(KERN_ERR NAME ": can't allocate I/O for GPIOs\n");
Index: linux-2.6.6-mm4/arch/i386/kernel/setup.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.6-mm4/arch/i386/kernel/setup.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 setup.c
--- linux-2.6.6-mm4/arch/i386/kernel/setup.c	19 May 2004 12:28:16 -0000	1.1.1.1
+++ linux-2.6.6-mm4/arch/i386/kernel/setup.c	21 May 2004 01:00:11 -0000
@@ -389,7 +389,7 @@ static void __init print_memory_map(char
 	int i;

 	for (i = 0; i < e820.nr_map; i++) {
-		printk(" %s: %016Lx - %016Lx ", who,
+		printk(KERN_DEBUG " %s: %016Lx - %016Lx ", who,
 			e820.map[i].addr,
 			e820.map[i].addr + e820.map[i].size);
 		switch (e820.map[i].type) {
@@ -663,7 +663,7 @@ static inline void copy_edd(void)
 static void __init setup_memory_region(void)
 {
 	char *who = machine_specific_memory_setup();
-	printk(KERN_INFO "BIOS-provided physical RAM map:\n");
+	printk(KERN_DEBUG "BIOS-provided physical RAM map:\n");
 	print_memory_map(who);
 } /* setup_memory_region */

@@ -831,7 +831,7 @@ static void __init parse_cmdline_early (
 	*to = '\0';
 	*cmdline_p = command_line;
 	if (userdef) {
-		printk(KERN_INFO "user-defined physical RAM map:\n");
+		printk(KERN_DEBUG "user-defined physical RAM map:\n");
 		print_memory_map("user");
 	}
 }
Index: linux-2.6.6-mm4/arch/i386/kernel/smpboot.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.6-mm4/arch/i386/kernel/smpboot.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 smpboot.c
--- linux-2.6.6-mm4/arch/i386/kernel/smpboot.c	19 May 2004 12:28:16 -0000	1.1.1.1
+++ linux-2.6.6-mm4/arch/i386/kernel/smpboot.c	21 May 2004 02:06:03 -0000
@@ -219,7 +219,8 @@ static void __init synchronize_tsc_bp (v
 	unsigned long one_usec;
 	int buggy = 0;

-	printk("checking TSC synchronization across %u CPUs: ", num_booting_cpus());
+	printk(KERN_DEBUG "checking TSC synchronization across %u CPUs: ",
+		num_booting_cpus());

 	/* convert from kcyc/sec to cyc/usec */
 	one_usec = cpu_khz / 1000;
@@ -296,7 +297,7 @@ static void __init synchronize_tsc_bp (v
 			if (tsc_values[i] < avg)
 				realdelta = -realdelta;

-			printk("BIOS BUG: CPU#%d improperly initialized, has %ld usecs TSC skew! FIXED.\n", i, realdelta);
+			printk(KERN_DEBUG "BIOS BUG: CPU#%d improperly initialized, has %ld usecs TSC skew! FIXED.\n", i, realdelta);
 		}

 		sum += delta;
@@ -355,7 +356,7 @@ void __init smp_callin(void)
 	phys_id = GET_APIC_ID(apic_read(APIC_ID));
 	cpuid = smp_processor_id();
 	if (cpu_isset(cpuid, cpu_callin_map)) {
-		printk("huh, phys CPU#%d, CPU#%d already present??\n",
+		printk(KERN_DEBUG "huh, phys CPU#%d, CPU#%d already present??\n",
 					phys_id, cpuid);
 		BUG();
 	}
@@ -383,7 +384,7 @@ void __init smp_callin(void)
 	}

 	if (!time_before(jiffies, timeout)) {
-		printk("BUG: CPU%d started up but did not get a callout!\n",
+		printk(KERN_DEBUG "BUG: CPU%d started up but did not get a callout!\n",
 			cpuid);
 		BUG();
 	}
@@ -509,7 +510,7 @@ EXPORT_SYMBOL(cpu_2_node);
 /* set up a mapping between cpu and node. */
 static inline void map_cpu_to_node(int cpu, int node)
 {
-	printk("Mapping cpu %d to node %d\n", cpu, node);
+	printk(KERN_DEBUG "Mapping cpu %d to node %d\n", cpu, node);
 	cpu_set(cpu, node_2_cpu_mask[node]);
 	cpu_2_node[cpu] = node;
 }
@@ -519,7 +520,7 @@ static inline void unmap_cpu_to_node(int
 {
 	int node;

-	printk("Unmapping cpu %d from all nodes\n", cpu);
+	printk(KERN_DEBUG "Unmapping cpu %d from all nodes\n", cpu);
 	for (node = 0; node < MAX_NUMNODES; node ++)
 		cpu_clear(cpu, node_2_cpu_mask[node]);
 	cpu_2_node[cpu] = 0;
@@ -629,9 +630,9 @@ wakeup_secondary_cpu(int logical_apicid,
 	Dprintk("NMI sent.\n");

 	if (send_status)
-		printk("APIC never delivered???\n");
+		printk(KERN_DEBUG "APIC never delivered???\n");
 	if (accept_status)
-		printk("APIC delivery error (%lx).\n", accept_status);
+		printk(KERN_DEBUG "APIC delivery error (%lx).\n", accept_status);

 	return (send_status | accept_status);
 }
@@ -764,9 +765,10 @@ wakeup_secondary_cpu(int phys_apicid, un
 	Dprintk("After Startup.\n");

 	if (send_status)
-		printk("APIC never delivered???\n");
+		printk(KERN_DEBUG "APIC never delivered???\n");
 	if (accept_status)
-		printk("APIC delivery error (%lx).\n", accept_status);
+		printk(KERN_DEBUG "APIC delivery error (%lx).\n",
+			accept_status);

 	return (send_status | accept_status);
 }
@@ -811,7 +813,8 @@ static int __init do_boot_cpu(int apicid
 	start_eip = setup_trampoline();

 	/* So we see what's up   */
-	printk("Booting processor %d/%d eip %lx\n", cpu, apicid, start_eip);
+	printk(KERN_DEBUG "Booting processor %d/%d eip %lx\n",
+		cpu, apicid, start_eip);
 	/* Stack for startup_32 can be just as for start_secondary onwards */
 	stack_start.esp = (void *) idle->thread.esp;

@@ -855,7 +858,7 @@ static int __init do_boot_cpu(int apicid
 		if (cpu_isset(cpu, cpu_callin_map)) {
 			/* number CPUs logically, starting from 1 (BSP is 0) */
 			Dprintk("OK.\n");
-			printk("CPU%d: ", cpu);
+			printk(KERN_DEBUG "CPU%d: ", cpu);
 			print_cpu_info(&cpu_data[cpu]);
 			Dprintk("CPU has booted.\n");
 		} else {
@@ -863,10 +866,10 @@ static int __init do_boot_cpu(int apicid
 			if (*((volatile unsigned char *)trampoline_base)
 					== 0xA5)
 				/* trampoline started but...? */
-				printk("Stuck ??\n");
+				printk(KERN_DEBUG "Stuck ??\n");
 			else
 				/* trampoline code not run */
-				printk("Not responding.\n");
+				printk(KERN_DEBUG "Not responding.\n");
 			inquire_remote_apic(apicid);
 		}
 	}
@@ -921,10 +924,10 @@ static void smp_tune_scheduling (void)

 	cache_decay_ticks = (long)cacheflush_time/cpu_khz + 1;

-	printk("per-CPU timeslice cutoff: %ld.%02ld usecs.\n",
+	printk(KERN_DEBUG "per-CPU timeslice cutoff: %ld.%02ld usecs.\n",
 		(long)cacheflush_time/(cpu_khz/1000),
 		((long)cacheflush_time*100/(cpu_khz/1000)) % 100);
-	printk("task migration cache decay timeout: %ld msecs.\n",
+	printk(KERN_DEBUG "task migration cache decay timeout: %ld msecs.\n",
 		cache_decay_ticks);
 }

@@ -947,7 +950,7 @@ static void __init smp_boot_cpus(unsigne
 	 * Setup boot CPU information
 	 */
 	smp_store_cpu_info(0); /* Final full version of the data */
-	printk("CPU%d: ", 0);
+	printk(KERN_INFO "CPU%d: ", 0);
 	print_cpu_info(&cpu_data[0]);

 	boot_cpu_physical_apicid = GET_APIC_ID(apic_read(APIC_ID));
@@ -963,11 +966,11 @@ static void __init smp_boot_cpus(unsigne
 	 * get out of here now!
 	 */
 	if (!smp_found_config && !acpi_lapic) {
-		printk(KERN_NOTICE "SMP motherboard not detected.\n");
+		printk(KERN_DEBUG "SMP motherboard not detected.\n");
 		smpboot_clear_io_apic_irqs();
 		phys_cpu_present_map = physid_mask_of_physid(0);
 		if (APIC_init_uniprocessor())
-			printk(KERN_NOTICE "Local APIC not detected."
+			printk(KERN_DEBUG "Local APIC not detected."
 					   " Using dummy APIC emulation.\n");
 		map_cpu_to_logical_apicid();
 		return;
@@ -979,7 +982,7 @@ static void __init smp_boot_cpus(unsigne
 	 * Makes no sense to do this check in clustered apic mode, so skip it
 	 */
 	if (!check_phys_apicid_present(boot_cpu_physical_apicid)) {
-		printk("weird, boot CPU (#%d) not listed by the BIOS.\n",
+		printk(KERN_DEBUG "weird, boot CPU (#%d) not listed by the BIOS.\n",
 				boot_cpu_physical_apicid);
 		physid_set(hard_smp_processor_id(), phys_cpu_present_map);
 	}
@@ -1003,7 +1006,7 @@ static void __init smp_boot_cpus(unsigne
 	 */
 	if (!max_cpus) {
 		smp_found_config = 0;
-		printk(KERN_INFO "SMP mode deactivated, forcing use of dummy APIC emulation.\n");
+		printk(KERN_DEBUG "SMP mode deactivated, forcing use of dummy APIC emulation.\n");
 		smpboot_clear_io_apic_irqs();
 		phys_cpu_present_map = physid_mask_of_physid(0);
 		return;
@@ -1040,7 +1043,7 @@ static void __init smp_boot_cpus(unsigne
 			continue;

 		if (do_boot_cpu(apicid))
-			printk("CPU #%d not responding - cannot use it.\n",
+			printk(KERN_WARNING "CPU #%d not responding - cannot use it.\n",
 								apicid);
 		else
 			++kicked;
@@ -1075,7 +1078,7 @@ static void __init smp_boot_cpus(unsigne
 	 */
 	if (tainted & TAINT_UNSAFE_SMP) {
 		if (cpucount)
-			printk (KERN_INFO "WARNING: This combination of AMD processors is not suitable for SMP.\n");
+			printk (KERN_WARNING "WARNING: This combination of AMD processors is not suitable for SMP.\n");
 		else
 			tainted &= ~TAINT_UNSAFE_SMP;
 	}
Index: linux-2.6.6-mm4/arch/i386/kernel/summit.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.6-mm4/arch/i386/kernel/summit.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 summit.c
--- linux-2.6.6-mm4/arch/i386/kernel/summit.c	19 May 2004 12:28:16 -0000	1.1.1.1
+++ linux-2.6.6-mm4/arch/i386/kernel/summit.c	21 May 2004 02:31:13 -0000
@@ -85,7 +85,7 @@ static int __init setup_pci_node_map_for
 		num_buses = 9;
 		break;
 	default:
-		printk(KERN_INFO "%s: Unsupported Winnipeg type!\n", __FUNCTION__);
+		printk(KERN_DEBUG "%s: Unsupported Winnipeg type!\n", __FUNCTION__);
 		return last_bus;
 	}

Index: linux-2.6.6-mm4/arch/i386/kernel/time.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.6-mm4/arch/i386/kernel/time.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 time.c
--- linux-2.6.6-mm4/arch/i386/kernel/time.c	19 May 2004 12:28:16 -0000	1.1.1.1
+++ linux-2.6.6-mm4/arch/i386/kernel/time.c	21 May 2004 02:24:35 -0000
@@ -362,9 +362,8 @@ void __init hpet_time_init(void)
 	xtime.tv_nsec = (INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ);
 	wall_to_monotonic.tv_nsec = -xtime.tv_nsec;

-	if (hpet_enable() >= 0) {
-		printk("Using HPET for base-timer\n");
-	}
+	if (hpet_enable() >= 0)
+		printk(KERN_DEBUG "Using HPET for base-timer\n");

 	cur_timer = select_timer();
 	printk(KERN_INFO "Using %s for high-res timesource\n",cur_timer->name);
Index: linux-2.6.6-mm4/arch/i386/kernel/cpu/amd.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.6-mm4/arch/i386/kernel/cpu/amd.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 amd.c
--- linux-2.6.6-mm4/arch/i386/kernel/cpu/amd.c	19 May 2004 12:28:16 -0000	1.1.1.1
+++ linux-2.6.6-mm4/arch/i386/kernel/cpu/amd.c	21 May 2004 00:35:56 -0000
@@ -74,7 +74,7 @@ static void __init init_amd(struct cpuin
 				void (*f_vide)(void);
 				unsigned long d, d2;

-				printk(KERN_INFO "AMD K6 stepping B detected - ");
+				printk(KERN_DEBUG "AMD K6 stepping B detected - ");

 				/*
 				 * It looks like AMD fixed the 2.6.2 bug and improved indirect
@@ -90,13 +90,13 @@ static void __init init_amd(struct cpuin
 				d = d2-d;

 				/* Knock these two lines out if it debugs out ok */
-				printk(KERN_INFO "AMD K6 stepping B detected - ");
+				printk(KERN_DEBUG "AMD K6 stepping B detected - ");
 				/* -- cut here -- */
 				if (d > 20*K6_BUG_LOOP)
 					printk("system stability may be impaired when more than 32 MB are used.\n");
 				else
 					printk("probably OK (after B9730xxxx).\n");
-				printk(KERN_INFO "Please see http://membres.lycos.fr/poulot/k6bug.html\n");
+				printk(KERN_DEBUG "Please see http://membres.lycos.fr/poulot/k6bug.html\n");
 			}

 			/* K6 with old style WHCR */
@@ -114,7 +114,7 @@ static void __init init_amd(struct cpuin
 					wbinvd();
 					wrmsr(MSR_K6_WHCR, l, h);
 					local_irq_restore(flags);
-					printk(KERN_INFO "Enabling old style K6 write allocation for %d Mb\n",
+					printk(KERN_DEBUG "Enabling old style K6 write allocation for %d Mb\n",
 						mbytes);
 				}
 				break;
@@ -135,7 +135,7 @@ static void __init init_amd(struct cpuin
 					wbinvd();
 					wrmsr(MSR_K6_WHCR, l, h);
 					local_irq_restore(flags);
-					printk(KERN_INFO "Enabling new style K6 write allocation for %d Mb\n",
+					printk(KERN_DEBUG "Enabling new style K6 write allocation for %d Mb\n",
 						mbytes);
 				}

@@ -155,7 +155,7 @@ static void __init init_amd(struct cpuin
 			 */
 			if (c->x86_model >= 6 && c->x86_model <= 10) {
 				if (!cpu_has(c, X86_FEATURE_XMM)) {
-					printk(KERN_INFO "Enabling disabled K7/SSE Support.\n");
+					printk(KERN_DEBUG "Enabling disabled K7/SSE Support.\n");
 					rdmsr(MSR_K7_HWCR, l, h);
 					l &= ~0x00008000;
 					wrmsr(MSR_K7_HWCR, l, h);
Index: linux-2.6.6-mm4/arch/i386/kernel/cpu/centaur.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.6-mm4/arch/i386/kernel/cpu/centaur.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 centaur.c
--- linux-2.6.6-mm4/arch/i386/kernel/cpu/centaur.c	19 May 2004 12:28:16 -0000	1.1.1.1
+++ linux-2.6.6-mm4/arch/i386/kernel/cpu/centaur.c	21 May 2004 00:42:27 -0000
@@ -269,7 +269,7 @@ static void __init init_c3(struct cpuinf
 			rdmsr (MSR_VIA_FCR, lo, hi);
 			lo |= ACE_FCR;		/* enable ACE unit */
 			wrmsr (MSR_VIA_FCR, lo, hi);
-			printk(KERN_INFO "CPU: Enabled ACE h/w crypto\n");
+			printk(KERN_DEBUG "CPU: Enabled ACE h/w crypto\n");
 		}

 		/* enable RNG unit, if present and disabled */
@@ -277,7 +277,7 @@ static void __init init_c3(struct cpuinf
 			rdmsr (MSR_VIA_RNG, lo, hi);
 			lo |= RNG_ENABLE;	/* enable RNG unit */
 			wrmsr (MSR_VIA_RNG, lo, hi);
-			printk(KERN_INFO "CPU: Enabled h/w RNG\n");
+			printk(KERN_DEBUG "CPU: Enabled h/w RNG\n");
 		}

 		/* store Centaur Extended Feature Flags as
@@ -346,7 +346,7 @@ static void __init init_centaur(struct c
 				name="C6";
 				fcr_set=ECX8|DSMC|EDCTLB|EMMX|ERETSTK;
 				fcr_clr=DPDC;
-				printk(KERN_NOTICE "Disabling bugged TSC.\n");
+				printk(KERN_DEBUG "Disabling bugged TSC.\n");
 				clear_bit(X86_FEATURE_TSC, c->x86_capability);
 #ifdef CONFIG_X86_OOSTORE
 				centaur_create_optimal_mcr();
@@ -420,10 +420,10 @@ static void __init init_centaur(struct c
 			newlo=(lo|fcr_set) & (~fcr_clr);

 			if (newlo!=lo) {
-				printk(KERN_INFO "Centaur FCR was 0x%X now 0x%X\n", lo, newlo );
+				printk(KERN_DEBUG "Centaur FCR was 0x%X now 0x%X\n", lo, newlo );
 				wrmsr(MSR_IDT_FCR1, newlo, hi );
 			} else {
-				printk(KERN_INFO "Centaur FCR is 0x%X\n",lo);
+				printk(KERN_DEBUG "Centaur FCR is 0x%X\n",lo);
 			}
 			/* Emulate MTRRs using Centaur's MCR. */
 			set_bit(X86_FEATURE_CENTAUR_MCR, c->x86_capability);
Index: linux-2.6.6-mm4/arch/i386/kernel/cpu/common.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.6-mm4/arch/i386/kernel/cpu/common.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 common.c
--- linux-2.6.6-mm4/arch/i386/kernel/cpu/common.c	19 May 2004 12:28:16 -0000	1.1.1.1
+++ linux-2.6.6-mm4/arch/i386/kernel/cpu/common.c	21 May 2004 00:39:19 -0000
@@ -84,7 +84,7 @@ void __init display_cacheinfo(struct cpu

 	if (n >= 0x80000005) {
 		cpuid(0x80000005, &dummy, &dummy, &ecx, &edx);
-		printk(KERN_INFO "CPU: L1 I Cache: %dK (%d bytes/line), D cache %dK (%d bytes/line)\n",
+		printk(KERN_DEBUG "CPU: L1 I Cache: %dK (%d bytes/line), D cache %dK (%d bytes/line)\n",
 			edx>>24, edx&0xFF, ecx>>24, ecx&0xFF);
 		c->x86_cache_size=(ecx>>24)+(edx>>24);
 	}
@@ -108,7 +108,7 @@ void __init display_cacheinfo(struct cpu

 	c->x86_cache_size = l2size;

-	printk(KERN_INFO "CPU: L2 Cache: %dK (%d bytes/line)\n",
+	printk(KERN_DEBUG "CPU: L2 Cache: %dK (%d bytes/line)\n",
 	       l2size, ecx & 0xFF);
 }

@@ -508,12 +508,12 @@ void __init cpu_init (void)
 		printk(KERN_WARNING "CPU#%d already initialized!\n", cpu);
 		for (;;) local_irq_enable();
 	}
-	printk(KERN_INFO "Initializing CPU#%d\n", cpu);
+	printk(KERN_DEBUG "Initializing CPU#%d\n", cpu);

 	if (cpu_has_vme || cpu_has_tsc || cpu_has_de)
 		clear_in_cr4(X86_CR4_VME|X86_CR4_PVI|X86_CR4_TSD|X86_CR4_DE);
 	if (tsc_disable && cpu_has_tsc) {
-		printk(KERN_NOTICE "Disabling TSC...\n");
+		printk(KERN_DEBUG "Disabling TSC...\n");
 		/**** FIX-HPA: DOES THIS REALLY BELONG HERE? ****/
 		clear_bit(X86_FEATURE_TSC, boot_cpu_data.x86_capability);
 		set_in_cr4(X86_CR4_TSD);
Index: linux-2.6.6-mm4/arch/i386/kernel/cpu/cyrix.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.6-mm4/arch/i386/kernel/cpu/cyrix.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 cyrix.c
--- linux-2.6.6-mm4/arch/i386/kernel/cpu/cyrix.c	19 May 2004 12:28:16 -0000	1.1.1.1
+++ linux-2.6.6-mm4/arch/i386/kernel/cpu/cyrix.c	21 May 2004 00:40:37 -0000
@@ -99,7 +99,7 @@ static void __init check_cx686_slop(stru
 		local_irq_restore(flags);

 		if (ccr5 & 2) { /* possible wrong calibration done */
-			printk(KERN_INFO "Recalibrating delay loop with SLOP bit reset\n");
+			printk(KERN_DEBUG "Recalibrating delay loop with SLOP bit reset\n");
 			calibrate_delay();
 			c->loops_per_jiffy = loops_per_jiffy;
 		}
@@ -111,7 +111,7 @@ static void __init set_cx86_reorder(void
 {
 	u8 ccr3;

-	printk(KERN_INFO "Enable Memory access reorder on Cyrix/NSC processor.\n");
+	printk(KERN_DEBUG "Enable Memory access reorder on Cyrix/NSC processor.\n");
 	ccr3 = getCx86(CX86_CCR3);
 	setCx86(CX86_CCR3, (ccr3 & 0x0f) | 0x10); /* enable MAPEN  */

@@ -126,7 +126,7 @@ static void __init set_cx86_memwb(void)
 {
 	u32 cr0;

-	printk(KERN_INFO "Enable Memory-Write-back mode on Cyrix/NSC processor.\n");
+	printk(KERN_DEBUG "Enable Memory-Write-back mode on Cyrix/NSC processor.\n");

 	/* CCR2 bit 2: unlock NW bit */
 	setCx86(CX86_CCR2, getCx86(CX86_CCR2) & ~0x04);
@@ -145,7 +145,7 @@ static void __init set_cx86_inc(void)
 {
 	unsigned char ccr3;

-	printk(KERN_INFO "Enable Incrementor on Cyrix/NSC processor.\n");
+	printk(KERN_DEBUG "Enable Incrementor on Cyrix/NSC processor.\n");

 	ccr3 = getCx86(CX86_CCR3);
 	setCx86(CX86_CCR3, (ccr3 & 0x0f) | 0x10); /* enable MAPEN  */
@@ -266,7 +266,7 @@ static void __init init_cyrix(struct cpu
 		   VSA1 we work around however.
 		*/

-		printk(KERN_INFO "Working around Cyrix MediaGX virtual DMA bugs.\n");
+		printk(KERN_DEBUG "Working around Cyrix MediaGX virtual DMA bugs.\n");
 		isa_dma_bridge_buggy = 2;
 #endif
 		c->x86_cache_size=16;	/* Yep 16K integrated cache thats it */
@@ -388,7 +388,7 @@ static void cyrix_identify(struct cpuinf
    	        {
 			unsigned char ccr3, ccr4;
 			unsigned long flags;
-			printk(KERN_INFO "Enabling CPUID on Cyrix processor.\n");
+			printk(KERN_DEBUG "Enabling CPUID on Cyrix processor.\n");
 			local_irq_save(flags);
 			ccr3 = getCx86(CX86_CCR3);
 			setCx86(CX86_CCR3, (ccr3 & 0x0f) | 0x10); /* enable MAPEN  */
Index: linux-2.6.6-mm4/arch/i386/kernel/cpu/intel.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.6-mm4/arch/i386/kernel/cpu/intel.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 intel.c
--- linux-2.6.6-mm4/arch/i386/kernel/cpu/intel.c	19 May 2004 12:28:16 -0000	1.1.1.1
+++ linux-2.6.6-mm4/arch/i386/kernel/cpu/intel.c	21 May 2004 00:34:10 -0000
@@ -50,7 +50,7 @@ int __init ppro_with_ram_bug(void)
 	    boot_cpu_data.x86 == 6 &&
 	    boot_cpu_data.x86_model == 1 &&
 	    boot_cpu_data.x86_mask < 8) {
-		printk(KERN_INFO "Pentium Pro with Errata#50 detected. Taking evasive action.\n");
+		printk(KERN_DEBUG "Pentium Pro with Errata#50 detected. Taking evasive action.\n");
 		return 1;
 	}
 	return 0;
@@ -120,8 +120,8 @@ static void __init Intel_errata_workarou
 	if ((c->x86 == 15) && (c->x86_model == 1) && (c->x86_mask == 1)) {
 		rdmsr (MSR_IA32_MISC_ENABLE, lo, hi);
 		if ((lo & (1<<9)) == 0) {
-			printk (KERN_INFO "CPU: C0 stepping P4 Xeon detected.\n");
-			printk (KERN_INFO "CPU: Disabling hardware prefetching (Errata 037)\n");
+			printk (KERN_DEBUG "CPU: C0 stepping P4 Xeon detected.\n");
+			printk (KERN_DEBUG "CPU: Disabling hardware prefetching (Errata 037)\n");
 			lo |= (1<<9);	/* Disable hw prefetching */
 			wrmsr (MSR_IA32_MISC_ENABLE, lo, hi);
 		}
@@ -147,7 +147,7 @@ static void __init init_intel(struct cpu
 		c->f00f_bug = 1;
 		if ( !f00f_workaround_enabled ) {
 			trap_init_f00f_bug();
-			printk(KERN_NOTICE "Intel Pentium with F0 0F bug - workaround enabled.\n");
+			printk(KERN_DEBUG "Intel Pentium with F0 0F bug - workaround enabled.\n");
 			f00f_workaround_enabled = 1;
 		}
 	}
@@ -207,17 +207,17 @@ static void __init init_intel(struct cpu
 		}

 		if ( trace )
-			printk (KERN_INFO "CPU: Trace cache: %dK uops", trace);
+			printk (KERN_DEBUG "CPU: Trace cache: %dK uops", trace);
 		else if ( l1i )
-			printk (KERN_INFO "CPU: L1 I cache: %dK", l1i);
+			printk (KERN_DEBUG "CPU: L1 I cache: %dK", l1i);
 		if ( l1d )
 			printk(", L1 D cache: %dK\n", l1d);
 		else
 			printk("\n");
 		if ( l2 )
-			printk(KERN_INFO "CPU: L2 cache: %dK\n", l2);
+			printk(KERN_DEBUG "CPU: L2 cache: %dK\n", l2);
 		if ( l3 )
-			printk(KERN_INFO "CPU: L3 cache: %dK\n", l3);
+			printk(KERN_DEBUG "CPU: L3 cache: %dK\n", l3);

 		/*
 		 * This assumes the L3 cache is shared; it typically lives in
@@ -275,7 +275,7 @@ static void __init init_intel(struct cpu
 		smp_num_siblings = (ebx & 0xff0000) >> 16;

 		if (smp_num_siblings == 1) {
-			printk(KERN_INFO  "CPU: Hyper-Threading is disabled\n");
+			printk(KERN_DEBUG  "CPU: Hyper-Threading is disabled\n");
 		} else if (smp_num_siblings > 1 ) {
 			index_lsb = 0;
 			index_msb = 31;
@@ -299,7 +299,7 @@ static void __init init_intel(struct cpu
 				index_msb++;
 			phys_proc_id[cpu] = phys_pkg_id((ebx >> 24) & 0xFF, index_msb);

-			printk(KERN_INFO  "CPU: Physical Processor ID: %d\n",
+			printk(KERN_DEBUG  "CPU: Physical Processor ID: %d\n",
                                phys_proc_id[cpu]);
 		}

Index: linux-2.6.6-mm4/arch/i386/kernel/cpu/transmeta.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.6-mm4/arch/i386/kernel/cpu/transmeta.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 transmeta.c
--- linux-2.6.6-mm4/arch/i386/kernel/cpu/transmeta.c	19 May 2004 12:28:16 -0000	1.1.1.1
+++ linux-2.6.6-mm4/arch/i386/kernel/cpu/transmeta.c	21 May 2004 00:36:54 -0000
@@ -18,7 +18,7 @@ static void __init init_transmeta(struct
 	max = cpuid_eax(0x80860000);
 	if ( max >= 0x80860001 ) {
 		cpuid(0x80860001, &dummy, &cpu_rev, &cpu_freq, &cpu_flags);
-		printk(KERN_INFO "CPU: Processor revision %u.%u.%u.%u, %u MHz\n",
+		printk(KERN_DEBUG "CPU: Processor revision %u.%u.%u.%u, %u MHz\n",
 		       (cpu_rev >> 24) & 0xff,
 		       (cpu_rev >> 16) & 0xff,
 		       (cpu_rev >> 8) & 0xff,
@@ -27,7 +27,7 @@ static void __init init_transmeta(struct
 	}
 	if ( max >= 0x80860002 ) {
 		cpuid(0x80860002, &dummy, &cms_rev1, &cms_rev2, &dummy);
-		printk(KERN_INFO "CPU: Code Morphing Software revision %u.%u.%u-%u-%u\n",
+		printk(KERN_DEBUG "CPU: Code Morphing Software revision %u.%u.%u-%u-%u\n",
 		       (cms_rev1 >> 24) & 0xff,
 		       (cms_rev1 >> 16) & 0xff,
 		       (cms_rev1 >> 8) & 0xff,
@@ -56,7 +56,7 @@ static void __init init_transmeta(struct
 		      (void *)&cpu_info[56],
 		      (void *)&cpu_info[60]);
 		cpu_info[64] = '\0';
-		printk(KERN_INFO "CPU: %s\n", cpu_info);
+		printk(KERN_DEBUG "CPU: %s\n", cpu_info);
 	}

 	/* Unhide possibly hidden capability flags */
Index: linux-2.6.6-mm4/arch/i386/kernel/cpu/mcheck/k7.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.6-mm4/arch/i386/kernel/cpu/mcheck/k7.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 k7.c
--- linux-2.6.6-mm4/arch/i386/kernel/cpu/mcheck/k7.c	19 May 2004 12:28:16 -0000	1.1.1.1
+++ linux-2.6.6-mm4/arch/i386/kernel/cpu/mcheck/k7.c	21 May 2004 01:06:31 -0000
@@ -76,7 +76,7 @@ void __init amd_mcheck_init(struct cpuin
 	machine_check_vector = k7_machine_check;
 	wmb();

-	printk (KERN_INFO "Intel machine check architecture supported.\n");
+	printk (KERN_DEBUG "Intel machine check architecture supported.\n");
 	rdmsr (MSR_IA32_MCG_CAP, l, h);
 	if (l & (1<<8))	/* Control register present ? */
 		wrmsr (MSR_IA32_MCG_CTL, 0xffffffff, 0xffffffff);
@@ -91,6 +91,6 @@ void __init amd_mcheck_init(struct cpuin
 	}

 	set_in_cr4 (X86_CR4_MCE);
-	printk (KERN_INFO "Intel machine check reporting enabled on CPU#%d.\n",
+	printk (KERN_DEBUG "Intel machine check reporting enabled on CPU#%d.\n",
 		smp_processor_id());
 }
Index: linux-2.6.6-mm4/arch/i386/kernel/cpu/mcheck/p4.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.6-mm4/arch/i386/kernel/cpu/mcheck/p4.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 p4.c
--- linux-2.6.6-mm4/arch/i386/kernel/cpu/mcheck/p4.c	19 May 2004 12:28:16 -0000	1.1.1.1
+++ linux-2.6.6-mm4/arch/i386/kernel/cpu/mcheck/p4.c	21 May 2004 01:03:02 -0000
@@ -125,7 +125,7 @@ static void __init intel_init_thermal(st

 	l = apic_read (APIC_LVTTHMR);
 	apic_write_around (APIC_LVTTHMR, l & ~APIC_LVT_MASKED);
-	printk (KERN_INFO "CPU%d: Thermal monitoring enabled\n", cpu);
+	printk (KERN_DEBUG "CPU%d: Thermal monitoring enabled\n", cpu);
 	return;
 }
 #endif /* CONFIG_X86_MCE_P4THERMAL */
@@ -237,7 +237,7 @@ void __init intel_p4_mcheck_init(struct
 	machine_check_vector = intel_machine_check;
 	wmb();

-	printk (KERN_INFO "Intel machine check architecture supported.\n");
+	printk (KERN_DEBUG "Intel machine check architecture supported.\n");
 	rdmsr (MSR_IA32_MCG_CAP, l, h);
 	if (l & (1<<8))	/* Control register present ? */
 		wrmsr (MSR_IA32_MCG_CTL, 0xffffffff, 0xffffffff);
@@ -249,14 +249,14 @@ void __init intel_p4_mcheck_init(struct
 	}

 	set_in_cr4 (X86_CR4_MCE);
-	printk (KERN_INFO "Intel machine check reporting enabled on CPU#%d.\n",
+	printk (KERN_DEBUG "Intel machine check reporting enabled on CPU#%d.\n",
 		smp_processor_id());

 	/* Check for P4/Xeon extended MCE MSRs */
 	rdmsr (MSR_IA32_MCG_CAP, l, h);
 	if (l & (1<<9))	{/* MCG_EXT_P */
 		mce_num_extended_msrs = (l >> 16) & 0xff;
-		printk (KERN_INFO "CPU%d: Intel P4/Xeon Extended MCE MSRs (%d)"
+		printk (KERN_DEBUG "CPU%d: Intel P4/Xeon Extended MCE MSRs (%d)"
 				" available\n",
 			smp_processor_id(), mce_num_extended_msrs);

Index: linux-2.6.6-mm4/arch/i386/kernel/cpu/mcheck/p5.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.6-mm4/arch/i386/kernel/cpu/mcheck/p5.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 p5.c
--- linux-2.6.6-mm4/arch/i386/kernel/cpu/mcheck/p5.c	19 May 2004 12:28:16 -0000	1.1.1.1
+++ linux-2.6.6-mm4/arch/i386/kernel/cpu/mcheck/p5.c	21 May 2004 01:03:39 -0000
@@ -45,9 +45,9 @@ void __init intel_p5_mcheck_init(struct
 	/* Read registers before enabling */
 	rdmsr(MSR_IA32_P5_MC_ADDR, l, h);
 	rdmsr(MSR_IA32_P5_MC_TYPE, l, h);
-	printk(KERN_INFO "Intel old style machine check architecture supported.\n");
+	printk(KERN_DEBUG "Intel old style machine check architecture supported.\n");

  	/* Enable MCE */
 	set_in_cr4(X86_CR4_MCE);
-	printk(KERN_INFO "Intel old style machine check reporting enabled on CPU#%d.\n", smp_processor_id());
+	printk(KERN_DEBUG "Intel old style machine check reporting enabled on CPU#%d.\n", smp_processor_id());
 }
Index: linux-2.6.6-mm4/arch/i386/kernel/cpu/mcheck/p6.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.6-mm4/arch/i386/kernel/cpu/mcheck/p6.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 p6.c
--- linux-2.6.6-mm4/arch/i386/kernel/cpu/mcheck/p6.c	19 May 2004 12:28:16 -0000	1.1.1.1
+++ linux-2.6.6-mm4/arch/i386/kernel/cpu/mcheck/p6.c	21 May 2004 01:05:16 -0000
@@ -96,7 +96,7 @@ void __init intel_p6_mcheck_init(struct
 	machine_check_vector = intel_machine_check;
 	wmb();

-	printk (KERN_INFO "Intel machine check architecture supported.\n");
+	printk (KERN_DEBUG "Intel machine check architecture supported.\n");
 	rdmsr (MSR_IA32_MCG_CAP, l, h);
 	if (l & (1<<8))	/* Control register present ? */
 		wrmsr(MSR_IA32_MCG_CTL, 0xffffffff, 0xffffffff);
@@ -109,6 +109,6 @@ void __init intel_p6_mcheck_init(struct
 	}

 	set_in_cr4 (X86_CR4_MCE);
-	printk (KERN_INFO "Intel machine check reporting enabled on CPU#%d.\n",
+	printk (KERN_DEBUG "Intel machine check reporting enabled on CPU#%d.\n",
 		smp_processor_id());
 }
Index: linux-2.6.6-mm4/arch/i386/kernel/cpu/mcheck/winchip.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.6-mm4/arch/i386/kernel/cpu/mcheck/winchip.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 winchip.c
--- linux-2.6.6-mm4/arch/i386/kernel/cpu/mcheck/winchip.c	19 May 2004 12:28:16 -0000	1.1.1.1
+++ linux-2.6.6-mm4/arch/i386/kernel/cpu/mcheck/winchip.c	21 May 2004 01:05:46 -0000
@@ -32,5 +32,5 @@ void __init winchip_mcheck_init(struct c
 	lo&= ~(1<<4);	/* Enable MCE */
 	wrmsr(MSR_IDT_FCR1, lo, hi);
 	set_in_cr4(X86_CR4_MCE);
-	printk(KERN_INFO "Winchip machine check reporting enabled on CPU#0.\n");
+	printk(KERN_DEBUG "Winchip machine check reporting enabled on CPU#0.\n");
 }
Index: linux-2.6.6-mm4/arch/i386/kernel/cpu/mtrr/cyrix.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.6-mm4/arch/i386/kernel/cpu/mtrr/cyrix.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 cyrix.c
--- linux-2.6.6-mm4/arch/i386/kernel/cpu/mtrr/cyrix.c	19 May 2004 12:28:16 -0000	1.1.1.1
+++ linux-2.6.6-mm4/arch/i386/kernel/cpu/mtrr/cyrix.c	21 May 2004 02:34:03 -0000
@@ -330,16 +330,16 @@ cyrix_arr_init(void)
 	set_mtrr_done(&ctxt);	/* flush cache and disable MAPEN */

 	if (ccrc[5])
-		printk(KERN_INFO "mtrr: ARR usage was not enabled, enabled manually\n");
+		printk(KERN_DEBUG "mtrr: ARR usage was not enabled, enabled manually\n");
 	if (ccrc[3])
-		printk(KERN_INFO "mtrr: ARR3 cannot be changed\n");
+		printk(KERN_DEBUG "mtrr: ARR3 cannot be changed\n");
 /*
     if ( ccrc[1] & 0x80) printk ("mtrr: SMM memory access through ARR3 disabled\n");
     if ( ccrc[1] & 0x04) printk ("mtrr: SMM memory access disabled\n");
     if ( ccrc[1] & 0x02) printk ("mtrr: SMM mode disabled\n");
 */
 	if (ccrc[6])
-		printk(KERN_INFO "mtrr: ARR3 was write protected, unprotected\n");
+		printk(KERN_DEBUG "mtrr: ARR3 was write protected, unprotected\n");
 }

 static struct mtrr_ops cyrix_mtrr_ops = {
Index: linux-2.6.6-mm4/arch/i386/kernel/cpu/mtrr/generic.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.6-mm4/arch/i386/kernel/cpu/mtrr/generic.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 generic.c
--- linux-2.6.6-mm4/arch/i386/kernel/cpu/mtrr/generic.c	19 May 2004 12:28:16 -0000	1.1.1.1
+++ linux-2.6.6-mm4/arch/i386/kernel/cpu/mtrr/generic.c	21 May 2004 02:34:50 -0000
@@ -89,8 +89,8 @@ void __init mtrr_state_warn(void)
 		printk(KERN_WARNING "mtrr: your CPUs had inconsistent variable MTRR settings\n");
 	if (mask & MTRR_CHANGE_MASK_DEFTYPE)
 		printk(KERN_WARNING "mtrr: your CPUs had inconsistent MTRRdefType settings\n");
-	printk(KERN_INFO "mtrr: probably your BIOS does not setup all CPUs.\n");
-	printk(KERN_INFO "mtrr: corrected configuration.\n");
+	printk(KERN_DEBUG "mtrr: probably your BIOS does not setup all CPUs.\n");
+	printk(KERN_DEBUG "mtrr: corrected configuration.\n");
 }


Index: linux-2.6.6-mm4/arch/i386/kernel/cpu/mtrr/main.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.6-mm4/arch/i386/kernel/cpu/mtrr/main.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 main.c
--- linux-2.6.6-mm4/arch/i386/kernel/cpu/mtrr/main.c	19 May 2004 12:28:16 -0000	1.1.1.1
+++ linux-2.6.6-mm4/arch/i386/kernel/cpu/mtrr/main.c	21 May 2004 02:35:41 -0000
@@ -82,7 +82,7 @@ static int have_wrcomb(void)
 		   Don't allow it and leave room for other chipsets to be tagged */
 		if (dev->vendor == PCI_VENDOR_ID_SERVERWORKS &&
 		    dev->device == PCI_DEVICE_ID_SERVERWORKS_LE) {
-			printk(KERN_INFO "mtrr: Serverworks LE detected. Write-combining disabled.\n");
+			printk(KERN_DEBUG "mtrr: Serverworks LE detected. Write-combining disabled.\n");
 			return 0;
 		}
 		/* Intel 450NX errata # 23. Non ascending cachline evictions to
@@ -90,7 +90,7 @@ static int have_wrcomb(void)
 		if (dev->vendor == PCI_VENDOR_ID_INTEL &&
 		    dev->device == PCI_DEVICE_ID_INTEL_82451NX)
 		{
-			printk(KERN_INFO "mtrr: Intel 450NX MMC detected. Write-combining disabled.\n");
+			printk(KERN_DEBUG "mtrr: Intel 450NX MMC detected. Write-combining disabled.\n");
 			return 0;
 		}
 	}
@@ -372,7 +372,7 @@ int mtrr_add_page(unsigned long base, un
 		set_mtrr(i, base, size, type);
 		usage_table[i] = 1;
 	} else
-		printk(KERN_INFO "mtrr: no more MTRRs available\n");
+		printk(KERN_DEBUG "mtrr: no more MTRRs available\n");
 	error = i;
  out:
 	up(&main_lock);
@@ -516,7 +516,7 @@ int
 mtrr_del(int reg, unsigned long base, unsigned long size)
 {
 	if ((base & (PAGE_SIZE - 1)) || (size & (PAGE_SIZE - 1))) {
-		printk(KERN_INFO "mtrr: size and base must be multiples of 4 kiB\n");
+		printk(KERN_DEBUG "mtrr: size and base must be multiples of 4 kiB\n");
 		printk(KERN_DEBUG "mtrr: size: 0x%lx  base: 0x%lx\n", size, base);
 		return -EINVAL;
 	}
@@ -685,7 +685,7 @@ static int __init mtrr_init(void)
 			break;
 		}
 	}
-	printk(KERN_INFO "mtrr: v%s\n",MTRR_VERSION);
+	printk(KERN_DEBUG "mtrr: v%s\n",MTRR_VERSION);

 	if (mtrr_if) {
 		set_num_var_ranges();
Index: linux-2.6.6-mm4/arch/i386/mm/fault.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.6-mm4/arch/i386/mm/fault.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 fault.c
--- linux-2.6.6-mm4/arch/i386/mm/fault.c	19 May 2004 12:28:16 -0000	1.1.1.1
+++ linux-2.6.6-mm4/arch/i386/mm/fault.c	21 May 2004 02:37:35 -0000
@@ -450,7 +450,7 @@ out_of_memory:
 		down_read(&mm->mmap_sem);
 		goto survive;
 	}
-	printk("VM: killing process %s\n", tsk->comm);
+	printk(KERN_WARNING "VM: killing process %s\n", tsk->comm);
 	if (error_code & 4)
 		do_exit(SIGKILL);
 	goto no_context;
Index: linux-2.6.6-mm4/arch/i386/mm/init.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.6-mm4/arch/i386/mm/init.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 init.c
--- linux-2.6.6-mm4/arch/i386/mm/init.c	19 May 2004 12:28:16 -0000	1.1.1.1
+++ linux-2.6.6-mm4/arch/i386/mm/init.c	21 May 2004 02:39:42 -0000
@@ -406,7 +406,7 @@ void __init paging_init(void)

 void __init test_wp_bit(void)
 {
-	printk("Checking if this processor honours the WP bit even in supervisor mode... ");
+	printk(KERN_DEBUG "Checking if this processor honours the WP bit even in supervisor mode... ");

 	/* Any page-aligned address will do, the test is non-destructive */
 	__set_fixmap(FIX_WP_TEST, __pa(&swapper_pg_dir), PAGE_READONLY);
@@ -585,14 +585,14 @@ void free_initmem(void)
 		free_page(addr);
 		totalram_pages++;
 	}
-	printk (KERN_INFO "Freeing unused kernel memory: %dk freed\n", (__init_end - __init_begin) >> 10);
+	printk (KERN_DEBUG "Freeing unused kernel memory: %dk freed\n", (__init_end - __init_begin) >> 10);
 }

 #ifdef CONFIG_BLK_DEV_INITRD
 void free_initrd_mem(unsigned long start, unsigned long end)
 {
 	if (start < end)
-		printk (KERN_INFO "Freeing initrd memory: %ldk freed\n", (end - start) >> 10);
+		printk (KERN_DEBUG "Freeing initrd memory: %ldk freed\n", (end - start) >> 10);
 	for (; start < end; start += PAGE_SIZE) {
 		ClearPageReserved(virt_to_page(start));
 		set_page_count(virt_to_page(start), 1);
Index: linux-2.6.6-mm4/arch/i386/pci/acpi.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.6-mm4/arch/i386/pci/acpi.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 acpi.c
--- linux-2.6.6-mm4/arch/i386/pci/acpi.c	19 May 2004 12:28:16 -0000	1.1.1.1
+++ linux-2.6.6-mm4/arch/i386/pci/acpi.c	21 May 2004 02:43:45 -0000
@@ -20,7 +20,7 @@ static int __init pci_acpi_init(void)

 	if (!acpi_noirq) {
 		if (!acpi_pci_irq_init()) {
-			printk(KERN_INFO "PCI: Using ACPI for IRQ routing\n");
+			printk(KERN_DEBUG "PCI: Using ACPI for IRQ routing\n");
 			pcibios_scanned++;
 			pcibios_enable_irq = acpi_pci_irq_enable;
 		} else
Index: linux-2.6.6-mm4/arch/i386/pci/direct.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.6-mm4/arch/i386/pci/direct.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 direct.c
--- linux-2.6.6-mm4/arch/i386/pci/direct.c	19 May 2004 12:28:16 -0000	1.1.1.1
+++ linux-2.6.6-mm4/arch/i386/pci/direct.c	21 May 2004 02:43:20 -0000
@@ -252,7 +252,7 @@ static int __init pci_direct_init(void)
 		goto type2;

 	if (pci_check_type1()) {
-		printk(KERN_INFO "PCI: Using configuration type 1\n");
+		printk(KERN_DEBUG "PCI: Using configuration type 1\n");
 		raw_pci_ops = &pci_direct_conf1;
 		return 0;
 	}
@@ -269,7 +269,7 @@ static int __init pci_direct_init(void)
 		goto fail2;

 	if (pci_check_type2()) {
-		printk(KERN_INFO "PCI: Using configuration type 2\n");
+		printk(KERN_DEBUG "PCI: Using configuration type 2\n");
 		raw_pci_ops = &pci_direct_conf2;
 		return 0;
 	}
Index: linux-2.6.6-mm4/arch/i386/pci/fixup.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.6-mm4/arch/i386/pci/fixup.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 fixup.c
--- linux-2.6.6-mm4/arch/i386/pci/fixup.c	19 May 2004 12:28:16 -0000	1.1.1.1
+++ linux-2.6.6-mm4/arch/i386/pci/fixup.c	21 May 2004 02:44:26 -0000
@@ -38,7 +38,7 @@ static void __devinit pci_fixup_i450gx(s
 	 */
 	u8 busno;
 	pci_read_config_byte(d, 0x4a, &busno);
-	printk(KERN_INFO "PCI: i440KX/GX host bridge %s: secondary bus %02x\n", pci_name(d), busno);
+	printk(KERN_DEBUG "PCI: i440KX/GX host bridge %s: secondary bus %02x\n", pci_name(d), busno);
 	pci_scan_bus(busno, &pci_root_ops, NULL);
 	pcibios_last_bus = -1;
 }
Index: linux-2.6.6-mm4/arch/i386/pci/irq.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.6-mm4/arch/i386/pci/irq.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 irq.c
--- linux-2.6.6-mm4/arch/i386/pci/irq.c	19 May 2004 12:28:16 -0000	1.1.1.1
+++ linux-2.6.6-mm4/arch/i386/pci/irq.c	21 May 2004 02:42:18 -0000
@@ -112,7 +112,7 @@ static void __init pirq_peer_trick(void)
 		if (!busmap[i] || pci_find_bus(0, i))
 			continue;
 		if (pci_scan_bus(i, &pci_root_ops, NULL))
-			printk(KERN_INFO "PCI: Discovered primary peer bus %02x [IRQ]\n", i);
+			printk(KERN_DEBUG "PCI: Discovered primary peer bus %02x [IRQ]\n", i);
 	}
 	pcibios_last_bus = -1;
 }
@@ -367,7 +367,7 @@ static int pirq_sis_set(struct pci_dev *
 static int pirq_vlsi_get(struct pci_dev *router, struct pci_dev *dev, int pirq)
 {
 	if (pirq > 8) {
-		printk(KERN_INFO "VLSI router pirq escape (%d)\n", pirq);
+		printk(KERN_DEBUG "VLSI router pirq escape (%d)\n", pirq);
 		return 0;
 	}
 	return read_config_nybble(router, 0x74, pirq-1);
@@ -376,7 +376,7 @@ static int pirq_vlsi_get(struct pci_dev
 static int pirq_vlsi_set(struct pci_dev *router, struct pci_dev *dev, int pirq, int irq)
 {
 	if (pirq > 8) {
-		printk(KERN_INFO "VLSI router pirq escape (%d)\n", pirq);
+		printk(KERN_DEBUG "VLSI router pirq escape (%d)\n", pirq);
 		return 0;
 	}
 	write_config_nybble(router, 0x74, pirq-1, irq);
@@ -423,14 +423,14 @@ static int pirq_amd756_get(struct pci_de
 	{
 		irq = read_config_nybble(router, 0x56, pirq - 1);
 	}
-	printk(KERN_INFO "AMD756: dev %04x:%04x, router pirq : %d get irq : %2d\n",
+	printk(KERN_DEBUG "AMD756: dev %04x:%04x, router pirq : %d get irq : %2d\n",
 		dev->vendor, dev->device, pirq, irq);
 	return irq;
 }

 static int pirq_amd756_set(struct pci_dev *router, struct pci_dev *dev, int pirq, int irq)
 {
-	printk(KERN_INFO "AMD756: dev %04x:%04x, router pirq : %d SET irq : %2d\n",
+	printk(KERN_DEBUG "AMD756: dev %04x:%04x, router pirq : %d SET irq : %2d\n",
 		dev->vendor, dev->device, pirq, irq);
 	if (pirq <= 4)
 	{
@@ -589,7 +589,7 @@ static __init int ali_router_probe(struc
 	{
 	case PCI_DEVICE_ID_AL_M1533:
 	case PCI_DEVICE_ID_AL_M1563:
-		printk("PCI: Using ALI IRQ Router\n");
+		printk(KERN_DEBUG "PCI: Using ALI IRQ Router\n");
 			r->name = "ALI";
 			r->get = pirq_ali_get;
 			r->set = pirq_ali_set;
@@ -649,7 +649,7 @@ static void __init pirq_find_router(stru

 #ifdef CONFIG_PCI_BIOS
 	if (!rt->signature) {
-		printk(KERN_INFO "PCI: Using BIOS for IRQ routing\n");
+		printk(KERN_DEBUG "PCI: Using BIOS for IRQ routing\n");
 		r->set = pirq_bios_set;
 		r->name = "BIOS";
 		return;
@@ -678,7 +678,7 @@ static void __init pirq_find_router(stru
 		if (pirq_router_dev->vendor == h->vendor && h->probe(r, pirq_router_dev, pirq_router_dev->device))
 			break;
 	}
-	printk(KERN_INFO "PCI: Using IRQ router %s [%04x/%04x] at %s\n",
+	printk(KERN_DEBUG "PCI: Using IRQ router %s [%04x/%04x] at %s\n",
 		pirq_router.name,
 		pirq_router_dev->vendor,
 		pirq_router_dev->device,
@@ -791,7 +791,7 @@ static int pcibios_lookup_irq(struct pci
 		} else
 			return 0;
 	}
-	printk(KERN_INFO "PCI: %s IRQ %d for device %s\n", msg, irq, pci_name(dev));
+	printk(KERN_DEBUG "PCI: %s IRQ %d for device %s\n", msg, irq, pci_name(dev));

 	/* Update IRQ for all devices with the same pirq value */
 	while ((dev2 = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev2)) != NULL) {
@@ -808,7 +808,7 @@ static int pcibios_lookup_irq(struct pci
 			(!(pci_probe & PCI_USE_PIRQ_MASK) || \
 			((1 << dev2->irq) & mask)) ) {
 #ifndef CONFIG_PCI_USE_VECTOR
-		    		printk(KERN_INFO "IRQ routing conflict for %s, have irq %d, want irq %d\n",
+		    		printk(KERN_DEBUG "IRQ routing conflict for %s, have irq %d, want irq %d\n",
 				       pci_name(dev2), dev2->irq, irq);
 #endif
 		    		continue;
@@ -816,7 +816,7 @@ static int pcibios_lookup_irq(struct pci
 			dev2->irq = irq;
 			pirq_penalty[irq]++;
 			if (dev != dev2)
-				printk(KERN_INFO "PCI: Sharing IRQ %d with %s\n", irq, pci_name(dev2));
+				printk(KERN_DEBUG "PCI: Sharing IRQ %d with %s\n", irq, pci_name(dev2));
 		}
 	}
 	return 1;
@@ -878,7 +878,7 @@ static void __init pcibios_fixup_irqs(vo
 						!platform_legacy_irq(irq))
 						irq = IO_APIC_VECTOR(irq);

-					printk(KERN_INFO "PCI->APIC IRQ transform: (B%d,I%d,P%d) -> %d\n",
+					printk(KERN_DEBUG "PCI->APIC IRQ transform: (B%d,I%d,P%d) -> %d\n",
 						dev->bus->number, PCI_SLOT(dev->devfn), pin, irq);
 					dev->irq = irq;
 				}
@@ -978,7 +978,7 @@ int pirq_enable_irq(struct pci_dev *dev)
 					if (!platform_legacy_irq(irq))
 						irq = IO_APIC_VECTOR(irq);
 #endif
-					printk(KERN_INFO "PCI->APIC IRQ transform: (B%d,I%d,P%d) -> %d\n",
+					printk(KERN_DEBUG "PCI->APIC IRQ transform: (B%d,I%d,P%d) -> %d\n",
 						dev->bus->number, PCI_SLOT(dev->devfn), pin, irq);
 					dev->irq = irq;
 					return 0;
Index: linux-2.6.6-mm4/arch/i386/pci/legacy.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.6-mm4/arch/i386/pci/legacy.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 legacy.c
--- linux-2.6.6-mm4/arch/i386/pci/legacy.c	19 May 2004 12:28:16 -0000	1.1.1.1
+++ linux-2.6.6-mm4/arch/i386/pci/legacy.c	21 May 2004 02:45:45 -0000
@@ -25,7 +25,7 @@ static void __devinit pcibios_fixup_peer
 			if (!raw_pci_ops->read(0, n, devfn, PCI_VENDOR_ID, 2, &l) &&
 			    l != 0x0000 && l != 0xffff) {
 				DBG("Found device at %02x:%02x [%04x]\n", n, devfn, l);
-				printk(KERN_INFO "PCI: Discovered peer bus %02x\n", n);
+				printk(KERN_DEBUG "PCI: Discovered peer bus %02x\n", n);
 				pci_scan_bus(n, &pci_root_ops, NULL);
 				break;
 			}
@@ -35,15 +35,13 @@ static void __devinit pcibios_fixup_peer

 static int __init pci_legacy_init(void)
 {
-	if (!raw_pci_ops) {
-		printk("PCI: System does not support PCI\n");
+	if (!raw_pci_ops)
 		return 0;
-	}

 	if (pcibios_scanned++)
 		return 0;

-	printk("PCI: Probing PCI hardware\n");
+	printk(KERN_DEBUG "PCI: Probing PCI hardware\n");
 	pci_root_bus = pcibios_scan_root(0);

 	pcibios_fixup_peer_bridges();
Index: linux-2.6.6-mm4/arch/i386/pci/mmconfig.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.6-mm4/arch/i386/pci/mmconfig.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 mmconfig.c
--- linux-2.6.6-mm4/arch/i386/pci/mmconfig.c	19 May 2004 12:28:16 -0000	1.1.1.1
+++ linux-2.6.6-mm4/arch/i386/pci/mmconfig.c	21 May 2004 02:46:21 -0000
@@ -98,7 +98,7 @@ static int __init pci_mmcfg_init(void)
 	if (!pci_mmcfg_base_addr)
 		goto out;

-	printk(KERN_INFO "PCI: Using MMCONFIG\n");
+	printk(KERN_DEBUG "PCI: Using MMCONFIG\n");
 	raw_pci_ops = &pci_mmcfg;
 	pci_probe = (pci_probe & ~PCI_PROBE_MASK) | PCI_PROBE_MMCONF;

Index: linux-2.6.6-mm4/arch/i386/pci/pcbios.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.6-mm4/arch/i386/pci/pcbios.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 pcbios.c
--- linux-2.6.6-mm4/arch/i386/pci/pcbios.c	19 May 2004 12:28:16 -0000	1.1.1.1
+++ linux-2.6.6-mm4/arch/i386/pci/pcbios.c	21 May 2004 02:46:56 -0000
@@ -448,7 +448,7 @@ struct irq_routing_table * __devinit pci
 			rt->size = opt.size + sizeof(struct irq_routing_table);
 			rt->exclusive_irqs = map;
 			memcpy(rt->slots, (void *) page, opt.size);
-			printk(KERN_INFO "PCI: Using BIOS Interrupt Routing Table\n");
+			printk(KERN_DEBUG "PCI: Using BIOS Interrupt Routing Table\n");
 		}
 	}
 	free_page(page);
Index: linux-2.6.6-mm4/arch/i386/pci/visws.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.6-mm4/arch/i386/pci/visws.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 visws.c
--- linux-2.6.6-mm4/arch/i386/pci/visws.c	19 May 2004 12:28:16 -0000	1.1.1.1
+++ linux-2.6.6-mm4/arch/i386/pci/visws.c	21 May 2004 02:47:24 -0000
@@ -98,7 +98,7 @@ static int __init pcibios_init(void)
 	pci_bus0 = li_pcib_read16(LI_PCI_BUSNUM) & 0xff;
 	pci_bus1 = li_pcia_read16(LI_PCI_BUSNUM) & 0xff;

-	printk(KERN_INFO "PCI: Lithium bridge A bus: %u, "
+	printk(KERN_DEBUG "PCI: Lithium bridge A bus: %u, "
 		"bridge B (PIIX4) bus: %u\n", pci_bus1, pci_bus0);

 	raw_pci_ops = &pci_direct_conf1;
Index: linux-2.6.6-mm4/include/asm-i386/bugs.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.6-mm4/include/asm-i386/bugs.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 bugs.h
--- linux-2.6.6-mm4/include/asm-i386/bugs.h	19 May 2004 12:28:18 -0000	1.1.1.1
+++ linux-2.6.6-mm4/include/asm-i386/bugs.h	21 May 2004 03:02:25 -0000
@@ -98,12 +98,12 @@ static void __init check_fpu(void)
 		__buggy_fxsr_alignment();
 	}
 	if (cpu_has_fxsr) {
-		printk(KERN_INFO "Enabling fast FPU save and restore... ");
+		printk(KERN_DEBUG "Enabling fast FPU save and restore... ");
 		set_in_cr4(X86_CR4_OSFXSR);
 		printk("done.\n");
 	}
 	if (cpu_has_xmm) {
-		printk(KERN_INFO "Enabling unmasked SIMD FPU exception support... ");
+		printk(KERN_DEBUG "Enabling unmasked SIMD FPU exception support... ");
 		set_in_cr4(X86_CR4_OSXMMEXCPT);
 		printk("done.\n");
 	}
@@ -126,7 +126,7 @@ static void __init check_fpu(void)

 static void __init check_hlt(void)
 {
-	printk(KERN_INFO "Checking 'hlt' instruction... ");
+	printk(KERN_DEBUG "Checking 'hlt' instruction... ");
 	if (!boot_cpu_data.hlt_works_ok) {
 		printk("disabled\n");
 		return;
@@ -145,7 +145,7 @@ static void __init check_popad(void)
 #ifndef CONFIG_X86_POPAD_OK
 	int res, inp = (int) &res;

-	printk(KERN_INFO "Checking for popad bug... ");
+	printk(KERN_DEBUG "Checking for popad bug... ");
 	__asm__ __volatile__(
 	  "movl $12345678,%%eax; movl $0,%%edi; pusha; popa; movl (%%edx,%%edi),%%ecx "
 	  : "=&a" (res)
@@ -214,7 +214,7 @@ static void __init check_bugs(void)
 {
 	identify_cpu(&boot_cpu_data);
 #ifndef CONFIG_SMP
-	printk("CPU: ");
+	printk(KERN_INFO "CPU: ");
 	print_cpu_info(&boot_cpu_data);
 #endif
 	check_config();
