Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263804AbUEMGQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263804AbUEMGQc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 02:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263809AbUEMGQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 02:16:32 -0400
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:50805 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263804AbUEMGQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 02:16:21 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [RFC] Move SysRq register dump processing into do_IRQ
Date: Thu, 13 May 2004 00:37:40 -0500
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@redhat.com>,
       Greg KH <greg@kroah.com>, Vojtech Pavlik <vojtech@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200405130037.42155.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As I mentioned in my other email current implementation of SysRq's "showPc"
option requires sysrq_handle_showregs to be called from the hard interrupt
context only, otherwise the call trace will be wrong. Having entire input
processing execute in hard IRQ context is not always feasible, some
interrupts may need splitting into IRQ/tasklet pairs.

Also, pt_regs structure is currently propagated throughout entire input and
USB systems for no other benefit than displaying the registers and call trace
at SysRq request.

I propose to change SysRq register dump processing in the following fashion:
- SysRq-P merely posts a request for the data (registers and call trace) to
  be printed;
- do_IRQ (or whatever arch's equivalent) checks the at the end of IRQ
  dispatching routine and prints the requested information next time some IRQ
  is raised. The check is cheap as rough attempt can be done without locking
  and if we miss request it's ok as next time do_IRQ called it will notice it.

The patch below implements the SysRq changes and do_IRQ for most popular (IMO)
arches. It works for me on i386. Please let me know if you think it is
acceptable and I will modify the rest of the arches and will remove pt_regs
handling from input system and then from USB. 

===== arch/alpha/kernel/irq.c 1.29 vs edited =====
--- 1.29/arch/alpha/kernel/irq.c	Thu Apr 22 03:40:34 2004
+++ edited/arch/alpha/kernel/irq.c	Wed May 12 23:59:19 2004
@@ -25,6 +25,7 @@
 #include <linux/irq.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
+#include <linux/sysrq.h>
 
 #include <asm/system.h>
 #include <asm/io.h>
@@ -679,6 +680,8 @@
 	spin_unlock(&desc->lock);
 
 	irq_exit();
+
+	sysrq_irq_show_registers(regs);
 }
 
 /*
===== arch/i386/kernel/irq.c 1.52 vs edited =====
--- 1.52/arch/i386/kernel/irq.c	Mon Apr 12 12:54:45 2004
+++ edited/arch/i386/kernel/irq.c	Wed May 12 23:30:51 2004
@@ -34,6 +34,7 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/kallsyms.h>
+#include <linux/sysrq.h>
 
 #include <asm/atomic.h>
 #include <asm/io.h>
@@ -569,6 +570,8 @@
 	spin_unlock(&desc->lock);
 
 	irq_exit();
+
+	sysrq_irq_show_registers(&regs);
 
 	return 1;
 }
===== arch/ia64/kernel/irq.c 1.37 vs edited =====
--- 1.37/arch/ia64/kernel/irq.c	Fri Feb 27 20:13:48 2004
+++ edited/arch/ia64/kernel/irq.c	Wed May 12 23:58:07 2004
@@ -35,6 +35,7 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/kallsyms.h>
+#include <linux/sysrq.h>
 
 #include <asm/atomic.h>
 #include <asm/io.h>
@@ -524,6 +525,9 @@
 		desc->handler->end(irq);
 		spin_unlock(&desc->lock);
 	}
+
+	sysrq_irq_show_registers(regs);
+
 	return 1;
 }
 
===== arch/ppc/kernel/irq.c 1.36 vs edited =====
--- 1.36/arch/ppc/kernel/irq.c	Wed Feb 18 22:42:58 2004
+++ edited/arch/ppc/kernel/irq.c	Thu May 13 00:04:55 2004
@@ -46,6 +46,7 @@
 #include <linux/random.h>
 #include <linux/seq_file.h>
 #include <linux/cpumask.h>
+#include <linux/sysrq.h>
 
 #include <asm/uaccess.h>
 #include <asm/bitops.h>
@@ -531,6 +532,7 @@
 		/* That's not SMP safe ... but who cares ? */
 		ppc_spurious_interrupts++;
         irq_exit();
+	sysrq_irq_show_registers(regs);
 }
 
 unsigned long probe_irq_on (void)
===== arch/ppc64/kernel/irq.c 1.52 vs edited =====
--- 1.52/arch/ppc64/kernel/irq.c	Mon Apr 12 12:54:06 2004
+++ edited/arch/ppc64/kernel/irq.c	Thu May 13 00:06:17 2004
@@ -41,6 +41,7 @@
 #include <linux/proc_fs.h>
 #include <linux/random.h>
 #include <linux/kallsyms.h>
+#include <linux/sysrq.h>
 
 #include <asm/uaccess.h>
 #include <asm/bitops.h>
@@ -617,6 +618,8 @@
 		timer_interrupt(regs);
 	}
 
+	sysrq_irq_show_registers(regs);
+
 	return 1; /* lets ret_from_int know we can do checks */
 }
 
@@ -645,6 +648,8 @@
 		ppc_spurious_interrupts++;
 
 	irq_exit();
+
+	sysrq_irq_show_registers(regs);
 
 	return 1; /* lets ret_from_int know we can do checks */
 }
===== arch/sparc/kernel/irq.c 1.28 vs edited =====
--- 1.28/arch/sparc/kernel/irq.c	Sun Feb 22 17:34:53 2004
+++ edited/arch/sparc/kernel/irq.c	Thu May 13 00:07:40 2004
@@ -30,6 +30,7 @@
 #include <linux/threads.h>
 #include <linux/spinlock.h>
 #include <linux/seq_file.h>
+#include <linux/sysrq.h>
 
 #include <asm/ptrace.h>
 #include <asm/processor.h>
@@ -341,6 +342,7 @@
 	} while (action);
 	enable_pil_irq(irq);
 	irq_exit();
+	sysrq_irq_show_registers(regs);
 }
 
 #ifdef CONFIG_BLK_DEV_FD
===== arch/sparc64/kernel/irq.c 1.40 vs edited =====
--- 1.40/arch/sparc64/kernel/irq.c	Tue Feb 24 22:04:19 2004
+++ edited/arch/sparc64/kernel/irq.c	Thu May 13 00:14:43 2004
@@ -21,6 +21,7 @@
 #include <linux/delay.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
+#include <linux/sysrq.h>
 
 #include <asm/ptrace.h>
 #include <asm/processor.h>
@@ -822,6 +823,7 @@
 		bp->flags &= ~IBF_INPROGRESS;
 	}
 	irq_exit();
+	sysrq_irq_show_registers(regs);
 }
 
 #ifdef CONFIG_BLK_DEV_FD
===== arch/x86_64/kernel/irq.c 1.22 vs edited =====
--- 1.22/arch/x86_64/kernel/irq.c	Wed Feb 18 22:42:58 2004
+++ edited/arch/x86_64/kernel/irq.c	Thu May 13 00:02:07 2004
@@ -33,6 +33,7 @@
 #include <linux/irq.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
+#include <linux/sysrq.h>
 
 #include <asm/atomic.h>
 #include <asm/io.h>
@@ -405,6 +406,9 @@
 	spin_unlock(&desc->lock);
 
 	irq_exit();
+
+	sysrq_irq_show_registers(regs);
+
 	return 1;
 }
 
===== drivers/char/sysrq.c 1.29 vs edited =====
--- 1.29/drivers/char/sysrq.c	Mon Jan 19 18:38:11 2004
+++ edited/drivers/char/sysrq.c	Wed May 12 23:39:52 2004
@@ -135,12 +135,33 @@
 
 
 /* SHOW SYSRQ HANDLERS BLOCK */
+unsigned int sysrq_register_dump_requested;
+static spinlock_t show_registers_lock = SPIN_LOCK_UNLOCKED;
+
+void __sysrq_irq_show_registers(struct pt_regs *pt_regs)
+{
+	unsigned long flags;
+	int doit = 0;
+
+	spin_lock_irqsave(&show_registers_lock, flags);
+	if (sysrq_register_dump_requested) {
+		sysrq_register_dump_requested--;
+		doit = 1;
+	}
+	spin_unlock_irqrestore(&show_registers_lock, flags);
+
+	if (doit)
+		show_regs(pt_regs);
+}
 
 static void sysrq_handle_showregs(int key, struct pt_regs *pt_regs,
 				  struct tty_struct *tty) 
 {
-	if (pt_regs)
-		show_regs(pt_regs);
+	unsigned long flags;
+
+	spin_lock_irqsave(&show_registers_lock, flags);
+	sysrq_register_dump_requested++;
+	spin_unlock_irqrestore(&show_registers_lock, flags);
 }
 static struct sysrq_key_op sysrq_showregs_op = {
 	.handler	= sysrq_handle_showregs,
===== include/linux/sysrq.h 1.5 vs edited =====
--- 1.5/include/linux/sysrq.h	Wed May  7 23:18:01 2003
+++ edited/include/linux/sysrq.h	Thu May 13 00:15:32 2004
@@ -31,13 +31,26 @@
 
 void handle_sysrq(int, struct pt_regs *, struct tty_struct *);
 
-/* 
+/*
  * Nonlocking version of handle sysrq, used by sysrq handlers that need to
  * call sysrq handlers
  */
 
 void __handle_sysrq_nolock(int, struct pt_regs *, struct tty_struct *);
 
+
+/*
+ * Check whether register dump has been requested and print it
+ */
+extern unsigned int sysrq_register_dump_requested;
+void __sysrq_irq_show_registers(struct pt_regs *);
+static inline void sysrq_irq_show_registers(struct pt_regs *pt_regs)
+{
+	if (unlikely(sysrq_register_dump_requested != 0))
+		__sysrq_irq_show_registers(pt_regs);
+}
+
+
 /*
  * Sysrq registration manipulation functions
  */
@@ -70,7 +83,7 @@
 	__sysrq_unlock_table();
 	return retval;
 }
-	
+
 static inline int register_sysrq_key(int key, struct sysrq_key_op *op_p)
 {
 	return __sysrq_swap_key_ops(key, op_p, NULL);
@@ -90,5 +103,9 @@
 
 #define register_sysrq_key(ig,nore) __reterr()
 #define unregister_sysrq_key(ig,nore) __reterr()
+
+static inline void sysrq_irq_show_registes(struct pt_regs *pt_regs)
+{
+}
 
 #endif
