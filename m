Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261707AbSIXQto>; Tue, 24 Sep 2002 12:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261708AbSIXQto>; Tue, 24 Sep 2002 12:49:44 -0400
Received: from air-2.osdl.org ([65.172.181.6]:29970 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261707AbSIXQtn>;
	Tue, 24 Sep 2002 12:49:43 -0400
Date: Tue, 24 Sep 2002 09:54:56 -0700
From: Dave Olien <dmo@osdl.org>
To: "David S. Miller" <davem@redhat.com>
Cc: phillips@arcor.de, davidm@hpl.hp.com, davidm@napali.hpl.hp.com,
       axboe@suse.de, _deepfire@mail.ru, linux-kernel@vger.kernel.org
Subject: Re: DAC960 in 2.5.38, with new changes
Message-ID: <20020924095456.A17658@acpi.pdx.osdl.net>
References: <20020923120400.A15452@acpi.pdx.osdl.net> <15759.26918.381273.951266@napali.hpl.hp.com> <E17ta3t-0003bj-00@starship> <20020923.135447.24672280.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020923.135447.24672280.davem@redhat.com>; from davem@redhat.com on Mon, Sep 23, 2002 at 01:54:47PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I haven't been ignoring the discussion.  Just thinking it over.
I was going to dig out an old PCI spec last night, but got involved
with other things.  I wanted to review how 64-bit PCI and 32-bit PCI busses
handle 32 and 64-bit writes from the processor.

I don't have a spec for these controllers.  IBM is selling Mylex
to LSI logic, so "All contracts, NDA's and agreements are on hold
until a transition to lsi is complete"  But, I'm guessing this
controller actually implements a 64-bit register at this location.
The 32-bit write from ia32 works probably because the controller either
clears the upper-32 bits when the lower-32 bits are written, or
those upper-32 bits are zero because we never set them to non-zero.

According to the Documentation/DMA-mapping.txt file, the new
DMA mapping interfaces should allow all PCI transfers to use 32-bit DMA
addresses. Controllers on the PCI bus should never need to use DAC
PCI transfers.  Based on this, writel() should work even on ia64.

It's possible there's something peculiar about the ia64 hardware
that lead to using writeq().  I might be able to get my hands on
an ia64 platform that I could try this on.

OR, the driver COULD always write 64 bits to this register.  ia32 doesn't
have a writeq() macro.  The only way I know to write 64 bits on ia32
is with one of the xchg instructions.  But that's mostly used if you
really want an atomic 64-bit operation.  Probably writeq() implemented as
two writel()'s would work.  It depends on the behavior of this particular
register's implementation on the controller.

I'll experiment with this later, after the other changes
I'm working on.  I'll try to identify a way to write this register
that is uniform across platforms, and won't require an #ifdef.

On Mon, Sep 23, 2002 at 01:54:47PM -0700, David S. Miller wrote:
>    From: Daniel Phillips <phillips@arcor.de>
>    Date: Mon, 23 Sep 2002 22:44:08 +0200
> 
>    On Monday 23 September 2002 21:19, David Mosberger wrote:
>    > This looks like a porting-nightmare in the making.  There's got to be a
>    > better way to determine whether you need a writeq() vs. a writel().
>    
>    Even if an #ifdef is necessary here (and we are in trouble if it is) it
>    should not trigger on __ia64__, it should trigger on the size of (long).
> 
> There is nothing preventing a 32-bit long platform from being able
> to store 64-bits at once to PCI space.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
