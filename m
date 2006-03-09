Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161014AbWCIDp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161014AbWCIDp3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 22:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161012AbWCIDp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 22:45:29 -0500
Received: from ozlabs.org ([203.10.76.45]:14001 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1161011AbWCIDp2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 22:45:28 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17423.42185.78767.837295@cargo.ozlabs.ibm.com>
Date: Thu, 9 Mar 2006 14:45:13 +1100
From: Paul Mackerras <paulus@samba.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: akpm@osdl.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
       mingo@redhat.com, Alan Cox <alan@redhat.com>, linuxppc64-dev@ozlabs.org
Subject: Re: [PATCH] Document Linux's memory barriers [try #2] 
In-Reply-To: <Pine.LNX.4.64.0603081716400.32577@g5.osdl.org>
References: <Pine.LNX.4.64.0603081115300.32577@g5.osdl.org>
	<20060308184500.GA17716@devserv.devel.redhat.com>
	<20060308173605.GB13063@devserv.devel.redhat.com>
	<20060308145506.GA5095@devserv.devel.redhat.com>
	<31492.1141753245@warthog.cambridge.redhat.com>
	<29826.1141828678@warthog.cambridge.redhat.com>
	<9834.1141837491@warthog.cambridge.redhat.com>
	<11922.1141842907@warthog.cambridge.redhat.com>
	<14275.1141844922@warthog.cambridge.redhat.com>
	<19984.1141846302@warthog.cambridge.redhat.com>
	<17423.30789.214209.462657@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0603081652430.32577@g5.osdl.org>
	<17423.32792.500628.226831@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0603081716400.32577@g5.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

> x86 mmiowb would have to be a real op too if there were any multi-pathed 
> PCI buses out there for x86, methinks.

Not if the manufacturers wanted to be able to run existing standard
x86 operating systems on it, surely.

I presume that on x86 the PCI host bridges and caches are all part of
the coherence domain, and that the rule about stores being observed in
order applies to what the PCI host bridge can see as much as it does
to any other agent in the coherence domain.  And if I have understood
you correctly, the store ordering rule applies both to stores to
regular cacheable memory and stores to noncacheable nonprefetchable
MMIO registers without distinction.

If that is so, then I don't see how the writel's can get out of order.
Put another way, we expect spinlock regions to order stores to regular
memory, and AFAICS the x86 ordering rules mean that the same guarantee
should apply to stores to MMIO registers.  (It's entirely possible
that I don't fully understand the x86 memory ordering rules, of
course. :)

> Basically, the issue boils down to one thing: no "normal" barrier will 
> _ever_ show up on the bus on x86 (ie ia64, afaik). That, together with any 

A spin_lock does show up on the bus, doesn't it?

> Would I want the hard-to-think-about IO ordering on a regular desktop 
> platform? No.

In fact I think that mmiowb can actually be useful on PPC, if we can
be sure that all the drivers we care about will use it correctly.

If we can have the following rules:

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

... then I can remove the sync from write*, which would be nice, and
make mmiowb() be a sync.  I wonder how long we're going to spend
chasing driver bugs after that, though. :)

Paul.
