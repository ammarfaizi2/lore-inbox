Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262944AbUB0S4Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 13:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262947AbUB0S4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 13:56:25 -0500
Received: from waste.org ([209.173.204.2]:5863 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262944AbUB0S4P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 13:56:15 -0500
Date: Fri, 27 Feb 2004 12:55:55 -0600
From: Matt Mackall <mpm@selenic.com>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: Why no interrupt priorities?
Message-ID: <20040227185555.GJ3883@waste.org>
References: <F760B14C9561B941B89469F59BA3A8470255F02D@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F760B14C9561B941B89469F59BA3A8470255F02D@orsmsx401.jf.intel.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 27, 2004 at 09:44:44AM -0800, Grover, Andrew wrote:
> > From: Helge Hafting [mailto:helgehaf@aitel.hist.no] 
> > Grover, Andrew wrote:
> > > Is the assumption that hardirq handlers are superfast also 
> > the reason
> > > why Linux calls all handlers on a shared interrupt, even if 
> > the first
> > > handler reports it was for its device?
> > > 
> > No, it is the other way around.  hardirq handlers have to be superfast
> > because linux usually _have to_ call all the handlers of a shared irq.
> > 
> > The fact that one device did indeed have an interrupt for us 
> > doesn't mean
> > that the others didn't.  So all of them have to be checked to be safe.
> 
> If a device later in the handler chain is also interrupting, then the
> interrupt will immediately trigger again. The irq line will remain
> asserted until nobody is asserting it.
> 
> If the LAST guy in the chain is the one with the interrupt, then you
> basically get today's ISR "call each handler" behavior, but it should be
> possible to in some cases to get less time spent in do_IRQ.

Let's imagine you have n sources simultaneously interrupting on a
given descriptor. Check the first, it's happening, acknowledge it,
exit, notice interrupt still asserted, check the first, nope, check
the second, yep, exit, etc. By the time we've made it to the nth ISR,
we've banged on the first one n times, the second n-1 times, etc. In
other words, early chain termination has an O(n^2) worst case.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
