Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932255AbWCVRyG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbWCVRyG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 12:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbWCVRyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 12:54:05 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:62988 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932255AbWCVRyC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 12:54:02 -0500
Message-ID: <44218E9C.3060102@vmware.com>
Date: Wed, 22 Mar 2006 09:51:24 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: virtualization@lists.osdl.org, Chris Wright <chrisw@sous-sol.org>,
       Ian Pratt <ian.pratt@xensource.com>, xen-devel@lists.xensource.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Xen-devel] Re: [RFC PATCH 18/35] Support gdt/idt/ldt handling
 on	Xen.
References: <20060322063040.960068000@sorel.sous-sol.org>	<20060322063753.556397000@sorel.sous-sol.org> <200603221530.51644.ak@suse.de>
In-Reply-To: <200603221530.51644.ak@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Wednesday 22 March 2006 07:30, Chris Wright wrote:
>
>   
>>  
>> -#define load_TR_desc() __asm__ __volatile__("ltr %w0"::"q" (GDT_ENTRY_TSS*8))
>> -#define load_LDT_desc() __asm__ __volatile__("lldt %w0"::"q" (GDT_ENTRY_LDT*8))
>> -
>> -#define load_gdt(dtr) __asm__ __volatile("lgdt %0"::"m" (*dtr))
>> -#define load_idt(dtr) __asm__ __volatile("lidt %0"::"m" (*dtr))
>> -#define load_tr(tr) __asm__ __volatile("ltr %0"::"mr" (tr))
>> -#define load_ldt(ldt) __asm__ __volatile("lldt %0"::"mr" (ldt))
>> -
>> -#define store_gdt(dtr) __asm__ ("sgdt %0":"=m" (*dtr))
>> -#define store_idt(dtr) __asm__ ("sidt %0":"=m" (*dtr))
>> -#define store_tr(tr) __asm__ ("str %0":"=mr" (tr))
>> -#define store_ldt(ldt) __asm__ ("sldt %0":"=mr" (ldt))
>>     
>
>
> These are all very infrequent except perhaps LLDT. I suspect trapping would 
> work too. But ok.
>   

Yes, trapping works fine.  Even LLDT is infrequent.  But, you do impose 
a very large amount of complexity on the hypervisor by trapping on any 
instruction.  Suppose you wanted to write a minimal hypervisor, which 
consisted of pretty much a wrapper based on the Xen or VMI interface 
that just stole a couple pages of physical memory, and hooked trap 
handlers by hooking the call out for lidt.

If you instead remove the hypervisor wrapper for lidt, and require the 
hypervisor to trap and emulate it, you have just imposed an insidious 
amount of overhead on it.  It doesn't seem too much at first - trap and 
emulate, right?

No.  First, you have to create a special #GP handler for the general 
protection fault.  But the fault doesn't tell you anything about why it 
happened - just that it was a general protection fault, and maybe a 
segment related to it.  To figure out what happened, you have to decode 
the instruction stream.  To decode the instruction stream, you have to 
take the EIP pointer and read from it, right?  Wrong.  You have to 
extract segment information from the code segment, apply segmentation 
rules to the access, rule out invalid processor modes, deal with wrap 
around conditions, etc.  But lets say you do all that.  Now, you have to 
read the guest memory to decode.  Which requires reading guest page 
tables.  The memory in question has to be mapped present and 
executable.  You have to deal conditionally with PAE / non-PAE paging 
modes.  And race conditions where self-modifying code can trick you into 
decoding something that really didn't happen.  Then, finally, you can 
interpret the instruction, go through the whole process of reading guest 
memory again (fortunately, this time, without segmentation), read the 
guest IDT, and hook in your trap handlers where appropriate.

Yeah, it really is that bad, and that is really only a scratch on the 
surface.  Trap and emulate, while possible, is basically about as evil a 
requirement as you can impose on a hypervisor.  Everyone who is serious 
about the market needs to support it in one form or another eventually, 
but it raises the bar to such a point as to stop proliferation of 
minimal hypervisors, which could make extremely useful research tools 
for the community under an open source license.

Zach
