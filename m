Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271435AbRHOUpr>; Wed, 15 Aug 2001 16:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271438AbRHOUpi>; Wed, 15 Aug 2001 16:45:38 -0400
Received: from smtp.mailbox.net.uk ([195.82.125.32]:57506 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S271437AbRHOUpX>; Wed, 15 Aug 2001 16:45:23 -0400
Date: Wed, 15 Aug 2001 21:45:04 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Maksim Krasnyanskiy <maxk@qualcomm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.9-pre[34] changes in drivers/char/vt.c broke Sparc64
Message-ID: <20010815214504.B27837@flint.arm.linux.org.uk>
In-Reply-To: <4.3.1.0.20010815133146.034a75c0@mail1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <4.3.1.0.20010815133146.034a75c0@mail1>; from maxk@qualcomm.com on Wed, Aug 15, 2001 at 01:37:17PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2001 at 01:37:17PM -0700, Maksim Krasnyanskiy wrote:
> Have you guys noticed that new vt.c in 2.4.9-pre[34] doesn't compile on
> Sparc64 (and Sparc32) ?
> 
> sparc64-linux-gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -m64 -pipe -mno-fpu -mcpu=ultrasparc -mcmodel=medlow -ffixed-g4 -fcall-used-g5 -fcall-used-g7 -Wno-sign-compare -Wa,--undeclared-regs    -c -o vt.o vt.c
> In file included from vt.c:27:
> /usr/src/linux/include/linux/irq.h:57: asm/hw_irq.h: No such file or directory
> vt.c: In function `vt_ioctl':
> vt.c:507: `kbd_rate' undeclared (first use in this function)
> vt.c:507: (Each undeclared identifier is reported only once
> vt.c:507: for each function it appears in.)
> vt.c:514: `kbd_rate' used prior to declaration
> vt.c:514: warning: implicit declaration of function `kbd_rate'
> 
> Simple commenting out #include <linux/irq.h> and ioctl code that uses
> kbd_rate works. Whoever changed vt.c please post correct fix.

I came across both of these in 2.4.8-ac.  The best fix is non-obvious,
and the code is very unclear.

Turns out the only reasonable way is to declare kbd_rate as a weak symbol
in your asm/keyboard.h:

extern int kbd_rate(struct kbd_repeat *rate) __attribute__((weak));

Second thing is <linux/irq.h>.  I strongly disagree with this change,
(see the comments in linux/irq.h in this patch) and I've sent the
following patch to Alan to fix this cockup.

diff -urN linux-orig/drivers/char/sysrq.c linux/drivers/char/sysrq.c
--- linux-orig/drivers/char/sysrq.c	Tue Aug 14 20:49:06 2001
+++ linux/drivers/char/sysrq.c	Sun Aug 12 20:24:21 2001
@@ -27,7 +27,6 @@
 #include <linux/quotaops.h>
 #include <linux/smp_lock.h>
 #include <linux/module.h>
-#include <linux/irq.h>
 
 #include <linux/spinlock.h>
 
diff -urN linux-orig/drivers/char/vt.c linux/drivers/char/vt.c
--- linux-orig/drivers/char/vt.c	Tue Aug 14 20:49:06 2001
+++ linux/drivers/char/vt.c	Sun Aug 12 20:08:13 2001
@@ -24,7 +24,6 @@
 #include <linux/major.h>
 #include <linux/fs.h>
 #include <linux/console.h>
-#include <linux/irq.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
diff -urN linux-orig/include/asm-i386/irq.h linux/include/asm-i386/irq.h
--- linux-orig/include/asm-i386/irq.h	Tue Aug 14 20:49:29 2001
+++ linux/include/asm-i386/irq.h	Sun Aug 12 20:02:12 2001
@@ -35,7 +35,7 @@
 extern void enable_irq(unsigned int);
 
 #ifdef CONFIG_X86_LOCAL_APIC
-#define ARCH_HAS_NMI_WATCHDOG		/* See include/linux/irq.h */
+#define ARCH_HAS_NMI_WATCHDOG		/* See include/linux/nmi.h */
 #endif
 
 #endif /* _ASM_IRQ_H */
diff -urN linux-orig/include/linux/irq.h linux/include/linux/irq.h
--- linux-orig/include/linux/irq.h	Tue Aug 14 20:49:32 2001
+++ linux/include/linux/irq.h	Sun Aug 12 20:01:17 2001
@@ -1,6 +1,14 @@
 #ifndef __irq_h
 #define __irq_h
 
+/*
+ * Please do not include this file in generic code.  There is currently
+ * no requirement for any architecture to implement anything held
+ * within this file.
+ *
+ * Thanks. --rmk
+ */
+
 #include <linux/config.h>
 
 #if !defined(CONFIG_ARCH_S390)
@@ -59,19 +67,6 @@
 extern irq_desc_t irq_desc [NR_IRQS];
 
 #include <asm/hw_irq.h> /* the arch dependent stuff */
-
-/**
- * touch_nmi_watchdog - restart NMI watchdog timeout.
- * 
- * If the architecture supports the NMI watchdog, touch_nmi_watchdog()
- * may be used to reset the timeout - for code which intentionally
- * disables interrupts for a long time. This call is stateless.
- */
-#ifdef ARCH_HAS_NMI_WATCHDOG
-extern void touch_nmi_watchdog(void);
-#else
-# define touch_nmi_watchdog() do { } while(0)
-#endif
 
 extern int handle_IRQ_event(unsigned int, struct pt_regs *, struct irqaction *);
 extern int setup_irq(unsigned int , struct irqaction * );
diff -urN linux-orig/include/linux/nmi.h linux/include/linux/nmi.h
--- linux-orig/include/linux/nmi.h	Thu Jan  1 01:00:00 1970
+++ linux/include/linux/nmi.h	Sun Aug 12 20:02:04 2001
@@ -0,0 +1,22 @@
+/*
+ *  linux/include/linux/nmi.h
+ */
+#ifndef LINUX_NMI_H
+#define LINUX_NMI_H
+
+#include <asm/irq.h>
+
+/**
+ * touch_nmi_watchdog - restart NMI watchdog timeout.
+ * 
+ * If the architecture supports the NMI watchdog, touch_nmi_watchdog()
+ * may be used to reset the timeout - for code which intentionally
+ * disables interrupts for a long time. This call is stateless.
+ */
+#ifdef ARCH_HAS_NMI_WATCHDOG
+extern void touch_nmi_watchdog(void);
+#else
+# define touch_nmi_watchdog() do { } while(0)
+#endif
+
+#endif
diff -urN linux-orig/kernel/sched.c linux/kernel/sched.c
--- linux-orig/kernel/sched.c	Tue Aug 14 20:49:34 2001
+++ linux/kernel/sched.c	Tue Aug 14 21:39:03 2001
@@ -23,7 +23,7 @@
 #include <linux/mm.h>
 #include <linux/init.h>
 #include <linux/smp_lock.h>
-#include <linux/irq.h>
+#include <linux/nmi.h>
 #include <linux/interrupt.h>
 #include <linux/kernel_stat.h>
 #include <linux/completion.h>


--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

