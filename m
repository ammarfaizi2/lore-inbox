Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268934AbRHCLcr>; Fri, 3 Aug 2001 07:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268940AbRHCLch>; Fri, 3 Aug 2001 07:32:37 -0400
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:24479 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S268934AbRHCLcU>; Fri, 3 Aug 2001 07:32:20 -0400
Date: Fri, 3 Aug 2001 13:32:28 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: changes to kiobuf support in 2.4.(?)4
Message-ID: <20010803133228.P750@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <10108012254.ZM192062@classic.engr.sgi.com> <20010802084259.H29065@athlon.random> <slrn9mi3g9.36p.kraxel@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <slrn9mi3g9.36p.kraxel@bytesex.org>; from kraxel@bytesex.org on Thu, Aug 02, 2001 at 08:23:37AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2001 at 08:23:37AM +0000, Gerd Knorr wrote:
> >  The reason of the large allocation and to put the bh inside the kiobuf
> >  is that if we do a small allocation then we end with a zillion of
> >  allocations of the bh and freeing of the bh at every I/O!! (not even at
> >  every read/write syscall, much more frequently)
> 
> That is true for block device I/O only.  Current bttv versions are using
> kiobufs to lock down user pages for DMA.  But I don't need the bh's to
> transfer the video frames ...

This is another problem. We miss a whole layer of fast streaming
and chunking IO, which is not meant for block devices.

The most practical example would be the sg-driver, but there are
other things which require this kind of semantic:

Transmit Buffer via DMA to device (and programming it for
operations on that buffer) and possible receiving sth. back.

We need no reordering here, but would like to do the DMA directly
from user space buffers.

Examples:

   - GiMP plugin, which renders some complex algorithm on a DSP.

   - Crypto (Co-)processors, which encrypt data streams

   - Screengrabbers, which can grab a specific area.

   - (intelligent, multi) data aquisistion devices (large sensor
     arrays)

   ...

I would like to have a thing like the zero copy IO in the network
layer, but not done with NICs only, but with ANY device.

For the DSP case (which might be the most complex one) I did some
research already, but I don't like to see this work duplicated
over and over again.

I built transfer structs similar to BHs but more simply and have
a queue of that per device and allocate transfers from a slab.

The blocking and unblocking is done in the driver anyway. I only
try to do zero copy IO, if I have complete pages, which
simplifies it a "little" ;-)

Without the coalescing and reordering it's pretty simple.

What do the gurus think here?

Regards

Ingo Oeser
-- 
You mean a kill file only kills email!!!! DAMN!!!! All these years
I thought I was doing the gene pool some good...
                             --- "Clint Wolff" <vaxman@qwest.net>
