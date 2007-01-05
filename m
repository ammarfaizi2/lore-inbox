Return-Path: <linux-kernel-owner+w=401wt.eu-S1161019AbXAEH6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161019AbXAEH6s (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 02:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161016AbXAEH6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 02:58:48 -0500
Received: from il.qumranet.com ([62.219.232.206]:53286 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161019AbXAEH6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 02:58:47 -0500
Subject: [PATCH 9/9] KVM: Simplify test for interrupt window
From: Avi Kivity <avi@qumranet.com>
Date: Fri, 05 Jan 2007 07:58:45 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <459E02E7.5020407@qumranet.com>
In-Reply-To: <459E02E7.5020407@qumranet.com>
Message-Id: <20070105075845.EAFEA250048@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No need to test for rflags.if as both VT and SVM specs assure us that on exit caused from
interrupt window opening, 'if' is set.

Signed-off-by: Dor Laor <dor.laor@qumranet.com>
Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/svm.c
===================================================================
--- linux-2.6.orig/drivers/kvm/svm.c
+++ linux-2.6/drivers/kvm/svm.c
@@ -1206,8 +1206,7 @@ static int interrupt_window_interception
 	 * possible
 	 */
 	if (kvm_run->request_interrupt_window &&
-	    !vcpu->irq_summary &&
-	    (vcpu->svm->vmcb->save.rflags & X86_EFLAGS_IF)) {
+	    !vcpu->irq_summary) {
 		++kvm_stat.irq_window_exits;
 		kvm_run->exit_reason = KVM_EXIT_IRQ_WINDOW_OPEN;
 		return 0;
Index: linux-2.6/drivers/kvm/vmx.c
===================================================================
--- linux-2.6.orig/drivers/kvm/vmx.c
+++ linux-2.6/drivers/kvm/vmx.c
@@ -1604,8 +1604,7 @@ static int handle_interrupt_window(struc
 	 * possible
 	 */
 	if (kvm_run->request_interrupt_window &&
-	    !vcpu->irq_summary &&
-	    (vmcs_readl(GUEST_RFLAGS) & X86_EFLAGS_IF)) {
+	    !vcpu->irq_summary) {
 		kvm_run->exit_reason = KVM_EXIT_IRQ_WINDOW_OPEN;
 		++kvm_stat.irq_window_exits;
 		return 0;
