Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130683AbRCWMmP>; Fri, 23 Mar 2001 07:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130686AbRCWMmF>; Fri, 23 Mar 2001 07:42:05 -0500
Received: from [32.97.166.31] ([32.97.166.31]:5255 "EHLO prserv.net")
	by vger.kernel.org with ESMTP id <S130683AbRCWMl4>;
	Fri, 23 Mar 2001 07:41:56 -0500
Message-Id: <m14fqnB-001PKiC@mozart>
From: Rusty Russell <rusty@rustcorp.com.au>
To: Dawson Engler <engler@csl.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] question about functions that can fail 
In-Reply-To: Your message of "Mon, 19 Mar 2001 13:49:01 -0800."
             <200103192149.NAA29973@csl.Stanford.EDU> 
Date: Thu, 22 Mar 2001 09:09:21 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200103192149.NAA29973@csl.Stanford.EDU> you write:
>                            skb_queue_len	:	56	:	2:

skb_queue_len not being checked?  Look at these two places: either
your analysis has a bug, or there's some wierd code...

skb_push and skb_pull return the new skb data region, but have more
important side effects.  All these three can never error.

>                                get_tuple	:	44	:	5:

pcmcia code, or netfilter code?  netfilter code always checks...

>                                mod_timer	:	13	:	163:

This is OK.  Most people don't care if mod_timer had to delete the old
timer or not.

>                                del_timer	:	36	:	444:

Whether ignoring this is OK or not is tricky.  If del_timer returns
false, you either never added the timer, it has already finished, or
it is running *now* (SMP).  Hence touching the timer struct contents
after an unchecked del_timer is v. v. suspect, eg:

	del_timer(&mytimer);
	kfree(mytimer->data);

Or an unchecked del_timer in module unload.  del_timer_sync on the
other hand, is safe.

Keep up the great work!
Rusty.
--
Premature optmztion is rt of all evl. --DK
