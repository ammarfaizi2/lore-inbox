Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263127AbRFGUvd>; Thu, 7 Jun 2001 16:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263130AbRFGUvX>; Thu, 7 Jun 2001 16:51:23 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:54797 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263127AbRFGUvP>; Thu, 7 Jun 2001 16:51:15 -0400
Date: Thu, 7 Jun 2001 13:51:05 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: Background scanning change on 2.4.6-pre1
In-Reply-To: <Pine.LNX.4.21.0106071330060.6510-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0106071345190.6604-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Forgot one comment..

> > This is going to make all pages have age 0 on an idle system after some
> > time (the old code from Rik which has been replaced by this code tried to 
> > avoid that)

There's another reason why I think the patch may be ok even without any
added logic: not only does it simplify the code and remove a illogical
heuristic, but there is nothing that really says that "age 0" is
necessarily very bad.

We should strive to keep the active/inactive lists in LRU order anyway, so
the ordering does tell you something about how recent (and thus how
important) the page is. Also, it's certainly MUCH preferable to let pages
age down to zero, than to let pages retain a maximum age over a long time,
like the old code used to do.

If, after long periods of inactivity, we start needing fresh pages again,
it's probably actually an _advantage_ to give the new pages a higher
relative importance. Caches tend to lose their usefulness over time, and
if the old cached pages are really relevant, then the new spurt of usage
will obviously mark them young again.

And if, after the idle time, the behaviour is different, the old pages
have appropriately been aged down and won't stand in the way of a new
cache footprint.

Do you actually have regular usage that shows the age-down to be a bad
thing? 

		Linus

