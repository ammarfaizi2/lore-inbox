Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264263AbUDOPHl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 11:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264159AbUDOPHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 11:07:41 -0400
Received: from gizmo11ps.bigpond.com ([144.140.71.21]:18623 "HELO
	gizmo11ps.bigpond.com") by vger.kernel.org with SMTP
	id S264263AbUDOPHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 11:07:18 -0400
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: Len Brown <len.brown@intel.com>
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH] for idle=C1halt, 2.6.5
Date: Fri, 16 Apr 2004 01:10:37 +1000
User-Agent: KMail/1.5.1
Cc: christian.kroener@tu-harburg.de, linux-kernel@vger.kernel.org,
       "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       Jamie Lokier <jamie@shareable.org>,
       "Prakash K. Cheemplavam" <PrakashKC@gmx.de>,
       Craig Bradney <cbradney@zip.com.au>, Daniel Drake <dan@reactivated.net>,
       Ian Kumlien <pomac@vapor.com>, Jesse Allen <the3dfxdude@hotmail.com>,
       a.verweij@student.tudelft.nl
References: <200404131117.31306.ross@datscreative.com.au> <200404131703.09572.ross@datscreative.com.au> <1081893978.2251.653.camel@dhcppc4>
In-Reply-To: <1081893978.2251.653.camel@dhcppc4>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_tXqfAXOsT9S/HmD"
Message-Id: <200404160110.37573.ross@datscreative.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_tXqfAXOsT9S/HmD
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 14 April 2004 11:02, Len Brown wrote:
> Re: IRQ0 XT-PIC timer issue
> 
> Since the hardware is connected to APIC pin0, it is a BIOS bug
> that an ACPI interrupt source override from pin2 to IRQ0 exists.
> 
> With this simple 2.6.5 patch you can specify "acpi_skip_timer_override"
> to ignore that bogus BIOS directive.  The result is with your
> ACPI-enabled APIC-enabled kernel, you'll get IRQ0 IO-APIC-edge timer.
> 
> Probably there is a more clever way to trigger this workaround
> automatcially instead of via boot parameter.
> 
> cheers,
> -Len
> 
> ===== Documentation/kernel-parameters.txt 1.44 vs edited =====
> --- 1.44/Documentation/kernel-parameters.txt	Mon Mar 22 16:03:22 2004
> +++ edited/Documentation/kernel-parameters.txt	Tue Apr 13 17:47:11 2004
> @@ -122,6 +122,10 @@
>  
>  	acpi_serialize	[HW,ACPI] force serialization of AML methods
>  
> +	acpi_skip_timer_override [HW,ACPI]]
> +			Recognize IRQ0/pin2 Interrupt Source Override
> +			and ignore it -- for broken nForce2 BIOS.
> +
>  	ad1816=		[HW,OSS]
>  			Format: <io>,<irq>,<dma>,<dma2>
>  			See also Documentation/sound/oss/AD1816.
> ===== arch/i386/kernel/setup.c 1.115 vs edited =====
> --- 1.115/arch/i386/kernel/setup.c	Fri Apr  2 07:21:43 2004
> +++ edited/arch/i386/kernel/setup.c	Tue Apr 13 17:41:31 2004
> @@ -614,6 +614,12 @@
>  		else if (!memcmp(from, "acpi_sci=low", 12))
>  			acpi_sci_flags.polarity = 3;
>  
> +		else if (!memcmp(from, "acpi_skip_timer_override", 24)) {
> +			extern int acpi_skip_timer_override;
> +
> +			acpi_skip_timer_override = 1;
> +		}
> +
>  #ifdef CONFIG_X86_LOCAL_APIC
>  		/* disable IO-APIC */
>  		else if (!memcmp(from, "noapic", 6))
> ===== arch/i386/kernel/acpi/boot.c 1.57 vs edited =====
> --- 1.57/arch/i386/kernel/acpi/boot.c	Tue Mar 30 17:05:19 2004
> +++ edited/arch/i386/kernel/acpi/boot.c	Tue Apr 13 17:50:14 2004
> @@ -62,6 +62,7 @@
>  
>  acpi_interrupt_flags acpi_sci_flags __initdata;
>  int acpi_sci_override_gsi __initdata;
> +int acpi_skip_timer_override __initdata;
>  
>  #ifdef CONFIG_X86_LOCAL_APIC
>  static u64 acpi_lapic_addr __initdata = APIC_DEFAULT_PHYS_BASE;
> @@ -327,6 +328,12 @@
>  		acpi_sci_ioapic_setup(intsrc->global_irq,
>  			intsrc->flags.polarity, intsrc->flags.trigger);
>  		return 0;
> +	}
> +
> +	if (acpi_skip_timer_override &&
> +		intsrc->bus_irq == 0 && intsrc->global_irq == 2) {
> +			printk(PREFIX "BIOS IRQ0 pin2 override ignored.\n");
> +			return 0;
>  	}
>  
>  	mp_override_legacy_irq (
> 
> 
> 

Hi Len, I have updated my nforce2 patches for 2.6.5 to work with your patch.
I have tested them only on one nforce2 board Epox 8Rga+ but as little has
changed in core functionality from past releases I think all will be OK....
Hopefully no clock skew. I saw none on my system but thats no guarantee.
 
I tried your above patch with the timer_ack on as is default in 2.6.5 and
nmi_watchdog=1 failed as expected. I still think Maciej's 8259 ack patch 
is more complete solution to the ack issue but this one gets watchdog going for
nforce2. I cannot see anyone using your above patch without an integrated
apic and tsc so I cannot see a problem triggering it off your kern arg.

The second patch is the C1halt update I suggested in another posting.
http://linux.derkeiler.com/Mailing-Lists/Kernel/2004-04/1707.html

Both patches in attached tarball.
Regards
Ross.

Here is my revised patch for use with "acpi_skip_timer_override" to get 
nmi_debug=1 working with the above patch from Len Brown.

--- linux-2.6.5/arch/i386/kernel/io_apic.c.orig	2004-04-16 00:20:54.000000000 +1000
+++ linux-2.6.5/arch/i386/kernel/io_apic.c	2004-04-15 20:24:18.000000000 +1000
@@ -2179,10 +2179,13 @@ static inline void check_timer(void)
 
 	if (pin1 != -1) {
 		/*
 		 * Ok, does IRQ0 through the IOAPIC work?
 		 */
+		extern int acpi_skip_timer_override;
+		if(acpi_skip_timer_override)
+			timer_ack=0;
 		unmask_IO_APIC_irq(0);
 		if (timer_irq_works()) {
 			if (nmi_watchdog == NMI_IO_APIC) {
 				disable_8259A_irq(0);
 				setup_nmi();

Here is my revised patch for "idle=C1halt" to prevent nforce2 hard lockups.
Now more robust, better tested with apm config, and without x86 apic config, 
and nolapic, noapic, acpi=off. All gave my usual 38C CPU temp when idle and
no hard lockups. Temp measured by leaving machine idle on run level 3 for 
several minutes and then reading bios temp on reboot.

--- linux-2.6.5/arch/i386/kernel/process.c.orig	2004-04-04 13:36:10.000000000 +1000
+++ linux-2.6.5/arch/i386/kernel/process.c	2004-04-15 20:41:13.000000000 +1000
@@ -47,10 +47,13 @@
 #include <asm/irq.h>
 #include <asm/desc.h>
 #ifdef CONFIG_MATH_EMULATION
 #include <asm/math_emu.h>
 #endif
+#if defined(CONFIG_X86_UP_APIC)
+#include <asm/apic.h>
+#endif
 
 #include <linux/irq.h>
 #include <linux/err.h>
 
 asmlinkage void ret_from_fork(void) __asm__("ret_from_fork");
@@ -98,10 +101,34 @@ void default_idle(void)
 			local_irq_enable();
 	}
 }
 
 /*
+ * We use this to avoid nforce2 lockups
+ * Reduces frequency of C1 disconnects
+ */
+static void c1halt_idle(void)
+{
+	if (!hlt_counter && current_cpu_data.hlt_works_ok) {
+		local_irq_disable();
+#if defined(CONFIG_X86_UP_APIC)
+		/* only hlt disconnect if more than 1.6% of apic interval remains */
+      	extern int enable_local_apic;
+		if(!need_resched() && (enable_local_apic < 0 ||
+			(apic_read(APIC_TMCCT) > (apic_read(APIC_TMICT)>>6)))) {
+#else
+		/* just adds a little delay to assist in back to back disconnects */
+		if(!need_resched()) {
+#endif
+		ndelay(600); /* helps nforce2 but adds 0.6us hard int latency */
+		safe_halt(); /* nothing better to do until we wake up */
+		} else {
+			local_irq_enable();
+		}
+	}
+}
+/*
  * On SMP it's slightly faster (but much more power-consuming!)
  * to poll the ->work.need_resched flag instead of waiting for the
  * cross-CPU IPI to arrive. Use this option with caution.
  */
 static void poll_idle (void)
@@ -135,20 +162,18 @@ static void poll_idle (void)
  * The idle thread. There's no useful work to be
  * done, so just try to conserve power and have a
  * low exit latency (ie sit in a loop waiting for
  * somebody to say that they'd like to reschedule)
  */
+static void (*idle)(void);
 void cpu_idle (void)
 {
 	/* endless idle loop with no priority at all */
 	while (1) {
 		while (!need_resched()) {
-			void (*idle)(void) = pm_idle;
-
 			if (!idle)
-				idle = default_idle;
-
+				idle = pm_idle ? pm_idle : default_idle;
 			irq_stat[smp_processor_id()].idle_timestamp = jiffies;
 			idle();
 		}
 		schedule();
 	}
@@ -199,16 +224,18 @@ void __init select_idle_routine(const st
 
 static int __init idle_setup (char *str)
 {
 	if (!strncmp(str, "poll", 4)) {
 		printk("using polling idle threads.\n");
-		pm_idle = poll_idle;
+		idle = poll_idle;
 	} else if (!strncmp(str, "halt", 4)) {
 		printk("using halt in idle threads.\n");
-		pm_idle = default_idle;
+		idle = default_idle;
+	} else if (!strncmp(str, "C1halt", 6)) {
+		printk("using C1 halt disconnect friendly idle threads.\n");
+		idle = c1halt_idle;
 	}
-
 	return 1;
 }
 
 __setup("idle=", idle_setup);
 



--Boundary-00=_tXqfAXOsT9S/HmD
Content-Type: application/x-tgz;
  name="nforce2-lockup-patches-rd-2.6.5.tgz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="nforce2-lockup-patches-rd-2.6.5.tgz"

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
Qw011FBDX4D+BJ8TfcMAKAAA

--Boundary-00=_tXqfAXOsT9S/HmD--

