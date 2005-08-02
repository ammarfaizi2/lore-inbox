Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261890AbVHBWJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbVHBWJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 18:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbVHBWJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 18:09:27 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:26262 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261890AbVHBWJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 18:09:27 -0400
Date: Tue, 2 Aug 2005 15:09:15 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: "Luck, Tony" <tony.luck@intel.com>
cc: Alex Williamson <alex.williamson@hp.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: RE: [PATCH] optimize writer path in time_interpolator_get_counter()
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F040BF5AD@scsmsx401.amr.corp.intel.com>
Message-ID: <Pine.LNX.4.62.0508021501190.18484@schroedinger.engr.sgi.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F040BF5AD@scsmsx401.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Aug 2005, Luck, Tony wrote:

> Yes this is an SMP system (Intel Tiger4).  Cpu0 is the boot cpu, and is
> indeed the one that takes the write lock, and thus the fast-return from
> the get_counter() code.  I'm just very confused as to why I only see these
> 10X worse outliers on cpu3.  There doesn't seem to be anything special
> about it (/proc/interrupts shows similar stuff happening on each cpu).

Are you sure that this is not some hardware contingency? I.e. cachelines 
are prioritized according to cpu number or some such thing? Switch the 
timer interrupt to a different cpu and see how this affects the 
situation.

> >We can still switch on the nojitter by default if the ITC's are guaranteed 
> >to be properly synchronized which will make all this ugliness go away. 
> 
> What do you mean by "properly synchronized"?  We can't get them
> completely in step ... but we do know that they are very close.

Properly synchronized means completely in step.

> Closer than the microsecond granularity that most users (gettimeofday)
> are going to pass back to the caller.  But running with "nojitter" will
> occasionally result in time (as seen on two different processors) sometimes
> jumping back by a microsecond.  How bad is this in practice?  I can
> see that a user that simply subtracts two times may sometimes see an
> answer of minus one micro-second ... but does this hurt?

In practice we have seen the time jump forward to A.D. 2587 which then 
results in tcp retransmits periods of a few centuries. I'd strongly advise 
against nojitter unless you know that the ITCs are in step. Isnt the 
hardware capable of making them run in step? It seems that some i386 
BIOSes have accomplished just that.

Note that the time subsystem for ia64 is not based on microseconds like 
i386 but on nanoseconds. clock_gettime will return nanosecond resolution 
which WILL become negative with devastating consequence if the clock 
jumps back a microsecond. A single ia64 processor can do multiple calls 
to retrieve time from user space within a microsecond.

The jitter compensation avoids the problems arising with time for ITC.
