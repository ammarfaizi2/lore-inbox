Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751395AbWCHOzl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbWCHOzl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 09:55:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751514AbWCHOzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 09:55:41 -0500
Received: from mx1.redhat.com ([66.187.233.31]:36563 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751289AbWCHOzk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 09:55:40 -0500
Date: Wed, 8 Mar 2006 09:55:06 -0500
From: Alan Cox <alan@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, mingo@redhat.com, alan@redhat.com,
       linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document Linux's memory barriers [try #2]
Message-ID: <20060308145506.GA5095@devserv.devel.redhat.com>
References: <31492.1141753245@warthog.cambridge.redhat.com> <29826.1141828678@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29826.1141828678@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2006 at 02:37:58PM +0000, David Howells wrote:
> + (*) reads can be done speculatively, and then the result discarded should it
> +     prove not to be required;

That might be worth an example with an if() because PPC will do this and if 
its a read with a side effect (eg I/O space) you get singed..

> +same set of data, but attempting not to use locks as locks are quite expensive.

s/are quite/is quite

and is quite confusing to read

> +SMP memory barriers are normally mere compiler barriers on a UP system because

s/mere//

Makes it easier to read if you are not 1st language English.

> +In addition, accesses to "volatile" memory locations and volatile asm
> +statements act as implicit compiler barriers.

Add

The use of volatile generates poorer code and hides the serialization in 
type declarations that may be far from the code. The Linux coding style therefore
strongly favours the use of explicit barriers except in small and specific cases.

> +SMP memory barriers are only compiler barriers on uniprocessor compiled systems
> +because it is assumed that a CPU will be apparently self-consistent, and will
> +order overlapping accesses correctly with respect to itself.

Is this true of IA-64 ??

> +There is no guarantee that some intervening piece of off-the-CPU hardware will
> +not reorder the memory accesses.  CPU cache coherency mechanisms should
> +propegate the indirect effects of a memory barrier between CPUs.

[For information on bus mastering DMA and coherency please read ....]

sincee have a doc on this

> +There are some more advanced barriering functions:

"barriering" ... ick,  barrier.

> +LOCKING FUNCTIONS
> +-----------------
> +
> +For instance all the following locking functions imply barriers:

s/For instance//

> + (*) spin locks
> + (*) R/W spin locks
> + (*) mutexes
> + (*) semaphores
> + (*) R/W semaphores
> +
> +In all cases there are variants on a LOCK operation and an UNLOCK operation.
> +
> + (*) LOCK operation implication:
> +
> +     Memory accesses issued after the LOCK will be completed after the LOCK
> +     accesses have completed.
> +
> +     Memory accesses issued before the LOCK may be completed after the LOCK
> +     accesses have completed.
> +
> + (*) UNLOCK operation implication:
> +
> +     Memory accesses issued before the UNLOCK will be completed before the
> +     UNLOCK accesses have completed.
> +
> +     Memory accesses issued after the UNLOCK may be completed before the UNLOCK
> +     accesses have completed.
> +
> + (*) LOCK vs UNLOCK implication:
> +
> +     The LOCK accesses will be completed before the UNLOCK accesses.
> +
> +And therefore an UNLOCK followed by a LOCK is equivalent to a full barrier, but
> +a LOCK followed by an UNLOCK isn't.
> +
> +Locks and semaphores may not provide any guarantee of ordering on UP compiled
> +systems, and so can't be counted on in such a situation to actually do anything
> +at all, especially with respect to I/O barriering, unless combined with
> +interrupt disablement operations.

s/disablement/disabling/

Should clarify local ordering v SMP ordering for locks implied here.


> +INTERRUPT DISABLEMENT FUNCTIONS
> +-------------------------------

s/Disablement/Disabling/

> +Interrupt disablement (LOCK equivalent) and enablement (UNLOCK equivalent) will

disable

> +===========================
> +LINUX KERNEL I/O BARRIERING

/barriering/barriers

> + (*) inX(), outX():
> +
> +     These are intended to talk to legacy i386 hardware using an alternate bus
> +     addressing mode.  They are synchronous as far as the x86 CPUs are

Not really true. Lots of PCI devices use them. Need to talk about "I/O space"
> +     concerned, but other CPUs and intermediary bridges may not honour that.
> +
> +     They are guaranteed to be fully ordered with respect to each other.

And make clear I/O space is a CPU property and that inX()/outX() may well map
to read/write variant functions on many processors

> + (*) readX(), writeX():
> +
> +     These are guaranteed to be fully ordered and uncombined with respect to
> +     each other on the issuing CPU, provided they're not accessing a

MTRRs

> +     prefetchable device.  However, intermediary hardware (such as a PCI
> +     bridge) may indulge in deferral if it so wishes; to flush a write, a read
> +     from the same location must be performed.

False. Its not so tightly restricted and many devices the location you write
is not safe to read so you must use another. I'd have to dig the PCI spec 
out but I believe it says the same devfn. It also says stuff about rules for
visibility of bus mastering relative to these accesses and PCI config space
accesses relative to the lot (the latter serveral chipsets get wrong). We
should probably point people at the PCI 2.2 spec .

Looks much much better than the first version and just goes to prove how complex
this all is

