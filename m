Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266368AbTABTIE>; Thu, 2 Jan 2003 14:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266377AbTABTIE>; Thu, 2 Jan 2003 14:08:04 -0500
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:49826 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S266368AbTABTIC>; Thu, 2 Jan 2003 14:08:02 -0500
Date: Thu, 02 Jan 2003 10:26:39 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] generic device DMA (dma_pool update)
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: akpm@digeo.com, James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org
Message-id: <3E14845F.5020808@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <200301020413.UAA03503@baldur.yggdrasil.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

Note that this "add gfp flags to dma_alloc_coherent()" issue is a tangent
to the dma_pool topic ... it's a different "generic device DMA" issue.

We already have the pci_pool allocator that knows how to cope (timeout and
retry) with the awkward semantics of pci_alloc_consistent() ... likewise,
we can tell that those semantics are problematic, both because they need
that kind of workaround and because they complicate reusing "better"
allocator code (like mm/slab.c) on top of the DMA page allocators.


> 	Let me clarify or revise my request.  By "show me or invent an
> example" I mean describe a case where this would be used, as in
> specific hardware devices that Linux has trouble supporting right now,
> or specific programs that can't be run efficiently under Linux, etc.

That doesn't really strike me as a reasonable revision, since that
wasn't an issue an improved dma_alloc_coherent() syntax was intended
to address directly.

To the extent that it's reasonable, you should also be considering
this corresponding issue:  ways that removing gfp_flags from the
corresponding generic memory allocator, __get_free_pages(), would be
improving those characteristics of Linux.  (IMO, it wouldn't.)


> 	I have trouble understanding why, for example, a USB hard
> disk driver would want anything more than a fixed size pool of
> transfer descriptors.  At some point you know that you've queued
> enough IO so that the driver can be confident that it will be
> called again before that queue is completely emptied.

For better or worse, that's not how it works today and it's not
likely to change in the 2.5 kernels.  "Transfer Descriptors" are
resources inside host controller drivers (bus drivers), allocated
dynamically (GFP_KERNEL in many cases, normally using a pci_pool)
when USB device drivers (like usb-storage) submit requests (URBs).

They are invisible to usb device drivers, except implicitly as
another reason that submitting an urb might trigger -ENOMEM.

And for that matter, the usb-storage driver doesn't "fire and
forget" as you described; that'd be a network driver model.
The storage driver needs to block till its request completes.


> 	Also, your use of the term GFP_KERNEL is potentially
> ambiguous.  In some cases GFP_KERNEL seems to mean "wait indifinitely
> until memory is available; never fail."  In other cases it means
> "perhaps wait a second or two if memory is unavailable, but fail if
> memory is not available by then."

Hmm, I was unaware that anyone expected GFP_KERNEL (or rather,
__GFP_WAIT) to guarantee that memory was always returned.  It's
not called __GFP_NEVERFAIL, after all.

I've always seen such fault returns documented as unrelated to
allocator parameters ... and treated callers that break on fault
returns as buggy, regardless of GFP_* parameters in use.  A
random sample of kernel docs agrees with me on that:  both
in Documentation/* (like the i2c stuff) or the O'Reilly book
on device drivers.

- Dave



