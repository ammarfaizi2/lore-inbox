Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313265AbSDOVKe>; Mon, 15 Apr 2002 17:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313267AbSDOVKd>; Mon, 15 Apr 2002 17:10:33 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:21255 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313265AbSDOVKc>; Mon, 15 Apr 2002 17:10:32 -0400
Date: Mon, 15 Apr 2002 14:08:54 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: <linux-kernel@vger.kernel.org>, <wli@holomorphy.com>
Subject: Re: [PATCH] for_each_zone / for_each_pgdat
In-Reply-To: <Pine.LNX.4.44L.0204151755491.16531-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0204151400200.13034-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 15 Apr 2002, Rik van Riel wrote:
> 
> However, I really don't like the fact of teaching now-simple
> VM code about pgdats again ;)

Well, you don't actually have to teach it about pgdats, but try out how 
much simpler the actual implementation is if you were to just add a 
"endzone" macro, allowing the macros to do nesting.

Once you do that, you can basically expand the thing any which way, 
something like

#define for_each_zone(zone) \
	do { pg_data_t * __pgdat; \
		for (__pgdat = pgdat_list; __pgdat; __pgdat = __pgdat->next) { \
			int __i; \
			for (i = 0; i < MAX_ZONES; i++) { \
				zone = pgdat->node_zones; \
				if (!zone->size) \
					break; \
				do { \

#define end_zone \
				while (0); \
			} \
		} \
	} while (0)

Which requires the user to use something like

	for_each_zone(zone) {
		...
	} end_zone;

but doesn't need changing the double loop into a artificial single loop.

		Linus

