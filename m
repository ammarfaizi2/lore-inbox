Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129858AbQKPLjo>; Thu, 16 Nov 2000 06:39:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129894AbQKPLjf>; Thu, 16 Nov 2000 06:39:35 -0500
Received: from chiara.elte.hu ([157.181.150.200]:44303 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S129858AbQKPLjT>;
	Thu, 16 Nov 2000 06:39:19 -0500
Date: Thu, 16 Nov 2000 13:19:14 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: async IO events
In-Reply-To: <Pine.LNX.4.10.10010232159480.940-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0011161309380.1685-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 23 Oct 2000, Linus Torvalds wrote:

> First, let's see what is so nice about "select()" and "poll()". They
> do have one _huge_ advantage, which is why you want to fall back on
> poll() once the RT signal interface stops working. What is that?
> 
> Basically, RT signals or any kind of event queue has a major
> fundamental queuing theory problem: if you have events happening
> really quickly, the events pile up, and queuing theory tells you that
> as you start having queueing problems, your latency increases, which
> in turn tends to mean that later events are even more likely to queue
> up, and you end up in a nasty meltdown schenario where your queues get
> longer and longer.

TUX uses asynchron IO exclusively, and we faced this very same problem.

the solution is to queue events *without* allocating additional memory.
This is done by extending the basic 'object' structure (file or socket, or
http_req) with event queue fields: input, output, [etc.]. Then if an event
happens for any object, it's added to the 'output queue' or 'input queue'
of any interested process, without allocating memory. It's simple, fast,
efficient, and scales perfectly. The allocation of all event-related data
structures is done when the object itself is allocated.

[this method assumes a basic object->process relationship, but that is not
a problem.]

this is how TUX is able to handle hundreds of thousands of sockets at once
in a single process, without any 'meltdown' effect. Every queueing and IO
operation within TUX is O(1).

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
