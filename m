Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273650AbRIQPnc>; Mon, 17 Sep 2001 11:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273646AbRIQPnW>; Mon, 17 Sep 2001 11:43:22 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:22539 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S273645AbRIQPnR>; Mon, 17 Sep 2001 11:43:17 -0400
Date: Mon, 17 Sep 2001 08:42:35 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Daniel Phillips <phillips@bonn-fries.net>, <linux-kernel@vger.kernel.org>
Subject: Re: broken VM in 2.4.10-pre9
In-Reply-To: <Pine.LNX.4.33L.0109170923190.2990-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.33.0109170840520.8836-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 17 Sep 2001, Rik van Riel wrote:
>
> >  - I don't like the lack of aging in 'reclaim_page()'. It will walk the
> >    whole LRU list if required, which kind of defeats the purpose of having
> >    reference bits and LRU on that list. The code _claims_ that it almost
> >    always succeeds with the first page, but I don't see why it would. I
> >    think that comment assumed that the inactive_clean list cannot have any
> >    referenced pages, but that's never been true.
>
> This depends on whether we do reactivation in __find_page_nolock()
> or if we leave the page alone and wait for kswapd to do that for
> us.

We should not do _anything_ in __find_page_nolock().

It's positively wrong to touch any aging information there - if you do,
you are guaranteed to not get read-ahead right (ie a page that gets
read-ahead first will behave differently than a page that got read
directly, which just cannot be right).

The aging has to be done at a higher level (ie when you actually _use_
it, not when you search the hash queues).

		Linus

