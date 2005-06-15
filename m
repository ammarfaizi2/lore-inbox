Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbVFOP0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbVFOP0u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 11:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbVFOP0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 11:26:50 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:18436 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261169AbVFOP0o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 11:26:44 -0400
Date: Wed, 15 Jun 2005 16:26:13 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Russ Anderson <rja@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RCF] Linux memory error handling
In-Reply-To: <200506151430.j5FEUD7J1393603@clink.americas.sgi.com>
Message-ID: <Pine.LNX.4.61L.0506151545410.13835@blysk.ds.pg.gda.pl>
References: <200506151430.j5FEUD7J1393603@clink.americas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jun 2005, Russ Anderson wrote:

> Handling memory errors:
> 
> 	Some memory error handling functionality is common to
> 	most architectures.
> 
> 	Corrected error handling:
> 
> 	    Logging:  When ECC hardware corrects a Single Bit Error (SBE),
> 		an interrupt is generated to inform linux that there is 
> 		a corrected error record available for logging.
> 
> 	    Polling Threshold:  A solid single bit error can cause a burst
> 		of correctable errors that can cause a significant logging
> 		overhead.  SBE thresholding counts the number of SBEs for
> 		a given page and if too many SBEs are detected in a given
> 		period of time, the interrupt is disabled and instead 
> 		linux periodically polls for corrected errors.

 This is highly undesirable if the same interrupt is used for MBEs.  A 
page that causes an excessive number of SBEs should rather be removed from 
the available pool instead.  Logging should probably take recent events 
into account anyway and take care of not overloading the system, e.g. by 
keeping only statistical data instead of detailed information about each 
event under load.

> 	    Data Migration:  If a page of memory has too many single bit
> 		errors, it may be prudent to move the data off that
> 		physical page before the correctable SBE turns into an
> 		uncorrectable MBE. 
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

 Note that scrubbing may also be required depending on hardware 
capabilities as data could have been corrected on the fly for the purpose 
of providing a correct value for the bus transaction, but memory may still 
hold corrupted data.

 And of course not all memory is DIMM!

> 	Uncorrected error handling:
> 
> 	    Kill the application:  One recovery technique to avoid a kernel
> 		panic when an application process hits an uncorrectable 
> 		memory error is to SIGKILL the application.  The page is 
> 		marked PG_reserved to avoid re-use.  A (new) PG_hard_error
> 		flag would be useful to indicate that the physical page has
> 		a hard memory error.

 Note we have some infrastructure for that in the MIPS port -- we kill the 
triggering process, but we don't mark the problematic memory page as 
unusable (which is an area for improvement).  This is of course the case 
for faults occurring synchronously in the user mode -- when in the kernel 
mode or when happening asynchronously (e.g. because of being triggered by 
a DMA transaction rather than one involving a CPU) you often cannot 
determine whether killing a process is good enough for system safety even 
if you are able to narrow the fault down to a potential victim.

> 	    Disable memory for next reboot:  When a hard error is detected,
> 		notify SAL/BIOS of the bad physical memory.  SAL/BIOS can
> 		save the bad addresses and, when building the EFI map after
> 		reset/reboot, mark the bad pages as EFI_UNUSABLE_MEMORY,
> 		and type = 0, so Linux will ignore granules contains these 
> 		pages.
> 
> 	    Dumping:  Dump programs should not try to dump pages with bad
> 		memory.  A PG_hard_error flag would indicate to dump
> 		programs which pages have bad memory.
> 
> 	Memory DIMM information & settings:
> 
> 	    Use a /proc/dimm_info interface to pass DIMM information to Linux.
> 	    Hardware vendors could add their hardware specific settings.

 I'd recommend a more generic name rather than "dimm_info" if that is to 
be reused universally.

  Maciej
