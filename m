Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129292AbRDJRP6>; Tue, 10 Apr 2001 13:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129408AbRDJRPs>; Tue, 10 Apr 2001 13:15:48 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:11022 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S129292AbRDJRPg>;
	Tue, 10 Apr 2001 13:15:36 -0400
Date: Tue, 10 Apr 2001 19:15:28 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: David Schleef <ds@schleef.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Mark Salisbury <mbs@mc.com>, Jeff Dike <jdike@karaya.com>,
        schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: No 100 HZ timer !
Message-ID: <20010410191528.B21024@pcep-jamie.cern.ch>
In-Reply-To: <20010410053105.B4144@stm.lbl.gov> <Pine.LNX.3.96.1010410155723.28395A-100000@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.96.1010410155723.28395A-100000@artax.karlin.mff.cuni.cz>; from mikulas@artax.karlin.mff.cuni.cz on Tue, Apr 10, 2001 at 04:10:28PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikulas Patocka wrote:
> Timers more precise than 100HZ aren't probably needed - as MIN_RTO is 0.2s
> and MIN_DELACK is 0.04s, TCP would hardly benefit from them.

Indeed, using precise timers for TCP would probably degrade performance
-- you should process a group of timer events together, when resolution
is not that important.

There are plenty of apps that need higher resolution.  Software modem
comes to mind (guess why ;), though the device driver supplies the high
resolution timed interrupts in that case.

Games would like to be able to page flip at vertical refresh time --
<1ms accuracy please.  Network traffic shaping benefits from better than
1ms timing.  Video players want to display their frames preferably
without 10ms jitter.

Even that old classic game "snake" benefits from decent timing.  I
worked on an X multiplayer snake implementation which was very
unpleasant and jerky at first.  1. Disable nagle for X connection :-)
Better but still jerky.  2. Write delay loop like this:

     calculate next_event_time
     select (0, 0, 0, next_event_time - 20ms)
     while (gettimeofday() < next_event_time)
       /* Busy loop for last 20ms. */

It's no coincidence that I've had to write another very similar event
loop recently.  You can see, this sort of thing is a real waste of CPU.

-- Jamie
