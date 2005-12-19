Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965208AbVLSG3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965208AbVLSG3N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 01:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965229AbVLSG3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 01:29:13 -0500
Received: from smtp.osdl.org ([65.172.181.4]:9619 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965208AbVLSG3N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 01:29:13 -0500
Date: Sun, 18 Dec 2005 22:24:55 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@suse.de>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: [patch 00/15] Generic Mutex Subsystem
In-Reply-To: <20051219042248.GG23384@wotan.suse.de>
Message-ID: <Pine.LNX.4.64.0512182214400.4827@g5.osdl.org>
References: <20051219013415.GA27658@elte.hu> <20051219042248.GG23384@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 19 Dec 2005, Andi Kleen wrote:
> 
> Do you have an idea where this big difference comes from? It doesn't look
> it's from the fast path which is essentially the same.  Do the mutexes have
> that much better scheduling behaviour than semaphores? It is a bit hard to 
> believe.

Are ingo's mutex'es perhaps not trying to be fair?

The normal mutexes try to make sure that if a process comes in and gets 
stuck on a mutex, and then another CPU releases the mutex and immediately 
tries to grab it again, the other CPU will _not_ get it.

That's a huge performance disadvantage, but it's done on purpose, because 
otherwise you end up in a situation where the semaphore release code did 
wake up the waiter, but before the waiter actually had time to grab it (it 
has to go through the IPI and scheduling logic), the same CPU just grabbed 
it again.

The original semaphores were unfair, and it works really well most of the 
time. But then it really sucks in some nasty cases.

The numbers make me suspect that Ingo's mutexes are unfair too, but I've 
not looked at the code yet.

NOTE! I'm not a huge fan of fairness per se. I think unfair is often ok, 
and the performance advantages are certainly real. It may well be that the 
cases that caused problems before are now done differently (eg we switched 
the VM semaphore over to an rwsem), and that we can have an unfair and 
fast mutex for those cases where we don't care.

I just suspect the comparison isn't fair.

		Linus
