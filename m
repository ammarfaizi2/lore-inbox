Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281255AbSAETuR>; Sat, 5 Jan 2002 14:50:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273261AbSAETt5>; Sat, 5 Jan 2002 14:49:57 -0500
Received: from cs182172.pp.htv.fi ([213.243.182.172]:28549 "EHLO
	cs182172.pp.htv.fi") by vger.kernel.org with ESMTP
	id <S280725AbSAETtr>; Sat, 5 Jan 2002 14:49:47 -0500
Message-ID: <3C3758B3.9A84693C@welho.com>
Date: Sat, 05 Jan 2002 21:49:07 +0200
From: Mika Liljeberg <Mika.Liljeberg@welho.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@elte.hu
CC: Davide Libenzi <davidel@xmailserver.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [announce] [patch] ultra-scalable O(1) SMP and UP scheduler
In-Reply-To: <Pine.LNX.4.33.0201051232020.2542-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> this method of 'global RT tasks' has the following practical advantage: it
> reduces the statistical scheduling latency of RT tasks better than any
> other solution, because the scheduler *cannot* know in advance which CPU
> will be able to get the RT task first. Think about it, what if the CPU,
> that appears to be the least busy for the scheduler, happens to be
> spinning within some critical section? The best method is to let every CPU
> go into the scheduler as fast as possible, and let the fastest one win.

Well, different RT tasks have different requirements and when multiple
RT tasks are competing for the CPUs it gets more interesting. For
instance, suppose that I have the MAC protocol for a software radio
running on a dedicated CPU, clocking out a radio frame every 1 ms with
very high time synchronization requirements. For this application I
definately don't want my CPU suddenly racing to the door to see why the
doorbell rang. :) This seems to suggest that it should be possible for a
task to make itself non-interruptible, in which case it would not even
receive reschedule IPIs for the global RT tasks.

It also seems to me that when the number of CPUs gets higher, the
average latency improvent gained for each additional CPU gets less and
less. Perhaps for SMP systems with a high number of CPUs it would be
more scalable to only interrupt a subset of the CPUs for the RT tasks in
the global queue.

> George Anzinger @ Montavista has suggested the following extension to this
> concept: besides having such global RT tasks, for some RT usages it makes
> sense to have per-CPU 'affine' RT tasks. I think that makes alot of sense
> as well, because if you care more about scalability than latencies, then
> you can still flag your process to be 'CPU affine RT task', which wont be
> included in the global queue, and thus you wont see the global locking
> overhead and 'CPUs racing to run RT tasks'. I have reserved some priority
> bitspace for such purposes.

This sounds like the very thing, although I think that key word here is
"non-interruptible" rather than just "CPU-affine". If this is what you
meant, I apologize for wasting everybody's time.

Regards,

	MikaL
