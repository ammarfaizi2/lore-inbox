Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270683AbRHJX0l>; Fri, 10 Aug 2001 19:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270684AbRHJX0c>; Fri, 10 Aug 2001 19:26:32 -0400
Received: from neon-gw.transmeta.com ([63.209.4.196]:59151 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S270683AbRHJX0N>; Fri, 10 Aug 2001 19:26:13 -0400
Date: Fri, 10 Aug 2001 16:26:00 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Jamie Lokier <lk@tantalophile.demon.co.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: /proc/<n>/maps getting _VERY_ long
In-Reply-To: <3B745990.7040808@zytor.com>
Message-ID: <Pine.LNX.4.33.0108101618270.1045-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 10 Aug 2001, H. Peter Anvin wrote:
>
> Note that it isn't very hard to deal with *that* problem, *if you want
> to*... you just need to maintain a shadow data structure in the same
> format as the page tables and stuff your software bits in there.

Actually, this is what Linux already does.

The Linux page tables _are_ a "shadow data structure", and are
conceptually independent from the hardware page tables (or hash table, or
whatever the actual hardware uses to actually fill in the TLB).

This is most clearly seen on CPU's that don't have traditional page table
trees, but use software fill TLB's, hashes, or other things in hardware.

> Whether or not that is a good idea is another issue entirely, however,
> on some level it would make sense to separate protection from all the
> other VM things...

I think that the current Linux approach is much superior - the page tables
are conceptually a separate shadow data structure, but the way things are
set up, you can choose to make the mapping from the shadow data structure
to the actual hardware data structures be a 1:1 mapping.

This does mean that we do NOT want to make the Linux shadow page tables
contain stuff that is not easy to translate to hardware page tables.
Tough. It's a trade-off: either you overspecify the kernel page tables
(and take the hit of having to keep two separate page tables), or you say
"the kernel page tables are weaker than we could make them", and you get
the optimization of being able to "fold" them on top of the hardware page
tables.

I'm 100% convinced that the Linux VM does the right choice - we optimize
for the important case, and I will claim that it is _really_ hard for
anybody to make a VM that is as efficient and as fast as the Linux one.

Proof: show me a full-fledged VM setup that even comes _close_ in
performance, and gives the protection and the flexibility that the Linux
one does.

And yes, we do have _another_ shadow data structure too. It's called the
vm_area_struct, aka "vma", and we do not artificially limit ourself to
trying to look like hardware on that one.

Which brings us back to the original question, and answers it: we already
do all of this, and we do it RIGHT. We optimize for the right things.

		Linus

