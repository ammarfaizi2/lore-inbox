Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261285AbSJBA0W>; Tue, 1 Oct 2002 20:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261331AbSJBA0W>; Tue, 1 Oct 2002 20:26:22 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:10743 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261285AbSJBA0V>; Tue, 1 Oct 2002 20:26:21 -0400
Subject: Re: [PATCH] 8390.c: preemption and disable_irq
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Robert Love <rml@tech9.net>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org
In-Reply-To: <1033509479.12851.34.camel@phantasy>
References: <1033509479.12851.34.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 02 Oct 2002 01:39:01 +0100
Message-Id: <1033519141.20103.32.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-01 at 22:58, Robert Love wrote:
> P.S. Note there is a much simpler solution of merely flipping the
> spin_lock() and disable_irq() calls - the spin_lock() will provide the
> atomicity without the explicit preempt_disable().  I do not think this
> is safe, however, since the IRQ handler could deadlock if it grabbed
> this lock (which I assume it does).


The actual game the driver is playing goes like this

ne2k-pci hardware is often very slow (some of it is isa chips nailed to
crappy pci/isa glue). 8390's also have the fun property that the
registers are windowed and you can't clear a pending IRQ without
flipping windows. 

When we do a transmit we want to do the packet upload with most
interrupts enabled (or you drop serial interrupts and life sucks a lot).
We take the lock with the irq. We switch window (safely under the lock)
and we turn interrupts off on the card. We then release the lock. 

At this point you might think all is safe. However IRQ delivery on x86
is asynchronous so an IRQ can be in flight after we turn it off but not
yet at the CPU. To cover this case we disable that IRQ line, then take
the lock - possibly waiting briefly for an IRQ handler to clear on
another CPU, but not where one can begin to occur and deadlock.

The end result of this little pile of tricks is that you can run ne2k
cards and a modem on a PC at the same time. I think you want to
disable pre-empt before we take the lock with irqsave - to cover the
moment we have the irq disabled against pre-emption and packet loss too
- ie move the pre-empt disable further backwards.


