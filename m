Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752264AbWCKACE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752264AbWCKACE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 19:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752267AbWCKACD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 19:02:03 -0500
Received: from ozlabs.org ([203.10.76.45]:57273 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1752258AbWCKACB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 19:02:01 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17426.4977.893926.803202@cargo.ozlabs.ibm.com>
Date: Sat, 11 Mar 2006 11:01:53 +1100
From: Paul Mackerras <paulus@samba.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, mingo@redhat.com, alan@redhat.com,
       linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document Linux's memory barriers [try #4] 
In-Reply-To: <26486.1142003950@warthog.cambridge.redhat.com>
References: <17424.48029.481013.502855@cargo.ozlabs.ibm.com>
	<16835.1141936162@warthog.cambridge.redhat.com>
	<26486.1142003950@warthog.cambridge.redhat.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells writes:

> Paul Mackerras <paulus@samba.org> wrote:
> > There shouldn't be any problem here, because readw/writew _must_
> > ensure that the device accesses are serialized.
> 
> No. That depends on the properties of the memory window readw/writew write
> through, the properties of the CPU wrt memory accesses, and what explicit
> barriers at interpolated inside readw/writew themselves.

The properties of the memory window are certainly relevant.  For a
non-prefetchable PCI MMIO region, the readw/writew must ensure that
the accesses are serialized w.r.t. each other, although not
necessarily serialized with accesses to normal memory.  That is a
requirement that the driver writer can rely on, and the implementor of
readw/writew must ensure is met, taking into account the properties of
the CPU (presumably by putting explicit barriers inside readw/write).

For prefetchable regions, or if the cookie used with readw/writew has
been obtained by something other than the normal ioremap{,_nocache},
then it's more of an open question.

> > Of course, on an SMP system it would be quite possible for the
> > interrupt to be taken on another CPU, and in that case disabling
> > interrupts (I assume that by "DISABLE IRQ" you mean
> > local_irq_disable() or some such)
> 
> Yes. There are quite a few different ways to disable interrupts.

I think it wasn't clear to me which of the following you meant:

(a) Telling this CPU not to take any interrupts (e.g. local_irq_disable())
(b) Telling the interrupt controller not to allow interrupts from that
    device (e.g. disable_irq(irq_num))
(c) Telling the device not to generate interrupts in some
    device-specific fashion

They all have different characteristics w.r.t. timing and
synchronization, so I think it's important to be clear which one you
mean.  For example, if it's (c), then after doing a writel (or
whatever) to the device, you then need at least to do a readl to make
sure the write has got to the device, and even then there might be an
interrupt signal still wending its way through the interrupt
controller etc., which might arrive after the readl has finished.

I think you meant (a), but DISABLE_IRQ actually sounds more like (b).

Paul.
