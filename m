Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967200AbWK2OKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967200AbWK2OKU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 09:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967202AbWK2OKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 09:10:20 -0500
Received: from il.qumranet.com ([62.219.232.206]:7841 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S967200AbWK2OKS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 09:10:18 -0500
Message-ID: <456D94C8.2000109@qumranet.com>
Date: Wed, 29 Nov 2006 16:10:16 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Avi Kivity <avi@qumranet.com>, Thomas Tuttle <thinkinginbinary@gmail.com>
CC: Andrew Morton <akpm@osdl.org>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Yaniv Kamay <yaniv@qumranet.com>
Subject: Re: 2.6.19-rc6-mm2
References: <20061128020246.47e481eb.akpm@osdl.org>	<20061129002411.GA1178@lion> <20061128165328.fd17d085.akpm@osdl.org> <456D1807.1000603@qumranet.com>
In-Reply-To: <456D1807.1000603@qumranet.com>
Content-Type: multipart/mixed;
 boundary="------------070409080708040002050901"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070409080708040002050901
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Avi Kivity wrote:
>
>
>>> Oh, and I get a ton of these messages with kvm:
>>>
>>> rtc: lost some interrupts at 1024Hz.
>>>     
>>
>>   
>
> I'll look into these too, though I'm not sure where.
>
>

Please try the attached patch and let us know.


-- 
error compiling committee.c: too many arguments to function


--------------070409080708040002050901
Content-Type: text/x-patch;
 name="kvm-handle-external-interrupts-explicitly.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kvm-handle-external-interrupts-explicitly.patch"

Index: linux/drivers/kvm/vmx.c
===================================================================
--- linux/drivers/kvm/vmx.c	(revision 3989)
+++ linux/drivers/kvm/vmx.c	(working copy)
@@ -1163,6 +1163,7 @@
 	vmcs_writel(VM_EXIT_MSR_LOAD_ADDR,
 		    virt_to_phys(vcpu->host_msrs + NR_BAD_MSRS));
 	vmcs_write32_fixedbits(MSR_IA32_VMX_EXIT_CTLS_MSR, VM_EXIT_CONTROLS,
+			       VM_EXIT_ACK_INTR_ON_EXIT |
 		     	       (HOST_IS_64 << 9));  /* 22.2,1, 20.7.1 */
 	vmcs_write32(VM_EXIT_MSR_STORE_COUNT, nr_good_msrs); /* 22.2.2 */
 	vmcs_write32(VM_EXIT_MSR_LOAD_COUNT, nr_good_msrs);  /* 22.2.2 */
@@ -1380,7 +1381,24 @@
 static int handle_external_interrupt(struct kvm_vcpu *vcpu,
 				     struct kvm_run *kvm_run)
 {
+	unsigned long irq;
+
 	++kvm_stat.irq_exits;
+	irq = vmcs_read32(VM_EXIT_INTR_INFO) & 0xff;
+	asm volatile (
+		"lea irq_dispatch(%0,%0,2), %0 \n\t"
+		"call *%0 \n\t"
+		"jmp out \n\t"
+		"irq_dispatch: \n\t"
+		"irq = 0 \n\t"
+		".rept 256 \n\t"
+		"  .byte 0xcd, irq \n\t" /* avoid int $3 -- one byte opcode */
+		"  ret \n\t"
+		"  irq = irq + 1 \n\t"
+		".endr \n\t"
+		"out:"
+		: "+r"(irq) );
+
 	return 1;
 }
 

--------------070409080708040002050901--
