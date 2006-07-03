Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750990AbWGCJDx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbWGCJDx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 05:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750989AbWGCJDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 05:03:52 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:27918 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750778AbWGCJDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 05:03:52 -0400
Date: Mon, 3 Jul 2006 10:03:43 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: tglx@linutronix.de, torvalds@osdl.org, mingo@elte.hu,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] genirq: ARM dyntick cleanup
Message-ID: <20060703090343.GA31274@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, tglx@linutronix.de,
	torvalds@osdl.org, mingo@elte.hu, linux-kernel@vger.kernel.org
References: <1151885928.24611.24.camel@localhost.localdomain> <20060702173527.cbdbf0e1.akpm@osdl.org> <20060703074155.GA28235@flint.arm.linux.org.uk> <20060703005542.62df5673.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060703005542.62df5673.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2006 at 12:55:42AM -0700, Andrew Morton wrote:
> On Mon, 3 Jul 2006 08:41:55 +0100
> Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> 
> > On Sun, Jul 02, 2006 at 05:35:27PM -0700, Andrew Morton wrote:
> > > This is not exactly a thing of beauty either.  It's much cleaner to use
> > > __attribute__((weak)), but that will add an empty call-return to everyone's
> > > interrupts.
> > 
> > Let's not go overboard with the weak stuff - it does not get removed
> > at link time, so it remains as dead code in the kernel image.
> 
> Well.
> 
> void handle_dynamic_tick(struct irqaction *action)
> {
> }
> 
> consumes one byte, doesn't it?  That's not very far overboard ;)

ROTFL!

All the word isn't x86.  On ARM it's 3 words for the stack setup and
one for the tear down, so 16 bytes, assuming the function doesn't
return a value.  If it does, add another 4 bytes.

So, on ARM potentially 16 to 20 bytes per weak function.  That's a
1600% to 2000% increase on your estimate.

(Unfortunately we have to tell the compiler to always generate stack
frames otherwise we can't get call traces out of the kernel.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
