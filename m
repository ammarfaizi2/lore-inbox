Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264768AbUETAXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264768AbUETAXb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 20:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264816AbUETAXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 20:23:31 -0400
Received: from ultra1.eskimo.com ([204.122.16.64]:46091 "EHLO
	ultra1.eskimo.com") by vger.kernel.org with ESMTP id S264768AbUETAX1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 20:23:27 -0400
Date: Wed, 19 May 2004 17:23:17 -0700
From: Elladan <elladan@eskimo.com>
To: Terry Barnaby <terry1@beam.ltd.uk>
Cc: davids@webmaster.com, Mike Black <mblack@csi-inc.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Problem with mlockall() and Threads: memory usage
Message-ID: <20040520002317.GB6501@eskimo.com>
References: <MDEHLPKNGKAHNMBLJOLKEEIJMBAA.davids@webmaster.com> <40AB1EA7.8080104@beam.ltd.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40AB1EA7.8080104@beam.ltd.uk>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2004 at 09:45:27AM +0100, Terry Barnaby wrote:
> Hi David,
> 
> We do want improved latency, but with reasonable memory usage. This is
> a soft real-time system. At the moment the memory usage is far too
> high in our application.
> 
> With 20 threads runing the system will lock 160MBytes of memory just
> for stack space (8 MBytes each), although the application probably
> only needs 2MByte in total.  We can reduce the maximum stack size per
> thread, but then if a thread increases its stack size beyond this the
> application will crash with a segment fault, not good ...
> 
> For our use, mapping in physical memory as required for a growing
> stack would be a good compromise between latency and memory usage.
> Once the system has run the worker threads for a short time all of the
> needed stack memory will be locked in and latency will be controlled.
> If a thread needs more memory for stack in a particular instance,
> there will be a latency hit but this would be acceptable and much
> better than a crash.

It sounds to me like you have a really special-purpose situation here.
You want to minimize the amount of memory used, but you may have deep
stacks of unknown depth and you can't grow them safely without incurring
latency.

It seems to me that you really should just figure out how much stack
your app really needs and set your limits appropriately.  If your
program requires indeterminate stack depth, you should fix it so it
doesn't.

If you really, really want random memory allocations and memory locking
at the same time, you could implement your own mlockall solution with
your own stack manager.  You could do an mlockall(MCL_CURRENT) with
small stack reserves, and then manually go and remap your stack space
the way you want it.  Of course, you'd need your own memory allocator if
you ever allocate more non-stack memory, but you'll need that anyway.

-J

> David Schwartz wrote:
> >>Thanks for that.
> >>I have done some more investigating, and on my system (Standard RedHat 9)
> >>the stack ulimit is set to 8192 KBytes. So it appears that the thread
> >>library/kernel threads pre-allocates, and writes to, 8129 KBytes
> >>of stack per
> >>thread and so then mlockall() locks all of this in memory.
> >>
> >>Should'nt the Thread library grow the stack rather than
> >>preallocate it all even
> >>with mlockall() like malloc ?
> >
> >
> >	I thought you wanted improved latency. Surely having to find a page 
> >	for you
> >when your stack grows will add unpredictable latency. So, no, the thread
> >library should reserve the stack when 'mlockall(MCL_FUTURE)' is specified.
> >
> >	I do agree that having an 'initial stack size' in additional to a 
> >	'maximum
> >stack size' would be a good idea. The former good for application that are
> >concerned about physical memory usage and the latter for applications
> >concerned about virtual memory usage.
> >
> >	DS
> >
> >
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> >
> 
> -- 
> Dr Terry Barnaby                     BEAM Ltd
> Phone: +44 1454 324512               Northavon Business Center, Dean Rd
> Fax:   +44 1454 313172               Yate, Bristol, BS37 5NH, UK
> Email: terry@beam.ltd.uk             Web: www.beam.ltd.uk
> BEAM for: Visually Impaired X-Terminals, Parallel Processing, Software
>                       "Tandems are twice the fun !"
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
