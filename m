Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316833AbSEVCkT>; Tue, 21 May 2002 22:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316835AbSEVCkS>; Tue, 21 May 2002 22:40:18 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:6665 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316833AbSEVCkQ>; Tue, 21 May 2002 22:40:16 -0400
Date: Tue, 21 May 2002 19:40:08 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "David S. Miller" <davem@redhat.com>
cc: zippel@linux-m68k.org, <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.17
In-Reply-To: <20020521.191724.56166460.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0205211933490.989-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 21 May 2002, David S. Miller wrote:
>
> I think deferring this to the lazy TLB end at the next task switch is
> worth pursuing.

No can do.

If we tear down the page tables, we _have_ to flush the TLB on x86,
because even if we don't touch them later on, speculative execution may
end up causing TLB fills, and if we don't tell the TLB fill hw that we've
torn down the pages (by invalidating the TLB), you can get all the same
nasty behaviour.

And we cannot just defer the TLB flush to a later date ("who cares if we
get crap in the TLB, we'll flush it anyway"), because some of the bogus
TLB contents might get the "Global" bit set too. Which would mean that
those bogus entries wouldn't be flushed at all.

In short:
 - if we tear down the page tables, we _have_ to flush the TLB, even if we
   turn it into a lazy TLB.
 - At least on x86, once you flush the TLB, the incremental cost of doing
   a full mm switch is basically zero. The TLB flush is, after all, the
   real cost of the mm switch (this is likely to be true on other CPU's
   too).
 - so we can choose between just flushing the TLB (and leaving it lazy),
   and then on the next switch_mm() we flush it again when we switch into
   the next process, _OR_ we could try to opportunistically switch mm's
   "early".

The early switch would at least on x86 be likely to result in the minimal
amount of TLB flushing theoretically possible. Which I kind of like (if
you can _prove_ that you cannot do better, you're in a good position ;).

But the "just flush the TLB" approach certainly also works.

		Linus

