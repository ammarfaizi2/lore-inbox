Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758092AbWK0MQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758092AbWK0MQj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 07:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758087AbWK0MQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 07:16:39 -0500
Received: from il.qumranet.com ([62.219.232.206]:31669 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1758093AbWK0MQi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 07:16:38 -0500
Subject: [PATCH 6/38] KVM: Make the guest debugger an arch operation
From: Avi Kivity <avi@qumranet.com>
Date: Mon, 27 Nov 2006 12:16:37 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <456AD5C6.1090406@qumranet.com>
In-Reply-To: <456AD5C6.1090406@qumranet.com>
Message-Id: <20061127121637.3A84125015E@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm.h
+++ linux-2.6/drivers/kvm/kvm.h
@@ -242,6 +242,9 @@ struct kvm_arch_ops {
 	void (*hardware_disable)(void *dummy);
 	int (*hardware_setup)(void);               /* __init */
 	void (*hardware_unsetup)(void);            /* __exit */
+
+	int (*set_guest_debug)(struct kvm_vcpu *vcpu,
+			       struct kvm_debug_guest *dbg);
 };
 
 extern struct kvm_stat kvm_stat;
Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -611,6 +611,7 @@ unsigned long vmcs_readl(unsigned long f
 		      : "=a"(value) : "d"(field) : "cc");
 	return value;
 }
+EXPORT_SYMBOL_GPL(vmcs_readl);
 
 void vmcs_writel(unsigned long field, unsigned long value)
 {
@@ -622,6 +623,7 @@ void vmcs_writel(unsigned long field, un
 		printk(KERN_ERR "vmwrite error: reg %lx value %lx (err %d)\n",
 		       field, value, vmcs_read32(VM_INSTRUCTION_ERROR));
 }
+EXPORT_SYMBOL_GPL(vmcs_writel);
 
 static void vmcs_write16(unsigned long field, u16 value)
 {
@@ -3230,9 +3232,7 @@ static int kvm_dev_ioctl_debug_guest(str
 				     struct kvm_debug_guest *dbg)
 {
 	struct kvm_vcpu *vcpu;
-	unsigned long dr7 = 0x400;
-	u32 exception_bitmap;
-	int old_singlestep;
+	int r;
 
 	if (dbg->vcpu < 0 || dbg->vcpu >= KVM_MAX_VCPUS)
 		return -EINVAL;
@@ -3240,44 +3240,11 @@ static int kvm_dev_ioctl_debug_guest(str
 	if (!vcpu)
 		return -ENOENT;
 
-	exception_bitmap = vmcs_read32(EXCEPTION_BITMAP);
-	old_singlestep = vcpu->guest_debug.singlestep;
-
-	vcpu->guest_debug.enabled = dbg->enabled;
-	if (vcpu->guest_debug.enabled) {
-		int i;
-
-		dr7 |= 0x200;  /* exact */
-		for (i = 0; i < 4; ++i) {
-			if (!dbg->breakpoints[i].enabled)
-				continue;
-			vcpu->guest_debug.bp[i] = dbg->breakpoints[i].address;
-			dr7 |= 2 << (i*2);    /* global enable */
-			dr7 |= 0 << (i*4+16); /* execution breakpoint */
-		}
-
-		exception_bitmap |= (1u << 1);  /* Trap debug exceptions */
-
-		vcpu->guest_debug.singlestep = dbg->singlestep;
-	} else {
-		exception_bitmap &= ~(1u << 1); /* Ignore debug exceptions */
-		vcpu->guest_debug.singlestep = 0;
-	}
-
-	if (old_singlestep && !vcpu->guest_debug.singlestep) {
-		unsigned long flags;
-
-		flags = vmcs_readl(GUEST_RFLAGS);
-		flags &= ~(X86_EFLAGS_TF | X86_EFLAGS_RF);
-		vmcs_writel(GUEST_RFLAGS, flags);
-	}
-
-	vmcs_write32(EXCEPTION_BITMAP, exception_bitmap);
-	vmcs_writel(GUEST_DR7, dr7);
+	r = kvm_arch_ops->set_guest_debug(vcpu, dbg);
 
 	vcpu_put(vcpu);
 
-	return 0;
+	return r;
 }
 
 static long kvm_dev_ioctl(struct file *filp,
Index: linux-2.6/drivers/kvm/vmx.c
===================================================================
--- linux-2.6.orig/drivers/kvm/vmx.c
+++ linux-2.6/drivers/kvm/vmx.c
@@ -31,6 +31,50 @@ extern struct vmcs_descriptor {
 	u32 revision_id;
 } vmcs_descriptor;
 
+static int set_guest_debug(struct kvm_vcpu *vcpu, struct kvm_debug_guest *dbg)
+{
+	unsigned long dr7 = 0x400;
+	u32 exception_bitmap;
+	int old_singlestep;
+
+	exception_bitmap = vmcs_read32(EXCEPTION_BITMAP);
+	old_singlestep = vcpu->guest_debug.singlestep;
+
+	vcpu->guest_debug.enabled = dbg->enabled;
+	if (vcpu->guest_debug.enabled) {
+		int i;
+
+		dr7 |= 0x200;  /* exact */
+		for (i = 0; i < 4; ++i) {
+			if (!dbg->breakpoints[i].enabled)
+				continue;
+			vcpu->guest_debug.bp[i] = dbg->breakpoints[i].address;
+			dr7 |= 2 << (i*2);    /* global enable */
+			dr7 |= 0 << (i*4+16); /* execution breakpoint */
+		}
+
+		exception_bitmap |= (1u << 1);  /* Trap debug exceptions */
+
+		vcpu->guest_debug.singlestep = dbg->singlestep;
+	} else {
+		exception_bitmap &= ~(1u << 1); /* Ignore debug exceptions */
+		vcpu->guest_debug.singlestep = 0;
+	}
+
+	if (old_singlestep && !vcpu->guest_debug.singlestep) {
+		unsigned long flags;
+
+		flags = vmcs_readl(GUEST_RFLAGS);
+		flags &= ~(X86_EFLAGS_TF | X86_EFLAGS_RF);
+		vmcs_writel(GUEST_RFLAGS, flags);
+	}
+
+	vmcs_write32(EXCEPTION_BITMAP, exception_bitmap);
+	vmcs_writel(GUEST_DR7, dr7);
+
+	return 0;
+}
+
 static __init int cpu_has_kvm_support(void)
 {
 	unsigned long ecx = cpuid_ecx(1);
@@ -123,6 +167,8 @@ static struct kvm_arch_ops vmx_arch_ops 
 	.hardware_unsetup = hardware_unsetup,
 	.hardware_enable = hardware_enable,
 	.hardware_disable = hardware_disable,
+
+	.set_guest_debug = set_guest_debug,
 };
 
 static int __init vmx_init(void)
