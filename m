Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263955AbTH1Mk3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 08:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263962AbTH1Mk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 08:40:28 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:1927 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S263955AbTH1MkW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 08:40:22 -0400
Date: Thu, 28 Aug 2003 13:39:58 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Timo Sirainen <tss@iki.fi>, Martin Konold <martin.konold@erfrakon.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Lockless file reading
Message-ID: <20030828123958.GC6800@mail.jlokier.co.uk>
References: <1061987837.1455.107.camel@hurina> <200308271442.48672.martin.konold@erfrakon.de> <1061988729.1457.115.camel@hurina> <Pine.LNX.4.53.0308270925550.278@chaos> <20030828000321.GC3759@mail.jlokier.co.uk> <Pine.LNX.4.53.0308280746400.2211@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0308280746400.2211@chaos>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> > > Even in machines that do load/store operations where individual
> > > components of those stores happen in groups, access to/from
> > > a buffer of such data is controlled (by hardware) so a write
> > > will complete before a read occurs.
> >
> > I don't understand what you mean by this.
> >
> > Do you mean that the writes are forced to appear on a different CPU in
> > the same order that they were written?  That isn't true on x86, for
> > two reasons: 1. writes aren't always in processor order (see
> > CONFIG_X86_OOSTORE and CONFIG_X86_PPRO_FENCE); 2. reads on the other
> > processor are out of order anyway.
> 
> I never said, nor even implied any such thing.

That's why I said I don't understand what you meant.  What does your
first paragraph above mean?

> [...] The implimentation detail of trimming the start or finish of a
> copy procedure trims the ends. That's, in fact, why it is
> impossible, yes, __impossible__ for the byte-sequence 0xABC to have
> both 0xA and 0xC copied without the 0xB being copied also.  There
> are no combinations of byte/word/long writes that will allow this to
> happen.

Correct.

> Whether or not there's an interrupt between each byte means nothing
> also. In the byte copy described, an interruopt at any time will
> simply leave:
> 
> XXX
> XXC
> XBC
> ABC
> 
> Clearly, if both A and C were copied, B was copied also.
> You can screw around with endian and use words and longwords
> as well. It just isn't possible for, in any 3-byte sequence
> for the middle byte to be missing.

What you say is correct about the intermediate states from
the writer's point of view, however a parallel reader _can_ observe
the middle byte missing.

The writing proceeds: A, B then C.  In that order.  No problem.

The writing CPU or task will always see these memory states:

   XXX
   AXX
   ABX
   ABC

Two problems for the reader, though: multiprocessor out of order
reads, and uniprocessor preemption.

Out of order means the reader can read the second byte _before_ the
first byte.  Which means the reader sees this:

  ...
  .X.
  AX.
  AXB

Preemption means this sequence of events can occur:

  Writer's                              Reader's
  destination buffer                    destination buffer
  --------------------------------------------------------

  XXX
	writer writes A
  AXX
	context switch to reader
	reader reads 2 bytes
					-> AX.
	context switch to writer
	writer writes B, C
  ABX
  ABC
	context switch to reader
	reader reads final byte
					-> AXB

The preemption case is a classic race between a writer and reader
moving in the same direction, alternating who is ahead.

Parallel memory access is not as simple as you make it out to be.  If
you don't understand this, you will have a hard time understanding locks,
set_task_state vs. __set_task_state, the wmb/rmb/smp_rmb() macros, etc.

-- Jamie
