Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261486AbRE0TH4>; Sun, 27 May 2001 15:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261490AbRE0THq>; Sun, 27 May 2001 15:07:46 -0400
Received: from chiara.elte.hu ([157.181.150.200]:45320 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S261486AbRE0THg>;
	Sun, 27 May 2001 15:07:36 -0400
Date: Sun, 27 May 2001 21:05:50 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Subject: Re: [patch] severe softirq handling performance bug, fix, 2.4.5
In-Reply-To: <20010527195619.K676@athlon.random>
Message-ID: <Pine.LNX.4.33.0105272101480.5852-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 27 May 2001, Andrea Arcangeli wrote:

> I mean everything is fine until the same softirq is marked active
> again under do_softirq, in such case neither the do_softirq in do_IRQ
> will run it (because we are in the critical section and we hold the
> per-cpu locks), nor we will run it again ourself from the underlying
> do_softirq to avoid live locking into do_softirq.

if you mean the stock kernel, this scenario you describe is not how it
behaves, because only IRQ contexts can mark a softirq active again. And
those IRQ contexts will run do_IRQ() naturally, so while *this*
do_softirq() invocation wont run those reactivated softirqs, the IRQ
context that just triggered the softirq will do so.

the real source of softirq latencies is the local_bh_disable()/enable()
behavior, see my previous patch.

	Ingo


