Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132242AbRACFsj>; Wed, 3 Jan 2001 00:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132267AbRACFsa>; Wed, 3 Jan 2001 00:48:30 -0500
Received: from www.wen-online.de ([212.223.88.39]:61188 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S132242AbRACFsR>;
	Wed, 3 Jan 2001 00:48:17 -0500
Date: Wed, 3 Jan 2001 06:17:45 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: Roger Larsson <roger.larsson@norran.net>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <andrewm@uow.edu.au>
Subject: Re: scheduling problem?
In-Reply-To: <01010303393503.01851@dox>
Message-ID: <Pine.Linu.4.10.10101030557060.1075-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jan 2001, Roger Larsson wrote:

> Hi,
> 
> I have played around with this code previously.
> This is my current understanding.
> [yield problem?]

Hmm.. this ~could be.  I once dove into the VM waters (me=stone)
and changed __alloc_pages() to only yield instead of scheduling.
The results (along with many other strange changes) were.. weirdest
feeling kernel I ever ran.  Damn fast, but very very weird ;-)

> Possible (in -prerelease) untested possibilities.
> 
> * Be tougher when yielding.
> 
> 
>  	wakeup_kswapd(0);
> 	if (gfp_mask & __GFP_WAIT) {
> 		__set_current_state(TASK_RUNNING);
> 		current->policy |= SCHED_YIELD;
> +               current->counter--; /* be faster to let kswapd run */
> or
> +               current->counter = 0; /* too fast? [not tested] */
> 		schedule();
> 	}

That looks a lot like cheating.

> * Move wakeup of bflushd to kswapd. Somewhere after 'do_try_to_free_pages(..)'
>   has been run. Before going to sleep... 
>   [a variant tested with mixed results - this is likely a better one]

I also did some things along this line.. also with mixed results.

:) the changes I've done that I actually like best is to kill bdflush
graveyard dead.  Did that twice and didn't miss it at all.  (next time,
I think I'll erect a headstone)

	-Mike

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
