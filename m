Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275861AbRI1HhO>; Fri, 28 Sep 2001 03:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275863AbRI1HhE>; Fri, 28 Sep 2001 03:37:04 -0400
Received: from chiara.elte.hu ([157.181.150.200]:42766 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S275861AbRI1Hgw>;
	Fri, 28 Sep 2001 03:36:52 -0400
Date: Fri, 28 Sep 2001 09:34:52 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Ben LaHaise <bcrl@redhat.com>
Subject: Re: [patch] softirq performance fixes, cleanups, 2.4.10.
In-Reply-To: <20010928052007.R14277@athlon.random>
Message-ID: <Pine.LNX.4.33.0109280919210.1569-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 28 Sep 2001, Andrea Arcangeli wrote:

> I'm just curious, what are the numbers of your A7 patch compared with
> this one?

well, a quick glance shows that this is mostly the -A7 patch with the
single-loop omitted, right? I tested it before (the unwakeup mechanizm is
orthogonal to the looping concept), and while unwakeup alone helps
somewhat, its effect cannot be compared to the effects of looping. Please
check my previous mail for details, i tried a large set of other
combinations as well.

frankly, i dont understand what your problem is with the looping concept.
It's actually simpler than the mask-bitmap version, and it ensures
finegrained handling and low latencies of softirq handlers. We loop in the
softirq handlers themselves already. Ideally we'd like to loop until all
work is done - but we exit on some limits, and it's generally a good idea
to not let the handlers themselves loop for a too long time. (to get good
scheduling latencies.) And we can increase/decrease MAX_SOFTIRQ_RESTART if
it's ever shown to be excessive/insufficient. (We could even runtime tune
it - but i thought that to be an overdesigning of a nonexisting problem.)

(i had an interim version of the patch which had a sysctl-tunable
MAX_SOFTIRQ_RESTART - this is where the value of '10' comes from. A value
of '1' means a single-loop. Just to make sure i also tested the 'mask'
version which is a bit more than just a single loop in the current patch -
but for tx/rx purposes it's almost equivalent to a single loop.)

	Ingo

