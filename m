Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129175AbRBMXWd>; Tue, 13 Feb 2001 18:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129146AbRBMXWZ>; Tue, 13 Feb 2001 18:22:25 -0500
Received: from e56090.upc-e.chello.nl ([213.93.56.90]:9994 "EHLO unternet.org")
	by vger.kernel.org with ESMTP id <S129154AbRBMXWQ>;
	Tue, 13 Feb 2001 18:22:16 -0500
Date: Wed, 14 Feb 2001 00:20:55 +0100
From: Frank de Lange <frank@unternet.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Ingo Molnar <mingo@chiara.elte.hu>, Andrew Morton <andrewm@uow.edu.au>,
        Manfred Spraul <manfred@colorfullife.com>,
        Martin Josefsson <gandalf@wlug.westbo.se>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.1, 2.4.2-pre3: APIC lockups
Message-ID: <20010214002055.A25494@unternet.org>
In-Reply-To: <Pine.GSO.3.96.1010213203553.1931A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010213203553.1931A-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Tue, Feb 13, 2001 at 09:13:10PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2001 at 09:13:10PM +0100, Maciej W. Rozycki wrote:
> There is also an additional debugging/statistics counter provided in
> /proc/cpuinfo that counts interrupts which got delivered with its trigger
> mode mismatched.  Check it out to find if you get any misdelivered
> interrupts at all.

I guess you mean the MIS: counter in /proc/interrupts? This is what it says on
my box after running some 330000 interrupts (at a rate of app. 900/second)
through the network/usb IRQ:

 cat /proc/interrupts 
           CPU0       CPU1       
  0:      31693      32749    IO-APIC-edge  timer
  1:       1208       1174    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  3:        113         26    IO-APIC-edge  serial
  4:       4689       4567    IO-APIC-edge  serial
 14:       4440       4545    IO-APIC-edge  ide0
 15:       1911       2132    IO-APIC-edge  ide1
 16:      85021      84227   IO-APIC-level  es1371, mga@PCI:1:0:0
 17:         26         26   IO-APIC-level  sym53c8xx
 18:          0          0   IO-APIC-level  btaudio, bttv
 19:     165467     166254   IO-APIC-level  eth0, eth1, usb-uhci
NMI:      64376      64376 
LOC:      64364      64362 
ERR:          0
MIS:        647

So, that's about 650 misdelivered interrupts for 330000 deliveries (the other
interrupts never gave me any trouble, so I guess the misdelivered ones are all
from IRQ 19), or about .2%

When I load the network and stream some audio over it, the sound becomes a bit
choppy. The MIS: counter only increases when the network (read: IRQ1() is
loaded, a single audio stream (app. 220 int/sec) causes no MISses to occur.

In general, I'd say the stability WITH the patch is good, and timeouts are
withing tolerable levels. If I need something better, I'll probably get myself
a better set of network cards...

So, quick conclusion, this seems a reasonable fix...

Cheers//Frank

-- 
  WWWWW      _______________________
 ## o o\    /     Frank de Lange     \
 }#   \|   /                          \
  ##---# _/     <Hacker for Hire>      \
   ####   \      +31-320-252965        /
           \    frank@unternet.org    /
            -------------------------
 [ "Omnis enim res, quae dando non deficit, dum habetur
    et non datur, nondum habetur, quomodo habenda est."  ]
