Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932466AbWEJSpK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932466AbWEJSpK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 14:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbWEJSpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 14:45:10 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:45484 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932466AbWEJSpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 14:45:09 -0400
Date: Wed, 10 May 2006 14:45:01 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Mark Hounschell <markh@compro.net>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: rt20 patch question
In-Reply-To: <446207D6.2030602@compro.net>
Message-ID: <Pine.LNX.4.58.0605101429100.22959@gandalf.stny.rr.com>
References: <446089CF.3050809@compro.net> <1147185483.21536.13.camel@c-67-180-134-207.hsd1.ca.comcast.net>
 <4460ADF8.4040301@compro.net> <Pine.LNX.4.58.0605100827500.3282@gandalf.stny.rr.com>
 <4461E53B.7050905@compro.net> <Pine.LNX.4.58.0605100938100.4503@gandalf.stny.rr.com>
 <446207D6.2030602@compro.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>
> So to my problem. What I mean by "the machine stops" is just that all
> indications of the mouse, keyboard, and vidio stop. Then in a few
> seconds will usually continue. At first I only saw problems when using
> ethernet in the emulation. I would telnet into the emulation from the
> linux box and do the equivalent of cat'ing a very large file. The
> machine will always "stop" somewhere randomly along the display. Then
> maybe continue on or maybe not. So I thought I might have a problem with
> my ethernet module. Then I noticed similar things with the SCSI module
> when accessing legacy scsi devices from within the emulation. Somtimes
> the whole machine doesn't stop. It would appear that only somethings
> have stopped. Like one or more of my I/O threads??
>
> I can only say for sure that I do not have these "stops" when running
> any other kernel or when running the rt20 kernel in any of the
> non-complete preemption modes.
>
> The only change that had to be made to this app for it to run at all on
> the rt20 kernel was insuring that the RTOM irq thread was at a higher
> priority than the CPU process/thread. Otherwise no signals were received
> from the RTOM.
>

(Working way to late! need to go home)

Mark, could you do the following for me.  I would really like to see what
is being scheduled, and when.  Could you apply the following patch:

http://www.kihontech.com/logdev/logdev-2.6.16-rt20.patch

Then do a "make oldconfig"  and answer the following questions:

Enable hooks for logdev device (LOGDEV_HOOKS) [N/y/?] (NEW) y
 Enable logdev device (LOGDEV) [M/n/y/?] (NEW) y
   Number of pages to allocate for logdev device (LOGDEV_PAGES) [256] (NEW)
   Logdev Multiple CPU buffers (LOGDEV_MULTI_CPUS) [N/y/?] (NEW) n
  Default Logdev prints should be enabled on startup (LOGDEV_PRINT_ENABLED) [Y/n/?] (NEW) n
  Default Logdev printing of context switches on startup (LOGDEV_SWITCH_ENABLED) [N/y/?] (NEW) n

So basically hit yes for the first two, and use whatever for the number of
pages.  And no to the rest.

This is a kernel ring buffer. But one of the things it records nicely is
scheduling switches.  The size of the ring buffer is defined by
LOGDEV_PAGES, and the bigger that is the more memory it will use.

Then make and install this kernel.

Then download: http://www.kihontech.com/logdev/logdev_tools-0.3.1.tar.bz2

Untar it and compile it with:

make KERNDIR=<path_to_kernel_dir_with_logdev_patch>/include


And then copy logread onto the machine that's running the kernel.

Boot into that kernel, and on this machine do:

# echo 1 > /proc/logdev/switch

Run your tests, and just after you see the machine freeze, do a

# echo 0 > /proc/logdev/switch

right away, otherwise the buffer might over flow.  Obviously you can't do
it while the machine is frozen, but it should be ok to do it as soon as
the machine is back up running.  You could just have a terminal up with
the echo ready, and when the machine freezes, hit enter, and hopefully the
buffered interrupt will go off after the machine is unfrozen.

Then do the

# ./logread > log.out

and email me privately, a compressed version of that log.out. It will show
nicely the scheduling that has taken placed:

ie.

[  614.937438] CPU:0 (posix_cpu_timer:2) -->> (softirq-timer/0:4)
[  614.937443] CPU:0 (softirq-timer/0:4) -->> (swapper:0)
[  614.938434] CPU:0 (swapper:0) -->> (posix_cpu_timer:2)
[  614.938436] CPU:0 (posix_cpu_timer:2) -->> (softirq-timer/0:4)
[  614.938438] CPU:0 (softirq-timer/0:4) -->> (swapper:0)
[  614.938777] CPU:0 (swapper:0) -->> (IRQ 11:710)


So at least I can see what is running on which CPU.

Thanks,

-- Steve

PS. Someday I plan to use relayfs as a backend and clean it up to perhaps
get this into the kernel.


