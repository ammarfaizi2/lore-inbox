Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268144AbTCFRDU>; Thu, 6 Mar 2003 12:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268147AbTCFRDU>; Thu, 6 Mar 2003 12:03:20 -0500
Received: from mx2.elte.hu ([157.181.151.9]:17071 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S268144AbTCFRDG>;
	Thu, 6 Mar 2003 12:03:06 -0500
Date: Thu, 6 Mar 2003 18:13:20 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@digeo.com>, Robert Love <rml@tech9.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
In-Reply-To: <Pine.LNX.4.44.0303051910380.1429-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0303060857380.4511-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 5 Mar 2003, Linus Torvalds wrote:

>  		p->sleep_avg += sleep_time;
> -		if (p->sleep_avg > MAX_SLEEP_AVG)
> +		if (p->sleep_avg > MAX_SLEEP_AVG) {
> +			int ticks = p->sleep_avg - MAX_SLEEP_AVG + current->sleep_avg;
>  			p->sleep_avg = MAX_SLEEP_AVG;
> +			if (ticks > MAX_SLEEP_AVG)
> +				ticks = MAX_SLEEP_AVG;
> +			if (!in_interrupt())
> +				current->sleep_avg = ticks;
> +		}
> +			
>  		p->prio = effective_prio(p);

interesting approach, but it has one problem which so far i tried to
avoid: it makes it too easy for a process to gain a bonus. Until now
pretty much the only way to get an interactive bonus was to actually
sleep. Another rule was that interactivity is kept constant, ie. the only
'source' of interactivity was passing time, not some artificial activity
performed by any process. Even the timeslice passing across fork()/exit()  
is controlled carefully to maintain the total sum of timeslices.

With the above code it's enough to keep a single helper thread around
which blocks on a pipe, to create an almost endless source of
interactivity bonus. And does not even have to be 'deliberate' - there's
tons of code that just waits for a CPU-bound task to finish (eg. 'make'
waiting for gcc to finish), and which processes/threads have a maximum
boost already, in which case the interactivity boost is not justified.

Anyway, Andrew, could you give Linus' patch a go as well?

	Ingo


