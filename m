Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262468AbUENUD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262468AbUENUD0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 16:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbUENUD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 16:03:26 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:3332 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262438AbUENUDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 16:03:15 -0400
Date: Fri, 14 May 2004 21:03:12 +0100
From: "'Christoph Hellwig'" <hch@infradead.org>
To: "Smart, James" <James.Smart@Emulex.com>
Cc: "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [(re)Announce] Emulex LightPulse Device Driver
Message-ID: <20040514210312.A28167@infradead.org>
Mail-Followup-To: 'Christoph Hellwig' <hch@infradead.org>,
	"Smart, James" <James.Smart@Emulex.com>,
	"'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
References: <3356669BBE90C448AD4645C843E2BF28034F9351@xbl.ma.emulex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3356669BBE90C448AD4645C843E2BF28034F9351@xbl.ma.emulex.com>; from James.Smart@Emulex.com on Fri, May 14, 2004 at 03:51:14PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2004 at 03:51:14PM -0400, Smart, James wrote:
>  - please explain USE_HGP_HOST_SLIM and why only ppc64 sets it,
>    per-arch ifdefs in LLDDs are very suspect
> 
>      Our hardware allows for control structures to be placed in adapter
> 	 memory rather than host memory. In general, this is the most
> 	 efficient mode of operation. USE_HGP_HOST_SLIM instructs us to
> override
> 	 this optimization and place them in host memory.
> 	 For PPC64, to work around byte ordering issues relative to how the
> 	 hardware is accessing the control structures, we found it easier to
> 	 just use the unoptimized location.

Still not an explanation.  What exact issue is that?  Is is just faster
this way or doesn't it work another way?  Why is ppc64 so different from
other plattforms, e.g. why does ist this set when I boot my (well, if I had
one :)) G5 mac with a 64bit kernel and why not when I boot it with a 32bit
kernel?  As you mention byte ordering why is it not needed for other
big endian system.

> 
>  - lpfc_clock.c should go away, just use add_timer/etc. diretly and
>    embedd the timer into your structures.  Yes, I know that's not
>    how SVR4-derivates work, but Linux does.  You also have an
>    unchecked kmalloc and a list_head cast in there..
> 
>      It's not an SVR4 vs linux thing.  This wrapper function does two
> 	 things - start the timer, and allocate/link a small control
> structure.
> 	 The control structure allows us to just keep a record of every
> 	 outstanding timer. This is a safety check, for driver
> 	 unloads/kills/etc, to ensure that we have cancelled all the timers
> 	 that have been registered with the OS.

No.  The timer should be embedded into the object it's associated with,
and you must call del_timer_sync in the object destructor.  BTW, you have
a lot of timers, more than the other fc drivers counted together.  This
looks slightly fishy.

>  - lpfcDRVR_t should go away in favour of a bunch of global variables
> 
>      Can you explain this comment further ?

You have a structure type lpfcDRVR_t but just a single global instance
of it.  Aka the data structure is just obsfucation and each member should
be a driver-wide variable of it's own.

> 
>  - lpfc_linux_attach should be merged into lpfc_pci_detect, which would
>    better be named lpfc_{,pci_}probe{,one}
> 
> 	 We've kept this organization so it's more in line with the
> 	 organization of the 2.4 driver. I don't see a real need to change
> 	 this.
>      Note: we have renamed the probe functions...

It's really awkward to follow.  See qla1280.c to see how to use 2.6-style
probe/release calls in a 2.4ish enviroment.  Been there, done that.

> 
>  - same for lpfc_linux_detach into lpfc_pci_release
>      
> 	 Same as last item

Dito.  Note that this one is especially awkward because of the brainded
pass index instead of object calling convention.

>  - you don't need a pci_pool per hba, just one per driver
> 
> 	 The pools are pre-dma mapped. As there are systems that require
> 	 dma maps to be specific to the adapter using them, we're maintaing
> 	 a pool per hba.

Ok, braino.  Of course you're right, I was thinking of the mempool.

>  - four mempool per hba seems a little much, care to explain why they're
>    needed?
> 
>      These are the safety pools just mentioned. 1 pool is for non-dma
> 	 mapped structures - which are used during discovery. The other 3
> 	 pools are pre-dma mapped buffers - of different allocation sizes
> 	 (256 bytes, 1k, and 4k). It's just an optimization on the amount
> 	 of memory used by the pool. I'm sure there's other methods, but...

Still doesn't say why they can't be global.  You'd need to uncomment
mempool_resize in mm/mempool.c for that, though.

