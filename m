Return-Path: <linux-kernel-owner+w=401wt.eu-S1754837AbWL1NLH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754837AbWL1NLH (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 08:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754840AbWL1NLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 08:11:07 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:41118 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754837AbWL1NLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 08:11:06 -0500
Date: Thu, 28 Dec 2006 14:08:33 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Avi Kivity <avi@qumranet.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [patch, try#2] kvm: fix GFP_KERNEL allocation in atomic section in kvm_dev_ioctl_create_vcpu()
Message-ID: <20061228130833.GA555@elte.hu>
References: <45939755.7010603@qumranet.com> <20061228124224.GA28573@elte.hu> <4593BEE6.30206@qumranet.com> <20061228125544.GA31207@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061228125544.GA31207@elte.hu>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> > Yes it does.  It calls nonpaging_init_context() which calls 
> > vmx_set_cr3() which promptly trashes address space of the VM that 
> > previously ran on that vcpu (or, if there were none, logs a vmwrite 
> > error).
> 
> ok, i missed that. Nevertheless the problem of the nonatomic alloc 
> remains. I guess a kvm_mmu_init() needs to be split into 
> kvm_mmu_create() and kvm_mmu_setup()?

the patch below implements this fix. Lightly tested on 32-bit/VMX on 
2.6.20-rc2-rt2 but seems to have done the trick.

	Ingo

-------------------->
Subject: [patch] kvm: fix GFP_KERNEL allocation in atomic section in kvm_dev_ioctl_create_vcpu()
From: Ingo Molnar <mingo@elte.hu>

fix an GFP_KERNEL allocation in atomic section: 
kvm_dev_ioctl_create_vcpu() called kvm_mmu_init(), which calls 
alloc_pages(), while holding the vcpu.

The fix is to set up the MMU state in two phases: kvm_mmu_create() and 
kvm_mmu_setup().

(NOTE: free_vcpus does an kvm_mmu_destroy() call so there's no need
 for any extra teardown branch on allocation/init failure here.)

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 drivers/kvm/kvm.h      |    3 ++-
 drivers/kvm/kvm_main.c |   10 ++++++----
 drivers/kvm/mmu.c      |   24 +++++++++---------------
 3 files changed, 17 insertions(+), 20 deletions(-)

Index: linux/drivers/kvm/kvm.h
===================================================================
--- linux.orig/drivers/kvm/kvm.h
+++ linux/drivers/kvm/kvm.h
@@ -319,7 +319,8 @@ int kvm_init_arch(struct kvm_arch_ops *o
 void kvm_exit_arch(void);
 
 void kvm_mmu_destroy(struct kvm_vcpu *vcpu);
-int kvm_mmu_init(struct kvm_vcpu *vcpu);
+int kvm_mmu_create(struct kvm_vcpu *vcpu);
+int kvm_mmu_setup(struct kvm_vcpu *vcpu);
 
 int kvm_mmu_reset_context(struct kvm_vcpu *vcpu);
 void kvm_mmu_slot_remove_write_access(struct kvm *kvm, int slot);
Index: linux/drivers/kvm/kvm_main.c
===================================================================
--- linux.orig/drivers/kvm/kvm_main.c
+++ linux/drivers/kvm/kvm_main.c
@@ -522,12 +522,14 @@ static int kvm_dev_ioctl_create_vcpu(str
 	if (r < 0)
 		goto out_free_vcpus;
 
-	kvm_arch_ops->vcpu_load(vcpu);
+	r = kvm_mmu_create(vcpu);
+	if (r < 0)
+		goto out_free_vcpus;
 
-	r = kvm_arch_ops->vcpu_setup(vcpu);
+	kvm_arch_ops->vcpu_load(vcpu);
+	r = kvm_mmu_setup(vcpu);
 	if (r >= 0)
-		r = kvm_mmu_init(vcpu);
-
+		r = kvm_arch_ops->vcpu_setup(vcpu);
 	vcpu_put(vcpu);
 
 	if (r < 0)
Index: linux/drivers/kvm/mmu.c
===================================================================
--- linux.orig/drivers/kvm/mmu.c
+++ linux/drivers/kvm/mmu.c
@@ -639,28 +639,22 @@ error_1:
 	return -ENOMEM;
 }
 
-int kvm_mmu_init(struct kvm_vcpu *vcpu)
+int kvm_mmu_create(struct kvm_vcpu *vcpu)
 {
-	int r;
-
 	ASSERT(vcpu);
 	ASSERT(!VALID_PAGE(vcpu->mmu.root_hpa));
 	ASSERT(list_empty(&vcpu->free_pages));
 
-	r = alloc_mmu_pages(vcpu);
-	if (r)
-		goto out;
-
-	r = init_kvm_mmu(vcpu);
-	if (r)
-		goto out_free_pages;
+	return alloc_mmu_pages(vcpu);
+}
 
-	return 0;
+int kvm_mmu_setup(struct kvm_vcpu *vcpu)
+{
+	ASSERT(vcpu);
+	ASSERT(!VALID_PAGE(vcpu->mmu.root_hpa));
+	ASSERT(!list_empty(&vcpu->free_pages));
 
-out_free_pages:
-	free_mmu_pages(vcpu);
-out:
-	return r;
+	return init_kvm_mmu(vcpu);
 }
 
 void kvm_mmu_destroy(struct kvm_vcpu *vcpu)
