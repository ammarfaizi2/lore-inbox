Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262467AbUKLHGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262467AbUKLHGX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 02:06:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262470AbUKLHGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 02:06:23 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:1800 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262467AbUKLHGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 02:06:16 -0500
Date: Fri, 12 Nov 2004 08:06:12 +0100
From: Willy Tarreau <willy@w.ods.org>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_X86_PM_TIMER is slow
Message-ID: <20041112070611.GA12474@alpha.home.local>
References: <Pine.LNX.4.61.0411112143200.1846@twinlark.arctic.org> <20041112060413.GF783@alpha.home.local> <Pine.LNX.4.61.0411112208180.24919@twinlark.arctic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0411112208180.24919@twinlark.arctic.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2004 at 10:16:27PM -0800, dean gaudet wrote:
> On Fri, 12 Nov 2004, Willy Tarreau wrote:
> 
> > On Thu, Nov 11, 2004 at 09:52:27PM -0800, dean gaudet wrote:
> > > when using CONFIG_X86_PM_TIMER i'm finding that gettimeofday() calls take 
> > > 2.8us on a p-m 1.4GHz box... which is an order of magnitude slower than 
> > > TSC-based solutions.
> > > 
> > > on one workload i'm seeing a 7% perf improvement by booting "acpi=off" to 
> > > force it to use tsc instead of the PM timer... (the workload calls 
> > > gettimeofday too frequently, but i can't change that).
> > 
> > I did not test, this might be interesting.
> > In fact, what would be very good would be sort of a new select/poll/epoll
> > syscalls with an additional argument, which would point to a structure
> > that the syscall would fill in return with the time of day. This would
> > greatly reduce the number of calls to gettimeofday() in some programs,
> > and make use of the time that was used by the syscall itself.
> > 
> > For example, if I could call it like this, it would be really cool :
> > 
> >    ret = select_absdate(&in, &out, &excp, &date_timeout, &return_date);
> 
> but the overhead isn't the syscall :)  it's the pm timer itself... the 
> program below reads the pm timer the same way the kernel does and you can 
> see it takes 2.5us to read it...

Sorry, what I meant is that if the select() did filled the structure itself,
it would avoid a supplementary call (syscall+hw access). And I'm certain
that select() accesses the same information at some time.

> # cc -O2 -g -Wall readport.c -o readport
> # grep PM-Timer /var/log/dmesg
> ACPI: PM-Timer IO Port: 0xd808
> # time ./readport 0xd808 1000000
> ./readport 0xd808 1000000  2.54s user 0.00s system 100% cpu 2.526 total
>
> the gettimeofday overhead is dominated by this i/o...

Indeed, this is much !

>         /* It has been reported that because of various broken
>          * chipsets (ICH4, PIIX4 and PIIX4E) where the ACPI PM time
>          * source is not latched, so you must read it multiple
>          * times to insure a safe value is read.
>          */
>         do {
>                 v1 = inl(pmtmr_ioport);
>                 v2 = inl(pmtmr_ioport);
>                 v3 = inl(pmtmr_ioport);
>         } while ((v1 > v2 && v1 < v3) || (v2 > v3 && v2 < v1)
>                         || (v3 > v1 && v3 < v2));

Just a thought : have you tried to check whether it's the recovery time
after a read or read itself which takes time ? I mean, perhaps one read
would take, say 50 ns, but two back-to-back reads will take 2 us. If
this is the case, having a separate function with only one read for
non-broken chipsets will be better because there might be no particular
reasons to check the counter that often.

Other thought : is it possible to memory-map this timer to avoid the slow
inl() on x86 ?

Regards,
Willy

