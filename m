Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263105AbSLTRKm>; Fri, 20 Dec 2002 12:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262924AbSLTRKm>; Fri, 20 Dec 2002 12:10:42 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:25327 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S262824AbSLTRKg>;
	Fri, 20 Dec 2002 12:10:36 -0500
Message-ID: <3E0350CA.6B99F722@mvista.com>
Date: Fri, 20 Dec 2002 09:18:02 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH]Timer list init is done AFTER use
References: <3E02D81F.13A5A59D@mvista.com> <3E02F073.BF57207C@digeo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> george anzinger wrote:
> >
> > On SMP systems the timer list init is done by way of a
> > cpu_notifier call.  This has two problems:
> >
> > 1.) Timers are started WAY before the cpu_notifier call
> > chain is executed.  In particular the console blanking timer
> > is deleted and inserted every time printk() is called.  That
> > this does not fail is only because the kernel has yet to
> > protect location zero.
> 
> But init_timers() directly calls timer_cpu_notify(), which directly
> calls init_timers_cpu().
> 
> So your patch appears to be a no-op for the boot CPU.

That is correct.  The problem is when cpu_init is called for
the secondary cpus.  It almost immediately calls printk. 
You can put a break point here, wait for the second entry
and then in mod_timer.  You will see that mod_timer grabs
the "base" for the second cpu which is not initialized. 
> 
> > 2.) This notifier is called when a cpu comes up.  I suspect
> > that initializing the timer list when a hot swap of a cpu is
> > done is NOT the right thing to do.  In any case, if this is
> > a desired action, the list still needs to be initialized
> > prior to its use.
> 
> It should be OK as-is?  The CPU_UP_PREPARE callout is performed
> before the secondary starts doing things.  Its timers are initialised.

Yes, but not really.  As noted, the timers are called as a
result of printk. (I use a standard pc for this so the
console is on the standard pc tube.  I don't know about
other consoles...)  My comments here are a wonderment if
this is the right thing to do when doing a hot swap of the
cpu.  I sort of doubt that this is correct.
> 
> > The attached patch initializes all the timer lists at
> > init_timers time and does not put code in the notify list.
> 
> But the patch assumes that the per-cpu data exists for all CPUs - even
> the !cpu_possible() ones.

True.
> 
> This is true at present.  But the intent here is that the per-cpu
> storage be allocated as the CPUs come up, and in their node-local
> memory.  That saves memory and presumably having the cpu-local timers
> in the cpu-local memory is a good thing.
> 
I agree.  It is possible that we may want to hold off
printks until the cpu is up.  There is a stub to do this,
but it is a nop on the i386.

> I have working code which did all that, but it sort-of got lost
> because there was a lot going on at the time.
> 
> Have you actually observed any problem?

Yes, with my High-res-timers patch (all 4 of them) with
CONFIG_HIGH_RES turned off fails to boot.  I traced the
timer insert as I suggested above and it somehow gets away
with writing into *NULL.  I am not sure how this happens,
but when I ask KGDB to read it back, it also is able to read
it.  The inserted timer (this is on an unpatched system,
i.e. no high-res or anything but the kgdb patch) looks like
this:
(gdb) p *timer
$13 = {entry = {next = 0xc11455b8, prev = 0x0}, expires =
605082, lock = {
    lock = 1}, magic = 1267182958, function = 0xc01d8510
<blank_screen>, 
  data = 0, base = 0x0}

The base of 0 is ok as that is updated after the insert by
mod_timer.  The prev =0, however is not cool.

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
