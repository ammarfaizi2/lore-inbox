Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310816AbSCHLyj>; Fri, 8 Mar 2002 06:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310818AbSCHLyb>; Fri, 8 Mar 2002 06:54:31 -0500
Received: from gra-lx1.iram.es ([150.214.224.41]:55563 "EHLO gra-lx1.iram.es")
	by vger.kernel.org with ESMTP id <S310816AbSCHLyT> convert rfc822-to-8bit;
	Fri, 8 Mar 2002 06:54:19 -0500
Date: Fri, 8 Mar 2002 12:54:02 +0100 (CET)
From: Gabriel Paubert <paubert@iram.es>
To: Eric Ries <eries@there.com>
cc: <linux-kernel@vger.kernel.org>
Subject: RE: FPU precision & signal handlers (bug?)
In-Reply-To: <KPEDLFEJBNHDLFEEOIIMOEOBCEAA.eries@there.com>
Message-ID: <Pine.LNX.4.33.0203081250440.22832-100000@gra-lx1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 7 Mar 2002, Eric Ries wrote:

> Yes, this is a quite tricky problem. Fortunately, in our situation we are
> extremely picky about just which calculations must be bit-for-bit consistent
> across machines, and try to keep those operations very simple. We have been
> doing this for some time on Intel hardware, and - apart from this signal
> handler issue - have never had any problems.

Intel but not IA-64 I presume ?

>
> > Right.
> > [Snipped the clear explanation showing that you've done your homework]
>
> Thanks :) I know how annoying it can be to put up with clueless posts on
> mailing lists.

Indeed :)

> > Actually, fxsave does not reset the FPU state IIRC (so it could be faster
> > for signal delivery to use fxsave followed by fnsave instead of the format
> > conversion routine if the FPU happens to hold the state of the current
> > process).
>
> That's an interesting thought. I didn't have a decent reference on MMX
> instructions while I was tracking this bug down, so I just assumed they were
> basically equivalent to their 387 counterparts.

I confirm.

> I don't see how this is a problem, because (as far as I can tell) there is
> no need to use the "default" control word at all. In the solution I propose,
> the FPU state is still saved before a signal handler call, and restored
> afterwards. It's just that during the signal handler execution, the control
> word is set to the process-global value. Keep in mind that, in the case that
> your signal handler has no floating-point instructions, the control word
> never has to be set, because no FINIT trap will be generated. So there's
> only a performance cost to those of us who use floating point in our signal
> handlers.

And where would you take the global value from ?

>
> > Therefore you certainly don't want to inherit the control word of the
> > executing thread. Now adding a prctl or something similar to say "I'd like
> > to get this control word(s) value as initial value(s) in signal handlers"
> > might make sense, even on other architectures or for SSE/SSE2 to control
> > such things as handle denormal as zeros or change the set of exceptions
> > enabled by default...
>
> I'm afraid I don't quite follow what you're suggesting here. Don't you
> always want “your” control word in any function that executes as part of
> your process?

But your control word is changed on the fly by the compiler for things as
trivial as float/double to int conversion. It is not as global and static
as you seem to believe.

	Gabriel.

