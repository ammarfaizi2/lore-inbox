Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288296AbSACUNe>; Thu, 3 Jan 2002 15:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288297AbSACUNY>; Thu, 3 Jan 2002 15:13:24 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:49294 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S288296AbSACUNJ>;
	Thu, 3 Jan 2002 15:13:09 -0500
Date: Thu, 3 Jan 2002 21:13:05 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200201032013.VAA03162@harpo.it.uu.se>
To: macro@ds2.pg.gda.pl, torvalds@transmeta.com
Subject: Re: [PATCH] 2.4.17/2.5.1 apic.c LVTERR fixes
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jan 2002 15:57:34 +0100 (MET), Maciej W. Rozycki wrote:
>> @@ -84,6 +88,8 @@
>>  		apic_write_around(APIC_LVTERR, APIC_LVT_MASKED);
>>  	if (maxlvt >= 4)
>>  		apic_write_around(APIC_LVTPC, APIC_LVT_MASKED);
>> +	apic_write(APIC_ESR, 0);
>> +	v = apic_read(APIC_ESR);
>>  }
>
> You mustn't access the ESR unconditionally -- it doesn't exist in the
>i82489DX.  Also check the Pentium erratum 3AP for possible issues (I can't
>recall if writing is safe -- possibly only the contents are lost).
>
> Also note that's really an APIC and not a kernel bug -- writing a
>previously read value to a register is defined as valid by Intel. 

Can you quote chapter and verse on that last statement?
(Preferably from IA32 Vol3.) Writes to APIC registers obviously
_do_ cause side-effects in some cases...

Pentium erratum 3AP can be ignored, since the whole purpose of the
two ESR accesses is to clear ESR. Unfortunately, Pentium erratum 11AP
does apply, since there are back-to-back APIC writes (first to LVTERR,
then to ESR).

The patch below fixes the 11AP and 82489DX issues. It has the usual test
before the write to ESR, which avoids both erratum 11AP (should the code
be moved around) and 3AP (redundantly, to avoid confusion).

(Linus, please apply.)

/Mikael

--- linux-2.5.2-pre6/arch/i386/kernel/apic.c.~1~	Thu Jan  3 19:08:00 2002
+++ linux-2.5.2-pre6/arch/i386/kernel/apic.c	Thu Jan  3 19:58:26 2002
@@ -88,8 +88,12 @@
 		apic_write_around(APIC_LVTERR, APIC_LVT_MASKED);
 	if (maxlvt >= 4)
 		apic_write_around(APIC_LVTPC, APIC_LVT_MASKED);
-	apic_write(APIC_ESR, 0);
-	v = apic_read(APIC_ESR);
+	v = GET_APIC_VERSION(apic_read(APIC_LVR));
+	if (APIC_INTEGRATED(v)) {	/* !82489DX */
+		if (maxlvt > 3)		/* Due to Pentium errata 3AP and 11AP. */
+			apic_write(APIC_ESR, 0);
+		apic_read(APIC_ESR);
+	}
 }
 
 void __init connect_bsp_APIC(void)
