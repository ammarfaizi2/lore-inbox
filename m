Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264874AbTLVX5n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 18:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264873AbTLVX5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 18:57:43 -0500
Received: from xavier.comcen.com.au ([203.23.236.73]:15891 "EHLO
	xavier.etalk.net.au") by vger.kernel.org with ESMTP id S264874AbTLVX5Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 18:57:16 -0500
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: Daniel Drake <dan@reactivated.net>
Subject: Re: Updated Lockup Patches, 2.6.0 Nforce2, apic timer ack delay, ioapic edge for NMI debug
Date: Tue, 23 Dec 2003 09:56:38 +1000
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <200312211917.05928.ross@datscreative.com.au> <3FE73CF6.4030207@reactivated.net>
In-Reply-To: <3FE73CF6.4030207@reactivated.net>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200312230948.24162.ross@datscreative.com.au>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 23 December 2003 04:50, Daniel Drake wrote:
> Hi,
> 
> I compiled 2.6.0-test11-mm1, with local APIC and IO-APIC (I hadn't used these 
> options before) and I encountered a complete system freeze after about 10 mins 
> of "basic" (mozilla, xmms) usage. Never had any stability problems on this 
> system at all, before that freeze. I then recompiled the kernel with your 
> patches and since then it's been fine.
> 

The freezes really show up with the apic on. The old XTPIC has slower access
times and different code paths which appear to make it more stable.

2.6.0-test11-mm1 picked up the earlier two patches which were the topic
of "Catching NForce2 lockup with NMI watchdog"

Others had reported that those patches achieved stability?

Those patches are known in the test11-mm1 changelog as
+nforce2-disconnect-quirk.patch
+nforce2-apic.patch

The nforce2-disconnect-quirk.patch disables the C1 disconnect bit.
It roughly equates in function to my apic ack delay patch.

The nforce2-apic.patch tries to correct the 8254 timer route but gets it wrong.
It roughly equates in function to my ioapic edge patch.

> Would your patches (by default) have influenced this? I have yet to play around 
> with apic_tack - would me testing this be useful?

YES by default you have corrected the 8254 timer route with my io-apic patch.

My apic ack delay patch is off in your system as evidenced by not using the
apic_tack arg. 

The disconnect quirk patch in the test11-mm1 is achieving much the same goal
as the apic_tack arg does but your cpu temperature is probably 8C to 10C hotter
than if the disconnect quirk was removed and you tried apic_tack=1. 

You can try apic_tack=2 but its performance in stopping lockups is more system and
linux version dependent.

I say probably on the temperature as it depends if your bios has C1 disconnect
on or off at boot.

You can check it the C1 disconnect bit at runtime and manipulate it if desired
with athcool.
On is cool
Off is hot.

Regards
Ross.

> 
> Hardware: AMD 2600+ throughbred, Abit NF7-S V2.0, DDR333 Corsair RAM.
> 
> -Daniel
> 
> Ross Dickson wrote:
> > Firstly I thought a summary overdue so here goes.
> > 
> > My speculations as to why Nforce2 systems lock up are as follows:
> > 
> > a) The Nforce2 DASP speculates and gets it right, pre-fetching the code for the
> >  local apic timer interrupt, so the interrupt code executes sooner after
> >  activation than it does with other chipsets for AMD. 
> > 
> > b) The AMD cpu may not be over its timing and stability issues when coming
> >  out of C1 disconnect. Plenty stable soon enough for other chipsets and other
> >  codepaths in linux which pull the cpu out of C1 disconnect, but not quite soon
> >  enough for the "cached" short code path to the local apic timer ack. So most
> >  of the time any latent lockup potential is not realised, but on occasion 
> >  we hit it.
> > 
> > Disclaimer: I can think of so many ways I could be way off so I have a support
> > request in with AMD on the topic which I am told is progressing. I do not have
> > the resources to be able to confirm or deny the above theory. Patches are 
> > GPL'ed as per the licenses of the files they go into.
> > 
> > 
> >   Are my patches the only way to workaround lockups?
> > NO Firstly I think the manufacturers will fix the problem so I will not have to
> > use any workarounds one day. There are early reports that recent Award bios's
> > are fixing the lockup issue but not the nmi_watchdog problem.
> > 
> > Others advise you can successfully use the C1 disconnect patch for the kernel,
> > also Athcool. Some bios also have options to alter the C1 Disconnect
> > state and some early bios are preset with it to always off. If the lockups would
> > only occur with disconnect on (yet to be confirmed or denied by manufacturers)
> > then this would be one sure way to stop them.
> > 
> >   Why don't you just disable the C1 disconnect?
> > I don't think it would be wise for me to frob with it for many reasons. Nvidia
> > has some seriously patented smarts in their ram controllers, and the ambient
> > temperature today, where I am, rose to 30C or about 85F and it gets hotter. I 
> > also have a system in the north of Western Australia where 40C+ summer is 
> > normal. The AMD processor data sheet says that the CPU only enters low power
> > state if it can disconnect. Web postings indicate 8C to 10C temperature increase
> > with disconnect disabled.
> > 
> >   Do my patches Fix all of it?
> > No they are just workarounds. How well they work around may depend upon your
> > system configuration, and how well the delay times chosen suit it.
> > 
> >   Any evil side effects?
> > Maybe, but I don't know of any yet. Any slowing from the delay is so far 
> > not noticeable.
> > 
> >   Why 2 patches?
> > The apic timer ack delay patch is for the hard lockups.
> > The io-apic edge patch is for lost interrupts and also gives nmi_watchdog=1
> > functionality.
> > 
> >   Should I install any or both?
> > Depends, you get to decide until the manufacturers fix it.
> > 
> > The io-apic edge seems beneficial to all Nforce2 so far as the bios reports the
> > 8254 timer connected to INTIN2. I found it connected directly to INTIN0.
> > The patch forces connection to INTIN0 to see if it works only after the existing 
> > code has tried to connect it to where the bios said it was. The io-apic patch
> > compiles in only with acpi on and uniprocessor x86 io-apic on in kern config. 
> > The acpi config is essential as we use part of it, the uniprocessor x86 io-apic
> > is there as a precaution and if the patch is more widely tested it may not be
> > required. Remove it if you want the patch in smp mode.
> > 
> > The apic timer ack is not needed if you do not have hard lockups and you can
> > solve the hard lockups by other means if you want to. I do not recommend kern
> > config of apic without io-apic for nforce2. The two work best together and if 
> > you use my apic timer ack delay patch then use my io-apic edge patch with it
> > for best results.
> > 
> > This version of the apic timer ack delay patch is not on by default. You need
> > to use a kernel argument at boot time to invoke it and there are two forms.
> > 
> > apic_tack=1
> > 
> > puts a small delay inline with the code. It is the reliable fallback mode.
> > 
> > apic_tack=2
> > 
> > reads the apic timer count and only delays if needed to prevent a lockup. This
> > mode assumes it is always safe to read the apic timer count register but 
> > unsafe at times to ack it. This assumption could be wrong.
> > 
> > I find apic_tack=1 better at stopping hard lockups on my T/bred XP2200 
> > (266fsb DDR400 ram) system with my patched 2.4.23 kern but apic_tack=2 ok
> > with 2.6.0 on same machine? I also note 2.4.23 gives me 53Mb/s and 2.6.0 only
> > 47Mb/s with hdparm -t /dev/hda testing.
> > 
> >  Other kernel versions?
> > It should work fine with 2.4.22 and 2.4.23 although you will probably have to hand
> > patch them for now.
> > 
> >  Historical postings on the topic?
> > Heaps, many thanks to those who have tested and contributed so far.
> > Primary thread on this topic for my patches
> >  Fixes for nforce2 hard lockup, apic, io-apic, udma133 covered
> > and another useful discussion
> >  Catching NForce2 lockup with NMI watchdog
> > 
> >  Debugging output?
> > Ioapic patch always reports success or otherwise as part of check_timer if
> > it is needed such as:
> > ..TIMER: vector=0x31 pin1=2 pin2=-1
> > ..MP-BIOS bug: 8254 timer not connected to IO-APIC INTIN2
> > ..TIMER: Is timer irq0 connected to IO-APIC INTIN0? ...
> > IOAPIC[0]: Set PCI routing entry (2-0 -> 0x31 -> IRQ 0 Mode:0 Active:0)
> > ..TIMER: works OK on IO-APIC INTIN0 irq0
> > 
> > None for apic ackdelay apic_tack=0 or apic_tack=1
> >  
> > apic_tack=2 always reports:
> > ..APIC TIMER ack delay, reload:16701, safe:16691
> > 
> > but numbers vary with your fsb.
> > reload is your existing local timer 1ms reload count.
> > safe is the down count at which about 800ns has expired since reload. Patch
> > considers it safe to ack after that time.
> > 
> > More can be had if 
> > #define APIC_DEBUG 0 
> > is set to 1 in 
> > /usr/src/linux-2.4.23-rd2/include/asm-i386/apic.h 
> > 
> > The io-apic patch will also display the 8259a xtpic interrupt mask.
> > I get hex fb and hex ff indicating that the only int enabled on the 8259A xtpic
> > which handles irq 0-7 is the cascade irq 2 which is OK because on the other
> > 8259A irq 8-15 are masked. This masked xtpic should always be the case. 
> > We want the 8259A off during our test to see if the 8254 timer is connected
> > directly to pin 0 of the ioapic. 
> > 
> > The apic ack delay patch will report at boot ten pre delay apic timer times to
> > get a feel as to whether the delay had to kick in or not. Note that this is a 
> > very small sample size but it does give an idea of the timing numbers. 
> > 
> > Following are my apic and ioapic patches for 2.6.0.
> > bzip also attached.
> > 
> > Regards
> > Ross Dickson.
> > 
<snip>
