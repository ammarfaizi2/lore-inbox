Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750844AbVLTIL7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844AbVLTIL7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 03:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbVLTIL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 03:11:59 -0500
Received: from smtp112.sbc.mail.mud.yahoo.com ([68.142.198.211]:4978 "HELO
	smtp112.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750841AbVLTIL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 03:11:58 -0500
From: David Brownell <david-b@pacbell.net>
To: Vitaly Wool <vwool@ru.mvista.com>
Subject: Re: [PATCH/RFC] SPI core: turn transfers to be linked list
Date: Tue, 20 Dec 2005 00:11:56 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
References: <43A480C0.9080201@ru.mvista.com> <200512181240.46841.david-b@pacbell.net> <43A665F7.7020404@ru.mvista.com>
In-Reply-To: <43A665F7.7020404@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512200011.57052.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >Hmm, color me confused.  Is there something preventing a driver from
> >having its own freelist (or whatever), in cases where kmalloc doesn't
> >suffice?  If not, why should the core change?  And what sort of driver
> >measurements are you doing, to conclude that kmalloc doesn't suffice?
> >  
> >
> Can't get what you're talking about. A freelist of what?

Of whatever the driver wants.  You had pointed at some code that
boiled down to keeping a freelist of some structures in the core.
Such code doesn't _need_ to be in the core at all ...


> Basically the idea of the custom lightweight allocation is the 
> following: allocate a page and divide into regions of the same size, 
> initialize and use these regions as a stack.

There already a lot of allocators that support that, like kmem_cache_t
or dma_pool or mempool_t ... no more, please!  They don't all have that
"stack"/freelist notion though; easy for drivers to do that, IMO.

Drivers that don't want to hit the heap will preallocate everything
they can, and they'll probably have their own freelists.  That wins
by eliminating the slab subroutine calls from what are often hot
code paths, along with their fault handling logic ... and removing
the need (and testing) for fault handling wins by improving robustness.


> Next, why the current model prevents us from doing that. The array may 
> be of any size thus we can't divide the page into regions of the same 
> size: we can't predict what the maximum size will be. And this is the 
> problem of the core.

The driver code calling through the core doesn't have that problem.
It knows what size it needs, and if it needed enough of them it'd be
easy to make a kmem_cache_t to suit its needs.


> >I'd have said that since this increases the per-transfer costs (to set
> >up and manage the list memberships) you want to increase the weight of
> >that part of the API, not decrease it.  ;)
> >  
> >
> Disagree. Let's look deeper. kmalloc itself is more heavyweght than 
> setting up list memberships.

But kmalloc was previously optional, yes?  And should still be ...


> The list setting commands are pretty essential and will not add a lot to 
> the assembly code.

I'm not totally averse to such changes, but you don't seem to be making
the best arguments.  Example:  they're clearly not "essential" because
transfer queues work today with the lists at the spi_message level.

 
> >Note that your current API maps to mine roughly by equating
> >
> >	allocate your spi_msg 
> >	allocate my { spi_message + one spi_transfer }
> >
> >So if you're doing one allocation anyway, you already have the relevant
> >linked list (in spi_message) and pre-known size.  So this patch wouldn't
> >improve any direct translation of your driver stack.
> >  
> >
> This is the patch to your API, so I don't see why you're mentioning it here.

Because interface changes need to be discussed in context, and at this time
you have the only code that seems to suggest a need for this ...


> And your understanding is not quite correct. What if I'm going to send a 
> chain of 5 messages? I'll allocate 5 spi_msg's in my case which all are 
> gonna be of the same size -- thus the technique described above is 
> applicable. In case of your core it's not.

I must have been deceived then by this little utility:

static inline struct spi_message *spi_message_alloc(unsigned ntrans, gfp_t flags)
{
        struct spi_message *m;

        m = kzalloc(sizeof(struct spi_message)
                        + ntrans * sizeof(struct spi_transfer),
                        flags);
        if (m) {
                m->transfers = (void *)(m + 1);
                m->n_transfer = ntrans;
        }
        return m;
}

Sure looks to me like spi_message_alloc(5, SLAB_ATOMIC) should do the trick.
One allocation, always the same size.  And kzalloc() could easily optimize
that to use the "size-192" slab cache (or whatever), like kmalloc() does;
that'd be a small speedup.


> >Could you elaborate on this problem you perceive?  This isn't the only
> >driver API in Linux to talk in terms of arrays describing transfers,
> >even potentially large arrays.  
> 
> The problem is: we're using real-time enhancements patch developed by 
> Ingo/Sven/Daniel etc. You cannot call kmalloc from the interrupt 
> context  if you're using this patch. Yeah, yeah -- the interrupt 
> handlers are in threads by default, but we can't go for that since we 
> want immediate acknowledgement from the interrupt context, and that 
> implies spi_message/spi_transfer allocation.

Could you elaborate a bit here?  You seem to be implying that for some
reason one of your SPI related drivers must use non-threaded hardirqs,
AND (news to me, if true) that such hardirqs can't kmalloc(), AND that
it can't use any of several widely used strategies to avoid hitting
things like the slab allocator.  (That last seems hardest to believe...)

I asked earlier what sort of performance measurements you're making
that are leading you to these conclusions.  I'm still wondering.  :)


> >Consider how "struct scatterlist" is used, and how USB manages the
> >descriptors for isochronous transfers.  They don't use linked lists
> >there, and haven't seemed to suffer from it.
> >  
> >
> Not sure if I understand why it's relevant to what we're discussing.

Examples of driver interfaces in Linux that work fine using arrays to couple
a group of transfers.  If you see some problem that makes a compelling
argument that the SPI must change, it would also affect drivers using
those interfaces too, at least a little bit ... right?  Does it?

- Dave

