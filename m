Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261692AbUKTHUw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbUKTHUw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 02:20:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262926AbUKTHUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 02:20:52 -0500
Received: from holomorphy.com ([207.189.100.168]:35971 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261692AbUKTHUe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 02:20:34 -0500
Date: Fri, 19 Nov 2004 23:15:14 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Linus Torvalds <torvalds@osdl.org>, Christoph Lameter <clameter@sgi.com>,
       akpm@osdl.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Hugh Dickins <hugh@veritas.com>, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V11 [0/7]: overview
Message-ID: <20041120071514.GO2714@holomorphy.com>
References: <20041120020306.GA2714@holomorphy.com> <419EBBE0.4010303@yahoo.com.au> <20041120035510.GH2714@holomorphy.com> <419EC205.5030604@yahoo.com.au> <20041120042340.GJ2714@holomorphy.com> <419EC829.4040704@yahoo.com.au> <20041120053802.GL2714@holomorphy.com> <419EDB21.3070707@yahoo.com.au> <20041120062341.GM2714@holomorphy.com> <419EE911.20205@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <419EE911.20205@yahoo.com.au>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> touch_nmi_watchdog() is only "protection" against local interrupt
>> disablement triggering the NMI oopser because alert_counter[]
>> increments are not atomic. Yet even supposing they were made so, the

On Sat, Nov 20, 2004 at 05:49:53PM +1100, Nick Piggin wrote:
> That would be a bug in touch_nmi_watchdog then, because you're
> racy against your own NMI too.
> So I'm actually not very very wrong at all. I'm technically wrong
> because touch_nmi_watchdog has a theoretical 'bug'. In practice,
> multiple races with the non atomic increments to the same counter,
> and in an unbroken sequence would be about as likely as hardware
> failure.
> Anyway, this touch nmi thing is going off topic, sorry list.

No, it's on-topic.
(1) The issue is not theoretical. e.g. sysrq t does trigger NMI oopses,
	merely not every time, and not on every system. It is not
	associated with hardware failure. It is, however, tolerable
	because sysrq's require privilege to trigger and are primarly
	used when the box is dying anyway.
(2) NMI's don't nest. There is no possibility of NMI's racing against
	themselves while the data is per-cpu.


William Lee Irwin III wrote:
>> net effect of "covering up" this gross deficiency is making the
>> user-observable problems it causes undiagnosable, as noted before.

On Sat, Nov 20, 2004 at 05:49:53PM +1100, Nick Piggin wrote:
> Well the loops that are in there now aren't covered up, and they
> don't seem to be causing problems. Ergo there is no problem (we're
> being _practical_ here, right?)

They are causing problems. They never stopped causing problems. None
of the above attempts to reduce rwlock starvation has been successful
in reducing it to untriggerable-in-the-field levels, and empirical
demonstrations of starvation recurring after those available at the
time of testing were put into place did in fact happen. Reduction of
frequency and making starvation more difficult to trigger are all that
they've achieved thus far.


William Lee Irwin III wrote:
>> Kevin Marin was the first to report this issue to lkml. I had seen
>> instances of it in internal corporate bugreports and it was one of
>> the motivators for the work I did on pidhashing (one of the causes
>> of the timeouts was worst cases in pid allocation). Manfred Spraul
>> and myself wrote patches attempting to reduce read-side hold time
>> in /proc/ algorithms, Ingo Molnar wrote patches to hierarchically
>> subdivide the /proc/ iterations, and Dipankar Sarma and Maneesh
>> Soni wrote patches to carry out the long iterations in /proc/ locklessly.
>> The last several of these affecting /proc/ have not gained acceptance,
>> though the work has not been halted in any sense, as this problem
>> recurs quite regularly. A considerable amount of sustained effort has
>> gone toward mitigating and resolving rwlock starvation.

On Sat, Nov 20, 2004 at 05:49:53PM +1100, Nick Piggin wrote:
> That's very nice. But there is no problem _now_, is there?

There is and has always been. All of the above merely mitigate the
issue, with the possible exception of the tasklist RCU patch, for
which I know of no testing results. Also note that almost none of
the work on /proc/ has been merged.


William Lee Irwin III wrote:
>> Aggravating the rwlock starvation destabilizes, not pessimizes,
>> and performance is secondary to stability.

On Sat, Nov 20, 2004 at 05:49:53PM +1100, Nick Piggin wrote:
> Well luckily we're not going to be aggravating the rwlock stavation.
> If you found a problem with, and fixed do_task_stat: ?time, ???_flt,
> et al, then you would apply the same solution to per thread rss to
> fix it in the same way.

You are aggravating the rwlock starvation by introducing gratuitous
full tasklist iterations. There is no solution to do_task_stat()
because it was recently introduced. There will be one as part of a port
of the usual mitigation patches when the perennial problem is reported
against a sufficiently recent kernel version, as usual. The already-
demonstrated problematic iterations have not been removed.


-- wli
