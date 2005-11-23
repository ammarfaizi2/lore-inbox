Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbVKWTFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbVKWTFe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 14:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbVKWTFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 14:05:34 -0500
Received: from smtp111.sbc.mail.mud.yahoo.com ([68.142.198.210]:19314 "HELO
	smtp111.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932202AbVKWTFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 14:05:33 -0500
From: David Brownell <david-b@pacbell.net>
To: Vitaly Wool <vwool@ru.mvista.com>
Subject: Re: [spi-devel-general] Re: SPI
Date: Wed, 23 Nov 2005 11:05:29 -0800
User-Agent: KMail/1.7.1
Cc: Mark Underwood <basicmark@yahoo.com>,
       dmitry pervushin <dpervushin@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, osdl.org@ascent.mvista.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       spi-devel-general@lists.sourceforge.net
References: <20051122191104.48403.qmail@web36907.mail.mud.yahoo.com> <200511221233.16634.david-b@pacbell.net> <43843768.1050405@ru.mvista.com>
In-Reply-To: <43843768.1050405@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511231105.30189.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >By the way Vitaly ... I'm still not getting responses directly from you.
> >Are you pruning me off CC lists, or is there something between us that's
> >filtering out posts?  It's certainly hard to respond ...
> >
> No, definitely I'm not. I'm just responding with "Reply All" button in 
> my Thunderbird, if you wanna know the details.
> And I'm quite surprised to hear about the kind of problems you have as 
> you're the only one who's having them.

Well, as was pointed out offline, you aren't always CC'ing me.  In this
case you did, and I got your message.


> >Vitaly, you're really going to have to come up with some facts if you
> >keep claiming the SPI framework I've posted doesn't support DMA.
> >(I'm not going to let you pull a SCO on us here.)  For that matter,
> >you might want to consider the fact that Stephen's pxa2xx_spi
> >driver disproves your arguments (it includes DMA support).
>   
> 
> Again, a single working driver cannot disapprove anything.

It certainly can disprove assertions like the one you made...


> Evidently enough for anyone more or less familiar with logic, if one 
> claims that something is working, he should prove it's working 
> everywhere not somewhere; on the other hand, to disapprove this 
> statement it's enough to give one example.

Which is what I did.  You said that the approach I was using did NOT
support DMA.  I disproved it with several counterexamples ... the whole
USB stack for one, using that same DMA approach (in "struct urb" on the
host side, and "struct usb_request" on the peripheral side), as well as
more specifically that pxa2xx_spi driver (with "struct spi_message").


> The thing is that what we do in the core to provide DMA capabilities 
> should be implemented in controller driver in your case.
> I can agree that it might be considered an addition to the core and not 
> directly included in it, but leaving rather standard operations to the 
> controller driver degrades the added value of the core.

That's an entirely different argument, note.

And in this case, it was a conscious decision not to require any
mid-layer logic to interpose itself between layers of SPI driver.
Drivers using PIO shouldn't need to pay mapping costs ... but if
the mapping were done in a mid-layer, they would always do so.


> >Controller drivers don't deal with userland addresses.  That's the
> >responsibility of the layers on top ... e.g. the filesystem or driver
> >code that accepts them.  Most just copy to/from userspace, but some
> >pay the costs to support direct I/O.
> >  
> >
> Oh no, you've got me wrong. I was tryng to say that an upper level 
> driver which copies the data from the userspace should be copying it to 
> GFP_DMA buffer, otherwise it won't work or will force the controller 
> driver to allocate/copy.

GFP_DMA is not necessary ... plus, it's usually inappropriate.  Except
for broken hardware, any buffer returned by kmalloc is fine ... and for
that broken hardware, the dma mapping calls should be setting up the
relevant bounce buffering.  (See how ARM does it for various XScale
systems, the dmabounce_* code.)


> Basically the upper level driver shouldn't give a damn whether the 
> buffers should be DMA-able or not since it might be used on different 
> platforms w/ and w/o DMA capabilities. 

If it were any effort to provide DMA-safe buffers, I might agree.
But it isn't; most buffers come from kmalloc() already.

Remember, this is the same requirement applying to the rest of
the Linux driver stack.  Now that the requirements have been
clear for a couple years (Documentation/DMA-mapping.txt, and
yes I had something to do with finally getting those rules
written down) this is NOT a problem of any note.


> >>>- it needs to timely send some credentials (what is the case for the 
> >>>WLAN driver, for instance).
> 
> >Again, not the responsibility of the lowest level driver.   A WLAN driver
> >layered on top could, of course.  That's the way such things are done in
> >other driver stacks.
> >
> >Are you seriously suggesting that an SPI controller driver should have any
> >clue whatever about credentials??   Which of the dozens of schemes should
> >become that "special", then ... and why??
>  
> I'm afraid that you were not reading my response attentively. 

I was trying, but your words were making no sense to me.


> Credentials are stored in a staic-allocated buffer in the upper level 
> driver. Then they are passed down to the SPI core which will fail to 
> send the buffer containing the credentials if it's not copied to DMAable 
> memory somewhere in between.

So it'd be just like with any other driver stack.  In this case, the issue
would be with whatever is passing static credentials where DMA-safe buffers
are required.  (In fact, static buffers work on every Linux platform I've ever
worked with, but it's not guaranteed ... the main issue would be the same one
that shows up with dma to/from stack, where cacheline sharing causes chaos on
systems without dma-coherent cache.)

For what it's worth, usually credentials get copied into an sk_buff, which
is DMA-safe since it comes from kmalloc().  If you're talking about some
out-of-tree WLAN code, I'd expect those issues would be resolved (in the WLAN
code) before that stack gets merged.

- Dave

