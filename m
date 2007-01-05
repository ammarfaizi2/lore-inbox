Return-Path: <linux-kernel-owner+w=401wt.eu-S1161004AbXAEHur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161004AbXAEHur (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 02:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161008AbXAEHur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 02:50:47 -0500
Received: from il.qumranet.com ([62.219.232.206]:35862 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161004AbXAEHuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 02:50:46 -0500
Subject: [PATCH 1/9] KVM: Improve reporting of vmwrite errors
From: Avi Kivity <avi@qumranet.com>
Date: Fri, 05 Jan 2007 07:50:45 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <459E02E7.5020407@qumranet.com>
In-Reply-To: <459E02E7.5020407@qumranet.com>
Message-Id: <20070105075045.225C3250048@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This will allow us to see the root cause when a vmwrite error happens.

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/vmx.c
===================================================================
--- linux-2.6.orig/drivers/kvm/vmx.c
+++ linux-2.6/drivers/kvm/vmx.c
@@ -152,15 +152,21 @@ static u64 vmcs_read64(unsigned long fie
 #endif
 }
 
+static noinline void vmwrite_error(unsigned long field, unsigned long value)
+{
+	printk(KERN_ERR "vmwrite error: reg %lx value %lx (err %d)\n",
+	       field, value, vmcs_read32(VM_INSTRUCTION_ERROR));
+	dump_stack();
+}
+
 static void vmcs_writel(unsigned long field, unsigned long value)
 {
 	u8 error;
 
 	asm volatile (ASM_VMX_VMWRITE_RAX_RDX "; setna %0"
 		       : "=q"(error) : "a"(value), "d"(field) : "cc" );
-	if (error)
-		printk(KERN_ERR "vmwrite error: reg %lx value %lx (err %d)\n",
-		       field, value, vmcs_read32(VM_INSTRUCTION_ERROR));
+	if (unlikely(error))
+		vmwrite_error(field, value);
 }
 
 static void vmcs_write16(unsigned long field, u16 value)
