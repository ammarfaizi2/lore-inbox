Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132789AbRDUSDl>; Sat, 21 Apr 2001 14:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132796AbRDUSDb>; Sat, 21 Apr 2001 14:03:31 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:26383 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132789AbRDUSDO>; Sat, 21 Apr 2001 14:03:14 -0400
Date: Sat, 21 Apr 2001 11:03:12 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: linux-kernel@vger.kernel.org
Subject: Re: try_to_swap_out() deactivating pages w. count > 2
In-Reply-To: <Pine.LNX.4.21.0104211450560.1685-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.21.0104211058130.17963-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 21 Apr 2001, Rik van Riel wrote:
> > 
> > We should _absolutely_ do the swap space reclaiming without looking at
> > the page count.
> 
> page->age != page->count

It's all the same thing.

The page age and count are used to decice when the page actually gets
thrown _out_ of memory. That's a decision that is based on the _physical_
page attributes.

But try_to_swap_out() is based on the attribute on this particular virtual
mapping of the page. If this particular virtual mapping does not have the
"accessed" bit set, then try_to_swap_out() should get rid of that virtual
mapping. It should absolutely not use the global page characteristics
(either global usage count or global age) in making that decision. Because
those do not matter - they have absoilutely no meaning for this virtual
mapping of the page.

Put another way: if process A is a heavy user of a page, and process B
just touched it once and will never touch it again, what do you think
should happen?

Answer: the page should be dropped from process B. It's a cheap thing to
do (we can get it back if necessary without any IO), and it means that if
we end up having toi actually swap out the page eventually, we will not be
confused by "noise" in the page count from a mappign that hasn't been
active for a long time.

		Linus

