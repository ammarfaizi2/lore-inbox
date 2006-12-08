Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425404AbWLHLO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425404AbWLHLO0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 06:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S938041AbWLHLO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 06:14:26 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:2589 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S938038AbWLHLOZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 06:14:25 -0500
Date: Fri, 8 Dec 2006 11:14:11 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, davem@davemloft.com,
       wli@holomorphy.com, matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 3/3] WorkStruct: Use direct assignment rather than cmpxchg()
Message-ID: <20061208111410.GA31068@flint.arm.linux.org.uk>
Mail-Followup-To: David Howells <dhowells@redhat.com>,
	Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
	davem@davemloft.com, wli@holomorphy.com, matthew@wil.cx,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20061207234250.GH1255@flint.arm.linux.org.uk> <20061207085409.228016a2.akpm@osdl.org> <20061207153138.28408.94099.stgit@warthog.cambridge.redhat.com> <20061207153143.28408.7274.stgit@warthog.cambridge.redhat.com> <639.1165521999@redhat.com> <26012.1165535903@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26012.1165535903@redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2006 at 11:58:23PM +0000, David Howells wrote:
> Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> 
> > Incorrect.  pre-v6 ARM bitops for test_and_xxx_bit() all do:
> > 
> > 	save and disable irqs
> > 	load value
> > 	test bit
> > 	if not in desired state, alter bit and write it back
> > 	restore irqs
> 
> Hmmm...  ARM has two implementations.  One in the header files which is what I
> consulted when writing that email:
> 
> static inline void ____atomic_set_bit(unsigned int bit, volatile unsigned long *p)
> {
> 	unsigned long flags;
> 	unsigned long mask = 1UL << (bit & 31);
> 
> 	p += bit >> 5;
> 
> 	raw_local_irq_save(flags);
> 	*p |= mask;
> 	raw_local_irq_restore(flags);
> }
> 
> And the other in the libs which does as you say.  Why the one in the header
> file at all?

These are the constant versions, where the compiler can optimise the
mask and word offset itself.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
