Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265395AbTLHNb3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 08:31:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265398AbTLHNb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 08:31:29 -0500
Received: from secure.comcen.com.au ([203.23.236.73]:6161 "EHLO
	xavier.etalk.net.au") by vger.kernel.org with ESMTP id S265395AbTLHNbZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 08:31:25 -0500
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: Craig Bradney <cbradney@zip.com.au>
Subject: Re: Catching NForce2 lockup with NMI watchdog - found?
Date: Mon, 8 Dec 2003 23:34:25 +1000
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org, recbo@nishanet.com,
       B.Zolnierkiewicz@elka.pw.edu.pl, AMartin@nvidia.com
References: <200312081321.06692.ross@datscreative.com.au> <1070883402.17639.115.camel@athlonxp.bradney.info>
In-Reply-To: <1070883402.17639.115.camel@athlonxp.bradney.info>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312082334.25163.ross@datscreative.com.au>
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 December 2003 21:36, Craig Bradney wrote:
> On Mon, 2003-12-08 at 04:21, Ross Dickson wrote:
> > On Monday 08 of December 2003 04:08, Bob wrote: 
> >  > >>Sounds great.. maybe you have come across something. Yes, the CPU 
> >  > >>Disconnect function arrived in your BIOS in revision of 2003/03/27 
> >  > >>"6.Adds"CPU Disconnect Function" to adjust C1 disconnects. The Chipset 
> >  > >>does not support C2 disconnect; thus, disable C2 function." 
> >  > >> 
> >  > >>For me though.. Im on an ASUS A7N8X Deluxe v2 BIOS 1007. From what I can 
> >  > >>see the CPU Disconnect isnt even in the Uber BIOS 1007 for this ASUS 
> >  > >>that has been discussed. 
> >  > >> 
> >  > >>Craig 
> >  > >
> >  > >I don't have that in MSI K7N2 MCP2-T near the 
> >  > >agp and fsb spread spectrum items or anywhere 
> >  >> else. 
> > >Use athcool: 
> > >         http://members.jcom.home.ne.jp/jacobi/linux/softwares.html#athcool
> > > or apply kernel patch (2.4 and 2.6 versions were posted already). 
> > >--bart 
> > 
> > Please take a look at 
> > 
> > Fixes for nforce2 hard lockup, apic, io-apic, udma133 covered
> > 
> > in mailing list.
> > 
> > I approached it from another angle regarding delaying the apic ack in local timer irq
> > and achieved stability. It would be good to have others try it. Ian Kumlien is also
> > reporting success so far.
> >  
> 
> Although I had long uptimes before.. and therefore might achieve them
> again fairly easily.. I'm now on 2 days 10 hours which has included a
> lot of compilation and a lot of idle time, and plenty of the hdpar and
> grep tests. I have used only the IRQ0 IO-APIC edge patch.
> 
> Can someone please note all the patches for 2.6 that people have tried
> and what they achieve? Im starting to get a bit lost, given the fact
> that I'm running stable here with only 1 patch. (so far - this is where
> it crashes after I click Send I suppose ;) )
> 
> -apic
> 
> -io-apic (IRQO set to XT-PIC incorrectly)
> 
> -udma133?
> 
> -cpu disconnect patch (missing bios option for ACPI Cx states)
> 
> Craig
> 
> 
> 
> 
Hi Craig
Here is a link to my original posting

http://linux.derkeiler.com/Mailing-Lists/Kernel/2003-12/1528.html

I have not been working with 2.6, only 2.4.23 and 2.4.22.
My work has been independent of the cpu disconnect function and mpparse
patches spoken of in this posting thread. I think my work may have utility
within the 2.6 environment hence my posting to this thread. 

This followup with Ian may shed some more light.

http://linux.derkeiler.com/Mailing-Lists/Kernel/2003-12/1648.html

My test system has also been running ioapic for days now and I have stress
loaded it at times with gigabyte file copies alongside mplayer playing movies in 
three windows at the same time. It feels good to see the hardware performing
well. My motivation was that I have a digital imaging application where one
of the PCI cards performs poorly with shared interrupts so I had to fix the
ioapic mode. At one stage I got desperate and went back to xtpic mode.
I tried reprogramming the pirq routing registers to get extra pci irqs other 
than just irq11 from the AMD768 docs but of course the nforce2 is different
and it didn't work.

Referring to my posting the stability key I found is the (a) apic ack delay. 
I actually implemented the (b) ioapic timer edge first but my system was 
unstable still. Part (c) the udma133 was a cleanup along the way when I
thought the problem had to do with ide interface timings. It is probably not
a required part of the solution but it was there so I thought I would throw
it into the ring, in fact looking back I wonder if part (a) the apic ack delay 
is enough on its own to get rid of the lockups?

I do not know why the apic timing delay stablises the system.
Perhaps with the bios an SMI event occurs to do with the cpu disconnect 
function? and the apic ack gets lost? I do not know? but hopefully someone
can get to the bottom of it. The concept of it being bios dependent is perhaps
not so strange. I found this posting regarding a bad SMI during my research.

http://www.ussg.iu.edu/hypermail/linux/kernel/0203.2/0698.html

I have really found this flying in the dark with respect to hardware docs
very frustrating. I do not have the appropriate AMD cpu nor the nForce2 docs 
to be able to delve much deeper into the cause. Heck I even dragged out my 
old Intel "Microsystem Components Handbook Volume 1 1984" to look up detail on 
the 8259 auto end of interrupt mode used in the virtual wire mode. I had never seen
anyone use it before.

I hope that whichever solutions best fix the problems end up in the kernel tree 
for all our benefit. This has cost me 2 weeks of little sleep to get this far and being 
in small business it is also two weeks of unpaid time. I wish the hardware industry
had an open documents philosophy as good as linux has open source.

Regards
Ross.
