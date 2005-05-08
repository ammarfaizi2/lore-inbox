Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262866AbVEHNkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262866AbVEHNkr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 09:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262869AbVEHNkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 09:40:46 -0400
Received: from mx1.suse.de ([195.135.220.2]:48007 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262866AbVEHNkg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 09:40:36 -0400
Date: Sun, 8 May 2005 15:40:35 +0200
From: Andi Kleen <ak@suse.de>
To: Bernd Paysan <bernd.paysan@gmx.de>
Cc: suse-amd64@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [suse-amd64] False "lost ticks" on dual-Opteron system (=> timer twice as fast)
Message-ID: <20050508134035.GC15724@wotan.suse.de>
References: <200505081445.26663.bernd.paysan@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505081445.26663.bernd.paysan@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 08, 2005 at 02:45:20PM +0200, Bernd Paysan wrote:
> Hi,
> 
> I've recently set up a dual Opteron RAID server (AMD-8000-based Tyan 
> Thunder K8S Pro SCSI board, 2 246 Opterons, stepping 10). Kernel is a 
> modified 2.6.11.4-20a from SuSE 9.3 (SMP version, sure). The Opterons 
> are capable of changing the CPU frequency (between 1GHz and 2GHz).

Your system should be using the HPET timer to work exactly around
this. AMD 8000 has HPET. Can you post a boot.log?

> 
> The system clock runs (on average) about twice as fast as it should be. 
> A closer observation revealed that the clock jumps forward by about 
> 10-30 seconds every 10-30 seconds (plus other oddities, including 
> backward clock jumps). The timer interrupts are distributed roughly 
> evenly among the two CPUs, but looking at the timer interrupt number 
> (grep timer /proc/interrupts) revealed that for about 10-30 seconds, 
> one CPU gets the interrupt, and then the other CPU gets them; the 
> transition causes the system clock to advance.
> 
> A quick look at timer_interrupt shows what I suspect is the culprit: 
> Each CPU keeps track of the last TSC at a timer interrupt, and adds the 

No, it doesn't. TSC is kept only globally right now.  Obviously
that is problem if the TSCs run at different frequencies (it actually
is a problem even without powernow, just a much smaller one), but
that is why HPET is used instead.

There are some plans to change that in the future, but it hasn't 
happened yet.

> "lost" ticks to jiffies when perceived necessary. If there's only a 
> single jiffies, but two vxtime.last_tsc, it can't work.
> 
> A quick workaround would be to ditch the handling of the "lost" jiffies. 
> I still anticipate to have annoying time skews by do_gettimeoffset() 
> (that's what explains the other oddities - if I do gettimeofday() on 
> the CPU that isn't getting interrupts, I'll going to add the "lost" 
> jiffies, too). A proposed fix would be to *also* store the last jiffies 
> value in the vxtime variable, and verify if it's really *this* CPU that 
> did miss the timer interrupts. This local "last-stored-jiffies" can 
> help do_gettimeoffset() to calculate the local time good enough on both 
> CPUs.

The current design is that only the BP runs the main timer, and the other
CPUs use the APIC timer and don't do any own time keeping. I think you
misread the code quite a bit.

And lost jiffie handling can't be dropped no.

A common problem however is that the irq 0 is misrouted somehow,
and gets broadcasted and processed on multiple CPUs. That results
in the time running far too fast. You can check that by looking
at /proc/interrupts.

-Andi
