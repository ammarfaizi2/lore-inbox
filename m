Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281843AbRKRCxe>; Sat, 17 Nov 2001 21:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281845AbRKRCxZ>; Sat, 17 Nov 2001 21:53:25 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:50692 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281843AbRKRCxO>; Sat, 17 Nov 2001 21:53:14 -0500
Date: Sat, 17 Nov 2001 18:48:22 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jan Hubicka <jh@suse.cz>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: i386 flags register clober in inline assembly
In-Reply-To: <20011118020957.A10674@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.33.0111171844001.899-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 18 Nov 2001, Jan Hubicka wrote:
> >
> > Well, you _can_ spill it, but you need to use "pushfl/popfl" to
> > spill/restore.
>
> I know, I can, but we are speaking about sollution how to get programs faster,
> not slow down them to scrawl.

Agreed, which is why I suggested the "spill the _comparison_, not the
actual cc0 register" approach.

That way, if you have to spill, you'll end up at worst with the same code
we already have to have, ie the code will end up something like

	lock ; decl mem
	seta %al		<- spill comparison to %al
	..
	testb %al,%al		<- re-do comparison test later
	jne ..

> Actually what can be feasible is to make asm statement set flags and follow
> it by store flag instruction that will be used in the conditional. Later
> the combine pass should be able to get it connected.

That sounds pretty ideal - have some way of telling gcc to add a "seta
%reg", while at the same time telling gcc that if it can elide the "seta"
and use a direct jump instead, do so..

> The design of asm statements should be IMO re-tought.  I think it has been
> mistake to make them so low level and allow user to write constraints directly,
> so perhaps we can think about big change for future gcc...

I don't see many alternatives. The fact is, asm's end up being used
exactly when gcc simply doesn't know what to do, so gcc doesn't know what
the constraints are either.

		Linus

