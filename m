Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129714AbQJ3XQn>; Mon, 30 Oct 2000 18:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129804AbQJ3XQd>; Mon, 30 Oct 2000 18:16:33 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:34567 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129714AbQJ3XQU>; Mon, 30 Oct 2000 18:16:20 -0500
Date: Mon, 30 Oct 2000 15:15:57 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Keith Owens <kaos@ocs.com.au>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test10-pre7 
In-Reply-To: <11462.972947019@ocs3.ocs-net>
Message-ID: <Pine.LNX.4.10.10010301508360.1085-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 31 Oct 2000, Keith Owens wrote:
> >
> >What would be wrong with just splitting it the other way, ie make OX_OBJS
> >be the expanded (but not ordered) list?
> >
> >That should take care of it, no?
> 
> usbcore.o is both multi part *and* order critical.  This is a
> combination that the existing "link order relies on declaration order"
> kludge cannot cope with.  It requires an explicit declaration of link
> order, which is exactly what LINK_FIRST implements.

I don't see your point.

I'm saying that EVERYTHING should be order-critical.

It is NEVER acceptable to change the order of object files.

If the Makefile said that the ordering should be

	obj-y = usb.o usbcore.o third.o last.o

then the fact that usbcore.o is a multi-part object file SHOULD NOT
MATTER.

We should just link it in the order specified:

	ld -r usbdrv.o $(obj-y)

No re-ordering. No expansion of multi-objs. No games. Do what the Makefile
author expected.

In short, we should _remove_ all traces of stuff like

	O_OBJS = $(filter-out $(export-objs), $(obj-y))

It's wrong.

We should just have

	O_OBJS = $(obj-y)

which is always right.

Then we change the meaning of OX_OBJS, and instead of saying

	ALL_O = $(OX_OBJS) $(O_OBJS)

we just say

	ALL_O = $(O_OBJS)

and the meaning of $OX_OBJS is the _subset_ of object file that have
SYMTAB objects.

This should all work pretty much as-is, with som every simple
modifications to existing old-style Makefiles, and with some even simpler
modifications to the new-style ones. In fact, it should remove pretty much
all the ugly games that new-style files do.

And it should make all this FIRST/LAST object file mockery a total
non-issue, because the whole concept turns out to be completely
unnecessary.

Is there anything that makes this more complex than what I've outlined
above? 

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
