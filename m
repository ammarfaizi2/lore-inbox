Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751071AbWCIB5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbWCIB5o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 20:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbWCIB5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 20:57:44 -0500
Received: from ozlabs.org ([203.10.76.45]:54184 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751062AbWCIB5l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 20:57:41 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17423.35719.758492.297725@cargo.ozlabs.ibm.com>
Date: Thu, 9 Mar 2006 12:57:27 +1100
From: Paul Mackerras <paulus@samba.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: akpm@osdl.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, mingo@redhat.com,
       Alan Cox <alan@redhat.com>, linuxppc64-dev@ozlabs.org
Subject: Re: [PATCH] Document Linux's memory barriers [try #2]
In-Reply-To: <200603081655.13672.jbarnes@virtuousgeek.org>
References: <Pine.LNX.4.64.0603081115300.32577@g5.osdl.org>
	<19984.1141846302@warthog.cambridge.redhat.com>
	<17423.30789.214209.462657@cargo.ozlabs.ibm.com>
	<200603081655.13672.jbarnes@virtuousgeek.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes writes:

> On Wednesday, March 8, 2006 4:35 pm, Paul Mackerras wrote:
> > David Howells writes:
> > > On NUMA PowerPC, should mmiowb() be a SYNC or an EIEIO instruction
> > > then? Those do inter-component synchronisation.
> >
> > We actually have quite heavy synchronization in read*/write* on PPC,
> > and mmiowb can safely be a no-op.  It would be nice to be able to have
> > lighter-weight synchronization, but I'm sure we would see lots of
> > subtle driver bugs cropping up if we did.  write* do a full memory
> > barrier (sync) after the store, and read* explicitly wait for the data
> > to come back before.
> >
> > If you ask me, the need for mmiowb on some platforms merely shows that
> > those platforms' implementations of spinlocks and read*/write* are
> > buggy...
> 
> Or maybe they just wanted to keep them fast.  I don't know why you 
> compromised so much in your implementation of read/write and 
> lock/unlock, but given how expensive synchronization is, I'd think it 
> would be better in the long run to make the barrier types explicit (or 
> at least a subset of them) to maximize performance.

The PPC read*/write* and in*/out* aim to implement x86 semantics, in
order to minimize the number of subtle driver bugs that only show up
under heavy load.

I agree that in the long run making the barriers more explicit is a
good thing.

> The rules for using 
> the barriers really aren't that bad... for mmiowb() you basically want 
> to do it before an unlock in any critical section where you've done PIO 
> writes.  

Do you mean just PIO, or do you mean PIO or MMIO writes?

> Of course, that doesn't mean there isn't confusion about existing 
> barriers.  There was a long thread a few years ago (Jes worked it all 
> out, iirc) regarding some subtle memory ordering bugs in the tty layer 
> that ended up being due to ia64's very weak spin_unlock ordering 
> guarantees (one way memory barrier only), but I think that's mainly an 
> artifact of how ill defined the semantics of the various arch specific 
> routines are in some cases.

Yes, there is a lot of confusion, unfortunately.  There is also some
difficulty in defining things to be any different from what x86 does.

> That's why I suggested in an earlier thread that you enumerate all the 
> memory ordering combinations on ppc and see if we can't define them all.  

The main difficulty we strike on PPC is that cacheable accesses tend
to get ordered independently of noncacheable accesses.  The only
instruction we have that orders cacheable accesses with respect to
noncacheable accesses is the sync instruction, which is a heavyweight
"synchronize everything" operation.  It acts as a full memory barrier
for both cacheable and noncacheable loads and stores.

The other barriers we have are the lwsync instruction and the eieio
instruction.  The lwsync instruction (light-weight sync) acts as a
memory barrier for cacheable loads and stores except that it allows a
following load to go before a preceding store.

The eieio instruction has two separate and independent effects.  It
acts as a full barrier for accesses to noncacheable nonprefetchable
memory (i.e. MMIO or PIO registers), and it acts as a write barrier
for accesses to cacheable memory.  It doesn't do any ordering between
cacheable and noncacheable accesses though.

There is also the isync (instruction synchronize) instruction, which
isn't explicitly a memory barrier.  It prevents any following
instructions from executing until the outcome of any previous
conditional branches are known, and until it is known that no previous
instruction can generate an exception.  Thus it can be used to create
a one-way barrier in spin_lock and read*.

> Then David can roll the implicit ones up into his document, or we can 
> add the appropriate new operations to the kernel.  Really getting 
> barriers right shouldn't be much harder than getting DMA mapping right, 
> from a driver writers POV (though people often get that wrong I guess).

Unfortunately, if you get the barriers wrong your driver will still
work most of the time on pretty much any machine, whereas if you get
the DMA mapping wrong your driver won't work at all on some machines.
Nevertheless, we should get these things defined properly and then try
to make sure drivers do the right things.

Paul.
