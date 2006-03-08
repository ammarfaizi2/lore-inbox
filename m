Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932437AbWCHDbF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437AbWCHDbF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 22:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbWCHDbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 22:31:05 -0500
Received: from smtp.osdl.org ([65.172.181.4]:30909 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932424AbWCHDbE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 22:31:04 -0500
Date: Tue, 7 Mar 2006 19:30:33 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Mackerras <paulus@samba.org>
cc: David Howells <dhowells@redhat.com>, akpm@osdl.org, mingo@redhat.com,
       linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document Linux's memory barriers
In-Reply-To: <17422.19209.60360.178668@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.64.0603071918460.32577@g5.osdl.org>
References: <31492.1141753245@warthog.cambridge.redhat.com>
 <17422.19209.60360.178668@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 8 Mar 2006, Paul Mackerras wrote:
> 
> Linus explained recently that wmb() on x86 does not order stores to
> system memory w.r.t. stores to stores to prefetchable I/O memory (at
> least that's what I think he said ;).

In fact, it won't order stores to normal memory even wrt any 
_non-prefetchable_ IO memory.

PCI (and any other sane IO fabric, for that matter) will do IO posting, so 
the fact that the CPU _core_ may order them due to a wmb() doesn't 
actually mean anything.

The only way to _really_ synchronize with a store to an IO device is 
literally to read from that device (*). No amount of memory barriers will 
do it.

So you can really only order stores to regular memory wrt each other, and 
stores to IO memory wrt each other. For the former, "smp_wmb()" does it.

For IO memory, normal IO memory is _always_ supposed to be in program 
order (at least for PCI. It's part of how the bus is supposed to work), 
unless the IO range allows prefetching (and you've set some MTRR). And if 
you do, that, currently you're kind of screwed. mmiowb() should do it, but 
nobody really uses it, and I think it's broken on x86 (it's a no-op, it 
really should be an "sfence").

A full "mb()" is probably most likely to work in practice. And yes, we 
should clean this up.

		Linus

(*) The "read" can of course be any event that tells you that the store 
has happened - it doesn't necessarily have to be an actual "read[bwl]()" 
operation. Eg the store might start a command, and when you get the 
completion interrupt, you obviously know that the store is done, just from 
a causal reason.
