Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266784AbUGLKj6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266784AbUGLKj6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 06:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266785AbUGLKj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 06:39:58 -0400
Received: from cobalt1.indo.net ([208.179.167.192]:780 "EHLO cobalt1.indo.net")
	by vger.kernel.org with ESMTP id S266784AbUGLKju (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 06:39:50 -0400
Message-ID: <005a01c467fc$cd8dac50$1002a8c0@3dijsrwin>
From: "Rajput" <rajput@indo.net>
To: "Con Kolivas" <kernel@kolivas.org>
Cc: <linux-kernel@vger.kernel.org>, "Rajput" <rajput@indo.net>
References: <cone.1089613755.742689.28499.502@pc.kolivas.org>
Subject: Re: [PATCH] Instrumenting high latency
Date: Mon, 12 Jul 2004 16:11:32 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

what is the difference in interrupt latency with and without your patch.

Regards,

Rajput.

----- Original Message ----- 
From: "Con Kolivas" <kernel@kolivas.org>
To: <linux-kernel@vger.kernel.org>
Cc: <akpm@osdl.org>
Sent: Monday, July 12, 2004 11:59 AM
Subject: [PATCH] Instrumenting high latency


> Because of the recent discussion about latency in the kernel I asked
William
> Lee Irwin III to help create some instrumentation to determine where in
the
> kernel there were still sustained periods of non-preemptible code. He
hacked
> together this simple patch which times periods according to the preempt
> count. Hopefully we can use this patch in the advice of Linus to avoid the
> "mental masturbation" at guessing where latency is and track down real
> problem areas.
>
> It is enabled via a config option and by setting the threshold at boot by
> passing the parameter:
> preempt_thresh=2
>
> to set the threshold at 2ms for example.
>
> The output is a warning in syslog like so:
>
> 5ms non-preemptible critical section violated 2 ms preempt threshold
> starting at add_wait_queue+0x21/0x82 and ending at add_wait
_queue+0x4a/0x82
>
> I would not recommend using this patch for daily use but please try it out
> on multiple setups/filesystems etc and help us track down the areas.
> Unfortunately I am not personally capable of fixing the code paths in
> question so I'll need the help of others in this.
>
> The patch appears to require CONFIG_PREEMPT enabled on uniprocessor and is
> i386 only at the moment.
>
> Patch applies to 2.6.8-rc1
>
> Cheers,
> Con Kolivas
>
>


----------------------------------------------------------------------------
----


> Index: linux-2.6.8-rc1/arch/i386/Kconfig
> ===================================================================
> --- linux-2.6.8-rc1.orig/arch/i386/Kconfig 2004-07-12 16:11:43.531241636
+1000
> +++ linux-2.6.8-rc1/arch/i386/Kconfig 2004-07-12 16:12:45.036678502 +1000
> @@ -504,6 +504,13 @@
>     Say Y here if you are building a kernel for a desktop, embedded
>     or real-time system.  Say N if you are unsure.
>
> +config PREEMPT_TIMING
> + bool "Non-preemptible critical section timing"
> + help
> +   This option measures the time spent in non-preemptible critical
> +   sections and reports warnings when a boot-time configurable
> +   latency threshold is exceeded.
> +
>  config X86_UP_APIC
>   bool "Local APIC support on uniprocessors" if !SMP
>   depends on !(X86_VISWS || X86_VOYAGER)
> Index: linux-2.6.8-rc1/arch/i386/kernel/traps.c
> ===================================================================
> --- linux-2.6.8-rc1.orig/arch/i386/kernel/traps.c 2004-07-12
16:11:43.601230753 +1000
> +++ linux-2.6.8-rc1/arch/i386/kernel/traps.c 2004-07-12 16:12:45.037678346
+1000
> @@ -947,3 +947,68 @@
>
>   trap_init_hook();
>  }
> +
> +#ifdef CONFIG_PREEMPT_TIMING
> +
> +static int preempt_thresh;
> +static DEFINE_PER_CPU(u64, preempt_timings);
> +static DEFINE_PER_CPU(unsigned long, preempt_entry);
> +static DEFINE_PER_CPU(unsigned long, preempt_exit);
> +
> +static int setup_preempt_thresh(char *s)
> +{
> + int thresh;
> +
> + get_option(&s, &thresh);
> + if (thresh > 0) {
> + preempt_thresh = thresh;
> + printk("Preemption threshold = %dms\n", preempt_thresh);
> + }
> + return 1;
> +}
> +__setup("preempt_thresh=", setup_preempt_thresh);
> +
> +void __inc_preempt_count(void)
> +{
> + preempt_count()++;
> + if (preempt_count() == 1 && system_state == SYSTEM_RUNNING) {
> + rdtscll(__get_cpu_var(preempt_timings));
> + __get_cpu_var(preempt_entry)
> + = (unsigned long)__builtin_return_address(0);
> + }
> +}
> +
> +void __dec_preempt_count(void)
> +{
> + if (preempt_count() == 1 && system_state == SYSTEM_RUNNING &&
> + __get_cpu_var(preempt_entry)) {
> + u64 exit;
> + __get_cpu_var(preempt_exit)
> + = (unsigned long)__builtin_return_address(0);
> + rdtscll(exit);
> + if (cpu_khz) {
> + __get_cpu_var(preempt_timings) =
> + exit - __get_cpu_var(preempt_timings);
> + do_div(__get_cpu_var(preempt_timings), cpu_khz);
> + if (__get_cpu_var(preempt_timings) > preempt_thresh &&
> + preempt_thresh) {
> + printk("%lums non-preemptible critical "
> + "section violated %d ms preempt "
> + "threshold starting at ",
> + (unsigned long)
> + __get_cpu_var(preempt_timings),
> + preempt_thresh);
> + print_symbol("%s and ending at ",
> + __get_cpu_var(preempt_entry));
> + print_symbol("%s\n",
> + __get_cpu_var(preempt_exit));
> + dump_stack();
> + }
> + }
> + __get_cpu_var(preempt_exit) = __get_cpu_var(preempt_entry) = 0;
> + }
> + preempt_count()--;
> +}
> +EXPORT_SYMBOL(__inc_preempt_count);
> +EXPORT_SYMBOL(__dec_preempt_count);
> +#endif
> Index: linux-2.6.8-rc1/include/linux/preempt.h
> ===================================================================
> --- linux-2.6.8-rc1.orig/include/linux/preempt.h 2004-03-11
21:29:26.000000000 +1100
> +++ linux-2.6.8-rc1/include/linux/preempt.h 2004-07-12 16:12:45.055675548
+1000
> @@ -9,17 +9,22 @@
>  #include <linux/config.h>
>  #include <linux/linkage.h>
>
> -#define preempt_count() (current_thread_info()->preempt_count)
> -
> -#define inc_preempt_count() \
> -do { \
> - preempt_count()++; \
> -} while (0)
> +#ifdef CONFIG_PREEMPT_TIMING
> +void __inc_preempt_count(void);
> +void __dec_preempt_count(void);
> +#else
> +#ifdef CONFIG_PREEMPT
> +#define __inc_preempt_count() do { preempt_count()++; } while (0)
> +#define __dec_preempt_count() do { preempt_count()--; } while (0)
> +#else
> +#define __inc_preempt_count() do { } while (0)
> +#define __dec_preempt_count() do { } while (0)
> +#endif
> +#endif
>
> -#define dec_preempt_count() \
> -do { \
> - preempt_count()--; \
> -} while (0)
> +#define preempt_count() (current_thread_info()->preempt_count)
> +#define inc_preempt_count() __inc_preempt_count()
> +#define dec_preempt_count() __dec_preempt_count()
>
>  #ifdef CONFIG_PREEMPT
>
> @@ -51,9 +56,9 @@
>
>  #else
>
> -#define preempt_disable() do { } while (0)
> -#define preempt_enable_no_resched() do { } while (0)
> -#define preempt_enable() do { } while (0)
> +#define preempt_disable() __inc_preempt_count()
> +#define preempt_enable_no_resched() __dec_preempt_count()
> +#define preempt_enable() __dec_preempt_count()
>  #define preempt_check_resched() do { } while (0)
>
>  #endif
>


