Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754831AbWKUWKO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754831AbWKUWKO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 17:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755694AbWKUWKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 17:10:13 -0500
Received: from gw.goop.org ([64.81.55.164]:59545 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1754831AbWKUWKL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 17:10:11 -0500
Message-ID: <45637940.1090608@goop.org>
Date: Tue, 21 Nov 2006 14:10:08 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Eric Dumazet <dada1@cosmosbay.com>, Ingo Molnar <mingo@elte.hu>,
       akpm@osdl.org, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386-pda UP optimization
References: <1158046540.2992.5.camel@laptopd505.fenrus.org> <200611211238.20419.dada1@cosmosbay.com> <456372AD.5080807@goop.org> <200611212252.28493.ak@suse.de>
In-Reply-To: <200611212252.28493.ak@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>> For umask/getppid, assuming you're just running 1e7 iterations, you're
>> seeing a difference of 25 and 35ns per iteration difference.  I wonder
>> why it would be different for different syscalls; I would expect it to
>> be a constant overhead either way.
>>     
>
> They got different numbers of current references? 
>   

My understanding is that Eric has changed UP current (and other PDA ops)
to not touch %gs at all, and the difference in reported times in due
omitting the %gs load in entry.S (though %gs is still save/restored on
the stack).

> On such micro benchmarks everything should be cache hot in theory
> (unless it's a system with really small cache)
>   

Yes, that would be my thought too, but maybe there's excessive aliasing
on one of the ways, but I think he's using a Pentium M which has a 8-way L1.

>> been planning on a patch to rearrange the gdt in order to pack all the
>> commonly used segment descriptors into one or two cache lines so that
>> all the segment register reloads can be done with a minimum of cache
>> misses.  It would be interesting for you to replace the:
>>
>>     movl $(__KERNEL_PDA), %edx; movl %edx, %gs
>>
>> with an appropriate read of the gdt entry, hm, which is a bit complex to
>> find.
>>     
>
> On UP it could be hardcoded. And oprofile can be used to profile for cache misses.
>   

Yes, assuming oprofile doesn't interfere with things too much. 
Actually, just counting cache miss events during the course of a syscall
would be most interesting (ie, no need to sample).


    J
