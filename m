Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932354AbVKVGAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbVKVGAs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 01:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbVKVGAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 01:00:48 -0500
Received: from rtsoft2.corbina.net ([85.21.88.2]:8841 "HELO mail.dev.rtsoft.ru")
	by vger.kernel.org with SMTP id S932354AbVKVGAr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 01:00:47 -0500
Message-ID: <4382B40A.5090407@ru.mvista.com>
Date: Tue, 22 Nov 2005 09:00:42 +0300
From: Vitaly Wool <vwool@ru.mvista.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: Mark Underwood <basicmark@yahoo.com>,
       dmitry pervushin <dpervushin@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       spi-devel-general@lists.sourceforge.net
Subject: Re: [spi-devel-general] Re: SPI
References: <20051121201547.78681.qmail@web36907.mail.mud.yahoo.com> <200511211327.34349.david-b@pacbell.net>
In-Reply-To: <200511211327.34349.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:

>>>- (A) uses more complicated structure of SPI message, that contains one
>>>  or more atomic transfers, and (B)
>>>  offers the only spi_msg that represents the atomic transfer on SPI bus.
>>>  The similar approach can be implemented
>>>  in (B), and actually is implemented. But my imp[ression is that
>>>  such enhancement may be added later..
>>>      
>>>
>>I wouldn't have said that the message structure in (A) is more complex then (B). For example, in
>>(B) you have many flags which controls things like SPI mode which are not needed in every message.
>>Once the SPI controller has been setup for a particular slave device you don't need to constantly
>>send this information. 
>>    
>>
>
>And in fact, constantly sending it means some drivers will have to waste
>time constantly checking it, in case it changed.  If that setup is stored
>in controller registers, it's a lot better to just have the setup() call
>be responsible for changing the communication parameters.  (This is the
>approach used by both MMC and PCMCIA, for what it's worth...)
>
>  
>
I'm not aware if MMC/PCMCIA guys are happy with this approach :), but 
anyway what you're talking about here makes sense.

>  
>
>>In (B) how to do you handle SPI devices which require to send several messages with out releasing
>>their cs? There are/will be some devices which require this. 
>>    
>>
>
>In fact, that's why the transfer segments are grouped.  One builds SPI
>protocol requests out of several such segments.  A very common idiom is
>writing a command, then reading its response.  Chipselect must stay
>active during the whole sequence.
>
>Adding support for such a basic mechanism "later" doesn't seem like
>a good idea to me.
>  
>
It is supported by means of flags. I'm afraid your note is pointless here.

>
>  
>
>>>- (A) uses workqueues to queue and handle SPI messages, and (B)
>>>  allocates the kernel thread to the same purpose.
>>>  Using workqueues is not very good solution in real-time environment; I
>>>  think that allocating and starting the 
>>>  separate thread will give us more predictable and stable results;
>>>      
>>>
>>Where does (A) use a workqueue? (A) doesn't use a workqueue or thread and instead leaves it up to
>>the adapter driver how to handle the messages that it gets sent (which in the case of some drivers
>>will mean no thread or workqueue). (B) is _forcing_ a thread on the adapter which the adapter may
>>not need. 
>>    
>>
>
>Exactly.  That's one of the things I meant when I recently listed some of the
>top goals of the framework I did:
>
>(a) SPI shouldn't perpetuate the driver model botches of I2C;
>(b) ditto I2C's "everything is synchronous" botches;
>(c) it should work well with DMA, to support things like DataFlash;
>(d) given the variety of SPI chips, protocol controls are needed;
>(e) place minimal implementation constraints on controller drivers.
>
>So for example one way you know that (c) is well met is that it's the same
>approach used in USB (both host and peripheral/gadget sides); that's been
>working well for quite a few years now.  (Despite comments from Dmitry
>and Vitaly to the contrary.)
>  
>
Lemme point you out that if somehting is "working" on a limited number 
of platforms within the limited number of use cases, that's not 
necessarily a correct implementation.

> 
>  
>
>>>- (A) has some assumptions on buffers that are passed down to spi
>>>  functions.
>>>      
>>>
>
>Make that "requirements"; FWIW they're the same ones that apply to all
>other kernel driver frameworks I've seen:  that buffers be DMA-safe.
>It would not be helpful (IMO) to define different rules; that's also
>called the "Principle of Least Astonishment".  :)
>  
>
Yeah within this requirement it's correct. But that requirement may 
really make the SPI controller driver a lot more complex if
- it has to send something received from the userland
- it needs to timely send some credentials (what is the case for the 
WLAN driver, for instance).

>
>  
>
>>>  If some controller driver (or bus driver 
>>>  in terms of (B)) tries to perform DMA transfers, it must copy the
>>>  passed buffers to some memory allocated
>>>  using GFP_DMA flag and map it using dma_map_single.
>>>      
>>>
>
>Based on this and other comments from Dmitry/Vitaly, I suspect they
>don't see how the Linux DMA APIs work.  The correct statement is that if
>a controller driver wants to use DMA, it must dma_{map,unmap}_single().
>The upper level drivers don't _need_ to worry about that.
>  
>
The upper level drivers do need to worry about their buffers being 
DMAable then which requirement adds more complexity.
For instance, that means that the upper level drivers can't use 
static/const for the data being sent, what might be pretty much annoying 
when you have to send the same data multiple times.
Our approach is definitely more robust, although it may be reasonable to 
simplify it somehow.

>>>- (A) retrieves SPI message from the queue in sequential order (FIFO),
>>>      
>>>
>
>Only with respect to a given device.  It would make no sense to reorder the
>queue so that writing X, then Y, then Z would morph into "X Z Y" or "Z Y X".  :)
>
>It's specifically _undefined_ how requests going to different devices are ordered.
>Some hardware will be happier if things are synchronized (e.g. to a vertical
>retrace IRQ), some systems might need to prioritize certain devices, and so on.
>
>I do think FIFO makes a good general policy, for boards without any of those
>special requirements.
>
>
>  
>
>>>  but (B) provides more flexible way by providing
>>>  special callback to retrieve next message from queue. This callback may
>>>  implement its own discipline of scheduling 
>>>  SPI messages. In any way, the default is FIFO.
>>>      
>>>
>>I think (A) is missing a method of adding extra spi_message(s) in callback to extend the current
>>transfer on that SPI device. I can imagine a case where you will be required to read status
>>information from a device and in this status information is the length of the data it has just
>>received (for example if it was a network adapter). Straight after reading this information the
>>device would start sending the data it has received but when the read status message was issued
>>the length of the data wasn't known.
>>    
>>
>
>Do you actually have hardware which works that way?  That would be an example
>of a system that needs some specific prioritization of transfers (see below).
>  
>
Let's just agree on the _fact_ that here our approach overcame yours. 
IMO it's pretty evident.

>
>  
>
>>Currently with (A) we would have to stop the transfer and 
>>restart the whole thing again, this time using the length of the data we found form the last
>>message. 
>>    
>>
>
>Well, each transfer segement would clearly stop, but if that segment had
>the flag set which says "leave chipselect active", then the controller
>driver would have the flexibility to prioritize transfers to that chip.
>  
>
Hey, you've told us earlier you don't need any flags, right?
If we start talking about flags necessity, then your *complicated* 
approach to the spi_message doesn't make sense, sorry.

>>>- (A) uses standartized way to provide CS information, and (B) relies on
>>>  functional drivers callbacks, which looks more
>>>  flexible to me.
>>>      
>>>
>>I'm not sure what you mean here. You need to provide the cs numbers with SPI device in order for
>>the core to create the unique addres and entry in sysfs. 
>>    
>>
>
>I'm not sure what he means either.  :)
>
>Stephen's PXA2xx SPI driver uses callbacks internally, but that's kind of
>specific to that PXA hardware ... there's no chipselect handled by the
>controller, one of the dozens of GPIOs must be chosen and that's clearly
>a board-specific mechanism (uses controller_data as I recall).  He tells
>me he plans to post the latest version of that -- many updates including
>PXA255 SSP support (not just NSSP) and code shrinkage -- early next week.
>
>But most of the SPI controllers I've seen just have a fixed number of
>chipselects, typically four, handled directly by the controller.  That's
>why the "standardized way" is just to use a 0..N chipselect number.
>  
>
Suppose we have a specific driver or system service (API) implemented to 
handle chip selects. We'll have to duplicate its functionality within 
your approach what is incorrect in architectural terms. Our approach is 
free from this drawback.

Vitaly

