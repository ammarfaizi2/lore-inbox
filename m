Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318346AbSGYGLb>; Thu, 25 Jul 2002 02:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318347AbSGYGLb>; Thu, 25 Jul 2002 02:11:31 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:47698 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S318346AbSGYGLb>; Thu, 25 Jul 2002 02:11:31 -0400
Date: Thu, 25 Jul 2002 02:14:39 -0400
From: Doug Ledford <dledford@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Greg KH <greg@kroah.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: i810_audio.c cli/sti fix
Message-ID: <20020725021439.A9261@redhat.com>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Greg KH <greg@kroah.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20020725003735.GA12682@kroah.com> <Pine.LNX.4.44.0207241815120.4293-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0207241815120.4293-100000@home.transmeta.com>; from torvalds@transmeta.com on Wed, Jul 24, 2002 at 06:17:17PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2002 at 06:17:17PM -0700, Linus Torvalds wrote:
> On Wed, 24 Jul 2002, Greg KH wrote:
> >
> > Here's a small patch to get the i810_audio.c driver working again.
> 
> Hmm..
> 
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
> 
> However, I also wonder if the code doesn't want any SMP locking? Is it ok
> to just make it a non-spinlock local interrupt disable, and if so, why?

Because this is all part of the module init code and our purpose here is
not locking out other users of the card (which is already accomplished via
the fact that card->initializing != 0 at the moment so any other attempts
to access the card, which must first go through the open routine to get a
file handle to the device, are all blocking in i810_open() or
i810_mixer_open() waiting on card->initializing to become 0)  but instead
it is merely intended to stop all interrupts that might skew our timing
via udelay() on the local CPU (it's actually pretty important that we keep 
our variance from a real 50ms delay as small as possible, since the more 
variance we allow in this loop the more likely it will be that our sound 
card will play sounds either a bit too fast or too slow).

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
