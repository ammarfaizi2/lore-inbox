Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263112AbUB1DSR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 22:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263113AbUB1DSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 22:18:17 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:42212 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263112AbUB1DSO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 22:18:14 -0500
Subject: Re: 2.6.3-mm3 (ioremap failure w/ _X86_4G and _NUMA)
From: Dave Hansen <haveblue@us.ibm.com>
To: John Stultz <johnstul@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1077936504.10076.63.camel@cog.beaverton.ibm.com>
References: <20040222172200.1d6bdfae.akpm@osdl.org>
	 <1077924860.10076.49.camel@cog.beaverton.ibm.com>
	 <20040227160613.17be31cb.akpm@osdl.org>
	 <1077936504.10076.63.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Message-Id: <1077938284.24528.12.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 27 Feb 2004 19:18:05 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-02-27 at 18:48, john stultz wrote:
> On Fri, 2004-02-27 at 16:06, Andrew Morton wrote:
> > john stultz <johnstul@us.ibm.com> wrote:
> > >
> > > When running -mm3 (plus the one-line fix to the expanded-pci-config
> > > patch) to on an x440  w/ 4G enabled, the tg3 driver cannot find my
> > > network card. 
> > > 
> > > When booting I get:
> > > tg3.c:v2.7 (February 17, 2004)                
> > > tg3: Cannot map device registers, aborting.
> > > tg3: probe of 0000:01:04.0 failed with error -12
> > > 
> > > Otherwise the system seems to come up fine. 
> > > 
> > > Disabling CONFIG_ACPI (or CONFIG_X86_4G) makes the problem go away.
> > 
> > Beats me.  Maybe acpi is returning some monstrous reosurce length and we're
> > running out of kernel virtual space only with the 4g split?
> > 
> > 'twould be appreciated if you could stick a few printk's in there and work
> > out what's happening please.  Check out the pci space base address and
> > length with and without ACPI?
> 
> The base address and length are the same either way, instead its
> __ioremap that's failing at "if(!PageReserved(page))"[ioremap.c:142].
> 
> I've also narrowed down the issue to only occur w/ (CONFIG_X86_4G=y &&
> CONFIG_NUMA=y) so it looks like its a propblem w/ 4G and discontigmem
> together. 
> 
> I've also finally moved to -mm4 and reproduced the problem there.

Can you dump out all of the variables in the 
	if (phys_addr < virt_to_phys(high_memory)) {
	...
statement, plus the arguments that ioremap() is getting?

Evidently, it's OK if highmem pages aren't PageReserved(), and I'm
starting to wonder if you've done something rare, like spanned the
highmem boundary with your ioremap().  

We do some weird stuff with that highmem boundary when NUMA is on,
because we remap a bunch of mem_map[] in that area to get it local on
NUMA nodes which might be causing something unexpected.  Take a look and
see if any of the variables that __ioremap() is using correspond to
those that remap_numa_kva() is playing with (from your boot log):
node 0 will remap to vaddr f8000000 - f8000000
node 1 will remap to vaddr f5600000 - f8000000
High memory starts at vaddr f8000000    

It's just a guess.  

-- dave

