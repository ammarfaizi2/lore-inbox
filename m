Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752086AbWJXHXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752086AbWJXHXd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 03:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752088AbWJXHXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 03:23:33 -0400
Received: from mis011-1.exch011.intermedia.net ([64.78.21.128]:15725 "EHLO
	mis011-1.exch011.intermedia.net") by vger.kernel.org with ESMTP
	id S1752086AbWJXHXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 03:23:32 -0400
Message-ID: <453DBF70.6030605@qumranet.com>
Date: Tue, 24 Oct 2006 09:23:28 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Anthony Liguori <aliguori@us.ibm.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/13] KVM: define exit handlers
References: <453CC390.9080508@qumranet.com> <20061023133106.C19DB250143@cleopatra.q> <453D66C6.5080008@us.ibm.com>
In-Reply-To: <453D66C6.5080008@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Oct 2006 07:23:32.0220 (UTC) FILETIME=[4F4DC3C0:01C6F73D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anthony Liguori wrote:
> Avi Kivity wrote:
>> +static int handle_external_interrupt(struct kvm_vcpu *vcpu,
>> +                     struct kvm_run *kvm_run)
>> +{
>> +    ++kvm_stat.irq_exits;
>> +    return 1;
>> +}
>>   
>
> Don't you need to propagate the interrupt here?  In Xen, we inject the 
> interrupt using the IDT.  As a module, you don't have access to that.  
> However, you could use a software interrupt to reraise it.

We don't set VM_EXIT_ACK_INTR_ON_EXIT on the VM exit controls, so when 
an external interrupt is received, it isn't acked and remains in the 
(real) apic.  We do set the guest to exit on external interrupt, so the 
guest exits and when it reaches the popf in kvm_dev_ioctl_run() the 
interrupt is dispatched naturally using the host IDT.

[Xen can't do that since it must handle some of the interrupts itself]

>
> I got your code running this afternoon (it's quite cool) but I noticed 
> a ton of "rtc: lost some interrupts at 1024Hz." messages which leads 
> me to believe.. you're dropping interrupts :-)  

That's in the guest, right?  I get those too.  Probably due to to our 
shadow mmu suckiness or a problem with the virtual apic.  We are 
addressing both.

> Things seem to hang trying to bring up eth0 in the guest.

Hmm.  What guest are you using?  Are you using dhcp? ipv6? qemu user net 
or tap?


>
> BTW, have you setup a mailing list yet?

I have a project queued on sourceforge, should be up in a day or two.

Thanks for testing!

-- 
error compiling committee.c: too many arguments to function

