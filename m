Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317680AbSGKGIK>; Thu, 11 Jul 2002 02:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317694AbSGKGIJ>; Thu, 11 Jul 2002 02:08:09 -0400
Received: from h-64-105-137-27.SNVACAID.covad.net ([64.105.137.27]:32442 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S317680AbSGKGII>; Thu, 11 Jul 2002 02:08:08 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 10 Jul 2002 23:09:53 -0700
Message-Id: <200207110609.XAA20931@adam.yggdrasil.com>
To: akpm@zip.com.au, dougg@torque.net, ingo.oeser@informatik.tu-chemnitz.de
Subject: Re: direct-to-BIO for O_DIRECT
Cc: axboe@suse.de, linux-kernel@vger.kernel.org, martin@dalecki.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Douglas Gilbert wrote:
>Ingo Oeser wrote:
[...]
>> It would be nice if we could just map a set of user pages to a scatterlist.
>
>After disabling kiobufs in sg I would like such a drop
>in replacement.
>
>> Developers of mass transfer devices (video grabbers, dsp devices, sg and
>> many others) would just LOVE you for this ;-)
>
>Agreed. Tape devices could be added to your list.
>Large page support will make for very efficient zero
>copy IO.
>
>> Block devices are the common case worth optimizing for, but character
>> devices just need to reimplement most of this, if they want the same 
>> optimizations. Some devices need mass transfers and are NOT blockdevices.
>
>> Please consider supporting them better for 2.5 in stuff similiar to BIOs
>> and DMA to/from user pages.
>
>CIOs?

	This is what I want to accomplish in my proposal to
pull most of the DMA transfer optimization code up from block
devices by generalizing DMA targets and turning struct scatterlist
into a linked list, discussed here:

	http://marc.theaimsgroup.com/?t=102487685000002&r=1&w=2

	I have not started coding this yet because:

	1. I'm tracking down a bug in the next revision of my proposed
	   bio_append patch (which eliminates {read,write}_full_page from
	   fs/buffers.c), and I want to hit that ball out of my court first.

	2. I want to look at aio to see if it has a better way or if it
	   could benefit from this.

	3. I want to accomodate Dave Miller's request for a non-PCI
	   generalization of pci_alloc_consistent, pci_map_single, etc.,
	   first, and that will depend on struct device, for which there are
	   some relevant changes working their way from Patrick Mochel
	   to Linus.

	4. After getting a general dma_alloc_consistent, etc. interface,
	   then I want to create a struct dma_target, to abstract
	   out the DMA capabilities currently maintained by the block
	   layer.  I hope that by doing this in stages, that it will be
	   more palatable to Jens, who expressed concern that the
	   my proposal to go to a linked list for struct scatterlist
	   was a bit too much change.

	Then, I think we'll be in a better position to go to a struct
scatterlist linked list or something similar that can be used by most
if not all big producers of IO.

	In the meantime, killing off kiobufs should be helpful.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
