Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965217AbWJYUJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965217AbWJYUJd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 16:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965223AbWJYUJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 16:09:33 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:17651 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965217AbWJYUJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 16:09:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CaaIpyvgXHiUNWepy9wMPWll+ZgsWiYoxx/MSrtQDy+ZC7K1x/rz88zagc0zicFw+88b0Y152YbXnjdYUQAFDYcFMX7z9FRq8uUqMhm4HESLi1/iXEmpace6K9TF+EZ/ns9UKIEKr6DllaHZJtCjdyovi1Sy6bRmN6vNew7RhyU=
Message-ID: <6b4e42d10610251309j4350c68co8f131a32f3b05644@mail.gmail.com>
Date: Wed, 25 Oct 2006 13:09:30 -0700
From: "Om Narasimhan" <om.turyx@gmail.com>
To: "Andi Kleen" <ak@suse.de>
Subject: Re: HPET : Legacy Routing Replacement Enable - 3rd try.
Cc: randy.dunlap@oracle.com, omanakuttan.potty@sun.com, clemens@ladisch.de,
       vojtech@suse.cz, bob.picco@hp.com, venkatesh.pallipadi@intel.com,
       omanakuttan@imap.cc, linux-kernel@vger.kernel.org
In-Reply-To: <p731wowmdlz.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200610250013.48194.om.turyx@gmail.com>
	 <p731wowmdlz.fsf@verdi.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Thanks for comments. I have split the patches into three.

Rationale:
Some enterprise servers' (e.g, SunFire 4600 series) BIOS sets up the
IRQ0 -> INT2 mapping  as per HPET specifications. (BIOS engineers
explained that this routing is required for another major commercial
OS's forthcoming version to work).
Linux currently assumes timer interrupt is at IRQ0 (implying
IRQ0->INT0) connection setup by the bios. In this scenario, IRQ0 would
not generate any interrupts and we get the following message :
........
Boot done.
..MP-BIOS bug: 8254 timer not connected to IO-APIC
 failed.
timer doesn't work through the IO-APIC - disabling NMI Watchdog!
Using local APIC timer interrupts.
........
When AMD Powernow (TM) is enabled, APIC interrupt does not work as
expected and we observe strange behaviour like lost ticks...etc and
occasional crashes.

I expect that more and more BIOSes would start implementing the
routing as per specifications and linux kernel might face this problem
sooner or later.

Regards,
Om.

Patch 01/03 : Arch specific (i386 and x86_64)

Signed-Off-by : Om Narasimhan <om.turyx@gmail.com>
 arch/i386/kernel/acpi/boot.c |   18 ++++++++++++++++++
 arch/i386/kernel/time_hpet.c |    3 ++-
 arch/x86_64/kernel/time.c    |   16 +++++++++++-----
 3 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/arch/i386/kernel/acpi/boot.c b/arch/i386/kernel/acpi/boot.c
index 92f79cd..3d30e2f 100644
--- a/arch/i386/kernel/acpi/boot.c
+++ b/arch/i386/kernel/acpi/boot.c
@@ -82,6 +82,17 @@ EXPORT_SYMBOL(acpi_strict);
 acpi_interrupt_flags acpi_sci_flags __initdata;
 int acpi_sci_override_gsi __initdata;
 int acpi_skip_timer_override __initdata;
+/* HPET Legacy routing replacement option passed through ACPI Table */
+int acpi_hpet_lrr;
+/* cmdline opt. for faulty bioses not setting ACPI HPET entry right */
+int hpet_lrr_force;
+
+static int hpet_lrr_setup (char *str)
+{
+	get_option(&str, &hpet_lrr_force);
+	return 1;
+}
+__setup ("hpet_lrr=", hpet_lrr_setup);

 #ifdef CONFIG_X86_LOCAL_APIC
 static u64 acpi_lapic_addr __initdata = APIC_DEFAULT_PHYS_BASE;
@@ -669,6 +680,13 @@ #define HPET_RESOURCE_NAME_SIZE 9
 			 "HPET %u", hpet_tbl->number);
 		hpet_res->end = (1 * 1024) - 1;
 	}
+	acpi_hpet_lrr = (hpet_tbl->id & ACPI_HPET_LRR_CAP) ? 1 : 0;
+	/* Print a message about the bios HPET ACPI Desc Table passed.
+	 * LRR bit should not be set in the table unless IRQ0->INT2 is
+	 * connected. But BIOS may be faulty ...
+	 */
+	printk(KERN_INFO PREFIX "HPET id: %#x. ACPI LRR bit %s SET\n",
+			hpet_tbl->id, acpi_hpet_lrr ? "": "NOT");

 #ifdef	CONFIG_X86_64
 	vxtime.hpet_address = hpet_tbl->addr.addrl |
diff --git a/arch/i386/kernel/time_hpet.c b/arch/i386/kernel/time_hpet.c
index 1a2a979..01b2f67 100644
--- a/arch/i386/kernel/time_hpet.c
+++ b/arch/i386/kernel/time_hpet.c
@@ -94,7 +94,8 @@ static int hpet_timer_stop_set_go(unsign
  	 * Go!
  	 */
 	cfg = hpet_readl(HPET_CFG);
-	if (hpet_use_timer)
+	/* Ideally the following should be &&(acpi_hpet_lrr || hpet_lrr_force) */
+	if (hpet_use_timer && hpet_lrr_force)
 		cfg |= HPET_CFG_LEGACY;
 	cfg |= HPET_CFG_ENABLE;
 	hpet_writel(cfg, HPET_CFG);
diff --git a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
index 1ba5a44..0f5d990 100644
--- a/arch/x86_64/kernel/time.c
+++ b/arch/x86_64/kernel/time.c
@@ -46,9 +46,6 @@ #include <asm/apic.h>
 #ifdef CONFIG_CPU_FREQ
 static void cpufreq_delayed_get(void);
 #endif
-extern void i8254_timer_resume(void);
-extern int using_apic_timer;
-
 static char *timename = NULL;

 DEFINE_SPINLOCK(rtc_lock);
@@ -783,7 +780,10 @@ static int hpet_timer_stop_set_go(unsign
 		    HPET_TN_32BIT, HPET_T0_CFG);
 		hpet_writel(hpet_tick, HPET_T0_CMP); /* next interrupt */
 		hpet_writel(hpet_tick, HPET_T0_CMP); /* period */
-		cfg |= HPET_CFG_LEGACY;
+		/* Ideal value (acpi_hpet_lrr || hpet_lrr_force) */
+		if (hpet_lrr_force)
+			cfg |= HPET_CFG_LEGACY;
+
 	}
 /*
  * Go!
@@ -887,6 +887,7 @@ time_cpu_notifier(struct notifier_block

 void __init time_init(void)
 {
+	int timer_irq = 0;
 	if (nohpet)
 		vxtime.hpet_address = 0;

@@ -906,6 +907,10 @@ void __init time_init(void)
 	  	tick_nsec = TICK_NSEC_HPET;
 		cpu_khz = hpet_calibrate_tsc();
 		timename = "HPET";
+		/* Ideal value is (acpi_hpet_lrr || hpet_lrr_force) */
+		if (hpet_lrr_force)
+			timer_irq = HPET_TIMER_LRR_IRQ;
+
 #ifdef CONFIG_X86_PM_TIMER
 	} else if (pmtmr_ioport && !vxtime.hpet_address) {
 		vxtime_hz = PM_TIMER_FREQUENCY;
@@ -924,7 +929,8 @@ #endif
 	vxtime.tsc_quot = (USEC_PER_MSEC << US_SCALE) / cpu_khz;
 	vxtime.last_tsc = get_cycles_sync();
 	set_cyc2ns_scale(cpu_khz);
-	setup_irq(0, &irq0);
+	printk(KERN_WARNING PREFIX "Registering Timer IRQ = %d\n", timer_irq);
+	setup_irq(timer_irq, &irq0);
 	hotcpu_notifier(time_cpu_notifier, 0);
 	time_cpu_notifier(NULL, CPU_ONLINE, (void *)(long)smp_processor_id());
