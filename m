Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964988AbWIIWgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964988AbWIIWgl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 18:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964986AbWIIWgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 18:36:41 -0400
Received: from gate.crashing.org ([63.228.1.57]:51349 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964985AbWIIWgj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 18:36:39 -0400
Subject: Re: TG3 data corruption (TSO ?)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
Cc: mchan@broadcom.com, segher@kernel.crashing.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, paulus@samba.org
In-Reply-To: <20060909.022228.41644790.davem@davemloft.net>
References: <9EAEC3B2-260E-444E-BCA1-3C9806340F65@kernel.crashing.org>
	 <1157745256.5344.8.camel@rh4>
	 <1157751962.31071.102.camel@localhost.localdomain>
	 <20060909.022228.41644790.davem@davemloft.net>
Content-Type: text/plain
Date: Sun, 10 Sep 2006 08:36:06 +1000
Message-Id: <1157841367.31071.182.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-09-09 at 02:22 -0700, David Miller wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date: Sat, 09 Sep 2006 07:46:02 +1000
> 
> > I don't think that in general, you have ordering guarantees between
> > cacheable and non-cacheable stores unless you use explicit barriers.
> 
> In fact, on most systems you absolutely do have ordering between
> MMIO and memory accesses.

Well, at least powerpc and ia64 don't in hw, I don't know about
others... out of order in general is getting fascionable in processor
design ... 

> So you are making an extremely poor engineering decision
> by trying to fixup all the drivers to match PowerPC's
> semantics.  I think a smart engineer would decrease his
> debugging burdon, by matching his platform's MMIO accessors
> such that it matches what other platforms do and therefore
> inheriting the testing coverage provided by all platforms.
> 
> Otherwise you will be hunting down these kinds of memory
> barrier issues forever.

Well, some of you (Alan, you, etc...) seem to imply that it's always
been the rule to have a memory store followed by an MMIO write be
strongly ordered.

However, if you look at drivers like e1000, USB OHCI, or even sungem
(:-) they, all have at least wmb()'s between updating descriptor in
memory and the MMIO that triggers reading those by the chip. So it seems
that I'm not the only one to have thought otherwise ;-) More
specificaly, at least ia64 I think, like PowerPC, assumes no ordering
requirement here. So they would need fixing too.

My main problem is the cost... it's actually very expensive to do that
sort of synchronisation. I don't know for ia64 or other potentially out
of order architectures, but we do introduced a measureable performance
hit by adding the one we already have to guard against spin_unlock.

So if we decide to go the way of making writel synchronous vs. previous
MMIOs, I'd really like to have a clearly defined "relaxed" version as
well.

However, I'm not sure any of our current "relaxed" accessor have clear
semantics. At least what is implemented currently on PowerPC is the
__raw_* versions which not only have no barriers at all (they don't even
order between MMIOs, for example, readl might cross writel), and do no
endian swap. Quite a mess of semantics if you ask me... Then there has
been talks about those *_relaxed operations but those are more a match
to the relaxed PCI-X and PCI-E cycels, that is they relax ordering vs.
requests in a different direction on the bus, they have nothing to do
with storage domains on the CPU.

Ben.


