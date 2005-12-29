Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965060AbVL2IlV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965060AbVL2IlV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 03:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965062AbVL2IlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 03:41:21 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:29876 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965060AbVL2IlU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 03:41:20 -0500
Date: Thu, 29 Dec 2005 09:41:00 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Nicolas Pitre <nico@cam.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 2/3] mutex subsystem: fastpath inlining
Message-ID: <20051229084100.GB31003@elte.hu>
References: <20051223161649.GA26830@elte.hu> <Pine.LNX.4.64.0512261414300.1496@localhost.localdomain> <20051227115525.GC23587@elte.hu> <Pine.LNX.4.64.0512271548030.3309@localhost.localdomain> <20051228074154.GA4442@elte.hu> <Pine.LNX.4.64.0512281639490.3309@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512281639490.3309@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.9 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.9 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nicolas Pitre <nico@cam.org> wrote:

> This is with all mutex patches applied and CONFIG_DEBUG_MUTEX_FULL=n, 
> therefore using the current semaphore code:
> 
>    text	   data	    bss	    dec	    hex	filename
> 1821108	 287792	  88264	2197164	 2186ac	vmlinux
> 
> Now with CONFIG_DEBUG_MUTEX_FULL=y to substitute semaphores with 
> mutexes:
> 
>    text	   data	    bss	    dec	    hex	filename
> 1797108	 287568	  88172	2172848	 2127b0	vmlinux
> 
> Finally with CONFIG_DEBUG_MUTEX_FULL=y and fast paths inlined:
> 
>    text	   data	    bss	    dec	    hex	filename
> 1807824	 287136	  88172	2183132	 214fdc	vmlinux
> 
> This last case is not the smallest, but it is the fastest.

i.e. 1.3% text savings from going to mutexes, and inlining them again 
gives up 0.5% of that. We've uninlined stuff for a smaller gain in the 
past ...

> > Note that x86 went to a non-inlined fastpath _despite_ 
> > having a compact CISC semaphore fastpath.
> 
> The function call overhead on x86 is less significant than the ARM 
> one, so always calling out of line code might be sensible in that 
> case.

i'm highly doubtful we should do that. The spinlock APIs are 4 times 
more frequent than mutexes are ever going to be, still they too are 
mostly out of line. (and we only inline the unlock portions that are a 
space win!) Can you measure any significant difference in performance?  
(e.g. lat_pipe triggers the mutex fastpath, in DEBUG_MUTEX_FULL=y mode) 

the performance won by inlining is often offset by the performance cost 
of the higher icache footprint. (and ARM CPUs dont have that large 
caches to begin with)

	Ingo
