Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129511AbQL1FF1>; Thu, 28 Dec 2000 00:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130893AbQL1FFR>; Thu, 28 Dec 2000 00:05:17 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:13317 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129511AbQL1FFE>; Thu, 28 Dec 2000 00:05:04 -0500
Date: Wed, 27 Dec 2000 20:35:56 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Christoph Rohland <cr@sap.com>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] shmem_unuse race fix
In-Reply-To: <m3ae9haf4x.fsf@linux.local>
Message-ID: <Pine.LNX.4.21.0012272025190.528-100000@dual.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 27 Dec 2000, Christoph Rohland wrote:

> Marcelo Tosatti <marcelo@conectiva.com.br> writes:
> 
> > I think that incrementing the swap entry count will not allow swap from
> > removing the swap entry (as the comment says)
> 
> I think the culprit is somewhere else. The error occurs in nopage of a
> process, not in swapoff.

I think swapoff() should be fixed..

I moved the

	if (PageSwapCache(page))
		delete_from_swap_cache(page);

thing to _before_ the "unuse_process()" and "shmem_unuse()" code, because
I wanted to avoid a race on the PageDirty bit that way. However, that
opens up another race, the one you see with "nopage".

Woul dyou mind testing this alternate fix instead:

 - add the lines

	repeat:
		ClearPageDirty(page);

   to just before the "read_lock(&tasklist_lock);" in try_to_unuse(). We
   can obviously mark the page clean, because we _are_ going to get rid of
   it, and in the meantime we have a hold on it by virtue of having raised
   the page count in "read_swap_cache()".

 - move the "delete_from_swap_cache()" call back to _after_ the
   unuse() calls.

 - but just before deleting the entry, we add a new test:

	if (PageDirty(page))
		goto repeat;

this all should mean that if something moves the dirty bit from a page
table to the backing store, we will notice, and just re-do the VM scan,
which will mark the page table entry dirty again. And because we delete it
from the swap cache late, we aren't severing the link with
"nopage" handling.

Christoph, how does this sound to you?

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
