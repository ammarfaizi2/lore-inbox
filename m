Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313535AbSC3TIK>; Sat, 30 Mar 2002 14:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313536AbSC3TIA>; Sat, 30 Mar 2002 14:08:00 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5383 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S313535AbSC3THx>;
	Sat, 30 Mar 2002 14:07:53 -0500
Message-ID: <3CA60CB1.E33080D5@zip.com.au>
Date: Sat, 30 Mar 2002 11:06:25 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [patch] block/IDE/interrupt lockup
In-Reply-To: <3CA603B0.8B73FD4C@zip.com.au> from "Andrew Morton" at Mar 30, 2002 10:28:00 AM <E16rNxa-0003UM-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > The kernel calls request_irq() inside cli() in lots of places.
> > That's the same bug: "if you called cli(), how come you're
> > allowing kmalloc to clear it?".
> 
> Those places should if possible be fixed. I take patches. If we can get 2.4
> to BUG() on those kmalloc violations and clean them up it sounds like
> progress

What I'd like is a debugging function `can_sleep()'.  This
is good for documentary purposes, and will catch bugs.

So kmalloc() would gain:

	if (gfp_flags & __GFP_WAIT)
		can_sleep();

can_sleep() would do the following:

- If CONFIG_PREEMPT, check the locking depth (minus BKL depth),
  whine if non-zero.

- If inside cli(), whine.

- If inside __cli(), also whine (not really a bug, but a design error).

- whining will include generation of a backtrace.

I suspect a 2.4 version would generate too many bug reports :)
It would have to implement its own lock depth accounting if
we want the sleep-inside-spinlock checking.

There's some arch-dependent stuff in there.  I'll do a 2.5
patch.  I suspect it'll generate showers of stuff.  We can
feed fixes back into 2.4.

-
