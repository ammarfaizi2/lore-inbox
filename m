Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131531AbQL1WmL>; Thu, 28 Dec 2000 17:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132027AbQL1WmB>; Thu, 28 Dec 2000 17:42:01 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:9877 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S131531AbQL1Wlv>; Thu, 28 Dec 2000 17:41:51 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] shmem_unuse race fix
In-Reply-To: <Pine.LNX.4.10.10012281003360.12064-100000@penguin.transmeta.com>
From: Christoph Rohland <cr@sap.com>
In-Reply-To: <Pine.LNX.4.10.10012281003360.12064-100000@penguin.transmeta.com>
Message-ID: <m3n1dgus5n.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: 28 Dec 2000 23:13:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> On 28 Dec 2000, Christoph Rohland wrote:
> > 
> > First we need the following patch since otherwise we use a swap entry
> > without having the count increased:
> 
> No, that shouldn't be needed.
> 
> Look at the code-path: the kernel has the page locked, so nothing will
> de-allocate the swap entry - so it's perfectly ok to increase it
> later.

I am not sure that page locking is done very strictly in the swap
cache. I had to fiddle around that sometimes in shmem.c. 

The patch actually is getting me the 'right error': Undead swap
entries in swapoff instead of bad swap entries in nopage. The latter
means there is a swapentry noted in the page table which was legally
removed. And that's definitely wrong.

> I dislike the "magic" __get_swap_page(2) thing - we might make
> get_swap_page() itself _always_ return a swap entry with count two
> (one fot eh swap cache, one for the user), or we should keep it the
> way it was (where we explicitly increment it for the user).

Yes, I agree. I was too lazy to check the other uses of get_swap_page
for this patchlet. But at least shmem.c uses the same and I think it's
logical. We always need a swap cache and a user reference.

> Ok. How about making try_to_unuse() just get the VM semaphore instead of
> the page table lock?
> 
> Then try_to_unuse() would follow all the right rules, and the above
> problem wouldn't exist..

If this is right we should do this. There is no need to care about
contention in swapoff. It's definitely not the common path. But we
have to be careful about deadlocks....

Greetings
                Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
