Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758135AbWK0Mem@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758135AbWK0Mem (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 07:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758134AbWK0Mel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 07:34:41 -0500
Received: from il.qumranet.com ([62.219.232.206]:32451 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1758135AbWK0Mek (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 07:34:40 -0500
Subject: [PATCH 24/38] KVM: Use the general purpose register accessors rather
	than direct access
From: Avi Kivity <avi@qumranet.com>
Date: Mon, 27 Nov 2006 12:34:38 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <456AD5C6.1090406@qumranet.com>
In-Reply-To: <456AD5C6.1090406@qumranet.com>
Message-Id: <20061127123438.51F3E25015E@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -1130,7 +1130,7 @@ static void report_emulation_failure(str
 {
 	static int reported;
 	u8 opcodes[4];
-	unsigned long rip = vmcs_readl(GUEST_RIP);
+	unsigned long rip = ctxt->vcpu->rip;
 	unsigned long rip_linear;
 
 	rip_linear = rip + get_segment_base(ctxt->vcpu, VCPU_SREG_CS);
@@ -1406,13 +1406,15 @@ static int kvm_dev_ioctl_get_regs(struct
 	if (!vcpu)
 		return -ENOENT;
 
+	kvm_arch_ops->cache_regs(vcpu);
+
 	regs->rax = vcpu->regs[VCPU_REGS_RAX];
 	regs->rbx = vcpu->regs[VCPU_REGS_RBX];
 	regs->rcx = vcpu->regs[VCPU_REGS_RCX];
 	regs->rdx = vcpu->regs[VCPU_REGS_RDX];
 	regs->rsi = vcpu->regs[VCPU_REGS_RSI];
 	regs->rdi = vcpu->regs[VCPU_REGS_RDI];
-	regs->rsp = vmcs_readl(GUEST_RSP);
+	regs->rsp = vcpu->regs[VCPU_REGS_RSP];
 	regs->rbp = vcpu->regs[VCPU_REGS_RBP];
 #ifdef __x86_64__
 	regs->r8 = vcpu->regs[VCPU_REGS_R8];
@@ -1425,7 +1427,7 @@ static int kvm_dev_ioctl_get_regs(struct
 	regs->r15 = vcpu->regs[VCPU_REGS_R15];
 #endif
 
-	regs->rip = vmcs_readl(GUEST_RIP);
+	regs->rip = vcpu->rip;
 	regs->rflags = vmcs_readl(GUEST_RFLAGS);
 
 	/*
@@ -1456,7 +1458,7 @@ static int kvm_dev_ioctl_set_regs(struct
 	vcpu->regs[VCPU_REGS_RDX] = regs->rdx;
 	vcpu->regs[VCPU_REGS_RSI] = regs->rsi;
 	vcpu->regs[VCPU_REGS_RDI] = regs->rdi;
-	vmcs_writel(GUEST_RSP, regs->rsp);
+	vcpu->regs[VCPU_REGS_RSP] = regs->rsp;
 	vcpu->regs[VCPU_REGS_RBP] = regs->rbp;
 #ifdef __x86_64__
 	vcpu->regs[VCPU_REGS_R8] = regs->r8;
@@ -1469,9 +1471,11 @@ static int kvm_dev_ioctl_set_regs(struct
 	vcpu->regs[VCPU_REGS_R15] = regs->r15;
 #endif
 
-	vmcs_writel(GUEST_RIP, regs->rip);
+	vcpu->rip = regs->rip;
 	vmcs_writel(GUEST_RFLAGS, regs->rflags);
 
+	kvm_arch_ops->decache_regs(vcpu);
+
 	vcpu_put(vcpu);
 
 	return 0;
