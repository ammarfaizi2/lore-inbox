Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261505AbRETJ4Q>; Sun, 20 May 2001 05:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261508AbRETJ4G>; Sun, 20 May 2001 05:56:06 -0400
Received: from www.wen-online.de ([212.223.88.39]:57612 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S261505AbRETJz4>;
	Sun, 20 May 2001 05:55:56 -0400
Date: Sun, 20 May 2001 11:47:33 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Rik van Riel <riel@conectiva.com.br>
cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [RFC][PATCH] Re: Linux 2.4.4-ac10
In-Reply-To: <Pine.LNX.4.21.0105200546241.5531-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.33.0105201104090.610-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 May 2001, Rik van Riel wrote:

> On Sun, 20 May 2001, Mike Galbraith wrote:
>
> > You're right.  It should never dump too much data at once.  OTOH, if
> > those cleaned pages are really old (front of reclaim list), there's no
> > value in keeping them either.  Maybe there should be a slow bleed for
> > mostly idle or lightly loaded conditions.
>
> If you don't think it's worthwhile keeping the oldest pages
> in memory around, please hand me your excess DIMMS ;)

You're welcome to the data in any of them :)  The hardware I keep.

> Remember that inactive_clean pages are always immediately
> reclaimable by __alloc_pages(), if you measured a performance
> difference by freeing pages in a different way I'm pretty sure
> it's a side effect of something else.  What that something
> else is I'm curious to find out, but I'm pretty convinced that
> throwing away data early isn't the way to go.

OK.  I'm getting a little distracted by thinking about the locking
and some latency comments I've heard various gurus make.  I should
probably stick to thinking about/measuring throughput.. much easier.

but ;-)

Looking at the locking and trying to think SMP (grunt) though, I
don't like the thought of taking two locks for each page until
kreclaimd gets a chance to run.  One of those locks is the
pagecache_lock, and that makes me think it'd be better to just
reclaim a block if I have to reclaim at all.  At that point, the
chances of needing to lock the pagecache soon again are about
100%.  The data in that block is toast anyway.  A big hairy SMP
box has to feel reclaim_page(). (they probably feel the zone lock
too.. probably would like to allocate blocks)

	-Mike

