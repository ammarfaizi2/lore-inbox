Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319354AbSHNVRy>; Wed, 14 Aug 2002 17:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319352AbSHNVQz>; Wed, 14 Aug 2002 17:16:55 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:7377 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319309AbSHNVPu> convert rfc822-to-8bit;
	Wed, 14 Aug 2002 17:15:50 -0400
Content-Type: text/plain; charset=US-ASCII
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux Solutions
To: Andrea Arcangeli <andrea@suse.de>, Andrew Theurer <habanero@us.ibm.com>
Subject: Re: [PATCH] NUMA-Q disable irqbalance
Date: Wed, 14 Aug 2002 14:16:59 -0700
User-Agent: KMail/1.4.1
Cc: Linus Torvalds <torvalds@transmeta.com>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.33.0208131421190.3110-100000@penguin.transmeta.com> <200208131729.50127.habanero@us.ibm.com> <20020813233007.GV14394@dualathlon.random>
In-Reply-To: <20020813233007.GV14394@dualathlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208141416.59397.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 August 2002 04:30 pm, Andrea Arcangeli wrote:
> On Tue, Aug 13, 2002 at 05:29:50PM -0500, Andrew Theurer wrote:
> > > 2.4.19-rc3aa3:
> > >
> > > No Balance    Ingo IRQ Balance        Andrea IRQ Balance
> > > 794 Mbps              787 Mbps                        792 Mbps
> > >
> > > With hyperthreading:
> > >
> > > No Balance    Ingo IRQ Balance        Andrea IRQ Balance
> > > 773 Mbps              798 Mbps                        809 Mbps
>
> thanks again for running the above benchmarks.
>
> > version is a little less aggressive and has less overhead, something I'd
> > prefer in 2.5.
>
> Second that of course, btw, the detailed explanataion of the changes I
> did while merging it can be found on lse-tech.
>
> it is also possible HZ/50 is too high frequency still, I didn't run any
> extensive test on the reprogramming frequency. I would suggest to try
> with HZ/10 too (so every 100msec instead of every 20msec).
>
> BTW, the very same algorithm should also be shared by alpha, alpha never
> had hardware irq balancing support, it's like a p4, and we do static
> routing distribution choosed by the kernel at boot which is been pretty
> good so far (better than mainline 2.4 on a p4 smp) but the irqblanace
> algorithm should be better there too.
>
> Andrea

I've been thinking about doing away with balance_irq on P4 boxes by using the 
TPR.  It might even help P3 and other i386 CPUs by routing interrupts 
preferentially to idle CPUs.  And, it would do it in real time, not as a 
snapshot of the past stored in the I/O APIC's dest masks.

What do you think about this?  (Crudely ripped out of my 2.5 summit patch; may 
not apply correctly.)

The code in do_IRQ could be "if (clustered_apic_mode) apic_adj_tpr(TPR_IRQ)" 
or some such, if that kind of APIC foolery is not considered necessary for 
the non-P4 crowd.  (The automatic priority boost for serial APICs with 
unEOIed interrupts should do the job for us.)


diff -ruN 2.5.24/arch/i386/kernel/irq.c d24/arch/i386/kernel/irq.c
--- 2.5.24/arch/i386/kernel/irq.c	Thu Jun 20 15:53:44 2002
+++ d24/arch/i386/kernel/irq.c	Wed Jul 10 13:34:14 2002
@@ -582,6 +582,7 @@
 	unsigned int status;
 
 	kstat.irqs[cpu][irq]++;
+	apic_adj_tpr(TPR_IRQ);
 	spin_lock(&desc->lock);
 	desc->handler->ack(irq);
 	/*
@@ -642,6 +643,7 @@
 
 	if (softirq_pending(cpu))
 		do_softirq();
+	apic_adj_tpr(-TPR_IRQ);
 	return 1;
 }
 
diff -ruN 2.5.24/arch/i386/kernel/process.c d24/arch/i386/kernel/process.c
--- 2.5.24/arch/i386/kernel/process.c	Thu Jun 20 15:53:40 2002
+++ d24/arch/i386/kernel/process.c	Wed Jul 10 14:12:57 2002
@@ -145,7 +145,9 @@
 		irq_stat[smp_processor_id()].idle_timestamp = jiffies;
 		while (!need_resched())
 			idle();
+		apic_set_tpr(TPR_TASK);
 		schedule();
+		apic_set_tpr(TPR_IDLE);
 	}
 }
 
diff -ruN 2.5.24/include/asm-i386/apic.h d24/include/asm-i386/apic.h
--- 2.5.24/include/asm-i386/apic.h	Thu Jun 20 15:53:57 2002
+++ d24/include/asm-i386/apic.h	Wed Jul 10 13:34:14 2002
@@ -64,6 +64,22 @@
 	apic_write_around(APIC_EOI, 0);
 }
 
+static inline void apic_set_tpr(unsigned long val)
+{
+	unsigned long value;
+
+	value = apic_read(APIC_TASKPRI);
+	apic_write_around(APIC_TASKPRI, (value & ~APIC_TPRI_MASK) + val);
+}
+
+static inline void apic_adj_tpr(long adj)
+{
+	unsigned long value;
+
+	value = apic_read(APIC_TASKPRI);
+	apic_write_around(APIC_TASKPRI, value + adj);
+}
+
 extern int get_maxlvt(void);
 extern void clear_local_APIC(void);
 extern void connect_bsp_APIC (void);
@@ -95,6 +118,15 @@
 #define NMI_LOCAL_APIC	2
 #define NMI_INVALID	3
 
+#else /* CONFIG_X86_LOCAL_APIC */
+#define apic_set_tpr(val)
+#define apic_adj_tpr(adj)
 #endif /* CONFIG_X86_LOCAL_APIC */
 
+/* Priority values for apic_adj_tpr() and apic_set_tpr() */
+/* xAPICs only do priority comparisons on the upper nibble. */
+#define TPR_IDLE	(0x00ul)
+#define TPR_TASK	(0x10ul)
+#define TPR_IRQ		(0x20ul)	/* Or maybe 0x10 ?? */
+
 #endif /* __ASM_APIC_H */


-- 
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com

