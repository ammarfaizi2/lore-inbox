Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129957AbRBBQbe>; Fri, 2 Feb 2001 11:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129958AbRBBQbZ>; Fri, 2 Feb 2001 11:31:25 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:11981 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S129383AbRBBQbK>;
	Fri, 2 Feb 2001 11:31:10 -0500
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14970.57386.342506.197905@harpo.it.uu.se>
Date: Fri, 2 Feb 2001 17:28:26 +0100
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [PATCH] 2.4.1-ac1 UP-APIC/NMI watchdog fixes
In-Reply-To: <Pine.GSO.3.96.1010202142901.28509G-100000@delta.ds2.pg.gda.pl>
In-Reply-To: <200102011928.UAA03188@harpo.it.uu.se>
	<Pine.GSO.3.96.1010202142901.28509G-100000@delta.ds2.pg.gda.pl>
X-Mailer: VM 6.76 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej W. Rozycki writes:
 >  I've forgotten to cc you when sending Ingo my patch-2.4.0-ac12-upapic-19
 > fixes a few days ago, my apologies.  Since the two patches conflict with
 > each other, I've merged them together and provide the result below. 
 > Please check if it is fine for you. 

Looks fine to me.

 >  I'm unsure about the K7_NMI_EVENT macro -- I think it should go into
 > include/asm-i386/msr.h, but the comment should remain here.  It should get
 > reworded a bit in this case, I suppose, though. 

I'd prefer to keep it in nmi.c -- it doesn't really have any relevance
elsewhere. I made a macro of it so that I wouldn't need any #ifdef:s
or long explanations in the code proper.

There is one thing which bothers me. Look at the end of the NMI handler:

 > +	if (cpu_has_apic && (nmi_watchdog == NMI_LOCAL_APIC))
 > +		wrmsr(nmi_perfctr_msr, -(cpu_khz/HZ*1000), -1);

This becomes a series of loads and tests. Ideally, a _single_ test should suffice
to inform the NMI handler whether we're in NMI_LOCAL_APIC mode or not. One problem
is that we aren't resetting nmi_watchdog to NMI_NONE if we fail to detect or
initialise the local APIC; if we did, we could kill the cpu_has_apic test.

... however, nmi_perfctr_msr could serve this purpose since it will be
non-zero if and only if (cpu_has_apic && nmi_watchdog == NMI_LOCAL_APIC).
So I would actually suggest something like:

	if (nmi_perfctr_msr)
		wrmsr(nmi_perfctr_msr, -(cpu_khz/HZ*1000), -1);

/Mikael
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
