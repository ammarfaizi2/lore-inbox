Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbWIILQ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWIILQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 07:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbWIILQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 07:16:29 -0400
Received: from ozlabs.org ([203.10.76.45]:47268 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751309AbWIILQ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 07:16:28 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17666.41604.944078.556991@cargo.ozlabs.ibm.com>
Date: Sat, 9 Sep 2006 21:16:20 +1000
From: Paul Mackerras <paulus@samba.org>
To: David Miller <davem@davemloft.net>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
       akpm@osdl.org, segher@kernel.crashing.org
Subject: Re: Opinion on ordering of writel vs. stores to RAM
In-Reply-To: <20060909.023405.71099525.davem@davemloft.net>
References: <17666.8433.533221.866510@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0609081928570.27779@g5.osdl.org>
	<17666.11971.416250.857749@cargo.ozlabs.ibm.com>
	<20060909.023405.71099525.davem@davemloft.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller writes:

> From: Paul Mackerras <paulus@samba.org>
> Date: Sat, 9 Sep 2006 13:02:27 +1000
> 
> > I suspect the best thing at this point is to move the sync in writeX()
> > before the store, as you suggest, and add an "eieio" before the load
> > in readX().  That does mean that we are then relying on driver writers
> > putting in the mmiowb() between a writeX() and a spin_unlock, but at
> > least that is documented.
> 
> I think not matching what PC systems do is, at least from one
> perspective, a very bad engineering decision for 2 reasons.

Well, I believe that my suggestion *does* match what PC systems do.
It will mean that writes to memory are ordered with respect to
following MMIO writes.  MMIO writes aren't ordered with respect to
following stores to memory, but then nobody sane expects that if you
do a writel() then a store to memory, the writel will hit the device
before the store hits memory; even PC systems do PCI write posting.

As for the writel followed by spin_unlock thing, Ben and I have an
idea for some debug code that will detect at runtime if someone does a
writel followed by a spin_unlock without a readl, spin_lock or mmiowb
in between.

The main question I'm trying to decide at the moment is whether to
make the change for 2.6.18 or not...  If not then I'd like to get the
wmb() into tg3.c temporarily to fix that particular data corruption
problem.

Paul.
