Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937567AbWLFT62@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937567AbWLFT62 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 14:58:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937580AbWLFT62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 14:58:28 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:2194 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937567AbWLFT61 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 14:58:27 -0500
Date: Wed, 6 Dec 2006 19:58:20 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Christoph Lameter <clameter@sgi.com>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch doesn't support it
Message-ID: <20061206195820.GA15281@flint.arm.linux.org.uk>
Mail-Followup-To: Christoph Lameter <clameter@sgi.com>,
	David Howells <dhowells@redhat.com>, torvalds@osdl.org,
	akpm@osdl.org, linux-arm-kernel@lists.arm.linux.org.uk,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20061206164314.19870.33519.stgit@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0612061054360.27047@schroedinger.engr.sgi.com> <20061206190025.GC9959@flint.arm.linux.org.uk> <Pine.LNX.4.64.0612061111130.27263@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612061111130.27263@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2006 at 11:16:55AM -0800, Christoph Lameter wrote:
> On Wed, 6 Dec 2006, Russell King wrote:
> 
> > On Wed, Dec 06, 2006 at 10:56:14AM -0800, Christoph Lameter wrote:
> > > I'd really appreciate a cmpxchg that is generically available for 
> > > all arches. It will allow lockless implementation for various performance 
> > > criticial portions of the kernel.
> > 
> > Let's recap on cmpxchg.
> > 
> > For CPUs with no atomic operation other than SWP, it is not lockless.
> 
> But then its also just requires disable/enable interrupts on UP which may 
> be cheaper than an atomic operation.

No.  SWP is atomic on the CPU it's being issued on, especially wrt
interrupts.  Only on one ARM CPU (which is UP) does it have a
questionable use, and there we do it via interrupt disable/enable.

> > For CPUs with load locked + store conditional, it is expensive.
> 
> Because it locks the bus? I am not that familiar with those architectures 
> but it seems that those will have a general problem anyways.

No.  That certainly would be bad for performance.  I can talk
authoritively from the ARM implementation.

When you use a special "ldrex" (load exclusive) instruction, the
CPU remembers the "address + cpu" pair.  If another access occurs
to the same address, this state is reset.

Only if this state is preserved will a "strex" (store exclusive)
instruction succeed.  This instruction returns status indicating
whether it succeeded.

So, to implement cmpxchg, you need to do this:

	; r1 = temporary register
	; r2 = address
	; r4 = new value
	; r3 = returned status
	ldrex	r1, [r2]
	cmp	r1, old_value
	streqex	r3, r4, [r2]

> > If you want an operation for performance critical portions of the
> > kernel, please allow architecture maintainers the freedom to use their
> > best performance enhancements.
> 
> And thereby denying the kernel developers to use a simple atomic SMP 
> operation? Adding additional defines for each arch and each performance 
> critical piece of kernel logic?

No.  If you read what I said, you'll see that you can _cheaply_ use
cmpxchg in a ll/sc based implementation.  Take an atomic increment
operation.

	do {
		old = load_locked(addr);
	} while (store_exclusive(old, old + 1, addr);

On a cmpxchg, that "store_exclusive" (loosely) becomes your cmpxchg
instruction, comparing the first arg, and if equal storing the second.
The "load_locked" macro becomes a standard pointer deref.  Ergo, x86
becomes:

	do {
		load value
		manipulate it
		conditional store
	} while not stored

On ll/sc, the load_locked() macro is the load locked instruction.  The
store_exclusive() macro is the exclusive store and it doesn't need to
use the first parameter at all.  Ergo, ARM becomes:

	do {
		ldrex r1, [r2]
		manipulate r1
		strex r0, r1, [r2]
	} while failed

Notice that both are optimal.

Now let's consider the cmpxchg case.

	do {
		val = *addr;
	} while (cmpxchg(val, val + 1, addr);

The x86 case is _identical_ to the ll/sc based implementation.  Absolutely
entirely.  No impact what so ever.

Let's look at the ll/sc case.  The cmpxchg code implemented on this has
to reload the original value, compare it, if equal store the new value.
So:

	do {
		val = *addr;
		(r2 = addr, 
		ldrex r1, [r2]
		compare r1, r0
		strexeq r4, r3, [r2] (store exclusive if equal)
	} while store failed or comparecondition failed

Note how the cmpxchg has _forced_ the ll/sc implementation to become
more complex.

So, let's recap.

Implementing ll/sc based accessor macros allows both ll/sc _and_ cmpxchg
architectures to produce optimal code.

Implementing an cmpxchg based accessor macro allows cmpxchg architectures
to produce optimal code and ll/sc non-optimal code.

See my point?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
