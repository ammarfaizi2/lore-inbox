Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316763AbSFKETK>; Tue, 11 Jun 2002 00:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316750AbSFKETJ>; Tue, 11 Jun 2002 00:19:09 -0400
Received: from mta05bw.bigpond.com ([139.134.6.95]:50386 "EHLO
	mta05bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S316763AbSFKETI>; Tue, 11 Jun 2002 00:19:08 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Roland Dreier <roland@topspin.com>, "David S. Miller" <davem@redhat.com>
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
Date: Tue, 11 Jun 2002 14:16:13 +1000
User-Agent: KMail/1.4.5
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <15619.9534.521209.93822@nanango.paulus.ozlabs.org> <20020610.201033.66168406.davem@redhat.com> <52lm9m7969.fsf@topspin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200206111416.13493.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jun 2002 14:04, Roland Dreier wrote:
> >>>>> "David" == David S Miller <davem@redhat.com> writes:
>
>     David> Wait a second, forget all of this cache alignment crap.  If
>     David> we can avoid drivers seeing it, we should by all means
>     David> necessary.
>
>     David> We should just tell people to use PCI pools and be done
>     David> with it.  That way all the complexity about buffer
>     David> alignment and all this other crapola lives strictly inside
>     David> of the PCI pool code.
>
> That's fine but there are drivers (USB, etc) doing
>
> 	struct something {
> 	        int field1;
> 	        char dma_buffer[SMALLER_THAN_CACHE_LINE];
> 	        int field2;
> 	};
>
> 	struct something *dev = kmalloc(sizeof *dev, GFP_KERNEL);
>
> Do they have to change to
>
> 	struct something {
> 	        int field1;
> 	        char *dma_buffer;
> 	        int field2;
> 	};
>
> 	struct something *dev = kmalloc(sizeof *dev, GFP_KERNEL);
>         dev->dma_buffer = kmalloc(SMALLER_THAN_CACHE_LINE, GFP_KERNEL);
>
> (This is always safe because as you said kmalloc can never return a
> slab that's not safe for DMA)  I don't see how PCI pools help here.
In the USB case, the "something" represents a device, and the "dma_buffer" is 
something you want to send-to / receive-from the device.

kmallocing the transfer buffers is a problem for suspend. Doing the "you get 
the transfer buffer with the device" is really useful, because you know that 
the device configuration will be returned. But we might need to re-init the 
device after a suspend, and [I've been told that] memory allocation may 
deadlock under these circumstances.

Would it be enought to move the transfer buffers to the start of the device 
struct, and then pad it up to a cacheline?

-- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
