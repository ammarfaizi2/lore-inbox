Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265208AbTLZR7N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 12:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265209AbTLZR7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 12:59:13 -0500
Received: from fw.osdl.org ([65.172.181.6]:36230 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265208AbTLZR7L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 12:59:11 -0500
Date: Fri, 26 Dec 2003 09:59:09 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Rik van Riel <riel@surriel.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: Page aging broken in 2.6
In-Reply-To: <1072423739.15458.62.camel@gaston>
Message-ID: <Pine.LNX.4.58.0312260957100.14874@home.osdl.org>
References: <1072423739.15458.62.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 26 Dec 2003, Benjamin Herrenschmidt wrote:
> 
> in mm/rmap.c, in page_referenced(), we do that twice:
> 
>                 if (ptep_test_and_clear_young(pte))
>                         referenced++;
> 
> And we never flush the TLB entry. 
> 
> I don't know if x86 (or other archs really using page tables) will
> actually set the referenced bit again in the PTE if it's already set
> in the TLB, if not, then x86 needs a flush too.

This was very much done on purpose. The theory is, that if you're low on
memory and have a lot of pages mapped, you will see enough TLB trashing
for this to not matter.

And if you aren't low on memory, or don't have a lot of pages mapped, it 
_also_ doesn't matter.

> ppc and ppc64 need a flush to evict the entry from the hash table or
> we'll never set the _PAGE_ACCESSED bit anymore.

Yeah, all hail bad MMU's.

Hash tables may need some kind of "not very urgent TLB flush" thing, so 
that it doesn't penalize sane architectures.

		Linus
