Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317566AbSGTXVk>; Sat, 20 Jul 2002 19:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317568AbSGTXVk>; Sat, 20 Jul 2002 19:21:40 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:40464 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317566AbSGTXVj>; Sat, 20 Jul 2002 19:21:39 -0400
Date: Sat, 20 Jul 2002 16:25:21 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Robert Love <rml@tech9.net>
cc: linux-kernel@vger.kernel.org, <linux-mm@kvack.org>,
       <riel@conectiva.com.br>, <wli@holomorphy.com>
Subject: Re: [PATCH] generalized spin_lock_bit
In-Reply-To: <1027200016.1086.800.camel@sinai>
Message-ID: <Pine.LNX.4.44.0207201622350.1814-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 20 Jul 2002, Robert Love wrote:
>
> My assumption was similar - that the bit locking may be inefficient on
> other architectures - so I put the spin_lock_bit code in per-arch
> headers.

Well, but you also passed it an unsigned long, and the bit number.

Which at least to me implies that they have to set that bit.

Which is totally unnecessary, if they _instead_ decide to set something
else altogether.

For example, the implementation on pte_chain_lock(page) might be something
like this instead:

	static void pte_chain_lock(struct page *page)
	{
		unsigned long hash = hash(page) & PTE_CHAIN_MASK;
		spin_lock(pte_chain[hash]);
	}

	static void pte_chain_unlock(struct page *page)
	{
		unsigned long hash = hash(page) & PTE_CHAIN_MASK;
		spin_unlock(pte_chain[hash]);
	}

> In other words, I assumed we may need to make some changes but to
> bit-locking in general and not rip out the whole design.

bit-locking in general doesn't work. Some architectures can sanely only
lock a byte (or even just a word).

		Linus

