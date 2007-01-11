Return-Path: <linux-kernel-owner+w=401wt.eu-S1030238AbXAKKGc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030238AbXAKKGc (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 05:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030243AbXAKKGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 05:06:32 -0500
Received: from il.qumranet.com ([62.219.232.206]:44529 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030238AbXAKKGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 05:06:31 -0500
Subject: [PATCH 4/5] KVM: Fix asm constraints with CONFIG_FRAME_POINTER=n
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 11 Jan 2007 10:06:30 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <45A60B2F.6090901@qumranet.com>
In-Reply-To: <45A60B2F.6090901@qumranet.com>
Message-Id: <20070111100630.55461250595@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A "g" constraint may place a local variable in an %rsp-relative memory operand.
but if your assembly changes %rsp, the operand points to the wrong location.

An "r" constraint fixes that.

Thanks to Ingo Molnar for neatly bisecting the problem.

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/vmx.c
===================================================================
--- linux-2.6.orig/drivers/kvm/vmx.c
+++ linux-2.6/drivers/kvm/vmx.c
@@ -1825,7 +1825,7 @@ again:
 #endif
 		"setbe %0 \n\t"
 		"popf \n\t"
-	      : "=g" (fail)
+	      : "=r" (fail)
 	      : "r"(vcpu->launched), "d"((unsigned long)HOST_RSP),
 		"c"(vcpu),
 		[rax]"i"(offsetof(struct kvm_vcpu, regs[VCPU_REGS_RAX])),
