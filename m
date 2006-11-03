Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751887AbWKCBpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887AbWKCBpX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 20:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752927AbWKCBpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 20:45:23 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:49303 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751887AbWKCBpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 20:45:22 -0500
Date: Fri, 3 Nov 2006 02:45:21 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
In-Reply-To: <p73velxju18.fsf@verdi.suse.de>
Message-ID: <Pine.LNX.4.64.0611030235050.7781@artax.karlin.mff.cuni.cz>
References: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz>
 <p73velxju18.fsf@verdi.suse.de>
X-Personality-Disorder: Schizoid
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz> writes:
>
>> new method to keep data consistent in case of crashes (instead
>> of journaling),
>
> What is that method?

Some tricks to avoid journal --- see 
http://artax.karlin.mff.cuni.cz/~mikulas/spadfs/download/INTERNALS

--- unlike journaling it survives only 65536 crashes :)

>> * There is a rw semaphore that is locked for read for nearly all
>
> Depending on the length of the critical section rw locks are often
> not faster than non rw locks because the read case has to bounce
> around the cache line of the lock anyways and they're actually
> a little more expensive.

This critical section is long --- i.e. any reads/writes to disk. Making it 
simple semaphore would effectively serialize all operations.

>> * This leads to another observation --- on i386 locking a semaphore is
>> 2 instructions, on x86_64 it is a call to two nested functions. Has it
>
> The second call should be a tail call, i.e. just a jump

It is down_write -> (tailcall) down_write_nested -> (normal call) 
spin_lock_irq and spin_unlock_irq.

> The first call isn't needed on a non debug kernel, but doing the
> two unconditional jumps should be basically free on a modern OOO CPU.

But it kills one cacheline.

> The actual implementation is spinlock based vs atomic based for i386.
> This was because at some point nobody could benchmark a difference
> between the two and the spinlock based version is much easier
> to verify and to understand. If you can demonstrate a difference
> that could be reevaluated.

Maybe one day I'll try it.

>> some reason or was it just implementator's laziness? Given the fact
>> that locked instruction takes 16 ticks on Opteron (and can overlap
>> about 2 ticks with other instructions), it would make sense to have
>> optimized semaphores too.
>
> In the last time we're going more for saved icache and better
> use of branch predictors (who are more happy with less branch locations
> to cache) I would expect the call/ret to be executed
> mostly in parallel with the other code anyways.

I see, but pushf, cli and popf in that spinlock hurt too (especially on 
Intel, it has them completely microcoded --- pushf/popf pair is 100 
ticks on Intel P4E and 12 ticks on Opteron).

Mikulas

> -Andi
>
