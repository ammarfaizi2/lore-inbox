Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318342AbSGYF6M>; Thu, 25 Jul 2002 01:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318343AbSGYF6M>; Thu, 25 Jul 2002 01:58:12 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:40200 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S318342AbSGYF6L>;
	Thu, 25 Jul 2002 01:58:11 -0400
Date: Wed, 24 Jul 2002 23:01:06 -0700
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: i810_audio.c cli/sti fix
Message-ID: <20020725060106.GA13691@kroah.com>
References: <20020725003735.GA12682@kroah.com> <Pine.LNX.4.44.0207241815120.4293-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207241815120.4293-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Thu, 27 Jun 2002 04:48:34 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2002 at 06:17:17PM -0700, Linus Torvalds wrote:
> > @@ -2814,15 +2814,15 @@
> >  		}
> >  		dmabuf->count = dmabuf->dmasize;
> >  		outb(31,card->iobase+dmabuf->write_channel->port+OFF_LVI);
> > -		save_flags(flags);
> > -		cli();
> > +		local_irq_save(flags);
> > +		local_irq_disable();
> 
> First off, "local_irq_save()" does both the save and the disable (the same
> way "spin_lock_irqsave()" does), it's the "local_save_flags(") that is
> equivalent to the old plain save_flags. So this should just be
> 
> 	local_irq_save(flags);

Ah, sorry, I didn't get that from cli-sti-removal.txt.  Actually it
looks like cli-sti-removal.txt is a bit wrong, as there is no
local_irq_save_off() function.  I'll send a patch for that next.

> However, I also wonder if the code doesn't want any SMP locking? Is it ok
> to just make it a non-spinlock local interrupt disable, and if so, why?

This is _only_ a guess, as I do not know this hardware or driver at all,
but this function is only called at device init time (from the PCI probe
function), so I don't think anything else is going on in the driver at
the same time to warrent SMP locking.  It also looks like this is done
to determine the "clocking" of the device, so interrupts need to be off
for the CPU doing the determination.

But again, this is only a guess from glancing at the code for a very
short time, and I should probably start using the ALSA version of this
driver anyway :)

Here's a patch with the extra local_irq_disable() call removed.

thanks,

greg k-h


diff -Nru a/sound/oss/i810_audio.c b/sound/oss/i810_audio.c
--- a/sound/oss/i810_audio.c	Wed Jul 24 23:08:21 2002
+++ b/sound/oss/i810_audio.c	Wed Jul 24 23:08:21 2002
@@ -1733,7 +1733,7 @@
 		}
 
 		spin_unlock_irqrestore(&state->card->lock, flags);
-		synchronize_irq();
+		synchronize_irq(state->card->irq);
 		dmabuf->ready = 0;
 		dmabuf->swptr = dmabuf->hwptr = 0;
 		dmabuf->count = dmabuf->total_bytes = 0;
@@ -2814,15 +2814,14 @@
 		}
 		dmabuf->count = dmabuf->dmasize;
 		outb(31,card->iobase+dmabuf->write_channel->port+OFF_LVI);
-		save_flags(flags);
-		cli();
+		local_irq_save(flags);
 		start_dac(state);
 		offset = i810_get_dma_addr(state, 0);
 		mdelay(50);
 		new_offset = i810_get_dma_addr(state, 0);
 		stop_dac(state);
 		outb(2,card->iobase+dmabuf->write_channel->port+OFF_CR);
-		restore_flags(flags);
+		local_irq_restore(flags);
 		i = new_offset - offset;
 #ifdef DEBUG
 		printk("i810_audio: %d bytes in 50 milliseconds\n", i);
