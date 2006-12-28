Return-Path: <linux-kernel-owner+w=401wt.eu-S1754832AbWL1MpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754832AbWL1MpZ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 07:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754835AbWL1MpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 07:45:24 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:45843 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754832AbWL1MpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 07:45:23 -0500
Date: Thu, 28 Dec 2006 13:42:24 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Avi Kivity <avi@qumranet.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [patch] kvm: fix GFP_KERNEL allocation in atomic section in kvm_dev_ioctl_create_vcpu()
Message-ID: <20061228124224.GA28573@elte.hu>
References: <45939755.7010603@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45939755.7010603@qumranet.com>
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

Subject: [patch] kvm: fix GFP_KERNEL allocation in atomic section in kvm_dev_ioctl_create_vcpu()
From: Ingo Molnar <mingo@elte.hu>

fix a GFP_KERNEL allocation in atomic section bug: 
kvm_dev_ioctl_create_vcpu() called kvm_mmu_init(), which calls 
alloc_pages(), while holding the vcpu. The fix is to set up the MMU 
state earlier, it does not require a loaded CPU state.

(NOTE: free_vcpus does an kvm_mmu_destroy() call so there's no need
 for any extra teardown branch on allocation failure here.)

found in 2.6.20-rc2-rt1.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 drivers/kvm/kvm_main.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: linux/drivers/kvm/kvm_main.c
===================================================================
--- linux.orig/drivers/kvm/kvm_main.c
+++ linux/drivers/kvm/kvm_main.c
@@ -522,12 +522,12 @@ static int kvm_dev_ioctl_create_vcpu(str
 	if (r < 0)
 		goto out_free_vcpus;
 
-	kvm_arch_ops->vcpu_load(vcpu);
+	r = kvm_mmu_init(vcpu);
+	if (r < 0)
+		goto out_free_vcpus;
 
+	kvm_arch_ops->vcpu_load(vcpu);
 	r = kvm_arch_ops->vcpu_setup(vcpu);
-	if (r >= 0)
-		r = kvm_mmu_init(vcpu);
-
 	vcpu_put(vcpu);
 
 	if (r < 0)
