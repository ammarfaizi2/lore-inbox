Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbWIKDyT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWIKDyT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 23:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbWIKDyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 23:54:19 -0400
Received: from gate.crashing.org ([63.228.1.57]:17572 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750809AbWIKDyS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 23:54:18 -0400
Subject: Re: Opinion on ordering of writel vs. stores to RAM
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, David Miller <davem@davemloft.net>,
       jeff@garzik.org, paulus@samba.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <21EFB791-B046-4EE0-8D93-8D0BA37C1D46@kernel.crashing.org>
References: <17666.11971.416250.857749@cargo.ozlabs.ibm.com>
	 <1157916919.23085.24.camel@localhost.localdomain>
	 <1157923513.31071.256.camel@localhost.localdomain>
	 <200609101725.49234.jbarnes@virtuousgeek.org>
	 <0828ADEB-0F0E-49FC-82BE-CFA15B7D3829@kernel.crashing.org>
	 <1157937023.31071.289.camel@localhost.localdomain>
	 <21EFB791-B046-4EE0-8D93-8D0BA37C1D46@kernel.crashing.org>
Content-Type: text/plain
Date: Mon, 11 Sep 2006 13:53:37 +1000
Message-Id: <1157946817.31071.381.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-09-11 at 03:48 +0200, Segher Boessenkool wrote:

> > Ordering between stores issued by different CPUs has no meaning
> > whatsoever unless you have locks. That is you have some kind of
> > synchronisation primitive between the 2 CPUs.
> 
> And that's exactly what mmiowb() does right now -- it makes sure
> the I/O ends up at some I/O hub that will keep the accesses in
> order, before it allows the current CPU to continue.

No. mmiowb isn't itself a synchronisation primitive between CPUs. It's a
barrier. The lock enclosing the MMIOs is the synchronisation primitive.
mmiowb() makes it actually work with MMIOs since otherwise, MMIO stores
might "leak" out of the lock.

There is no concept of ordering between a flow of stores from 2 CPUs.
There is no "before" or "after" (or rather, they aren't defined) unless
you create a common "t0" reference, in which case you can indeed say
wether a given store on a given side is before or after this "t0".

This common reference can only excist if code on -both- sides actually
implement it, that is, it has to appear somewhere in the program to have
any meaning.

mmiowb() doesn't do that. The spinlock does. That's the referene. That's
what crates a concept of "before" and "after" (or rather "inside" or
"outside"). mmiowb() is merely an implementation detail to make this
actually work when MMIOs are involved.
 
> Aaaaaaaanyway...  the question of what to call mmiowb() and what its
> exact semantics would become, is a bit of a side issue right now, let's
> discuss it later...

See my proposed document with explicit semantics.

Ben.


