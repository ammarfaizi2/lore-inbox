Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751420AbWCVXH7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbWCVXH7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 18:07:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbWCVXH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 18:07:59 -0500
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:31690 "EHLO
	mail1.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S1751420AbWCVXH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 18:07:58 -0500
Date: Wed, 22 Mar 2006 18:07:42 -0500
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: Andi Kleen <ak@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Lee Revell <rlrevell@joe-job.com>, Jeff Garzik <jeff@garzik.org>,
       Jason Baron <jbaron@redhat.com>, linux-kernel@vger.kernel.org,
       john stultz <johnstul@us.ibm.com>
Subject: Re: libata/sata_nv latency on NVIDIA CK804 [was Re: AMD64 X2 lost ticks on PM timer]
Message-ID: <20060322230742.GA2363@ti64.telemetry-investments.com>
Mail-Followup-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	Andi Kleen <ak@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
	Jeff Garzik <jeff@garzik.org>, Jason Baron <jbaron@redhat.com>,
	linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>
References: <200602280022.40769.darkray@ic3man.com> <1142522019.13318.27.camel@localhost.localdomain> <20060316165737.GA23248@ti64.telemetry-investments.com> <200603221709.09846.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603221709.09846.ak@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2006 at 05:09:08PM +0100, Andi Kleen wrote:
> Also my latest patchkit has a debugging patch for lost tries
> 
> ftp://ftp.firstfloor.org/pub/ak/x86_64/quilt/patches/lost-cli-debug
> 
> Can you test it with this patch? 

It didn't apply cleanly against vanilla 2.6.16; rediffed patch below.

Typical output:

time.c: Lost 12 timer tick(s)! rip 10:__do_softirq+0x4b/0xdf
last cli handle_IRQ_event+0x62/0x71
last cli caller __do_IRQ+0xa6/0x104
time.c: Lost 5 timer tick(s)! rip 10:__do_softirq+0x4b/0xdf
last cli handle_IRQ_event+0x62/0x71
last cli caller __do_IRQ+0xa6/0x104
time.c: Lost 4 timer tick(s)! rip 10:__do_softirq+0x4b/0xdf
last cli handle_IRQ_event+0x62/0x71
last cli caller __do_IRQ+0xa6/0x104
time.c: Lost 8 timer tick(s)! rip 10:__do_softirq+0x4b/0xdf
last cli handle_IRQ_event+0x62/0x71
last cli caller __do_IRQ+0xa6/0x104
time.c: Lost 3 timer tick(s)! rip 10:__do_softirq+0x4b/0xdf
last cli handle_IRQ_event+0x62/0x71
last cli caller __do_IRQ+0xa6/0x104

Some statistics:

rugolsky@ti94: grep 'last cli' /var/log/messages | sed -n -e '1p;$p'
Mar 22 17:37:06 ti94 kernel: last cli 0x0
Mar 22 17:43:48 ti94 kernel: last cli caller __do_IRQ+0xa6/0x104

rugolsky@ti94: grep 'last cli' /var/log/messages | cut -d' ' -f6- | sort | uniq -c | sort -nr
    782 last cli handle_IRQ_event+0x62/0x71
    782 last cli caller __do_IRQ+0xa6/0x104
      2 last cli _spin_lock_irqsave+0x16/0x27
      1 last cli setup_boot_APIC_clock+0x48/0x12e
      1 last cli pci_direct_init+0x47/0x190
      1 last cli kmem_cache_free+0x1d/0x62
      1 last cli caller smp_prepare_cpus+0x36a/0x394
      1 last cli caller release_console_sem+0x1a/0x1c9
      1 last cli caller init+0x1c3/0x338
      1 last cli caller acpi_os_release_object+0x9/0xd
      1 last cli caller __up_read+0x19/0x9e
      1 last cli caller 0x0
      1 last cli 0x0

Thanks.

	-Bill


--- linux-2.6.16/arch/x86_64/kernel/time.c.lost-cli-debug	2006-03-20 00:53:29.000000000 -0500
+++ linux-2.6.16/arch/x86_64/kernel/time.c	2006-03-22 17:09:14.000000000 -0500
@@ -43,7 +43,7 @@
 #endif
 
 #ifdef CONFIG_CPU_FREQ
-static void cpufreq_delayed_get(void);
+static void cpufreq_delayed_get(struct pt_regs *);
 #endif
 extern void i8254_timer_resume(void);
 extern int using_apic_timer;
@@ -63,7 +63,7 @@ static unsigned long hpet_period;			/* f
 unsigned long hpet_tick;				/* HPET clocks / interrupt */
 int hpet_use_timer;				/* Use counter of hpet for time keeping, otherwise PIT */
 unsigned long vxtime_hz = PIT_TICK_RATE;
-int report_lost_ticks;				/* command line option */
+int report_lost_ticks = 1;			/* command line option */
 unsigned long long monotonic_base;
 
 struct vxtime_data __vxtime __section_vxtime;	/* for vsyscalls */
@@ -309,15 +309,20 @@ unsigned long long monotonic_clock(void)
 }
 EXPORT_SYMBOL(monotonic_clock);
 
+extern unsigned long last_clier, last_clier_caller;
+
 static noinline void handle_lost_ticks(int lost, struct pt_regs *regs)
 {
     static long lost_count;
     static int warned;
 
     if (report_lost_ticks) {
-	    printk(KERN_WARNING "time.c: Lost %d timer "
-		   "tick(s)! ", lost);
-	    print_symbol("rip %s)\n", regs->rip);
+		printk(KERN_WARNING 
+			"time.c: Lost %d timer tick(s)! rip %02lx", 
+			lost, regs->cs);
+		print_symbol(":%s\n", regs->rip);
+		print_symbol("last cli %s\n", last_clier);
+		print_symbol("last cli caller %s\n", last_clier_caller);
     }
 
     if (lost_count == 1000 && !warned) {
@@ -345,7 +350,7 @@ static noinline void handle_lost_ticks(i
        (like going into thermal throttle)
        Give cpufreq a change to catch up. */
     if ((lost_count+1) % 25 == 0) {
-	    cpufreq_delayed_get();
+	    cpufreq_delayed_get(regs);
     }
 #endif
 }
@@ -599,14 +604,15 @@ static void handle_cpufreq_delayed_get(v
  * to verify the CPU frequency the timing core thinks the CPU is running
  * at is still correct.
  */
-static void cpufreq_delayed_get(void)
+static void cpufreq_delayed_get(struct pt_regs *regs)
 {
 	static int warned;
 	if (cpufreq_init && !cpufreq_delayed_issched) {
 		cpufreq_delayed_issched = 1;
 		if (!warned) {
 			warned = 1;
-			printk(KERN_DEBUG "Losing some ticks... checking if CPU frequency changed.\n");
+			print_symbol(KERN_DEBUG 
+	"Losing some ticks... checking if CPU frequency changed (rip=%s)\n", regs->rip);
 		}
 		schedule_work(&cpufreq_delayed_get_work);
 	}
--- linux-2.6.16/arch/x86_64/kernel/process.c.lost-cli-debug	2006-03-20 00:53:29.000000000 -0500
+++ linux-2.6.16/arch/x86_64/kernel/process.c	2006-03-22 17:12:01.000000000 -0500
@@ -841,3 +841,16 @@ unsigned long arch_align_stack(unsigned 
 		sp -= get_random_int() % 8192;
 	return sp & ~0xf;
 }
+
+unsigned long last_clier, last_clier_caller;
+ 
+void __local_irq_disable(void *caller)
+{
+	if (!irqs_disabled()) {
+		last_clier = __builtin_return_address(0);
+		last_clier = (unsigned long)__builtin_return_address(0);
+		last_clier_caller = (unsigned long)caller;
+ 		asm volatile("cli":::"memory"); 
+	}
+}
+EXPORT_SYMBOL(__local_irq_disable);
--- linux-2.6.16/include/asm-x86_64/system.h.lost-cli-debug	2006-03-20 00:53:29.000000000 -0500
+++ linux-2.6.16/include/asm-x86_64/system.h	2006-03-22 17:01:50.000000000 -0500
@@ -351,7 +351,10 @@ static inline unsigned long __cmpxchg(vo
 /* For spinlocks etc */
 #define local_irq_save(x)	do { local_save_flags(x); local_irq_restore((x & ~(1 << 9)) | (1 << 18)); } while (0)
 #else  /* CONFIG_X86_VSMP */
-#define local_irq_disable() 	__asm__ __volatile__("cli": : :"memory")
+
+extern void __local_irq_disable(void *caller);
+#define local_irq_disable() __local_irq_disable(__builtin_return_address(0))
+
 #define local_irq_enable()	__asm__ __volatile__("sti": : :"memory")
 
 #define irqs_disabled()			\
@@ -362,7 +365,7 @@ static inline unsigned long __cmpxchg(vo
 })
 
 /* For spinlocks etc */
-#define local_irq_save(x) 	do { warn_if_not_ulong(x); __asm__ __volatile__("# local_irq_save \n\t pushfq ; popq %0 ; cli":"=g" (x): /* no input */ :"memory"); } while (0)
+#define local_irq_save(x) 	do { warn_if_not_ulong(x); __asm__ __volatile__("# local_irq_save \n\t pushfq ; popq %0":"=g" (x): /* no input */ :"memory"); local_irq_disable(); } while (0)
 #endif
 
 /* used in the idle loop; sti takes one instruction cycle to complete */
