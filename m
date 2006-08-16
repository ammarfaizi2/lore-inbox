Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbWHPMDz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbWHPMDz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 08:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbWHPMDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 08:03:55 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:15596 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751121AbWHPMDy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 08:03:54 -0400
Date: Wed, 16 Aug 2006 16:00:26 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@infradead.org>, David Miller <davem@davemloft.net>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [PATCH 1/1] network memory allocator.
Message-ID: <20060816120026.GA30291@2ka.mipt.ru>
References: <20060814110359.GA27704@2ka.mipt.ru> <20060816084808.GA7366@infradead.org> <20060816090028.GA25476@2ka.mipt.ru> <200608161327.02826.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <200608161327.02826.arnd@arndb.de>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 16 Aug 2006 16:00:30 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2006 at 01:27:02PM +0200, Arnd Bergmann (arnd@arndb.de) wrote:
> On Wednesday 16 August 2006 11:00, Evgeniy Polyakov wrote:
> > There is drawback here - if data was allocated on CPU wheere NIC is
> > "closer" and then processed on different CPU it will cost more than 
> > in case where buffer was allocated on CPU where it will be processed.
> > 
> > But from other point of view, most of the adapters preallocate set of
> > skbs, and with msi-x help there will be a possibility to bind irq and
> > processing to the CPU where data was origianlly allocated.
> > 
> > So I would like to know how to determine which node should be used for
> > allocation. Changes of __get_user_pages() to alloc_pages_node() are
> > trivial.
> 
> There are two separate memory areas here: Your own metadata used by the
> allocator and the memory used for skb data.
> 
> avl_node_array[cpu] and avl_container_array[cpu] are only designed to
> be accessed only by the local cpu, so these should be done like
> 
> avl_node_array[cpu] = kmalloc_node(AVL_NODE_PAGES * sizeof(void *),
> 			GFP_KERNEL, cpu_to_node(cpu));
> 
> or you could make the whole array DEFINE_PER_CPU(void *, which would
> waste some space in the kernel object file.
> 
> Now for the actual pages you get with __get_free_pages(), doing the
> same (alloc_pages_node), will help accessing your avl_container 
> members, but may not be the best solution for getting the data
> next to the network adapter.

I can create it with numa_node_id() right now and later, if there will
exsist some helper to match netdev->node, it can be used instead.

> 	Arnd <><

-- 
	Evgeniy Polyakov
