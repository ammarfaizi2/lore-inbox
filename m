Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262653AbSJTOWU>; Sun, 20 Oct 2002 10:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262670AbSJTOWT>; Sun, 20 Oct 2002 10:22:19 -0400
Received: from 2-136.ctame701-1.telepar.net.br ([200.193.160.136]:46825 "EHLO
	2-136.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S262653AbSJTOWS>; Sun, 20 Oct 2002 10:22:18 -0400
Date: Sun, 20 Oct 2002 12:28:02 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Jim Houston <jim.houston@attbi.com>
cc: linux-kernel@vger.kernel.org, <mingo@elte.hu>, <andrea@suse.de>,
       <jim.houston@ccur.com>, <akpm@digeo.com>, <conman@kolivas.net>
Subject: Re: [PATCH] Re: Pathological case identified from contest
In-Reply-To: <200210200319.g9K3J5s07242@linux.local>
Message-ID: <Pine.LNX.4.44L.0210201214010.22993-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Oct 2002, Jim Houston wrote:

> 	I'm punishing processes that actually get to run rather
> 	than rewarding proceses that sleep.

Sounds good...

>  static inline unsigned int task_timeslice(task_t *p)
>  {
> -	return BASE_TIMESLICE(p);
> +	/*
> +	 * The more favorable priority the shorter the time slice.
> +	 * For 100 Hz clock this gives a range 10 - 191 ms.
> +	 * For 1000 Hz clock this gives 1 - 157 ms.
> +	 */
> +	if (HZ > 100)
> +		return(((p)->prio - MAX_RT_PRIO)*4 + 1);
> +	else
> +		return(((p)->prio - MAX_RT_PRIO)/2 + 1);
>  }

It'd be fun if this code also worked for values of HZ not
equal to 100 or 1000.  Better put HZ somewhere in this
calculation and make it HZ-independant.

> + * The rq->prio_ind is used to raise/rotate the priority of all of the
> + * processes in the run queue.  I know this  sounds like a pyramid scheme.
> + * This increase in priority is balanced by two feedback mechanisms.
> + * First processes which consume there timeslice are moved to a lower
> + * priority queue.  To continue the pyramid analogy we make the time
> + * slice smaller for more favorable priorities.

Sounds like a good strategy, at least in theory.  I suspect
it'll balance itself well enough to also work in practice.

> + * The rotate_rate is the rate at which the priorities of processes
> + * in the run queue increase.  With the initial HZ/10 guess a process
> + * will go from the worst dynamic priority to the best in 4 seconds.

How long does it take for a best priority process to go
down ?

Or, for how much time can a newly started CPU hog starve
an older process ?   This is important to know since eg.
a newly started Mozilla could starve an already running
movie player.

> +	if (HZ > 100) {
> +		hl = 2000;	/* half life of 2 seconds at HZ=1000 */
> +		as = -23;	/* 64*1024*log(0.5)/hl */
> +	} else {
> +		hl = 200;	/* half life of 2 seconds at HZ=100 */
> +		as = -229;	/* 64*1024*log(0.5)/hl */
> +	}

Same comment as before, HZ > 100 doesn't mean that HZ == 1000 ;)

I'm about to be dragged off to lunch now, so I haven't looked in
detail at the rest of this function. Not yet, at least.

kind regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://distro.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

