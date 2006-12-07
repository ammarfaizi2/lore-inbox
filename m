Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032294AbWLGPDW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032294AbWLGPDW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 10:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032297AbWLGPDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 10:03:22 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:3052 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032294AbWLGPDV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 10:03:21 -0500
Date: Thu, 7 Dec 2006 15:03:03 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Christoph Lameter <clameter@sgi.com>, David Howells <dhowells@redhat.com>,
       torvalds@osdl.org, akpm@osdl.org,
       linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch doesn't support it
Message-ID: <20061207150303.GB1255@flint.arm.linux.org.uk>
Mail-Followup-To: Nick Piggin <nickpiggin@yahoo.com.au>,
	Christoph Lameter <clameter@sgi.com>,
	David Howells <dhowells@redhat.com>, torvalds@osdl.org,
	akpm@osdl.org, linux-arm-kernel@lists.arm.linux.org.uk,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20061206164314.19870.33519.stgit@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0612061054360.27047@schroedinger.engr.sgi.com> <20061206190025.GC9959@flint.arm.linux.org.uk> <Pine.LNX.4.64.0612061111130.27263@schroedinger.engr.sgi.com> <20061206195820.GA15281@flint.arm.linux.org.uk> <4577DF5C.5070701@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4577DF5C.5070701@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2006 at 08:31:08PM +1100, Nick Piggin wrote:
> Russell King wrote:
> >On Wed, Dec 06, 2006 at 11:16:55AM -0800, Christoph Lameter wrote:
> 
> >No.  If you read what I said, you'll see that you can _cheaply_ use
> >cmpxchg in a ll/sc based implementation.  Take an atomic increment
> >operation.
> >
> >	do {
> >		old = load_locked(addr);
> >	} while (store_exclusive(old, old + 1, addr);
> >
> >On a cmpxchg, that "store_exclusive" (loosely) becomes your cmpxchg
> >instruction, comparing the first arg, and if equal storing the second.
> >The "load_locked" macro becomes a standard pointer deref.  Ergo, x86
> >becomes:
> >
> >	do {
> >		load value
> >		manipulate it
> >		conditional store
> >	} while not stored
> >
> >On ll/sc, the load_locked() macro is the load locked instruction.  The
> >store_exclusive() macro is the exclusive store and it doesn't need to
> >use the first parameter at all.  Ergo, ARM becomes:
> >
> >	do {
> >		ldrex r1, [r2]
> >		manipulate r1
> >		strex r0, r1, [r2]
> >	} while failed
> >
> >Notice that both are optimal.
> >
> >Now let's consider the cmpxchg case.
> >
> >	do {
> >		val = *addr;
> >	} while (cmpxchg(val, val + 1, addr);
> >
> >The x86 case is _identical_ to the ll/sc based implementation.  Absolutely
> >entirely.  No impact what so ever.
> >
> >Let's look at the ll/sc case.  The cmpxchg code implemented on this has
> >to reload the original value, compare it, if equal store the new value.
> >So:
> >
> >	do {
> >		val = *addr;
> >		(r2 = addr, 
> >		ldrex r1, [r2]
> >		compare r1, r0
> >		strexeq r4, r3, [r2] (store exclusive if equal)
> >	} while store failed or comparecondition failed
> >
> >Note how the cmpxchg has _forced_ the ll/sc implementation to become
> >more complex.
> >
> >So, let's recap.
> >
> >Implementing ll/sc based accessor macros allows both ll/sc _and_ cmpxchg
> >architectures to produce optimal code.
> >
> >Implementing an cmpxchg based accessor macro allows cmpxchg architectures
> >to produce optimal code and ll/sc non-optimal code.
> >
> >See my point?
> 
> Wrong. Your ll/sc implementation with cmpxchg is buggy. The cmpxchg
> load_locked is not locked at all,

Intentional - cmpxchg architectures don't generally have a load locked.

> and there can be interleaving writes
> between the load and cmpxchg which do not cause the store_conditional
> to fail.

In which case the cmpxchg fails and we do the atomic operation again,
in exactly the same way that we do the operation again if the 'sc'
fails in the ll/sc case.

I do not see any problem.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
