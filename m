Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154236-23312>; Sun, 25 Oct 1998 15:29:38 -0500
Received: from dm.cobaltmicro.com ([209.133.34.35]:3104 "EHLO dm.cobaltmicro.com" ident: "davem") by vger.rutgers.edu with ESMTP id <155448-23312>; Sun, 25 Oct 1998 15:12:13 -0500
Date: Sun, 25 Oct 1998 19:07:39 -0800
Message-Id: <199810260307.TAA13367@dm.cobaltmicro.com>
From: "David S. Miller" <davem@dm.cobaltmicro.com>
To: torvalds@transmeta.com
CC: ak@muc.de, khim@sch57.msk.ru, linux-kernel@vger.rutgers.edu, crux@Pool.Informatik.RWTH-Aachen.DE
In-reply-to: <Pine.LNX.3.96.981025144701.3859K-100000@penguin.transmeta.com> (message from Linus Torvalds on Sun, 25 Oct 1998 14:55:09 -0800 (PST))
Subject: Re: 2.2.0 and egcs 1.1 was Re: Sorry, wrong gcc-version
References: <Pine.LNX.3.96.981025144701.3859K-100000@penguin.transmeta.com>
Sender: owner-linux-kernel@vger.rutgers.edu

   Date: 	Sun, 25 Oct 1998 14:55:09 -0800 (PST)
   From: Linus Torvalds <torvalds@transmeta.com>

   For example, everybody in the egcs camp just decided that clobbers
   and inputs must not overlap. Nobody told me why, and why they can't
   just be automatically converted to early-clobbers inside gcc.

You're telling the compiler two different things which conflict.

The gcc documentation indicates how the design of the asm construct
was really geared for single assembler instructions, and the
constraint/clobber specification works in a much more sensible way if
you only use it in this manner.  Of course, we all have used it in a
much more broad sense to use multiple assembler instructions and a lot
of people screw up the "input operand only" case.

The reload pass of the compiler groups operands for a single piece of
RTL (the internal representation of "instructions" in gcc) into
several groups when it sees register pressure and must create relods.
These are:

1) Input reloads

   Such operands must have the specified value on input to the
   instruction.  They will still have this specified value upon
   completion of the instructions execution.

2) Output reloads

   Such operands will be killed by this instruction and set is to some
   value which will be set upon completion of the instruction.

3) Address reloads

   These deal with address formation for memory operands found in the
   RTL for a particular instruction and sometimes require secondary
   reloads to be created (to deal with cases such as when the address
   must be in a single register because the usage does not allow an
   offsettable [reg + offset] type addressing mode, ie. the 'o'
   constraint)

When the compiler scans an instruction for an instruction it says:

1) What must be in registers upon entry to this instruction.

   These are the input reloads, once assigned a register life analysis
   marks these registers as containin the specified value upon input
   and also upon exit from the instruction.

2) Which registers get killed as the "last thing" this instruction
   does.  That is, with a simple example:

   add		DEST, SRC

   DEST would be an output reload, and so far gcc can legitimately
   load the SRC value into DEST and just use DEST twice in the
   instruction unless...

3) Which input and output reloads conflict.

   When you say that an input and output don't need to be in the same
   register value, it will use the same register for input and output
   reloads as it sees profitable.  Unless you specify early clobber
   with '&' in the constraints the compiler can legitimately use the
   same register for arbitrary input and output reloads.

4) Which registers die in some unspecified way during this
   instruction.  This is an explicit clobber.

So in the case being mentioned you are telling the compiler that a
particular (in fact a specific) register is an "input only" operand
and it dies in some unspecified way during this instruction.  So I
just scanned the gcc documentation and I see:

	Some instructions clobber specific hard registers.  To describe
	this, write a third colon after the input operands, followed by the
	names of the clobbered hard registers (given as strings).

If I'm not trying to be pedantic about all this, I would interpret
this to mean "if you cannot describe what happens to a hard register
using constraints, then use clobbers".

It seems to imply that "constraint mentioned" registers and clobbers
are mutually exclusive.

So in my view either such input constraints are spurious and
inaccurate, or one is using clobbers to describe what output
constraints are there for.

Later,
David S. Miller
davem@dm.cobaltmicro.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
