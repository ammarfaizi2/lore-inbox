Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262234AbTD3RIu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 13:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262246AbTD3RIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 13:08:50 -0400
Received: from ltgp.iram.es ([150.214.224.138]:48264 "EHLO ltgp.iram.es")
	by vger.kernel.org with ESMTP id S262234AbTD3RIt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 13:08:49 -0400
From: Gabriel Paubert <paubert@iram.es>
Date: Wed, 30 Apr 2003 19:10:56 +0200
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: desc v0.61 found a 2.5 kernel bug
Message-ID: <20030430171056.GA4475@iram.es>
References: <200304292234_MC3-1-369F-3000@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304292234_MC3-1-369F-3000@compuserve.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 29, 2003 at 10:33:09PM -0400, Chuck Ebbert wrote:
> Gabriel Paubert wrote:
> 
> >>  And shouldn't CR3 be intitialized in case anyone actually wants to
> >> switch back to the kernel TSS?
> >
> > For now no, since the only task gate ever taken (double fault), never
> > returns (you don't want to update the TSS's CR3 field on every 
> > switch_to() so you would have to do it in the task gate return 
> > path, as well as having a correct LDT field).
> 
>   I want to write a TSS-based debug exception handler that just does
> an iret when it gets invoked.  For now it looks easier to just keep
> CR3 up-to-date on every switch.

It seems cr3 is in the same cache line as esp0 for a 32 byte cache line, 
so it's not that big a deal, but I'd still try to avoid this.

> 
> > However, returning from a task gate is so much fraught with races wrt 
> > segment registers that the best thing to do is to avoid it.
> 
>  Even with interrupts off?

Yes. Consider the following:

	create an LDT entry 
	load the segment to %fs
	clear the LDT entry (or mark it non present), 
		-> %fs is now stale but still marked valid
	...(no task switch)
	Interrupt handled through task gate
		-> stale selector written to TSS
	...(interrupt handler)
	iret-> TS/NP/SF exception when loading segments in the
		new task (I believe it can't be GP)

Of course on an SMP machine with shared LDT, there are even more
ways of triggering segment related exceptions.

Currently %fs and %gs are lazily cleaned up when switching processes
using the standard fixup mechanism, %ds and %es are cleaned up if
necessary when popping them off the stack in the return to user
mode path (the one which ends up in iret). There is no way to recover
from bad user %cs/%ss, the process simply exits in the iret fixup.

But this works only because you can put a specific fixup for each
instruction which loads a given segment register (or two for iret).
In an iret from a task gate, you don't have this fine grained control
(all registers are loaded at once and then checked one by one)
and the return address is unpredictable, so the fixup mechanism is out.

This does not mean that there is no way to safely return from an 
interrupt handled through a task gate, but it's not simple (you 
don't want to change the existing lazy cleanup mechanism which is 
about as simple and low overhead as it gets for the common cases).

	Gabriel

