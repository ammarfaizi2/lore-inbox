Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131245AbQL1StV>; Thu, 28 Dec 2000 13:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131424AbQL1StL>; Thu, 28 Dec 2000 13:49:11 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:12561 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S131245AbQL1StH>; Thu, 28 Dec 2000 13:49:07 -0500
Date: Thu, 28 Dec 2000 14:25:56 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Juan Quintela <quintela@fi.udc.es>, Rik van Riel <riel@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] not sleep while holding a locked page in block_truncate_page
In-Reply-To: <Pine.LNX.4.10.10012280955570.12064-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0012281411550.12364-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 28 Dec 2000, Linus Torvalds wrote:

> 
> 
> On Thu, 28 Dec 2000, Marcelo Tosatti wrote:
> > 
> > Hi Linus, 
> > 
> > block_truncate_page() function unecessarily calls mark_buffer_dirty(),
> > which may wait on bdflush, while holding a locked page.
> 
> Good catch. It should be ok to sleep for bdflush while holding the page,
> but at the same time it's certainly preferable _not_ to do that.
> 
> bdflush should not need any locks that we hold, so it shouldn't have
> deadlocked. How did you find this? Just reading the source, or have you
> seen any real problems? 

Just reading the code.

> If the latter, maybe there's something that tries to get a FS lock
> when it shouldn't?

No, its not a deadlock. Its just a potential performance
problem. 

Actually, ext2 is full of calls to mark_buffer_dirty() while holding the
superblock lock. Juan Quintela (which is being CC'ed) has a patch to
minimize the contention of the superblock lock by calling balance_dirty()
only after the sb lock gets unlocked all over ext2. Would you accept that
patch for 2.4?

Moreover, it seems mark_buffer_dirty does not makes a lot of sense wrt
balance_dirty:

---

/* atomic version, the user must call balance_dirty() by hand
   as soon as it become possible to block */
void __mark_buffer_dirty(struct buffer_head *bh)
{
        if (!atomic_set_buffer_dirty(bh))
                __mark_dirty(bh);
}

void mark_buffer_dirty(struct buffer_head *bh)
{
        __mark_buffer_dirty(bh);
        balance_dirty(bh->b_dev);
}

--- 

If we call mark_buffer_dirty() on an already dirty buffer, we may sleep
waiting for bdflush even if we haven't caused _any_ real disk IO (because
the buffer was already dirty anyway).

I think it makes more sense if we only call balance_dirty if we actually
caused real disk IO.

Would you accept a patch to change that situation by making
__mark_buffer_dirty return the old dirty bit value and make
mark_buffer_dirty only sleep on bdflush if we dirtied a clean buffer?


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
