Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262657AbREOGss>; Tue, 15 May 2001 02:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262659AbREOGsi>; Tue, 15 May 2001 02:48:38 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:26387 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262657AbREOGsX>; Tue, 15 May 2001 02:48:23 -0400
Date: Mon, 14 May 2001 23:48:07 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Daniel Phillips <phillips@bonn-fries.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] filemap.c fixes
In-Reply-To: <Pine.LNX.4.21.0105141111100.4671-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.21.0105142342040.23955-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 14 May 2001, Rik van Riel wrote:

> On Mon, 14 May 2001, Daniel Phillips wrote:
> > 
> > How about:
> > 
> > > +	if (PageActive(page))
> > > +		SetPageReferenced(page);
> > > +	else
> > > +		activate_page(page);
> 
> Fine with me ...

Now, please explain to me why it's not just a simple

	SetPageReferenced(page);

and then just moving it lazily from one queue to another..

Advantage: fast and robust. Very simple. 

Disadvantage: lazy queue movement. But we're already doing that for other
things (ie page_launder() already has the logic to move pages with counts
and references to the active list). So this is nothing new.

The advantage of doing the work lazily is not just simplicity: it's
actually much _faster_ to delay the work until later, because in many
cases the work never needs to be done at all (ie we might not be low on
memory, or the page ends up being moved for other reasons anyway).

Comments?

		Linus

