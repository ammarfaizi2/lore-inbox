Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280737AbRKSVo3>; Mon, 19 Nov 2001 16:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280738AbRKSVoW>; Mon, 19 Nov 2001 16:44:22 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:20485 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280737AbRKSVni>; Mon, 19 Nov 2001 16:43:38 -0500
Date: Mon, 19 Nov 2001 12:38:25 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: <linux-kernel@vger.kernel.org>, <ben@google.com>, <brownfld@irridia.com>,
        <phillips@bonn-fries.net>, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: 2.4.15pre6aa1 (fixes google VM problem)
In-Reply-To: <Pine.LNX.4.33.0111191036010.8281-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0111191229270.8501-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 19 Nov 2001, Linus Torvalds wrote:
>
> So why not have the much simpler patch to just say:
>
> 	min = 0;
> 	for (;;) {
> 		zone_t *z = *(zone++);
> 		..
> 		min = (min >> 2) + z->pages_low;
> 		..

Actually, as we already limit "pages_low" (for _all_ zones) through the
use of zone_balance_max[], I don't think we need to even age the minimum
pages.

And instead of doing "zone->free_pages - (1UL << order)" in
zone_free_pages(), we can do it much more efficiently just once for the
for-loop by initializing "min" to "(1UL << order)" instead of zero. So
we'd just make the loop be

	min = (1UL << order);
	for (;;) {
		zone_t *z = *(zone++);
		..
		min += z->pages_low;
		...

instead, which is even simpler (and then just compare page->free_pages
against "min" directly..

		Linus

