Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S156908AbPLUXtH>; Tue, 21 Dec 1999 18:49:07 -0500
Received: by vger.rutgers.edu id <S156737AbPLUXsr>; Tue, 21 Dec 1999 18:48:47 -0500
Received: from TSX-PRIME.MIT.EDU ([18.86.0.76]:44166 "HELO tsx-prime.MIT.EDU") by vger.rutgers.edu with SMTP id <S156749AbPLUXs3>; Tue, 21 Dec 1999 18:48:29 -0500
Date: Tue, 21 Dec 1999 18:48:18 -0500
Message-Id: <199912212348.SAA10433@tsx-prime.MIT.EDU>
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jes Sorensen <Jes.Sorensen@cern.ch>, wendling@ganymede.isdn.uiuc.edu, linux-kernel@vger.rutgers.edu
In-reply-to: Linus Torvalds's message of Sat, 18 Dec 1999 15:50:19 -0800 (PST), <Pine.LNX.4.10.9912181546480.1964-100000@penguin.transmeta.com>
Subject: Re: [patch] read[bwl] and ioremap problem
Address: 1 Amherst St., Cambridge, MA 02139
Phone: (617) 253-8091
Sender: owner-linux-kernel@vger.rutgers.edu

   Date:   Sat, 18 Dec 1999 15:50:19 -0800 (PST)
   From: Linus Torvalds <torvalds@transmeta.com>

   THAT case is certainly a rather strong argument for using something
   like "gsc_read[bwl]()" on HP-PA.

The other strong reason for doing gsc_read[bwl] on HP-PA is that some
PA-RISC boxes have both a GSC bus *and* a PCI bus, and you need to
access devices on both buses....

Something to consider is that for certain drivers, such as the serial
driver, I'm already having to do a serial_inp() which dispatches to the
proper {inb,readb,gsc_readb} already.  Yes I take a overhead/performance
hit for doing this, but it's the only clean way to support both ISA and
PCI serial boards in a single i386 box, or to support multiple buses in
the HP-PA scenario.

We've historically said that this kind of thing is horrible for
performance reasons, and the SCO and NetBSD approaches of doing
parameterized I/O has been derided for that reason.  However, it's
something that perhaps we should rethink; on modern CPU's, the extra
procedure activation/deactivation isn't *that* expensive, and it ends up
making the drivers much more portable and easier to support multiple
architectures.  The alternative is that each driver author ends up
writing their own I/O dispatch routines, such as what's currently in the
serial driver.  While this approach does have some advantages, in that
each driver author can decide whether or not he/she wishes to pay the
indirection overhead, it can mean code duplication and a delay before
certain devices get supported on non-mainline architectures.

Something to think about.

						- Ted

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
