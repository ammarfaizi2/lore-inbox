Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161087AbWJYUVJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161087AbWJYUVJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 16:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965230AbWJYUVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 16:21:09 -0400
Received: from mga01.intel.com ([192.55.52.88]:15806 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S965229AbWJYUVF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 16:21:05 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,357,1157353200"; 
   d="scan'208"; a="151992568:sNHT30516339"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: HPET : Legacy Routing Replacement Enable - 3rd try.
Date: Wed, 25 Oct 2006 13:21:01 -0700
Message-ID: <EB12A50964762B4D8111D55B764A8454C9608C@scsmsx413.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: HPET : Legacy Routing Replacement Enable - 3rd try.
Thread-Index: Acb4BSXuiDd3iP2aTvq523bSljkAWgAXfIHA
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Om Narasimhan" <om.turyx@gmail.com>, <linux-kernel@vger.kernel.org>
Cc: <randy.dunlap@oracle.com>, <omanakuttan.potty@sun.com>,
       <clemens@ladisch.de>, <ak@muc.de>, <vojtech@suse.cz>,
       <bob.picco@hp.com>, <omanakuttan@imap.cc>
X-OriginalArrivalTime: 25 Oct 2006 20:21:02.0427 (UTC) FILETIME=[176832B0:01C6F873]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


General comment. I guess this patch will conflict with timer cleanups
and hrt timer patches. This patch being smaller, it may be easier to
rebase this against hrt timer patches. 

Other comments inlined below...

>-----Original Message-----
>From: Om Narasimhan [mailto:om.turyx@gmail.com] 
>Sent: Wednesday, October 25, 2006 12:14 AM
>To: linux-kernel@vger.kernel.org
>Cc: randy.dunlap@oracle.com; omanakuttan.potty@sun.com; 
>clemens@ladisch.de; ak@muc.de; vojtech@suse.cz; 
>bob.picco@hp.com; Pallipadi, Venkatesh; omanakuttan@imap.cc
>Subject: HPET : Legacy Routing Replacement Enable - 3rd try.
>
>I have incorporated Randy's comments.
>CC-ing HPET developers.
>
>Patch here.
>Signed-off-by: Om Narasimhan <om.turyx@gmail.com>
>
>
> Documentation/hpet.txt              |   56 
>+++++++++++++++++++++++++++++++++++
> Documentation/kernel-parameters.txt |    9 ++++++
> arch/i386/kernel/acpi/boot.c        |   18 +++++++++++
> arch/i386/kernel/time_hpet.c        |    3 +-
> arch/x86_64/kernel/time.c           |   16 +++++++---
> include/asm-x86_64/hpet.h           |    1 +
> include/linux/acpi.h                |    1 +
> include/linux/hpet.h                |    7 ++++
> 8 files changed, 105 insertions(+), 6 deletions(-)
>
>diff --git a/Documentation/hpet.txt b/Documentation/hpet.txt
>index b7a3dc3..ca62b69 100644
>--- a/Documentation/hpet.txt
>+++ b/Documentation/hpet.txt
>@@ -298,3 +298,59 @@ members of the hpet_task structure befor
> hpet_control simply vectors to the hpet_ioctl routine and has the same
> commands and respective arguments as the user API.  hpet_unregister
> is used to terminate usage of the HPET timer reserved by 
>hpet_register.
>+
>+		HPET Legacy Replacement Route option (hpet_lrr)
>+
>+HPET is capable of replacing the IRQ0 (connected INT0 PIN) routing for
>+timer interrupt. The capability register (at offset 0 of HPET
>+base address) has a bit specifying if HPET chip is capbale of doing
>+this. OS can read the bit either from HW or ACPI table. (HPET ACPI
>+description table -> Event Timer block -> bit 15, page 30 of HPET
>+spec).  Ideally (I think so!) BIOS should set the ACPI table 
>than letting
>+the OS read H/W, which gives the BIOS a way to configure either legacy
>+or Legacy replacement modes.
>+
>+Typically the motherboard has BIOS configured / hardwired IRQ0 to INT0
>+(pin of APIC) connection. Linux assumes IRQ0 connected to 
>INT0 unless it is
>+supplied using an override parameter in the MPTable. Some 
>NVidia chipsets /
>+BIOS initialization code had configured to override IRQ0 -> 
>INT0 connection
>+and later a parameter was introduce 
>(acpi_skip_timer_override) to get IRQ0 ->
>+INT0 connection right.
>+
>+But a number of bioses (both phoenix and AMI) are not working as
>+expected. (I have an AMI BIOS which sets ACPI table bit 15 to 
>0 and then
>+connect IRQ0 -> INT2 internally, Another bios I have sets the 
>ACPI table bit
>+15 to 0, but does not connect IRQ0 -> INT2. Both would result 
>in a hang in
>+calibrate_delay() since there would not be any timer 
>interrupts So I have
>+provided a command line parameter which overrides
>+the BIOS ACPI entry. So, irrespctive of the BIOS' HPET ACPI Descriptor
>+table settings, if the parameter hpet_lrr=[0,1] is specified, it takes
>+precedence.
>+
>+* When to use this parameter?
>+
>+Some latest versions CK-804 (e.g),(Actually the code initializes the
>+CK804 in the BIOS), would correctly set the HPET such that 
>there would not
>+be any interrupts on INT0. Linux does not handle this 
>situation very well
>+because in linux, if HW is LRR capable, it is enabled from 
>the OS. Still the
>+timer interrupt handler is setup for IRQ0. Under this 
>situation, you can 
>+force the parameter hpet_lrr=1, so that IRQ2 is timer interrupts.
>+
>+[root@mophia ~]# cat /proc/interrupts | grep 2:
>+ 2:        163          0          0          0          1          7
>+207     955341    IO-APIC-edge  timer
>+
>+[root@mophia ~]# uptime
>+ 22:52:38 up 15 min,  2 users,  load average: 0.00, 0.01, 0.02
>+
>+[root@mophia ~]# dmesg | grep -i MP-BIOS
>+
>+For 15 mts (900 sec), around 95k interrupts on timer looks kinda fine.
>+
>+* Known Bugs:
>+I have tested it only with Nvidia CK-804. There seem to be 
>some kind of timing
>+issue between enabling the HPET with LRR set and start of 
>tinerrupts. As a
>+result of which, calibrate_delay() hangs because there are no 
>interrupts. If
>+you run into such a case, pass lpj=<bogomips * 500> as a work 
>around. i.e, if
>+your bogomips is 5000, pass lpj=2500000
>+
>diff --git a/Documentation/kernel-parameters.txt 
>b/Documentation/kernel-parameters.txt
>index dd00fd5..7916ff5 100644
>--- a/Documentation/kernel-parameters.txt
>+++ b/Documentation/kernel-parameters.txt
>@@ -366,6 +366,15 @@ and is between 256 and 4096 characters. 
> 	hpet=		[IA-32,HPET] option to disable HPET and use PIT.
> 			Format: disable
> 
>+	hpet_lrr=	[IA32,X86_64,HPET] Option to 
>enable/disable the HPET
>+			Legacy replacement route. Please read 
>Documentation/
>+			hpet.txt for more info.
>+			Format : {"0" | "1"}
>+			0 -> Disables Legacy Route Replacement. 
>(Default)
>+			1 -> Enables LRR. Please consult your BIOS
>+			documentation before doing this.
>+			
>+
> 	cm206=		[HW,CD]
> 			Format: { auto | [<io>,][<irq>] }
> 
>diff --git a/arch/i386/kernel/acpi/boot.c 
>b/arch/i386/kernel/acpi/boot.c
>index ab974ff..2c5a798 100644
>--- a/arch/i386/kernel/acpi/boot.c
>+++ b/arch/i386/kernel/acpi/boot.c
>@@ -82,6 +82,17 @@ EXPORT_SYMBOL(acpi_strict);
> acpi_interrupt_flags acpi_sci_flags __initdata;
> int acpi_sci_override_gsi __initdata;
> int acpi_skip_timer_override __initdata;
>+/* HPET Legacy routing replacement option passed through ACPI Table */
>+int acpi_hpet_lrr;
>+/* cmdline opt. for faulty bioses not setting ACPI HPET entry right */
>+int hpet_lrr_force;
>+
>+static int hpet_lrr_setup (char *str)
>+{
>+	get_option(&str, &hpet_lrr_force);
>+	return 1;
>+}
>+__setup ("hpet_lrr=", hpet_lrr_setup);
> 
> #ifdef CONFIG_X86_LOCAL_APIC
> static u64 acpi_lapic_addr __initdata = APIC_DEFAULT_PHYS_BASE;
>@@ -669,6 +680,13 @@ #define HPET_RESOURCE_NAME_SIZE 9
> 			 "HPET %u", hpet_tbl->number);
> 		hpet_res->end = (1 * 1024) - 1;
> 	}
>+	acpi_hpet_lrr = (hpet_tbl->id & ACPI_HPET_LRR_CAP) ? 1 : 0;
>+	/* Print a message about the bios HPET ACPI Desc Table passed.
>+	 * LRR bit should not be set in the table unless IRQ0->INT2 is
>+	 * connected. But BIOS may be faulty ...
>+	 */
>+	printk(KERN_INFO PREFIX "HPET id: %#x. ACPI LRR bit %s SET\n",
>+			hpet_tbl->id, acpi_hpet_lrr ? "": "NOT");

I don't see acpi_hpet_lrr getting used anywhere in the patch? Are you
planning to change it in any subsequent patches?

> 
> #ifdef	CONFIG_X86_64
> 	vxtime.hpet_address = hpet_tbl->addr.addrl |
>diff --git a/arch/i386/kernel/time_hpet.c 
>b/arch/i386/kernel/time_hpet.c
>index 1a2a979..01b2f67 100644
>--- a/arch/i386/kernel/time_hpet.c
>+++ b/arch/i386/kernel/time_hpet.c
>@@ -94,7 +94,8 @@ static int hpet_timer_stop_set_go(unsign
>  	 * Go!
>  	 */
> 	cfg = hpet_readl(HPET_CFG);
>-	if (hpet_use_timer)
>+	/* Ideally the following should be &&(acpi_hpet_lrr || 
>hpet_lrr_force) */
>+	if (hpet_use_timer && hpet_lrr_force)

What will be the value of hpet_lrr_force if no boot parameter was used.
It will end up coming from uninitialized data section. Right?

So, CFG_LEGACY will not be set on any platforms unless lrr_force
parameter is used? Is that the intention or am I missing something?

> 		cfg |= HPET_CFG_LEGACY;
> 	cfg |= HPET_CFG_ENABLE;
> 	hpet_writel(cfg, HPET_CFG);
>diff --git a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
>index 1ba5a44..0f5d990 100644
>--- a/arch/x86_64/kernel/time.c
>+++ b/arch/x86_64/kernel/time.c
>@@ -46,9 +46,6 @@ #include <asm/apic.h>
> #ifdef CONFIG_CPU_FREQ
> static void cpufreq_delayed_get(void);
> #endif
>-extern void i8254_timer_resume(void);
>-extern int using_apic_timer;
>-
> static char *timename = NULL;
> 
> DEFINE_SPINLOCK(rtc_lock);
>@@ -783,7 +780,10 @@ static int hpet_timer_stop_set_go(unsign
> 		    HPET_TN_32BIT, HPET_T0_CFG);
> 		hpet_writel(hpet_tick, HPET_T0_CMP); /* next 
>interrupt */
> 		hpet_writel(hpet_tick, HPET_T0_CMP); /* period */
>-		cfg |= HPET_CFG_LEGACY;
>+		/* Ideal value (acpi_hpet_lrr || hpet_lrr_force) */
>+		if (hpet_lrr_force)
>+			cfg |= HPET_CFG_LEGACY;
>+
> 	}
> /*
>  * Go!
>@@ -887,6 +887,7 @@ time_cpu_notifier(struct notifier_block 
> 
> void __init time_init(void)
> {
>+	int timer_irq = 0;
> 	if (nohpet)
> 		vxtime.hpet_address = 0;
> 
>@@ -906,6 +907,10 @@ void __init time_init(void)
> 	  	tick_nsec = TICK_NSEC_HPET;
> 		cpu_khz = hpet_calibrate_tsc();
> 		timename = "HPET";
>+		/* Ideal value is (acpi_hpet_lrr || hpet_lrr_force) */
>+		if (hpet_lrr_force)
>+			timer_irq = HPET_TIMER_LRR_IRQ;
>+
> #ifdef CONFIG_X86_PM_TIMER
> 	} else if (pmtmr_ioport && !vxtime.hpet_address) {
> 		vxtime_hz = PM_TIMER_FREQUENCY;
>@@ -924,7 +929,8 @@ #endif
> 	vxtime.tsc_quot = (USEC_PER_MSEC << US_SCALE) / cpu_khz;
> 	vxtime.last_tsc = get_cycles_sync();
> 	set_cyc2ns_scale(cpu_khz);
>-	setup_irq(0, &irq0);
>+	printk(KERN_WARNING PREFIX "Registering Timer IRQ = 
>%d\n", timer_irq);

Why is this an unconditional warning?

Thanks,
Venki
