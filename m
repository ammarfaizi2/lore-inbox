Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293713AbSCUNDp>; Thu, 21 Mar 2002 08:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310430AbSCUNDf>; Thu, 21 Mar 2002 08:03:35 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:19912 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S293713AbSCUND2>; Thu, 21 Mar 2002 08:03:28 -0500
Date: Thu, 21 Mar 2002 14:03:28 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
cc: Ingo Molnar <mingo@elte.hu>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Severe IRQ problems on Foster (P4 Xeon) system
In-Reply-To: <Pine.LNX.4.33.0203201701480.9609-100000@biker.pdb.fsc.net>
Message-ID: <Pine.GSO.3.96.1020321133902.16502A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2002, Martin Wilck wrote:

> In principle not even cli is necessary because, all interrupts are
> automatically disabled upon entry into SMM mode. The bios does mask
> the PIC, though, probably because it is possible for SMI handlers to
> reenable interrupts while in SMM mode. AFAIK, our BIOS does _not_
> include such handlers, but Phoenix seems to have put in that code
> so that it is possible to write them if desired. It appears that the
> Phoenix programmers overlooked the fact that the PIC might be in poll
> mode when they try to read the IMR. Our Bios people are trying to
> contact Phoenix about this.

 This does not make sense -- fiddling with 8259A chips does not assure
maskable interrupts won't arrive.  They still may come from the APIC bus
and from local APIC sources.  And you don't really want to handle
interrupts in the SMI mode unless you know details of the operating system
running -- if you execute an iret instruction NMIs get enabled and even
more mess may happen (this may be the reason of some systems failing with
the NMI watchdog enabled). 

> Can you tell me how the SMI code could correctly transparently reestablish
> the 8259A state in the situation we are facing?
> I can't think of an algorithm that would put the PIC in exactly the same
> state that it was in before the SMI, not to talk about the time elapsed
> during SMI, which easily comes up to a few 100 us on our system.

 There are two ways I can think of at the moment:

1. Don't touch it at all.  It's the preferred way if possible, as it
doesn't change the hardware's state.

2. Use alternate registers dedicated to save/restore the hardware's state
(typically used for power management), that provide details beyond the
standard ones.  Of course if a particular implementation doesn't have ones
(are there any these days?), you don't really have a choice apart from #1
above.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

