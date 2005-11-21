Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750737AbVKUVXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbVKUVXY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 16:23:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbVKUVXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 16:23:24 -0500
Received: from web36904.mail.mud.yahoo.com ([209.191.85.72]:26274 "HELO
	web36904.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750737AbVKUVXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 16:23:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=SG7xSgdb7v/dJr7c+ERGQu2umhzp3wkfNKyLVeHJSmmJpcDrcQqlY/SfN5nCgdxBAOgvKYKNSuPV3EMKyf8MRURS7uRUiNLqiFohOvV8NbKwJNbWSi4vrQJhVPbPaQBLWWSYaAw8V9o4yUenR/KhaRgZCF5l1TPJyPUaTQdJA5c=  ;
Message-ID: <20051121212322.78931.qmail@web36904.mail.mud.yahoo.com>
Date: Mon, 21 Nov 2005 21:23:22 +0000 (GMT)
From: Mark Underwood <basicmark@yahoo.com>
Subject: Re: SPI
To: Vitaly Wool <vwool@ru.mvista.com>
Cc: dmitry pervushin <dpervushin@gmail.com>,
       David Brownell <david-b@pacbell.net>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       spi-devel-general@lists.sourceforge.net
In-Reply-To: <4382346F.7080909@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Vitaly Wool <vwool@ru.mvista.com> wrote:

> Mark Underwood wrote:
> 
> >>The list of main differences between David Brownell's SPI framework (A)
> >>and my one (B):
> >>- (A) uses more complicated structure of SPI message, that contains one
> >>or more atomic transfers, and (B)
> >> offers the only spi_msg that represents the atomic transfer on SPI bus.
> >>The similar approach can be imple-
> >> mented in (B), and actually is implemented. But my imp[ression is that
> >>such enhancement may be added later..
> >>    
> >>
> >
> >I wouldn't have said that the message structure in (A) is more complex then (B). For example,
> in
> >(B) you have many flags which controls things like SPI mode which are not needed in every
> message.
> >Once the SPI controller has been setup for a particular slave device you don't need to
> constantly
> >send this information. 
> >In (B) how to do you handle SPI devices which require to send several messages with out
> releasing
> >their cs? There are/will be some devices which require this. 
> >  
> >
> Please see the explanation for the 'flags' in Documentation/spi.txt 
> within the patch.

I can see that you can leave cs active at the end of a transfer but that's not my point. How do
you make sure that message for other SPI devices don't get send while the cs of the current device
is high?

> 
> >  
> >
> >>- (A) uses workqueues to queue and handle SPI messages, and (B)
> >>allocates the kernel thread to the same purpose.
> >> Using workqueues is not very good solution in real-time environment; I
> >>think that allocating and starting the 
> >> separate thread will give us more predictable and stable results;
> >>    
> >>
> >
> >Where does (A) use a workqueue? (A) doesn't use a workqueue or thread and instead leaves it up
> to
> >the adapter driver how to handle the messages that it gets sent (which in the case of some
> drivers
> >will mean no thread or workqueue). (B) is _forcing_ a thread on the adapter which the adapter
> may
> >not need. 
> >  
> >
> I bet the drivers that don't need neither threads not workqueue there's 
> no need in async transfers as well. :)
> On the other hand, threads is a flexible mechanism for handling async 
> stuff, and there won't be a lot of threads so the overhead won't be high.
> You might also want to ask why you can't change the steering wheel 
> placement in your car from right-side to rleft-side although you travel 
> by car to continental Europe once per decade. ;-)

Sorry I'm not following you here.

Example:
An interrupt driven PIO doesn't need a thread or a workqueue. When it is idle the call to its
transfer function can start off the first transfer and after that the interrupt routine will check
for a new transfer when it has finished the current one. David provided other examples so if you
are still not sure search through the archives.

> 
> >  
> >
> >>- (A) has some assumptions on buffers that are passed down to spi
> >>functions. If some controller driver (or bus driver
> >> in terms of (B)) tries to perform DMA transfers, it must copy the
> >>passed buffers to some memory allocated
> >> using GFP_DMA flag and map it using dma_map_single. From the other
> >>hand, (B) relies on callbacks provided 
> >> by SPI device driver to allocate memory for DMA transfers, but keeps
> >>ability to pass user-allocated buffers down
> >> to SPI functions by specifying flags in SPI message. SPI message being
> >>a fundamental essense looks better to me when 
> >> it's as simple as possible. Especially when we don't lose any
> >>flexibility which is exacly our case (buffers that are
> >> allocated as well as message itself/provided by user, DMA-capable
> >>buffers..)	
> >>    
> >>
> >
> >But allocating and freeing buffer is a core kernel thing not a SPI thing. To me you are adding
> >more complexity then is needed and your saying this is keeping things simple? 
> >  
> >
> I'm afraid that you're not quite getting the whole concept. The concept 
> is to provide thorough and stable solution.
> Given that the buffer passed is declared as, say, static, the whole 
> kernel might crash if we try to pass it to DMA. David's core itself is 
> not capable of filtering that and letting the driver decide adds more 
> complexity to the driver.
> If we're choosing between adding complexity to the core and adding it to 
> the particular drivers, it's definitely better to add it to the core cuz 
> it's done _once_.

I'm not 100% sure how David is handling this, but one option would be to have a not_dmaable flag
which states that the buffers used in this message are not DMAable and in this case the adapter
driver will either do a PIO transfer or bounce the data to/from a DMAable buffer it allocated
itself. I don't see why a SPI adapter driver needs to supply alloc/free callbacks when a simple
flag would do the job.

> 
> >>- (A) uses standartized way to provide CS information, and (B) relies on
> >>functional drivers callbacks, which looks more
> >> flexible to me.
> >>    
> >>
> >
> >I'm not sure what you mean here. You need to provide the cs numbers with SPI device in order
> for
> >the core to create the unique addres and entry in sysfs. 
> >However, (A) is not checking to see if the cs that a registering device wants to use is already
> in
> >use, this needs to be added, and the same is true for registering spi masters. 
> >  
> >
> Can you please elaborate on that?

If I register a SPI device on cs1 of spi-1 and later try to register another device on cs1 of
spi-1 I would expect the spi core layer to fail the registration of the second device.

Mark

> 
> Vitaly
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



		
___________________________________________________________ 
To help you stay safe and secure online, we've developed the all new Yahoo! Security Centre. http://uk.security.yahoo.com
