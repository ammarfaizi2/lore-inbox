Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261672AbULBQsA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbULBQsA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 11:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbULBQr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 11:47:59 -0500
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:12982 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S261672AbULBQrj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 11:47:39 -0500
Date: Thu, 2 Dec 2004 17:47:25 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       LKML <linux-kernel@vger.kernel.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] oom killer (Core)
Message-ID: <20041202164725.GB32635@dualathlon.random>
References: <20041201104820.1.patchmail@tglx> <20041201211638.GB4530@dualathlon.random> <1101938767.13353.62.camel@tglx.tec.linutronix.de> <20041202033619.GA32635@dualathlon.random> <1101985759.13353.102.camel@tglx.tec.linutronix.de> <1101995280.13353.124.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101995280.13353.124.camel@tglx.tec.linutronix.de>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2004 at 02:48:00PM +0100, Thomas Gleixner wrote:
> Reentrancy and follow up calls of oom_kill() are blocked until the task
> which was killed by the first oom_kill() has actually released the
> resources. I added a callback which is called from do_exit() when the
> PF_MEMDIE flag is set. The reentrancy blocking is released inside the
> callback.

This logic will certainly fix it, and I'm not against this logic to fix
the problem in a definitive way. It's only unfortunate PF_MEMDIE is smp
racy (plus having to check for PF_MEMDIE in the fast path).

> >From the first call to out_of_memory, which activates the reentrancy
> blocking until the blocking is released in the callback, out_of_memory
> is called more than 300 times.

I believe the thing you're hiding with the callback, is some screwup in
the VM. It shouldn't fire oom 300 times in a row.

zone->all_unreclaimable and zone->pages_scanned _must_ be set to 0 by
the oom_killer invocation, did you try to fix that? 

> So it's up to you VM guys to fight out from which place you want call
> out_of_memory(). I don't care as both places have exactly the same bad
> side effects.

the reason for oom in page_alloc.c, is that you must check the free
pages levels correctly, your previous nr_free_pages() attempt was the
unreliable way to do that (it couldn't take into account all the
lowmem_reserve levels etc..).

> My concern is to make it reliable when it is finally invoked.

This approach of using a callback will sure work fine for that but the
300 times invocation of oom kill shows something is wrong in the VM, and
I believe the screwup is zone->all_unreclaimable and zone->pages_scanned
not being resetted by the oom killer invocation. I suspect if you fix
that single bit, things will start working even without the callback.

Note that in 2.4 only one task gets killed, and there's no need of any
callback in any fast path to make it work. I'm not conceptually against
the callback to "guarantee" oom-killing racing avoidance, but right now
it sounds like it's hiding some more fundamental problem in 2.6.

Thanks.
