Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315200AbSEURAA>; Tue, 21 May 2002 13:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315216AbSEUQ77>; Tue, 21 May 2002 12:59:59 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:18191 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315200AbSEUQ76>; Tue, 21 May 2002 12:59:58 -0400
Date: Tue, 21 May 2002 09:59:39 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.17 IDE 65
In-Reply-To: <3CEA6881.2070701@evision-ventures.com>
Message-ID: <Pine.LNX.4.44.0205210954210.2471-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 21 May 2002, Martin Dalecki wrote:

> - Make the synchronization token active resident on the same level as the
>    spin lock. They interact with each other until the generic queue handling
>    gets sanitized to not attach hardware properties like the hard sector size
>    to the queue entities. This is a design mistake in ll_rw_blk biting everybody
>    out there.

This does not parse. It is _not_ a design mistake in ll_rw_blk - if it
bites you, you're doing something wrong.

The queue should be a per-device thing. If you have multiple devices with
different hard-sector-sizes (or other queue attributes) on the same queue,
that's _your_ problem, not the problem of ll_rw_block.

Sure, ll_rw_block _allows_ you to use the same queue for multiple devices,
but if you do that you only have yourself to blame, and you get:

 - shared values (like the hardsector-size above)
 - worse elevator performance (longer queues to traverse)
 - worse elevator schedules (mixing devices will caused mixed queue
   contents, which makes it basically impossible to do a good ordering)

I thought the IDE layer already did the "one queue per device" thing, is
there somewhere where this isn't true?

In short, I think whatever synchronization token problem there is is
completely an internal IDE problem, and no blame should be laid at anybody
else.

		Linus

