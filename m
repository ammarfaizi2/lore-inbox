Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267107AbTAPRPj>; Thu, 16 Jan 2003 12:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267119AbTAPRPj>; Thu, 16 Jan 2003 12:15:39 -0500
Received: from bilbo.math.uni-mannheim.de ([134.155.88.153]:21946 "HELO
	bilbo.math.uni-mannheim.de") by vger.kernel.org with SMTP
	id <S267107AbTAPRPh>; Thu, 16 Jan 2003 12:15:37 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: linux-kernel@vger.kernel.org
Subject: [PARISC] kernel 2.5.58 doesn't compile
Date: Thu, 16 Jan 2003 18:24:37 +0100
User-Agent: KMail/1.4.3
Cc: submit@bugs.parisc-linux.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200301161824.37608@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First problem:

arch/parisc/kernel/irq.c: In function `show_interrupts':
arch/parisc/kernel/irq.c:254: subscripted value is neither array nor pointer
arch/parisc/kernel/irq.c: In function `do_irq':
arch/parisc/kernel/irq.c:391: subscripted value is neither array nor pointer

I hope this fixes this, I looked on the other arch's irq.c and did the
following patch. But be careful, this is just looking 10 lines of code up and
down. It is completely untested!

--- arch/parisc/kernel/irq.c.orig       Wed Jan 15 17:18:19 2003
+++ arch/parisc/kernel/irq.c    Wed Jan 15 17:20:27 2003
@@ -251,7 +251,7 @@
 #ifdef CONFIG_SMP
                for (; j < NR_CPUS; j++)
 #endif
-                   seq_printf(p, "%10u ", kstat_cpu(j).irqs[regnr][irq_no]);
+                   seq_printf(p, "%10u ", kstat_cpu(j).irqs[irq_no]);

                seq_printf(p, " %14s",
                            region->data.name ? region->data.name : "N/A");
@@ -388,7 +388,7 @@
        int cpu = smp_processor_id();

        irq_enter();
-       ++kstat_cpu(cpu).irqs[IRQ_REGION(irq)][IRQ_OFFSET(irq)];
+       ++kstat_cpu(cpu).irqs[irq];

        DBG_IRQ(irq, ("do_irq(%d) %d+%d\n", irq, IRQ_REGION(irq), IRQ_OFFSET(irq)));


At least it compiles. But then this happens:

arch/parisc/kernel/module.c: In function `apply_relocate_add':
arch/parisc/kernel/module.c:131: `R_PARISC_PLABEL32' undeclared (first use in this function)
arch/parisc/kernel/module.c:131: (Each undeclared identifier is reported only once
arch/parisc/kernel/module.c:131: for each function it appears in.)
arch/parisc/kernel/module.c:135: `R_PARISC_DIR32' undeclared (first use in this function)
arch/parisc/kernel/module.c:139: `R_PARISC_DIR21L' undeclared (first use in this function)
arch/parisc/kernel/module.c:143: `R_PARISC_DIR14R' undeclared (first use in this function)
arch/parisc/kernel/module.c:147: `R_PARISC_SEGREL32' undeclared (first use in this function)
arch/parisc/kernel/module.c:151: `R_PARISC_DPREL21L' undeclared (first use in this function)
arch/parisc/kernel/module.c:155: `R_PARISC_DPREL14R' undeclared (first use in this function)
arch/parisc/kernel/module.c:159: `R_PARISC_PCREL17F' undeclared (first use in this function)
arch/parisc/kernel/module.c:163: `R_PARISC_PCREL22F' undeclared (first use in this function)
arch/parisc/kernel/module.c:170: warning: long long unsigned int format, different type arg (arg 3)

I've grepped a lot, but there are no definitions of this anywhere in the
kernel source. The only ones I found are in a libc header file modified by
Eric Biederman and included in kexec-tools. But they also do not define
R_PARISC_PLABEL32. Looks like anyone missed a file, module.c is new
in 2.5.5?.

Eike
