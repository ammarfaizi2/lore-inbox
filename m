Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267529AbRGWUPh>; Mon, 23 Jul 2001 16:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267833AbRGWUP1>; Mon, 23 Jul 2001 16:15:27 -0400
Received: from mplspop4.mpls.uswest.net ([204.147.80.14]:58885 "HELO
	mplspop4.mpls.uswest.net") by vger.kernel.org with SMTP
	id <S267529AbRGWUPU>; Mon, 23 Jul 2001 16:15:20 -0400
Date: Mon, 23 Jul 2001 13:15:31 -0700
Message-Id: <p05100301b78235dce19e@[10.0.0.49]>
From: "Jonathan Lundell" <jlundell@pobox.com>
To: "Linus Torvalds" <torvalds@transmeta.com>,
        "Andrea Arcangeli" <andrea@suse.de>
Cc: "Jeff Dike" <jdike@karaya.com>, user-mode-linux-user@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, "Jan Hubicka" <jh@suse.cz>
Mime-Version: 1.0
In-Reply-To: <Pine.LNX.4.33.0107231259520.13272-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0107231259520.13272-100000@penguin.transmeta.com>
Subject: Re: user-mode port 0.44-2.4.7
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

At 1:00 PM -0700 2001-07-23, Linus Torvalds wrote:
>On Mon, 23 Jul 2001, Andrea Arcangeli wrote:
>>
>>  gcc can assume 'state' stays constant in memory not just during the
>>  'case'.
>
>The point is that if the kernel has _any_ algorithm where it cares, it's a
>kernel bug. With volatile or without.
>
>SHOW ME THE CASE WHERE IT CARES. Let's fix it. Let's not just hide it with
>"volatile".

in arch/i386/kernel/io_apic.c:

>static int __init timer_irq_works(void)
>{
>	unsigned int t1 = jiffies;
>
>	sti();
>	/* Let ten ticks pass... */
>	mdelay((10 * 1000) / HZ);
>
>	/*
>	* Expect a few ticks at least, to be sure some possible
>	* glue logic does not lock up after one or two first
>	* ticks in a non-ExtINT mode.  Also the local APIC
>	* might have cached one ExtINT interrupt.  Finally, at
>	* least one tick may be lost due to delays.
>	*/
>	if (jiffies - t1 > 4)
>		return 1;
>
>	return 0;
>}

If jiffies were not volatile, this initializing assignment and the 
test at the end could be optimized away, leaving an unconditional 
"return 0". A lock is of no help.
-- 
/Jonathan Lundell.
