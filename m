Return-Path: <linux-kernel-owner+w=401wt.eu-S965356AbXAKKDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965356AbXAKKDc (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 05:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965358AbXAKKDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 05:03:32 -0500
Received: from il.qumranet.com ([62.219.232.206]:44353 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965356AbXAKKDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 05:03:31 -0500
Subject: [PATCH 1/5] KVM: Make sure there is a vcpu context loaded when
	destroying the mmu
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 11 Jan 2007 10:03:30 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <45A60B2F.6090901@qumranet.com>
In-Reply-To: <45A60B2F.6090901@qumranet.com>
Message-Id: <20070111100330.1CB08250595@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This makes the vmwrite errors on vm shutdown go away.

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -272,7 +272,9 @@ static void kvm_free_physmem(struct kvm 
 
 static void kvm_free_vcpu(struct kvm_vcpu *vcpu)
 {
+	vcpu_load(vcpu->kvm, vcpu_slot(vcpu));
 	kvm_mmu_destroy(vcpu);
+	vcpu_put(vcpu);
 	kvm_arch_ops->vcpu_free(vcpu);
 }
 
