Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317709AbSFLONH>; Wed, 12 Jun 2002 10:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317710AbSFLONG>; Wed, 12 Jun 2002 10:13:06 -0400
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:9440 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S317709AbSFLONF>; Wed, 12 Jun 2002 10:13:05 -0400
Date: Wed, 12 Jun 2002 07:14:17 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
To: "David S. Miller" <davem@redhat.com>
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Message-id: <3D075739.7010506@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
In-Reply-To: <20020611.202553.28822742.davem@redhat.com>
 <20020611173347.21348@smtp.adsl.oleane.com>
 <20020612.024224.60294929.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    Please don't limit the API design to PCI ;)
>    
> When I say "PCI pools" think "struct device pools" because that
> will what it will be in the end.
> 
> That is Linus's long range plan, everything you see as pci_*
> will become dev_*.

I think the guts of it could happen in the 2.5 series soonish
though, so it'd only be "long range" in that quaint Wall Street
sense of "finishes sometime after next quarter".  :)

Just to put some flesh on the discussion ... here's the rough
shape of what I was thinking, as more wood for the fire:

- Associated with a "struct device" would be some kind of
   memory allocator/mapper object that would expose every (?)
   primitive in DMA-mapping.txt, but not PCI-specific.  That
   would basically be a vtable, using the device for state.

	struct dev_dma_whatsit {
	    /* page-level "consistent" allocators
	     * should they continue to be nonblocking?
	     */
	    void *alloc_consistent(struct device *dev,
		size_t *size, dma_addr_t *dma);
	    void free_consistent(struct device *dev,
		size_t size, void *addr, dma_addr_t dma);

	    /* "streaming mapping" calls
	     * return BAD_DMA_ADDR on error
	     */
	    dma_addr_t map_single(struct device *dev,
		void *addr, size_t size, int dir);
	    void unmap_single(struct device *dev,
		dma_addr_t, size_t size, int dir);
	    void sync_single(struct device *dev,
		dma_addr_t, size_t size, int dir);
		
	    /* Also: dma masks, page and scatterlist
	     * map/unmap/sync, dma64_addr_t, ...
	     */
	};

   Those would be designed so they could be shared between
   devices, invisibly to code talking to a struct device.

   Example:  all USB devices connected to a given bus would
   normally delegate to the PCI device underlying that bus.
   (Except for non-PCI host controllers, of course!)

   And the PCI versions of those methods have rather obvious
   implementations ... :)

- There'd be dev_*() routines that in many cases just call
   directly to those methods, or failed cleanly if the whatsit
   wasn't set up ("used the default allocator"), or omitted
   key methods.  Many could be inlinable functions:

	dev_alloc_consistent(...)
	dev_free_consistent(...)
	dev_map_single(...)
	... etc

   In some cases they'd mostly be layered over those primitives:

	/* kmalloc analogue */
   	void *dev_kmalloc(struct device *dev,
		size_t size, int mem_flags,
		dma_addr_t *dma);
	void dev_kfree (struct device *dev, void *mem,
		dma_addr_t dma);

	/* pci_pool/kmem_cache_t analogues */
	struct dev_pool *dev_pool_create(const char *name,
		struct device *dev, size_t size,
		size_t allocation, int mem_flags);
	void dev_pool_destroy(struct dev_pool *pool);

	void *dev_pool_alloc(struct dev_pool *pool,
		int mem_flags, dma_addr_t *dma);
	void dev_pool_free(struct dev_pool *pool,
		void *mem, dma_addr_t dma);
		
- Some of the other driver APIs would want to change to
   leverage these primitives.  They might want to provide
   wrappers to make the dev_*() calls given the subsystem
   device API.

   Again using USB for an, one _possible_ change would be
   to make urb->transfer_buffer be a dma_addr_t ... where
   today it's a void*.  (Discussions of such details belong
   on the linux-usb-devel list, for the most part.)   That'd
   be a pretty major change to the USB API, since it'd force
   device drivers to manage DMA mappings.  While usb-storage
   might benefit from sglist support, other drivers might
   not see much of a win.

OK, that's enough trouble for this morning... ;)

- Dave



