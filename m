Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbUEQV00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbUEQV00 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 17:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262103AbUEQV00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 17:26:26 -0400
Received: from emulex.emulex.com ([138.239.112.1]:41960 "EHLO
	emulex.emulex.com") by vger.kernel.org with ESMTP id S262085AbUEQV0I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 17:26:08 -0400
Message-ID: <3356669BBE90C448AD4645C843E2BF28034F9368@xbl.ma.emulex.com>
From: "Smart, James" <James.Smart@Emulex.Com>
To: "'Christoph Hellwig'" <hch@infradead.org>
Cc: "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: [(re)Announce] Emulex LightPulse Device Driver
Date: Mon, 17 May 2004 17:25:26 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: 'Christoph Hellwig' [mailto:hch@infradead.org]
> Sent: Friday, May 14, 2004 4:03 PM
>
> On Fri, May 14, 2004 at 03:51:14PM -0400, Smart, James wrote:
> >  - please explain USE_HGP_HOST_SLIM and why only ppc64 sets it,
> >    per-arch ifdefs in LLDDs are very suspect
> > 
> >      Our hardware allows for control structures to be 
> placed in adapter
> > 	 memory rather than host memory. In general, this is the most
> > 	 efficient mode of operation. USE_HGP_HOST_SLIM instructs us to
> > override
> > 	 this optimization and place them in host memory.
> > 	 For PPC64, to work around byte ordering issues 
> relative to how the
> > 	 hardware is accessing the control structures, we found 
> it easier to
> > 	 just use the unoptimized location.
> 
> Still not an explanation.  What exact issue is that?  Is is 
> just faster
> this way or doesn't it work another way?  Why is ppc64 so 
> different from
> other plattforms, e.g. why does ist this set when I boot my 
> (well, if I had
> one :)) G5 mac with a 64bit kernel and why not when I boot it 
> with a 32bit
> kernel?  As you mention byte ordering why is it not needed for other
> big endian system.

I'm tracking the details on this down. It's rather dated and prior to my
joining Emulex. It is possible that ppc64 was the only platform on Emulex's
support matrix that was subject to the issue. If this issue applies to other
architectures as well, we will obviously need to correct this (e.g. Emulex's
support matrix doesn't matter - we must do the right things for every
architecture).

 
> 
> > 
> >  - lpfc_clock.c should go away, just use add_timer/etc. diretly and
> >    embedd the timer into your structures.  Yes, I know that's not
> >    how SVR4-derivates work, but Linux does.  You also have an
> >    unchecked kmalloc and a list_head cast in there..
> > 
> >      It's not an SVR4 vs linux thing.  This wrapper 
> function does two
> > 	 things - start the timer, and allocate/link a small control
> > structure.
> > 	 The control structure allows us to just keep a record of every
> > 	 outstanding timer. This is a safety check, for driver
> > 	 unloads/kills/etc, to ensure that we have cancelled 
> all the timers
> > 	 that have been registered with the OS.
> 
> No.  The timer should be embedded into the object it's 
> associated with,
> and you must call del_timer_sync in the object destructor.  
> BTW, you have
> a lot of timers, more than the other fc drivers counted 
> together.  This
> looks slightly fishy.
> 

We could embed the timer into the associated object. This is mainly an
approach issue - it was just a simplistic choice to track the timers via the
hba object. Given the amount of code churn changing this would incur, I'm
inclined to ask why, other than for style and approach, must this be
changed?

As far as timer count goes... (shrug) we do manage discovery and port login
in the driver, which other driver's don't do, which adds quite a bit. We
could certainly delineate what we have and why...

> >  - lpfcDRVR_t should go away in favour of a bunch of global 
> variables
> > 
> >      Can you explain this comment further ?
> 
> You have a structure type lpfcDRVR_t but just a single global instance
> of it.  Aka the data structure is just obsfucation and each 
> member should
> be a driver-wide variable of it's own.

Ok - so I can see just killing the structure and making it's elements
globals. But, is this all you are asking ?  The elements are just a linked
list of the per-hba structures. You aren't recommending that we make arrays
of the per-hba structures are you ? 


> 
> > 
> >  - lpfc_linux_attach should be merged into lpfc_pci_detect, 
> which would
> >    better be named lpfc_{,pci_}probe{,one}
> > 
> > 	 We've kept this organization so it's more in line with the
> > 	 organization of the 2.4 driver. I don't see a real 
> need to change
> > 	 this.
> >      Note: we have renamed the probe functions...
> 
> It's really awkward to follow.  See qla1280.c to see how to 
> use 2.6-style
> probe/release calls in a 2.4ish enviroment.  Been there, done that.

Ok - so why is this a significant issue ?


> 
> > 
> >  - same for lpfc_linux_detach into lpfc_pci_release
> >      
> > 	 Same as last item
> 
> Dito.  Note that this one is especially awkward because of 
> the brainded
> pass index instead of object calling convention.

It is a little awkward, with the only difference whether the base structure
is found in the lpfc_pci_release routine or not. Still doesn't seem a
significant issue.

> 
> >  - you don't need a pci_pool per hba, just one per driver
> > 
> > 	 The pools are pre-dma mapped. As there are systems that require
> > 	 dma maps to be specific to the adapter using them, 
> we're maintaing
> > 	 a pool per hba.
> 
> Ok, braino.  Of course you're right, I was thinking of the mempool.
> 
> >  - four mempool per hba seems a little much, care to 
> explain why they're
> >    needed?
> > 
> >      These are the safety pools just mentioned. 1 pool is 
> for non-dma
> > 	 mapped structures - which are used during discovery. 
> The other 3
> > 	 pools are pre-dma mapped buffers - of different 
> allocation sizes
> > 	 (256 bytes, 1k, and 4k). It's just an optimization on 
> the amount
> > 	 of memory used by the pool. I'm sure there's other 
> methods, but...
> 
> Still doesn't say why they can't be global.  You'd need to uncomment
> mempool_resize in mm/mempool.c for that, though.

Also doesn't say they need to be global. Again - what's the significant
issue ? Seems to be just a style - whether things are done on a per-instance
basis or on a global basis. As the size requirements for this pool is based
on the number of instances - per-hba pools scales with far less effort when
more adapters are present. Growing/shrinking the pool each time an instance
attaches/detaches actually makes the global pool implementation more
complex. Coding for a global vs per-hba pool is roughly identical - the only
difference being whether the data structure is anchored globally or in the
per-hba structure.  And if you've already got per-hba pool code (the pre-dma
mapped pools), making the pool global seems to just add code.

