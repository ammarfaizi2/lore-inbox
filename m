Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264624AbRGIH6b>; Mon, 9 Jul 2001 03:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266997AbRGIH6W>; Mon, 9 Jul 2001 03:58:22 -0400
Received: from www.wen-online.de ([212.223.88.39]:42501 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S264624AbRGIH6E>;
	Mon, 9 Jul 2001 03:58:04 -0400
Date: Mon, 9 Jul 2001 09:56:58 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Rik van Riel <riel@conectiva.com.br>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Christoph Rohland <cr@sap.com>
Subject: Re: VM in 2.4.7-pre hurts...
In-Reply-To: <Pine.LNX.4.33L.0107081521510.4598-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.33.0107090944120.305-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Jul 2001, Rik van Riel wrote:

> On Sun, 8 Jul 2001, Linus Torvalds wrote:
> > On Sun, 8 Jul 2001, Rik van Riel wrote:
> > >
> > > ... Bingo.  You hit the infamous __wait_on_buffer / ___wait_on_page
> > > bug. I've seen this for quite a while now on our quad xeon test
> > > machine, with some kernel versions it can be reproduced in minutes,
> > > with others it won't trigger at all.
> >
> > Hmm.. That would explain why the "tar" gets stuck, but why does the whole
> > machine grind to a halt with all other processes being marked runnable?
>
> If __wait_on_buffer and ___wait_on_page get stuck, this could
> mean a page doesn't get unlocked.  When this is happening, we
> may well be running into a dozens of pages which aren't getting
> properly unlocked on IO completion.
>
> This in turn would get the rest of the system stuck in the
> pageout code path, eating CPU like crazy.

I don't know exactly what is happening, but I do know _who_ is causing
the problem I'm seeing.. it's tmpfs.  When mounted on /tmp and running
X/KDE, the tar [1] will oom my box every time because page_launder trys
and always failing to get anything scrubbed after the tar has run for a
while.  Unmount tmpfs/restart X and do the same tar, and all is well.

(it's not locked pages aparantly. I modified page_launder to move those
to the active list, and refill_inactive_scan to rotate them to the end
of the active list.  inactive_dirty list still grows ever larger, filling
with 'stuff' that page_launder can't clean until you're totally oom)

	-Mike

