Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130707AbRCEWJh>; Mon, 5 Mar 2001 17:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130706AbRCEWJ2>; Mon, 5 Mar 2001 17:09:28 -0500
Received: from colorfullife.com ([216.156.138.34]:1546 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S130717AbRCEWJR>;
	Mon, 5 Mar 2001 17:09:17 -0500
Message-ID: <001f01c0a5c0$e942d8f0$5517fea9@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: <zaitcev@redhat.com>
Cc: <linux-usb-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
        <david-b@pacbell.net>
Subject: Re: SLAB vs. pci_alloc_xxx in usb-uhci patch
Date: Mon, 5 Mar 2001 23:08:10 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And mm/slab.c changes semantics when CONFIG_SLAB_DEBUG
> is set: it ignores SLAB_HWCACHE_ALIGN. That seems more like
> the root cause of the problem to me!
>

HWCACHE_ALIGN does not guarantee a certain byte alignment. And
additionally it's not even guaranteed that kmalloc() uses that
HWCACHE_ALIGN.
Uhci is broken, not my slab code ;-)

> I think that the pci_alloc_consistent patch that Johannes sent
>by for "uhci.c" would be a better approach. Though I'd like
>to see that be more general ... say, making mm/slab.c know
>about such things. Add a simple abstraction, and that should
>be it -- right? :-)

I looked at it, and there are 2 problems that make it virtually
impossible to integrate kmem_cache_alloc() with pci memory alloc without
a major redesign:

* pci_alloc_consistent returns 2 values, kmem_cache_alloc() only one.
This one would be possible to work around.

* the slab allocator heavily relies on the 'struct page' structure, but
it's not guaranteed that it exists for pci_alloced memory.

I'd switch to pci_alloc_consistent with some optimizations to avoid
wasting a complete page for each DMA header. (I haven't seen Johannes
patch, but we discussed the problem 6 weeks ago and that proposal was
the end of the thread)

--

    Manfred

