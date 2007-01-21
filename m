Return-Path: <linux-kernel-owner+w=401wt.eu-S1751346AbXAUKRW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbXAUKRW (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 05:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbXAUKRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 05:17:22 -0500
Received: from il.qumranet.com ([62.219.232.206]:33746 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751346AbXAUKRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 05:17:21 -0500
Message-ID: <45B33DAE.20000@qumranet.com>
Date: Sun, 21 Jan 2007 12:17:18 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] KVM: do VMXOFF upon reboot
References: <20070117091319.GA30036@elte.hu> <20070117095141.GA11341@elte.hu> <20070117100210.GA13080@elte.hu>
In-Reply-To: <20070117100210.GA13080@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
>
>   
>> So i think we should do the patch below - this makes reboot work even 
>> in atomic contexts. [...]
>>     
>
> hm, this causes problems if KVM is not active on a VT-capable CPU: even 
> on CPUs with VT supported, if a VT context is not actually activated, a 
> vmxoff causes an invalid opcode exception. So the updated patch below 
> uses a slightly more sophisticated approach to avoid that problem.
>
>   

There is already code to that effect.  Any idea why it is not called?

> static int kvm_reboot(struct notifier_block *notifier, unsigned long val,
>                        void *v)
> {
>     if (val == SYS_RESTART) {
>         /*
>          * Some (well, at least mine) BIOSes hang on reboot if
>          * in vmx root mode.
>          */
>         printk(KERN_INFO "kvm: exiting hardware virtualization\n");
>         on_each_cpu(kvm_arch_ops->hardware_disable, 0, 0, 1);
>     }
>     return NOTIFY_OK;
> }
>
> static struct notifier_block kvm_reboot_notifier = {
>     .notifier_call = kvm_reboot,
>     .priority = 0,
> };
>

Note that it performs the vmxoff on all cpus, not just one, and that it 
is svm friendly too.  Maybe it should check for values other than 
SYS_RESTART?


-- 
error compiling committee.c: too many arguments to function

