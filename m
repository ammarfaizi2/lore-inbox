Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263486AbUBHLlR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 06:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263491AbUBHLlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 06:41:17 -0500
Received: from gizmo12ps.bigpond.com ([144.140.71.22]:31450 "HELO
	gizmo12ps.bigpond.com") by vger.kernel.org with SMTP
	id S263486AbUBHLlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 06:41:08 -0500
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: Jamie Lokier <jamie@shareable.org>
Subject: Re: Nforce2 apic timer ack delay
Date: Sun, 8 Feb 2004 21:41:09 +1000
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org, Ian Kumlien <pomac@vapor.com>,
       Jesse Allen <the3dfxdude@hotmail.com>
References: <200312211917.05928.ross@datscreative.com.au> <20040207145544.GC17015@mail.shareable.org>
In-Reply-To: <20040207145544.GC17015@mail.shareable.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402082141.09693.ross@datscreative.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 08 February 2004 00:55, Jamie Lokier wrote:
> Ross Dickson wrote:
> > a) The Nforce2 DASP speculates and gets it right, pre-fetching the
> > code for the local apic timer interrupt, so the interrupt code
> > executes sooner after activation than it does with other chipsets
> > for AMD.
> > 
> > b) The AMD cpu may not be over its timing and stability issues when
> > coming out of C1 disconnect. Plenty stable soon enough for other
> > chipsets and other codepaths in linux which pull the cpu out of C1
> > disconnect, but not quite soon enough for the "cached" short code
> > path to the local apic timer ack. So most of the time any latent
> > lockup potential is not realised, but on occasion we hit it.
> 
> Ross,
> 
> Is the AMD C1 Disconnect state only entered when the CPU is idle, as in a
> "hlt" instruction?

Yes that is how I read the Athlon data sheet. It also needs the disconnect bit
set in the Northbridge.

> 
> If it is, we could set a flag just before the "hlt" instruction in the
> idle task and clear it afterwards.  If the flag is set, the interrupt
> path could clear the flag and do the delay thing.  Then you could use
> a longer, safe delay, and have it in the generic intrrupt path not
> just the local apic timer.  A delay coming out of the idle state is no
> big deal.
> 
> -- Jamie
> 
> 
> 

Great Idea and I think well worth trying but...

I just tried booting with "idle=poll" and without my apic_tack arg
which to my understanding should avoid using the hlt instruction. I know
my system has the disconnect bit set by the bios.
I was just writing you to tell you how well it prevented lockups when my system
experienced a hard lockup in a slightly different form. Firstly mplayer bailed
complaining about misuse of cpu ram etc, which is an abnormal failure for
this system. I then swapped desktops back to continue my email and then 
no mouse or anything else just like one of the original hard lockups.
A bit early to draw conclusions but could it be that the bios also executes
a hlt instruction in a System Management Interrupt?? Perhaps on detecting a 
hot cpu or something??

Other info I have uncovered which I think disproves my above theory:

I earlier decided to try some more things with my apic ack delay patch and found
that it was still able to prevent the lockups on my system when moved to the end
of the  smp_apic_timer_interrupt()????, way after the apic ack????
At least this is so on my preempt lowlat vhz64 1000hz 2.4.24 kernel.

What this tells me is that on an nforce2 system if the smp_apic_timer_interrupt()
routine completes execution in under about 1us time since the hardware
interrupt occurred then the system can (will?) hard lock-up.
Why?

I also altered the CLK_Ctl MSR bits along the lines of changes since model 4 
Athlon and found nothing useful - they appear to me to be already optimised
on my model 8 cpu.

Regards
Ross.
