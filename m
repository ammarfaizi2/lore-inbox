Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751290AbWERHAk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbWERHAk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 03:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbWERHAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 03:00:39 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:34302 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751290AbWERHAi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 03:00:38 -0400
Date: Thu, 18 May 2006 03:00:03 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Christoph Lameter <clameter@sgi.com>
cc: LKML <linux-kernel@vger.kernel.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Paul Mackerras <paulus@samba.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@suse.de>,
       Martin Mares <mj@atrey.karlin.mff.cuni.cz>, bjornw@axis.com,
       schwidefsky@de.ibm.com, benedict.gaster@superh.com, lethal@linux-sh.org,
       Chris Zankel <chris@zankel.net>, Marc Gauthier <marc@tensilica.com>,
       Joe Taylor <joe@tensilica.com>,
       David Mosberger-Tang <davidm@hpl.hp.com>, rth@twiddle.net,
       spyro@f2s.com, starvik@axis.com, tony.luck@intel.com,
       linux-ia64@vger.kernel.org, ralf@linux-mips.org,
       linux-mips@linux-mips.org, grundler@parisc-linux.org,
       parisc-linux@parisc-linux.org, linuxppc-dev@ozlabs.org,
       linux390@de.ibm.com, davem@davemloft.net, arnd@arndb.de,
       kenneth.w.chen@intel.com, sam@ravnborg.org, kiran@scalex86.org
Subject: Re: [RFC PATCH 00/09] robust VM per_cpu variables
In-Reply-To: <Pine.LNX.4.64.0605171038160.13767@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0605180229050.30044@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0605170547490.8408@gandalf.stny.rr.com>
 <Pine.LNX.4.64.0605170744360.13021@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0605171104100.13160@gandalf.stny.rr.com>
 <Pine.LNX.4.64.0605170846190.13337@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0605171152190.15798@gandalf.stny.rr.com>
 <Pine.LNX.4.64.0605171038160.13767@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 17 May 2006, Christoph Lameter wrote:

> On Wed, 17 May 2006, Steven Rostedt wrote:
>
> > > Well I'd like to see a comprehensive solution including a fix for the
> > > problems with allocper_cpu() allocations (allocper_cpu has to allocate
> > > memory for potential processors... which could be a lot on
> > > some types of systems and its allocated somewhere not on the nodes of the
> > > processor since they may not yet be online).
> >
> > OK, now you're beyond what I'm working with ;)  No hot plug CPUs for me.
> > Well, at least not yet!
>
> You need to at least consider how this could be handled by the per_cpu
> memory manangement. The VM thingie with dynamic per cpu memory would allow
> a fixup of allocpercpu.
>

Last night, while aimlessly wondering the streets of Karlsruhe, I thought
of some ideas.  Maybe not very good ideas, but ideas never-the-less.

How about a hybrid?  Have the normal in kernel code use what is there
today, with the indirection.  Have modules and add on CPUs use an
allocated vm area.

Here's the thought:

  Have the boot time per_cpu variables (BTPCV) allocated like it is today.
  But make sure that they are paged align.

  Store away the initial values of per_cpu variables (PCV), for systems
  with hot pluggable CPUs.

  For modules, have a VM dedicated area. The assumption is that the
  modules will not have more PCVs than the kernel. Hopefully the PCVs
  of a module will not strain the TLB too much.  As long as the modules
  PCVs are separated per cpu the same as the BTPCV then this will work.
  We can even use the extra space that was added in the alignment,
  if the modules PCV section is small enough to fit.

  Now for allocated PCV for a hot plugged CPU.  We can dynamically
  allocate them when the CPU is loaded, and copy in the saved BTPCV.

The hotplug CPU handling might be hard to work with the module handling,
but both should be simple by themselves.  So if we concentrate on just the
hotplug first, then this might actually benefit you.

So, Allocate a page alligned BTPCV for each online CPU and copy the
section into them.  Keep the initial section around.

When a CPU comes on line, allocate the memory for the PCV in VM and copy
the saved BTPCV into it.  Then have the indirect pointer array (or CPU
private register/variable) point to this section.  It only puts strain on
the TLB of the newly online CPU, but it gives us the option of placing the
PCV into memory that we want (NUMA friendly).

So I should forget about the modules for now, and get a hotplug PCV
solution working.  All the archs would need to do is to give a VM address
where to store these variables. Hmm...

Thoughts?

-- Steve


