Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261211AbVFOQgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbVFOQgq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 12:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbVFOQgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 12:36:46 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:30694 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261211AbVFOQgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 12:36:37 -0400
From: Russ Anderson <rja@sgi.com>
Message-Id: <200506151636.j5FGaSXG1433860@clink.americas.sgi.com>
Subject: Re: [RCF] Linux memory error handling
To: ak@muc.de (Andi Kleen)
Date: Wed, 15 Jun 2005 11:36:28 -0500 (CDT)
Cc: rja@sgi.com (Russ Anderson), linux-kernel@vger.kernel.org
In-Reply-To: <m1is0faca2.fsf@muc.de> from "Andi Kleen" at Jun 15, 2005 05:08:05 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Russ Anderson <rja@sgi.com> writes:
> 
> > 		[RCF] Linux memory error handling.
> 
> RCF? RFC?

(sigh) RFC.  I ran the document through the spellchecker and
still missed the first three letters. 

> > Summary: One of the most common hardware failures in a computer 
> > 	is a memory failure.   There has been efforts in various
> > 	architectures to support recover from memory errors.  This
> > 	is an attempt to define a common support infrastructure
> > 	in Linux to support memory error handling.
> 
> Yes that is badly needed. With rmap we can do much better than
> we used to do. That code should be common though, not specific
> to an architecture.
>
> > 	Corrected error handling:
> >
> > 	    Logging:  When ECC hardware corrects a Single Bit Error (SBE),
> > 		an interrupt is generated to inform linux that there is 
> > 		a corrected error record available for logging.
> 
> I don't think it makes sense to commonize this - many platforms
> want to log these errors to platform specific firmware logs (like
> IA64 or PPC). Others who don't have such powerful firmware need
> to do their own thing (like x86-64's mcelog). But I don't see much
> commodiality. 

Sure.  It should only be common code when it makes sense.

> > 	    Polling Threshold:  A solid single bit error can cause a burst
> > 		of correctable errors that can cause a significant logging
> > 		overhead.  SBE thresholding counts the number of SBEs for
> > 		a given page and if too many SBEs are detected in a given
> > 		period of time, the interrupt is disabled and instead 
> > 		linux periodically polls for corrected errors.
> 
> I don't see how this could be sanely done in common code. It is deeply
> architecture specific.

This is what could be used to trigger the data migration (common) code.
It's the interface from arch specific to common code that has pushed
me from linux-ia64 to lkml.

> > 	    Data Migration:  If a page of memory has too many single bit
> > 		errors, it may be prudent to move the data off that
> > 		physical page before the correctable SBE turns into an
> > 		uncorrectable MBE. 
> 
> This should be common code indeed.
>
> Similar for handling uncorrectable errors; e.g. swap the page 
> in again from disk if possible or kill the application. That should
> be imho all common code

Yup.
 
> I did a prototype of this some time ago, but ran out of time
> and it wasn't that useful on my platform anyways so I gave it up. 
> 
> >
> > 	    Memory handling parameters:
> >
> > 		Since memory failure modes are due to specific DIMM
> > 		failure characteristics, there is will be no way to 
> > 		reach agreement on one set of thresholds that will
> > 		be appropriate for all configurations.  Therefore there
> > 		needs to be a way to modify the thresholds.  One alternative
> > 		is a /proc/sys/kernel/ interface to control settings, such
> > 		as polling thresholds.  That provides an easy standard
> > 		way of modifying thresholds to match the characteristics
> > 		of the specific DIMM type.
> 
> This is deeply architecture and even platform specific.

The implementation is arch specific, but the external interface could
be common.  If common doesn't make sense, I'll just add it in linux-ia64
and be done with it.  :-)

> > 	Uncorrected error handling:
> >
> > 	    Kill the application:  One recovery technique to avoid a kernel
> > 		panic when an application process hits an uncorrectable 
> > 		memory error is to SIGKILL the application.  The page is 
> > 		marked PG_reserved to avoid re-use.  A (new) PG_hard_error
> > 		flag would be useful to indicate that the physical page has
> > 		a hard memory error.
> 
> No need for a new flag, just allocate it.

That is what the current code does.  Looking ahead, it would be nice to
keep track of the bad memory, so that other processes, such as a dump
program, does not try to access it.  The PG_hard_error flag is one
idea, but others may have a better idea.  Conversely, a diag program may
want to access it to do additional analysys.  The hot-plug people,
working on page migration, were wondering how to deal with pages
marked reserved.  Bad data on bad memory pages does not need to
be migrated.  They need to know what data not to migrate.

>                                             This should be indeed common
> code using the rmap infrastructure.
>
> > 	    Disable memory for next reboot:  When a hard error is detected,
> > 		notify SAL/BIOS of the bad physical memory.  SAL/BIOS can
> > 		save the bad addresses and, when building the EFI map after
> > 		reset/reboot, mark the bad pages as EFI_UNUSABLE_MEMORY,
> > 		and type = 0, so Linux will ignore granules contains these 
> > 		pages.
> 
> Deeply hardware specific.

My intent was a common interface to tell EFI of a bad address.
In ia64, I could add a SAL call to tell our SAL(SGI PROM) of
the bad address, to get this functionality.  Very platform specific.
Perhaps a more generic interface would add more value for more 
platforms.  That was my intent.  

> > 	    Dumping:  Dump programs should not try to dump pages with bad
> > 		memory.  A PG_hard_error flag would indicate to dump
> > 		programs which pages have bad memory.
> 
> There is no dump program in mainline. I have no problem with the flag,
> but for some reason the struct page bits seem to be very contended
> and 32bit will run out of them in the forseeable future.

Add more bits. :-)  I realize that flag bits are more limited with
32bit, but adding a page flag is a lkml issue, not a linux-ia64 issue.
So I need to discuss this issue here.  Perhaps there is an alternative
way to achieve the needed functionality.

> > 	Memory DIMM information & settings:
> >
> > 	    Use a /proc/dimm_info interface to pass DIMM information to Linux.
> > 	    Hardware vendors could add their hardware specific settings.
> 
> I don't think it makes sense to put any of this in common code.
> 
> > 	Page Flags:  When a page is discarded, PG_reserved is set so that the
> > 		page is no longer used.  A PG_hard_error flag could be added
> 
> That is not quite how PG_reserved works...

That's why it needs improvement.

> > 		to indicate the physical page has bad memory.
> >
> > 	Pseudo task switching:  Some architectures signal memory errors via
> > 		non maskable interrupts, with unusual calling sequences into
> > 		the OS.  It is often easier to process these non-maskable
> > 		errors on a stack that is separate from the normal kernel
> > 		stacks.  This requires non-blocking scheduler interfaces
> > 		to obtain the current running task, to modify the pointer
> > 		to the current running task and to reset that pointer when
> > 		the memory error has been processed.
> 
> 
> A "non blocking interface to obtain the current task"? aka "current"?
> 
> I sense some confusion here ;-)

See "[RFD] Separating struct task and the kernel stacks"
http://www.gelato.unsw.edu.au/linux-ia64/0506/14426.html

Thanks,
-- 
Russ Anderson, OS RAS/Partitioning Project Lead  
SGI - Silicon Graphics Inc          rja@sgi.com
