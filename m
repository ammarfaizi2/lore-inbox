Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273385AbRI0PiQ>; Thu, 27 Sep 2001 11:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273382AbRI0PiG>; Thu, 27 Sep 2001 11:38:06 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:22035 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S273371AbRI0Phv>; Thu, 27 Sep 2001 11:37:51 -0400
Date: Thu, 27 Sep 2001 08:38:02 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "David S. Miller" <davem@redhat.com>, <bcrl@redhat.com>,
        <marcelo@conectiva.com.br>, <andrea@suse.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Locking comment on shrink_caches()
In-Reply-To: <E15ma09-0003p9-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0109270835130.17030-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 27 Sep 2001, Alan Cox wrote:
>
> > Yes, this was my intended point.  Please see my quoted text above and
> > note the "exclusive cache line acquisition" with emphasis on the word
> > "acquisition" meaning you don't have the cache line in E state yet.
>
> See prefetching - the CPU prefetching will hide some of the effect and
> the spin_lock_prefetch() macro does wonders for the rest.

prefetching and friends won't do _anything_ for the case of a cache line
bouncing back and forth between CPU's.

In fact, it can easily make things _worse_, simply by having bouncing
happen even more (you bounce it into the CPU for the prefetch, another CPU
bounces it back, and you bounce it in again for the actual lock).

And this isn't at all unlikely if you have a lock that is accessed a _lot_
but held only for short times.

Now, I'm not convinced that pagecache_lock is _that_ critical yet, but is
it one of the top ones? Definitely.

		Linus

