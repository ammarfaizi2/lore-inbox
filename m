Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317641AbSFLGYB>; Wed, 12 Jun 2002 02:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317643AbSFLGYB>; Wed, 12 Jun 2002 02:24:01 -0400
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:48797 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S317641AbSFLGX6>; Wed, 12 Jun 2002 02:23:58 -0400
Date: Tue, 11 Jun 2002 23:25:09 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <3D06E945.7070301@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
In-Reply-To: <3D058B41.6010601@pacbell.net>
 <20020610.224401.13280464.davem@redhat.com> <3D061363.70500@pacbell.net>
 <20020611.202553.28822742.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
>    From: David Brownell <david-b@pacbell.net>
>    
>    Should the dma mapping APIs try to detect the "DMA buffer starts in
>    middle of non-coherent cacheline" case, and fail?
>    
> This brings back another issue, returning failure from pci_map_*()
> and friends which currently cannot happen.

An issue that'll get fixed, yes? :)

I'd suspect ((dma_addr_t)0) would be a reasonable error return.
At least some hardware treats such values like software would
treat null pointers.  No call syntax change necessary, which
might be good or bad depending on how you feel tomorrow.


> Remember please that specifically the DMA mapping APIs encourage use
> of consistent memory for small data objects.  ...
> ...  The non-consistent end of the APIs is
> meant for long contiguous buffers, not small chunks.

And in between, a nice huge grey area to play with and argue about!


> This is one of the reasons I want to fix this by making people use
> either consistent memory or PCI pools (which is consistent memory
> too).

For that model, I would prefer tools more like a kmalloc than the
pci_pool, which is most like a kmem_cache_t.  The particular objects
in question are a bit small to use page-or-bigger allocators, too.

The problem for APIs like USB is that they haven't yet exposed DMA
addresses.  Doing that, giving folk a choice from the "non-consistent
end of the APIs", would be a big change.


Oh no -- I just had an evil thought.  Now that we have the device model
code partially in place, shouldn't we have DMA memory calls talk in
terms of "struct device" not "struct pci_device"?  That'd be the way
to have _one_ API for dma mapping (and consistent memory allocation),
working for PCI, USB, and any other bus framework that comes along.

Nah ... forget I said that.  Too logical, it could never happen!  ;)

- Dave






