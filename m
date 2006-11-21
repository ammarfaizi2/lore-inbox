Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161719AbWKVBhx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161719AbWKVBhx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 20:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161722AbWKVBhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 20:37:53 -0500
Received: from sp604005mt.neufgp.fr ([84.96.92.11]:58618 "EHLO smtp.Neuf.fr")
	by vger.kernel.org with ESMTP id S1161719AbWKVBhw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 20:37:52 -0500
Date: Tue, 21 Nov 2006 22:58:06 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [PATCH] i386-pda UP optimization
In-reply-to: <456372AD.5080807@goop.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@suse.de>, Ingo Molnar <mingo@elte.hu>, akpm@osdl.org,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Message-id: <4563766E.8070408@cosmosbay.com>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8; format=flowed
Content-transfer-encoding: 8BIT
References: <1158046540.2992.5.camel@laptopd505.fenrus.org>
 <200611151824.36198.ak@suse.de> <200611151846.31109.dada1@cosmosbay.com>
 <200611211238.20419.dada1@cosmosbay.com> <456372AD.5080807@goop.org>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Fitzhardinge a écrit :
> Eric Dumazet wrote:
>> I did *lot* of reboots of my Dell D610 machine, with some trivial benchmarks 
>> using : pipe/write()/read, umask(), or getppid(), using or not oprofile.
>>
>> I managed to avoid reloading %gs in sysenter_entry .
>> (avoiding the two instructions : movl $(__KERNEL_PDA), %edx; movl %edx, %gs
>>
>> I could not avoid reloading %gs in system_call, I dont know why, but modern 
>> glibc use sysenter so I dont care :)
>>
>> I confirm I got better results with my patched kernel in all tests I've done.
>>
>> umask : 12.64 s instead of 12.90 s
>> getppid : 13.37 s instead of 13.72 s
>> pipe/read/write : 9.10 s instead of 9.52 s
>>
>> (I got very different results in umask() bench, patching it not to use xchg(), 
>> since this instruction is expensive on x86 and really change oprofile 
>> results. I will submit a patch for this.
>>   
> 
> Could you go into more detail about what you're actually measuring
> here?  Is it 10,000,000 loops of the single syscall?  pipe/read/write
> suggests that you're doing at least 2 syscalls per loop, but it takes
> the smallest elapsed time.

for umask/getppid(), its a basic loop with 100.000.000 iterations
for read/write(), loop with 10.000.000 iterations
> 
> What are you using as your time reference?  Real time?  Process time?
> 

elapsed time (/usr/bin/time ./prog)
10 runs, and the minimum time is taken.

> For umask/getppid, assuming you're just running 1e7 iterations, you're
> seeing a difference of 25 and 35ns per iteration difference.  I wonder
> why it would be different for different syscalls; I would expect it to
> be a constant overhead either way.  Certainly these numbers are much
> larger than I saw when I benchmarked pda-vs-nopda using lmbench's null
> syscall (getppid) test; I saw an overall 9ns difference in null syscall
> time on my Core Duo run at 1GHz.  What's your CPU and speed?

Its a 1.6GHz Pentium-M CPU (Dell D610)

> 
> One possibility is a cache miss on the gdt while reloading %gs.  I've
> been planning on a patch to rearrange the gdt in order to pack all the
> commonly used segment descriptors into one or two cache lines so that
> all the segment register reloads can be done with a minimum of cache
> misses.  It would be interesting for you to replace the:
> 
>     movl $(__KERNEL_PDA), %edx; movl %edx, %gs
> 
> with an appropriate read of the gdt entry, hm, which is a bit complex to
> find.
> 

Hum... Do you mean a cache miss every time we do a syscall ? What could 
invalidate this cache exactly ?


