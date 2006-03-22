Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751206AbWCVQvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbWCVQvm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 11:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWCVQvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 11:51:42 -0500
Received: from cantor2.suse.de ([195.135.220.15]:7057 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751206AbWCVQvl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 11:51:41 -0500
From: Andi Kleen <ak@suse.de>
To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
Subject: Re: libata/sata_nv latency on NVIDIA CK804 [was Re: AMD64 X2 lost ticks on PM timer]
Date: Wed, 22 Mar 2006 17:09:08 +0100
User-Agent: KMail/1.9.1
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Lee Revell <rlrevell@joe-job.com>, Jeff Garzik <jeff@garzik.org>,
       Jason Baron <jbaron@redhat.com>, linux-kernel@vger.kernel.org,
       john stultz <johnstul@us.ibm.com>
References: <200602280022.40769.darkray@ic3man.com> <1142522019.13318.27.camel@localhost.localdomain> <20060316165737.GA23248@ti64.telemetry-investments.com>
In-Reply-To: <20060316165737.GA23248@ti64.telemetry-investments.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603221709.09846.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 March 2006 17:57, Bill Rugolsky Jr. wrote:
> On Thu, Mar 16, 2006 at 03:13:39PM +0000, Alan Cox wrote:
> > On Mer, 2006-03-15 at 23:00 +0100, Ingo Molnar wrote:
> > > so my guess would be that this device doesnt do MMIO, and the PIO inb() 
> > > causes some bad BIOS-based SMM handler/emulator to trigger, which takes 
> > > 16.6 msecs. If indeed the device is not in MMIO mode, is there a way to 
> > > force it into MMIO mode, to test this theory?
> > 
> > There is a much more reliable way to check this. Use the profiling
> > registers to check the instruction issue count before/after the I/O and
> > you'll know if its something like SMM or just a bus stall.
> 
> 
> Brilliant [as usual 8-)].
> 
> 
> So I imagine that the thing to do is just insert before/after
> rdmsr(MSR_K7_PERFCTR[0123]) into the code, with a suitable printk(),
> and then program the counters with oprofile to use large event
> counts (lasting seconds)? 


perfctr0 is already programmed. You can just use rdpmc on it

Also my latest patchkit has a debugging patch for lost tries

ftp://ftp.firstfloor.org/pub/ak/x86_64/quilt/patches/lost-cli-debug

Can you test it with this patch? 

I'm still not quite convinced you're barking at the right tree
with these latency traces because it doesn't match the symptoms.

If some particular critical section would take too long the 
interrupt should occur at its STI or POPF or one instruction after it. 
But they happen on STIs that are not related to any critical section. 
This more looks like a lost CLI to me.

>   <idle>-0     0dns. 1855us : _spin_unlock_irqrestore (blk_run_queue)

This is very long, but still less than a tick (assuming HZ=250) 
I guess it would be a good idea to add some code to split this up
though and enable interrupts more often, but that probably won't fix 
your problem.

-Andi
