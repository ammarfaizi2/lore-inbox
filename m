Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264756AbTCCMUE>; Mon, 3 Mar 2003 07:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264761AbTCCMUE>; Mon, 3 Mar 2003 07:20:04 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:49926 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S264756AbTCCMUD>; Mon, 3 Mar 2003 07:20:03 -0500
Date: Mon, 3 Mar 2003 13:30:29 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: Nigel Cunningham <ncunningham@clear.net.nz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SWSUSP Discontiguous pagedir patch
Message-ID: <20030303123029.GC20929@atrey.karlin.mff.cuni.cz>
References: <1046487717.4616.22.camel@laptop-linux.cunninghams> <Pine.LNX.4.33.0303021731510.1120-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0303021731510.1120-100000@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Thus, I still think we can go with the patch I submitted before. I've
> > rediffed it against 2.5.63 (less the bits already applied).
> 
> I've spent the last week reading, reviewing, and rewriting major portions 
> of swsusp. I've actually been reasonably impressed, once I was able to get 
> the code into a much more readable state. 

:-).

> > diff -ruN linux-2.5.63/arch/i386/kernel/suspend.c linux-2.5.63-01/arch/i386/kernel/suspend.c
> > --- linux-2.5.63/arch/i386/kernel/suspend.c	2003-02-20 08:25:26.000000000 +1300
> > +++ linux-2.5.63-01/arch/i386/kernel/suspend.c	2003-02-20 08:27:36.000000000 +1300
> 
> Thank you for putting this back in C, it's much appreciated. 

Actually, it can not be put back in C. Manipulating stack pointer from
gcc inline assembly is just undefined. Its back in C so we can edit
it, but it needs to get back to assembly before merging with Linus.

> > +	for (loop=0; loop < nr_copy_pages; loop++) {
> > +		/* You may not call something (like copy_page) here: see above */
> > +		for (loop2=0; loop2 < PAGE_SIZE; loop2++) {
> > +			*(((char *)(PAGEDIR_ENTRY(pagedir_nosave,loop)->orig_address))+loop2) =
> > +				*(((char *)(PAGEDIR_ENTRY(pagedir_nosave,loop)->address))+loop2);
> > +			__flush_tlb();
> > +		}
> > +	}
> 
> This is better done as 
> 
> 	for (loop = 0; loop < nr_copy_pagse; loop++) {
> 		memcpy((char *)pagedir_nosave[loop].orig_address,
> 		       (char *)pagedir_nosave[loop].address,
> 		       PAGE_SIZE);
> 		__flush_tlb();
> 	}

Hehe, try it.

You may not do function call at this point, because you are
overwriting your stack. See mails with Andi Kleen. This *needs* to be
in assembly. 

> Is __flush_tlb() really necessary? 

Its there to prevent Heisenbugs.
								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
