Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274326AbRITGRU>; Thu, 20 Sep 2001 02:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274324AbRITGRK>; Thu, 20 Sep 2001 02:17:10 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:782 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S274327AbRITGQx>; Thu, 20 Sep 2001 02:16:53 -0400
Date: Wed, 19 Sep 2001 23:15:47 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Hugh Dickins <hugh@veritas.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>
Subject: Re: pre12 VM doubts and patch
In-Reply-To: <20010920080837.A719@athlon.random>
Message-ID: <Pine.LNX.4.33.0109192310340.2852-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 20 Sep 2001, Andrea Arcangeli wrote:
>
> hmm, the stuff inside #if 0 doesn't seem to be correct either there,
> write_access doesn't mean we have the right to write to it, it just mean
> we're trying to.

No, write_access means not only that we are trying to write to it, but it
(by implication) means that we have the right too - otherwise we would
have SIGSEGV'd.

Anyway, I'm not at all sure that the write_access test is worth it, we
could just never do it (like your patch), or we could test if we allow COW
and do early COW (which the write-access kind of means).

However, your patch isn't right for another reason: if we do delete it
from the swap cache, we'd better mark it dirty so that it gets
re-allocated a swap entry if it later on needs it.

That's why the old code went to such extremes: it marked it dirty and
writable if it was a write access (and exclusive), and it marked it _just_
dirty and removed it from the swap cache if it went over the swap limit.

Whether that complexity is worth it, I don't know.

		Linus

