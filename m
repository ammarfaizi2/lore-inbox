Return-Path: <linux-kernel-owner+w=401wt.eu-S1753460AbWL1Mev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753460AbWL1Mev (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 07:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754821AbWL1Mev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 07:34:51 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:55314 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753460AbWL1Meu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 07:34:50 -0500
Date: Thu, 28 Dec 2006 13:32:19 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Avi Kivity <avi@qumranet.com>
Cc: kvm-devel@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [patch] kvm: fix GFP_KERNEL alloc in atomic section bug
Message-ID: <20061228123219.GA27387@elte.hu>
References: <458A57A4.9000807@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <458A57A4.9000807@qumranet.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [patch] kvm: fix GFP_KERNEL alloc in atomic section bug
From: Ingo Molnar <mingo@elte.hu>

KVM does kmalloc() in an atomic section while having preemption disabled 
via vcpu_load(). Fix this by moving the ->*_msr setup from the 
vcpu_setup method to the vcpu_create method.

(This is also a small speedup for setting up a vcpu, which can in theory 
be more frequent than the vcpu_create method).

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 drivers/kvm/vmx.c |   32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

Index: linux/drivers/kvm/vmx.c
===================================================================
--- linux.orig/drivers/kvm/vmx.c
+++ linux/drivers/kvm/vmx.c
@@ -1094,14 +1094,6 @@ static int vmx_vcpu_setup(struct kvm_vcp
 	rdmsrl(MSR_IA32_SYSENTER_EIP, a);
 	vmcs_writel(HOST_IA32_SYSENTER_EIP, a);   /* 22.2.3 */
 
-	ret = -ENOMEM;
-	vcpu->guest_msrs = kmalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!vcpu->guest_msrs)
-		goto out;
-	vcpu->host_msrs = kmalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!vcpu->host_msrs)
-		goto out_free_guest_msrs;
-
 	for (i = 0; i < NR_VMX_MSR; ++i) {
 		u32 index = vmx_msr_index[i];
 		u32 data_low, data_high;
@@ -1155,8 +1147,6 @@ static int vmx_vcpu_setup(struct kvm_vcp
 
 	return 0;
 
-out_free_guest_msrs:
-	kfree(vcpu->guest_msrs);
 out:
 	return ret;
 }
@@ -1906,13 +1896,33 @@ static int vmx_create_vcpu(struct kvm_vc
 {
 	struct vmcs *vmcs;
 
+	vcpu->guest_msrs = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!vcpu->guest_msrs)
+		return -ENOMEM;
+
+	vcpu->host_msrs = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!vcpu->host_msrs)
+		goto out_free_guest_msrs;
+
 	vmcs = alloc_vmcs();
 	if (!vmcs)
-		return -ENOMEM;
+		goto out_free_msrs;
+
 	vmcs_clear(vmcs);
 	vcpu->vmcs = vmcs;
 	vcpu->launched = 0;
+
 	return 0;
+
+out_free_msrs:
+	kfree(vcpu->host_msrs);
+	vcpu->host_msrs = NULL;
+
+out_free_guest_msrs:
+	kfree(vcpu->guest_msrs);
+	vcpu->guest_msrs = NULL;
+
+	return -ENOMEM;
 }
 
 static struct kvm_arch_ops vmx_arch_ops = {

