Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129689AbQJaRar>; Tue, 31 Oct 2000 12:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129596AbQJaRaa>; Tue, 31 Oct 2000 12:30:30 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:31248 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129130AbQJaRaM>; Tue, 31 Oct 2000 12:30:12 -0500
Date: Tue, 31 Oct 2000 09:29:48 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Peter Samuelson <peter@cadcamlab.org>
cc: Keith Owens <kaos@ocs.com.au>, Christoph Hellwig <hch@ns.caldera.de>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: test10-pre7
In-Reply-To: <20001031075506.B1041@wire.cadcamlab.org>
Message-ID: <Pine.LNX.4.10.10010310912050.6866-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 31 Oct 2000, Peter Samuelson wrote:
> 
> The thing that Keith's patch does is flush these things out into the
> open.  By using LINK_FIRST/LINK_LAST, we declare that "these are the
> known issues" -- and then the rest of the objects are reordered, and if
> something breaks, we track it down and add it to LINK_FIRST.

But it doesn't even WORK.

You need to have 

	LINK_FIRST1
	LINK_FIRST2
	LINK_FIRST3
	...

etc to get the proper ordering.

USB is the _easy_ case. There happen sto be only one file that cares about
ordering.

In many other cases, like SCSI, we need almost _total_ ordering. For such
a case, theer is no "first" or "last" - there is a well-specific ORDER.

Do you see the problem now? LINK_FIRST/LINK_LAST is a complete and utter
hack, and it WON'T EVER WORK. The only way it would work is to make
LINK_FIRST maintain the order, but once you do that LINK_FIRST is
completely superfluous, as it ends up being exactly the same as $(obj-y).

See the fallacy? LINK_FIRST doesn't solve anything, because in the end it
has to do everything O_OBJS will have to do anyway: maintain the full
order.

So trust me, LINK_FIRST/LINK_LAST is not going to happen. 

> A few months ago I actually tried to write a make function (yes, GNU
> make has these!) to remove duplicates while not sorting, but GNU make
> doesn't seem to support the necessary iteration/(tail-)recursion
> features.  (Surprising, considering GNU's overall LISP-ish worldview.)

Ehh.. 

There are multiple solutions to this. One is to simply not do that then.
We've done that before, it's not all that painful at all. The classic
example is the current drivers/net/ Makefile, which is badly written
anyway (a mixture of old-style and new-style stuff), and has that 8390.o
and slhc.o multiple thing. It's not that hard to re-write by just adding a
special

	obj-8390-$(CONFIG_xxx) = y

for every config that wants 8390.o (and same thing for slhc) and at the
very end do a final

	obj-$(obj-8390-y) += 8390.o

Not as simple as what we have now, but not a disaster like the current
lack of ordering is.

And if you really want to remove duplicates, at worst we can even use an
external program for it - which would solve all these things once and for
all. The difference between

	$(filter .. black magic lies here ..)

and 

	$(shell .. black magic lies here ..)

is not that big.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
