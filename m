Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317620AbSHCRbT>; Sat, 3 Aug 2002 13:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317622AbSHCRbT>; Sat, 3 Aug 2002 13:31:19 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:56070 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317620AbSHCRbS>; Sat, 3 Aug 2002 13:31:18 -0400
Date: Sat, 3 Aug 2002 10:22:42 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: David Woodhouse <dwmw2@infradead.org>
cc: davidm@hpl.hp.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       <linux-kernel@vger.kernel.org>, <davidm@napali.hpl.hp.com>
Subject: Re: adjust prefetch in free_one_pgd() 
In-Reply-To: <17304.1028393989@redhat.com>
Message-ID: <Pine.LNX.4.44.0208031014190.3981-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 3 Aug 2002, David Woodhouse wrote:
>
> If you prefetch off the end of your object, and the thing you end up
> prefetching is a DMA buffer which we'd just nuked from our cache to allow
> the device to DMA into it, something's going to be unhappy regardless of
> whether your prefetch faults or not.

Yeah, there are broken prefetches around. So what else is new?

My personal opinion is that if a prefetch has semantic meanings outside
the "speed up subsequent accesses", it should not be exposed to the rest
of the kernel (it might still be useful inside architecture-specific
routines like optimized memcpy etc).

If your caches aren't speculation-safe, then prefetch isn't safe to use in
a generic manner. Our current use is probably ok right now, but if we get
future code where doing a prefetch on a pointer that we do not trust is a
good idea, I would personally suggest just disabling prefetch on machines
where that is broken.

Examples of this might be using prefetch on user-supplied addresses (which
might in turn have IO mappings or other issues). Clearly it's not worth
doing a VMA lookup to see if the address is prefetch-safe, so either we
speed up non-broken machines, or we leave everybody slow.

I'd rather speed up non-broken machines and let the broken hardware
hopefully slowly die away.

		Linus

