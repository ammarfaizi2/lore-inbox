Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262326AbUJ0IKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262326AbUJ0IKu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 04:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbUJ0IKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 04:10:50 -0400
Received: from mx1.elte.hu ([157.181.1.137]:27536 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262326AbUJ0IKe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 04:10:34 -0400
Date: Wed, 27 Oct 2004 10:10:44 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: karim@opersys.com, paulmck@us.ibm.com, linux-kernel@vger.kernel.org,
       rpm@xenomai.org
Subject: Re: [RFC][PATCH] Restricted hard realtime
Message-ID: <20041027081044.GA14451@elte.hu>
References: <20041023194721.GB1268@us.ibm.com> <417F12F1.5010804@opersys.com> <20041026212956.4729ce98.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041026212956.4729ce98.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> I have a sneaking suspicion that the day will come when we get nice
> sub-femtosecond latencies in all the trivial benchmarks [...]

with -RT-V0.3 i get lower than 20 usec _maximum_ latencies during
'./hackbench 20'. (the average latency is 1 usec) So while i'm not yet
in the sub-femtosecond category, things are looking pretty good in
PREEMPT_REALTIME land :)

> [...] but it turns out that the realtime processes won't be able to
> *do* anything useful because whenever they perform syscalls, those
> syscalls end up taking long-held locks.

this is not really a problem for the following reason: the spinlock
lock-breaks i am doing for !PREEMPT_REALTIME are exactly the kind of
latencies that could interact with a hard-RT task. What becomes a
latency reducer for the normal SMP or desktop kernel is _the_ latency
guarantee for using arbitrary kernel services in the PREEMPT_REALTIME
model.

another step is to make kernel subsystems have constant overhead (O(1)),
i'd say that's mostly true already today, and it's increasingly becoming
true in the future.

also, RT applications rarely hit the really complex kernel subsystems
because 'complex' often means 'has the potential for IO' - on any
hard-RT OS. So what is important are two factors:

 1) preempt to the RT app immediately

 2) do not create locking interactions between a tasks that use 
    'isolated resources'

#1 is quite good in PREEMPT_REALTIME, and even #2 is largely true for 
it. But RT apps will try to stay isolated anyway, they do an mlockall()
and use simple syscalls.

note that #2 means: 'no big locks', which is a natural scalability
desire anyway.

> Which does lead me to suggest that we need to identify the target
> application areas for Ingo's current work and confirm that those
> applications are seeing the results which they require.  Empirical
> results from the field do seem to indicate success, but I doubt if
> they're sufficiently comprehensive.

with the -V series of PREEMPT_REALTIME the 'preemption latency' target
is easy to meet, because in essence everything except the core scheduler
and the irq redirection code is preemptible :)

E.g. the innermost loop of the IDE hardirq is preemptible, the innermost
loop of kswapd is preemptible and PREEMPT_REALTIME can preempt the
pagefault handler and the mouse handler - name any code and it's
preemptible.

the API latency target is not a big issue because the 'locking
independence' requirement (#2 above) directly corresponds to 'good
scalability on SMP and NUMA'. So anytime we improve high-end scalability
we often will also improve the API-latencies of PREEMPT_REALTIME!

(of course this is a much simplified reasoning ignoring a few issues.)

	Ingo
