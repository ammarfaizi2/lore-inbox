Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130742AbRCEW55>; Mon, 5 Mar 2001 17:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130743AbRCEW5s>; Mon, 5 Mar 2001 17:57:48 -0500
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:37078 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S130742AbRCEW5i>; Mon, 5 Mar 2001 17:57:38 -0500
Date: Mon, 05 Mar 2001 14:52:24 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: SLAB vs. pci_alloc_xxx in usb-uhci patch
To: Manfred Spraul <manfred@colorfullife.com>, zaitcev@redhat.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Message-id: <00d401c0a5c6$f289d200$6800000a@brownell.org>
MIME-version: 1.0
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: text/plain; charset="iso-8859-1"
Content-transfer-encoding: 7bit
X-MSMail-Priority: Normal
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
In-Reply-To: <001f01c0a5c0$e942d8f0$5517fea9@local>
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > And mm/slab.c changes semantics when CONFIG_SLAB_DEBUG
> > is set: it ignores SLAB_HWCACHE_ALIGN. That seems more like
> > the root cause of the problem to me!
> 
> HWCACHE_ALIGN does not guarantee a certain byte alignment. And
> additionally it's not even guaranteed that kmalloc() uses that
> HWCACHE_ALIGN.
> Uhci is broken, not my slab code ;-)

If so, the slab code docs/specs are broken too ... I just checked in
my development tree (2.4.2-ac7 plus goodies) and what's written
is that HWCACHE_ALIGN is to "Align the objects in this cache to
a hardware cacheline."  Which contradicts what you just wrote;
it's supposed to always align, not do so only when convenient.

Clearly, something in mm/slab.c needs to change even if it's just
changing the spec for kmem_cache_create() behavior.


> I'd switch to pci_alloc_consistent with some optimizations to avoid
> wasting a complete page for each DMA header. (I haven't seen Johannes
> patch, but we discussed the problem 6 weeks ago and that proposal was
> the end of the thread)

I didn't see that thread.  I agree, pci_alloc_consistent() already has
a signature that's up to the job.  The change you suggest would need
to affect every architecture's implementation of that code ... which
somehow seems not the best solution at this time.

Perhaps we should have different functions for pci consistent alloc
at the "hardware" level (what we have now) and at the "slab" level.

That's sort of what Johannes' patch did, except it was specific to
that one driver rather than being a generic utility.  Of course, I'd
rather that such a generic package have all the debug support
(except broken redzoning :-) that the current slab code does.

- Dave


