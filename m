Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129778AbRAIUID>; Tue, 9 Jan 2001 15:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129733AbRAIUHn>; Tue, 9 Jan 2001 15:07:43 -0500
Received: from chiara.elte.hu ([157.181.150.200]:32268 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S129729AbRAIUHi>;
	Tue, 9 Jan 2001 15:07:38 -0500
Date: Tue, 9 Jan 2001 21:07:17 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
In-Reply-To: <93fnve$250$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.30.0101092058090.8236-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 9 Jan 2001, Linus Torvalds wrote:

> I told David that he can fix the network zero-copy code two ways: either
> he makes it _truly_ scatter-gather (an array of not just pages, but of
> proper page-offset-length tuples), or he makes it just a single area and
> lets the low-level TCP/whatever code build up multiple segments
> internally.  Either of which are good designs.

it's actually truly zero-copy internally, we use an array of
(page,offset,length) tuples, with proper per-page usage counting. We did
this for than half a year. I believe the array-of-pages solution you refer
to went only from the pagecache layer into the highest level of TCP - then
it got converted into the internal representation. These tuples right now
do not have their own life, they are always associated with actual
outgoing packets (and in fact are allocated together with skb's and are at
the end of the header area).

the lowlevel networking drivers (and even midlevel networking code) knows
nothing about kiovecs or arrays of pages, it's using the array-of-tuples
representation:

typedef struct skb_frag_struct skb_frag_t;

struct skb_frag_struct
{
        struct page *page;
        __u16 page_offset;
        __u16 size;
};

/* This data is invariant across clones and lives at
 * the end of the header data, ie. at skb->end.
 */
struct skb_shared_info {
        atomic_t        dataref;
        unsigned int    nr_frags;
        struct sk_buff  *frag_list;
        skb_frag_t      frags[MAX_SKB_FRAGS];
};

(the __u16 thing is more of a cache footprint paranoia than real
necessity, it could be int as well.). So i do believe that the networking
code is properly designed in this respect, and this concept goes to the
highest level of the networking code.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
