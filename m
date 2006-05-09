Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751592AbWEIItI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751592AbWEIItI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 04:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751549AbWEIItD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 04:49:03 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:54659 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751480AbWEIIss
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 04:48:48 -0400
Message-Id: <20060509085157.491027000@sous-sol.org>
References: <20060509084945.373541000@sous-sol.org>
Date: Tue, 09 May 2006 00:00:24 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: [RFC PATCH 24/35] Add support for Xen event channels.
Content-Disposition: inline; filename=evtchn
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Support Xen event channels instead of the i8259 PIC.

Event channels are used to inject events into the kernel, either from
the hypervisor or from another VM.  The injected events are mapped to
interrupts.

If an event needs to be injected, the hypervisor causes an upcall into
the kernel.  The upcall handler then scans the event pending bitmap
and calls do_IRQ for each pending event.

Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 arch/i386/kernel/Makefile               |    6 
 drivers/xen/core/evtchn.c               |  887 ++++++++++++++++++++++++++++++++
 include/asm-i386/hw_irq.h               |    4 
 include/asm-i386/mach-xen/irq_vectors.h |  109 +++
 include/xen/evtchn.h                    |  116 ++++
 5 files changed, 1120 insertions(+), 2 deletions(-)

--- linus-2.6.orig/arch/i386/kernel/Makefile
+++ linus-2.6/arch/i386/kernel/Makefile
@@ -5,7 +5,7 @@
 extra-y := head.o init_task.o vmlinux.lds
 
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o \
-		ptrace.o time.o ioport.o ldt.o setup.o i8259.o sys_i386.o \
+		ptrace.o time.o ioport.o ldt.o setup.o hw_irq.o sys_i386.o \
 		pci-dma.o i386_ksyms.o i387.o bootflag.o \
 		quirks.o i8237.o topology.o alternative.o
 
@@ -42,6 +42,10 @@ EXTRA_AFLAGS   := -traditional
 
 obj-$(CONFIG_SCx200)		+= scx200.o
 
+hw_irq-y			:= i8259.o
+
+hw_irq-$(CONFIG_XEN)		:= ../../../drivers/xen/core/evtchn.o
+
 # vsyscall.o contains the vsyscall DSO images as __initdata.
 # We must build both images before we can assemble it.
 # Note: kbuild does not track this dependency due to usage of .incbin
--- linus-2.6.orig/include/asm-i386/hw_irq.h
+++ linus-2.6/include/asm-i386/hw_irq.h
@@ -68,7 +68,9 @@ extern atomic_t irq_mis_count;
 
 #define IO_APIC_IRQ(x) (((x) >= 16) || ((1<<(x)) & io_apic_irqs))
 
-#if defined(CONFIG_X86_IO_APIC)
+#if defined(CONFIG_X86_XEN)
+extern void hw_resend_irq(struct hw_interrupt_type *h, unsigned int i);
+#elif defined(CONFIG_X86_IO_APIC)
 static inline void hw_resend_irq(struct hw_interrupt_type *h, unsigned int i)
 {
 	if (IO_APIC_IRQ(i))
--- /dev/null
+++ linus-2.6/drivers/xen/core/evtchn.c
@@ -0,0 +1,887 @@
+/******************************************************************************
+ * evtchn.c
+ * 
+ * Communication via Xen event channels.
+ * 
+ * Copyright (c) 2002-2005, K A Fraser
+ * 
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version 2
+ * as published by the Free Software Foundation; or, when distributed
+ * separately from the Linux kernel or incorporated into other
+ * software packages, subject to the following license:
+ * 
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this source file (the "Software"), to deal in the Software without
+ * restriction, including without limitation the rights to use, copy, modify,
+ * merge, publish, distribute, sublicense, and/or sell copies of the Software,
+ * and to permit persons to whom the Software is furnished to do so, subject to
+ * the following conditions:
+ * 
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ * 
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
+ * IN THE SOFTWARE.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/sched.h>
+#include <linux/kernel_stat.h>
+#include <linux/version.h>
+#include <asm/atomic.h>
+#include <asm/system.h>
+#include <asm/ptrace.h>
+#include <asm/synch_bitops.h>
+#include <xen/interface/xen.h>
+#include <xen/interface/event_channel.h>
+#include <xen/interface/physdev.h>
+#include <asm/hypervisor.h>
+#include <xen/evtchn.h>
+#include <linux/mc146818rtc.h> /* RTC_IRQ */
+
+/*
+ * This lock protects updates to the following mapping and reference-count
+ * arrays. The lock does not need to be acquired to read the mapping tables.
+ */
+static spinlock_t irq_mapping_update_lock;
+
+/* IRQ <-> event-channel mappings. */
+static int evtchn_to_irq[NR_EVENT_CHANNELS];
+
+/* Packed IRQ information: binding type, sub-type index, and event channel. */
+static u32 irq_info[NR_IRQS];
+
+/* Binding types. */
+enum { IRQT_UNBOUND, IRQT_PIRQ, IRQT_VIRQ, IRQT_IPI, IRQT_EVTCHN };
+
+/* Constructor for packed IRQ information. */
+static inline u32 mk_irq_info(u32 type, u32 index, u32 evtchn)
+{
+	return ((type << 24) | (index << 16) | evtchn);
+}
+
+/* Convenient shorthand for packed representation of an unbound IRQ. */
+#define IRQ_UNBOUND	mk_irq_info(IRQT_UNBOUND, 0, 0)
+
+/*
+ * Accessors for packed IRQ information.
+ */
+
+static inline unsigned int evtchn_from_irq(int irq)
+{
+	return (u16)(irq_info[irq]);
+}
+
+static inline unsigned int index_from_irq(int irq)
+{
+	return (u8)(irq_info[irq] >> 16);
+}
+
+static inline unsigned int type_from_irq(int irq)
+{
+	return (u8)(irq_info[irq] >> 24);
+}
+
+/* IRQ <-> VIRQ mapping. */
+DEFINE_PER_CPU(int, virq_to_irq[NR_VIRQS]);
+
+/* IRQ <-> IPI mapping. */
+#ifndef NR_IPIS
+#define NR_IPIS 1
+#endif
+DEFINE_PER_CPU(int, ipi_to_irq[NR_IPIS]);
+
+/* Reference counts for bindings to IRQs. */
+static int irq_bindcount[NR_IRQS];
+
+/* Bitmap indicating which PIRQs require Xen to be notified on unmask. */
+static unsigned long pirq_needs_unmask_notify[NR_PIRQS/sizeof(unsigned long)];
+
+#ifdef CONFIG_SMP
+
+static u8 cpu_evtchn[NR_EVENT_CHANNELS];
+static unsigned long cpu_evtchn_mask[NR_CPUS][NR_EVENT_CHANNELS/BITS_PER_LONG];
+
+static inline unsigned long active_evtchns(unsigned int cpu,
+					   struct shared_info *sh,
+					   unsigned int idx)
+{
+	return (sh->evtchn_pending[idx] &
+		cpu_evtchn_mask[cpu][idx] &
+		~sh->evtchn_mask[idx]);
+}
+
+static void bind_evtchn_to_cpu(unsigned int chn, unsigned int cpu)
+{
+	clear_bit(chn, (unsigned long *)cpu_evtchn_mask[cpu_evtchn[chn]]);
+	set_bit(chn, (unsigned long *)cpu_evtchn_mask[cpu]);
+	cpu_evtchn[chn] = cpu;
+}
+
+static void init_evtchn_cpu_bindings(void)
+{
+	/* By default all event channels notify CPU#0. */
+	memset(cpu_evtchn, 0, sizeof(cpu_evtchn));
+	memset(cpu_evtchn_mask[0], ~0, sizeof(cpu_evtchn_mask[0]));
+}
+
+static inline unsigned int cpu_from_evtchn(unsigned int evtchn)
+{
+	return cpu_evtchn[evtchn];
+}
+
+#else
+
+static inline unsigned long active_evtchns(unsigned int cpu,
+					   struct shared_info *sh,
+					   unsigned int idx)
+{
+	return (sh->evtchn_pending[idx] & ~sh->evtchn_mask[idx]);
+}
+
+static void bind_evtchn_to_cpu(unsigned int chn, unsigned int cpu)
+{
+}
+
+static void init_evtchn_cpu_bindings(void)
+{
+}
+
+static inline unsigned int cpu_from_evtchn(unsigned int evtchn)
+{
+	return 0;
+}
+
+#endif
+
+/* Upcall to generic IRQ layer. */
+#ifdef CONFIG_X86
+extern fastcall unsigned int do_IRQ(struct pt_regs *regs);
+#if defined (__i386__)
+static inline void exit_idle(void) {}
+#define IRQ_REG orig_eax
+#elif defined (__x86_64__)
+#include <asm/idle.h>
+#define IRQ_REG orig_rax
+#endif
+#define do_IRQ(irq, regs) do {		\
+	(regs)->IRQ_REG = ~(irq);	\
+	do_IRQ((regs));			\
+} while (0)
+#endif
+
+/* Xen will never allocate port zero for any purpose. */
+#define VALID_EVTCHN(chn)	((chn) != 0)
+
+/*
+ * Force a proper event-channel callback from Xen after clearing the
+ * callback mask. We do this in a very simple manner, by making a call
+ * down into Xen. The pending flag will be checked by Xen on return.
+ */
+void force_evtchn_callback(void)
+{
+	(void)HYPERVISOR_xen_version(0, NULL);
+}
+EXPORT_SYMBOL_GPL(force_evtchn_callback);
+
+/* NB. Interrupts are disabled on entry. */
+asmlinkage void evtchn_do_upcall(struct pt_regs *regs)
+{
+	unsigned long  l1, l2;
+	unsigned int   l1i, l2i, port;
+	int            irq, cpu = smp_processor_id();
+	struct shared_info *s = HYPERVISOR_shared_info;
+	struct vcpu_info *vcpu_info = &s->vcpu_info[cpu];
+
+	vcpu_info->evtchn_upcall_pending = 0;
+
+	/* NB. No need for a barrier here -- XCHG is a barrier on x86. */
+	l1 = xchg(&vcpu_info->evtchn_pending_sel, 0);
+	while (l1 != 0) {
+		l1i = __ffs(l1);
+		l1 &= ~(1UL << l1i);
+
+		while ((l2 = active_evtchns(cpu, s, l1i)) != 0) {
+			l2i = __ffs(l2);
+
+			port = (l1i * BITS_PER_LONG) + l2i;
+			if ((irq = evtchn_to_irq[port]) != -1)
+				do_IRQ(irq, regs);
+			else {
+				exit_idle();
+#ifdef CONFIG_XEN_EVTCHN_DEVICE
+				evtchn_device_upcall(port);
+#else
+				mask_evtchn(port);
+#endif
+			}
+		}
+	}
+}
+
+static int find_unbound_irq(void)
+{
+	int irq;
+
+	for (irq = 0; irq < NR_IRQS; irq++)
+		if (irq_bindcount[irq] == 0)
+			break;
+
+	if (irq == NR_IRQS) {
+		printk(KERN_ERR "No available IRQ to bind to: increase NR_IRQS!\n");
+		irq = -EINVAL;
+	}
+
+	return irq;
+}
+
+static int bind_evtchn_to_irq(unsigned int evtchn)
+{
+	int irq;
+
+	spin_lock(&irq_mapping_update_lock);
+
+	if ((irq = evtchn_to_irq[evtchn]) == -1) {
+		irq = find_unbound_irq();
+		if (irq < 0)
+			goto out;
+		evtchn_to_irq[evtchn] = irq;
+		irq_info[irq] = mk_irq_info(IRQT_EVTCHN, 0, evtchn);
+	}
+
+	irq_bindcount[irq]++;
+out:
+	spin_unlock(&irq_mapping_update_lock);
+
+	return irq;
+}
+
+static int bind_virq_to_irq(unsigned int virq, unsigned int cpu)
+{
+	struct evtchn_op op = { .cmd = EVTCHNOP_bind_virq };
+	int evtchn, irq;
+
+	spin_lock(&irq_mapping_update_lock);
+
+	if ((irq = per_cpu(virq_to_irq, cpu)[virq]) == -1) {
+		irq = find_unbound_irq();
+		if (irq < 0)
+			goto out;
+
+		op.u.bind_virq.virq = virq;
+		op.u.bind_virq.vcpu = cpu;
+		BUG_ON(HYPERVISOR_event_channel_op(&op) != 0);
+		evtchn = op.u.bind_virq.port;
+
+		evtchn_to_irq[evtchn] = irq;
+		irq_info[irq] = mk_irq_info(IRQT_VIRQ, virq, evtchn);
+
+		per_cpu(virq_to_irq, cpu)[virq] = irq;
+
+		bind_evtchn_to_cpu(evtchn, cpu);
+	}
+
+	irq_bindcount[irq]++;
+out:
+	spin_unlock(&irq_mapping_update_lock);
+
+	return irq;
+}
+
+static int bind_ipi_to_irq(unsigned int ipi, unsigned int cpu)
+{
+	struct evtchn_op op = { .cmd = EVTCHNOP_bind_ipi };
+	int evtchn, irq;
+
+	spin_lock(&irq_mapping_update_lock);
+
+	if ((irq = per_cpu(ipi_to_irq, cpu)[ipi]) == -1) {
+		irq = find_unbound_irq();
+		if (irq < 0)
+			goto out;
+
+		op.u.bind_ipi.vcpu = cpu;
+		BUG_ON(HYPERVISOR_event_channel_op(&op) != 0);
+		evtchn = op.u.bind_ipi.port;
+
+		evtchn_to_irq[evtchn] = irq;
+		irq_info[irq] = mk_irq_info(IRQT_IPI, ipi, evtchn);
+
+		per_cpu(ipi_to_irq, cpu)[ipi] = irq;
+
+		bind_evtchn_to_cpu(evtchn, cpu);
+	}
+
+	irq_bindcount[irq]++;
+out:
+	spin_unlock(&irq_mapping_update_lock);
+
+	return irq;
+}
+
+static void unbind_from_irq(unsigned int irq)
+{
+	struct evtchn_op op = { .cmd = EVTCHNOP_close };
+	int evtchn = evtchn_from_irq(irq);
+
+	spin_lock(&irq_mapping_update_lock);
+
+	if ((--irq_bindcount[irq] == 0) && VALID_EVTCHN(evtchn)) {
+		op.u.close.port = evtchn;
+		BUG_ON(HYPERVISOR_event_channel_op(&op) != 0);
+
+		switch (type_from_irq(irq)) {
+		case IRQT_VIRQ:
+			per_cpu(virq_to_irq, cpu_from_evtchn(evtchn))
+				[index_from_irq(irq)] = -1;
+			break;
+		case IRQT_IPI:
+			per_cpu(ipi_to_irq, cpu_from_evtchn(evtchn))
+				[index_from_irq(irq)] = -1;
+			break;
+		default:
+			break;
+		}
+
+		/* Closed ports are implicitly re-bound to VCPU0. */
+		bind_evtchn_to_cpu(evtchn, 0);
+
+		evtchn_to_irq[evtchn] = -1;
+		irq_info[irq] = IRQ_UNBOUND;
+	}
+
+	spin_unlock(&irq_mapping_update_lock);
+}
+
+int bind_evtchn_to_irqhandler(
+	unsigned int evtchn,
+	irqreturn_t (*handler)(int, void *, struct pt_regs *),
+	unsigned long irqflags,
+	const char *devname,
+	void *dev_id)
+{
+	unsigned int irq;
+	int retval;
+
+	irq = bind_evtchn_to_irq(evtchn);
+	if (irq < 0)
+		goto out;
+
+	retval = request_irq(irq, handler, irqflags, devname, dev_id);
+	if (retval != 0) {
+		unbind_from_irq(irq);
+		return retval;
+	}
+out:
+	return irq;
+}
+EXPORT_SYMBOL_GPL(bind_evtchn_to_irqhandler);
+
+int bind_virq_to_irqhandler(
+	unsigned int virq,
+	unsigned int cpu,
+	irqreturn_t (*handler)(int, void *, struct pt_regs *),
+	unsigned long irqflags,
+	const char *devname,
+	void *dev_id)
+{
+	unsigned int irq;
+	int retval;
+
+	irq = bind_virq_to_irq(virq, cpu);
+	if (irq < 0)
+		goto out;
+
+	retval = request_irq(irq, handler, irqflags, devname, dev_id);
+	if (retval != 0) {
+		unbind_from_irq(irq);
+		return retval;
+	}
+out:
+	return irq;
+}
+EXPORT_SYMBOL_GPL(bind_virq_to_irqhandler);
+
+int bind_ipi_to_irqhandler(
+	unsigned int ipi,
+	unsigned int cpu,
+	irqreturn_t (*handler)(int, void *, struct pt_regs *),
+	unsigned long irqflags,
+	const char *devname,
+	void *dev_id)
+{
+	unsigned int irq;
+	int retval;
+
+	irq = bind_ipi_to_irq(ipi, cpu);
+	if (irq < 0)
+		goto out;
+
+	retval = request_irq(irq, handler, irqflags, devname, dev_id);
+	if (retval != 0) {
+		unbind_from_irq(irq);
+		return retval;
+	}
+out:
+	return irq;
+}
+EXPORT_SYMBOL_GPL(bind_ipi_to_irqhandler);
+
+void unbind_from_irqhandler(unsigned int irq, void *dev_id)
+{
+	free_irq(irq, dev_id);
+	unbind_from_irq(irq);
+}
+EXPORT_SYMBOL_GPL(unbind_from_irqhandler);
+
+#ifdef CONFIG_SMP
+static void do_nothing_function(void *ign)
+{
+}
+#endif
+
+/* Rebind an evtchn so that it gets delivered to a specific cpu */
+static void rebind_irq_to_cpu(unsigned irq, unsigned tcpu)
+{
+	struct evtchn_op op = { .cmd = EVTCHNOP_bind_vcpu };
+	int evtchn;
+
+	spin_lock(&irq_mapping_update_lock);
+
+	evtchn = evtchn_from_irq(irq);
+	if (!VALID_EVTCHN(evtchn)) {
+		spin_unlock(&irq_mapping_update_lock);
+		return;
+	}
+
+	/* Send future instances of this interrupt to other vcpu. */
+	op.u.bind_vcpu.port = evtchn;
+	op.u.bind_vcpu.vcpu = tcpu;
+
+	/*
+	 * If this fails, it usually just indicates that we're dealing with a 
+	 * virq or IPI channel, which don't actually need to be rebound. Ignore
+	 * it, but don't do the xenlinux-level rebind in that case.
+	 */
+	if (HYPERVISOR_event_channel_op(&op) >= 0)
+		bind_evtchn_to_cpu(evtchn, tcpu);
+
+	spin_unlock(&irq_mapping_update_lock);
+
+	/*
+	 * Now send the new target processor a NOP IPI. When this returns, it
+	 * will check for any pending interrupts, and so service any that got 
+	 * delivered to the wrong processor by mistake.
+	 * 
+	 * XXX: The only time this is called with interrupts disabled is from
+	 * the hotplug/hotunplug path. In that case, all cpus are stopped with 
+	 * interrupts disabled, and the missed interrupts will be picked up
+	 * when they start again. This is kind of a hack.
+	 */
+	if (!irqs_disabled())
+		smp_call_function(do_nothing_function, NULL, 0, 0);
+}
+
+
+static void set_affinity_irq(unsigned irq, cpumask_t dest)
+{
+	unsigned tcpu = first_cpu(dest);
+	rebind_irq_to_cpu(irq, tcpu);
+}
+
+/*
+ * Interface to generic handling in irq.c
+ */
+
+static unsigned int startup_dynirq(unsigned int irq)
+{
+	int evtchn = evtchn_from_irq(irq);
+
+	if (VALID_EVTCHN(evtchn))
+		unmask_evtchn(evtchn);
+	return 0;
+}
+
+static void shutdown_dynirq(unsigned int irq)
+{
+	int evtchn = evtchn_from_irq(irq);
+
+	if (VALID_EVTCHN(evtchn))
+		mask_evtchn(evtchn);
+}
+
+static void enable_dynirq(unsigned int irq)
+{
+	int evtchn = evtchn_from_irq(irq);
+
+	if (VALID_EVTCHN(evtchn))
+		unmask_evtchn(evtchn);
+}
+
+static void disable_dynirq(unsigned int irq)
+{
+	int evtchn = evtchn_from_irq(irq);
+
+	if (VALID_EVTCHN(evtchn))
+		mask_evtchn(evtchn);
+}
+
+static void ack_dynirq(unsigned int irq)
+{
+	int evtchn = evtchn_from_irq(irq);
+
+	if (VALID_EVTCHN(evtchn)) {
+		mask_evtchn(evtchn);
+		clear_evtchn(evtchn);
+	}
+}
+
+static void end_dynirq(unsigned int irq)
+{
+	int evtchn = evtchn_from_irq(irq);
+
+	if (VALID_EVTCHN(evtchn) && !(irq_desc[irq].status & IRQ_DISABLED))
+		unmask_evtchn(evtchn);
+}
+
+static struct hw_interrupt_type dynirq_type = {
+	"Dynamic-irq",
+	startup_dynirq,
+	shutdown_dynirq,
+	enable_dynirq,
+	disable_dynirq,
+	ack_dynirq,
+	end_dynirq,
+	set_affinity_irq
+};
+
+static inline void pirq_unmask_notify(int pirq)
+{
+	struct physdev_op op;
+	if (unlikely(test_bit(pirq, &pirq_needs_unmask_notify[0]))) {
+		op.cmd = PHYSDEVOP_IRQ_UNMASK_NOTIFY;
+		(void)HYPERVISOR_physdev_op(&op);
+	}
+}
+
+static inline void pirq_query_unmask(int pirq)
+{
+	struct physdev_op op;
+	op.cmd = PHYSDEVOP_IRQ_STATUS_QUERY;
+	op.u.irq_status_query.irq = pirq;
+	(void)HYPERVISOR_physdev_op(&op);
+	clear_bit(pirq, &pirq_needs_unmask_notify[0]);
+	if (op.u.irq_status_query.flags & PHYSDEVOP_IRQ_NEEDS_UNMASK_NOTIFY)
+		set_bit(pirq, &pirq_needs_unmask_notify[0]);
+}
+
+/*
+ * On startup, if there is no action associated with the IRQ then we are
+ * probing. In this case we should not share with others as it will confuse us.
+ */
+#define probing_irq(_irq) (irq_desc[(_irq)].action == NULL)
+
+static unsigned int startup_pirq(unsigned int irq)
+{
+	struct evtchn_op op = { .cmd = EVTCHNOP_bind_pirq };
+	int evtchn = evtchn_from_irq(irq);
+
+	if (VALID_EVTCHN(evtchn))
+		goto out;
+
+	op.u.bind_pirq.pirq  = irq;
+	/* NB. We are happy to share unless we are probing. */
+	op.u.bind_pirq.flags = probing_irq(irq) ? 0 : BIND_PIRQ__WILL_SHARE;
+	if (HYPERVISOR_event_channel_op(&op) != 0) {
+		if (!probing_irq(irq))
+			printk(KERN_INFO "Failed to obtain physical IRQ %d\n",
+			       irq);
+		return 0;
+	}
+	evtchn = op.u.bind_pirq.port;
+
+	pirq_query_unmask(irq_to_pirq(irq));
+
+	bind_evtchn_to_cpu(evtchn, 0);
+	evtchn_to_irq[evtchn] = irq;
+	irq_info[irq] = mk_irq_info(IRQT_PIRQ, irq, evtchn);
+
+ out:
+	unmask_evtchn(evtchn);
+	pirq_unmask_notify(irq_to_pirq(irq));
+
+	return 0;
+}
+
+static void shutdown_pirq(unsigned int irq)
+{
+	struct evtchn_op op = { .cmd = EVTCHNOP_close };
+	int evtchn = evtchn_from_irq(irq);
+
+	if (!VALID_EVTCHN(evtchn))
+		return;
+
+	mask_evtchn(evtchn);
+
+	op.u.close.port = evtchn;
+	BUG_ON(HYPERVISOR_event_channel_op(&op) != 0);
+
+	bind_evtchn_to_cpu(evtchn, 0);
+	evtchn_to_irq[evtchn] = -1;
+	irq_info[irq] = IRQ_UNBOUND;
+}
+
+static void enable_pirq(unsigned int irq)
+{
+	int evtchn = evtchn_from_irq(irq);
+
+	if (VALID_EVTCHN(evtchn)) {
+		unmask_evtchn(evtchn);
+		pirq_unmask_notify(irq_to_pirq(irq));
+	}
+}
+
+static void disable_pirq(unsigned int irq)
+{
+	int evtchn = evtchn_from_irq(irq);
+
+	if (VALID_EVTCHN(evtchn))
+		mask_evtchn(evtchn);
+}
+
+static void ack_pirq(unsigned int irq)
+{
+	int evtchn = evtchn_from_irq(irq);
+
+	if (VALID_EVTCHN(evtchn)) {
+		mask_evtchn(evtchn);
+		clear_evtchn(evtchn);
+	}
+}
+
+static void end_pirq(unsigned int irq)
+{
+	int evtchn = evtchn_from_irq(irq);
+
+	if (VALID_EVTCHN(evtchn) && !(irq_desc[irq].status & IRQ_DISABLED)) {
+		unmask_evtchn(evtchn);
+		pirq_unmask_notify(irq_to_pirq(irq));
+	}
+}
+
+static struct hw_interrupt_type pirq_type = {
+	"Phys-irq",
+	startup_pirq,
+	shutdown_pirq,
+	enable_pirq,
+	disable_pirq,
+	ack_pirq,
+	end_pirq,
+	set_affinity_irq
+};
+
+void hw_resend_irq(struct hw_interrupt_type *h, unsigned int i)
+{
+	int evtchn = evtchn_from_irq(i);
+	struct shared_info *s = HYPERVISOR_shared_info;
+	if (!VALID_EVTCHN(evtchn))
+		return;
+	BUG_ON(!test_bit(evtchn, &s->evtchn_mask[0]));
+	synch_set_bit(evtchn, &s->evtchn_pending[0]);
+}
+
+void notify_remote_via_irq(int irq)
+{
+	int evtchn = evtchn_from_irq(irq);
+
+	if (VALID_EVTCHN(evtchn))
+		notify_remote_via_evtchn(evtchn);
+}
+EXPORT_SYMBOL_GPL(notify_remote_via_irq);
+
+void mask_evtchn(int port)
+{
+	struct shared_info *s = HYPERVISOR_shared_info;
+	synch_set_bit(port, &s->evtchn_mask[0]);
+}
+EXPORT_SYMBOL_GPL(mask_evtchn);
+
+void unmask_evtchn(int port)
+{
+	struct shared_info *s = HYPERVISOR_shared_info;
+	unsigned int cpu = smp_processor_id();
+	struct vcpu_info *vcpu_info = &s->vcpu_info[cpu];
+
+	/* Slow path (hypercall) if this is a non-local port. */
+	if (unlikely(cpu != cpu_from_evtchn(port))) {
+		struct evtchn_op op = { .cmd = EVTCHNOP_unmask,
+				   .u.unmask.port = port };
+		(void)HYPERVISOR_event_channel_op(&op);
+		return;
+	}
+
+	synch_clear_bit(port, &s->evtchn_mask[0]);
+
+	/*
+	 * The following is basically the equivalent of 'hw_resend_irq'. Just
+	 * like a real IO-APIC we 'lose the interrupt edge' if the channel is
+	 * masked.
+	 */
+	if (test_bit(port, &s->evtchn_pending[0]) &&
+	    !synch_test_and_set_bit(port / BITS_PER_LONG,
+				    &vcpu_info->evtchn_pending_sel)) {
+		vcpu_info->evtchn_upcall_pending = 1;
+		if (!vcpu_info->evtchn_upcall_mask)
+			force_evtchn_callback();
+	}
+}
+EXPORT_SYMBOL_GPL(unmask_evtchn);
+
+void irq_resume(void)
+{
+	struct evtchn_op op;
+	int cpu, pirq, virq, ipi, irq, evtchn;
+
+	init_evtchn_cpu_bindings();
+
+	/* New event-channel space is not 'live' yet. */
+	for (evtchn = 0; evtchn < NR_EVENT_CHANNELS; evtchn++)
+		mask_evtchn(evtchn);
+
+	/* Check that no PIRQs are still bound. */
+	for (pirq = 0; pirq < NR_PIRQS; pirq++)
+		BUG_ON(irq_info[pirq_to_irq(pirq)] != IRQ_UNBOUND);
+
+	/* Secondary CPUs must have no VIRQ or IPI bindings. */
+	for (cpu = 1; cpu < NR_CPUS; cpu++) {
+		for (virq = 0; virq < NR_VIRQS; virq++)
+			BUG_ON(per_cpu(virq_to_irq, cpu)[virq] != -1);
+		for (ipi = 0; ipi < NR_IPIS; ipi++)
+			BUG_ON(per_cpu(ipi_to_irq, cpu)[ipi] != -1);
+	}
+
+	/* No IRQ <-> event-channel mappings. */
+	for (irq = 0; irq < NR_IRQS; irq++)
+		irq_info[irq] &= ~0xFFFF; /* zap event-channel binding */
+	for (evtchn = 0; evtchn < NR_EVENT_CHANNELS; evtchn++)
+		evtchn_to_irq[evtchn] = -1;
+
+	/* Primary CPU: rebind VIRQs automatically. */
+	for (virq = 0; virq < NR_VIRQS; virq++) {
+		if ((irq = per_cpu(virq_to_irq, 0)[virq]) == -1)
+			continue;
+
+		BUG_ON(irq_info[irq] != mk_irq_info(IRQT_VIRQ, virq, 0));
+
+		/* Get a new binding from Xen. */
+		memset(&op, 0, sizeof(op));
+		op.cmd              = EVTCHNOP_bind_virq;
+		op.u.bind_virq.virq = virq;
+		op.u.bind_virq.vcpu = 0;
+		BUG_ON(HYPERVISOR_event_channel_op(&op) != 0);
+		evtchn = op.u.bind_virq.port;
+
+		/* Record the new mapping. */
+		evtchn_to_irq[evtchn] = irq;
+		irq_info[irq] = mk_irq_info(IRQT_VIRQ, virq, evtchn);
+
+		/* Ready for use. */
+		unmask_evtchn(evtchn);
+	}
+
+	/* Primary CPU: rebind IPIs automatically. */
+	for (ipi = 0; ipi < NR_IPIS; ipi++) {
+		if ((irq = per_cpu(ipi_to_irq, 0)[ipi]) == -1)
+			continue;
+
+		BUG_ON(irq_info[irq] != mk_irq_info(IRQT_IPI, ipi, 0));
+
+		/* Get a new binding from Xen. */
+		memset(&op, 0, sizeof(op));
+		op.cmd = EVTCHNOP_bind_ipi;
+		op.u.bind_ipi.vcpu = 0;
+		BUG_ON(HYPERVISOR_event_channel_op(&op) != 0);
+		evtchn = op.u.bind_ipi.port;
+
+		/* Record the new mapping. */
+		evtchn_to_irq[evtchn] = irq;
+		irq_info[irq] = mk_irq_info(IRQT_IPI, ipi, evtchn);
+
+		/* Ready for use. */
+		unmask_evtchn(evtchn);
+	}
+}
+
+void init_8259A(int auto_eoi)
+{
+}
+
+void __init init_ISA_irqs (void)
+{
+}
+
+void __init init_IRQ(void)
+{
+	int i;
+	int cpu;
+
+	irq_ctx_init(0);
+
+	spin_lock_init(&irq_mapping_update_lock);
+
+	init_evtchn_cpu_bindings();
+
+	/* No VIRQ or IPI bindings. */
+	for (cpu = 0; cpu < NR_CPUS; cpu++) {
+		for (i = 0; i < NR_VIRQS; i++)
+			per_cpu(virq_to_irq, cpu)[i] = -1;
+		for (i = 0; i < NR_IPIS; i++)
+			per_cpu(ipi_to_irq, cpu)[i] = -1;
+	}
+
+	/* No event-channel -> IRQ mappings. */
+	for (i = 0; i < NR_EVENT_CHANNELS; i++) {
+		evtchn_to_irq[i] = -1;
+		mask_evtchn(i); /* No event channels are 'live' right now. */
+	}
+
+	/* No IRQ -> event-channel mappings. */
+	for (i = 0; i < NR_IRQS; i++)
+		irq_info[i] = IRQ_UNBOUND;
+
+	/* Dynamic IRQ space is currently unbound. Zero the refcnts. */
+	for (i = 0; i < NR_DYNIRQS; i++) {
+		irq_bindcount[dynirq_to_irq(i)] = 0;
+
+		irq_desc[dynirq_to_irq(i)].status  = IRQ_DISABLED;
+		irq_desc[dynirq_to_irq(i)].action  = NULL;
+		irq_desc[dynirq_to_irq(i)].depth   = 1;
+		irq_desc[dynirq_to_irq(i)].handler = &dynirq_type;
+	}
+
+	/* Phys IRQ space is statically bound (1:1 mapping). Nail refcnts. */
+	for (i = 0; i < NR_PIRQS; i++) {
+		irq_bindcount[pirq_to_irq(i)] = 1;
+
+#ifdef RTC_IRQ
+		/* If not domain 0, force our RTC driver to fail its probe. */
+		if ((i == RTC_IRQ) &&
+		    !(xen_start_info->flags & SIF_INITDOMAIN))
+			continue;
+#endif
+
+		irq_desc[pirq_to_irq(i)].status  = IRQ_DISABLED;
+		irq_desc[pirq_to_irq(i)].action  = NULL;
+		irq_desc[pirq_to_irq(i)].depth   = 1;
+		irq_desc[pirq_to_irq(i)].handler = &pirq_type;
+	}
+}
--- /dev/null
+++ linus-2.6/include/asm-i386/mach-xen/irq_vectors.h
@@ -0,0 +1,109 @@
+/*
+ * This file should contain #defines for all of the interrupt vector
+ * numbers used by this architecture.
+ *
+ * In addition, there are some standard defines:
+ *
+ *	FIRST_EXTERNAL_VECTOR:
+ *		The first free place for external interrupts
+ *
+ *	SYSCALL_VECTOR:
+ *		The IRQ vector a syscall makes the user to kernel transition
+ *		under.
+ *
+ *	TIMER_IRQ:
+ *		The IRQ number the timer interrupt comes in at.
+ *
+ *	NR_IRQS:
+ *		The total number of interrupt vectors (including all the
+ *		architecture specific interrupts) needed.
+ *
+ */			
+#ifndef _ASM_IRQ_VECTORS_H
+#define _ASM_IRQ_VECTORS_H
+
+/*
+ * IDT vectors usable for external interrupt sources start
+ * at 0x20:
+ */
+#define FIRST_EXTERNAL_VECTOR	0x20
+
+#define SYSCALL_VECTOR		0x80
+
+/*
+ * Vectors 0x20-0x2f are used for ISA interrupts.
+ */
+
+/*
+ * Special IRQ vectors used by the SMP architecture, 0xf0-0xff
+ *
+ *  Vectors 0xf0-0xfa are free (reserved for future Linux use).
+ */
+#define SPURIOUS_APIC_VECTOR	0xff
+#define ERROR_APIC_VECTOR	0xfe
+
+#define THERMAL_APIC_VECTOR	0xf0
+
+/*
+ * First APIC vector available to drivers: (vectors 0x30-0xee)
+ * we start at 0x31 to spread out vectors evenly between priority
+ * levels. (0x80 is the syscall vector)
+ */
+#define FIRST_DEVICE_VECTOR	0x31
+#define FIRST_SYSTEM_VECTOR	0xef
+
+/*
+ * 16 8259A IRQ's, 208 potential APIC interrupt sources.
+ * Right now the APIC is mostly only used for SMP.
+ * 256 vectors is an architectural limit. (we can have
+ * more than 256 devices theoretically, but they will
+ * have to use shared interrupts)
+ * Since vectors 0x00-0x1f are used/reserved for the CPU,
+ * the usable vector space is 0x20-0xff (224 vectors)
+ */
+
+#define RESCHEDULE_VECTOR	0
+#define CALL_FUNCTION_VECTOR	1
+#define NR_IPIS			2
+
+/*
+ * The maximum number of vectors supported by i386 processors
+ * is limited to 256. For processors other than i386, NR_VECTORS
+ * should be changed accordingly.
+ */
+#define NR_VECTORS 256
+
+#define FPU_IRQ			13
+
+#define	FIRST_VM86_IRQ		3
+#define LAST_VM86_IRQ		15
+#define invalid_vm86_irq(irq)	((irq) < 3 || (irq) > 15)
+
+/*
+ * The flat IRQ space is divided into two regions:
+ *  1. A one-to-one mapping of real physical IRQs. This space is only used
+ *     if we have physical device-access privilege. This region is at the 
+ *     start of the IRQ space so that existing device drivers do not need
+ *     to be modified to translate physical IRQ numbers into our IRQ space.
+ *  3. A dynamic mapping of inter-domain and Xen-sourced virtual IRQs. These
+ *     are bound using the provided bind/unbind functions.
+ */
+
+#define PIRQ_BASE		0
+#define PIRQ_BITS		8
+#define NR_PIRQS		(1 << PIRQ_BITS)
+
+#define DYNIRQ_BASE		(PIRQ_BASE + NR_PIRQS)
+#define DYNIRQ_BITS		8
+#define NR_DYNIRQS		(1 << DYNIRQ_BITS)
+
+#define NR_IRQS			(NR_PIRQS + NR_DYNIRQS)
+#define NR_IRQ_VECTORS		NR_IRQS
+
+#define pirq_to_irq(_x)		((_x) + PIRQ_BASE)
+#define irq_to_pirq(_x)		((_x) - PIRQ_BASE)
+
+#define dynirq_to_irq(_x)	((_x) + DYNIRQ_BASE)
+#define irq_to_dynirq(_x)	((_x) - DYNIRQ_BASE)
+
+#endif /* _ASM_IRQ_VECTORS_H */
--- /dev/null
+++ linus-2.6/include/xen/evtchn.h
@@ -0,0 +1,116 @@
+/******************************************************************************
+ * evtchn.h
+ * 
+ * Communication via Xen event channels.
+ * Also definitions for the device that demuxes notifications to userspace.
+ * 
+ * Copyright (c) 2004-2005, K A Fraser
+ * 
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version 2
+ * as published by the Free Software Foundation; or, when distributed
+ * separately from the Linux kernel or incorporated into other
+ * software packages, subject to the following license:
+ * 
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this source file (the "Software"), to deal in the Software without
+ * restriction, including without limitation the rights to use, copy, modify,
+ * merge, publish, distribute, sublicense, and/or sell copies of the Software,
+ * and to permit persons to whom the Software is furnished to do so, subject to
+ * the following conditions:
+ * 
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ * 
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
+ * IN THE SOFTWARE.
+ */
+
+#ifndef __ASM_EVTCHN_H__
+#define __ASM_EVTCHN_H__
+
+#include <linux/config.h>
+#include <linux/interrupt.h>
+#include <asm/hypervisor.h>
+#include <asm/ptrace.h>
+#include <asm/synch_bitops.h>
+#include <xen/interface/event_channel.h>
+#include <linux/smp.h>
+
+/*
+ * LOW-LEVEL DEFINITIONS
+ */
+
+/*
+ * Dynamically bind an event source to an IRQ-like callback handler.
+ * On some platforms this may not be implemented via the Linux IRQ subsystem.
+ * The IRQ argument passed to the callback handler is the same as returned
+ * from the bind call. It may not correspond to a Linux IRQ number.
+ * Returns IRQ or negative errno.
+ * UNBIND: Takes IRQ to unbind from; automatically closes the event channel.
+ */
+extern int bind_evtchn_to_irqhandler(
+	unsigned int evtchn,
+	irqreturn_t (*handler)(int, void *, struct pt_regs *),
+	unsigned long irqflags,
+	const char *devname,
+	void *dev_id);
+extern int bind_virq_to_irqhandler(
+	unsigned int virq,
+	unsigned int cpu,
+	irqreturn_t (*handler)(int, void *, struct pt_regs *),
+	unsigned long irqflags,
+	const char *devname,
+	void *dev_id);
+extern int bind_ipi_to_irqhandler(
+	unsigned int ipi,
+	unsigned int cpu,
+	irqreturn_t (*handler)(int, void *, struct pt_regs *),
+	unsigned long irqflags,
+	const char *devname,
+	void *dev_id);
+
+/*
+ * Common unbind function for all event sources. Takes IRQ to unbind from.
+ * Automatically closes the underlying event channel (even for bindings
+ * made with bind_evtchn_to_irqhandler()).
+ */
+extern void unbind_from_irqhandler(unsigned int irq, void *dev_id);
+
+extern void irq_resume(void);
+
+/* Entry point for notifications into Linux subsystems. */
+asmlinkage void evtchn_do_upcall(struct pt_regs *regs);
+
+/* Entry point for notifications into the userland character device. */
+extern void evtchn_device_upcall(int port);
+
+extern void mask_evtchn(int port);
+extern void unmask_evtchn(int port);
+
+static inline void clear_evtchn(int port)
+{
+	struct shared_info *s = HYPERVISOR_shared_info;
+	synch_clear_bit(port, &s->evtchn_pending[0]);
+}
+
+static inline void notify_remote_via_evtchn(int port)
+{
+	struct evtchn_op op;
+	op.cmd         = EVTCHNOP_send,
+	op.u.send.port = port;
+	(void)HYPERVISOR_event_channel_op(&op);
+}
+
+/*
+ * Unlike notify_remote_via_evtchn(), this is safe to use across
+ * save/restore. Notifications on a broken connection are silently dropped.
+ */
+extern void notify_remote_via_irq(int irq);
+
+#endif /* __ASM_EVTCHN_H__ */

--
