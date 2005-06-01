Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbVFAT7y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbVFAT7y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 15:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261157AbVFAT7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 15:59:54 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:26701
	"EHLO g5.random") by vger.kernel.org with ESMTP id S261176AbVFAT7W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 15:59:22 -0400
Date: Wed, 1 Jun 2005 21:59:05 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Thomas Gleixner <tglx@linutronix.de>, Karim Yaghmour <karim@opersys.com>,
       Ingo Molnar <mingo@elte.hu>, Paulo Marques <pmarques@grupopie.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       James Bruce <bruce@andrew.cmu.edu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Bill Huey (hui)" <bhuey@lnxw.com>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       hch@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050601195905.GX5413@g5.random>
References: <20050601192224.GV5413@g5.random> <Pine.OSF.4.05.10506012129460.1707-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.05.10506012129460.1707-100000@da410.phys.au.dk>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2005 at 09:34:58PM +0200, Esben Nielsen wrote:
> It is simply not needed: Any driver suitable for SMP is using spin-locks,
> which becomes mutexes when CONFIG_PREEMPT_RT is set. Therefore: SMP safe
> becomes RT safe.
> Ofcourse, you can manually have to grep the code for offending
> local_irq_disable() or cli()'s just to make sure.

There's a significant number of local_irq_disable across the kernel, I
don't see why should we risk a driver update possibly looping a bit too
logn, to break the RT guarantee. It's not too hard to reach the hundred
usec range when doing hardware operations in inefficient drivers when
touchign the mmio/io regions. That would not be a bug in any config but
preempt-RT. Possibly not nice, but not a bug (keep in mind the usb irq
in my firewall for whatever reasons keeps irq disabled for >1msec).

> Doesn't RTAI at least in principle have the same problem? Someone might
> have coded a local irq-disable directly in assambler without the official
> macros? The Adeos patch wouldn't catch it then, right? (The risc of that
> is very small, I know...)

Using cli by hand never happens anywhere, while if you grep for
local_irq_disable that happens in many drivers.

Using cli in asm is like doing memset() all over the ram... then kernel
will crash and irq will stop too ;) While local_irq_disable os far was a
supported API for drivers and generic kernel code (most commmonly used
before touching per-cpu data structures, so very common in certain part
of the kernels, including the scheduler).
