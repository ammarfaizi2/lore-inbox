Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265938AbRGFDmd>; Thu, 5 Jul 2001 23:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265921AbRGFDmN>; Thu, 5 Jul 2001 23:42:13 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:21987 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S265969AbRGFDmB>; Thu, 5 Jul 2001 23:42:01 -0400
Message-ID: <3B4533B6.7E67A0D1@uow.edu.au>
Date: Fri, 06 Jul 2001 13:42:46 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bob_Tracy <rct@gherkin.sa.wlk.com>
CC: Andrea Arcangeli <andrea@suse.de>, Arjan van de Ven <arjanv@redhat.com>,
        Thibaut Laurent <thibaut@celestix.com>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: [2.4.6] kernel BUG at softirq.c:206!
In-Reply-To: <20010705181544.Y17051@athlon.random> "from Andrea Arcangeli at
	 Jul 5, 2001 06:15:44 pm" <m15IHnE-0005khC@gherkin.sa.wlk.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bob_Tracy wrote:
> 
> Andrea Arcangeli quoted:
> > On Thu, Jul 05, 2001 at 11:46:33AM -0400, Arjan van de Ven wrote:
> > > On Thu, Jul 05, 2001 at 11:32:00PM +0800, Thibaut Laurent wrote:
> > > > And the winner is... Andrea. Kudos to you, I've just applied these patches,
> > > > recompiled and it seems to work fine.
> > > > Too bad, this was the perfect excuse for getting rid of those good old Cyrix
> > > > boxen ;)
> > >
> > > As Andrea's patches don't actually fix anything Cyrix related it's obvious
> > > that they just avoid the real bug instead of fixing it.
> > > It's a very useful datapoint though.
> 
> Put me in the "it works for me" camp also.  Do we have the definitive answer
> as far as what is/was broken?   Thanks, Andrea...

The Cyrix setup code in arch/i386/kernel/setup.c is unconditionally
enabling interrupts when it shouldn't.  This allows timer interrupts
to start running before the softirq system has been set up.  A
subsequent softirq_init() mucks up the softirq data structures and
we hit the BUG().

The setup code needs to not reenable interrupts, and softirq_init()
should be called prior to time_init().  Both these changes are in
2.4.7-pre3.

-
