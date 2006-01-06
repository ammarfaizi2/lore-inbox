Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932535AbWAFVUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932535AbWAFVUu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 16:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932539AbWAFVUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 16:20:49 -0500
Received: from relais.videotron.ca ([24.201.245.36]:17708 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932535AbWAFVUn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 16:20:43 -0500
Date: Fri, 06 Jan 2006 16:20:42 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 2/3] mutex subsystem: fastpath inlining
In-reply-to: <20051229084100.GB31003@elte.hu>
X-X-Sender: nico@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Message-id: <Pine.LNX.4.64.0512291216330.3309@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20051223161649.GA26830@elte.hu>
 <Pine.LNX.4.64.0512261414300.1496@localhost.localdomain>
 <20051227115525.GC23587@elte.hu>
 <Pine.LNX.4.64.0512271548030.3309@localhost.localdomain>
 <20051228074154.GA4442@elte.hu>
 <Pine.LNX.4.64.0512281639490.3309@localhost.localdomain>
 <20051229084100.GB31003@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry for the delay...

On Thu, 29 Dec 2005, Ingo Molnar wrote:

> 
> * Nicolas Pitre <nico@cam.org> wrote:
> 
> > This is with all mutex patches applied and CONFIG_DEBUG_MUTEX_FULL=n, 
> > therefore using the current semaphore code:
> > 
> >    text	   data	    bss	    dec	    hex	filename
> > 1821108	 287792	  88264	2197164	 2186ac	vmlinux
> > 
> > Now with CONFIG_DEBUG_MUTEX_FULL=y to substitute semaphores with 
> > mutexes:
> > 
> >    text	   data	    bss	    dec	    hex	filename
> > 1797108	 287568	  88172	2172848	 2127b0	vmlinux
> > 
> > Finally with CONFIG_DEBUG_MUTEX_FULL=y and fast paths inlined:
> > 
> >    text	   data	    bss	    dec	    hex	filename
> > 1807824	 287136	  88172	2183132	 214fdc	vmlinux
> > 
> > This last case is not the smallest, but it is the fastest.
> 
> i.e. 1.3% text savings from going to mutexes, and inlining them again 
> gives up 0.5% of that. We've uninlined stuff for a smaller gain in the 
> past ...
> 
> > > Note that x86 went to a non-inlined fastpath _despite_ 
> > > having a compact CISC semaphore fastpath.
> > 
> > The function call overhead on x86 is less significant than the ARM 
> > one, so always calling out of line code might be sensible in that 
> > case.
> 
> i'm highly doubtful we should do that. The spinlock APIs are 4 times 
> more frequent than mutexes are ever going to be, still they too are 
> mostly out of line. (and we only inline the unlock portions that are a 
> space win!) Can you measure any significant difference in performance?  
> (e.g. lat_pipe triggers the mutex fastpath, in DEBUG_MUTEX_FULL=y mode) 

Here it is.

With the default non inlined fast path:

Pipe latency: 14.2669 microseconds
Pipe latency: 14.2625 microseconds
Pipe latency: 14.2655 microseconds
Pipe latency: 14.2670 microseconds

Then, with fast paths inlined:

Pipe latency: 13.9483 microseconds
Pipe latency: 13.9409 microseconds
Pipe latency: 13.9468 microseconds
Pipe latency: 13.9529 microseconds

So inlining the mutex fast path is more than 2% faster for the whole 
test.

Is that worth the 0.5% increase in kernel size in your opinion?

Note: I modified lat_pipe to use two threads instead of two processes 
since on ARM switching mm require a full cache flush due to the VIVT 
cache, and doing so skyrockets the pipe latency up to 480 microsecs with 
the mutex difference lost in the noise.


Nicolas
