Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030228AbVINWV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030228AbVINWV0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 18:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030229AbVINWV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 18:21:26 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:787 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1030228AbVINWVY (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 18:21:24 -0400
Date: Wed, 14 Sep 2005 23:21:06 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: [PATCH 2/5] atomic: introduce atomic_inc_not_zero
Message-ID: <20050914232106.H30746@flint.arm.linux.org.uk>
Mail-Followup-To: Roman Zippel <zippel@linux-m68k.org>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>,
	Dipankar Sarma <dipankar@in.ibm.com>
References: <43283825.7070309@yahoo.com.au> <4328387E.6050701@yahoo.com.au> <Pine.LNX.4.61.0509141814220.3743@scrub.home> <43285374.3020806@yahoo.com.au> <Pine.LNX.4.61.0509141906040.3728@scrub.home> <20050914230049.F30746@flint.arm.linux.org.uk> <Pine.LNX.4.61.0509150010100.3728@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.61.0509150010100.3728@scrub.home>; from zippel@linux-m68k.org on Thu, Sep 15, 2005 at 12:10:56AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2005 at 12:10:56AM +0200, Roman Zippel wrote:
> Hi,
> 
> On Wed, 14 Sep 2005, Russell King wrote:
> 
> > > 	do {
> > > 		old = atomic_load_locked(v);
> > > 		if (!old)
> > > 			break;
> > > 		new = old + 1;
> > > 	} while (!atomic_store_lock(v, old, new));
> > 
> > How do you propose architectures which don't have locked loads implement
> > this, where the only atomic instruction is an unconditional atomic swap
> > between memory and CPU register?
> 
> #define atomic_store_lock atomic_cmpxchg

No.  "unconditional atomic swap" does not mean cmpxchg - it means that
atomic_cmpxchg itself would have to be open coded, which is inefficient.

What you're asking architectures to do is:

retry:
	load
	operation
	save interrupts
	load
	compare
	store if equal
	restore interrupts
	goto retry if not equal

whereas they could have done the far simpler version of:

	save interrupts
	load
	operation
	store
	restore interrupts

which they do today.

The whole point about architecture specific includes is not to provide
a frenzied feeding ground for folk who like to "clean code up" but to
allow architectures to do things in the most efficient way for them
without polluting the kernel too much.

It seems that aspect is being lost sight of here.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
