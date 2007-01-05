Return-Path: <linux-kernel-owner+w=401wt.eu-S1750794AbXAEWPW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbXAEWPW (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 17:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbXAEWPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 17:15:22 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:47492 "EHLO
	mailout1.vmware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794AbXAEWPV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 17:15:21 -0500
Message-ID: <459ECDF7.9040309@vmware.com>
Date: Fri, 05 Jan 2007 14:15:19 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: kvm-devel <kvm-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org,
       Avi Kivity <avi@qumranet.com>
Subject: Re: [announce] [patch] KVM paravirtualization for Linux
References: <20070105215223.GA5361@elte.hu>
In-Reply-To: <20070105215223.GA5361@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> i'm pleased to announce the first release of paravirtualized KVM (Linux 
> under Linux), which includes support for the hardware cr3-cache feature 
> of Intel-VMX CPUs. (which speeds up context switches and TLB flushes)
>
> the patch is against 2.6.20-rc3 + KVM trunk and can be found at:
>
>    http://redhat.com/~mingo/kvm-paravirt-patches/
>
> Some aspects of the code are still a bit ad-hoc and incomplete, but the 
> code is stable enough in my testing and i'd like to have some feedback. 
>   

Your code looks generally good.  I have some comments.

You can't do this, even though you want to:

-EXPORT_SYMBOL(paravirt_ops);
+EXPORT_SYMBOL_GPL(paravirt_ops);


The problem is it makes all modules GPL - or at least all modules that 
use any kind of locking, pull in the basic definitions to enable and 
disable interrupts, thus the paravirt_ops symbol, so basically all modules.

What you really want is more like EXPORT_SYMBOL_READABLE_GPL(paravirt_ops);

But I'm not sure that is technically feasible yet.

The kvm code should probably go in kvm.c instead of paravirt.c.


Index: linux/drivers/serial/8250.c
===================================================================
--- linux.orig/drivers/serial/8250.c
+++ linux/drivers/serial/8250.c
@@ -1371,7 +1371,7 @@ static irqreturn_t serial8250_interrupt(
 
 		l = l->next;
 
-		if (l == i->head && pass_counter++ > PASS_LIMIT) {
+		if (!kvm_paravirt 



Is this a bug that might happen under other virtualizations as well, not 
just kvm? Perhaps it deserves a disable feature instead of a kvm 
specific check.

Which also gets rid of the need for this unusually placed extern:

Index: linux/include/linux/sched.h
===================================================================
--- linux.orig/include/linux/sched.h
+++ linux/include/linux/sched.h
@@ -1911,6 +1911,11 @@ static inline void set_task_cpu(struct t
 
 #endif /* CONFIG_SMP */
 
+/*
+ * Is paravirtualization active?
+ */
+extern int kvm_paravirt;

+



