Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265993AbTGAF7P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 01:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265998AbTGAF7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 01:59:15 -0400
Received: from rj.sgi.com ([192.82.208.96]:58496 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S265993AbTGAF7I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 01:59:08 -0400
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Get rid of __syscall_count. 
In-reply-to: Your message of "Tue, 01 Jul 2003 15:36:25 +1000."
             <20030701054635.A2D532C0B1@lists.samba.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 01 Jul 2003 16:13:22 +1000
Message-ID: <7159.1057040002@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Jul 2003 15:36:25 +1000, 
Rusty Russell <rusty@rustcorp.com.au> wrote:
>Linus, please apply, unless someone has plans for this field.
>
>Noone seems to use __syscall_count.  Remove the field from i386
>irq_cpustat_t struct, and the generic accessor macros.

The __syscall_count field was added around 2.4.0-test5-pre6 for
performance monitoring and detection of runaway processes.  For reasons
that have long since passed beyond recall, the asm specific bits never
got added.  This was the original patch.

--- linux/include/asm-i386/hardirq.h.orig	Thu Jul 20 09:38:50 2000
+++ linux/include/asm-i386/hardirq.h	Thu Jul 20 09:35:26 2000
@@ -9,7 +9,8 @@
 	unsigned int __local_irq_count;
 	unsigned int __local_bh_count;
 	unsigned int __nmi_counter;
-	unsigned int __pad[5];
+	unsigned int __syscall_counter; /* this is updated in entry.S */
+	unsigned int __pad[4];
 } ____cacheline_aligned irq_cpustat_t;
 
 extern irq_cpustat_t irq_stat [NR_CPUS];
--- linux/arch/i386/kernel/entry.S.orig	Thu Jul 20 09:39:21 2000
+++ linux/arch/i386/kernel/entry.S	Thu Jul 20 09:34:44 2000
@@ -206,9 +206,11 @@
 #ifdef CONFIG_SMP
 	movl processor(%ebx),%eax
 	shll $5,%eax
+	incl SYMBOL_NAME(irq_stat)+12(,%eax) # irq_stat.__syscall_counter
 	movl SYMBOL_NAME(softirq_state)(,%eax),%ecx
 	testl SYMBOL_NAME(softirq_state)+4(,%eax),%ecx
 #else
+	incl SYMBOL_NAME(irq_stat)+12	# irq_stat.__syscall_counter
 	movl SYMBOL_NAME(softirq_state),%ecx
 	testl SYMBOL_NAME(softirq_state)+4,%ecx
 #endif
--- linux/arch/i386/kernel/irq.c.orig	Thu Jul 20 09:39:41 2000
+++ linux/arch/i386/kernel/irq.c	Thu Jul 20 09:34:44 2000
@@ -170,6 +170,13 @@
 	p += sprintf(p, "\n");
 #endif
 	p += sprintf(p, "ERR: %10lu\n", irq_err_count);
+
+	p += sprintf(p, "SYS: ");
+	for (j = 0; j < smp_num_cpus; j++)
+		p += sprintf(p, "%10u ",
+			irq_stat[cpu_logical_map(j)].__syscall_counter);
+	p += sprintf(p, " %14s\n", "system calls");
+
 	return p - buf;
 }


# cat /proc/interrupts
           CPU0       CPU1
  0:      89722      99730    IO-APIC-edge  timer
  1:          2          0    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  4:        168        162    IO-APIC-edge  serial
 13:          1          0          XT-PIC  fpu
 15:          1          3    IO-APIC-edge  ide1
 19:      27408      27300   IO-APIC-level  aic7xxx, aic7xxx
 21:      13432      13948   IO-APIC-level  eth0
NMI:     189327     189327
LOC:     189299     189289
ERR:          0
SYS:  130768636   69891376    system calls

