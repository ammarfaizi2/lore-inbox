Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752419AbWJ0TJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752419AbWJ0TJo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 15:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752387AbWJ0TJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 15:09:43 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:46241 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1752418AbWJ0TJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 15:09:43 -0400
Message-ID: <45425976.3090508@vmware.com>
Date: Fri, 27 Oct 2006 12:09:42 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
Cc: Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Jeremy Fitzhardinge <jeremy@goop.org>,
       Chris Wright <chrisw@sous-sol.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] Skip timer works.patch
References: <200610200009.k9K09MrS027558@zach-dev.vmware.com> <20061027145650.GA37582@muc.de>
In-Reply-To: <20061027145650.GA37582@muc.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Thu, Oct 19, 2006 at 05:09:22PM -0700, Zachary Amsden wrote:
>   
>> Add a way to disable the timer IRQ routing check via a boot option.  The
>> VMI timer code uses this to avoid triggering the pester Mingo code, which
>> probes for some very unusual and broken motherboard routings.  It fires
>> 100% of the time when using a paravirtual delay mechanism instead of
>> using a realtime delay, since there is no elapsed real time, and the 4 timer
>> IRQs have not yet been delivered.
>>     
>
> You mean paravirtualized udelay will not actually wait? 
>   

Yes, but even putting that problem aside, the timing element here is 
tricky to get right in a VM.

> This implies that you can't ever use any real timer in that kind of guest,
> right?
>   

No.  You can use a real timer just fine.  But there is no reason ever to 
use udelay to busy wait for "hardware" in a virtual machine.  Drivers 
which are used for real hardware may turn udelay back on selectively; 
but this is another patch.


>> In addition, it is entirely possible, though improbable, that this bug
>> could surface on real hardware which picks a particularly bad time to enter
>> SMM mode, causing a long latency during one of the timer IRQs.
>>     
>
> We already have a no timer check option. But:
>   

Really?  I didn't see one that disabled the broken motherboard detection 
/ workaround code, which is what we are trying to avoid here.


>> While here, make check_timer be __init.
>>     
>
> So how is this supposed to work? The hypervisor would always pass that 
> option?  If yes that would seem rather hackish to me. We should probably
> instead probe in some way if we have the required timer hardware.
> The paravirt kernel should know anyways it is paravirt and that it doesn't
> need to probe for flakey hardware.
>   

That is what this patch is building towards, but the boot option is 
"free", so why not?  In the meantime, it helps non-paravirt kernels 
booted in a VM.

Zach
