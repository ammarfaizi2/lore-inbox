Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289214AbSAOOkx>; Tue, 15 Jan 2002 09:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289776AbSAOOkn>; Tue, 15 Jan 2002 09:40:43 -0500
Received: from mx2.elte.hu ([157.181.151.9]:25254 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S289214AbSAOOkd>;
	Tue, 15 Jan 2002 09:40:33 -0500
Date: Tue, 15 Jan 2002 17:37:55 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Anton Blanchard <anton@samba.org>
Cc: Manfred Spraul <manfred@colorfullife.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: cross-cpu balancing with the new scheduler
In-Reply-To: <20020114061054.GB17549@krispykreme>
Message-ID: <Pine.LNX.4.33.0201151730120.10949-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 14 Jan 2002, Anton Blanchard wrote:

> Rusty and I were talking about this recently. Would it make sense for
> the load balancer to use a weighted queue length (sum up all
> priorities in the queue?) instead of just balancing the queue length?

something like this would work, but it's not an easy task to *truly*
balance priorities (or timeslice lengths instead) between CPUs.

Eg. in the following situation:

	CPU#0			CPU#1

	prio 1			prio 1
	prio 1			prio 1
	prio 20			prio 1

if the load-balancer only looks at the tail of the runqueue then it finds
that it cannot balance things any better - by moving the prio 20 task over
to CPU#1 it will not create a better-balanced situation. If it would look
at other runqueue entries then it could create the following,
better-balanced situation:

	CPU#0			CPU#1

	prio 20			prio 1
				prio 1
				prio 1
				prio 1
				prio 1

the solution would be to search the whole runqueue and migrate the task
with the shortest timeslice - but that is a pretty slow and
cache-intensive thing to do.

	Ingo

