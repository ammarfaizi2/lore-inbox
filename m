Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286482AbRL0S6i>; Thu, 27 Dec 2001 13:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286477AbRL0S63>; Thu, 27 Dec 2001 13:58:29 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:36872 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S286482AbRL0S6U>; Thu, 27 Dec 2001 13:58:20 -0500
Date: Thu, 27 Dec 2001 10:55:59 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andre Hedrick <andre@linux-ide.org>
cc: Keith Owens <kaos@ocs.com.au>, <kbuild-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: your mail
In-Reply-To: <Pine.LNX.4.10.10112271008350.24428-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.33.0112271025590.1052-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 27 Dec 2001, Andre Hedrick wrote:
>
> Lots of luck ... please pass your crack pipe arounds so the rest of us
> idiots can see your vision or lack of ...

Heh. I think I must have passed it on to you long ago, and you never gave
it back, you sneaky bastard ;)

The vision, btw, is to get the request layer in good enough shape that we
can dispense with the mid-layer approaches of SCSI/IDE, and block devices
turn into _just_ device drivers.

For example, ide-scsi is heading for that big scrap-yard in the sky: it's
not the SCSI layer that handles special ioctl requests any more, because
the upper layers are going to be flexible enough that you can just pass
the requests down the regular pipe.

(Right now you can see this in block_ioctl.c - while only a few of the
ioctl's have been converted, you get the idea. I'm actually surprised that
nobody seems to have commented on that part).

The final end result of this (I sincerely hope) is that we can get rid of
some of the couplings that we've had in the block layer. ide-scsi is just
the most obvious strange coupling - things like "sg.c" in general are
rather horrible. There's very little _SCSI_ in sg.c - it's really about
sending commands down to the block devices.

The reason I want to get rid of the couplings is that they end up being
big anchors holding down development: you can create a clean driver that
isn't dependent on the SCSI layer overheads (and people do, for things
like DAC etc), but when you do that you lose _all_ of the support
infrastructure, not just the bloat. Which is sad.

(And which is why things like ide-scsi exist - IDE didn't really want to
be a SCSI driver, but people _did_ want to be able to use some of the
generic support routines that the SCSI layer offers. You couldn't just
cherry-pick the parts you wanted).

The other part of the bio rewrite has been to get rid of another coupling:
the coupling between "struct buffer_head" (which is used for a limited
kind of memory management by a number of filesystems) and the act of
actually just doing IO.

I used to think that we could just relegate "struct buffer_head" to _be_
the IO entity, but it turns out to be much easier to just split off the IO
part, which is why you now have a separate "bio" structure for the block
IO part, and the buffer_head stuff uses that to get the work done.

Andre, I know that you're worried about the low-level drivers, but:

 - I've long since noticed that we cannot communicate, which is why Jens
   is the block level driver person. You'll have to live with it.

 - I personally don't think you _can_ make a good driver without having
   reasonable interfaces, and we didn't have them.

   For example, the network drivers have improved a lot and do not have
   _nearly_ the amount of problems block drivers have. That's obviously
   partly just because it is a simpler problem, but because it was simpler
   it was also possible to change them. The infrastructure changes in the
   networking during 2.3.x really did help drivers.

And note that the "Jens" and "communication" part is important. If you
have patches, please talk to Jens, tell him what the issues, are, and I
know I can communicate with him.

			Linus


