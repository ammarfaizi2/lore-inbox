Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129849AbQLEW30>; Tue, 5 Dec 2000 17:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130517AbQLEW3Q>; Tue, 5 Dec 2000 17:29:16 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:5395 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129849AbQLEW3H>; Tue, 5 Dec 2000 17:29:07 -0500
Date: Tue, 5 Dec 2000 13:58:03 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Daniel Phillips <phillips@innominate.de>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test12-pre5
In-Reply-To: <00120522275601.09076@gimli>
Message-ID: <Pine.LNX.4.10.10012051349580.7163-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 5 Dec 2000, Daniel Phillips wrote:
> 
> OK, I see - this isn't easy at all.  You start the io if necessary, and
> some time later it completes.

Right. You don't know when. Once completed, it will unlock the page and
wake up waiters. It will also set PG_Uptodate if the read was successful
(and obviously it might not have been).

If you only care about the contents of the page, you can just test the
Uptodate flag - if the page is up-to-date you may not care whether IO is
outstanding on the page, or whether somebody is modifying page state
(removing page buffers etc). So it's entirely legal to look up a page in
the page cache and only look at uptodate.

(Of course, if it _isn't_ uptodate, you will still have to get the page
lock and re-test and possibly start the IO if it still isn't up-to-date
after you got the page lock. This is what all the generic_file_read()
stuff does for you).

>				  The locking state is therefore
> indeterminate after ->readpage or ->writepage; all we know is that
> after some finite amount of time the lock bit will go down.

Yes. It might have completed immediately (ramdisks or what not), or be
fast enough that by the time you get back it's already done. But the
likely case is that the page will be locked, and you'd be better off going
away and doing something else in the meantime (this is certainly important
for the VM layer - it needs to continue doing swap-outs so that it
doesn't just dribble the pages out one by one).

The main reason for the page locking changes for the writepage() case were
really:

 - the swapping code serializes accesses by using the page lock, and
   doesn't have any other underlying serializing primitives. So we needed
   to let the brw_page() code leave the lock set until the write has
   physically completed.

 - the VM code really wants to have a notion of "I have this many pages in
   flight", so that it can sanely make a decision on when to start waiting
   on page writeout completion, instead of just writing as much as it can.
   The block device layer does some of this, of course, but the VM layer
   can do more by just using the "nr_async_pages" thing. However, before
   the unlock changes, this could not work for shared file mappings.

I hope that explains the change,

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
