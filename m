Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261709AbUKTGuq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261709AbUKTGuq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 01:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbUKTGum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 01:50:42 -0500
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:3164 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261721AbUKTGuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 01:50:07 -0500
Message-ID: <419EE911.20205@yahoo.com.au>
Date: Sat, 20 Nov 2004 17:49:53 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Linus Torvalds <torvalds@osdl.org>, Christoph Lameter <clameter@sgi.com>,
       akpm@osdl.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Hugh Dickins <hugh@veritas.com>, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V11 [0/7]: overview
References: <Pine.LNX.4.58.0411190704330.5145@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0411191155180.2222@ppc970.osdl.org> <20041120020306.GA2714@holomorphy.com> <419EBBE0.4010303@yahoo.com.au> <20041120035510.GH2714@holomorphy.com> <419EC205.5030604@yahoo.com.au> <20041120042340.GJ2714@holomorphy.com> <419EC829.4040704@yahoo.com.au> <20041120053802.GL2714@holomorphy.com> <419EDB21.3070707@yahoo.com.au> <20041120062341.GM2714@holomorphy.com>
In-Reply-To: <20041120062341.GM2714@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> William Lee Irwin III wrote:
> 
>>>There isn't anything left to explain. So if there's a question, be
>>>specific about it.
> 
> 
> On Sat, Nov 20, 2004 at 04:50:25PM +1100, Nick Piggin wrote:
> 
>>Why am I very very wrong? Why won't touch_nmi_watchdog work from
>>the read loop?
>>And let's just be nice and try not to jump at the chance to point
>>out when people are very very wrong, and keep count of the times
>>they have been very very wrong. I'm trying to be constructive.
> 
> 
> touch_nmi_watchdog() is only "protection" against local interrupt
> disablement triggering the NMI oopser because alert_counter[]
> increments are not atomic. Yet even supposing they were made so, the

That would be a bug in touch_nmi_watchdog then, because you're
racy against your own NMI too.

So I'm actually not very very wrong at all. I'm technically wrong
because touch_nmi_watchdog has a theoretical 'bug'. In practice,
multiple races with the non atomic increments to the same counter,
and in an unbroken sequence would be about as likely as hardware
failure.

Anyway, this touch nmi thing is going off topic, sorry list.

> net effect of "covering up" this gross deficiency is making the
> user-observable problems it causes undiagnosable, as noted before.
> 

Well the loops that are in there now aren't covered up, and they
don't seem to be causing problems. Ergo there is no problem (we're
being _practical_ here, right?)

> 
> William Lee Irwin III wrote:
> 
>>>This entire line of argument is bogus. A preexisting bug of a similar
>>>nature is not grounds for deliberately introducing any bug.
> 
> 
> On Sat, Nov 20, 2004 at 04:50:25PM +1100, Nick Piggin wrote:
> 
>>Sure, if that is a bug and someone is just about to fix it then
>>yes you're right, we shouldn't introduce this. I didn't realise
>>it was a bug. Sounds like it would be causing you lots of problems
>>though - have you looked at how to fix it?
> 
> 
> Kevin Marin was the first to report this issue to lkml. I had seen
> instances of it in internal corporate bugreports and it was one of
> the motivators for the work I did on pidhashing (one of the causes
> of the timeouts was worst cases in pid allocation). Manfred Spraul
> and myself wrote patches attempting to reduce read-side hold time
> in /proc/ algorithms, Ingo Molnar wrote patches to hierarchically
> subdivide the /proc/ iterations, and Dipankar Sarma and Maneesh
> Soni wrote patches to carry out the long iterations in /proc/ locklessly.
> 
> The last several of these affecting /proc/ have not gained acceptance,
> though the work has not been halted in any sense, as this problem
> recurs quite regularly. A considerable amount of sustained effort has
> gone toward mitigating and resolving rwlock starvation.
> 

That's very nice. But there is no problem _now_, is there?

> Aggravating the rwlock starvation destabilizes, not pessimizes,
> and performance is secondary to stability.
> 

Well luckily we're not going to be aggravating the rwlock stavation.

If you found a problem with, and fixed do_task_stat: ?time, ???_flt,
et al, then you would apply the same solution to per thread rss to
fix it in the same way.
