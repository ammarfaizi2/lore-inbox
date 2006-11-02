Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752821AbWKBXln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752821AbWKBXln (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 18:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752820AbWKBXln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 18:41:43 -0500
Received: from mx1.suse.de ([195.135.220.2]:51087 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1752821AbWKBXlm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 18:41:42 -0500
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
References: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz>
From: Andi Kleen <ak@suse.de>
Date: 03 Nov 2006 00:41:39 +0100
In-Reply-To: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz>
Message-ID: <p73velxju18.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz> writes:

> new method to keep data consistent in case of crashes (instead
> of journaling),

What is that method?

> * There is a rw semaphore that is locked for read for nearly all

Depending on the length of the critical section rw locks are often
not faster than non rw locks because the read case has to bounce
around the cache line of the lock anyways and they're actually
a little more expensive.
> * This leads to another observation --- on i386 locking a semaphore is
> 2 instructions, on x86_64 it is a call to two nested functions. Has it

The second call should be a tail call, i.e. just a jump

The first call isn't needed on a non debug kernel, but doing the
two unconditional jumps should be basically free on a modern OOO CPU.

The actual implementation is spinlock based vs atomic based for i386.
This was because at some point nobody could benchmark a difference
between the two and the spinlock based version is much easier
to verify and to understand. If you can demonstrate a difference
that could be reevaluated.

> some reason or was it just implementator's laziness? Given the fact
> that locked instruction takes 16 ticks on Opteron (and can overlap
> about 2 ticks with other instructions), it would make sense to have
> optimized semaphores too.

In the last time we're going more for saved icache and better
use of branch predictors (who are more happy with less branch locations
to cache) I would expect the call/ret to be executed
mostly in parallel with the other code anyways.

-Andi
