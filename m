Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132223AbRCVWVT>; Thu, 22 Mar 2001 17:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132224AbRCVWVK>; Thu, 22 Mar 2001 17:21:10 -0500
Received: from mozart.stat.wisc.edu ([128.105.5.24]:55814 "EHLO
	mozart.stat.wisc.edu") by vger.kernel.org with ESMTP
	id <S132223AbRCVWUz>; Thu, 22 Mar 2001 17:20:55 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mike Galbraith <mikeg@wen-online.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.2 fails to merge mmap areas, 700% slowdown.
In-Reply-To: <Pine.LNX.4.33.0103220951460.1667-100000@mikeg.weiden.de>
From: buhr@stat.wisc.edu (Kevin Buhr)
In-Reply-To: Mike Galbraith's message of "Thu, 22 Mar 2001 10:04:28 +0100 (CET)"
Date: 22 Mar 2001 16:19:56 -0600
Message-ID: <vba1yrp30qb.fsf@mozart.stat.wisc.edu>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith <mikeg@wen-online.de> writes:
> 
> 2.4.2.ac20.virgin   2.4.3-pre6
> real    11m0.708s   11m58.617s
> user    15m8.720s   7m29.970s
> sys     1m31.410s   0m41.590s
> 
> It looks like ac20 is doing some double accounting.

Alan:

In "2.4.2-ac20", the check in "apic.c" in the "APIC_init_uniprocessor"
function to avoid initializing the APIC is:

        if (!smp_found_config && !cpu_has_apic)
                return -1;

However, in "arch/i386/time.c", we use the following check:

        if (!smp_found_config)
                smp_local_timer_interrupt(regs);

to see if we need to emulate an smp_local_timer_interrupt from
"do_timer_interrupt".

In Mike's case, I think we have smp_found_config == 0 but cpu_has_apic
== 1, so we're telling the CPU APIC to generate smp_local_timer_interrupts,
and then we're also emulating them on normal timer ticks.  That
doubles the rate at which "smp_local_timer_interrupt" is called,
doubling the process user and system time accounting.

Mike, would you like to try out the following (untested) patch against
vanilla ac20 to see if it does the trick?

Kevin <buhr@stat.wisc.edu>

                        *       *       *

diff -ru linux-2.4.2-ac20/arch/i386/kernel/apic.c linux-2.4.2-ac20-local/arch/i386/kernel/apic.c
--- linux-2.4.2-ac20/arch/i386/kernel/apic.c	Thu Mar 22 12:36:02 2001
+++ linux-2.4.2-ac20-local/arch/i386/kernel/apic.c	Thu Mar 22 15:59:08 2001
@@ -30,6 +30,9 @@
 #include <asm/mpspec.h>
 #include <asm/pgalloc.h>
 
+/* Using APIC to generate smp_local_timer_interrupt? */
+int using_apic_timer = 0;
+
 int prof_multiplier[NR_CPUS] = { 1, };
 int prof_old_multiplier[NR_CPUS] = { 1, };
 int prof_counter[NR_CPUS] = { 1, };
@@ -884,6 +887,8 @@
 
 	/* and update all other cpus */
 	smp_call_function(setup_APIC_timer, (void *)calibration_result, 1, 1);
+
+	using_apic_timer = 1;
 }
 
 /*
diff -ru linux-2.4.2-ac20/arch/i386/kernel/time.c linux-2.4.2-ac20-local/arch/i386/kernel/time.c
--- linux-2.4.2-ac20/arch/i386/kernel/time.c	Thu Mar 22 12:36:03 2001
+++ linux-2.4.2-ac20-local/arch/i386/kernel/time.c	Thu Mar 22 16:03:02 2001
@@ -422,7 +422,7 @@
 	if (!user_mode(regs))
 		x86_do_profile(regs->eip);
 #else
-	if (!smp_found_config)
+	if (!using_apic_timer)
 		smp_local_timer_interrupt(regs);
 #endif
 
diff -ru linux-2.4.2-ac20/include/asm-i386/smp.h linux-2.4.2-ac20-local/include/asm-i386/smp.h
--- linux-2.4.2-ac20/include/asm-i386/smp.h	Sun Mar  4 21:35:03 2001
+++ linux-2.4.2-ac20-local/include/asm-i386/smp.h	Thu Mar 22 16:07:28 2001
@@ -34,6 +34,7 @@
 extern unsigned long cpu_online_map;
 extern volatile unsigned long smp_invalidate_needed;
 extern int pic_mode;
+extern int using_apic_timer;
 extern void smp_flush_tlb(void);
 extern void smp_message_irq(int cpl, void *dev_id, struct pt_regs *regs);
 extern void smp_send_reschedule(int cpu);
