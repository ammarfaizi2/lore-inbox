Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271623AbRICPNA>; Mon, 3 Sep 2001 11:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271656AbRICPMq>; Mon, 3 Sep 2001 11:12:46 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:1036 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S271623AbRICPMj>; Mon, 3 Sep 2001 11:12:39 -0400
Date: Mon, 3 Sep 2001 17:12:58 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: ARM softirqs
Message-ID: <20010903171258.M699@athlon.random>
In-Reply-To: <20010823112014.A24974@flint.arm.linux.org.uk> <20010829155753.N16364@athlon.random> <20010829150855.A11200@flint.arm.linux.org.uk> <20010829162100.P16364@athlon.random> <20010829155930.A11334@flint.arm.linux.org.uk> <20010829172534.R16364@athlon.random> <20010830003239.L16364@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010830003239.L16364@athlon.random>; from andrea@suse.de on Thu, Aug 30, 2001 at 12:32:39AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2001 at 12:32:39AM +0200, Andrea Arcangeli wrote:
> On Wed, Aug 29, 2001 at 05:25:34PM +0200, Andrea Arcangeli wrote:
> How does this look? (untested, I will test it later together with a
> dozen of other changes)
> 
> btw, a number of other archs was buggy the same way as arm or it will
> benefit by this change the same way as arm.
> 
> I will send to Linus after it is tested.

Linus please include this patch in next kernel. In short Russell pointed
out that the risc port aren't handy in implementing a very lightweight
set bit atomic with respect to interrupts (so only atomic with respect
to the local cpu) because they are missing an "or" or "bit set"
instruction between a register and memory.

Having __cpu_raise_softirq atomic against interrupts only allows us to
re-enable irqs a few cycles before, so it's only a micro irq latency
optimization, it doesn't save cpu cycles so it doesn't worth to hurt
the risc chips for it.

Now both cpu_raise_softirq and __cpu_raise_softirq must be recalled with
irq disabled, only raise_softirq can be called in whatever irq state.

diff -urN 2.4.10pre2aa1/include/asm-alpha/softirq.h 2.4.10pre2aa1-softirq/include/asm-alpha/softirq.h
--- 2.4.10pre2aa1/include/asm-alpha/softirq.h	Sat Jul 21 00:04:29 2001
+++ 2.4.10pre2aa1-softirq/include/asm-alpha/softirq.h	Thu Aug 30 00:22:58 2001
@@ -32,6 +32,4 @@
 
 #define in_softirq() (local_bh_count(smp_processor_id()) != 0)
 
-#define __cpu_raise_softirq(cpu, nr) set_bit(nr, &softirq_pending(cpu))
-
 #endif /* _ALPHA_SOFTIRQ_H */
diff -urN 2.4.10pre2aa1/include/asm-arm/softirq.h 2.4.10pre2aa1-softirq/include/asm-arm/softirq.h
--- 2.4.10pre2aa1/include/asm-arm/softirq.h	Thu Aug 16 22:03:39 2001
+++ 2.4.10pre2aa1-softirq/include/asm-arm/softirq.h	Thu Aug 30 00:23:00 2001
@@ -21,6 +21,4 @@
 		__asm__("bl%? __do_softirq": : : "lr");/* out of line */\
 } while (0)
 
-#define __cpu_raise_softirq(cpu, nr) __set_bit(nr, &softirq_pending(cpu))
-
 #endif	/* __ASM_SOFTIRQ_H */
diff -urN 2.4.10pre2aa1/include/asm-cris/softirq.h 2.4.10pre2aa1-softirq/include/asm-cris/softirq.h
--- 2.4.10pre2aa1/include/asm-cris/softirq.h	Sat Aug 11 08:04:23 2001
+++ 2.4.10pre2aa1-softirq/include/asm-cris/softirq.h	Thu Aug 30 00:23:03 2001
@@ -27,6 +27,4 @@
 
 #define in_softirq() (local_bh_count(smp_processor_id()) != 0)
 
-#define __cpu_raise_softirq(cpu,nr) set_bit((nr), &softirq_pending(cpu))
-
 #endif	/* __ASM_SOFTIRQ_H */
diff -urN 2.4.10pre2aa1/include/asm-i386/softirq.h 2.4.10pre2aa1-softirq/include/asm-i386/softirq.h
--- 2.4.10pre2aa1/include/asm-i386/softirq.h	Wed Aug 29 15:05:25 2001
+++ 2.4.10pre2aa1-softirq/include/asm-i386/softirq.h	Thu Aug 30 00:22:53 2001
@@ -45,6 +45,4 @@
 		/* no registers clobbered */ );				\
 } while (0)
 
-#define __cpu_raise_softirq(cpu, nr) __set_bit(nr, &softirq_pending(cpu))
-
 #endif	/* __ASM_SOFTIRQ_H */
diff -urN 2.4.10pre2aa1/include/asm-ia64/softirq.h 2.4.10pre2aa1-softirq/include/asm-ia64/softirq.h
--- 2.4.10pre2aa1/include/asm-ia64/softirq.h	Sat Aug 11 08:04:25 2001
+++ 2.4.10pre2aa1-softirq/include/asm-ia64/softirq.h	Thu Aug 30 00:23:06 2001
@@ -18,8 +18,6 @@
 } while (0)
 
 
-#define __cpu_raise_softirq(cpu,nr)	set_bit((nr), &softirq_pending(cpu))
-
 #define in_softirq()		(local_bh_count() != 0)
 
 #endif /* _ASM_IA64_SOFTIRQ_H */
diff -urN 2.4.10pre2aa1/include/asm-ppc/softirq.h 2.4.10pre2aa1-softirq/include/asm-ppc/softirq.h
--- 2.4.10pre2aa1/include/asm-ppc/softirq.h	Sat Jul 21 00:04:30 2001
+++ 2.4.10pre2aa1-softirq/include/asm-ppc/softirq.h	Thu Aug 30 00:23:09 2001
@@ -28,8 +28,6 @@
 	}						\
 } while (0)
 
-#define __cpu_raise_softirq(cpu, nr) set_bit((nr), &softirq_pending(cpu));
-
 #define in_softirq() (local_bh_count(smp_processor_id()) != 0)
 
 #endif	/* __ASM_SOFTIRQ_H */
diff -urN 2.4.10pre2aa1/include/asm-s390/softirq.h 2.4.10pre2aa1-softirq/include/asm-s390/softirq.h
--- 2.4.10pre2aa1/include/asm-s390/softirq.h	Thu Aug 16 22:03:40 2001
+++ 2.4.10pre2aa1-softirq/include/asm-s390/softirq.h	Thu Aug 30 00:23:12 2001
@@ -36,8 +36,6 @@
 			do_softirq();					\
 } while (0)
 
-#define __cpu_raise_softirq(cpu, nr) (softirq_pending(cpu) |= (1<<nr))
-
 #endif	/* __ASM_SOFTIRQ_H */
 
 
diff -urN 2.4.10pre2aa1/include/asm-s390x/softirq.h 2.4.10pre2aa1-softirq/include/asm-s390x/softirq.h
--- 2.4.10pre2aa1/include/asm-s390x/softirq.h	Thu Aug 16 22:03:40 2001
+++ 2.4.10pre2aa1-softirq/include/asm-s390x/softirq.h	Thu Aug 30 00:23:14 2001
@@ -36,8 +36,6 @@
 			do_softirq();					\
 } while (0)
 
-#define __cpu_raise_softirq(cpu, nr) (softirq_pending(cpu) |= (1<<nr))
-
 #endif	/* __ASM_SOFTIRQ_H */
 
 
diff -urN 2.4.10pre2aa1/include/asm-sh/softirq.h 2.4.10pre2aa1-softirq/include/asm-sh/softirq.h
--- 2.4.10pre2aa1/include/asm-sh/softirq.h	Sat Jul 21 00:04:31 2001
+++ 2.4.10pre2aa1-softirq/include/asm-sh/softirq.h	Thu Aug 30 00:23:17 2001
@@ -25,8 +25,6 @@
 	}						\
 } while (0)
 
-#define __cpu_raise_softirq(cpu, nr) set_bit((nr), &softirq_pending(cpu));
-
 #define in_softirq() (local_bh_count(smp_processor_id()) != 0)
 
 #endif /* __ASM_SH_SOFTIRQ_H */
diff -urN 2.4.10pre2aa1/include/asm-sparc/softirq.h 2.4.10pre2aa1-softirq/include/asm-sparc/softirq.h
--- 2.4.10pre2aa1/include/asm-sparc/softirq.h	Sat Jul 21 00:04:31 2001
+++ 2.4.10pre2aa1-softirq/include/asm-sparc/softirq.h	Thu Aug 30 00:23:46 2001
@@ -22,13 +22,6 @@
 		__sti();			  \
      }						  \
 } while (0)
-#define __do_cpu_raise_softirq(cpu, nr)	(softirq_pending(cpu) |= (1<<nr))
-#define __cpu_raise_softirq(cpu, nr)			\
-do {	unsigned long flags;				\
-	local_irq_save(flags);				\
-	__do_cpu_raise_softirq(cpu, nr);			\
-	local_irq_restore(flags);			\
-} while (0)
 #define in_softirq() (local_bh_count(smp_processor_id()) != 0)
 
 #endif	/* __SPARC_SOFTIRQ_H */
diff -urN 2.4.10pre2aa1/include/asm-sparc64/softirq.h 2.4.10pre2aa1-softirq/include/asm-sparc64/softirq.h
--- 2.4.10pre2aa1/include/asm-sparc64/softirq.h	Sat Jul 21 00:04:31 2001
+++ 2.4.10pre2aa1-softirq/include/asm-sparc64/softirq.h	Thu Aug 30 00:23:54 2001
@@ -20,13 +20,6 @@
      }						  \
 } while (0)
 
-#define __do_cpu_raise_softirq(cpu, nr)	(softirq_pending(cpu) |= (1<<nr))
-#define __cpu_raise_softirq(cpu,nr)			\
-do {	unsigned long flags;				\
-	local_irq_save(flags);				\
-	__do_cpu_raise_softirq(cpu, nr);			\
-	local_irq_restore(flags);			\
-} while (0)
 #define in_softirq() (local_bh_count(smp_processor_id()) != 0)
 
 #endif /* !(__SPARC64_SOFTIRQ_H) */
diff -urN 2.4.10pre2aa1/include/linux/interrupt.h 2.4.10pre2aa1-softirq/include/linux/interrupt.h
--- 2.4.10pre2aa1/include/linux/interrupt.h	Wed Aug 29 15:05:25 2001
+++ 2.4.10pre2aa1-softirq/include/linux/interrupt.h	Thu Aug 30 00:22:13 2001
@@ -74,6 +74,7 @@
 asmlinkage void do_softirq(void);
 extern void open_softirq(int nr, void (*action)(struct softirq_action*), void *data);
 extern void softirq_init(void);
+#define __cpu_raise_softirq(cpu, nr) do { softirq_pending(cpu) |= 1UL << (nr); } while (0)
 extern void FASTCALL(cpu_raise_softirq(unsigned int cpu, unsigned int nr));
 extern void FASTCALL(raise_softirq(unsigned int nr));
 
diff -urN 2.4.10pre2aa1/kernel/softirq.c 2.4.10pre2aa1-softirq/kernel/softirq.c
--- 2.4.10pre2aa1/kernel/softirq.c	Sat Aug 11 08:04:32 2001
+++ 2.4.10pre2aa1-softirq/kernel/softirq.c	Thu Aug 30 00:24:09 2001
@@ -108,6 +108,9 @@
 	local_irq_restore(flags);
 }
 
+/*
+ * This function must run with irq disabled!
+ */
 inline void cpu_raise_softirq(unsigned int cpu, unsigned int nr)
 {
 	__cpu_raise_softirq(cpu, nr);
@@ -127,7 +130,11 @@
 
 void raise_softirq(unsigned int nr)
 {
+	long flags;
+
+	local_irq_save(flags);
 	cpu_raise_softirq(smp_processor_id(), nr);
+	local_irq_restore(flags);
 }
 
 void open_softirq(int nr, void (*action)(struct softirq_action*), void *data)
@@ -195,8 +202,8 @@
 		local_irq_disable();
 		t->next = tasklet_vec[cpu].list;
 		tasklet_vec[cpu].list = t;
-		local_irq_enable();
 		__cpu_raise_softirq(cpu, TASKLET_SOFTIRQ);
+		local_irq_enable();
 	}
 }
 
@@ -229,8 +236,8 @@
 		local_irq_disable();
 		t->next = tasklet_hi_vec[cpu].list;
 		tasklet_hi_vec[cpu].list = t;
-		local_irq_enable();
 		__cpu_raise_softirq(cpu, HI_SOFTIRQ);
+		local_irq_enable();
 	}
 }
 
diff -urN 2.4.10pre2aa1/net/core/dev.c 2.4.10pre2aa1-softirq/net/core/dev.c
--- 2.4.10pre2aa1/net/core/dev.c	Sat Aug 11 08:04:32 2001
+++ 2.4.10pre2aa1-softirq/net/core/dev.c	Thu Aug 30 00:24:36 2001
@@ -1217,10 +1217,9 @@
 enqueue:
 			dev_hold(skb->dev);
 			__skb_queue_tail(&queue->input_pkt_queue,skb);
-			local_irq_restore(flags);
-
 			/* Runs from irqs or BH's, no need to wake BH */
 			__cpu_raise_softirq(this_cpu, NET_RX_SOFTIRQ);
+			local_irq_restore(flags);
 #ifndef OFFLINE_SAMPLE
 			get_sample_stats(this_cpu);
 #endif
@@ -1529,10 +1528,9 @@
 
 	local_irq_disable();
 	netdev_rx_stat[this_cpu].time_squeeze++;
-	local_irq_enable();
-
 	/* This already runs in BH context, no need to wake up BH's */
 	__cpu_raise_softirq(this_cpu, NET_RX_SOFTIRQ);
+	local_irq_enable();
 
 	NET_PROFILE_LEAVE(softnet_process);
 	return;



Andrea
