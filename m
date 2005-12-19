Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964806AbVLSQJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbVLSQJs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 11:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964802AbVLSQJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 11:09:48 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:26773 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964798AbVLSQJr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 11:09:47 -0500
Date: Mon, 19 Dec 2005 17:08:54 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Joe Korty <joe.korty@ccur.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>, matthew@wil.cx,
       arjan@infradead.org, Christoph Hellwig <hch@infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, nikita@clusterfs.com, pj@sgi.com,
       dhowells@redhat.com
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-ID: <20051219160854.GA7934@elte.hu>
References: <1134769269.2806.17.camel@tglx.tec.linutronix.de> <Pine.LNX.4.64.0512161339140.3698@g5.osdl.org> <1134770778.2806.31.camel@tglx.tec.linutronix.de> <Pine.LNX.4.64.0512161414370.3698@g5.osdl.org> <1134772964.2806.50.camel@tglx.tec.linutronix.de> <Pine.LNX.4.64.0512161439330.3698@g5.osdl.org> <20051217002929.GA7151@tsunami.ccur.com> <Pine.LNX.4.64.0512161647570.3698@g5.osdl.org> <Pine.LNX.4.58.0512162211320.6498@gandalf.stny.rr.com> <Pine.LNX.4.64.0512162323140.3698@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512162323140.3698@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> I really can't think of any blocking kernel lock where priority 
> inheritance would make _any_ sense at all. Please give me an example.

you are completely right, most of the blocking kernel locks we have in 
Linux are an extremely poor candidate for priority inheritance. Most of 
them are totally noncritical, or cover so long codepaths that 'latency 
guarantees' and 'priority inheritance' make little sense for them.

the reason why we still have transformed most of the stock semaphore 
users to generic mutexes in the -rt kernel is mostly because i wanted to 
have _one_ central lock implementation. Firstly, it makes alot of sense 
to consolidate code on embedded platforms anyway. Secondly, it was much 
easier to implement (and validate) one robust locking primitive, than to 
implement 5 separate primitives. The fact that this also made semaphores 
PI-able is just a side-effect, with little to no practical relevance.

maybe ->i_sem is one notable exception: it is often held in critical 
codepaths, and it's really hard for even the most-well-controlled RT app 
to achieve _total_ isolation from the 'unprivileged' filesystem space.  
So occasional 'resource sharing' in form of hitting an i_sem of another 
task may still occur, and PI can at least reduce the worst-case cost 
somehow. (even though i_sem codepaths are by no means deterministic!)

so in the -rt kernel, every semaphore, rw-semaphore, spinlock, rwlock 
and seqlock [and in the latest -rt patches, every futex too] is 
abstracted off a central generic mutex type, which mutex is blocking and 
supports priority queueing and priority inheritance. It also has an 
extensive debugging framework, which we didnt want to duplicate for 
every separate lock object.

we also have a facility in the -rt kernel that traces the worst-case 
latency path of critical applications (the 'latency tracer'), when mixed 
with non-critical workloads, so we have quite good experience about what 
kind of locks make a difference and what kind of locks make no 
difference.

we also definitely know that priority inheritance done over _all_ these 
lock objects makes a very real quality difference in practice, resulting 
in real-time apps experiencing much lower worst-case latencies than 
under the stock kernel. It is true that you could live without priority 
inheritance, in cases were the RT app can be rewritten to have totally 
separated resources, but in practice that is only possible for the 
simplest applications.

	Ingo
