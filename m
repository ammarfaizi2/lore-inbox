Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264521AbRFJLwg>; Sun, 10 Jun 2001 07:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264520AbRFJLw1>; Sun, 10 Jun 2001 07:52:27 -0400
Received: from juicer13.bigpond.com ([139.134.6.21]:40947 "EHLO
	mailin1.bigpond.com") by vger.kernel.org with ESMTP
	id <S264519AbRFJLwR>; Sun, 10 Jun 2001 07:52:17 -0400
Message-Id: <m1592do-001RQAC@mozart>
From: Rusty Russell <rusty@rustcorp.com.au>
To: mingo@elte.hu
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Subject: Re: [patch] severe softirq handling performance bug, fix, 2.4.5 
In-Reply-To: Your message of "Sat, 26 May 2001 19:59:28 +0200."
             <Pine.LNX.4.33.0105261920030.3336-200000@localhost.localdomain> 
Date: Sun, 10 Jun 2001 20:40:20 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.33.0105261920030.3336-200000@localhost.localdomain> you 
write:
> i've been seeing really bad average TCP latencies on certain gigabit cards
> (~300-400 microseconds instead of the expected 100-200 microseconds), ever
> since softnet went into the main kernel, and never found a real
> explanation for it, until today.

The S/390 guys hit similar issues with the hotplug CPU patch, with
softirqs still pending on the downed CPU.

There are two cases when this happens:

(1) softirq's disabled when the interrupt came in.

(2) softirq scheduled within softirq, such as when networking is
    overloaded (net/core/dev.c's net_rx_action()).

Solving (2) is hard: the choices are to risk livelock (by resetting
the mask inside the softirq loop), or accept that bursty traffic may
have latencies of up to one timer tick.

Either way, we should solve (1) by checking in local_bh_enable() is
fine (despite Dave's reservations, and Alexey's "don't do that unless
you are about to schedule()" is obviously crap).  Then we can drop the
hackish checks inside schedule(), system calls returns and idle loops,
all of which were simply masking this problem.

Rusty.
--
Premature optmztion is rt of all evl. --DK
