Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbUCQSNM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 13:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbUCQSNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 13:13:12 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:7166 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261779AbUCQSNG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 13:13:06 -0500
Subject: Re: boot time node and memory limit options
From: Dave Hansen <haveblue@us.ibm.com>
To: Jesse Barnes <jbarnes@sgi.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Robert Picco <Robert.Picco@hp.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthew Dobson <colpatch@us.ibm.com>
In-Reply-To: <20040317175134.GA23153@sgi.com>
References: <4057392A.8000602@hp.com> <20040316174329.GA29992@sgi.com>
	 <34060000.1079465992@flay> <405879BC.7060904@hp.com>
	 <1745150000.1079541412@[10.10.2.4]> <1079543385.5789.152.camel@nighthawk>
	 <20040317175134.GA23153@sgi.com>
Content-Type: text/plain
Message-Id: <1079547171.5789.307.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 17 Mar 2004 10:12:51 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-03-17 at 09:51, Jesse Barnes wrote:
> In some cases (ia64 for example) there are additional restrictions on
> each memory chunk.  For example, the EFI memory map may describe a
> contiguous chunk of memory 28MB in size, but if your kernel page size
> was set to 64MB, you'd have to throw it away as unusable.  Should that
> be dealt with in the arch independent code (i.e. is similar stuff done
> on other platforms?) or is it best to only add sections that are usable?

I was really hoping that this mechanism can be as stupid about what it
contains as possible.  It's _just_ there to store the memory layout, and
wouldn't decide or implement policy for the architecture.

The "runt" section of memory should be added to the structures and
tracked.  If, for some random reason, another 36MB of contiguous memory
got added to it later, you could start to think about coalescing it with
the runt from before.

The place to ignore the runt is in your architecture code that sets up
the page tables.  Your arch code would, of course, be reading from this
layout code.

> > What I'd like to do is present a standard way for all of these
> > architectures to store the information that they need to record at boot
> > time, plus make something flexible enough that we can use it for stuff
> > at runtime when hotplug memory is involved.
> 
> That would be great, what you have below seems sensible.

Mostly sensible.  I definitely need to make sure that it can cover all
the cases.  The "section" terminology should probably be removed so that
we can use it for CONFIG_NONLINEAR, and we need to think about what
happens when conflicting sections are added.  For instance, it might be
valid to add RAM from 0-4GB, then reserve 3.75-4GB later on for PCI
space.  Also, the code currently leaves "undefined" sections instead of
creating holes.  That can be dealt with later. 

Anyway, I'm not too attached to that code, it just realizes an idea that
I have.

> > The code I'd like to see go away from boot-time is anything that deals
> > with arch-specific structures like the e820, functions like
> > lmb_end_of_DRAM(), or any code that deals with zholes.  I'd like to get
> > it to a point where we can do a mostly arch-independent mem=.  
> 
> So what you have here would be only for boot time setup, while
> CONFIG_NONLINEAR would be used in lieu of multiple pgdats per node or a
> virtual memmap in the case of intranode discontiguous memory?

Well, I was hoping that whatever we use at boot-time could stick around
for runtime.  I'd like to get to the point where the interface for
bringing up boot-time memory is the same for hotplugging memory.  (for
2.7, of course)

Just as with the CPU hotplug code, having separate code paths for
hotplug memory is asking for trouble, because the coverage will never be
as high as the generic boot case.  

-- dave

