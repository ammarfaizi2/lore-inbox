Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282064AbRKZTMM>; Mon, 26 Nov 2001 14:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282346AbRKZTL6>; Mon, 26 Nov 2001 14:11:58 -0500
Received: from mx2.elte.hu ([157.181.151.9]:8929 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S282064AbRKZTLS>;
	Mon, 26 Nov 2001 14:11:18 -0500
Date: Mon, 26 Nov 2001 22:09:02 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Momchil Velikov <velco@fadata.bg>
Cc: <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] Scalable page cache
In-Reply-To: <87vgfxqwd3.fsf@fadata.bg>
Message-ID: <Pine.LNX.4.33.0111262201420.18923-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hm, as far as i can see, your patch dirties both cachelines of the target
struct page on every lookup (page_splay_tree_find()), correct? If correct,
is this just an implementational thing, or something more fundamental?

i've been thinking about getting rid of some of the cacheline dirtying in
the page lookup code, ie. something like this:

- #define SetPageReferenced(page)    set_bit(PG_referenced, &(page)->flags)
+ #define SetPageReferenced(page) \
+	if (!test_bit(PG_referenced), &(page)->flags) \
+		set_bit(PG_referenced, &(page)->flags)

this would have the benefit of not touching the cacheline while doing a
simple read(), if the referenced bit is still set. (which is not cleared
too eagerly in most no-VM-pressure cases.) And it should not be a problem
that this is not race-free - missing to set the referenced bit is not a
big failure.

	Ingo

