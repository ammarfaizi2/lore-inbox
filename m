Return-Path: <linux-kernel-owner+w=401wt.eu-S932999AbWL1KPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932999AbWL1KPU (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 05:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932936AbWL1KPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 05:15:20 -0500
Received: from il.qumranet.com ([62.219.232.206]:54148 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932999AbWL1KPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 05:15:19 -0500
Subject: [PATCH 8/8] KVM: Fix oops on oom
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 28 Dec 2006 10:15:17 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <45939755.7010603@qumranet.com>
In-Reply-To: <45939755.7010603@qumranet.com>
Message-Id: <20061228101517.AE36C2500F7@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

__free_page() doesn't like a NULL argument, so check before calling it.  A
NULL can only happen if memory is exhausted during allocation of a memory
slot.

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -245,7 +245,8 @@ static void kvm_free_physmem_slot(struct
 	if (!dont || free->phys_mem != dont->phys_mem)
 		if (free->phys_mem) {
 			for (i = 0; i < free->npages; ++i)
-				__free_page(free->phys_mem[i]);
+				if (free->phys_mem[i])
+					__free_page(free->phys_mem[i]);
 			vfree(free->phys_mem);
 		}
 
