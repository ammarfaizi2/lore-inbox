Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317648AbSGaCCe>; Tue, 30 Jul 2002 22:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317649AbSGaCCd>; Tue, 30 Jul 2002 22:02:33 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:12706 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S317648AbSGaCCd>;
	Tue, 30 Jul 2002 22:02:33 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Steven Cole <elenstev@mesatop.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.29, CPU#1 not working with CONFIG_SMP=y, 2.5.28 OK. 
In-reply-to: Your message of "30 Jul 2002 14:22:34 CST."
             <1028060554.3148.41.camel@spc9.esa.lanl.gov> 
Date: Wed, 31 Jul 2002 11:34:18 +1000
Message-Id: <20020731020722.4D4D2421D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1028060554.3148.41.camel@spc9.esa.lanl.gov> you write:
> Rusty,
> 
> I sent the following to lkml before I realized that this should have
> been cc'ed to you.  In the meantime, I looked at changes to init/main.c,
> so I tried rebooting 2.5.29 with maxcpus=2 on the command line at boot.
> That changed the line from dmesg which read
> CPUS done 4294967295
> to
> CPUS done 2
> but still I have the same result in that only CPU#0 is running.

> 2.5.29 dmesg snippet:
> 
> Using local APIC timer interrupts.
> calibrating APIC timer ...
> ..... CPU clock speed is 999.0634 MHz.
> ..... host bus clock speed is 133.0284 MHz.
> cpu: 0, clocks: 133284, slice: 4038
> CPU0<T0:133280,T1:129232,D:10,S:4038,C:133284>
> checking TSC synchronization across 2 CPUs: passed.
> Bringing up 3

Hmm... this is the hint, here.  Please try the patch below (trivial,
but untested).

Please tell the results!
Rusty.

diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.29/include/asm-i386/smp.h working-2.5.29-smpfix/include/asm-i386/smp.h
--- linux-2.5.29/include/asm-i386/smp.h	Sat Jul 27 15:24:39 2002
+++ working-2.5.29-smpfix/include/asm-i386/smp.h	Wed Jul 31 11:28:04 2002
@@ -85,7 +85,9 @@ extern volatile int logical_apicid_to_cp
  */
 #define smp_processor_id() (current_thread_info()->cpu)
 
-#define cpu_possible(cpu) (phys_cpu_present_map & (1<<(cpu)))
+extern volatile unsigned long cpu_callout_map;
+
+#define cpu_possible(cpu) (cpu_callout_map & (1<<(cpu)))
 #define cpu_online(cpu) (cpu_online_map & (1<<(cpu)))
 
 extern inline unsigned int num_online_cpus(void)
@@ -113,7 +115,6 @@ static __inline int logical_smp_processo
 	return GET_APIC_LOGICAL_ID(*(unsigned long *)(APIC_BASE+APIC_LDR));
 }
 
-extern volatile unsigned long cpu_callout_map;
 /* We don't mark CPUs online until __cpu_up(), so we need another measure */
 static inline int num_booting_cpus(void)
 {

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
