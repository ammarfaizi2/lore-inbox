Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286692AbSBKCuz>; Sun, 10 Feb 2002 21:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286712AbSBKCuk>; Sun, 10 Feb 2002 21:50:40 -0500
Received: from nat-pool-meridian.redhat.com ([12.107.208.200]:64824 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S286692AbSBKCtm>; Sun, 10 Feb 2002 21:49:42 -0500
Date: Sun, 10 Feb 2002 21:49:41 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200202110249.g1B2nfx27479@devserv.devel.redhat.com>
To: stodden@in.tum.de, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: pci_pool reap?
In-Reply-To: <mailman.1013388420.27877.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.1013388420.27877.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> is it true that pci pools are never shrunk? or am i just missing the
> point where it happens?
> 
> try_to_free_pages() seems to care just about kmem_caches.

Yes, they do not shrink. When David-B wrote them, they shrunk.
Later I found an interrupt availability violation (pci_pool_free
can be called from an interrupt, it can call pci_free_consistent,
which cannot be called from an interrupt), so we got it removed.

There is a certain controversy about pci_free_consistent called
from an interrupt. It seems that most architectures would
have no problems, and only arm is problematic. RMK says that
it's not intrinsicly so, this is one of my TODO notes:

 ## 2001/12/18
<zaitcev> rmk: you do have some stuff broken, for instance using vmalloc for
           pci_alloc_consistent was a major pain for everyone else
<_rmk_> zaitcev: errrrrrrrr
<_rmk_> zaitcev: I don't use vmalloc there, never have done.
<_rmk_> I use alloc_pages and ioremap
<_rmk_> You're thinking about the sa1100 people who decided to make pci_map_*
           fail I think.
<zaitcev> hmm. I'll re-investigate.
<_rmk_> which... is not something I agree with either.
<_rmk_> but quite honestly, with Intel breaking the hardware soo badly, it
           being popular and continues to be reused on other platforms, its
           something we're going to have to live with.

Wanna take it up personally? I seem never to have a time.

-- Pete
