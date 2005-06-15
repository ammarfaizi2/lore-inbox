Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261463AbVFOObJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbVFOObJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 10:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbVFOObJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 10:31:09 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:704 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261463AbVFOOaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 10:30:16 -0400
From: Russ Anderson <rja@sgi.com>
Message-Id: <200506151430.j5FEUD7J1393603@clink.americas.sgi.com>
Subject: [RCF] Linux memory error handling
To: linux-kernel@vger.kernel.org
Date: Wed, 15 Jun 2005 09:30:13 -0500 (CDT)
Cc: rja@sgi.com (Russ Anderson)
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

		[RCF] Linux memory error handling.

Summary: One of the most common hardware failures in a computer 
	is a memory failure.   There has been efforts in various
	architectures to support recover from memory errors.  This
	is an attempt to define a common support infrastructure
	in Linux to support memory error handling.

Background:  There has been considerable work on recovering from
	Machine Check Aborts (MCAs) in arch/ia64.  One result is
	that many memory errors encountered by user applications
	not longer cause a kernel panic.  The application is 
	terminated, but linux and other applications keep running.
	Additional improvements are becoming dependent on mainline
	linux support.  That requires involvement of lkml, not
	just linux-ia64.

Types of memory failures:

	Memory hardware failures are very hardware implementation 
	specific, but there are some general characteristics.

	    Corrected errors: Error Correction Codes (ECC) in memory 
		hardware can correct Single Bit Errors (SBEs).  

	    Uncorrected errors: Parity errors and Multiple Bit Errors (MBEs)
		are errors that hardware cannot correct.  In this case the
		data in memory is no longer valid and cannot be used.

	There are different types of memory errors:

	    Transient errors: The bit showed up bad, but re-reading the
		data returns the correct data.

	    Soft errors: A bit in memory has changed state, but the 
		the underlying memory cell still works.  For example
		a particle strike can sometimes cause a bit to switch.
		In this case, re-writing the data corrects the error.

	    Hard errors:  The memory storage cell cannot hold the bit.  
		The underlying memory cell could be stuck at 0 or 1.

	A common question is whether single bit (corrected) errors will 
	turn into double bit (uncorrected) errors.  The answer is it
	depends on the underlying cause of the memory error.  There are
	some errors that show up as single bits, especially transient 
	and soft errors, that do not degrade over time.  There are other
	failures that do degrade over time.  The details of the memory
	technology are implementation specific and too detailed for
	this discussion.

Handling memory errors:

	Some memory error handling functionality is common to
	most architectures.

	Corrected error handling:

	    Logging:  When ECC hardware corrects a Single Bit Error (SBE),
		an interrupt is generated to inform linux that there is 
		a corrected error record available for logging.

	    Polling Threshold:  A solid single bit error can cause a burst
		of correctable errors that can cause a significant logging
		overhead.  SBE thresholding counts the number of SBEs for
		a given page and if too many SBEs are detected in a given
		period of time, the interrupt is disabled and instead 
		linux periodically polls for corrected errors.

	    Data Migration:  If a page of memory has too many single bit
		errors, it may be prudent to move the data off that
		physical page before the correctable SBE turns into an
		uncorrectable MBE. 

	    Memory handling parameters:

		Since memory failure modes are due to specific DIMM
		failure characteristics, there is will be no way to 
		reach agreement on one set of thresholds that will
		be appropriate for all configurations.  Therefore there
		needs to be a way to modify the thresholds.  One alternative
		is a /proc/sys/kernel/ interface to control settings, such
		as polling thresholds.  That provides an easy standard
		way of modifying thresholds to match the characteristics
		of the specific DIMM type.

	Uncorrected error handling:

	    Kill the application:  One recovery technique to avoid a kernel
		panic when an application process hits an uncorrectable 
		memory error is to SIGKILL the application.  The page is 
		marked PG_reserved to avoid re-use.  A (new) PG_hard_error
		flag would be useful to indicate that the physical page has
		a hard memory error.

	    Disable memory for next reboot:  When a hard error is detected,
		notify SAL/BIOS of the bad physical memory.  SAL/BIOS can
		save the bad addresses and, when building the EFI map after
		reset/reboot, mark the bad pages as EFI_UNUSABLE_MEMORY,
		and type = 0, so Linux will ignore granules contains these 
		pages.

	    Dumping:  Dump programs should not try to dump pages with bad
		memory.  A PG_hard_error flag would indicate to dump
		programs which pages have bad memory.

	Memory DIMM information & settings:

	    Use a /proc/dimm_info interface to pass DIMM information to Linux.
	    Hardware vendors could add their hardware specific settings.

Linux infrastructure:

	Some infrastructure that could be added to linux that would be
	useful to various architectures.

	Page Flags:  When a page is discarded, PG_reserved is set so that the
		page is no longer used.  A PG_hard_error flag could be added
		to indicate the physical page has bad memory.

	/proc interfaces:  Use /proc interfaces to change thresholds and
		pass information to/from BIOS/SAL.  

	Pseudo task switching:  Some architectures signal memory errors via
		non maskable interrupts, with unusual calling sequences into
		the OS.  It is often easier to process these non-maskable
		errors on a stack that is separate from the normal kernel
		stacks.  This requires non-blocking scheduler interfaces
		to obtain the current running task, to modify the pointer
		to the current running task and to reset that pointer when
		the memory error has been processed.

-- 
Russ Anderson, OS RAS/Partitioning Project Lead  
SGI - Silicon Graphics Inc          rja@sgi.com
