Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261623AbVFOWSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbVFOWSa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 18:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbVFOWSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 18:18:12 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:62675 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261628AbVFOWJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 18:09:23 -0400
From: Russ Anderson <rja@sgi.com>
Message-Id: <200506152209.j5FM9HgD1464876@clink.americas.sgi.com>
Subject: Re: [RFC] Linux memory error handling
To: macro@linux-mips.org (Maciej W. Rozycki)
Date: Wed, 15 Jun 2005 17:09:17 -0500 (CDT)
Cc: rja@sgi.com (Russ Anderson), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61L.0506151545410.13835@blysk.ds.pg.gda.pl> from "Maciej W. Rozycki" at Jun 15, 2005 04:26:13 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej W. Rozycki wrote:
> On Wed, 15 Jun 2005, Russ Anderson wrote:
> 
> > Handling memory errors:
> > 
> > 	    Polling Threshold:  A solid single bit error can cause a burst
> > 		of correctable errors that can cause a significant logging
> > 		overhead.  SBE thresholding counts the number of SBEs for
> > 		a given page and if too many SBEs are detected in a given
> > 		period of time, the interrupt is disabled and instead 
> > 		linux periodically polls for corrected errors.
> 
>  This is highly undesirable if the same interrupt is used for MBEs.  A 
> page that causes an excessive number of SBEs should rather be removed from 
> the available pool instead.

As a practical point I think you are right that if there are enough 
SBEs to cause a performance hit, migrating the data to a different 
physical page would be a prudent thing to do.  But that functionality
hasn't been implemented yet.

That may not always be the right setting for all customers.
One possible way to deal with that would be to have different
threshold settings for logging and page migration.  That would
provide flexibility.

>                              Logging should probably take recent events 
> into account anyway and take care of not overloading the system, e.g. by 
> keeping only statistical data instead of detailed information about each 
> event under load.

That's what the SBE thresholding does.  It avoids overloading the
system by switching from interrupt mode to periodic polling
mode, where detailed information can get dropped.

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
>  Note that scrubbing may also be required depending on hardware 
> capabilities as data could have been corrected on the fly for the purpose 
> of providing a correct value for the bus transaction, but memory may still 
> hold corrupted data.

Good point.

>  And of course not all memory is DIMM!

Another good point.

> > 	Uncorrected error handling:
> > 
> > 	    Kill the application:  One recovery technique to avoid a kernel
> > 		panic when an application process hits an uncorrectable 
> > 		memory error is to SIGKILL the application.  The page is 
> > 		marked PG_reserved to avoid re-use.  A (new) PG_hard_error
> > 		flag would be useful to indicate that the physical page has
> > 		a hard memory error.
> 
>  Note we have some infrastructure for that in the MIPS port -- we kill the 
> triggering process, but we don't mark the problematic memory page as 
> unusable (which is an area for improvement). 

Mips has some nice features when it comes to error recovery.

Thanks,
-- 
Russ Anderson, OS RAS/Partitioning Project Lead  
SGI - Silicon Graphics Inc          rja@sgi.com
