Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274335AbRITGdO>; Thu, 20 Sep 2001 02:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274336AbRITGdF>; Thu, 20 Sep 2001 02:33:05 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:25614 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S274335AbRITGcy>; Thu, 20 Sep 2001 02:32:54 -0400
Date: Wed, 19 Sep 2001 23:31:45 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Hugh Dickins <hugh@veritas.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>
Subject: Re: pre12 VM doubts and patch
In-Reply-To: <20010920082602.A701@athlon.random>
Message-ID: <Pine.LNX.4.33.0109192326070.2852-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 20 Sep 2001, Andrea Arcangeli wrote:
>
> forget that, of course if write_access is set it means we can write to
> the page or the page fault would be finished much earlier. This looks
> much better:

You still need to mark the pte dirty. Becuase you know that it _is_ dirty,
or it wouldn't have had a swap cache entry allocated to it.

Or you need to not drop the swap cache.

Failing to mark it dirty will cause all kind sof interesting problems when
pages suddenly become zero-filled when the VM scanning just drops the old
contents (which sure makes for good performance, but not for nice
behaviour ;)

So I would suggest:

	if (exclusive_swap_page(page)) {
		if (vma->vm_flags & VM_WRITE)
			pte = pte_mkwrite(pte);
		pte = pte_mkdirty(pte);
		delete_from_swap_cache_nolock(page);
	}

or similar.

		Linus

