Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288669AbSADPIu>; Fri, 4 Jan 2002 10:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288667AbSADPIk>; Fri, 4 Jan 2002 10:08:40 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:25217 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S288666AbSADPIZ>;
	Fri, 4 Jan 2002 10:08:25 -0500
Date: Fri, 4 Jan 2002 16:08:23 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200201041508.QAA12387@harpo.it.uu.se>
To: macro@ds2.pg.gda.pl
Subject: Re: [PATCH] 2.4.17/2.5.1 apic.c LVTERR fixes
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br,
        torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jan 2002 13:12:44 +0100 (MET), Maciej W. Rozycki wrote:
>  Still the
>APIC looks insane for me -- it should really signal an error only once an
>interrupt is received, like it does for interrupts from remote sources.

But a remote interrupt source supplies a vector, doesn't it? If we
assume that the local APIC checks the vector on arrival _of_the_vector_,
then it does make some sense that it also flags a null vector written
to one of the LVT entries as an error. The bug really is that it forgets
to take the mask bit into account. However, the behaviour _is_ there and
we have to avoid triggering it.

>> +		if (maxlvt > 3)		/* Due to Pentium errata 3AP and 11AP. */
>> +			apic_write(APIC_ESR, 0);
>
> Use apic_write_around() instead as the 11AP workaround -- it was
>introduced specifically for this purpose.  Using anything else doesn't
>guarantee no back-to-back APIC writes due to interrupts (specifically
>writes to the EOI register).

I disagree. The write doesn't occur on P5s, so 11AP doesn't apply.
If I had used an unconditional write_around() instead, then someone
would complain that I'm violating erratum 3AP (even though it doesn't
matter in this case). The test as written unambiguously handles both
3AP and 11AP, and is identical to the "clear ESR" code in
setup_local_APIC() around line 385.

/Mikael
