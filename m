Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317504AbSHCTo5>; Sat, 3 Aug 2002 15:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317540AbSHCTo5>; Sat, 3 Aug 2002 15:44:57 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:32012 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317504AbSHCTo5>; Sat, 3 Aug 2002 15:44:57 -0400
Date: Sat, 3 Aug 2002 12:36:17 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: David Woodhouse <dwmw2@infradead.org>
cc: davidm@hpl.hp.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       <linux-kernel@vger.kernel.org>, <davidm@napali.hpl.hp.com>
Subject: Re: adjust prefetch in free_one_pgd() 
In-Reply-To: <18259.1028396351@redhat.com>
Message-ID: <Pine.LNX.4.44.0208031230400.9758-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 3 Aug 2002, David Woodhouse wrote:
>
> Not that I'm necessarily disagreeing with you -- but can you confirm that
> you are including all architectures with non-cache-coherent DMA in the
> 'broken hardware' category below, or point out what I'm missing?

Rule: if prefetch to random addresses is a problem, then that's broken
hardware.

I don't think that non-cache-coherency wrt DMA necessarily means that that
is true, though. If you flush all CPU caches to memory before starting the
DMA, and you invalidate the DMA'd memory range _after_ the DMA finished, a
"prefetch" on such an architecture is not a problem at all.

Sure, the data vould have been (for a while - between the potential
prefetch and the "DMA write finish invalidate") in the CPU caches in a
non-coherent state, but since the kernel reading anything from that region
would have been a bug in the first place, that should not matter.

Note that such architectures have issues with speculative reads etc too,
which can have all the same issues as prefetch. Of course, only slow and
stupid architectures tend to have non-coherent caches in the first place,
so "speculation" simply isn' tmuch of an issue.

		Linus

(That's not to say that I think that non-coherent DMA is broken _anyway_,
but I don't think it should be a problem for prefetch itself)

