Return-Path: <linux-kernel-owner+w=401wt.eu-S933169AbWLaNWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933169AbWLaNWh (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 08:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933170AbWLaNWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 08:22:37 -0500
Received: from il.qumranet.com ([62.219.232.206]:41780 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933169AbWLaNWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 08:22:36 -0500
Subject: [PATCH] KVM: Improve interrupt response
From: Avi Kivity <avi@qumranet.com>
Date: Sun, 31 Dec 2006 13:22:32 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, akpm@osdl.org
Message-Id: <20061231132232.A98E92500F7@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dor Laor <dor.laor@qumranet.com>

The current interrupt injection mechanism might delay an interrupt under
the following circumstances:

 - if injection fails because the guest is not interruptible (rflags.IF clear,
   or after a 'mov ss' or 'sti' instruction).  Userspace can check rflags,
   but the other cases or not testable under the current API.
 - if injection fails because of a fault during delivery.  This probably
   never happens under normal guests.
 - if injection fails due to a physical interrupt causing a vmexit so that
   it can be handled by the host.

in all cases the guest proceeds without processing the interrupt, reducing
the interactive feel and interrupt throughput of the guest.

This patch fixes the situation by allowing userspace to request an exit when
the 'interrupt window' opens, so that it can re-inject the interrupt at the
right time.  Guest interactivity is very visibly improved.

Signed-off-by: Dor Laor <dor.laor@qumranet.com>
Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -58,6 +58,9 @@ static struct kvm_stats_debugfs_item {
 	{ "io_exits", &kvm_stat.io_exits },
 	{ "mmio_exits", &kvm_stat.mmio_exits },
 	{ "signal_exits", &kvm_stat.signal_exits },
+	{ "irq_window", &kvm_stat.irq_window_exits },
+	{ "halt_exits", &kvm_stat.halt_exits },
+	{ "request_irq", &kvm_stat.request_irq_exits },
 	{ "irq_exits", &kvm_stat.irq_exits },
 	{ 0, 0 }
 };
@@ -1693,12 +1696,12 @@ static long kvm_dev_ioctl(struct file *f
 		if (copy_from_user(&kvm_run, (void *)arg, sizeof kvm_run))
 			goto out;
 		r = kvm_dev_ioctl_run(kvm, &kvm_run);
-		if (r < 0)
+		if (r < 0 &&  r != -EINTR)
 			goto out;
-		r = -EFAULT;
-		if (copy_to_user((void *)arg, &kvm_run, sizeof kvm_run))
+		if (copy_to_user((void *)arg, &kvm_run, sizeof kvm_run)) {
+			r = -EFAULT;
 			goto out;
-		r = 0;
+		}
 		break;
 	}
 	case KVM_GET_REGS: {
Index: linux-2.6/drivers/kvm/kvm.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm.h
+++ linux-2.6/drivers/kvm/kvm.h
@@ -173,6 +173,7 @@ struct kvm_vcpu {
 	struct mutex mutex;
 	int   cpu;
 	int   launched;
+	int interrupt_window_open;
 	unsigned long irq_summary; /* bit vector: 1 per word in irq_pending */
 #define NR_IRQ_WORDS KVM_IRQ_BITMAP_SIZE(unsigned long)
 	unsigned long irq_pending[NR_IRQ_WORDS];
@@ -247,6 +248,9 @@ struct kvm_stat {
 	u32 io_exits;
 	u32 mmio_exits;
 	u32 signal_exits;
+	u32 irq_window_exits;
+	u32 halt_exits;
+	u32 request_irq_exits;
 	u32 irq_exits;
 };
 
Index: linux-2.6/include/linux/kvm.h
===================================================================
--- linux-2.6.orig/include/linux/kvm.h
+++ linux-2.6/include/linux/kvm.h
@@ -11,7 +11,7 @@
 #include <asm/types.h>
 #include <linux/ioctl.h>
 
-#define KVM_API_VERSION 1
+#define KVM_API_VERSION 2
 
 /*
  * Architectural interrupt line count, and the size of the bitmap needed
@@ -45,6 +45,7 @@ enum kvm_exit_reason {
 	KVM_EXIT_DEBUG            = 4,
 	KVM_EXIT_HLT              = 5,
 	KVM_EXIT_MMIO             = 6,
+	KVM_EXIT_IRQ_WINDOW_OPEN  = 7,
 };
 
 /* for KVM_RUN */
@@ -53,11 +54,19 @@ struct kvm_run {
 	__u32 vcpu;
 	__u32 emulated;  /* skip current instruction */
 	__u32 mmio_completed; /* mmio request completed */
+	__u8 request_interrupt_window;
+	__u8 padding1[3];
 
 	/* out */
 	__u32 exit_type;
 	__u32 exit_reason;
 	__u32 instruction_length;
+	__u8 ready_for_interrupt_injection;
+	__u8 if_flag;
+	__u16 padding2;
+	__u64 cr8;
+	__u64 apic_base;
+
 	union {
 		/* KVM_EXIT_UNKNOWN */
 		struct {
Index: linux-2.6/drivers/kvm/svm.c
===================================================================
--- linux-2.6.orig/drivers/kvm/svm.c
+++ linux-2.6/drivers/kvm/svm.c
@@ -235,6 +235,8 @@ static void skip_emulated_instruction(st
 
 	vcpu->rip = vcpu->svm->vmcb->save.rip = vcpu->svm->next_rip;
 	vcpu->svm->vmcb->control.int_state &= ~SVM_INTERRUPT_SHADOW_MASK;
+
+	vcpu->interrupt_window_open = 1;
 }
 
 static int has_svm(void)
@@ -1031,10 +1033,11 @@ static int halt_interception(struct kvm_
 {
 	vcpu->svm->next_rip = vcpu->svm->vmcb->save.rip + 1;
 	skip_emulated_instruction(vcpu);
-	if (vcpu->irq_summary && (vcpu->svm->vmcb->save.rflags & X86_EFLAGS_IF))
+	if (vcpu->irq_summary)
 		return 1;
 
 	kvm_run->exit_reason = KVM_EXIT_HLT;
+	++kvm_stat.halt_exits;
 	return 0;
 }
 
@@ -1186,6 +1189,24 @@ static int msr_interception(struct kvm_v
 		return rdmsr_interception(vcpu, kvm_run);
 }
 
+static int interrupt_window_interception(struct kvm_vcpu *vcpu,
+				   struct kvm_run *kvm_run)
+{
+	/*
+	 * If the user space waits to inject interrupts, exit as soon as
+	 * possible
+	 */
+	if (kvm_run->request_interrupt_window &&
+	    !vcpu->irq_summary &&
+	    (vcpu->svm->vmcb->save.rflags & X86_EFLAGS_IF)) {
+		++kvm_stat.irq_window_exits;
+		kvm_run->exit_reason = KVM_EXIT_IRQ_WINDOW_OPEN;
+		return 0;
+	}
+
+	return 1;
+}
+
 static int (*svm_exit_handlers[])(struct kvm_vcpu *vcpu,
 				      struct kvm_run *kvm_run) = {
 	[SVM_EXIT_READ_CR0]           		= emulate_on_interception,
@@ -1210,6 +1231,7 @@ static int (*svm_exit_handlers[])(struct
 	[SVM_EXIT_NMI]				= nop_on_interception,
 	[SVM_EXIT_SMI]				= nop_on_interception,
 	[SVM_EXIT_INIT]				= nop_on_interception,
+	[SVM_EXIT_VINTR]			= interrupt_window_interception,
 	/* [SVM_EXIT_CR0_SEL_WRITE]		= emulate_on_interception, */
 	[SVM_EXIT_CPUID]			= cpuid_interception,
 	[SVM_EXIT_HLT]				= halt_interception,
@@ -1278,15 +1300,11 @@ static void pre_svm_run(struct kvm_vcpu 
 }
 
 
-static inline void kvm_try_inject_irq(struct kvm_vcpu *vcpu)
+static inline void kvm_do_inject_irq(struct kvm_vcpu *vcpu)
 {
 	struct vmcb_control_area *control;
 
-	if (!vcpu->irq_summary)
-		return;
-
 	control = &vcpu->svm->vmcb->control;
-
 	control->int_vector = pop_irq(vcpu);
 	control->int_ctl &= ~V_INTR_PRIO_MASK;
 	control->int_ctl |= V_IRQ_MASK |
@@ -1301,6 +1319,59 @@ static void kvm_reput_irq(struct kvm_vcp
 		control->int_ctl &= ~V_IRQ_MASK;
 		push_irq(vcpu, control->int_vector);
 	}
+
+	vcpu->interrupt_window_open =
+		!(control->int_state & SVM_INTERRUPT_SHADOW_MASK);
+}
+
+static void do_interrupt_requests(struct kvm_vcpu *vcpu,
+				       struct kvm_run *kvm_run)
+{
+	struct vmcb_control_area *control = &vcpu->svm->vmcb->control;
+
+	vcpu->interrupt_window_open =
+		(!(control->int_state & SVM_INTERRUPT_SHADOW_MASK) &&
+		 (vcpu->svm->vmcb->save.rflags & X86_EFLAGS_IF));
+
+	if (vcpu->interrupt_window_open && vcpu->irq_summary)
+		/*
+		 * If interrupts enabled, and not blocked by sti or mov ss. Good.
+		 */
+		kvm_do_inject_irq(vcpu);
+
+	/*
+	 * Interrupts blocked.  Wait for unblock.
+	 */
+	if (!vcpu->interrupt_window_open &&
+	    (vcpu->irq_summary || kvm_run->request_interrupt_window)) {
+		control->intercept |= 1ULL << INTERCEPT_VINTR;
+	} else
+		control->intercept &= ~(1ULL << INTERCEPT_VINTR);
+}
+
+static void post_kvm_run_save(struct kvm_vcpu *vcpu,
+			      struct kvm_run *kvm_run)
+{
+	kvm_run->ready_for_interrupt_injection = (vcpu->interrupt_window_open &&
+						  vcpu->irq_summary == 0);
+	kvm_run->if_flag = (vcpu->svm->vmcb->save.rflags & X86_EFLAGS_IF) != 0;
+	kvm_run->cr8 = vcpu->cr8;
+	kvm_run->apic_base = vcpu->apic_base;
+}
+
+/*
+ * Check if userspace requested an interrupt window, and that the
+ * interrupt window is open.
+ *
+ * No need to exit to userspace if we already have an interrupt queued.
+ */
+static int dm_request_for_irq_injection(struct kvm_vcpu *vcpu,
+					  struct kvm_run *kvm_run)
+{
+	return (!vcpu->irq_summary &&
+		kvm_run->request_interrupt_window &&
+		vcpu->interrupt_window_open &&
+		(vcpu->svm->vmcb->save.rflags & X86_EFLAGS_IF));
 }
 
 static void save_db_regs(unsigned long *db_regs)
@@ -1326,7 +1397,7 @@ static int svm_vcpu_run(struct kvm_vcpu 
 	u16 ldt_selector;
 
 again:
-	kvm_try_inject_irq(vcpu);
+	do_interrupt_requests(vcpu, kvm_run);
 
 	clgi();
 
@@ -1487,17 +1558,26 @@ again:
 	if (vcpu->svm->vmcb->control.exit_code == SVM_EXIT_ERR) {
 		kvm_run->exit_type = KVM_EXIT_TYPE_FAIL_ENTRY;
 		kvm_run->exit_reason = vcpu->svm->vmcb->control.exit_code;
+		post_kvm_run_save(vcpu, kvm_run);
 		return 0;
 	}
 
 	if (handle_exit(vcpu, kvm_run)) {
 		if (signal_pending(current)) {
 			++kvm_stat.signal_exits;
+			post_kvm_run_save(vcpu, kvm_run);
+			return -EINTR;
+		}
+
+		if (dm_request_for_irq_injection(vcpu, kvm_run)) {
+			++kvm_stat.request_irq_exits;
+			post_kvm_run_save(vcpu, kvm_run);
 			return -EINTR;
 		}
 		kvm_resched(vcpu);
 		goto again;
 	}
+	post_kvm_run_save(vcpu, kvm_run);
 	return 0;
 }
 
Index: linux-2.6/drivers/kvm/vmx.c
===================================================================
--- linux-2.6.orig/drivers/kvm/vmx.c
+++ linux-2.6/drivers/kvm/vmx.c
@@ -263,6 +263,7 @@ static void skip_emulated_instruction(st
 	if (interruptibility & 3)
 		vmcs_write32(GUEST_INTERRUPTIBILITY_INFO,
 			     interruptibility & ~3);
+	vcpu->interrupt_window_open = 1;
 }
 
 static void vmx_inject_gp(struct kvm_vcpu *vcpu, unsigned error_code)
@@ -1214,21 +1215,34 @@ static void kvm_do_inject_irq(struct kvm
 			irq | INTR_TYPE_EXT_INTR | INTR_INFO_VALID_MASK);
 }
 
-static void kvm_try_inject_irq(struct kvm_vcpu *vcpu)
+
+static void do_interrupt_requests(struct kvm_vcpu *vcpu,
+				       struct kvm_run *kvm_run)
 {
-	if ((vmcs_readl(GUEST_RFLAGS) & X86_EFLAGS_IF)
-	    && (vmcs_read32(GUEST_INTERRUPTIBILITY_INFO) & 3) == 0)
+	u32 cpu_based_vm_exec_control;
+
+	vcpu->interrupt_window_open =
+		((vmcs_readl(GUEST_RFLAGS) & X86_EFLAGS_IF) &&
+		 (vmcs_read32(GUEST_INTERRUPTIBILITY_INFO) & 3) == 0);
+
+	if (vcpu->interrupt_window_open &&
+	    vcpu->irq_summary &&
+	    !(vmcs_read32(VM_ENTRY_INTR_INFO_FIELD) & INTR_INFO_VALID_MASK))
 		/*
-		 * Interrupts enabled, and not blocked by sti or mov ss. Good.
+		 * If interrupts enabled, and not blocked by sti or mov ss. Good.
 		 */
 		kvm_do_inject_irq(vcpu);
-	else
+
+	cpu_based_vm_exec_control = vmcs_read32(CPU_BASED_VM_EXEC_CONTROL);
+	if (!vcpu->interrupt_window_open &&
+	    (vcpu->irq_summary || kvm_run->request_interrupt_window))
 		/*
 		 * Interrupts blocked.  Wait for unblock.
 		 */
-		vmcs_write32(CPU_BASED_VM_EXEC_CONTROL,
-			     vmcs_read32(CPU_BASED_VM_EXEC_CONTROL)
-			     | CPU_BASED_VIRTUAL_INTR_PENDING);
+		cpu_based_vm_exec_control |= CPU_BASED_VIRTUAL_INTR_PENDING;
+	else
+		cpu_based_vm_exec_control &= ~CPU_BASED_VIRTUAL_INTR_PENDING;
+	vmcs_write32(CPU_BASED_VM_EXEC_CONTROL, cpu_based_vm_exec_control);
 }
 
 static void kvm_guest_debug_pre(struct kvm_vcpu *vcpu)
@@ -1565,23 +1579,41 @@ static int handle_wrmsr(struct kvm_vcpu 
 	return 1;
 }
 
+static void post_kvm_run_save(struct kvm_vcpu *vcpu,
+			      struct kvm_run *kvm_run)
+{
+	kvm_run->if_flag = (vmcs_readl(GUEST_RFLAGS) & X86_EFLAGS_IF) != 0;
+	kvm_run->cr8 = vcpu->cr8;
+	kvm_run->apic_base = vcpu->apic_base;
+	kvm_run->ready_for_interrupt_injection = (vcpu->interrupt_window_open &&
+						  vcpu->irq_summary == 0);
+}
+
 static int handle_interrupt_window(struct kvm_vcpu *vcpu,
 				   struct kvm_run *kvm_run)
 {
-	/* Turn off interrupt window reporting. */
-	vmcs_write32(CPU_BASED_VM_EXEC_CONTROL,
-		     vmcs_read32(CPU_BASED_VM_EXEC_CONTROL)
-		     & ~CPU_BASED_VIRTUAL_INTR_PENDING);
+	/*
+	 * If the user space waits to inject interrupts, exit as soon as
+	 * possible
+	 */
+	if (kvm_run->request_interrupt_window &&
+	    !vcpu->irq_summary &&
+	    (vmcs_readl(GUEST_RFLAGS) & X86_EFLAGS_IF)) {
+		kvm_run->exit_reason = KVM_EXIT_IRQ_WINDOW_OPEN;
+		++kvm_stat.irq_window_exits;
+		return 0;
+	}
 	return 1;
 }
 
 static int handle_halt(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 {
 	skip_emulated_instruction(vcpu);
-	if (vcpu->irq_summary && (vmcs_readl(GUEST_RFLAGS) & X86_EFLAGS_IF))
+	if (vcpu->irq_summary)
 		return 1;
 
 	kvm_run->exit_reason = KVM_EXIT_HLT;
+	++kvm_stat.halt_exits;
 	return 0;
 }
 
@@ -1632,6 +1664,21 @@ static int kvm_handle_exit(struct kvm_ru
 	return 0;
 }
 
+/*
+ * Check if userspace requested an interrupt window, and that the
+ * interrupt window is open.
+ *
+ * No need to exit to userspace if we already have an interrupt queued.
+ */
+static int dm_request_for_irq_injection(struct kvm_vcpu *vcpu,
+					  struct kvm_run *kvm_run)
+{
+	return (!vcpu->irq_summary &&
+		kvm_run->request_interrupt_window &&
+		vcpu->interrupt_window_open &&
+		(vmcs_readl(GUEST_RFLAGS) & X86_EFLAGS_IF));
+}
+
 static int vmx_vcpu_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 {
 	u8 fail;
@@ -1663,9 +1710,7 @@ again:
 	vmcs_writel(HOST_GS_BASE, segment_base(gs_sel));
 #endif
 
-	if (vcpu->irq_summary &&
-	    !(vmcs_read32(VM_ENTRY_INTR_INFO_FIELD) & INTR_INFO_VALID_MASK))
-		kvm_try_inject_irq(vcpu);
+	do_interrupt_requests(vcpu, kvm_run);
 
 	if (vcpu->guest_debug.enabled)
 		kvm_guest_debug_pre(vcpu);
@@ -1802,6 +1847,7 @@ again:
 
 	fx_save(vcpu->guest_fx_image);
 	fx_restore(vcpu->host_fx_image);
+	vcpu->interrupt_window_open = (vmcs_read32(GUEST_INTERRUPTIBILITY_INFO) & 3) == 0;
 
 #ifndef CONFIG_X86_64
 	asm ("mov %0, %%ds; mov %0, %%es" : : "r"(__USER_DS));
@@ -1834,12 +1880,22 @@ again:
 			/* Give scheduler a change to reschedule. */
 			if (signal_pending(current)) {
 				++kvm_stat.signal_exits;
+				post_kvm_run_save(vcpu, kvm_run);
+				return -EINTR;
+			}
+
+			if (dm_request_for_irq_injection(vcpu, kvm_run)) {
+				++kvm_stat.request_irq_exits;
+				post_kvm_run_save(vcpu, kvm_run);
 				return -EINTR;
 			}
+
 			kvm_resched(vcpu);
 			goto again;
 		}
 	}
+
+	post_kvm_run_save(vcpu, kvm_run);
 	return 0;
 }
 
