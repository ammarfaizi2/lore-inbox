Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276045AbRI1Sg6>; Fri, 28 Sep 2001 14:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276232AbRI1Sgs>; Fri, 28 Sep 2001 14:36:48 -0400
Received: from h24-78-175-24.vn.shawcable.net ([24.78.175.24]:12170 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id <S276229AbRI1Sgf>;
	Fri, 28 Sep 2001 14:36:35 -0400
Date: Fri, 28 Sep 2001 11:36:48 -0700
From: Simon Kirby <sim@netnation.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Subject: Re: [patch] softirq-2.4.10-B2
Message-ID: <20010928113648.A21266@netnation.com>
In-Reply-To: <20010928013106.W14277@athlon.random> <Pine.LNX.4.33.0109280716040.1569-200000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0109280716040.1569-200000@localhost.localdomain>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2001 at 09:18:17AM +0200, Ingo Molnar wrote:

> basically the problem is that there is a big 'gap' between the activation
> of softirqs, and the time when ksoftirqd starts running. There are a
> number of mechanisms within the networking stack that are quite
> timing-sensitive. And generally, if there is work A and work B that are
> related, and we've executed work A (the hardware interrupt), then it's
> almost always the best idea to execute work B as soon as possible. Any
> 'delaying' of work B should only be done for non-performance reasons:
> eg. fairness in this case. Now it's MAX_SOFTIRQ_RESTART that balances
> performance against fairness. (in most kernel subsystems we almost always
> give preference to performance over fairness - without ignoring fairness
> of course.)

This may be somewhat related to something I've been thinking about
lately: The fact that most machines will choke under a simple UDP
while(1) sendto() attack (eg: around 100Mbit wire speed with lots of small
packets).  It seems that what's happening is a new packet comes in
immediately after the last interrupt is serviced (because the packets are
so small), so the CPU has no time to execute anything else and goes right
back into the interrupt handler.  This starves userspace CPU time.

Would your changes affect this at all?  It would be nice if this could
somehow be batched so that a Linux router could be capable of handling
large amounts of traffic with small packets, and wouldn't choke when lots
of small packets (most commonly from a TCP SYN bomb) go through it.

Actually, I just tested my while(1) sendto() UDP spamming program on an
Acenic card and noticed that it seems to do some sort of batching /
grouping, because the number of interrupts reported by vmstat is only
8,000 while it's easily 75,000 on other eepro100 boxes.  Interesting...

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
