Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288678AbSADQhE>; Fri, 4 Jan 2002 11:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288679AbSADQgx>; Fri, 4 Jan 2002 11:36:53 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:18419 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S288678AbSADQgh>; Fri, 4 Jan 2002 11:36:37 -0500
Date: Fri, 4 Jan 2002 17:32:34 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br,
        torvalds@transmeta.com
Subject: Re: [PATCH] 2.4.17/2.5.1 apic.c LVTERR fixes
In-Reply-To: <200201041508.QAA12387@harpo.it.uu.se>
Message-ID: <Pine.GSO.3.96.1020104164747.829A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jan 2002, Mikael Pettersson wrote:

> But a remote interrupt source supplies a vector, doesn't it? If we
> assume that the local APIC checks the vector on arrival _of_the_vector_,
> then it does make some sense that it also flags a null vector written
> to one of the LVT entries as an error. The bug really is that it forgets

 A local interrupt arriving when masked can be treated as one that's not
destined to the APIC, hence no error should be signalled.  And certainly
not at the LVT write time (especially as 0x00010000 is the power-up
default as well, possibly used by software predating integrated local
APICs). 

> to take the mask bit into account. However, the behaviour _is_ there and
> we have to avoid triggering it.

 Sure, but it'd better be marked as an APIC weirdness workaround or
otherwise code seems looks clueless.  The weirdness is nowhere documented
and the code is to be read by others -- the fact we know what is happening
here doesn't help much. 

> >> +		if (maxlvt > 3)		/* Due to Pentium errata 3AP and 11AP. */
> >> +			apic_write(APIC_ESR, 0);
> >
> > Use apic_write_around() instead as the 11AP workaround -- it was
> >introduced specifically for this purpose.  Using anything else doesn't
> >guarantee no back-to-back APIC writes due to interrupts (specifically
> >writes to the EOI register).
> 
> I disagree. The write doesn't occur on P5s, so 11AP doesn't apply.

 But the comment is misleading.  With an apic_write_around() no comment is
needed (the code looks obvious) and the code is a bit smaller. 

> If I had used an unconditional write_around() instead, then someone
> would complain that I'm violating erratum 3AP (even though it doesn't
> matter in this case). The test as written unambiguously handles both

 If someone digs deeply enough to check what 3AP is, he should know why it
doesn't apply.

> 3AP and 11AP, and is identical to the "clear ESR" code in
> setup_local_APIC() around line 385.

 It's not identical -- the code in setup_local_APIC() doesn't discard what
is read from ESR so it can't do apic_write_around().  Note that you must
write to ESR before reading it on a P6 and you must not write to ESR
before reading it on a Pentium if you want to retrieve meaningful data. 

 If you only want to clear ESR, you just need to ensure there is a
write-read sequence somewhere.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

