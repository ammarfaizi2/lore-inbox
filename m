Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131178AbQKADHm>; Tue, 31 Oct 2000 22:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131161AbQKADHc>; Tue, 31 Oct 2000 22:07:32 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:16141 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S131141AbQKADHR>; Tue, 31 Oct 2000 22:07:17 -0500
Date: Tue, 31 Oct 2000 21:06:33 -0600
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>, Keith Owens <kaos@ocs.com.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test10-pre7
Message-ID: <20001031210633.D1041@wire.cadcamlab.org>
In-Reply-To: <Pine.LNX.4.10.10010310930110.6866-100000@penguin.transmeta.com> <200010311928.e9VJS2d08641@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200010311928.e9VJS2d08641@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Tue, Oct 31, 2000 at 07:28:01PM +0000
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Russell King]
> Since someone kindly enlightened me that LINK_FIRST was unsorted, I'm
> finding it very hard to grasp what the difference is between an
> unsorted LINK_FIRST and unsorted LINK_LAST list, and an unsorted
> obj-y list.  From what I understand, obj-y = $(LINK_FIRST)
> $(LINK_LAST) ?

Not quite.  If that's how you understand it, I see why you think it's a
bad idea.  Here's what is *really* happening:

  obj-y = {subset of LINK_FIRST that is in obj-y} \
          {subset of obj-y that is not in LINK_FIRST or LINK_LAST} \
          {subset of LINK_LAST that is in obj-y}

GNU make has extensions that make this easy to implement -- no more
verbose than the pseudocode, in fact.

The biggest difference between LINK_FIRST and obj-y is that LINK_FIRST
is meant to be a static list, not dependent on CONFIG_*, and specifies
*only* those objects which must be linked before (or after, for
LINK_LAST) other objects.  In the common case, most object files do
*not* appear in LINK_FIRST or LINK_LAST, but just in O_OBJS.

In the pathological case of strict requirements for the whole
directory, LINK_FIRST would contain all of obj-y.  Keith and I think
this is a rare case -- a more common case is the opposite:
LINK_FIRST/LAST are empty because there are *no* ordering requirements.


Again, anything that appears in O_OBJS but not in LINK_FIRST is linked
in arbitrary order.  Anything that appears in LINK_FIRST but not in
O_OBJS is ignored.  That is why it can be a static list.

Since LINK_FIRST is a (usually short) static list, it is easy for the
author to guarantee that it has no duplicate files in it.  By contrast,
O_OBJS (or obj-y) frequently has duplicates, because of things like

  obj-$(CONFIG_FOO) := foo.o xxx.o
  obj-$(CONFIG_BAR) := bar.o xxx.o

where xxx.o is something like 8390 support for network cards.

Removing duplicates is a side effect of the GNU make 'sort' function,
which is THE ONLY REASON we want to sort $(O_OBJS).  The reordering is
the "other" side effect, the less desirable one.  GNU make does not
provide a 'uniq-without-sort' function, and while one is trivial to
write in e.g. shell, some of us consider a shell hack to be, well, more
hackish than LINK_FIRST.

** BTW, the only reason I'm still posting to this thread, which seems
   pretty moot because "Linus Has Spoken", is that I believe there is
   still a lot of misunderstanding about what LINK_FIRST actually does.
   When I'm satisfied that the opponents truly *understand* LINK_FIRST
   and still oppose it, I'll shut up.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
