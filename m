Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130632AbQLKVCP>; Mon, 11 Dec 2000 16:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130755AbQLKVCG>; Mon, 11 Dec 2000 16:02:06 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:55045 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130632AbQLKVB5>; Mon, 11 Dec 2000 16:01:57 -0500
Date: Mon, 11 Dec 2000 12:30:59 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Matthew Galgoci <mgalgoci@redhat.com>
cc: Andrew Morton <andrewm@uow.edu.au>, linux-kernel@vger.kernel.org,
        Martin Mares <mj@suse.cz>
Subject: Re: cardbus pirq conflict
In-Reply-To: <20001211150323.C16986@redhat.com>
Message-ID: <Pine.LNX.4.10.10012111225010.1458-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Dec 2000, Matthew Galgoci wrote:
> 
> I do however still recieve a nasty message about a pirq table
> conflict, but it does not seem to affect the operation of the 
> card.

It doesn't.

> The pirq conflict message seems a little harsh though, and perhaps 
> unnecessary.

It is a bit harsh, and while not unnecessary I'll have to do something
about it.

What is going on is that a lot of laptops appear to have a pirq routing
table for PCI bus #1 (and sometimes #2), even though that bus does not
actually exist in hardware at all. My suspicion is that the BIOS writers
just re-use the same pirq table over and over again, and that it's just a
remnant of the fact that some laptops have either a docking station bus or
an AGP bus as bus #1.

When Linux assigns bus #1 to the CardBus bridge, those bogus entries in
the pirq routing table will show up as conflicts. They'll be ignored, but
it's still a nasty message.

The problem is that the message probably _should_ be printed for the real
case of a misconfigured BIOS, if for no other reason than to try to track
down what the h*ll is going on.

My tentative fix for this would be to make Linux never assign bus #1 or #2
to a cardbus bridge, and start cardbus bridges at bus #8 or something like
that.  That way we'd still catch any strangeness in the pirq table, but we
wouldn't get the message for this case which seems to be very common.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
