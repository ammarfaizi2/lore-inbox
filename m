Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131673AbRCSXpU>; Mon, 19 Mar 2001 18:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131672AbRCSXpL>; Mon, 19 Mar 2001 18:45:11 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38667 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S131671AbRCSXo7>;
	Mon, 19 Mar 2001 18:44:59 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200103192344.XAA02107@raistlin.arm.linux.org.uk>
Subject: Re: gettimeofday question
To: eli.carter@inet.com (Eli Carter)
Date: Mon, 19 Mar 2001 23:44:06 +0000 (GMT)
Cc: lk@tantalophile.demon.co.uk (Jamie Lokier), linux-kernel@vger.kernel.org
In-Reply-To: <3AB68E13.E6F6109E@inet.com> from "Eli Carter" at Mar 19, 2001 04:54:11 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eli Carter writes:
> And you described (in much better detail) the same problem I was talking
> about in the first email I sent today.

Ok, at least we've got the same picture that we're working from now.

> Yes, but it digs another to get the dirt to fill the first one. :/  for
> instance:
> 
> > 
> >         read_lock_xtime_and_ints();
> >         jiffies_1 = jiffies;
> >         counter_1 = counter;
> >         read_unlock_xtime_and_ints();
> 
> Time passes due to an interrupt handler.... but not a full jiffy, so
> jiffies hasn't changed.
> Also, what if this function is called with interrupts disabled?  (Is
> that legal?)  If so, we've broken the locking expected by the caller.

The calling function does indeed do the read_lock_xtime_and_ints() bit
for us.  However, we can always do a read_unlock(); sti(); read_lock_irq();
in do_gettimeofday().  Whether we want to or not is another matter,
especially as its not nice for a called function to explicitly enable
interrupts.

As for timer interrupts taking more than 10ms, yes, that is another
problem. ;(

> Comments?

This problem has a non-trivial solution, and I think whoever originally
wrote the x86 do_gettimeofday code decided that it wasn't worth finding
a solution to it.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html
