Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267668AbUIJRaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267668AbUIJRaq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 13:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267664AbUIJRaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 13:30:00 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:51939 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S267614AbUIJR1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 13:27:49 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: swsusp: kill crash when too much memory is free
Date: Fri, 10 Sep 2004 19:26:30 +0200
User-Agent: KMail/1.6.2
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>,
       Patrick Mochel <mochel@digitalimplant.org>
References: <20040909154219.GB11742@atrey.karlin.mff.cuni.cz> <200409100001.28781.rjw@sisk.pl> <20040910094039.GC11281@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20040910094039.GC11281@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200409101926.30902.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 of September 2004 11:40, Pavel Machek wrote:
> Hi!
> 
> > > If too much memory is free, swsusp dies in quite a ugly way. Even when
> > > it is not neccessary to relocate pagedir, it is proably still
> > > neccessary to relocate individual pages. Thanks to Kurt Garloff and
> > > Stefan Seyfried...
> > > 								Pavel
> > > PS: And could I have one brown paper bag, please?
> > 
> > I applied this and it didn't fix my problems with resuming, unfortunately, 
but 
> > it changed the symptoms.  Namely, if USB modules are not unloaded before 
> > suspending, I get:
> 
> > This is 100% reproducible (ie unload USB modules and dm_mod, suspend the 
> > machine, try to wake it up, hangs solid).
> > 
> > Can you tell me, please, if there's anything I can compile out/in to debug 
it 
> > a bit more?  Or can I put some printk()s somewhere in the code to get some 
> > more info?  Any suggestions welcome.
> 
> Can you try my "bigdiff"? Also, does it work okay in 32-bit mode?

Well, the good news is that it sort of works.  Still, there are some bad news, 
as usual. ;-)

First, to make the box wake up, I have to unload ohci_hcd and everything that 
sits on IRQ11 before suspending (on my system that is sk98lin, yenta_socked, 
and ohci1394).  If you want me to show what happens if I don't unload these 
modules, I'll be able to grab some traces in a couple of hours. ;-)  Also, I 
have to compile out the frequency scaling, because otherwise it hangs solid 
at some time after wake-up.

Second, after it's woken up, it seems to be very, _very_ slow, and the reason 
is indicated by this:

albercik:~ # cat /proc/interrupts && cat /proc/interrupts
           CPU0
  0:     273334          XT-PIC  timer
  1:       1803          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:    6656316          XT-PIC  NVidia nForce3
  8:          0          XT-PIC  rtc
  9:        121          XT-PIC  acpi
 10:          2          XT-PIC  ehci_hcd
 12:       5447          XT-PIC  i8042
 14:         16          XT-PIC  ide0
 15:       5044          XT-PIC  ide1
NMI:          0
LOC:     272507
ERR:          0
MIS:          0
           CPU0
  0:     273460          XT-PIC  timer
  1:       1803          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:    6680145          XT-PIC  NVidia nForce3
  8:          0          XT-PIC  rtc
  9:        121          XT-PIC  acpi
 10:          2          XT-PIC  ehci_hcd
 12:       5447          XT-PIC  i8042
 14:         16          XT-PIC  ide0
 15:       5046          XT-PIC  ide1
NMI:          0
LOC:     272632
ERR:          0
MIS:          0

Normally (eg before suspending), I get something like that:

           CPU0
  0:     196903          XT-PIC  timer
  1:       1437          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:         40          XT-PIC  NVidia nForce3
  8:          0          XT-PIC  rtc
  9:         99          XT-PIC  acpi
 10:          2          XT-PIC  ehci_hcd
 12:       3302          XT-PIC  i8042
 14:         16          XT-PIC  ide0
 15:       4667          XT-PIC  ide1
NMI:          0
LOC:     196751
ERR:          0
MIS:          0
           CPU0
  0:     196905          XT-PIC  timer
  1:       1437          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:         40          XT-PIC  NVidia nForce3
  8:          0          XT-PIC  rtc
  9:         99          XT-PIC  acpi
 10:          2          XT-PIC  ehci_hcd
 12:       3302          XT-PIC  i8042
 14:         16          XT-PIC  ide0
 15:       4667          XT-PIC  ide1
NMI:          0
LOC:     196753
ERR:          0
MIS:          0

In the 32-bit mode it behaves similarly (eg I have to unload the same modules 
etc. to make the box wake up), although the rate of growth of the number of 
IRQ5s seems to be smaller.

If you need any more info or if I can do anything more to debug it further, 
please let me know.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
