Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129029AbQJaSjd>; Tue, 31 Oct 2000 13:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130205AbQJaSjY>; Tue, 31 Oct 2000 13:39:24 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:15123 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129029AbQJaSjJ>; Tue, 31 Oct 2000 13:39:09 -0500
Date: Tue, 31 Oct 2000 10:38:46 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Vladislav Malyshkin <mal@gromco.com>
cc: Peter Samuelson <peter@cadcamlab.org>, R.E.Wolff@BitWizard.nl,
        linux-kernel@vger.kernel.org
Subject: Re: test10-pre7
In-Reply-To: <39FF0A71.FE05FAEB@gromco.com>
Message-ID: <Pine.LNX.4.10.10010311018180.7083-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ok, how about this approach? It only works for the case where we do not
have the kind of multiple stuff that drivers/net has, but hey, we don't
actually need to handle all the cases right now.

We can leave that for the future, as the configuration process is likely
to change anyway during 2.5.x, and the multiple object case may go away
entirely (ie the case of slhc and 8390 will become just a normal
configuration dependency: you'd have a "CONFIG_SLHC" entry that is
computed by the dependency graph at configuration time, rather than by the
Makefile at build time).

This is the simplest rule base that I could come up with that should work
for both SCSI and USB:

	# Translate to Rules.make lists.
	multi-used      := $(filter $(list-multi), $(obj-y) $(obj-m))
	multi-objs      := $(foreach m, $(multi-used), $($(basename $(m))-objs))
	active-objs     := $(sort $(multi-objs) $(obj-y) $(obj-m))

	O_OBJS          := $(obj-y)
	M_OBJS          := $(obj-m)
	MIX_OBJS        := $(filter $(export-objs), $(active-objs))

Does anybody see any problems with it? Basically, we're sidestepping the
sorting, because neither SCSI nor USB need it. Making the problem simpler
is always good.

Now, the above won't work for drivers/net, but I think it will work for
just about anything else. So let's just leave drivers/net alone for now.
Simplicity is good.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
