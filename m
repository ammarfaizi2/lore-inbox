Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261264AbULWQNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbULWQNN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 11:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbULWQNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 11:13:13 -0500
Received: from aun.it.uu.se ([130.238.12.36]:24196 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261264AbULWQNB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 11:13:01 -0500
Date: Thu, 23 Dec 2004 17:11:39 +0100 (MET)
Message-Id: <200412231611.iBNGBdLY022571@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: vda@port.imtp.ilyichevsk.odessa.ua, wli@holomorphy.com
Subject: Re: 2.6.x BUGs at boot time (APIC related)
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Dec 2004 14:57:25 +0000, Denis Vlasenko wrote:
>> On Thu, Dec 23, 2004 at 11:02:09AM +0000, Denis Vlasenko wrote:
>> > Tested with noapic nolapic boot params. Still happens.
>> > Call chain is init() -> APIC_init_uniprocessor() ->
>> > ->  setup_local_APIC(). I am a bit suspicious why
>> > APIC_init_uniprocessor() does not bail out
>> > if enable_local_apic<0 (i.e. if I boot with "nolapic"):
>> > int __init APIC_init_uniprocessor (void)
>> > {
>> >         if (enable_local_apic < 0)
>> >                 clear_bit(X86_FEATURE_APIC,
>> > boot_cpu_data.x86_capability); <=3D=3D=3D=3D=3D missing "return -1"?
>> >
>> >         if (!smp_found_config && !cpu_has_apic)
>> >                 return -1;
>> > ...
>>
>> Sounds pretty serious. What happens if you add the missing return -1?
>
>Just tested that. It booted ok. Patch is in attachment.

The early return just hides the real bug, whatever it is.
I'm suspecting some bogosity with boot_cpu_physical_apicid,
or possibly smp_found_config. Please remove the early return
and try the patch below instead.

/Mikael

--- linux-2.6.10-rc3/arch/i386/kernel/apic.c.~1~	2004-12-23 15:44:26.000000000 +0100
+++ linux-2.6.10-rc3/arch/i386/kernel/apic.c	2004-12-23 16:38:27.000000000 +0100
@@ -363,7 +363,7 @@ void __init init_bsp_APIC(void)
 	apic_write_around(APIC_LVT1, value);
 }
 
-void __init setup_local_APIC (void)
+int __init setup_local_APIC (void)
 {
 	unsigned long oldvalue, value, ver, maxlvt;
 
@@ -384,8 +384,10 @@ void __init setup_local_APIC (void)
 	/*
 	 * Double-check whether this APIC is really registered.
 	 */
+	printk("%s: boot_cpu_physical_apicid == %#x\n", __FUNCTION__, boot_cpu_physical_apicid);
+	printk("%s: apic_read(APIC_ID) == %#lx\n", __FUNCTION__, apic_read(APIC_ID));
 	if (!apic_id_registered())
-		BUG();
+		return -1;
 
 	/*
 	 * Intel recommends to set DFR, LDR and TPR before enabling
@@ -511,6 +513,7 @@ void __init setup_local_APIC (void)
 	if (nmi_watchdog == NMI_LOCAL_APIC)
 		setup_apic_nmi_watchdog();
 	apic_pm_activate();
+	return 0;
 }
 
 /*
@@ -809,6 +812,8 @@ void __init init_apic_mappings(void)
 	 */
 	if (boot_cpu_physical_apicid == -1U)
 		boot_cpu_physical_apicid = GET_APIC_ID(apic_read(APIC_ID));
+	printk("%s: boot_cpu_physical_apicid == %#x\n", __FUNCTION__, boot_cpu_physical_apicid);
+	printk("%s: apic_read(APIC_ID) == %#lx\n", __FUNCTION__, apic_read(APIC_ID));
 
 #ifdef CONFIG_X86_IO_APIC
 	{
@@ -1271,7 +1276,8 @@ int __init APIC_init_uniprocessor (void)
 
 	phys_cpu_present_map = physid_mask_of_physid(boot_cpu_physical_apicid);
 
-	setup_local_APIC();
+	if (setup_local_APIC() < 0)
+		return -1;
 
 	if (nmi_watchdog == NMI_LOCAL_APIC)
 		check_nmi_watchdog();
--- linux-2.6.10-rc3/arch/i386/kernel/mpparse.c.~1~	2004-12-23 15:44:26.000000000 +0100
+++ linux-2.6.10-rc3/arch/i386/kernel/mpparse.c	2004-12-23 16:32:16.000000000 +0100
@@ -180,6 +180,7 @@ void __init MP_processor_info (struct mp
 	if (m->mpc_cpuflag & CPU_BOOTPROCESSOR) {
 		Dprintk("    Bootup CPU\n");
 		boot_cpu_physical_apicid = m->mpc_apicid;
+		printk("%s: boot_cpu_physical_apicid == %#x\n", __FUNCTION__, boot_cpu_physical_apicid);
 		boot_cpu_logical_apicid = apicid;
 	}
 
@@ -823,6 +824,7 @@ void __init mp_register_lapic_address (
 
 	if (boot_cpu_physical_apicid == -1U)
 		boot_cpu_physical_apicid = GET_APIC_ID(apic_read(APIC_ID));
+	printk("%s: boot_cpu_physical_apicid == %#x\n", __FUNCTION__, boot_cpu_physical_apicid);
 
 	Dprintk("Boot CPU = %d\n", boot_cpu_physical_apicid);
 }
--- linux-2.6.10-rc3/arch/i386/kernel/smpboot.c.~1~	2004-10-19 13:01:17.000000000 +0200
+++ linux-2.6.10-rc3/arch/i386/kernel/smpboot.c	2004-12-23 16:33:33.000000000 +0100
@@ -913,6 +913,7 @@ static void __init smp_boot_cpus(unsigne
 	print_cpu_info(&cpu_data[0]);
 
 	boot_cpu_physical_apicid = GET_APIC_ID(apic_read(APIC_ID));
+	printk("%s: boot_cpu_physical_apicid == %#x\n", __FUNCTION__, boot_cpu_physical_apicid);
 	boot_cpu_logical_apicid = logical_smp_processor_id();
 	x86_cpu_to_apicid[0] = boot_cpu_physical_apicid;
 
--- linux-2.6.10-rc3/include/asm-i386/apic.h.~1~	2004-12-23 15:44:30.000000000 +0100
+++ linux-2.6.10-rc3/include/asm-i386/apic.h	2004-12-23 16:37:53.000000000 +0100
@@ -94,7 +94,7 @@ extern int verify_local_APIC (void);
 extern void cache_APIC_registers (void);
 extern void sync_Arb_IDs (void);
 extern void init_bsp_APIC (void);
-extern void setup_local_APIC (void);
+extern int setup_local_APIC (void);
 extern void init_apic_mappings (void);
 extern void smp_local_timer_interrupt (struct pt_regs * regs);
 extern void setup_boot_APIC_clock (void);
