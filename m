Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268383AbTCFUfm>; Thu, 6 Mar 2003 15:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268386AbTCFUfl>; Thu, 6 Mar 2003 15:35:41 -0500
Received: from packet.digeo.com ([12.110.80.53]:6130 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S268383AbTCFUe4>;
	Thu, 6 Mar 2003 15:34:56 -0500
Date: Thu, 6 Mar 2003 12:42:57 -0800
From: Andrew Morton <akpm@digeo.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: rml@tech9.net, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
Message-Id: <20030306124257.4bf29c6c.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0303051910380.1429-100000@home.transmeta.com>
References: <20030228202555.4391bf87.akpm@digeo.com>
	<Pine.LNX.4.44.0303051910380.1429-100000@home.transmeta.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Mar 2003 20:42:58.0243 (UTC) FILETIME=[F8B40930:01C2E420]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> wrote:
>
> 
> ===== kernel/sched.c 1.161 vs edited =====
> --- 1.161/kernel/sched.c	Thu Feb 20 20:33:52 2003
> +++ edited/kernel/sched.c	Wed Mar  5 19:09:45 2003
> @@ -337,8 +337,15 @@
>  		 * boost gets as well.
>  		 */
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
>  	}
>  	enqueue_task(p, array);

This improves the X interactivity tremendously.  I went back to 2.5.64 base
just to verify, and the difference was very noticeable.

The test involved doing the big kernel compile while moving large xterm,
mozilla and sylpheed windows about.  With this patch the mouse cursor was
sometimes a little jerky (0.1 seconds, perhaps) and mozilla redraws were
maybe 0.5 seconds laggy.

So.  A big thumbs up on that one.  It appears to be approximately as
successful as sched-2.5.64-a5.

Ingo's combo patch is better still - that is sched-2.5.64-a5 and your patch
combined (yes?).  The slight mouse jerkiness is gone and even when doing
really silly things I cannot make it misbehave at all.  I'd handwavingly
describe both your patch and sched-2.5.64-a5 as 80% solutions, and the combo
95%.


So I'm a happy camper, and will be using Ingo's combo patch.  But I do not
use XMMS and xine and things like that - they may be running like crap with
these patches.  I do not know, and I do not have a base to compare against
even if I could work out how to get them going.


I did spend a bit of time a while back trying to come up with some
combination of tests which would exhibit this problem, and which would allow
it to be measured and tweaked.  It was unsuccessful - the peculiar
combination of a compilation and X seems to bring it out.


