Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131378AbQLXS3D>; Sun, 24 Dec 2000 13:29:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131375AbQLXS2n>; Sun, 24 Dec 2000 13:28:43 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:47624 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131371AbQLXS2m>; Sun, 24 Dec 2000 13:28:42 -0500
Date: Sun, 24 Dec 2000 09:57:56 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Marco d'Itri" <md@Linux.IT>
cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: innd mmap bug in 2.4.0-test12
In-Reply-To: <20001224170052.A223@wonderland.linux.it>
Message-ID: <Pine.LNX.4.10.10012240941540.3972-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 24 Dec 2000, Marco d'Itri wrote:
> On Dec 24, Alexander Viro <viro@math.psu.edu> wrote:
> 
>  >> I put "cp active active.ok" in the rc file before shutting down the
>  >> daemon and at the next boot the files are different, every time.
>  >
>  >Could you send me both files? BTW, which filesystem it is?
> I use ext2. The files are not corrupted, they just are not updated.
> Another data point: at least in some cases, if I stop and start inn
> without rebooting the files are the same.

Ok, looks like we just drop the page cache page without writing it out in
some cases. Possibly/probably because we have dropped the dirty bit on the
floor.

Look slike this is a completely different case from the previous
corruptions, it looks more like a VM issue than a FS thing..

Hmm.. munmap() (and exit()) go through "zap_page_range()", which go
through "free_pte()", which definitely copies the dirty bit to the page
structure.

Hmm.. I wonder if such a dirty page might have been moved to the
"inactive_clean" list some way? It shouldn't really be there, as the page
had users, but if it gets on that list we'd not have tested the dirty bit.

Marco, would you mind changing the test in reclaim_page(), somewheer
around line mm/vmscan.c:487 that says:

	/* The page is dirty, or locked, move to inactive_dirty list. */
	if (page->buffers || TryLockPage(page)) {
		...

and change the test to

	if (page->buffers || PageDirty(page) || TryLockPage(page)) {

instead? Ie ad the test for "PageDirty(page)" (and order _is_ important:
the TryLockPage() thing must come last, because it has side effects).

(You might add a "printk()" too that triggers when the new condition
happens, just to see if it does indeed happen).

If the page is on the inactive_clean() list, we'll have to find where it
is put there, because it really shouldn't have been there. 

Uhhuh. Actually, reading "page_launder()", the buffer clearign case looks
suspiciously like i doesn't check for page accessed or dirty bits. That's
probably it. Maybe there are other cases. Anyway, I'd love to hear if the
above one-liner fixes the corruption for you..

	Thanks,
		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
