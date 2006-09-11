Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964870AbWIKBAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964870AbWIKBAm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 21:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964872AbWIKBAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 21:00:42 -0400
Received: from gate.crashing.org ([63.228.1.57]:11938 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964870AbWIKBAl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 21:00:41 -0400
Subject: Re: Opinion on ordering of writel vs. stores to RAM
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, David Miller <davem@davemloft.net>,
       jeff@garzik.org, paulus@samba.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org, segher@kernel.crashing.org
In-Reply-To: <200609101725.49234.jbarnes@virtuousgeek.org>
References: <17666.11971.416250.857749@cargo.ozlabs.ibm.com>
	 <1157916919.23085.24.camel@localhost.localdomain>
	 <1157923513.31071.256.camel@localhost.localdomain>
	 <200609101725.49234.jbarnes@virtuousgeek.org>
Content-Type: text/plain
Date: Mon, 11 Sep 2006 11:00:12 +1000
Message-Id: <1157936412.31071.282.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If we accept this, I don't think we're much better off than we are 
> currently (not that I have a problem with that).  That is, many
> drivers 
> would still need to be fixed up.

Not necessarily if you introduce the trick of doing the mmiowb() in
spin_unlock when a per-cpu flag has been set previously by writel... not
sure if it's worth tho.

> >  - __writel/__readl are totally relaxed between mem and IO, though
> > they still guarantee ordering between MMIO and MMIO. That
> guaranteed,
> > on powerpc, can be acheived by putting most of the burden in
> > __readl(), thus letting __writel() alone to still allow for write
> > combining. We still need to verify wether those semantics are
> > realistic on other out-of-order platforms. Jesse ?
> 
> Depends on what you mean by "ordered between MMIO and MMIO".
> mmiowb() 
> was initially introduced to allow ordering of writes between CPUs,
> and 
> really didn't say anything about memory vs. I/O, so the semantics you 
> describe here would also be different (and more expensive) than what
> we 
> have now.

No. What I mean is that two consecutive MMIO writes on the same CPU stay
in order, and reads can't cross writes. The relaxed versions would still
require mmiowb() (or another name) for synchronisation against
spinlocks. As I told you before, I much prefer to sync of mmiowb() as a
sync with locks than a sync with "other MMIOs on anotehr CPU" since that
doesn't mean anything outside of the context of a lock.

> This is what mmiowb() is supposed to be, though only for writes.
> I.e. 
> two writes from different CPUs may arrive out of order if you don't
> use 
> mmiowb() carefully.  Do you also need a mmiorb() macro or just a 
> stronger mmiob()?

No, you misunderstand me. That's the main problem with mmiowb() and
that's why it's so not clear to so many people: the way you keep
presenting it as synchronizing MMIO vs. MMIO. I think it's a lot more
clear if you present it as synchronizing MMIOs with locks. MMIO vs. MMIO
is anohter matter. It's wether consecutive MMIO writes can be
re-ordered, wether MMIO loads can cross a write (either because the load
is performed late, only when the value is actually used, or because the
load can be exucuted before a preceeding write). That's what current
__raw_* versions on PowerPC will allow, in addition to not doing endian
swap. My proposal was that __writel/__readl, however, would keep MMIO
vs. MMIO ordering (wouldn't allow that sort of re-ordering), however,
they wouldn't order vs. spinlock (would still require mmiowb) nor vs.
main memory (cacheable storage).

> >  - In order to provide explicit ordering with memory for the above,
> > we introduce mem_to_io_barrier() and io_to_mem_barrier(). It's still
> > unclear
> > wether to include mmiowb() as an equivalent here, that is wether the
> > spinlock
> > case has to be special cased vs. io_to_mem_barrier(). I need to get
> > Jesse input
> > on that one.
> 
> mmiowb() could be written as io_to_io_write_barrier() if we wanted to be 
> extra verbose.  AIUI it's the same thing as smb_wmb() but for MMIO 
> space.

I'm very much against your terminology. It's -not- an IO to IO barrier.
It's an IO to lock barrier. Really. IO to IO is something else. ordering
of IOs between CPUs has absolutely no meaning outside of the context of
locked regions in any case.

Cheers,
Ben.


