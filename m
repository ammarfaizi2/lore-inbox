Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752053AbWCIXfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752053AbWCIXfF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 18:35:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752044AbWCIXfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 18:35:05 -0500
Received: from ozlabs.org ([203.10.76.45]:43238 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750794AbWCIXfD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 18:35:03 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17424.48029.481013.502855@cargo.ozlabs.ibm.com>
Date: Fri, 10 Mar 2006 10:34:53 +1100
From: Paul Mackerras <paulus@samba.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, mingo@redhat.com, alan@redhat.com,
       linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document Linux's memory barriers [try #4] 
In-Reply-To: <16835.1141936162@warthog.cambridge.redhat.com>
References: <16835.1141936162@warthog.cambridge.redhat.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells writes:

> +On some systems, I/O writes are not strongly ordered across all CPUs, and so
> +locking should be used, and mmiowb() should be issued prior to unlocking the
> +critical section.

I think we should say more strongly that mmiowb() is required where
MMIO accesses are done under a spinlock, and that if your driver is
missing them then that is a bug.  I don't think it makes sense to say
that mmiowb is required "on some systems".

At least, we should either make that statement, or we should not
require any driver on any platform to use mmiowb explicitly.  (In that
case, the platforms that need it could do something like keep a
per-cpu count of MMIO accesses, which is zeroed in spin_lock and
incremented by read*/write*, and if spin_unlock finds it non-zero, it
does the mmiowb().)

Also, this section doesn't sound right to me:

> +	DISABLE IRQ
> +	writew(ADDR, ctl_reg_3);
> +	writew(DATA, y);
> +	ENABLE IRQ
> +	<interrupt>
> +	writew(ADDR, ctl_reg_4);
> +	q = readw(DATA);
> +	</interrupt>
> +
> +If ordering rules are sufficiently relaxed, the write to the data register
> +might happen after the second write to the address register.
> +
> +
> +It must be assumed that accesses done inside an interrupt disabled section may
> +leak outside of it and may interleave with accesses performed in an interrupt
> +and vice versa unless implicit or explicit barriers are used.
> +
> +Normally this won't be a problem because the I/O accesses done inside such
> +sections will include synchronous read operations on strictly ordered I/O
> +registers that form implicit I/O barriers. If this isn't sufficient then an
> +mmiowb() may need to be used explicitly.

There shouldn't be any problem here, because readw/writew _must_
ensure that the device accesses are serialized.  Just saying "if this
isn't sufficient" leaves the reader wondering when it might not be
sufficient or how they would know when it wasn't sufficient, and
introduces doubt where there needn't be any.

Of course, on an SMP system it would be quite possible for the
interrupt to be taken on another CPU, and in that case disabling
interrupts (I assume that by "DISABLE IRQ" you mean
local_irq_disable() or some such) gets you absolutely nothing; you
need to use a spinlock, and then the mmiowb is required.

You may like to include these words describing some of the rules:

* If you have stores to regular memory, followed by an MMIO store, and
  you want the device to see the stores to regular memory at the point
  where it receives the MMIO store, then you need a wmb() between the
  stores to regular memory and the MMIO store.

* If you have PIO or MMIO accesses, and you need to ensure the
  PIO/MMIO accesses don't get reordered with respect to PIO/MMIO
  accesses on another CPU, put the accesses inside a spin-locked
  region, and put a mmiowb() between the last access and the
  spin_unlock.

* smp_wmb() doesn't necessarily do any ordering of MMIO accesses
  vs. other accesses, and in that sense it is weaker than wmb().

Paul.
