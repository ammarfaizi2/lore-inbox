Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288607AbSADMRo>; Fri, 4 Jan 2002 07:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288611AbSADMRh>; Fri, 4 Jan 2002 07:17:37 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:31216 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S288615AbSADMRN>; Fri, 4 Jan 2002 07:17:13 -0500
Date: Fri, 4 Jan 2002 13:12:44 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        marcelo@conectiva.com.br
Subject: Re: [PATCH] 2.4.17/2.5.1 apic.c LVTERR fixes
In-Reply-To: <200201032013.VAA03162@harpo.it.uu.se>
Message-ID: <Pine.GSO.3.96.1020104122237.22521B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jan 2002, Mikael Pettersson wrote:

> > Also note that's really an APIC and not a kernel bug -- writing a
> >previously read value to a register is defined as valid by Intel. 
> 
> Can you quote chapter and verse on that last statement?
> (Preferably from IA32 Vol3.) Writes to APIC registers obviously
> _do_ cause side-effects in some cases...

 Obviously I confused defined bits with reserved ones, sorry.  Still the
APIC looks insane for me -- it should really signal an error only once an
interrupt is received, like it does for interrupts from remote sources.

> Pentium erratum 3AP can be ignored, since the whole purpose of the
> two ESR accesses is to clear ESR. Unfortunately, Pentium erratum 11AP
> does apply, since there are back-to-back APIC writes (first to LVTERR,
> then to ESR).

 I checked 3AP and you are right, since we don't need the ESR's value.

> +		if (maxlvt > 3)		/* Due to Pentium errata 3AP and 11AP. */
> +			apic_write(APIC_ESR, 0);

 Use apic_write_around() instead as the 11AP workaround -- it was
introduced specifically for this purpose.  Using anything else doesn't
guarantee no back-to-back APIC writes due to interrupts (specifically
writes to the EOI register).

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

