Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272685AbTHPJid (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 05:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272688AbTHPJid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 05:38:33 -0400
Received: from AMarseille-201-1-3-2.w193-253.abo.wanadoo.fr ([193.253.250.2]:7975
	"EHLO gaston") by vger.kernel.org with ESMTP id S272685AbTHPJib
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 05:38:31 -0400
Subject: Re: [BUG] slab debug vs. L1 alignement
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <3F3D8D3B.3020708@colorfullife.com>
References: <3F3D558D.5050803@colorfullife.com>
	 <1060990883.581.87.camel@gaston>  <3F3D8D3B.3020708@colorfullife.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1061026667.881.100.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 16 Aug 2003 11:37:48 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> >Yes, I understand that, but that is wrong for GFP_DMA imho. Also, 
> >SLAB_MUST_HWCACHE_ALIGN just disables redzoning, which is not smart,
> >I'd rather allocate more and keep both redzoning and cache alignement,
> >that would help catch some of those subtle problems when a chip DMA
> >engine plays funny tricks.
> >
> I don't want to upgrade SLAB_HWCACHE_ALIGN to SLAB_MUST_HWCACHE_ALIGN 
> depending on GFP_DMA: IIRC one arch (ppc64?) marks everything as 
> GFP_DMA, because all memory is DMA capable.

Same for ppc32. Anyway, I don't like MUST_HWCACHE_ALIGN because it
just disables redzoning, I'd rather allocate more and do both redzoning
and cache alignement.

In fact, I think cache alignement should be a property of all kmalloc
calls for any size > L1 cache line size for obvious perfs reasons, and
redzoning shouldn't change such a property...

> Which arch do you use? Perhaps alignment could be added for broken archs.
> 
> Actually I think you should fix your arch, perhaps by double buffering 
> in pci_map_ if the input pointers are not aligned. What if someone uses 
> O_DIRECT with an unaligned pointer?

ppc32 "normally" is cache coherent, that is with high end or desktop CPUs,
embedded CPUs aren't. Some archs like ARM arent't. But in this case, the
problem is related to a broken SCSI controller on the motherboard which
will cause corruption on non-aligned buffers (it basically always issues
memory write and invalidate cycles).

Anyway, I _still_ think it's stupid to return non-aligned buffers, both
for performances, and because that prevents from dealing with such cases,
typically the SCSI layer assumes alignement here among others...

Regarding O_DIRECT with an unaligned pointer, I haven't looked at this
case yet, I suppose it will be broken in a whole lot of cases.

Ben.

