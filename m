Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315544AbSEHXGp>; Wed, 8 May 2002 19:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315545AbSEHXGp>; Wed, 8 May 2002 19:06:45 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:7408 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S315544AbSEHXGm>; Wed, 8 May 2002 19:06:42 -0400
Subject: [PATCH] 2.4: preempt-kernel for MIPS
From: Robert Love <rml@mvista.com>
To: linux-kernel@vger.kernel.org
Cc: kpreempt-tech@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="=-3FDPA0V4gvrttwk9JucK"
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-4) 
Date: 08 May 2002 16:06:58 -0700
Message-Id: <1020899219.880.17.camel@summit>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3FDPA0V4gvrttwk9JucK
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

MontaVista has provided the community with MIPS architecture support for
the preemptive kernel patch.  Thanks specifically to Jun Sun of
MontaVista for the work.

This patch will be integrated with the base 2.4 preempt-kernel patch
soon.  For now, this is diffed on _top_ of preempt-kernel for
2.4.19-pre8.  While it is against 2.4.19-pre8, it should hopefully also
apply to a recent MIPS tree checkout.

Comments are welcome.  Enjoy,

	Robert Love






--=-3FDPA0V4gvrttwk9JucK
Content-Disposition: attachment; filename=preempt-kernel-mips-2.4.19-pre8-1.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=preempt-kernel-mips-2.4.19-pre8-1.patch;
	charset=ISO-8859-1

diff -urN linux-2.4.19-pre8-preempt/arch/mips/config.in linux/arch/mips/con=
fig.in
--- linux-2.4.19-pre8-preempt/arch/mips/config.in	Wed May  8 15:09:53 2002
+++ linux/arch/mips/config.in	Wed May  8 15:54:35 2002
@@ -468,6 +468,7 @@
 #	bool ' Access.Bus support' CONFIG_ACCESSBUS
 #    fi
 fi
+dep_bool 'Preemptible Kernel' CONFIG_PREEMPT $CONFIG_NEW_IRQ
 endmenu
=20
 if [ "$CONFIG_ISA" =3D "y" ]; then
diff -urN linux-2.4.19-pre8-preempt/arch/mips/kernel/i8259.c linux/arch/mip=
s/kernel/i8259.c
--- linux-2.4.19-pre8-preempt/arch/mips/kernel/i8259.c	Wed May  8 15:09:53 =
2002
+++ linux/arch/mips/kernel/i8259.c	Wed May  8 15:54:35 2002
@@ -8,6 +8,7 @@
  * Copyright (C) 1992 Linus Torvalds
  * Copyright (C) 1994 - 2000 Ralf Baechle
  */
+#include <linux/sched.h>
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
diff -urN linux-2.4.19-pre8-preempt/arch/mips/kernel/irq.c linux/arch/mips/=
kernel/irq.c
--- linux-2.4.19-pre8-preempt/arch/mips/kernel/irq.c	Wed May  8 15:09:53 20=
02
+++ linux/arch/mips/kernel/irq.c	Wed May  8 15:56:16 2002
@@ -8,6 +8,8 @@
  * Copyright (C) 1992 Linus Torvalds
  * Copyright (C) 1994 - 2000 Ralf Baechle
  */
+
+#include <linux/sched.h>
 #include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/delay.h>
@@ -19,11 +21,13 @@
 #include <linux/slab.h>
 #include <linux/mm.h>
 #include <linux/random.h>
-#include <linux/sched.h>
+#include <linux/spinlock.h>
+#include <linux/ptrace.h>
=20
 #include <asm/atomic.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
+#include <asm/debug.h>
=20
 /*
  * Controller mappings for all interrupt sources:
@@ -420,6 +424,8 @@
 	struct irqaction * action;
 	unsigned int status;
=20
+	preempt_disable();
+
 	kstat.irqs[cpu][irq]++;
 	spin_lock(&desc->lock);
 	desc->handler->ack(irq);
@@ -481,6 +487,27 @@
=20
 	if (softirq_pending(cpu))
 		do_softirq();
+
+#if defined(CONFIG_PREEMPT)
+	while (--current->preempt_count =3D=3D 0) {
+		db_assert(intr_off());
+		db_assert(!in_interrupt());
+
+		if (current->need_resched =3D=3D 0) {
+			break;
+		}
+
+		current->preempt_count ++;
+		sti();
+		if (user_mode(regs)) {
+			schedule();
+		} else {
+			preempt_schedule();
+		}
+		cli();
+	}
+#endif
+
 	return 1;
 }
=20
diff -urN linux-2.4.19-pre8-preempt/arch/mips/mm/extable.c linux/arch/mips/=
mm/extable.c
--- linux-2.4.19-pre8-preempt/arch/mips/mm/extable.c	Wed May  8 15:09:53 20=
02
+++ linux/arch/mips/mm/extable.c	Wed May  8 15:54:35 2002
@@ -3,6 +3,7 @@
  */
 #include <linux/config.h>
 #include <linux/module.h>
+#include <linux/sched.h>
 #include <linux/spinlock.h>
 #include <asm/uaccess.h>
=20
diff -urN linux-2.4.19-pre8-preempt/include/asm-mips/smplock.h linux/includ=
e/asm-mips/smplock.h
--- linux-2.4.19-pre8-preempt/include/asm-mips/smplock.h	Wed May  8 15:09:1=
1 2002
+++ linux/include/asm-mips/smplock.h	Wed May  8 15:57:41 2002
@@ -5,12 +5,21 @@
  *
  * Default SMP lock implementation
  */
+#include <linux/config.h>
 #include <linux/interrupt.h>
 #include <linux/spinlock.h>
=20
 extern spinlock_t kernel_flag;
=20
+#ifdef CONFIG_SMP
 #define kernel_locked()		spin_is_locked(&kernel_flag)
+#else
+#ifdef CONFIG_PREEMPT
+#define kernel_locked()         preempt_get_count()
+#else
+#define kernel_locked()         1
+#endif
+#endif
=20
 /*
  * Release global kernel lock and global interrupt lock
@@ -42,8 +51,14 @@
  */
 extern __inline__ void lock_kernel(void)
 {
+#ifdef CONFIG_PREEMPT
+	if (current->lock_depth =3D=3D -1)
+		spin_lock(&kernel_flag);
+	++current->lock_depth;
+#else
 	if (!++current->lock_depth)
 		spin_lock(&kernel_flag);
+#endif
 }
=20
 extern __inline__ void unlock_kernel(void)
diff -urN linux-2.4.19-pre8-preempt/include/asm-mips/softirq.h linux/includ=
e/asm-mips/softirq.h
--- linux-2.4.19-pre8-preempt/include/asm-mips/softirq.h	Wed May  8 15:09:1=
1 2002
+++ linux/include/asm-mips/softirq.h	Wed May  8 15:54:35 2002
@@ -15,6 +15,7 @@
=20
 static inline void cpu_bh_disable(int cpu)
 {
+	preempt_disable();
 	local_bh_count(cpu)++;
 	barrier();
 }
@@ -23,6 +24,7 @@
 {
 	barrier();
 	local_bh_count(cpu)--;
+	preempt_enable();
 }
=20
=20
@@ -36,6 +38,7 @@
 	cpu =3D smp_processor_id();				\
 	if (!--local_bh_count(cpu) && softirq_pending(cpu))	\
 		do_softirq();					\
+	preempt_enable();                                       \
 } while (0)
=20
 #define in_softirq() (local_bh_count(smp_processor_id()) !=3D 0)
diff -urN linux-2.4.19-pre8-preempt/include/asm-mips/system.h linux/include=
/asm-mips/system.h
--- linux-2.4.19-pre8-preempt/include/asm-mips/system.h	Wed May  8 15:09:11=
 2002
+++ linux/include/asm-mips/system.h	Wed May  8 15:54:35 2002
@@ -285,4 +285,16 @@
 #define die_if_kernel(msg, regs)					\
 	__die_if_kernel(msg, regs, __FILE__ ":"__FUNCTION__, __LINE__)
=20
+extern __inline__ int intr_on(void)
+{
+	unsigned long flags;
+	save_flags(flags);
+	return flags & 1;
+}
+
+extern __inline__ int intr_off(void)
+{
+	return ! intr_on();
+}
+
 #endif /* _ASM_SYSTEM_H */

--=-3FDPA0V4gvrttwk9JucK--

