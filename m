Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261830AbVHDO3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbVHDO3W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 10:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261738AbVHDO1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 10:27:14 -0400
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:29091 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261830AbVHDO0M convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 10:26:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:From:To:Subject:Date:User-Agent:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=gqJJFIX4jqjdelkdICVWIEXZmj54OxdJjXbueurheURLRfTmtQIHdnV2FZCK8uD5wb9p1FAFPX/wAVd1MphIpCTcGCoSOhxkBx6X56c26+mBRZcLHZPt+l4ji9EiQLZ7ysWAMs+16mqXhB7dcr0GI6PAlYSVX6AvQKEYGKFwQV8=  ;
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: [RFC] AMD64 @ K8T800/VT8237: Doubled IOAPIC-level-interrupt rate
Date: Thu, 4 Aug 2005 16:25:41 +0200
User-Agent: KMail/1.8.1
Cc: Ingo Molnar <mingo@elte.hu>, ak@suse.de
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200508041625.41296.annabellesgarden@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this should likely be addressed to VIA Taiwan,
but I don't know their engineer's e-mail address and their forum
doesn't work for me.
Maybe somebody here has a clue?
Or maybe this is even motherboard specific?

To reproduce:
	$ aplay -Dhw:0 -fdat /dev/zero

On a sane system (or here in PIC Mode) you'll see
around 12 Interrupts/s.
Here I see 24.

12 per s more is no big deal, but if you run low-latency audio,
the overhead becomes significant.

What exactly happens when i.e. the sounddevice (part of the VT8237)
triggers an interrupt (low level on interrupt pin) is this:

1. IOAPIC accepts interrupt, sends it to CPU's APIC.

2. Interrupt Routine runs,
   tells the sounddevice to deassert the interrupt pin.

3. When sounddevice deasserts pin (low to high transition),
   IOAPIC accepts an interrupt _again_ , tells APIC,
   which also accepts interrupt again (IRR-Bit set).
   _This should not happen_.
   Looks like the IOAPIC (Part of the VT8237) behaves like
   Level Triggered _AND_ Edge Triggered at once!?!

3. Interrupt Routine finishes with sending EOI to the CPU's APIC,
   which tells IOAPIC to accept Interrupts on the soundcards interrupt
   pin _now_.
   But the IOAPIC has already wrongly accepted the next interupt
   in step 2.

4. Processor accepts interrupts again and runs the soundcards
   interruptroutine again.
   Now the interrupt Routine sees a soundcard that doesn't need
   servicing and finishes, having done nothing,
   but clearing up the APIC/IOAPIC.
 
This bad behavior can be eliminated by masking the IOAPIC's interrupt pin
during the phase where the sounddevice's interrupt pin is deasserted.
But (Un)masking is also a cycle-costly operation,
which shouldn't be necessary on a sane system.

So my question here is:
Can the VT8237's IOAPIC (or other device) be programmed in a way
to behave sanely?
Or is this a known bug that can only be circumvented?
If it was an Intel/AMD chipsets I'd likely find those info's
in publicly available docs, but here the problem for me is
to get the docs...
(Or WTF do I buy stuff, which comes without public docs $%§!!grmbl!)

Thanks,
Karsten

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
