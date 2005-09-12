Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbVILLXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbVILLXu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 07:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbVILLXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 07:23:50 -0400
Received: from cantor2.suse.de ([195.135.220.15]:56500 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750743AbVILLXt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 07:23:49 -0400
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [1/3] Add 4GB DMA32 zone
Date: Mon, 12 Sep 2005 13:22:08 +0200
User-Agent: KMail/1.8
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, discuss@x86-64.org
References: <43246267.mailL4R11PXCB@suse.de> <200509121242.20910.ak@suse.de> <1126524787.30449.56.camel@localhost.localdomain>
In-Reply-To: <1126524787.30449.56.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509121322.09138.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 September 2005 13:33, Alan Cox wrote:
> On Llu, 2005-09-12 at 12:42 +0200, Andi Kleen wrote:
> > (I cannot in fact remember a report of someone running especially
> > into this problem)  And the cards seem to be essentially dead in the
> > market now. So it's really more a theoretical problem than a practical
> > one. [Proof of it: the current sources don't seem to handle it, so
> > it cannot be that bad ;-]
>
> Current sources don't handle DMA32, so that can't be bad either. Can we
> stick to sensible discussion, its quicker.

Well discussing broken hardware that is rarely used on 64bit systems
with enough memory doesn't seem very sensible to me.

But ok:

Even a 2GB DMA32 wouldn't magically fix it anyways.


>
> There have been various reports over time, quite a few early on when we
> had a long series of on list discussions trying to debug what appeared
> to be an iommu bug but was in fact a kernel bug.
>
> You hit it on any size AMD64 with iommu, but since most aacraid users
> are intel boxes it doesn't hurt too many, and the rest all know about
> turning the iommu off on the box (but that hurts the rest), or just run
> something else because Linux "doesn't work".

You need essentially the same code to fix it with GFP_DMA32 as with
GFP_DMA. Some bounce code that allocates low memory and does
the necessary bounces.

The only difference with GFP_DMA is that the bounce pool is smaller

Limiting everybody else just to get a bigger bounce pool on a single
broken device that isn't even shipping anymore doesn't seem like sensible 
design approach to me.

>
> > That is why I essentially ignored the b44. AFAIK the driver
> > has a GFP_DMA bounce workaround anyways, so it would work
> > anyways.
>
> Usually - the DMA zone at 16MB is too small so allocations sometimes
> fail. It btw would want 1GB limits.

mempool - sleep on a waitqueue until someone frees. In fact the kernel's 
normal allocator is already quite good at that so you might not even
need that.


>
> Doesn't work. The DMA area is way too small with all the users already
> and the aacraid can and does want a lot of outstanding I/O. Using a 1GB
> or 2GB boundary line hurts nobody doing "allocate me some memory below
> 4Gb" because nobody asks for .5GB chunks. A 4GB zone means we need to
> either increase the 16MB zone or add yet another one.

This is really only a problem if a significant fraction of your memory
is beyond the limit (otherwise most buffers can go directly). 

And with the mempool sleep approach they will just get small queues. Yes
that will be slower, but if you want performance on boxes with a lot of memory 
you should not buy broken hardware.

Basically aacraid was always broken and it is not more or not less broken
than it was before with DMA32.

-Andi
