Return-Path: <linux-kernel-owner+w=401wt.eu-S1161015AbXAEH4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161015AbXAEH4r (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 02:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161016AbXAEH4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 02:56:47 -0500
Received: from il.qumranet.com ([62.219.232.206]:53276 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161015AbXAEH4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 02:56:47 -0500
Subject: [PATCH 7/9] KVM: Make loading cr3 more robust
From: Avi Kivity <avi@qumranet.com>
Date: Fri, 05 Jan 2007 07:56:45 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <459E02E7.5020407@qumranet.com>
In-Reply-To: <459E02E7.5020407@qumranet.com>
Message-Id: <20070105075645.900B6250048@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

Prevent the guest's loading of a corrupt cr3 (pointing at no guest phsyical
page) from crashing the host.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -463,7 +463,19 @@ void set_cr3(struct kvm_vcpu *vcpu, unsi
 
 	vcpu->cr3 = cr3;
 	spin_lock(&vcpu->kvm->lock);
-	vcpu->mmu.new_cr3(vcpu);
+	/*
+	 * Does the new cr3 value map to physical memory? (Note, we
+	 * catch an invalid cr3 even in real-mode, because it would
+	 * cause trouble later on when we turn on paging anyway.)
+	 *
+	 * A real CPU would silently accept an invalid cr3 and would
+	 * attempt to use it - with largely undefined (and often hard
+	 * to debug) behavior on the guest side.
+	 */
+	if (unlikely(!gfn_to_memslot(vcpu->kvm, cr3 >> PAGE_SHIFT)))
+		inject_gp(vcpu);
+	else
+		vcpu->mmu.new_cr3(vcpu);
 	spin_unlock(&vcpu->kvm->lock);
 }
 EXPORT_SYMBOL_GPL(set_cr3);
