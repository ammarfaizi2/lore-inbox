Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261481AbVFKP4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261481AbVFKP4E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 11:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261553AbVFKP4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 11:56:03 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:4451
	"EHLO g5.random") by vger.kernel.org with ESMTP id S261481AbVFKPzH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 11:55:07 -0400
Date: Sat, 11 Jun 2005 17:54:59 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Bill Huey <bhuey@lnxw.com>, Karim Yaghmour <karim@opersys.com>,
       Lee Revell <rlrevell@joe-job.com>, Tim Bird <tim.bird@am.sony.com>,
       linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org
Subject: Re: Attempted summary of "RT patch acceptance" thread
Message-ID: <20050611155459.GB5796@g5.random>
References: <1118372388.32270.6.camel@mindpipe> <20050610154745.GA1300@us.ibm.com> <20050610173728.GA6564@g5.random> <20050610193926.GA19568@nietzsche.lynx.com> <42A9F788.2040107@opersys.com> <20050610223724.GA20853@nietzsche.lynx.com> <20050610225231.GF6564@g5.random> <20050610230836.GD21618@nietzsche.lynx.com> <20050610232955.GH6564@g5.random> <20050611014133.GO1300@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050611014133.GO1300@us.ibm.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2005 at 06:41:33PM -0700, Paul E. McKenney wrote:
> I just -know- I am going to regret stepping into the middle of
> this one...

Never mind, I keep regretting it myself. Perhaps it was better if I
avoided posting here, and by now people would think preempt-RT was the
holy grail of hard-RT and that would obsolete RTAI/rtlinux, when infact
it's an inferior solution from from a reliability/guarantee standpoint
and from a performance standpoint too (as some measurements showed
already too) [and local_irq_disable would still be not emulated in
software]

> All I have seen Ingo claim is that -some- hardware configurations running
> -some- specific workloads had excellent -measured- maximum scheduling
> latencies.  I have not seen Ingo claim that he has mathematically proven
> that CONFIG_PREEMPT_RT's worst-case scheduling latency is bounded, let
> alone make any claim of what such a mathematically proven bound might be.

Indeed. As I stated in my first relevant post to this thread on "Tue, 31
May 2005 18:11:57 +0200" _before_ most of the other quotes that I received
today, and before realizing the _irq part of the spin_lock_irq was
already emulated in software and before realizing that the rtlinux
patent doesn't forbid to emulate in software the _irq part of the
spin_lock_irq because I'm not really good at reading all the patent
claims but I focused only on the patent concept (and regardless there is
apparently somebody who rightfully paid lawyers for research in that area):

	For the determinism, you could do what Ingo did so far, that is to
	"measure" but there's no way a "measurement" can provide an hard-RT
	guarantee. The "measure" way is great for the lowlatency patches, and to
	try to eliminate the bad-latencies paths, but it _can't_ guarantee a 
	"worst-case-latency".

This is what I posted in my _second_ email to this thread. Of course
nobody is quoting the above, they picked other later emails, but if you
go back to the second email (and first relevant one) I posted here,
you'll see this text at the end.  Sorry for that mistake about the _irq
part and the related patent claims that I'm not good at reading cause
it's written by lawyers, but that mistake made no difference to the
bottom line cause local_irq_disable was still disable the hard irqs
without being emulated in software. I was reading local_irq_disable that
wasn't touched (local_irq_disable is the _first_ thing I check in every
RT patch on earth) and so I assumed no _irq disable was emulated. My bad
but it didn't change the bottom line.

Now even local_irq_disable can be emulated in software (incidentally
happened after my suggestions last week) but that still leaves the above
issue in my second email unsolved.

It's not like I made up this "guarante" of worst case latency argument
after realizing that _irq was emulated and after local_irq_disable has
been emulated too, as somebody apparently seems to have described today
by providing a list of quotes ignoring the above argument that was the
core of my first relevant email to this thread.

If you check the timestamp, I mentioned the above core issue, way
_before_ going into the _irq details.

> Ingo -has- greatly reduced the amount of kernel code that must
> be inspected to guarantee realtime response, and this is a great
> accomplishment and a great contribution.  I believe that his approach

Indeed.

> is more than "good enough" for a great number of applications that are
> traditionally thought of as "hard realtime".  But, unless I missed
> something, it is not mathematically proven, nor is it in any way
> "certified".

Yes, it could be that 99% of the app that traditionally claims to need
hard-RT will be fully covered by preempt-RT (assuming the cpu can keep
up with the slowdown), but when I talk about hard-RT I only think at
those apps like the linuxdevices article that beats at 50usec. To me
hard-RT is all about guaranteeing to provide a deadline, the rest I call
it lowlatency patches. preempt-RT is obviously a very great improvement
to the lowlatency soft-RT approach and I agree a lot of those apps
thought to need hard-RT will be fine with it.

But one should evaluate if an hard-RT guarantee is truly needed or not
before picking preempt-RT, the performance should be evaluated as well
cause irq handling is much faster than a context switch.

The slowdown numbers posted so far are quite impressive as well.

Think that in some recent research I'm doing, I'm looking to make the
semaphore a spinlock to boost performance, preempt-RT is the opposite ;)

> Some of the approaches involving separate RTOSes -can- legitimately claim
> have mathematically proven worst-case scheduling latencies.  For example,
> the dual-OS/dual-core approach can do so, particularly in the case where
> the "RTOS" is a tight loop written on bare metal in hand-coded assembly.
> One might consider this to be a trivial example, perhaps even a stupid
> example, but there are a lot of apps out there that use exactly this
> approach.
>
> The migration-between-OSes approach, such as RTAI Fusion, might also be
> able to mathematically guarantee RTOS scheduling latencies.  And, unlike
> the dual-OS/dual-core approaches, it does provide a single environment
> to applications.  However, it still results in two separate OS instances
> to administer, and, as near as I can tell, the RTOS has to stick its
> hands so deeply into Linux's internals that it might as well be part
> of the Linux kernel.  Unless I am missing something, any sort of bug
> in the Linux kernel has a reasonable chance of messing up the RTOS,
> since the RTOS must paw through Linux's tasks.

Yes. I'm a beliver in the dual-OS/dual-core model, as the only one who
can reasonably simply guarantee a deadline.

The single image RTOS has much larger pieces of complex code involved in
the RT equation (in your list you didn't mention the mutex code itself),
plus this codes like the scheduler changes all the time (it's not like
the irq code that pratically never changes in stable cycles), and it
slowsdown quite a bit as well at emulating infinite cpus and
overscheduling at every contention.

> Can we say that one of these approaches is definitely "good enough" for
> all reasonable Linux RT work, and that we should therefore stop working on 
> the other approach?
> 
> I might well be missing something, but I don't believe so, at least
> not yet.

I agree with you. Perhaps I didn't make my point of view clear enough on
the good things of preempt-RT. preempt-RT is a great feature for some
apps.

I _only_ criticise people who wants to put preempt-RT on par with
guaranteed hard-RT solutions like RTAI/rtlinux that can easily provide a
guaranteed deadline, while preempt-RT can only proviede measurements
backed by statistically signficance, which is quite far away from a
guarantee. Plus it's much slower as well. But apparently some people
here, wants you to believe that preempt-RT will be exactly guaranteed
hard-RT as RTAI/rtlinux, and they can't handle it when I say this is not
the case. This is the only thing I'm objecting as stated in my first
relevant email of the thread partly quoted above.

I'm sure I've ever said that preempt-RT is useless and there's no application
for it, infact I stated _multiple_ times there are cases like alsa where
preempt-RT is the very best that one can do.

> In the meantime, the more time anyone spends sending flames on LKML, the
> less time that person is putting into improving his/her favorite approach.

Well, I'm not in RT development anyway so that's not my case, but of
course I'm could spend my time much better anyway ;)

Thanks again for your appreciated RT efforts Paul!
