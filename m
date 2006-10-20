Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423099AbWJTU1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423099AbWJTU1N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 16:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423230AbWJTU1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 16:27:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21465 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423099AbWJTU1M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 16:27:12 -0400
Date: Fri, 20 Oct 2006 13:23:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net>
Cc: jens.axboe@oracle.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH 2/2] cciss: disable dma prefetch for P600
Message-Id: <20061020132350.d49f7b22.akpm@osdl.org>
In-Reply-To: <20061020195618.GA13181@beardog.cca.cpqcorp.net>
References: <20061017211303.GB17874@beardog.cca.cpqcorp.net>
	<20061017171021.baea3c3f.akpm@osdl.org>
	<20061018165453.GA14255@beardog.cca.cpqcorp.net>
	<20061018143723.48510ea7.akpm@osdl.org>
	<20061020195618.GA13181@beardog.cca.cpqcorp.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2006 14:56:18 -0500
"Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net> wrote:

> ..
> > 
> > > > 
> > > > What is the actual problem which is being fixed here?
> > > 
> > > Sorry, I should have been clearer. There is a bug in the DMA engine that
> > > that may result in prefetching data from beyond the end of memory or
> > > falling off into one the holes on IPF and AMD. It causes a machine check
> > > when that happens.
> > > It doesn't happen on Proliant because the last 4kB (or so) of memory is
> > > mapped out by the BIOS and Pentium guarantees contiguous memory.
> > 
> > I think that this:
> > 
> > > > #if defined(CONFIG_IA64) || defined(CONFIG_X86_64)
> > 
> > is nowhere near strong enough and is probably inappropriate.
> > 
> > It _could_ be that CONFIG_DISCONTIGMEM|CONFIG_SPARSEMEM will be closer, but
> > even CONFIG_FLATMEM systems can have holes.
> 
> I'm poking around on some IPF platforms. It looks like CONFIG_DISCONTIGMEM is
> set on them, but not the others you mention. Would that be sufficient?

I don't think so.  All machines in all memory models can and do have holes
in their memory map.  I think the problem is that some machines object to
having those holes read from and others do not.  It could be that this
problem is purely an ia64 thing.

And it's not just holes: we had a problem a year or so back where CPU
prefetching was walking off the end of real mmeory and into the AGP region
and was causing weird cache coherency problems on x86_64 (or something like
that).

> > 
> > On what machines can/does this card exist?  Things like powerpc?
> 
> This problem was found on Itanium. We don't try to support powerpc.

Well the CCISS driver presently has no architecture Kconfig dependencies,
so anyone can build it on anything.  I don't know whether it's physically
possible to put a cciss controller into a power/sparc/whatever machine -
are these controllers only ever integrated onto the main boad?

Anyway, I'd suggest the best way of sorting this out is to come up with a
complete description of the problem, decide which architectures are
affected and to then ask the relevant architecture maintainers to recommend
a solution.

I think the description would be

  There is a bug in the DMA engine that that may result in prefetching
  data from beyond the end of memory or falling off into one the holes on
  IPF and AMD.  It causes a machine check when that happens.

  It doesn't happen on Proliant because the last 4kB (or so) of memory is
  mapped out by the BIOS and Pentium guarantees contiguous memory.

  If the platform is culnerable to this then driver's prefetching needs
  to be disabled at compile-time or, preferably, initialization-time.  What
  is the best means by which we can determine whether the platform needs
  this treatment?


(the patch didn't compile, btw: there's no definition of I2O0_DMA1_CFG)
