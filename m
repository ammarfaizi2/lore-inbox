Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316831AbSFKFan>; Tue, 11 Jun 2002 01:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316832AbSFKFam>; Tue, 11 Jun 2002 01:30:42 -0400
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:49134 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S316831AbSFKFal>; Tue, 11 Jun 2002 01:30:41 -0400
Date: Mon, 10 Jun 2002 22:31:45 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <3D058B41.6010601@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Roland Dreier <roland@topspin.com>
> Date: 10 Jun 2002 21:39:27 -0700
> 
>        David> How about allocating struct something using pci_pool?
>    
>    The problem is the driver can't safely touch field1 or field2 near the
>    DMA (it might pull the cache line back in too soon, or dirty the cache
>    line and have it written back on top of DMA'ed data)
> 
> Oh duh, I see, then go to making the thing a pointer to the
> dma area.

If it's going to be a pointer, it might as well be normal kmalloc data,
avoiding obfuscation of the memory model used by USB device drivers.
(They don't have to worry about DMA addresses, which IMO is a feature.)

Seems like there are two basic options for how to handle all this.

(a) Expose the dma/cache interaction to device drivers, so
     they can manage (and prevent) bad ones like the cacheline
     sharing scenarios.

(b) Require drivers to provide I/O buffers that are slab/page/...
     pointers from some API that prevents such problems.

I think (a) is more or less a variant of the existing alignment
requirements that get embedded in ABIs, but which still show up
in code that's very close to the hardware.  Many device driver
folk are familiar with them, or performance tuners, but not so
many folk doing USB device drivers would be.  (They are thankfully
far from host controller hardware and its quirks!)

Personally I'd avoid (b) since I like to allocate memory all at
once in most cases ... lots fewer error cases to cope with (or,
more typically _not_ cope with :).

One question is whether to support only one of them, or allow both.
In either case the DMA-mapping.txt will need to touch on the issue.

- Dave




