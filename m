Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136073AbREHD1Z>; Mon, 7 May 2001 23:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136123AbREHD1Q>; Mon, 7 May 2001 23:27:16 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:35853 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136073AbREHD05>; Mon, 7 May 2001 23:26:57 -0400
Date: Mon, 7 May 2001 20:26:42 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "David S. Miller" <davem@redhat.com>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: page_launder() bug
In-Reply-To: <15095.26207.768685.708804@pizda.ninka.net>
Message-ID: <Pine.LNX.4.21.0105072024570.8237-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 7 May 2001, David S. Miller wrote:
> 
> Marcelo Tosatti writes:
>  > I was wrong. The patch is indeed buggy because of the __GFP_IO thing.
> 
> What about the __GFP_IO thing?
> 
> Specifically, what protects the __GFP_IO thing from happening without
> my patch?

This:

                        /* First time through? Move it to the back of the list */
                        if (!launder_loop) {
                                list_del(page_lru);
                                list_add(page_lru, &inactive_dirty_list);
                                UnlockPage(page);
                                continue;
                        }


        if (can_get_io_locks && !launder_loop && free_shortage()) {
                launder_loop = 1;
		...


Notice? If "can_get_io_locks" is not true, we will never call
"writepage()" on the page, because if "can_get_io_locks" is false,
"launder_loop" will always be false too..

And "can_get_io_locks" depends on __GFP_IO.

		Linus

