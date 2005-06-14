Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261256AbVFNQsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbVFNQsc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 12:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbVFNQsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 12:48:32 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:18238
	"EHLO g5.random") by vger.kernel.org with ESMTP id S261254AbVFNQrn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 12:47:43 -0400
Date: Tue, 14 Jun 2005 18:47:30 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: karim@opersys.com, dwalker@mvista.com, paulmck@us.ibm.com,
       Bill Huey <bhuey@lnxw.com>, Lee Revell <rlrevell@joe-job.com>,
       Tim Bird <tim.bird@am.sony.com>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, mingo@elte.hu, pmarques@grupopie.com,
       bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au, ak@muc.de,
       sdietrich@mvista.com, hch@infradead.org, akpm@osdl.org
Subject: Re: Attempted summary of "RT patch acceptance" thread
Message-ID: <20050614164730.GD9664@g5.random>
References: <42AE01EA.10905@opersys.com> <E1DiDyt-0003qN-00@w-gerrit.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DiDyt-0003qN-00@w-gerrit.beaverton.ibm.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2005 at 09:09:39AM -0700, Gerrit Huizenga wrote:
> RT code should be crafted so that every single laptop user is running
> most of the code *and* benefiting from it.  If most of the RT code goes

The problem is that it's not feasible to enable it by default and
pretend not to hurt the larger part of the userbase.

Only the musicians and the videogame players may get a benefit from
preempt-RT (probably the videogames players may not get a noticeable
benefit either), everyone else would be hurt somehow.

I don't think it's correct to compare this to the smp scalability
effort, where even a small 2-way was getting benefit from every SMP
optimization done for a 16-way.

Also don't forget today UP systems still run with CONFIG_SMP disable to
keep performance of those systems higher (that may change once UP
systems becomes obsolete, but not because CONFIG_SMP is useless per se ;).

The RT design emulates infinite cpus, with the associated locking
contention that infinite cpus would generate (actually the number is
bound at some point, it's not really infinite but it depends on the
hardware/software combination). To make things even worse every
contention (even if short) generates overscheduling. So the performance
impact of some workload is probably going to be very measurable for a
small system that has no need of dealing with the infinite-cpus locking.
Some slowdown number have been posted already, but probably debug
options were enabled and there's room for further optimization, they
seemed excessive bad numbers so far which can be improved, but no idea
how much.

The mouse going faster kind of thing must be always verified with a
placebo to give it any statistical value (if it cannot be measured),
otherwise by applying the new feature it'll always go faster with the
new feature applied, it happened to me as well sometime, humans aren't
very reliable since our (or at least my) perception of time vary
depending on the feelings.

To make an example I'm 100% sure that I would only get downsides by
running preempt-RT in all my production systems (including laptops,
desktop and servers), so while I may run it on my test systems to help
testing, I would never consider to enable it on any of my production
systems where I try to keep an optimal setup. This has never been the
case with the smp scalability effort, I've always got benefits in all my
smp systems, and I had CONFIG_SMP=n in the UP systems.

This is why there's a config option for preempt-rt I think, which makes
perfect sense to me and I doubt it'll be enabled by default, at least
unless they find a way to reduce the slowdown to not-measurable levels,
which I strongly doubt, especially due the irq scheduling thingy.

Perhaps the only thing that I could benefit from is such horrible 8msec
latency of the usb irq in my firewall, but that's a bug that needs
fixing by offloading it to softirq or in some other way, preempt-RT
would only hide the real problem at the expense of overscheduling.

non-RT irqs are always supposed to be as quick as possible and to do the
processing in normal kernel context after a wakeup (or softirq context
after posting a tasklet or raising a softirq, or even a kevent).

Overall I doubt preempt-RT config option objective was to be enabled by
default in the kernel that gets installed on laptops, but I could be
wrong.
