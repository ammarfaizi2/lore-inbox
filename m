Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286263AbSCFXcz>; Wed, 6 Mar 2002 18:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287134AbSCFXcr>; Wed, 6 Mar 2002 18:32:47 -0500
Received: from 64-178-80-34.customer.algx.net ([64.178.80.34]:2043 "HELO
	mail2.there.com") by vger.kernel.org with SMTP id <S286263AbSCFXck>;
	Wed, 6 Mar 2002 18:32:40 -0500
From: "Eric Ries" <eries@there.com>
To: "Gabriel Paubert" <paubert@iram.es>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: FPU precision & signal handlers (bug?)
Date: Wed, 6 Mar 2002 15:32:22 -0800
Message-ID: <KPEDLFEJBNHDLFEEOIIMOEOBCEAA.eries@there.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
In-Reply-To: <Pine.LNX.4.33.0203051918520.7951-100000@gra-lx1.iram.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Gabriel Paubert [mailto:paubert@iram.es]
> Sent: Wednesday, March 06, 2002 11:12 AM
> To: Eric Ries
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: FPU precision & signal handlers (bug?)
>
> <Offtopic>
> Believing in getting the same floating-point results down to the last bit
> on different platforms is almost always bound to fail: for transcendental
> functions, a 486 will not give the same results as a Pentium, a PIV will
> use a library and give different results if you use SSE2 mode, and so on.
> I don't even know whether an Athlon and the PII/PIII always give the same
> results or not.
>
> Now if you have other architectures, even if they all use IEEE-[78]54
> floating point format, this becomes even more interesting. For examples
> PPC, MIPS, IA64, and perhaps others will tend to use fused
> multiply-accumulate instructions unless you tell the compiler not do do so
> (BTW after a quick look at GCC doc and sources, -mno-fused-madd is not
> even an option for IA-64).
> </Offtopic>

Yes, this is a quite tricky problem. Fortunately, in our situation we are
extremely picky about just which calculations must be bit-for-bit consistent
across machines, and try to keep those operations very simple. We have been
doing this for some time on Intel hardware, and - apart from this signal
handler issue - have never had any problems.

> Right.
> [Snipped the clear explanation showing that you've done your homework]

Thanks :) I know how annoying it can be to put up with clueless posts on
mailing lists.

> Actually, fxsave does not reset the FPU state IIRC (so it could be faster
> for signal delivery to use fxsave followed by fnsave instead of the format
> conversion routine if the FPU happens to hold the state of the current
> process).

That's an interesting thought. I didn't have a decent reference on MMX
instructions while I was tracking this bug down, so I just assumed they were
basically equivalent to their 387 counterparts.


> Very bad idea, the control word is often changed in the middle of the
> code, especially the rounding mode field for float->int conversions; have
> a look at the code that GCC generates (grep for f{nst,ld}cw). The Pentium
> IV doc even states that you can efficiently toggle between 2 values of the
> control word, but not more.

I don't see how this is a problem, because (as far as I can tell) there is
no need to use the "default" control word at all. In the solution I propose,
the FPU state is still saved before a signal handler call, and restored
afterwards. It's just that during the signal handler execution, the control
word is set to the process-global value. Keep in mind that, in the case that
your signal handler has no floating-point instructions, the control word
never has to be set, because no FINIT trap will be generated. So there's
only a performance cost to those of us who use floating point in our signal
handlers.

> Therefore you certainly don't want to inherit the control word of the
> executing thread. Now adding a prctl or something similar to say "I'd like
> to get this control word(s) value as initial value(s) in signal handlers"
> might make sense, even on other architectures or for SSE/SSE2 to control
> such things as handle denormal as zeros or change the set of exceptions
> enabled by default...

I'm afraid I don't quite follow what you're suggesting here. Don't you
always want “your” control word in any function that executes as part of
your process?

Thanks for the thoughtful reply,

Eric

