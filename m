Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261830AbULPN4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbULPN4F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 08:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262660AbULPN4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 08:56:04 -0500
Received: from gaz.sfgoth.com ([69.36.241.230]:56810 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S261830AbULPNzt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 08:55:49 -0500
Date: Thu, 16 Dec 2004 06:00:07 -0800
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Gabriel Paubert <paubert@iram.es>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Eric St-Laurent <ericstl34@sympatico.ca>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Stefan Seyfried <seife@suse.de>, Con Kolivas <kernel@kolivas.org>,
       Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: dynamic-hz
Message-ID: <20041216140007.GG76532@gaz.sfgoth.com>
References: <20041211142317.GF16322@dualathlon.random> <20041212163547.GB6286@elf.ucw.cz> <20041212222312.GN16322@dualathlon.random> <41BCD5F3.80401@kolivas.org> <41BD483B.1000704@suse.de> <20041213135820.A24748@flint.arm.linux.org.uk> <1102949565.2687.2.camel@localhost.localdomain> <1102983378.9865.11.camel@orbiter> <1103133841.3180.1.camel@localhost.localdomain> <20041216091032.GA9774@iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041216091032.GA9774@iram.es>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.2.2 (gaz.sfgoth.com [127.0.0.1]); Thu, 16 Dec 2004 06:00:08 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gabriel Paubert wrote:
> So the options are:
> 1) microseconds, allows up to roughly half an hour (signed) 
>    or an hour (unsigned).
> 2) nanoseconds, needs 64 bits, nice for 64 bit machines but 
>    at the risk of bloat on 32 bit ones.
> 3) timespecs, somewhat wasteful on 64 bit machines (two longs).

Also forgive me if this has already been discussed (I might have missed
some of the messages on these threads) but there's also Paul Henning
Kamp's "bintime" format used in FreeBSD:
  http://phk.freebsd.dk/pubs/timecounter.pdf

I'm not convinced it's the right solution for this problem but the paper
does make a lot of good points.

I also agree that any new timer API needs to have entry points for users
that can handle an imprecise wakeup -- running multiple wakeups at once
is important at high load.

Another idea I've been toying around in my head related to this (but
would need some instrumentation to prove)  I bet on heavy server loads
there's a lot of timeouts where:
  1. Requested timeout is always >N seconds
  2. Timeouts almost always get canceled well before (N/2) seconds have
     passed

If this is the case you could make a pretty simple hack -- on each CPU keep
two list_head's of timers -- lets call them "add_list" and "prev_list".
Now every N/2 seconds do:
  tmp = prev_list
  prev_list = add_list
  add_list = EMPTY
...and then add all the timers on "tmp" to the normal timer queue.

The advantage here is that to add a timer you just have to insert it onto
add_list -- you don't have to keep these lists in order.  By the time
we get around to adding the timers on "tmp" to the main timer queue we know:
  1. They are still waiting to expire (at most "N" seconds have elapsed
     since they were inserted)
  2. Most of them have been canceled (since at least "N/2" seconds have
     passed) and were thus removed from the list.  "tmp" should not
     have many elements remaining

I think for some class of timeouts (device timeouts, network, etc) this
should be pretty efficient.  You'd have to do a bunch of instrumenting
to see if there are enough timers with these characteristics to make this
useful (and what would make a good value for 'N')  I've got a zillion other
projects so I'm not going to have a chance to do this, but maybe it'll
give someone else some ideas.

-Mitch
