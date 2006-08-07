Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751077AbWHGFfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbWHGFfU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 01:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbWHGFfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 01:35:20 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:57490 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751077AbWHGFfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 01:35:19 -0400
Date: Mon, 7 Aug 2006 01:34:56 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Theodore Tso <tytso@mit.edu>
cc: David Miller <davem@davemloft.net>, mchan@broadcom.com,
       herbert@gondor.apana.org.au, LKML <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH -rt DO NOT APPLY] Fix for tg3 networking lockup
In-Reply-To: <20060803235326.GC7894@thunk.org>
Message-ID: <Pine.LNX.4.58.0608070124340.15870@gandalf.stny.rr.com>
References: <E1G8a0J-0002Pn-00@gondolin.me.apana.org.au> <1154630207.3117.17.camel@rh4>
 <20060803201741.GA7894@thunk.org> <20060803.144845.66061203.davem@davemloft.net>
 <20060803235326.GC7894@thunk.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 3 Aug 2006, Theodore Tso wrote:

> On Thu, Aug 03, 2006 at 02:48:45PM -0700, David Miller wrote:
> > > eth0: Tigon3 [partno(BCM95704s) rev 2100 PHY(serdes)] (PCIX:100MHz:64-bit) 10/100/1000BaseT Ethernet 00:14:5e:86:44:24
> >
> > The 5704 chip will set TG3_FLAG_TAGGED_STATUS, and therefore
> > doesn't need the periodic poking done by tg3_timer().
>
> Hmm.... all I can say is that I could reliably knock the box off the
> network by running a four processes that tied up all CPU's at high
> real-time priorities, and after I applied the horrible hack that
> guaranteed that tg3_timer() was run every 0.128 seconds, the system
> stayed on the network.  I'm not sure why, but it did fix the problem.
>
> Any suggestions on how I could figure out what was really going on and
> what would be a better fix would be greatly appreciated.
>

Ted,

I took a quick look at the tg3 driver and that timer interrupt as well
have read this thread.  My suggestion would be to separate that tg3_timer
into 4 different timers, which is what it actually looks like.  One I
believe (the first one) is an actual timeout and the other three are
timers that are expected to be triggered everytime (watchdog like: at 1
second, 2 seconds and 3 seconds) and thus should be converted into a
hrtimers that goes off when expected then having some crazy accounting
thing in one timer.

I don't fully understand the ASF part here, and if it definitely needs to
go off then set that timer  with the highest prio.  I've ask Thomas to
add a way to add a hrtimer with a given prio instead of always taking the
current->normal_prio.  But until he does that, you can do a hack of
changing the current prio to something very high (like 99) then start the
timer, and then lower the prio back to what it was.  This is a hack, but
it might lead to a better solution in the future.

-- Steve

