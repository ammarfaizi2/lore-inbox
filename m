Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932514AbVJZB0f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932514AbVJZB0f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 21:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932515AbVJZB0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 21:26:35 -0400
Received: from relais.videotron.ca ([24.201.245.36]:64844 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932514AbVJZB0e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 21:26:34 -0400
Date: Tue, 25 Oct 2005 21:26:33 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 2/9] mm: arm ready for split ptlock
In-reply-to: <20051026002016.GB25420@flint.arm.linux.org.uk>
X-X-Sender: nico@localhost.localdomain
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Message-id: <Pine.LNX.4.64.0510252049410.5288@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <Pine.LNX.4.61.0510221716380.18047@goblin.wat.veritas.com>
 <Pine.LNX.4.61.0510221719370.18047@goblin.wat.veritas.com>
 <20051022170240.GA10631@flint.arm.linux.org.uk>
 <Pine.LNX.4.64.0510241922040.5288@localhost.localdomain>
 <20051025075555.GA25020@flint.arm.linux.org.uk>
 <Pine.LNX.4.64.0510251056380.5288@localhost.localdomain>
 <20051026002016.GB25420@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Oct 2005, Russell King wrote:

> On Tue, Oct 25, 2005 at 11:00:09AM -0400, Nicolas Pitre wrote:
> 
> > Argh...  So only suffice to s/pte_write/pte_dirty/ I'd guess?
> 
> No.  If we're emulating a cmpxchg() on a clean BSS page, this code
> as it stands today will write to the zero page making it a page which
> is mostly zero.  Bad news when it's mapped into other processes BSS
> pages.
> 
> Changing this for pte_dirty() means that we'll refuse to do a cmpxchg()
> on a clean BSS page.  The data may compare correctly, but because it
> isn't already dirty, you'll fail.

Does it matter?  I'd say no.  OK we _know_ that it should have worked, 
but user space must be ready to deal with cmpxchg failing and reattempt 
the operation.  It never cares about the reason for which it might have 
failed in all the cases I've seen.  The second time, the page will have 
been marked dirty and things will proceed normally.

This is of course not perfect but should be pretty damn good enough 
given that the number of machine instances on this planet that _might_ 
need to rely on that code are truely non standard (i.e. pre ARMv6 SMP) 
and can be counted on my fingers.  The only other "solution" is to 
always return failure and simply deny NPTL support for those classes of 
machines.


Nicolas
