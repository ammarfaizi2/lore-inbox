Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129847AbQLYJut>; Mon, 25 Dec 2000 04:50:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129927AbQLYJuk>; Mon, 25 Dec 2000 04:50:40 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:19973 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129847AbQLYJua>; Mon, 25 Dec 2000 04:50:30 -0500
Date: Mon, 25 Dec 2000 01:19:50 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Marco d'Itri" <md@Linux.IT>
cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: innd mmap bug in 2.4.0-test12
In-Reply-To: <20001225005303.A205@wonderland.linux.it>
Message-ID: <Pine.LNX.4.10.10012250049400.5242-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 25 Dec 2000, Marco d'Itri wrote:

> On Dec 24, Linus Torvalds <torvalds@transmeta.com> wrote:
> 
>  >	/* The page is dirty, or locked, move to inactive_dirty list. */
>  >	if (page->buffers || TryLockPage(page)) {
>  >		...
>  >
>  >and change the test to
>  >
>  >	if (page->buffers || PageDirty(page) || TryLockPage(page)) {
> Done, no change.
> Got some articles, restarted the server, all is good.
> Got other articles, rebooted and the files now differ.

Willing to test some more?

Add a printk() to __remove_inode_page() that complains whenever it removes
a dirty page. 

Oh, in order to not see this with swap pages (which _can_ be removed when
they are dirty, if all users of them are gone), add a PageClearDirty() to
"remove_from_swap_cache()" so that we don't get false positives..

Do you get any messages? I don't think you will, but it should be tested.
You might mark it a BUG(), so tht we'll get a stack-trace if it happens.

Assuming we don't lose any PG_dirty bits, we might of course just lose it
from the page tables themselves before it ever even gets to "struct page".
I'm just surprised that it seems to be so repeatable for you - it sounds
like we _never_ actually write out the dirty pages to disk. It's not that
we can lose the dirty bit occasionally, we seem to lose it every time in
your setup.

I wonder if it's something specific innd does. Like "msync()" just being
broken or similar. But the code looks sane.

Hmm.. Can you send me an "strace" of innd when this happens?

> And I have another problem: I'm experiencing random hangs using X[1] with
> 2.4.0-test12.

That's probably the infinite loop in the tty task queue handling, should
be fixed in test13-pre3 or so.

		Linus


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
