Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278207AbRJRX34>; Thu, 18 Oct 2001 19:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278203AbRJRX3q>; Thu, 18 Oct 2001 19:29:46 -0400
Received: from air-1.osdl.org ([65.201.151.5]:49425 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S278206AbRJRX3i>;
	Thu, 18 Oct 2001 19:29:38 -0400
Date: Thu, 18 Oct 2001 16:30:05 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@osdlab.pdx.osdl.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] New Driver Model for 2.5
In-Reply-To: <20011018221828.23673@smtp.wanadoo.fr>
Message-ID: <Pine.LNX.4.33.0110181601250.9099-100000@osdlab.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> That's why I prefer more explicit semantics:
>
>  - Prepare sleep: Allocate enough memory to save state. For most
> devices, it will be a fixed quantity. In the case of devices that need
> per-request allocation, like USB of firewire, just allocate a limited
> pool. That means that you will eventually cause serialisation to
> happen when not needed and hurt perfs, but nobody will care at this
> point ;)
>
>  - Suspend activity: There you lock your IO queues, set your busy flag
> or whatever, and wait for any pending IO to be completed. Interrupts
> are enabled, scheduling as well (and other CPUs). Each driver is
> responsible to properly block a process issuing a request (which should
> not be a problem to implement for most of them, a single semaphore
> is enough for simple drivers, drivers with IO queues just need to
> leave requests in the queues, etc...)
>
>  - Set power state: Here you shut your device down for real. Interrupt
> are disabled. Only one CPU is still active (the others can be put in
> whatever state your arch allow, like a sleep loop or whatever...).

Ok, so we need another walk before we go to sleep.

But, first a question - does the swap device need to absolutely be the
last thing to stop taking requests? Or, can it stop after everything is
done allocating memory?

> The actual state save can be in step 2 or 3, we don't really care,
> it depends mostly on what is more convenient for the driver writer.

For most devices, it seems it could happen in the first, as well. They
should be fine with stopping I/O requests early on. It's only special
cases like swap and maybe one or two others that need an extra step,
right?

	-pat

