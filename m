Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750871AbWIKVc6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbWIKVc6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 17:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbWIKVc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 17:32:58 -0400
Received: from gate.crashing.org ([63.228.1.57]:15795 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750820AbWIKVc5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 17:32:57 -0400
Subject: Re: Opinion on ordering of writel vs. stores to RAM
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, David Miller <davem@davemloft.net>,
       jeff@garzik.org, paulus@samba.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org, segher@kernel.crashing.org
In-Reply-To: <200609111108.18138.jbarnes@virtuousgeek.org>
References: <17666.11971.416250.857749@cargo.ozlabs.ibm.com>
	 <200609101725.49234.jbarnes@virtuousgeek.org>
	 <1157936412.31071.282.camel@localhost.localdomain>
	 <200609111108.18138.jbarnes@virtuousgeek.org>
Content-Type: text/plain
Date: Tue, 12 Sep 2006 07:32:10 +1000
Message-Id: <1158010331.3879.56.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-09-11 at 11:08 -0700, Jesse Barnes wrote:
> On Sunday, September 10, 2006 6:00 pm, Benjamin Herrenschmidt wrote:
> > > If we accept this, I don't think we're much better off than we are
> > > currently (not that I have a problem with that).  That is, many
> > > drivers
> > > would still need to be fixed up.
> >
> > Not necessarily if you introduce the trick of doing the mmiowb() in
> > spin_unlock when a per-cpu flag has been set previously by writel... not
> > sure if it's worth tho.
> 
> True, though again this would add a branch to writeX.

No, it adds a cacheable store to writeX and a branch to spin_unlock

> Sure, that's where one would typically use it, but it really is a memory 
> barrier...

I prefer having separate semantics for it so people understand it better
but I may be wrong :)

> That's because it *is* a barrier.  I don't think it's any harder to understand 
> then regular memory barriers for example.  It's just that you'd typically use 
> it in conjunction with locks to ensure proper device access.

That's why I prefer defining it as a MMIO + lock barrier.

> Ok, that's fine, though I think you'd only want the very weak semantics (as 
> provided by your __raw* routines) on write combined memory typically?

Well, that and memory with no side effects (like frame buffers)

> > I'm very much against your terminology. It's -not- an IO to IO barrier.
> > It's an IO to lock barrier. Really. IO to IO is something else. ordering
> > of IOs between CPUs has absolutely no meaning outside of the context of
> > locked regions in any case.
> 
> But it *is* MMIO vs. MMIO.  There's confusion because your __raw* routines 
> don't even guarantee same CPU ordering, while mmiowb() is solely intended for 
> inter-CPU ordering.
> 
> But as you say, the most common (maybe only) use model for it is to make sure 
> critical sections protecting device access behave correctly, so I don't have 
> a problem tying it to locks somehow.

Ben.


