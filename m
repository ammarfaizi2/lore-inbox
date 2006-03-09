Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932673AbWCIE0d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932673AbWCIE0d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 23:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932670AbWCIE0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 23:26:33 -0500
Received: from detroit.securenet-server.net ([209.51.153.26]:54712 "EHLO
	detroit.securenet-server.net") by vger.kernel.org with ESMTP
	id S932102AbWCIE0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 23:26:32 -0500
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Document Linux's memory barriers [try #2]
Date: Wed, 8 Mar 2006 20:26:29 -0800
User-Agent: KMail/1.9.1
Cc: akpm@osdl.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, mingo@redhat.com,
       Alan Cox <alan@redhat.com>, linuxppc64-dev@ozlabs.org
References: <Pine.LNX.4.64.0603081115300.32577@g5.osdl.org> <200603081655.13672.jbarnes@virtuousgeek.org> <17423.35719.758492.297725@cargo.ozlabs.ibm.com>
In-Reply-To: <17423.35719.758492.297725@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603082026.29725.jbarnes@virtuousgeek.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - detroit.securenet-server.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - virtuousgeek.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, March 08, 2006 5:57 pm, Paul Mackerras wrote:
> > The rules for using
> > the barriers really aren't that bad... for mmiowb() you basically
> > want to do it before an unlock in any critical section where you've
> > done PIO writes.
>
> Do you mean just PIO, or do you mean PIO or MMIO writes?

I'd have to check, but iirc it was just MMIO.  We assumed PIO (inX/outX) 
was defined to be very strongly ordered (and thus slow) in Linux.  But 
Linus is apparently flexible on that point for the new ioreadX/iowriteX 
stuff.

> Yes, there is a lot of confusion, unfortunately.  There is also some
> difficulty in defining things to be any different from what x86 does.

Well, Alpha has smp_barrier_depends or whatever, that's *really* funky.

> > That's why I suggested in an earlier thread that you enumerate all
> > the memory ordering combinations on ppc and see if we can't define
> > them all.
>
> The main difficulty we strike on PPC is that cacheable accesses tend
> to get ordered independently of noncacheable accesses.  The only
> instruction we have that orders cacheable accesses with respect to
> noncacheable accesses is the sync instruction, which is a heavyweight
> "synchronize everything" operation.  It acts as a full memory barrier
> for both cacheable and noncacheable loads and stores.

Ah, ok, sounds like your chip needs an ISA extension or two then. :)

> The other barriers we have are the lwsync instruction and the eieio
> instruction.  The lwsync instruction (light-weight sync) acts as a
> memory barrier for cacheable loads and stores except that it allows a
> following load to go before a preceding store.

This sounds like ia64 acquire semantics, a fence, but only in the 
downward direction.

> The eieio instruction has two separate and independent effects.  It
> acts as a full barrier for accesses to noncacheable nonprefetchable
> memory (i.e. MMIO or PIO registers), and it acts as a write barrier
> for accesses to cacheable memory.  It doesn't do any ordering between
> cacheable and noncacheable accesses though.

Weird, ok, so for cacheable stuff it's equivalent to ia64's release 
semantics, but has additional effects for noncacheable accesses.  Too 
bad it doesn't tie the two together somehow.

> There is also the isync (instruction synchronize) instruction, which
> isn't explicitly a memory barrier.  It prevents any following
> instructions from executing until the outcome of any previous
> conditional branches are known, and until it is known that no
> previous instruction can generate an exception.  Thus it can be used
> to create a one-way barrier in spin_lock and read*.

Hm, interesting.

> Unfortunately, if you get the barriers wrong your driver will still
> work most of the time on pretty much any machine, whereas if you get
> the DMA mapping wrong your driver won't work at all on some machines.
> Nevertheless, we should get these things defined properly and then
> try to make sure drivers do the right things.

Agreed.  Having a set of rules that driver writers can use would help 
too.  Given that PPC doesn't appear to have a lightweight way of 
synchronizing between I/O and memory accesses, it sounds like full 
syncs will be needed in a lot of cases.

Jesse
