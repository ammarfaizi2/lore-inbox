Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264992AbSLTTmz>; Fri, 20 Dec 2002 14:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265177AbSLTTmz>; Fri, 20 Dec 2002 14:42:55 -0500
Received: from palrel10.hp.com ([156.153.255.245]:35049 "HELO palrel10.hp.com")
	by vger.kernel.org with SMTP id <S264992AbSLTTmt>;
	Fri, 20 Dec 2002 14:42:49 -0500
Date: Fri, 20 Dec 2002 11:50:31 -0800
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: mj@ucw.cz, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       turukawa@icc.melco.co.jp, ink@jurassic.park.msu.ru,
       torvalds@transmeta.com, grundler@cup.hp.com
Subject: Re: PATCH 2.5.x disable BAR when sizing
Message-ID: <20021220195031.GC21823@cup.hp.com>
References: <20021219213712.0518B12CB2@debian.cup.hp.com> <1040352868.30778.12.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1040352868.30778.12.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
From: grundler@cup.hp.com (Grant Grundler)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2002 at 02:54:28AM +0000, Alan Cox wrote:
> Nothing says your memory can't be behind the bridge and you just turned
> memory access off. Whoops bang, game over.
> And yes this happens on some PC class systems.

ugh. very poor design.
Can someone send URL or old mail describing such a broken system?
(or point me at previous attempts to submit this patch?)

I'm not able to narrow down the search to a reasonable number
of useful keywords.


I agree the patch I posted isn't ready.
But I have a real problem to solve on real HW.

I've tried to catchup with lkml postings via an archive:

Linux Torvalds wrote:
| Think about it: if you move the BAR to high memory, you basically disable 
| only _that_ bar, and nothing else. You don't clobber any other associated 
| functions, or anything like that.

That's exactly the problem on ia64 - it does.
Could this also be a problem on i386 that we just haven't noticed yet?

Original problem report says:
> In this case, the video device gets 64MB memory space from 0xFC000000 to 
> 0xFFFFFFFF improperly, and it conflicts with System reserve region
> (0xFCxxxxxx - 0xFExxxxxx) for SAPIC interrupt messages.
> After that the video device reacts to an SAPIC interrupt improperly.

(https://lists.linuxia64.org/archives//linux-ia64/2002-April/003302.html)

One of my boxes with serverworks chips + Foster CPU (1.6Ghz) also
has SAPIC and /proc/iomem shows:
...
fec00000-fec0ffff : reserved
fee00000-fee00fff : reserved
fff80000-ffffffff : reserved


and later:
| Ivan pointed out that it also disables things like VGA legacy registers. 

I expect disabling VGA is only a problem for debugging PCI code.
Is that the only thing that outputs for the duration we have things disabled?
Anyway, I've been there (debugging code crashes the box) and don't want
to go there again.

| It will disable IDE legacy registers too, btw. I'd also expect it to 
| disable IDE DMA access, so if you happen to be trying to probe the BAR's 
| after somebody started IO on the IDE, you just made that IO fail 
| spectacularly, and I'd not be surprised if the IDE controller just locked 
| up as a result. 

We aren't clearing PCI_COMMAND_MASTER.
I would expect DMA to continue working.
But some chip sets could be broken in this way too...


| Let me re-iterate the "turn power off at the master switch in a house when 
| switching a light bulb" analogy. Yes, it's a good idea if you are nervous, 
| but you do that only when you _know_ who is in the house and you know what 
| they are doing and it's ok by them. 

The PCI subsystem does know "who is in the house and what they are doing".
We currently never probe active devices. PCI bridges complicate the
picture since the definition of "active" has to include downstream devices.
I would like to determine "active" (or a reasonable approximation)
and only disable PCI_COMMAND_IO/PCI_COMMAND_MEMORY when it's clearly
safe to do so. I'll resubmit if I can figure out an appropriate test.


Ivan Kokshaysky wrote:
| I don't think that generic BAR probing is ever avoidable - too often 
| it's the only way to build a consistent resource tree. Without that 
| the driver cannot know whether the BAR setting is safe or there is a 
| conflict with something else. 

I agree.

| Anyway, in the short term we could give the architecture ability to use its 
| own probing code, something like this: 

An arch specific hook might be useful.
But how about letting the arch decide if it's safe to disable a device?
ie don't replicate the rest of the code in pci_read_bases() in
the arch that needs to disable the device.
It's very similar to what Ivan proposed.

thanks,
grant
