Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317852AbSHPBK4>; Thu, 15 Aug 2002 21:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317855AbSHPBK4>; Thu, 15 Aug 2002 21:10:56 -0400
Received: from [195.223.140.120] ([195.223.140.120]:27461 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S317852AbSHPBKz>; Thu, 15 Aug 2002 21:10:55 -0400
Date: Fri, 16 Aug 2002 01:54:59 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Pavel Machek <pavel@elf.ucw.cz>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
Subject: aio-core why not using SuS? [Re: [rfc] aio-core for 2.5.29 (Re: async-io API registration for 2.5.29)]
Message-ID: <20020815235459.GG14394@dualathlon.random>
References: <1028223041.14865.80.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0208010924050.14765-100000@home.transmeta.com> <20020801140112.G21032@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020801140112.G21032@redhat.com>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2002 at 02:01:12PM -0400, Benjamin LaHaise wrote:
> On Thu, Aug 01, 2002 at 09:30:04AM -0700, Linus Torvalds wrote:
> > Absolutely. I think "jiffies64" is fine (as long as is it converted to
> > some "standard" time-measure like microseconds or nanoseconds so that
> > people don't have to care about internal kernel state) per se.
> 
> Hmmm, it almost sounds like implementing clock_gettime as a syscall and 
> exporting jiffies as CLOCK_MONOTONIC is the way to go, as that gives a 
> nanosecond resolution export of jiffies.  Then, it would make sense to 
> use that as the basis for "when" timeouts.  Relative timeouts still have 
> a certain simplicity to them that is appealing, though.

this is all about reducing the latency window between the read of the
gettimeofday in userspace and the "add_timer" executed by the aio
syscall. But there will always be a window, because every timer is
programmed as a "timeout" not as an absolute time. And most important as
said in my previous email (no matter of the jiffies64 to userspace or
similar non second-unit) you will always need some gettimeofday (or
clock_gettime) in userspace too to detect if your program can keep up
with the load or if you're constantly running out of time. And as soon
as you run gettimeofday into userspace, you run in a similar window to
the one that you try to decrease (i.e.  scheduling). Of course making
the window a kernel window inside a preempt_disable and a __cli() will
have a goodness effect in a number of cases, but I don't think it
matters significantly because you still need some gettimeofday in
userspace (or clock_gettime if that matters, clock_gettime infact is
even worse than gettimeofday due its certainly lower resolution).

Last but not the least the SuS specifications only contemplate a
timeout. So we couldn't take advantage of the "absolute time" (either in
second or jiffies64 units) from userspace unless you run into a non
standard user (not kernel) API.

Now reading the SuS specifications I also like less and less our current
kernel API of this sumbit_io, the SuS does exactly what I suggested
originally that is aio_read/aio_write/aio_fsync as separate calls. So
the merging effect mentioned by Ben cannot be taken advantage of by the
kernel anyways because userspace will issue separate calls for each
command.

See the SuS API:

	http://www.opengroup.org/onlinepubs/007908799/xsh/aio.h.html

Can you please explain why you did a completely different kernel API and
you force glibc to wrap the whole thing internally on top of your
different kernel API? Wouldn't it be much simpler to use the clean SuS
API for the kernel too like we do for everything else? Do you expect
programmers to ignore completely the aio.h in glibc? I really like the
aio.h in glibc to be the default used by the programmers so we follow
a standard, and glibc should then rely on kernel to execute those
functions efficiently (instead of using threads). Or is something
foundamental missing (i.e. not doable) in the SuS API and so we're
forced to take a completely different route to provide the features we
need? I only had a short look at the SuS aio API so far and it seems to
provide the same functionalities at least in the most important paths.
In short the SuS API looks good to me and I don't see why we aren't
implementing it stright with kernel support (doing it in kernel will
also be faster because even if we may still implement the main I/O point
as a submit_io() function, wrappers in kernel code will runs faster, and
having a aio_abi.h that basically matches the glibc aio.h looks much
cleaner than having this current aio_abi.h intermediate thing that glibc
needs to wrap around).

Raising this question isn't in my interest because if somebody agrees
with me, this will delay further the registration of an API and that's a
problem, but I feel doing the right thing in raising it anyways just to
be sure this issue it's not ignored (I'll be very happy to hear that my
suggestion to implement the SuS API in the kernel is flawed for some
reason :). Otherwise if somebody agrees with me I'll do my best to avoid
adding delays despite we may choose to rewrite the API completely.

BTW, regardless if we want to make the kernel API match the user API
(like I think would be natural thing to do rather than having this
special kernel API), I really would like to have "a" kernel API
registered in 2.5 ASAP, otherwise I'll be forced to start using the
dynamic syscall too and I much prefer to spend my time doing useful
things instead. If no patch returns floating around for submission in
2.5 I will send new patches myself again.

Comments are welcome, (I will probably be offline until 20 August, so
replies aren't very urgent), thanks!

Andrea
