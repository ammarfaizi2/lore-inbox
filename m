Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263704AbUDMT1q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 15:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263707AbUDMT1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 15:27:46 -0400
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:12277 "EHLO
	mail.kroptech.com") by vger.kernel.org with ESMTP id S263704AbUDMT1f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 15:27:35 -0400
Date: Tue, 13 Apr 2004 15:48:32 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Chris Lalancette <chris.lalancette@gd-ais.com>
Cc: pmarques@grupopie.com, linux-kernel@vger.kernel.org
Subject: Re: Memory image save/restore
Message-ID: <20040413154832.A20467@mail.kroptech.com>
References: <407C18D0.9010302@gd-ais.com> <407C1D4F.4060706@grupopie.com> <407C2FF7.4010500@gd-ais.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <407C2FF7.4010500@gd-ais.com>; from chris.lalancette@gd-ais.com on Tue, Apr 13, 2004 at 02:22:47PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2004 at 02:22:47PM -0400, Chris Lalancette wrote:
> Paulo,
>     Thanks for responding.  You are right in that the state of memory 
> isn't the state of the entire machine; however, for instance, the 
> swsusp2 project can save the contents of memory out to disk, go to 
> sleep, and then resume to it later.

You're forgetting an important step. swsusp does not just haul off and
save the contents of memory. It has to quiesce the entire system first
by getting all hardware devices into a known state. THAT is the tricky
bit, with deadlock lurking around every corner.

> Basically, what I am trying to do 
> is something like swsusp2, with less restrictions; I know I have another 
> region the size of physical memory to work with, I know I am executing 
> from an interrupt handler, and at the end I don't want to go to sleep, 
> just continue on.

That's relatively easy.

> Then I might want to use that memory image later.

That's hard. REALLY, REALLY hard. Impossibly hard.

Make no mistake about it: You need to save and restore HARDWARE state as
well as software state (i.e. RAM image). The only practical way to do
that is to quiesce the system before you snapshot it. Your case is even
harder because you essentially want to revert to a previous point in time.
That means reverting fun things like your disk images (since the layout
of the data in your filesystem no longer matches what's in your outdated
RAM image) and how are you going to suck all those tx'ed network packets
back off the wire, anyway?

Your "simplifications" are really complexifications.

--Adam


> pmarques@grupopie.com wrote:
> 
> > Chris Lalancette wrote:
> >
> >> Hello all,
> >>
> >>    I have been trying to implement some sort of save/restore kernel 
> >> memory image for the linux kernel (x86 only right now), without much 
> >> success.  Let me explain the situation:
> >>
> >> I have a hardware device that I can generate interrupts with.  I also 
> >> have a machine with 512M of memory, and I am passing the kernel the 
> >> command line mem=256M.  My idea is to generate an interrupt with the 
> >> hardware device, and then inside of the interrupt handler make a copy 
> >> of the entire contents of RAM into the unused upper 256M of memory; 
> >> later on, with another interrupt, I would like to restore that 
> >> previously saved memory image.  This way we can go "back in time", 
> >> similar to what software suspend is doing, but without as many 
> >> constraints (i.e. we have a hardware interrupt to work with, we 
> >> reserved the same amount of physical memory to use, etc.).  Before I 
> >> went much further, I figured I would ask if anyone on the list has 
> >> tried this, and if there are any reasons why this is not possible.
> >
> >
> > You're assuming that the state of the memory is the *state* of the 
> > entire system.
> >
> > This fails because there is a lot of state information in hardware 
> > registers, external peripheral devices, etc., etc.
> >
