Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932483AbWCHNUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932483AbWCHNUK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 08:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWCHNUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 08:20:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52873 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750933AbWCHNUI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 08:20:08 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <17422.19209.60360.178668@cargo.ozlabs.ibm.com> 
References: <17422.19209.60360.178668@cargo.ozlabs.ibm.com>  <31492.1141753245@warthog.cambridge.redhat.com> 
To: Paul Mackerras <paulus@samba.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       mingo@redhat.com, linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document Linux's memory barriers 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Wed, 08 Mar 2006 13:19:52 +0000
Message-ID: <28393.1141823992@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras <paulus@samba.org> wrote:

> By "memory accesses" do you mean accesses to system memory, or do you
> mean loads and stores - which may be to system memory, memory on an I/O
> device (e.g. a framebuffer) or to memory-mapped I/O registers?

Well, I meant all loads and stores, irrespective of their destination.

However, on i386, for example, you've actually got at least two different I/O
access domains, and I don't know how they impinge upon each other (IN/OUT vs
MOV).

> Enabling/disabling interrupts doesn't imply a barrier on powerpc, and
> nor does taking an interrupt or returning from one.

Surely it ought to, otherwise what's to stop accesses done with interrupts
disabled crossing with accesses done inside an interrupt handler?

> > +Either interrupt disablement (LOCK) and enablement (UNLOCK) will barrier
> ...
> I don't think this is right, and I don't think it is necessary to
> achieve the end you state, since a CPU will always see its own memory
> accesses in program order.

But what about a driver accessing some memory that its device is going to
observe under irq disablement, and then getting an interrupt immediately after
from that same device, the handler for which communicates with the device,
possibly then being broken because the CPU hasn't completed all the memory
accesses that the driver made while interrupts are disabled?

Alternatively, might it be possible for communications between two CPUs to be
stuffed because one took an interrupt that also modified common data before
the it had committed the memory accesses done under interrupt disablement?
This would suggest using a lock though.

I'm not sure that I can come up with a feasible example for this, but Alan Cox
seems to think that it's a valid problem too.

The only likely way I can see this being a problem is with unordered I/O
writes, which would suggest you have to place an mmiowb() before unlocking the
spinlock in such a case, assuming it is possible to get unordered I/O writes
(which I think it is).

> What does *F+*A mean?

Combined accesses.

> Well, the driver should *not* be doing *ADR at all, it should be using
> read[bwl]/write[bwl].  The architecture code has to implement
> read*/write* in such a way that the accesses generated can't be
> reordered.  I _think_ it also has to make sure the write accesses
> can't be write-combined, but it would be good to have that clarified.

Than what use mmiowb()?

Surely write combining and out-of-order reads are reasonable for cacheable
devices like framebuffers.

David
