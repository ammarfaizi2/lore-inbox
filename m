Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287314AbSACPD3>; Thu, 3 Jan 2002 10:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287320AbSACPDU>; Thu, 3 Jan 2002 10:03:20 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:53474 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S287314AbSACPDH>; Thu, 3 Jan 2002 10:03:07 -0500
Date: Thu, 3 Jan 2002 15:57:34 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: marcelo@conectiva.com.br, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.17/2.5.1 apic.c LVTERR fixes
In-Reply-To: <200112231514.QAA25107@harpo.it.uu.se>
Message-ID: <Pine.GSO.3.96.1020103153325.20800D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Dec 2001, Mikael Pettersson wrote:

> The Intel P6 local APIC internally signals an Illegal Vector error
> whenever a zero vector is written to an LVT entry, even if the entry
> is simultaneously masked. The bug is that apic.c triggers these errors
> when the contents of LVTERR is defined by the BIOS and not the kernel,
> which can cause unexpected interrupts on unknown vectors. This typically
> happens at boot-time initialisation, PM suspend, and PM resume.
> 
> The patch eliminates the problem by changing the initialisation order
> in apic.c's clear_local_APIC() and apic_pm_resume() to ensure that LVTERR
> is masked when we write (potentially) null vectors to LVT entries.
[...]
> @@ -84,6 +88,8 @@
>  		apic_write_around(APIC_LVTERR, APIC_LVT_MASKED);
>  	if (maxlvt >= 4)
>  		apic_write_around(APIC_LVTPC, APIC_LVT_MASKED);
> +	apic_write(APIC_ESR, 0);
> +	v = apic_read(APIC_ESR);
>  }

 You mustn't access the ESR unconditionally -- it doesn't exist in the
i82489DX.  Also check the Pentium erratum 3AP for possible issues (I can't
recall if writing is safe -- possibly only the contents are lost).

 Also note that's really an APIC and not a kernel bug -- writing a
previously read value to a register is defined as valid by Intel. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

