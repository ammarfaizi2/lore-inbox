Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263205AbUBKAyK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 19:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263475AbUBKAyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 19:54:10 -0500
Received: from fw.osdl.org ([65.172.181.6]:53668 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263205AbUBKAyG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 19:54:06 -0500
Date: Tue, 10 Feb 2004 16:55:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: Darren Williams <dsw@gelato.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: Re: [TRIVIAL patch] 2.6.2-rc2 Remove compile warnings from timer.o
Message-Id: <20040210165534.3bdc22e3.akpm@osdl.org>
In-Reply-To: <20040211003913.GC15247@cse.unsw.EDU.AU>
References: <20040211003913.GC15247@cse.unsw.EDU.AU>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Darren Williams <dsw@gelato.unsw.edu.au> wrote:
>
> 
> To allow the ia64 simulator to run correctly on slower machines
> the value of HZ has been defined as 32, this has introduced a compiler
> warning (not that much of issue):
> kernel/timer.c: In function `second_overflow':
> kernel/timer.c:589: warning: right shift count is negative
> kernel/timer.c:592: warning: right shift count is negative
> 
> I asked if the value of HZ could be increased for the simulator in 
> include/asm-ia64/param.h, 
> which was rejected for reasons below.

Well we really should be able to support values lower than 32 anyway - just
from a quality-of-code point of view.

I do recall once spying a piece of code which would cause a div-by-zero if
HZ was set to less than 50.  These things happen.

>      ltemp = time_freq + pps_freq;
> +    
> +#if (SHIFT_SCALE <= (SHIFT_USEC + SHIFT_HZ))
>      if (ltemp < 0)
>  	time_adj -= -ltemp >>
>  	    (SHIFT_USEC + SHIFT_HZ - SHIFT_SCALE);
>      else
>  	time_adj += ltemp >>
>  	    (SHIFT_USEC + SHIFT_HZ - SHIFT_SCALE);
> +	    
> +#else	/* (SHIFT_SCALE > (SHIFT_USEC + SHIFT_HZ)) */
> +    if (ltemp < 0)
> +	time_adj -= -ltemp >> SHIFT_SCALE;
> +    else
> +	time_adj += ltemp >> SHIFT_SCALE;
> +	    
> +#endif /* (SHIFT_SCALE > (SHIFT_USEC + SHIFT_HZ)) */

You should lose the ifdefs.  Just do:

	if (SHIFT_SCALE <= (SHIFT_USEC + SHIFT_HZ)) {
		if (ltemp < 0)
			time_adj -= -ltemp >>
				(SHIFT_USEC + SHIFT_HZ - SHIFT_SCALE);
		else
			time_adj += ltemp >>
				(SHIFT_USEC + SHIFT_HZ - SHIFT_SCALE);
	}
	...

because

a) It is not revolting and

b) The compiler checks the unused code for you, then throws it away.



