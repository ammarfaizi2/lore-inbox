Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129667AbQLTTY6>; Wed, 20 Dec 2000 14:24:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130466AbQLTTYt>; Wed, 20 Dec 2000 14:24:49 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:4266 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S129667AbQLTTYn>; Wed, 20 Dec 2000 14:24:43 -0500
Date: Wed, 20 Dec 2000 19:52:32 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, mingo@chiara.elte.hu
Subject: Re: Startup IPI (was: Re: test13-pre3)
In-Reply-To: <1023FFA13E5F@vcnet.vc.cvut.cz>
Message-ID: <Pine.GSO.3.96.1001220192220.846J-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Dec 2000, Petr Vandrovec wrote:

> I did... So it uses 'xchg %eax,APIC_ICR' instead of 'movl %eax,APIC_ICR',
> yes (as verified in generated code...)? No change, still dies, as expected
> (do not forget that before it dies, it can do ~0x1300 write-read cycles

 I've forgotten indeed...

> from videomemory (AGP4x), so secondary CPU just does some thinking before

 This might be the time needed to deliver the IPI.  Remember that the
inter-APIC bus is serial and not that fast.

> it kills machine; only problem is that 0x1300 wr-rd cycles to VGA apperture
> take 3.48ms, and this does not correspond with needed 200us udelay.

 Hmm, how do you calculate the time?  Assuming AGP4x runs at 133MHz and a
read or write cycle lasts for a single clock tick (I don't know exact AGP
specs -- please correct me if I'm wrong), I find 0x1300 cycles to finish
in about 73usecs.  The loop execution overhead may double the result and
it will still fit within 300usecs. 

> Maybe chipset decides to do something when second CPU cannot obtain
> bus access in 100000 pci cycles?).

 I guess a certain initial cycle from the AP confuses the chipset somehow.

> Do you (or anyone else) have code which can dump MTRR registers of each
> of CPU before mtrr driver takes over them? At least first CPU does not have
> any problem...

 A brief look at arch/i386/kernel/mtrr.c reveals the bootstrap CPU's
settings do not get changed.  As a result they may always be fetched from
the /proc filesystem.  For APs you probably need to tweak sources.

> I even placed 'wbinvd' and 'wbinvd; cpuid' before sending startup IPI,
> but it does not matter. Secondary CPU just does not finish even first
> instruction when first CPU reads from videoram again and again.

 Well, the CPU obeys the writeback and the invalidation, but does the
chipset?

> Without VIA datasheet I cannot try to disable some PCI features to find
> which one is culprit, so I'm sorry.

 But you may complain to the manufacturer and/or change hardware.  I'm
still uncertain the delay should stay in...

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
