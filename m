Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289715AbSAJVro>; Thu, 10 Jan 2002 16:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289712AbSAJVre>; Thu, 10 Jan 2002 16:47:34 -0500
Received: from mx2.elte.hu ([157.181.151.9]:25293 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S289706AbSAJVrT>;
	Thu, 10 Jan 2002 16:47:19 -0500
Date: Fri, 11 Jan 2002 00:44:43 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Robert Love <rml@tech9.net>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mike Kravetz <kravetz@us.ibm.com>, Anton Blanchard <anton@samba.org>,
        george anzinger <george@mvista.com>,
        Davide Libenzi <davidel@xmailserver.org>,
        Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch] O(1) scheduler, -G1, 2.5.2-pre10, 2.4.17 (fwd)
In-Reply-To: <1010692888.5338.319.camel@phantasy>
Message-ID: <Pine.LNX.4.33.0201110036420.10579-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 10 Jan 2002, Robert Love wrote:

> Along the same lines as the above, note this code snippet from
> try_to_wake_up:

> 		if (0 && !rt_task(p) && synchronous && (smp_processor_id() < p->cpu)) {

> +		if (!rt_task(p) && synchronous && (smp_processor_id() > p->cpu)) {

you are right - but i have removed it completely from my current tree.

the reason is that i think, unless seeing some hard proof to the contrary,
it's not a good idea to balance from wakeups. Wakeups are high-frequency
and lightweight in nature, and despite all the idle-balancing magic we
tried in 2.4 (i wrote most of that code), there were important cases where
it failed.

so the current stategy i'd like us to try is to do 'high frequency idle
rebalancing' and 'slow frequency fairness rebalancing'. No rebalancing in
wakeup, at all. This makes wakeups simpler, faster and more scalable. (We
can also do slow rebalancing in some other, strategic places where we know
that it's the right time to push a process context to another CPU.)

	Ingo

