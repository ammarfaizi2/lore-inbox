Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266622AbTA2RPy>; Wed, 29 Jan 2003 12:15:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266688AbTA2RPy>; Wed, 29 Jan 2003 12:15:54 -0500
Received: from fmr09.intel.com ([192.52.57.35]:28112 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id <S266622AbTA2RPu>;
	Wed, 29 Jan 2003 12:15:50 -0500
Subject: [RFC][2.5.59 PATCH]Kirq Hook
From: Rusty Lynch <rusty@linux.co.intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: fault-injection-developer 
	<fault-injection-developer@lists.sourceforge.net>,
       Louis Zhuang <louis.zhuang@intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 29 Jan 2003 09:24:49 -0800
Message-Id: <1043861090.10695.20.camel@vmhack>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As part of the work from the fault injection project at 
http://fault-injection.sf.net/, the need for a few features has come up
that are not specific to fault injection.

One of these needed features is the ability to hook into an arbitrary
interrupt handler, and have the opportunity to bypass that handler.
For a fault injection test case we may need to simply note when a given
interrupt has fired, take some action before the driver has a chance to
respond to the interrupt, or maybe just drop the interrupt without the
driver knowing.

The following patch applies to a 2.5.59 kernel to provide such a feature
for the i386 architecture.  There really isn't much to this, we just add
global functions for adding the hook (which we call kirq but I suspect
that's probably a bad choice) and then removing the hook.

Given the development kernel is currently in a feature freeze, and I 
can't really justify this as a driver, then this email is really an early
request for comments.

    --rustyl

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.956   -> 1.957  
#	   arch/i386/Kconfig	1.34    -> 1.35   
#	arch/i386/kernel/Makefile	1.32    -> 1.33   
#	               (new)	        -> 1.1     include/asm-i386/kirq.h
#	               (new)	        -> 1.1     arch/i386/kernel/kirq.c
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/01/20	rusty@vmhack.(none)	1.957
# Adds KIRQ implementation which enables arbitrary interrupt callbacks
# to be hooked into.
# --------------------------------------------
#
diff -Nru a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig	Mon Jan 20 08:44:57 2003
+++ b/arch/i386/Kconfig	Mon Jan 20 08:44:57 2003
@@ -1545,6 +1545,14 @@
 	  Say Y here if you are developing drivers or trying to debug and
 	  identify kernel problems.
 
+config KIRQ
+	bool "Kernel Irq interceptor for X86(experimental)"
+	depends on DEBUG_KERNEL && EXPERIMENTAL
+	help
+	  This option enable an IRQ interceptor. You can get the control
+	  before any specified ISR is executing and decide whether it
+	  should be executing through "register_kirq/unregister_kirq".
+
 config DEBUG_STACKOVERFLOW
 	bool "Check for stack overflows"
 	depends on DEBUG_KERNEL
diff -Nru a/arch/i386/kernel/Makefile b/arch/i386/kernel/Makefile
--- a/arch/i386/kernel/Makefile	Mon Jan 20 08:44:57 2003
+++ b/arch/i386/kernel/Makefile	Mon Jan 20 08:44:57 2003
@@ -4,7 +4,7 @@
 
 EXTRA_TARGETS := head.o init_task.o
 
-export-objs     := mca.o i386_ksyms.o time.o
+export-objs     := mca.o i386_ksyms.o time.o kirq.o
 
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o vm86.o \
 		ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_i386.o \
@@ -30,6 +30,7 @@
 obj-$(CONFIG_PROFILING)		+= profile.o
 obj-$(CONFIG_EDD)             	+= edd.o
 obj-$(CONFIG_MODULES)		+= module.o
+obj-$(CONFIG_KIRQ)		+= kirq.o
 obj-y				+= sysenter.o
 
 EXTRA_AFLAGS   := -traditional
diff -Nru a/arch/i386/kernel/kirq.c b/arch/i386/kernel/kirq.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/i386/kernel/kirq.c	Mon Jan 20 08:44:57 2003
@@ -0,0 +1,123 @@
+/* Support for kernel irq interceptor.
+   (C) 2002 Stanley Wang <stanley.wang@intel.com>.
+*/
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <asm/kirq.h>
+
+struct kirq kirq_list[NR_IRQS] =
+	{ [0 ... NR_IRQS-1] = { NULL, NULL, NULL}};
+
+void kirq_handler(int irq, void *dev_id, struct pt_regs *regs)
+{
+	int	i;
+	struct kirq *p = kirq_list + irq;
+	if (p->handler != NULL){
+		i = (*(p->handler))(p, irq, dev_id, regs);
+		if ( i == 0 )
+			(*(p->isr))(irq, dev_id, regs);
+	}else{
+		printk(KERN_ERR "%s: Dropping unexpected interrupt #%i\n",
+				__FUNCTION__, irq);
+	}
+	return;
+}
+
+int register_kirq(int irq, char *devname, kirq_handler_t handler)
+{
+	struct irqaction *action;
+	irq_desc_t *desc = irq_desc + irq;
+	struct kirq *p = kirq_list + irq;
+	unsigned long flags;
+	
+	if (handler == NULL) {
+		printk(KERN_ERR "%s: Missing handler!\n", __FUNCTION__);
+		return -EINVAL;
+	}
+
+	if (p->handler) {
+		printk(KERN_ERR "%s: KIRQ was regitsered already!\n", __FUNCTION__);
+		return -EINVAL;
+	}
+	
+	spin_lock_irqsave(&desc->lock,flags);
+	
+	action = desc->action;
+	while (action) {
+		if (strcmp(action->name,devname)) {
+			action = action->next;
+		}else{
+			break;
+		}
+	}
+
+	if (!action) {
+		spin_unlock_irqrestore(&desc->lock,flags);
+		return -1; 
+	}
+
+	p->isr = action->handler;
+	p->handler = handler;
+	p->dev_id = action->dev_id;
+		
+	action->handler = kirq_handler;
+		
+	spin_unlock_irqrestore(&desc->lock,flags);
+
+	return 0;
+}
+
+int unregister_kirq(int irq)
+{
+	struct irqaction *action;
+	irq_desc_t *desc = irq_desc + irq;
+	struct kirq *p = kirq_list + irq;
+	unsigned long flags;
+	
+	spin_lock_irqsave(&desc->lock,flags);
+	
+	action = desc->action;
+	while ( action && action->dev_id != p->dev_id) {
+		action = action->next;
+	}
+
+	if (!action) {
+		printk(KERN_ERR "%s: Unregister KIRQ failed!\n", __FUNCTION__);
+		spin_unlock_irqrestore(&desc->lock,flags);
+		return -1;
+	}
+
+	action->handler = p->isr;
+	
+	p->isr = NULL;
+	p->handler = NULL;
+	p->dev_id = NULL;
+		
+	spin_unlock_irqrestore(&desc->lock,flags);
+
+	return 0;
+}
+
+void dispatch_kirq(int irq, struct pt_regs *regs)
+{
+	struct kirq *p = kirq_list + irq;
+	if (p->isr != NULL){
+		(*(p->isr))(irq, p->dev_id, regs);
+	}else{
+		printk(KERN_ERR "%s: Dropping wrong interrupt #%i\n",
+				__FUNCTION__, irq);
+	}
+	return;
+}
+
+EXPORT_SYMBOL_GPL(register_kirq);
+EXPORT_SYMBOL_GPL(unregister_kirq);
+EXPORT_SYMBOL_GPL(dispatch_kirq);
+
diff -Nru a/include/asm-i386/kirq.h b/include/asm-i386/kirq.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-i386/kirq.h	Mon Jan 20 08:44:57 2003
@@ -0,0 +1,27 @@
+#ifndef _ASM_KIRQ_H
+#define _ASM_KIRQ_H
+
+#include <linux/errno.h>
+
+/* Define return value for kirq handler. */
+#define KIRQ_CONTINUE	0
+#define KIRQ_SKIP	1
+
+struct kirq;
+typedef int (*kirq_handler_t)(struct kirq *, int, void *, 
+			      struct pt_regs *);
+struct kirq {
+	void *dev_id;
+	void (*isr)(int, void *, struct pt_regs *);
+	kirq_handler_t	handler;
+};
+
+#ifdef CONFIG_KIRQ
+extern int register_kirq(int irq, char *devname, 
+			 kirq_handler_t handler);
+extern int unregister_kirq(int irq);
+extern void dispatch_kirq(int irq, struct pt_regs* regs);
+#else
+void dispatch_kirq(int irq, struct pt_regs* regs) {}
+#endif /*CONFIG_KIRQ*/
+#endif /*_ASM_KIRQ_H*/



