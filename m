Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266837AbUHCUt1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266837AbUHCUt1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 16:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266835AbUHCUt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 16:49:26 -0400
Received: from mail.dif.dk ([193.138.115.101]:10662 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S266837AbUHCUsd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 16:48:33 -0400
Date: Tue, 3 Aug 2004 22:53:11 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Jack Lloyd <lloyd@randombit.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] get_random_bytes returns the same on every boot
In-Reply-To: <20040803174753.GA16361@acm.jhu.edu>
Message-ID: <Pine.LNX.4.60.0408032125320.2821@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.58.0407222254440.3652@pingvin.fazekas.hu>
 <cemg09$hun$1@abraham.cs.berkeley.edu> <20040803174753.GA16361@acm.jhu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Aug 2004, Jack Lloyd wrote:

> On Mon, Aug 02, 2004 at 10:42:17PM +0000, David Wagner wrote:
> > Balint Marton  wrote:
> > >At boot time, get_random_bytes always returns the same random data, as if
> > >there were a constant random seed.  [This is because no entropy is
> > >available yet.]
> > 
> > Are there any consequences of this for security?  A number of network
> > functions call get_random_bytes() to get unguessable numbers; if those
> > numbers are guessable, security might be compromised.  Note that most init
> > scripts save randomness state from the last reboot and fill it into the
> > entropy pool after boot, but before then any callers to get_random_bytes()
> > might be vulnerable.  Has anyone ever audited all places that call
> > get_random_bytes() to see if any of them might pose a security exposure
> > during the window of time between boot and execution of init scripts?
> > For instance, are TCP sequence numbers, SYN cookies, etc. vulnerable?
> 
> If the init scripts haven't run, then most likely your machine doesn't have an
> IP address configured anyway. On some distros the network is configured before
> the saved entropy is added to the pool, but most servers don't get started
> until afterward.
> 
> > (Needless to say, seeding the pool with just the time of day and the
> > system hostname is not enough to defend against such attacks.)
> 
> I can't think of much else the machine could be adding at the point before init
> is created. The TSC isn't going to be very unpredicable, since the machine just
> booted, but it might have a few bits of entropy. Hardware serial numbers?
> Fixed, and largely easy to get ahold of. I'm out of ideas.
> 
> Hmmm, it just occured to me that you could include process execution details
> (owner, pathname, pid/ppid, timestamp) into the entropy pool, sort of like a
> Cryptlib generator but in kernel space. But again, that isn't of much use
> before the kernel creates init.
> 
First of all, please excuse me if I don't make any sense at all - I really 
don't know anything about generating good random numbers and good sources 
of entropy, but I had a few thoughts while reading this thread and just 
thought I'd mention them in case there was actually something useful in 
them.

How about using some of the following as early sources of entropy (keeping 
in mind that this early on we just want something a little less 
predictable since completely unpredictable is probably impossible) : 

As you yourself mentioned; hardware serial numbers.

The clock of course, although the predictability of that was what started 
this thread, it's still a source.

The time the first (or first few) interrupts happen (any interrupt)? I'm 
guessing there must be *some* interrupts that the hardware generates for 
all boxes (and even if there's not for a few boxes, then that in itself 
is data), and if the hardware differs from box to box, then this would 
also differ between boxes.

The RAM size could provide a number that, although easily discovered, 
would often differ from box to box, same goes for CPU clock frequency 
(which I've often observed differs slightly even amongst supposedly 
identical CPU's).

How about the BIOS version? BIOS manufacturer string or similar info that 
could potentially differ between boxes?

What about the value of some semi-randomly picked memory locations? Or is 
all memory initialized to a known value? (could it be read before being 
initialized?).

How about the build time/build nr of the kernel? Again, easily 
discoverable, but if the main problem is boxes booting at same time 
getting same initial random numbers, then this could differentiate them at 
least a bit if they had different kernels.


If a few (or all) of the above where used to provide a few bits of 
entropy each, wouldn't that combined give enough difference between boxes 
and provide enough sources to make the final result (at least a bit) less 
easily guessed?


There is of course a big possibility that I'm completely wrong, but I just 
wanted to mention my thoughts in case they would be of use.


--
Jesper Juhl <juhl-lkml@dif.dk>
