Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279735AbRJ3Bnu>; Mon, 29 Oct 2001 20:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279734AbRJ3Bnk>; Mon, 29 Oct 2001 20:43:40 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:45578 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S279730AbRJ3Bni>; Mon, 29 Oct 2001 20:43:38 -0500
Date: Mon, 29 Oct 2001 17:42:07 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "David S. Miller" <davem@redhat.com>
cc: <riel@conectiva.com.br>, <bcrl@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: please revert bogus patch to vmscan.c
In-Reply-To: <20011029.173400.35036258.davem@redhat.com>
Message-ID: <Pine.LNX.4.33.0110291736010.7778-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 29 Oct 2001, David S. Miller wrote:
>
> I'm asking him to show the case that "breaks for something
> else".

Guys, guys, calm down.

I removed the tlb invalidate that ended up being called millions of times,
but I don't really have anything fundamental against either invalidating
each mm as it comes up in swap_out_mm(), or maybe just doing a full TLB
invalidate for each swap_out(). As Ben points out, the invalidate doesn't
even have to be synchronous - the only thing we really care about is that
there is some upper bound for how long we can cache TLB entries witht eh
wrong accessed bit.

One reasonable (?), yet rare, upper bound might be something like
"swap_out() wrapped around the MM list".

This is particularly true since we won't actually _care_ about the
accessed bit until the second time around when it is clear, so the
"wrapped around the VM list" thing is (a) often enough to matter and (b)
obviously seldom enough that it shouldn't be a performance issue even if
it implies a cross-call to everybody.

The difference in call frequency would, on large machines, probably be on
the order of several magnitudes, which will certainly cut the overhead
down to the noise while satisfying people who have architectures that can
cache things for a long time.

Agreed?

(Yeah, maybe you think that's _too_ long. Civil arguments, please).

		Linus

