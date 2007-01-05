Return-Path: <linux-kernel-owner+w=401wt.eu-S1161005AbXAEHvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161005AbXAEHvw (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 02:51:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161006AbXAEHvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 02:51:52 -0500
Received: from il.qumranet.com ([62.219.232.206]:39610 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161005AbXAEHvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 02:51:51 -0500
Subject: [PATCH 2/9] KVM: Initialize vcpu->kvm a little earlier
From: Avi Kivity <avi@qumranet.com>
Date: Fri, 05 Jan 2007 07:51:45 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <459E02E7.5020407@qumranet.com>
In-Reply-To: <459E02E7.5020407@qumranet.com>
Message-Id: <20070105075145.37C11250048@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes oops on early close of /dev/kvm.

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -230,6 +230,7 @@ static int kvm_dev_open(struct inode *in
 		struct kvm_vcpu *vcpu = &kvm->vcpus[i];
 
 		mutex_init(&vcpu->mutex);
+		vcpu->kvm = kvm;
 		vcpu->mmu.root_hpa = INVALID_PAGE;
 		INIT_LIST_HEAD(&vcpu->free_pages);
 	}
@@ -530,7 +531,6 @@ static int kvm_dev_ioctl_create_vcpu(str
 	vcpu->guest_fx_image = vcpu->host_fx_image + FX_IMAGE_SIZE;
 
 	vcpu->cpu = -1;  /* First load will set up TR */
-	vcpu->kvm = kvm;
 	r = kvm_arch_ops->vcpu_create(vcpu);
 	if (r < 0)
 		goto out_free_vcpus;
