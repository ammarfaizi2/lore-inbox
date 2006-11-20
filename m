Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965716AbWKTK3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965716AbWKTK3X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 05:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965711AbWKTK3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 05:29:22 -0500
Received: from il.qumranet.com ([62.219.232.206]:34266 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S965716AbWKTK3W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 05:29:22 -0500
Subject: [PATCH 3/3] KVM: Fix mmu reset locking when setting cr0
From: Avi Kivity <avi@qumranet.com>
Date: Mon, 20 Nov 2006 10:29:20 -0000
To: kvm-devel@lists.sourceforge.net
Cc: akpm@osdl.org, kvm-devel@lists.sourceforge.net, yaniv.kamay@qumranet.com,
       linux-kernel@vger.kernel.org
References: <45617A00.5040303@qumranet.com>
In-Reply-To: <45617A00.5040303@qumranet.com>
Message-Id: <20061120102920.B555325015E@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yaniv Kamay <yaniv@qumranet.com>

An mmu reset needs to be called with the kvm lock held.

Signed-off-by: Yaniv Kamay <yaniv@qumranet.com>
Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -1045,7 +1045,9 @@ static void set_cr0(struct kvm_vcpu *vcp
 	}
 
 	__set_cr0(vcpu, cr0);
+	spin_lock(&vcpu->kvm->lock);
 	kvm_mmu_reset_context(vcpu);
+	spin_unlock(&vcpu->kvm->lock);
 	return;
 }
 
