Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268842AbTB0AXH>; Wed, 26 Feb 2003 19:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268860AbTB0AXH>; Wed, 26 Feb 2003 19:23:07 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:33222 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S268842AbTB0AXG> convert rfc822-to-8bit; Wed, 26 Feb 2003 19:23:06 -0500
Content-Type: text/plain; charset=US-ASCII
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux Solutions
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [BUG] 2.5.63: ESR killed my box!
Date: Wed, 26 Feb 2003 16:32:09 -0800
User-Agent: KMail/1.4.3
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       mingo@redhat.com, Mikael Pettersson <mikpe@csd.uu.se>,
       Asit Mallick <asit.k.mallick@intel.com>
References: <Pine.LNX.4.44.0302260813510.1423-100000@home.transmeta.com> <8750000.1046278359@[10.10.2.4]>
In-Reply-To: <8750000.1046278359@[10.10.2.4]>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200302261632.09436.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 February 2003 08:52 am, Martin J. Bligh wrote:
[ Snip! ]
> >
> > Anyway, the above is clearly not what we're doing with the ESR right now.
> >
> > Martin: in the esr disable case you clearly write the ESR multiple times
> > ("over the head with a big hammer"), and you must do that because you
> > noticed that a single write was insufficient. Why four? Did you just
> > decide that as long as you're doing multiple writes, you might as well
> > just do "several". Or did four writes work and two didn't?
>
> The latter, IIRC, 2 writes worked most of the time, but never really fixed
> it. Using any kind of logical analysis never seemed to work on that chip
> ... brute force, trial and error, and 3 months of tearing my hair out was
> the only thing that succeeded in the end. A time I have no wish to revisit
> ;-)
>
> cc'ed James Cleverdon ... he was involved in this with PTX, and gave me
> some  pointers to hair-restorer during the Linux timeframe.
>
> M.
> -

You want _that_ story, eh?   8^)

	*	*	*	*	*

Yeah we had ESR problems on the original NUMA-Q boxes with P6 CPUs.  On system 
shutdown, CPU 0 on one or more secondary nodes would occasionally spasm with 
an infinite stream of APIC error interrupts claiming invalid message.  A 
couple hardware guys and I spent a lot of time looking at the APIC bus with 
special APIC bus analyzers, etc.  We _never_ caught a malformed message on 
the APIC bus.

Once a CPU started weirding out like this, it was impossible to make it shut 
up.  We could clear the error status, and it would show cleared in the ESR, 
but the local APIC would reissue the same error interrupt as soon as we 
returned from the error handler.

In fact, with kernel printf turned off we would get about a million of them 
per second, faster than most APIC messages could be sent over the APIC bus.  
(This was a 16.6667 MHz two bit wide bus.  Messages were about 10 to 40 
frames long.)

Thus, I concluded that it was some weird error state in the local APIC.  We 
never got any answer back from Intel on how to clear this state, let alone 
admission that it existed, so we just turned off the APIC error IRQ.  Since 
we were shutting down the system anyway, this seemed an adequate kludge.

Writing 0 to the ESR four times was done out of paranoia, and a desire to 
grind the clear deeper into the local APIC's state machine.  I have no 
evidence that it ever really fixed this bug.  Nothing did.

Maybe this weirdness was fixed in P2s or later CPUs.  Maybe.  Intel never did 
say anything about it to us.  Regardless, the four writes to ESR is still 
enshrined in Dynix/PTX's APIC error handler, and will remain a hidden 
testimony to this bug for as long as IBM maintains PTX support.

-- 
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com

