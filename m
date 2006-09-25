Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964781AbWIYBgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbWIYBgE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 21:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbWIYBgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 21:36:04 -0400
Received: from gw.goop.org ([64.81.55.164]:53676 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932210AbWIYBgC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 21:36:02 -0400
Message-ID: <45173287.8070204@goop.org>
Date: Sun, 24 Sep 2006 18:36:07 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Andi Kleen <ak@muc.de>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       virtualization <virtualization@lists.osdl.org>
Subject: Re: [PATCH 5/7] Use %gs for per-cpu sections in kernel
References: <1158925861.26261.3.camel@localhost.localdomain>	 <1158925997.26261.6.camel@localhost.localdomain>	 <1158926106.26261.8.camel@localhost.localdomain>	 <1158926215.26261.11.camel@localhost.localdomain>	 <1158926308.26261.14.camel@localhost.localdomain>	 <1158926386.26261.17.camel@localhost.localdomain>	 <4514663E.5050707@goop.org>	 <1158985882.26261.60.camel@localhost.localdomain>	 <45172AC8.2070701@goop.org> <1159146974.26986.30.camel@localhost.localdomain>
In-Reply-To: <1159146974.26986.30.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> 	You're thinking of it in a convoluted way, by converting to offsets
> from the per-cpu section, then converting it back.  How about this
> explanation: the local cpu's versions are offset from where the compiler
> thinks they are by __per_cpu_offset[cpu].  We set the segment base to
> __per_cpu_offset[cpu], so "%gs:per_cpu__foo" gets us straight to the
> local cpu version.  __per_cpu_offset[cpu] is always positive (kernel
> image sits at bottom of kernel address space).
>   

We're talking kernel virtual addresses, so the physical load address 
doesn't matter, of course.

So, take this kernel I have here as an explicit example:

$ nm -n vmlinux
[...]
c0431100 A __per_cpu_start
[...]
c0433800 D per_cpu__cpu_gdt_descr
c0433880 D per_cpu__cpu_tlbstate


And say that this CPU has its percpu data allocated at 0xc100000.

So, in this case the %gs base will be loaded with 0xc100000-0xc0431100 = 
0x4bccef00
The offset of per_cpu__cpu_gdt_descr is 0xc0433800, so 
%gs:per_cpu__cpu_gdt_descr will compute 0x4bccef00+0xc0433800 to get the 
final linear address.  Since 0xc0433800 is negative, this is actually a 
subtraction, and it therefore requires the segment to have a 4G limit.  
Which makes Xen sad.

>>   Especially since "__per_cpu_start" is actually very 
>> large, and so this scheme pretty much relies on being able to wrap 
>> around the segment limit, and will be very bad for Xen.
>>     
>
> __per_cpu_start is large, yes.  But there's no reason to use it in
> address calculation.  The second half of your statement is not correct.
>   

__per_cpu_start is added to all per_cpu__* addresses.

>> An alternative is to put the "-__per_cpu_start" into the addressing mode 
>> when constructing the address of the per-cpu variable.
>>     
>
> I think you're thinking of TLS relocations?  I don't use them...
>   

No, but this is just as bad.

    J
