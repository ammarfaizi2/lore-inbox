Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262278AbTEZWmn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 18:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262412AbTEZWmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 18:42:31 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:37583
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262278AbTEZWlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 18:41:32 -0400
Date: Tue, 27 May 2003 00:54:45 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: AA's 00_backout_gcc_3-0-patch-1
Message-ID: <20030526225445.GV3767@dualathlon.random>
References: <Pine.LNX.4.55L.0305261929460.30175@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55L.0305261929460.30175@freak.distro.conectiva>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 26, 2003 at 07:30:44PM -0300, Marcelo Tosatti wrote:
> 
> Andrea,
> 
> For what reason are you doing this?

yes, if you ask the gcc developers any piece of memory that will change
under gcc, despite gcc has no clue that it can change under it, MUST (in
RFC sense) be marked volatile.

this avoids possible crashes for example with a switch(xtime.tv_sec)
case 0,1,2,3,4 etc.. gcc could generate an hash to get the cases fast and
verify the xtime.tv_sec is <= 4 before derferencing tv_sec again. But
tv_sec could change under gcc and it would jump to random.

However with xtime itself, it would be very rare to get failures like
the above, we're not going to compare xtime that often in a gcc-crashing
way.

Still xtime is one obvious target for being marked volatile, and for
correctness I like it. Performance shouldn't matter.

Overall in kernel we disagreed to follow the MUST requrested by the gcc
developers, we often want to do comparisons of variables out of locks to
know if we need to take the lock and work on a garbage collection or
stuff like that and we for sure don't want to mark those variables
volatile since they must be cached and not spilled all the time, under
the locks. Linus as well was against using volatile for every piece of
memory that can change under gcc. The decision is been basically to
outsmart gcc in choosing if gcc has rights to generate kernel crashing
code or not. This makes kernel developement even more difficult since
you've to imagine whatever smart thing gcc can do with your not
serialized code to know if you're forced to mark the stuff volatile, but
it'll generate the very best performance.

As for xtime since it won't hurt performance, and since it's an obvious
volatile candidate I preferred to take the obviously safe approch. I
prefer to take the outsmart-gcc-optimizations way, only when it is
worthwhile.

> 
> diff -urN 2.4.6pre3/kernel/timer.c backoutgcc/kernel/timer.c
> --- 2.4.6pre3/kernel/timer.c	Wed Jun 13 04:02:52 2001
> +++ backoutgcc/kernel/timer.c	Wed Jun 13 15:49:13 2001
> @@ -32,7 +32,7 @@
>  long tick = (1000000 + HZ/2) / HZ;	/* timer interrupt period */
> 
>  /* The current time */
> -struct timeval xtime __attribute__ ((aligned (16)));
> +volatile struct timeval xtime __attribute__ ((aligned (16)));
> 
>  /* Don't completely fail for HZ > 500.  */
>  int tickadj = 500/HZ ? : 1;		/* microsecs */
> 


Andrea
