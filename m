Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964971AbVL2Cxn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964971AbVL2Cxn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 21:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964978AbVL2Cxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 21:53:43 -0500
Received: from relais.videotron.ca ([24.201.245.36]:49245 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S964971AbVL2Cxm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 21:53:42 -0500
Date: Wed, 28 Dec 2005 21:53:39 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 2/3] mutex subsystem: fastpath inlining
In-reply-to: <20051228074154.GA4442@elte.hu>
X-X-Sender: nico@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Message-id: <Pine.LNX.4.64.0512281639490.3309@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20051223161649.GA26830@elte.hu>
 <Pine.LNX.4.64.0512261414300.1496@localhost.localdomain>
 <20051227115525.GC23587@elte.hu>
 <Pine.LNX.4.64.0512271548030.3309@localhost.localdomain>
 <20051228074154.GA4442@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Dec 2005, Ingo Molnar wrote:

> * Nicolas Pitre <nico@cam.org> wrote:
> 
> > > * Nicolas Pitre <nico@cam.org> wrote:
> > > 
> > > > Some architectures, notably ARM for instance, might benefit from 
> > > > inlining the mutex fast paths. [...]
> > > 
> > > what is the effect on text size? Could you post the before- and 
> > > after-patch vmlinux 'size kernel/test.o' output in the nondebug case, 
> > > with Arjan's latest 'convert a couple of semaphore users to mutexes' 
> > > patch applied? [make sure you've got enough of those users compiled in, 
> > > so that the inlining cost is truly measured. Perhaps also do 
> > > before/after 'size' output of a few affected .o files, without mixing 
> > > kernel/mutex.o into it, like vmlinux does.]
> > 
> > Theory should be convincing enough. [...]
> 
> please provide actual measurements (just a simple pre-patch and 
> post-patch 'size' output of vmlinux is enough), so that we can see the 
> inlining cost.

This is with all mutex patches applied and CONFIG_DEBUG_MUTEX_FULL=n, 
therefore using the current semaphore code:

   text	   data	    bss	    dec	    hex	filename
1821108	 287792	  88264	2197164	 2186ac	vmlinux

Now with CONFIG_DEBUG_MUTEX_FULL=y to substitute semaphores with 
mutexes:

   text	   data	    bss	    dec	    hex	filename
1797108	 287568	  88172	2172848	 2127b0	vmlinux

Finally with CONFIG_DEBUG_MUTEX_FULL=y and fast paths inlined:

   text	   data	    bss	    dec	    hex	filename
1807824	 287136	  88172	2183132	 214fdc	vmlinux

This last case is not the smallest, but it is the fastest.

> Note that x86 went to a non-inlined fastpath _despite_ 
> having a compact CISC semaphore fastpath.

The function call overhead on x86 is less significant than the ARM one, 
so always calling out of line code might be sensible in that case.


Nicolas
