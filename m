Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbVKUUPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbVKUUPt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 15:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbVKUUPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 15:15:49 -0500
Received: from web36907.mail.mud.yahoo.com ([209.191.85.75]:35433 "HELO
	web36907.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750765AbVKUUPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 15:15:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=TgYVXRJcqSomWwn1D3T4tfG0F8LDrzD42X4hvRvRDDaZuYB603p3wOxhYAMD+fKcxNasprF0zX5Bcfq9MxQSiOjKlf00wm9kg8LKFcMzFd/zrgYwyPf1JFryESKxOOQQQ7LPaNPhZq70eC7yk6/WmvRIzHzvJRaQoKgY2j02wWA=  ;
Message-ID: <20051121201547.78681.qmail@web36907.mail.mud.yahoo.com>
Date: Mon, 21 Nov 2005 20:15:47 +0000 (GMT)
From: Mark Underwood <basicmark@yahoo.com>
Subject: Re: SPI
To: dmitry pervushin <dpervushin@gmail.com>,
       David Brownell <david-b@pacbell.net>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: spi-devel-general@lists.sourceforge.net
In-Reply-To: <1131703881.5324.4.camel@fj-laptop.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- dmitry pervushin <dpervushin@gmail.com> wrote:

> This is an updated version of SPI framework from me, Dmitry Pervushin.
> It seems that now it is good time to consolidate our SPI frameworks to
> push it to kernel :)
> 
> We've tested our SPI core as well with bus drivers with wireless LAN
> driver and achieved good performance with relatively small overhead.
> This proves the viability of this framework in real life even in
> real-time environment. The size of .text is
> still about 2,500 bytes, that is comparable with David Brownell's
> framework size.
> 
> I think now is the time to start the final convergence process for these
> two cores and get the final core 
> into the mainline kernel. And in order to understand where we need to
> converge, I created the main differences
> list (see below).
> 
> The list of main differences between David Brownell's SPI framework (A)
> and my one (B):
> - (A) uses more complicated structure of SPI message, that contains one
> or more atomic transfers, and (B)
>  offers the only spi_msg that represents the atomic transfer on SPI bus.
> The similar approach can be imple-
>  mented in (B), and actually is implemented. But my imp[ression is that
> such enhancement may be added later..

I wouldn't have said that the message structure in (A) is more complex then (B). For example, in
(B) you have many flags which controls things like SPI mode which are not needed in every message.
Once the SPI controller has been setup for a particular slave device you don't need to constantly
send this information. 
In (B) how to do you handle SPI devices which require to send several messages with out releasing
their cs? There are/will be some devices which require this. 

> - (A) uses workqueues to queue and handle SPI messages, and (B)
> allocates the kernel thread to the same purpose.
>  Using workqueues is not very good solution in real-time environment; I
> think that allocating and starting the 
>  separate thread will give us more predictable and stable results;

Where does (A) use a workqueue? (A) doesn't use a workqueue or thread and instead leaves it up to
the adapter driver how to handle the messages that it gets sent (which in the case of some drivers
will mean no thread or workqueue). (B) is _forcing_ a thread on the adapter which the adapter may
not need. 

> - (A) has some assumptions on buffers that are passed down to spi
> functions. If some controller driver (or bus driver
>  in terms of (B)) tries to perform DMA transfers, it must copy the
> passed buffers to some memory allocated
>  using GFP_DMA flag and map it using dma_map_single. From the other
> hand, (B) relies on callbacks provided 
>  by SPI device driver to allocate memory for DMA transfers, but keeps
> ability to pass user-allocated buffers down
>  to SPI functions by specifying flags in SPI message. SPI message being
> a fundamental essense looks better to me when 
>  it's as simple as possible. Especially when we don't lose any
> flexibility which is exacly our case (buffers that are
>  allocated as well as message itself/provided by user, DMA-capable
> buffers..)	

But allocating and freeing buffer is a core kernel thing not a SPI thing. To me you are adding
more complexity then is needed and your saying this is keeping things simple? 
	 
> - (A) retrieves SPI message from the queue in sequential order (FIFO),
> but (B) provides more flexible way by providing
>  special callback to retrieve next message from queue. This callback may
> implement its own discipline of scheduling 
>  SPI messages. In any way, the default is FIFO.

I think (A) is missing a method of adding extra spi_message(s) in callback to extend the current
transfer on that SPI device. I can imagine a case where you will be required to read status
information from a device and in this status information is the length of the data it has just
received (for example if it was a network adapter). Straight after reading this information the
device would start sending the data it has received but when the read status message was issued
the length of the data wasn't known. Currently with (A) we would have to stop the transfer and
restart the whole thing again, this time using the length of the data we found form the last
message. 

A better solution would to be able to add an extra message during the callback from the first
message as now we know then length we can setup a transfer that would be the correct size.
However, this message must be the next message that the adapter sends as if another message for
another SPI device was sent before then the cs line of the device we are talking to would be
deselected and we would have to start again. 
 
My proposal is that in the callback from a spi_message being sent it returns a pointer to the next
spi_message which the adapter will send before it continues sending any other messages (this is
like the adapter being locked by the SPI device), if no other messages need to be sent atomically
in the callback of current message then the SPI device driver would just return NULL. 
 
Example: 
======== 
/* callback/complete routine of a SPI device/protocol driver */ 
int my_spi_callback (void *data) 
{ 
	struct my_status_struct = data; 
	struct spi_message read_message; 
	 
	/* Check to see if we have received any data */ 
	if (my_status_struct->read_length) 
	{ 
		/* Create a new spi_message to read the data which will be 
		 * the very next thing the device will send */ 
		  
		 read_message = kzalloc(...) 
		 ... 
		 return read_message; 
	} 
	else 
		/* No data to be read so don't append another message */ 
		return NULL; 
} 
 

> - (A) uses standartized way to provide CS information, and (B) relies on
> functional drivers callbacks, which looks more
>  flexible to me.

I'm not sure what you mean here. You need to provide the cs numbers with SPI device in order for
the core to create the unique addres and entry in sysfs. 
However, (A) is not checking to see if the cs that a registering device wants to use is already in
use, this needs to be added, and the same is true for registering spi masters. 
 
Mark 



		
___________________________________________________________ 
To help you stay safe and secure online, we've developed the all new Yahoo! Security Centre. http://uk.security.yahoo.com
