Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272311AbTG3XBE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 19:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272318AbTG3XBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 19:01:04 -0400
Received: from fw.osdl.org ([65.172.181.6]:39883 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272311AbTG3XA5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 19:00:57 -0400
Date: Wed, 30 Jul 2003 16:00:50 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Luiz Capitulino <lcapitulino@prefeitura.sp.gov.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2-osdl1
Message-Id: <20030730160050.44127f95.shemminger@osdl.org>
In-Reply-To: <1059577647.2226.2.camel@lorien>
References: <20030729160719.20e17f3b.shemminger@osdl.org>
	<1059577647.2226.2.camel@lorien>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.3claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 Jul 2003 12:07:27 -0300
Luiz Capitulino <lcapitulino@prefeitura.sp.gov.br> wrote:

> Stephen,
> 
> Em Ter, 2003-07-29 às 20:07, Stephen Hemminger escreveu:
> 
> > o Performance Counters			(Mikael Pettersson)
> 
> CC      drivers/perfctr/x86.o
> drivers/perfctr/x86.c: In function `p4_write_control':
> drivers/perfctr/x86.c:806: request for member `mask' in something
> not a structure or union
> drivers/perfctr/x86.c: In function `finalise_backpatching':
> drivers/perfctr/x86.c:1139: incompatible types in assignment
> drivers/perfctr/x86.c:1140: warning: statement with no effect
> drivers/perfctr/x86.c: In function `perfctr_cpu_init':
> drivers/perfctr/x86.c:1680: incompatible types in assignment
> make[2]: ** [drivers/perfctr/x86.o] Error 1
> make[1]: ** [drivers/perfctr] Error 2
> make: ** [drivers] Error 2

I had to redo the cpu bit mask code for perfctr to make it work with
the patch to allow greater than 32 cpu's.  This should work:

diff -Nru a/drivers/perfctr/x86.c b/drivers/perfctr/x86.c
--- a/drivers/perfctr/x86.c	Wed Jul 30 15:52:07 2003
+++ b/drivers/perfctr/x86.c	Wed Jul 30 15:52:07 2003
@@ -9,6 +9,7 @@
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/fs.h>
+#include <linux/cpumask.h>
 #include <linux/perfctr.h>
 
 #include <asm/msr.h>
@@ -797,6 +798,8 @@
 }
 #endif	/* PERFCTR_INTERRUPT_SUPPORT */
 
+cpumask_t perfctr_cpus_forbidden_mask;
+
 static void p4_write_control(const struct perfctr_cpu_state *state)
 {
 	struct per_cpu_cache *cache;
@@ -1122,23 +1125,15 @@
  *								*
  ****************************************************************/
 
-static inline void set_perfctr_cpus_forbidden_mask(cpumask_t mask)
-{
-#if !defined(perfctr_cpus_forbidden_mask)
-	perfctr_cpus_forbidden_mask = mask;
-#endif
-}
-
 /* see comment above at redirect_call() */
 static void __init finalise_backpatching(void)
 {
 	struct per_cpu_cache *cache;
 	struct perfctr_cpu_state state;
-	cpumask_t old_mask, new_mask;
+	cpumask_t old_mask;
 
 	old_mask = perfctr_cpus_forbidden_mask;
-	cpus_empty(new_mask);
-	set_perfctr_cpus_forbidden_mask(new_mask);
+	cpus_clear(perfctr_cpus_forbidden_mask);
 
 	cache = &per_cpu_cache[smp_processor_id()];
 	memset(cache, 0, sizeof *cache);
@@ -1151,7 +1146,7 @@
 	perfctr_cpu_resume(&state);
 	perfctr_cpu_suspend(&state);
 
-	set_perfctr_cpus_forbidden_mask(old_mask);
+	perfctr_cpus_forbidden_mask = old_mask;
 
 	redirect_call_disable = 1;
 }
@@ -1167,8 +1162,6 @@
 }
 #else
 
-cpumask_t perfctr_cpus_forbidden_mask;
-
 static inline int __init p4_ht_finalise(cpumask_t forbidden)
 {
 	int cpu;
@@ -1214,7 +1207,7 @@
 	}
 	if( nr_siblings < 2 )
 		return 0;
-	cpus_empty(forbidden);
+	cpus_clear(forbidden);
 	smp_call_function(p4_ht_mask_setup_cpu, &forbidden, 1, 1);
 	p4_ht_mask_setup_cpu(&forbidden);
 	if( !any_online_cpu(forbidden))
diff -Nru a/include/asm-i386/perfctr.h b/include/asm-i386/perfctr.h
--- a/include/asm-i386/perfctr.h	Wed Jul 30 15:52:07 2003
+++ b/include/asm-i386/perfctr.h	Wed Jul 30 15:52:07 2003
@@ -164,14 +164,9 @@
 static inline void perfctr_cpu_set_ihandler(perfctr_ihandler_t x) { }
 #endif
 
-#if defined(CONFIG_SMP) && LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,15)
 /* CPUs in `perfctr_cpus_forbidden_mask' must not use the
    performance-monitoring counters. TSC use is unrestricted. */
 extern cpumask_t perfctr_cpus_forbidden_mask;
-#else
-#define perfctr_cpus_forbidden_mask (0UL)
-#endif
-
 #endif	/* CONFIG_PERFCTR */
 
 #if defined(CONFIG_KPERFCTR) && PERFCTR_INTERRUPT_SUPPORT
