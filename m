Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267767AbSLTKTK>; Fri, 20 Dec 2002 05:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267771AbSLTKTJ>; Fri, 20 Dec 2002 05:19:09 -0500
Received: from packet.digeo.com ([12.110.80.53]:16528 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267767AbSLTKTG>;
	Fri, 20 Dec 2002 05:19:06 -0500
Message-ID: <3E02F073.BF57207C@digeo.com>
Date: Fri, 20 Dec 2002 02:26:59 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: george anzinger <george@mvista.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH]Timer list init is done AFTER use
References: <3E02D81F.13A5A59D@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Dec 2002 10:27:03.0537 (UTC) FILETIME=[56966610:01C2A812]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger wrote:
> 
> On SMP systems the timer list init is done by way of a
> cpu_notifier call.  This has two problems:
> 
> 1.) Timers are started WAY before the cpu_notifier call
> chain is executed.  In particular the console blanking timer
> is deleted and inserted every time printk() is called.  That
> this does not fail is only because the kernel has yet to
> protect location zero.

But init_timers() directly calls timer_cpu_notify(), which directly
calls init_timers_cpu().

So your patch appears to be a no-op for the boot CPU.
 
> 2.) This notifier is called when a cpu comes up.  I suspect
> that initializing the timer list when a hot swap of a cpu is
> done is NOT the right thing to do.  In any case, if this is
> a desired action, the list still needs to be initialized
> prior to its use.

It should be OK as-is?  The CPU_UP_PREPARE callout is performed
before the secondary starts doing things.  Its timers are initialised.
 
> The attached patch initializes all the timer lists at
> init_timers time and does not put code in the notify list.

But the patch assumes that the per-cpu data exists for all CPUs - even
the !cpu_possible() ones.

This is true at present.  But the intent here is that the per-cpu
storage be allocated as the CPUs come up, and in their node-local
memory.  That saves memory and presumably having the cpu-local timers
in the cpu-local memory is a good thing.

I have working code which did all that, but it sort-of got lost
because there was a lot going on at the time.


Have you actually observed any problem?
