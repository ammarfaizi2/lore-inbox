Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129224AbRBBLbl>; Fri, 2 Feb 2001 06:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129506AbRBBLbb>; Fri, 2 Feb 2001 06:31:31 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:47884 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129224AbRBBLbM>;
	Fri, 2 Feb 2001 06:31:12 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Mikael Pettersson <mikpe@csd.uu.se>
Date: Fri, 2 Feb 2001 12:28:14 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] 2.4.1-ac1 UP-APIC/NMI watchdog fixes
CC: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
        macro@ds2.pg.gda.pl, mingo@elte.hu
X-mailer: Pegasus Mail v3.40
Message-ID: <14539A444A09@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  2 Feb 01 at 3:35, Mikael Pettersson wrote:
> On Fri, 2 Feb 2001 01:37:28 +0100, Ingo Molnar wrote:
> > On Thu, 1 Feb 2001, Mikael Pettersson wrote:
> > > * NMI watchdog cleanups: mark setup_apic_nmi_watchdog() as __init,
> > >   fix the K7 init code to not leave any perfctr MSR uninitialised,
> > >   avoid having to check CPU type in NMI handler.
> > >   (Yes, the merged wrmsr(,,-1) is safe for P6.)
> > 
> > thanks Mikael! Did you have a chance to test this on a K7? Does
> > UP-APIC-NMI-watchdog code truly 'just work' now on the K7?
> 
> I wrote the initial patch using the info I gathered for my
> performance-monitoring counters driver. Petr Vandrovec tested
> and debugged it. (Alas, I don't yet have a K7 to play with.)

Yes, it works. There is only problem with VMware - I wrote patch
which disables LVTPC NMI delivery when running VMware (like 
LVT0/1 NMI delivery is disabled on normal SMP/IOAPIC kernel (as VMware
uses its own address space when running emulation, it does not want 
NMI delivery during switching address spaces)) and I found that after 
I reenable delivery, nothing happens :-( Performance counters aparently
just delivery interrupt only for one cycle when counter value is 
FFFFFFFFFFFFFFFF. And apparently setting delivery mode to edge triggered 
does not work for LVTPC (or maybe that disabling LVTPC delivery just causes
all events to be dropped, even in edgemode). So first time when VMware 
runs when NMI should be triggered, you lost it. And as next come after 
2^48 CPU clocks, it disables NMI watchdog almost forever (it is not 
problem on ia32, as 2^32 cycles passes in few seconds after you exit 
from VMware).

As workaround, I tried to program LVTPC as fixed delivery to 2, but this
caused 'invalid vector received' error :-( So for now UP K7 NMI watchdog 
and vmware are incompatible. Maybe I should try to revector it for
SMI delivery, because of SMI handler runs in its own address space. But it
is incompatible with APM and ACPI, so...
                                            Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
