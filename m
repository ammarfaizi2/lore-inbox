Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbUBNQM5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 11:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbUBNQM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 11:12:57 -0500
Received: from gizmo03ps.bigpond.com ([144.140.71.13]:1729 "HELO
	gizmo03ps.bigpond.com") by vger.kernel.org with SMTP
	id S262153AbUBNQMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 11:12:55 -0500
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
Subject: Re: [PATCH] 2.6, 2.4, Nforce2, Experimental idle halt workaround instead of apic ack delay.
Date: Sun, 15 Feb 2004 02:13:20 +1000
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org, Jamie Lokier <jamie@shareable.org>,
       Ian Kumlien <pomac@vapor.com>, Jesse Allen <the3dfxdude@hotmail.com>,
       Craig Bradney <cbradney@zip.com.au>, Daniel Drake <dan@reactivated.net>
References: <200402120122.06362.ross@datscreative.com.au> <200402141124.50880.ross@datscreative.com.au> <402E0386.5090004@gmx.de>
In-Reply-To: <402E0386.5090004@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402150213.20532.ross@datscreative.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Found the problem for 2.6
> > 
> > After fixing it the 2.6 temperature is
> > Patched Linux 2.6.3-rc1-mm1, 38C
> > Ambient today is 1C cooler also.
> 
> Yes, I am just trying your new patch, and it works! Furthermore it seems 
> to have less ipact on system performance than the tack one, as now 
> hdparm reports the same figures as without using APIC. Well done!
> 
> Have you read the post  from Mathieu about his finding of APIC and 8254 
> timer not being sync, which causes lock-ups? 

I have seen the posting from Mathieu. It is very interesting work. 
With an embedded system you would not waste the resources to setup and run
two timers at almost the same 1ms interval as is done in i386 linux unless you
had very good reason. I think for the PC it has to do with the 8254 historically
having a more accurate oscillator source?

I am thinking that maybe nforce2 is locking up when the 8254 interrupt and the
apic interrupt trigger almost co-incident with each other for a while - yielding
back to back cycles of coming out of C1 disconnect and then being thrown
back into it by the idle thread. This could cause all sorts of problems within
the chips such as hot tristate drivers or power rail fluctuations if the capacitors
and regulators cannot compensate for such a frequency. An analogy is
the low frequency beat while tuning a musical instrument. Also if the oscillators
are from different crystals then the beat frequency will also vary with temperature.

By changing the timing differential between the apic timer and the 8254 timer
Mathieu forces the interrupts come into phase with each other for a briefer
period of time so then not so many back to back C1 cycles occur? And eliminating
the apic timer removes this source of interrupt co-incidence.

Maybe the Athlon nforce2 system can withstand the C1 disconnect dance of the
two timers but then throwing in the repetitive block read interrupts of an IDE hard
drive triggers failure. Twos company - three's a crowd...??? I am just guessing.


>	Maybe there should be the 
> correct way of fixing it. Furthermore I saw this in latest ACPI update:
> [ACPI] nforce2 timer lockup from Maciej W. Rozycki
> 
> Is this the fix or something else?

Partly, its related to my io-apic edge patch regarding timer ints. Maciej &
I corresponded about the ioapic & 8254 timers in some detail in December.
Jesse spotted Maciej's fix called nforce-irq-setup-fix.patch first appearing
in 2.6.3-rc1-mm1 and is referred to in this thread starter.

It gets another mention in 2.6.3-rc2-mm1 changelog as now being included
in the ACPI patch so I am pretty sure that is it.
"-nforce-irq-setup-fix.patch"
" This is in the ACPI patch"

Regards
Ross.

> 
> Cheers,
> 
> Prakash
 

