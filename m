Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbVFOPIY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbVFOPIY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 11:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261158AbVFOPIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 11:08:24 -0400
Received: from one.firstfloor.org ([213.235.205.2]:50664 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261156AbVFOPIH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 11:08:07 -0400
To: Russ Anderson <rja@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RCF] Linux memory error handling
References: <200506151430.j5FEUD7J1393603@clink.americas.sgi.com>
From: Andi Kleen <ak@muc.de>
Date: Wed, 15 Jun 2005 17:08:05 +0200
In-Reply-To: <200506151430.j5FEUD7J1393603@clink.americas.sgi.com> (Russ
 Anderson's message of "Wed, 15 Jun 2005 09:30:13 -0500 (CDT)")
Message-ID: <m1is0faca2.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russ Anderson <rja@sgi.com> writes:

> 		[RCF] Linux memory error handling.

RCF? RFC?

>
> Summary: One of the most common hardware failures in a computer 
> 	is a memory failure.   There has been efforts in various
> 	architectures to support recover from memory errors.  This
> 	is an attempt to define a common support infrastructure
> 	in Linux to support memory error handling.

Yes that is badly needed. With rmap we can do much better than
we used to do. That code should be common though, not specific
to an architecture.

> 	Corrected error handling:
>
> 	    Logging:  When ECC hardware corrects a Single Bit Error (SBE),
> 		an interrupt is generated to inform linux that there is 
> 		a corrected error record available for logging.

I don't think it makes sense to commonize this - many platforms
want to log these errors to platform specific firmware logs (like
IA64 or PPC). Others who don't have such powerful firmware need
to do their own thing (like x86-64's mcelog). But I don't see much
commodiality. 

>
> 	    Polling Threshold:  A solid single bit error can cause a burst
> 		of correctable errors that can cause a significant logging
> 		overhead.  SBE thresholding counts the number of SBEs for
> 		a given page and if too many SBEs are detected in a given
> 		period of time, the interrupt is disabled and instead 
> 		linux periodically polls for corrected errors.

I don't see how this could be sanely done in common code. It is deeply
architecture specific.

>
> 	    Data Migration:  If a page of memory has too many single bit
> 		errors, it may be prudent to move the data off that
> 		physical page before the correctable SBE turns into an
> 		uncorrectable MBE. 

This should be common code indeed.

Similar for handling uncorrectable errors; e.g. swap the page 
in again from disk if possible or kill the application. That should
be imho all common code

I did a prototype of this some time ago, but ran out of time
and it wasn't that useful on my platform anyways so I gave it up. 

>
> 	    Memory handling parameters:
>
> 		Since memory failure modes are due to specific DIMM
> 		failure characteristics, there is will be no way to 
> 		reach agreement on one set of thresholds that will
> 		be appropriate for all configurations.  Therefore there
> 		needs to be a way to modify the thresholds.  One alternative
> 		is a /proc/sys/kernel/ interface to control settings, such
> 		as polling thresholds.  That provides an easy standard
> 		way of modifying thresholds to match the characteristics
> 		of the specific DIMM type.

This is deeply architecture and even platform specific.

>
> 	Uncorrected error handling:
>
> 	    Kill the application:  One recovery technique to avoid a kernel
> 		panic when an application process hits an uncorrectable 
> 		memory error is to SIGKILL the application.  The page is 
> 		marked PG_reserved to avoid re-use.  A (new) PG_hard_error
> 		flag would be useful to indicate that the physical page has
> 		a hard memory error.

No need for a new flag, just allocate it. This should be indeed common
code using the rmap infrastructure.

> 	    Disable memory for next reboot:  When a hard error is detected,
> 		notify SAL/BIOS of the bad physical memory.  SAL/BIOS can
> 		save the bad addresses and, when building the EFI map after
> 		reset/reboot, mark the bad pages as EFI_UNUSABLE_MEMORY,
> 		and type = 0, so Linux will ignore granules contains these 
> 		pages.

Deeply hardware specific.

> 	    Dumping:  Dump programs should not try to dump pages with bad
> 		memory.  A PG_hard_error flag would indicate to dump
> 		programs which pages have bad memory.

There is no dump program in mainline. I have no problem with the flag,
but for some reason the struct page bits seem to be very contended
and 32bit will run out of them in the forseeable future.

>
> 	Memory DIMM information & settings:
>
> 	    Use a /proc/dimm_info interface to pass DIMM information to Linux.
> 	    Hardware vendors could add their hardware specific settings.

I don't think it makes sense to put any of this in common code.

> 	Page Flags:  When a page is discarded, PG_reserved is set so that the
> 		page is no longer used.  A PG_hard_error flag could be added

That is not quite how PG_reserved works...

> 		to indicate the physical page has bad memory.
>
> 	Pseudo task switching:  Some architectures signal memory errors via
> 		non maskable interrupts, with unusual calling sequences into
> 		the OS.  It is often easier to process these non-maskable
> 		errors on a stack that is separate from the normal kernel
> 		stacks.  This requires non-blocking scheduler interfaces
> 		to obtain the current running task, to modify the pointer
> 		to the current running task and to reset that pointer when
> 		the memory error has been processed.


A "non blocking interface to obtain the current task"? aka "current"?

I sense some confusion here ;-)

Doing all the rmap process lookup etc. needed for the advanced handling
needs to take sleep locks. No way around that.

What I did in my x86-64 prototype to handle this was to raise a
"self interrupt" (kind of a IPI to the current CPU that would raise
next time interrupts were enabled or immediately in user space etc.)
and then in the self interrupt where you have a defined context
queue work for a CPU workqueue. The workqueue would then take
the mm locks and look up the processes mapping the page and kill
them etc.

Basically the trick is to keep the tricky fully lockless part
of the MCE handler as small as possible and "bootstrap" yourself
in multiple steps to a defined process context where you can use
the rest of the kernel sanely.

This implies the actual machine check is processed a bit later. That
is fine because near all CPUs seem to cause machine checks asynchronously
to the normal instruction stream anyways (so you are already "too late")
and adding a bit more delay is not too different. Trying to complicate
everything and processing the MCE immediately thus does not help too much.
For the common case of the MCE happening in user space it will be always
immediately after the exception anyways.

-Andi
