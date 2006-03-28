Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751198AbWC1Bu4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbWC1Bu4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 20:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbWC1Bu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 20:50:56 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:34319 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751198AbWC1Bu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 20:50:56 -0500
Message-ID: <44289606.4070902@vmware.com>
Date: Mon, 27 Mar 2006 17:48:54 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Andi Kleen <ak@suse.de>, virtualization <virtualization@lists.osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Dan Hecht <dhecht@vmware.com>, Chris Wright <chrisw@sous-sol.org>
Subject: Re: [RFC, PATCH 5/24] i386 Vmi code patching
References: <200603271955_MC3-1-BBB1-E3F1@compuserve.com>
In-Reply-To: <200603271955_MC3-1-BBB1-E3F1@compuserve.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert wrote:
> In-Reply-To: <200603222115.46926.ak@suse.de>
>
> On Wed, 22 Mar 2006 21:15:44 +0100, Andi Kleen wrote:
>
>   
>> On Monday 13 March 2006 19:02, Zachary Amsden wrote:
>>     
>>> The VMI ROM detection and code patching mechanism is illustrated in
>>> setup.c.  There ROM is a binary block published by the hypervisor, and
>>> and there are certainly implications of this.  ROMs certainly have a
>>> history of being proprietary, very differently licensed pieces of
>>> software, and mostly under non-free licenses.  Before jumping to the
>>> conclusion that this is a bad thing, let us consider more carefully
>>> why hiding the interface layer to the hypervisor is actually a good
>>> thing.
>>>       
>> How about you fix all these issues you describe here first 
>> and then submit it again?
>>
>> The disassembly stuff indeed doesn't look like something
>> that belongs in the kernel.
>>     
>
> I think they put the disassembler in there as a joke. ;)
>
> It's not necessary for fixing up the call site, anyway. Something like
> this should work, assuming there is always a call in every vmi
> translation.
>   

Very good observation.  The code you illustrate is roughly what the 
patch mechanism used to do.  The disassembly serves one purpose, which 
is incomplete in our current implementation.  It provides live register 
information and constant propagation that can be used by an inliner in 
the VMI layer to inline hypervisor calls.  This information gets encoded 
naturally in the push sequence before the call instruction.

But considering it is currently incomplete, and most of the benefit can 
be had be special casing just 4 VMI calls to allow selective inlining, 
it does seem like a lot of complexity for little payoff.  I really don't 
like special casing, but in this scenario, it does seem to make sense.  
And of the 4 VMI calls, only one (SetInterruptMask) takes an input, and 
it takes that input in a fixed register.

Based on suggestions from Anthony Liguori and others, we are going to 
drop this extra complexity - we can get to hypervisor inlining later.  
Right now having the simplest and cleanest interface is more important.  
Actually, adding the required padding for inlining is quite easy:

#define FILL(n) ".fill " #n "-1,1,0x66; nop"

static inline void local_irq_restore(const unsigned long flags)
{
        vmi_wrap_call(
                SetInterruptMask, "pushl %0; popfl"  FILL(6),
                VMI_NO_OUTPUT,
                1, VMI_IREG1 (flags),
                XCONC("cc", "memory"));
}

Now you have 8 bytes to overwrite, which is sufficient for byte 
arithmetic operations to a memory address, plus a segment override.  
This seems like a much simpler solution than run-time disassembly.

> -				/*
> -				 * Don't printk - it may acquire spinlocks with
> -				 * partially completed VMI translations, causing
> -				 * nuclear meltdown of the core.
> - 				 */
> -				BUG();
> -				return;
> -		}
> -	}
>   

This part was a joke  ;)
