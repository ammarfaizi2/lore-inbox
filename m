Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261806AbVGMABy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbVGMABy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 20:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262189AbVGMABx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 20:01:53 -0400
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:41897 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261806AbVGMABt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 20:01:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=lCrEv4JlBbAQqOn4q3bTrjauvGXxizynvV/0EOrrlkuoE8u7ykK49MTM17mjYbDf/fe8X0TYadfcv3RE2iqGGY50Ympn6BkNiZqxeukMDBkCmNQo9OwMXSQwGAQGGuWWHZZk8ZJWB6hV0A1n4TY5/oHCwqKngtLKZMDNO04naEU=  ;
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: Daniel Walker <dwalker@mvista.com>
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-24
Date: Wed, 13 Jul 2005 02:04:08 +0200
User-Agent: KMail/1.8.1
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
References: <200507121223.10704.annabellesgarden@yahoo.de> <20050712140251.GB18296@elte.hu> <1121178339.10199.8.camel@c-67-188-6-232.hsd1.ca.comcast.net>
In-Reply-To: <1121178339.10199.8.camel@c-67-188-6-232.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507130204.08824.annabellesgarden@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 12. Juli 2005 16:25 schrieb Daniel Walker:
> On Tue, 2005-07-12 at 16:02 +0200, Ingo Molnar wrote:
> > * Karsten Wiese <annabellesgarden@yahoo.de> wrote:
> > 
> > > Hi Ingo
> > > 
> > > I've refined io_apic.c a little more:
> > 
> > great. I've applied these changes and have released the -28 patch. (note 
> > that the last chunk of your patch was malformed, have applied it by 
> > hand.)
> > 
> > i'm wondering what your thoughts are about IOAPIC_POSTFLUSH - i had to 
> > turn it on unconditionally again, to get rid of spurious interrupts and 
> > outright interrupt storms (and resulting lockups) on some systems.  
> > IOAPIC_POSTFLUSH is now causing much of the IO-APIC related IRQ handling 
> > overhead.
> 
> I observed a situation on a dual xeon where IOAPIC_POSTFLUSH , if on,
> would actually cause spurious interrupts. It was odd cause it's suppose
> to stop them .. If there was a lot of interrupt traffic on one IRQ , it
> would cause interrupt traffic on another IRQ. This would result in
> "nobody cared" messages , and the storming IRQ line would get shutdown.
> 
> This would only happen in PREEMPT_RT .
> 
i've only tested on 2005ish Ahlon64_UP@k8T800: it doesn't need any of the quirks
  IOAPIC_POSTFLUSH, sis_bug, level-edge cleanup.
IOAPIC_POSTFLUSH caused no negative influence neither.
i've an io_apic_one.c here, that doesn't have any of the quirks and is stripped down
to handle just one ioapic. It runs just fine on PREEMPT_RT.
Could be used as a "Do i crash/suffer without the quirks?" test for 1 ioapic equipped machines.
Should i post it?

On vanilla level-interrupts behave "nervously" showing the "doubled rate" effect:
For level interrupts vanilla just sends an EOI to the apic. Nothing else should be necessary (io)apic wise.
Only here, when the edge-level triggered hardware-handler acknowledges its client
(== resets the interrupt line) the doubled level interrupt is triggered on the same pin.
Thus the same interrupt routine runs again as soon as EOI has been sent and IFlag is open again.
hardware-handler receives it, does nothing and returns with "uninterested" <<insert correct macro here<.
everything works correctly though. its just some cycles wasted.
Odd, no? I found that the correct interrupt handling can be achieve by obeying the PREEMPT_RT method:
	level-interrupt triggers
		ioapic pin is masked
			harware-handler deasserts pin/line
		apic gets eoi
		ioapic pin is unmasked
this could be optimized by ioapic caching , but there must be some configuration tweak......
that i don't know of. there are no via docs for me. erm.. anybody sends me a link _offlist_ ?-)
Or even _knows that tweak_ ?
And again IOAPIC_POSTFLUSH has no influence here on the doubled interrupt (VIA K8T800 only ?)
bug.

    Karsten

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
