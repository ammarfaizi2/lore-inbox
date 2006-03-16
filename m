Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751704AbWCPPb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751704AbWCPPb5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 10:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751653AbWCPPb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 10:31:57 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:22803 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751318AbWCPPb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 10:31:56 -0500
Message-ID: <4419845E.8060904@vmware.com>
Date: Thu, 16 Mar 2006 07:29:34 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: VMI Interface Proposal Documentation for I386, Part 4
References: <4415CE1C.1060608@vmware.com> <20060315233703.GE1919@elf.ucw.cz> <1142522308.13318.29.camel@localhost.localdomain>
In-Reply-To: <1142522308.13318.29.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Iau, 2006-03-16 at 00:37 +0100, Pavel Machek wrote:
>   
>> This code used to work when ran as root:
>>     
>
> Unless it page faulted, or was on SMP, or ....
>   

Actually, quite interestingly, I believe you can take page faults in 
this scenario - you might end up getting rescheduled and lose the effect 
disabling interrupts, but I think the kernel lives on just fine - as 
long as it doesn't BUG_ON about this.  On SMP, clearly you can't 
disabled IRQs on all processors with it.  But I really think the point 
is to try to eliminate IRQs on a single processor during some critical 
timing sensitive region.  One thing you definitely can't do safely is 
make sysenter based syscalls off the vsyscall page - you will notice 
that you always come back with interrupts enabled.

I just really don't think that is a good idea to do in userspace, when 
writing a kernel module to accomplish this safely is actually really 
quite easy.  I would argue that the various CMOS timer update utilities 
in userspace that do this same thing, really should be moved into the 
kernel as fast as possible - they could race against other CPUs in 
kernel mode that are doing the same thing, and there is no locking 
discipline here whatsoever.

>   
>> I'm not sure how will X like this.
>>     
>
> X has not used this ability for many years.
>   

Good to know.  I thought some piece of xinit still used it to do 
dot-clock probing - but I could be wrong.  We really don't care about 
getting accurate information here, since the dot-clocks don't actually 
exist in a VM.  We simulate virtual SVGA hardware instead of passing 
through any installed card.

Zach
