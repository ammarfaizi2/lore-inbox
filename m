Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266995AbRGIJUP>; Mon, 9 Jul 2001 05:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266996AbRGIJUG>; Mon, 9 Jul 2001 05:20:06 -0400
Received: from www.wen-online.de ([212.223.88.39]:59916 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S266995AbRGIJTy>;
	Mon, 9 Jul 2001 05:19:54 -0400
Date: Mon, 9 Jul 2001 11:18:52 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Christoph Rohland <cr@sap.com>
cc: Rik van Riel <riel@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: VM in 2.4.7-pre hurts...
In-Reply-To: <m3wv5iik5m.fsf@linux.local>
Message-ID: <Pine.LNX.4.33.0107091107490.311-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 Jul 2001, Christoph Rohland wrote:

> Hi Mike,
>
> On Mon, 9 Jul 2001, Mike Galbraith wrote:
> > I don't know exactly what is happening, but I do know _who_ is
> > causing the problem I'm seeing.. it's tmpfs.  When mounted on /tmp
> > and running X/KDE, the tar [1] will oom my box every time because
> > page_launder trys and always failing to get anything scrubbed after
> > the tar has run for a while.  Unmount tmpfs/restart X and do the
> > same tar, and all is well.
> >
> > (it's not locked pages aparantly. I modified page_launder to move
> > those to the active list, and refill_inactive_scan to rotate them to
> > the end of the active list.  inactive_dirty list still grows ever
> > larger, filling with 'stuff' that page_launder can't clean until
> > you're totally oom)
>
> Do you have set the size parameter for tmpfs? Else it will grow until
> oom.

No, but that doesn't appear to be the problem.  The patchlet below
fixes^Wmakes it work ok without ooming, whether I have swap enabled
or not.

--- mm/shmem.c.org	Mon Jul  9 09:03:27 2001
+++ mm/shmem.c	Mon Jul  9 09:03:46 2001
@@ -264,8 +264,8 @@
 	info->swapped++;

 	spin_unlock(&info->lock);
-out:
 	set_page_dirty(page);
+out:
 	UnlockPage(page);
 	return error;
 }

So, did I fix it or just bust it in a convenient manner ;-)

	-Mike

Rik.  Kswapd should check oom even if there is no inactive shortage,
else you get livelock when you can't scrub instead of kaboom.  Maybe
a count of loops before killing things, but IMHO a check is needed.

