Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129800AbQLXUkP>; Sun, 24 Dec 2000 15:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129965AbQLXUkG>; Sun, 24 Dec 2000 15:40:06 -0500
Received: from hermes.mixx.net ([212.84.196.2]:6152 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129800AbQLXUjx>;
	Sun, 24 Dec 2000 15:39:53 -0500
Message-ID: <3A46578C.5FF7AD4F@innominate.de>
Date: Sun, 24 Dec 2000 21:07:40 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: innd mmap bug in 2.4.0-test12
In-Reply-To: <20001224170052.A223@wonderland.linux.it> <Pine.LNX.4.10.10012240941540.3972-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Hmm.. I wonder if such a dirty page might have been moved to the
> "inactive_clean" list some way? It shouldn't really be there, as the page
> had users, but if it gets on that list we'd not have tested the dirty bit.
> 
> Marco, would you mind changing the test in reclaim_page(), somewheer
> around line mm/vmscan.c:487 that says:
> 
>         /* The page is dirty, or locked, move to inactive_dirty list. */
>         if (page->buffers || TryLockPage(page)) {
>                 ...
> 
> and change the test to
> 
>         if (page->buffers || PageDirty(page) || TryLockPage(page)) {
> 
> instead? Ie ad the test for "PageDirty(page)"

Good point.  Up until recently the page dirty bit wasn't actually being
set anywhere and page->buffers was acting as kind of a surrogate dirty
bit - page_launder would call try_to_free_buffers which would find the
dirty buffers and fail out, but start io first

It looks like PG_dirty is now being used only for swap_cache pages, and
not for buffer cache and page cache pages, is that correct?

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
