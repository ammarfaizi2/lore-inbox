Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261302AbSKKUZX>; Mon, 11 Nov 2002 15:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261305AbSKKUZW>; Mon, 11 Nov 2002 15:25:22 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:65261 "EHLO
	flossy.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261302AbSKKUZV>; Mon, 11 Nov 2002 15:25:21 -0500
Date: Mon, 11 Nov 2002 15:31:37 -0500
From: Doug Ledford <dledford@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>,
       geert@linux-m68k.org, Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] NCR53C9x ESP: C99 designated initializers
Message-ID: <20021111203137.GB11636@redhat.com>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"David S. Miller" <davem@redhat.com>, geert@linux-m68k.org,
	Christoph Hellwig <hch@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Jens Axboe <axboe@suse.de>
References: <1037019925.2887.21.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0211110915470.1805-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211110915470.1805-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2002 at 09:24:32AM -0800, Linus Torvalds wrote:
> 
> On 11 Nov 2002, Alan Cox wrote:
> > 
> > The stupid thing is we take the lock then call the eh function then drop
> > it. You can drop the lock, wait and retake it. I need to fix a couple of
> > other drivers to do a proper wait and in much the same way.
> 
> Hmm.. I wonder if the thing should disable the queue (plug it)

It does this already

> and release 
> the lock before calling reset.

We call into the driver with the lock held for the sake of consistency.  
When you get right down to it, you can write a driver who has no more 
concept of SMP locking than spin_lock_irq(host->host_lock); in the isr 
routine.  They need to know to drop the lock before calling scsi_sleep() 
in the eh routines, or they can drop the lock and sleep on some wait queue 
as well if they wish.  But, in general, in depth locking knowledge is not 
required.  Since I've ported the old aic7xxx driver to the new scheme, it 
is for certain an improvement over the old method in terms of ease of 
programming a driver to the API.

> I assume we don't want any new requests at 
> this point anyway, and having the low-level drivers know about stopping 
> the queue etc sounds like a bad idea..

Right, both already handled.

> Of course, I suspect that it is potentially a bad idea to have the reset
> functionality at the SCSI level _at_all_.

It saves a lot of code duplication.  There's basically only two existing 
reset strategies around.  A) I'm a stupid card with a SCSI bus and all 
SCSI busses and plain SCSI devices hang pretty much the same way, so the 
mid layer can write a reasonable strategy routine and just have the low 
level driver fill in the implementation hooks (abort hook, bus reset hook, 
full host reset hook, etc) and B) I'm an intelligent firmware and you just 
let me do my thing, in which case the mid layer can't really do anything 
and the low level drivers only need to leave the hooks undefined because 
if the firmware looses the command we're bust already.

> As usual, the higher layers
> don't really know what is going on, and the lower levels on smarter cards
> are likely to be doing the right thing on their own, no?

Lower levels on smart cards assume that if the card ever looses a command 
then you just want a watchdog to reset the machine anyway.

> (Yes, we should improve the infrastructure for having per-command timeouts 
> etc, but the reset/abort callbacks have always been strange)
> 
> 		Linus

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
