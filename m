Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbWHXMei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbWHXMei (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 08:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWHXMei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 08:34:38 -0400
Received: from elvis.mu.org ([192.203.228.196]:35806 "EHLO elvis.mu.org")
	by vger.kernel.org with ESMTP id S1751204AbWHXMeh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 08:34:37 -0400
Message-ID: <44ED9CB4.7070302@FreeBSD.org>
Date: Thu, 24 Aug 2006 14:33:56 +0200
From: Suleiman Souhlal <ssouhlal@FreeBSD.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051204)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Edward Falk <efalk@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix x86_64 _spin_lock_irqsave()
References: <44ED157D.6050607@google.com> <p7364gifx8o.fsf@verdi.suse.de> <44ED87AC.8070106@FreeBSD.org> <200608241332.40139.ak@suse.de>
In-Reply-To: <200608241332.40139.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Thursday 24 August 2006 13:04, Suleiman Souhlal wrote:
> 
>>Andi Kleen wrote:
>>
>>>Edward Falk <efalk@google.com> writes:
>>>
>>>
>>>
>>>>Add spin_lock_string_flags and _raw_spin_lock_flags() to
>>>>asm-x86_64/spinlock.h so that _spin_lock_irqsave() has the same
>>>>semantics on x86_64 as it does on i386 and does *not* have interrupts
>>>>disabled while it is waiting for the lock.
>>>
>>>
>>>Did it fix anything for you?
>>
>>I think this was to work around the fact that some buggy drivers try to 
>>grab spinlocks without disabling interrupts when they should, which 
>>would cause deadlocks when trying to rendez-vous every cpu via IPIs.
> 
> 
> That doesn't help them at all because they could then deadlock later.

If the driver uses spin_lock() when it knows that the hardware won't 
generate the interrupt that would need to be masked, and 
spin_lock_irqsave() elsewhere, there shouldn't be any deadlocks unless 
IPIs are involved.

For example, say a driver uses spin_lock(&driver_lock) in its interrupt 
handler and spin_lock_irqsave(&driver_lock) elsewhere.
Imagine CPU1 is handling a such a interrupt while CPU2 is trying to send 
a packet (for example).

In a regular situation, CPU1 shouldn't be interrupted by anything 
needing driver_lock, and so it should be able to complete and let CPU2 
acquire the lock.

Now, if CPU3 is trying to do an IPI rendez-vous, it will interrupt CPU1 
and try to interrupt CPU2 too. However, since spin_lock_irqsave() spins 
with interrupts disabled, the system will deadlock.

With this patch, IPI rendez-vous shouldn't cause these problems, since 
it will let the rendez-vous will be able to complete. Or am I missing 
something?

-- Suleiman
