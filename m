Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030195AbVJEROX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030195AbVJEROX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 13:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030267AbVJEROX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 13:14:23 -0400
Received: from xproxy.gmail.com ([66.249.82.203]:37357 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030195AbVJEROW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 13:14:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aDFLOisso0Mpwl79qzVo0hELvMQuo/VjjKB8Sr58qNzClLeSM/UI8Pq0L5FV2DWKTLCgNpDukbR4e+f+IJ7431y95o7GOoSJXBLyJqbJBHK3los56Ocn2lxQumvMkMd0tL58oiP4ru3Kteig1sac9bkzu2JrFdZB/DrW6hztGUM=
Message-ID: <5bdc1c8b0510051014q3bb02d5bl80d2c88cc884fe35@mail.gmail.com>
Date: Wed, 5 Oct 2005 10:14:19 -0700
From: Mark Knecht <markknecht@gmail.com>
Reply-To: Mark Knecht <markknecht@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.14-rc3-rt2
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051005105605.GA27075@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051004084405.GA24296@elte.hu> <43427AD9.9060104@cybsft.com>
	 <20051004130009.GB31466@elte.hu>
	 <5bdc1c8b0510040944q233f14e6g17d53963a4496c1f@mail.gmail.com>
	 <5bdc1c8b0510041111n188b8e14lf5a1398406d30ec4@mail.gmail.com>
	 <1128450029.13057.60.camel@tglx.tec.linutronix.de>
	 <5bdc1c8b0510041158m3620f5dcy2dafda545ad3cd5e@mail.gmail.com>
	 <1128458707.13057.68.camel@tglx.tec.linutronix.de>
	 <5bdc1c8b0510041349g1a4f2484qd17a11812c8ccac3@mail.gmail.com>
	 <20051005105605.GA27075@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/05, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Mark Knecht <markknecht@gmail.com> wrote:
>
> > On 10/4/05, Thomas Gleixner <tglx@linutronix.de> wrote:
> > > On Tue, 2005-10-04 at 11:58 -0700, Mark Knecht wrote:
> > > > > I guess its related to the priority leak I'm tracking down right now.
> > > > > Can you please set following config options and check if you get a bug
> > > > > similar to this ?
> > > > >
> > > > > BUG: init/1: leaked RT prio 98 (116)?
> > > > >
> > > > > Steven, it goes away when deadlock detection is enabled. Any pointers
> > >
> > > Thats actually a red hering caused by asymetric accounting which only
> > > happens when
> > >
> > > CONFIG_DEBUG_PREEMPT=y
> > > and
> > > # CONFIG_RT_DEADLOCK_DETECT is not set
> >
> > OK. I'll keep testing then.
> >
> > Are you asking me to apply the code you sent or is that for someone
> > else?
>
> could you try the -rt8 kernel, with the same .config that previously
> produced those messages - do the messages still occur?
>
>         Ingo
>

Hi Ingo,
   By the time I go there it was already -rt9. Unfortunately I still
get the same message. Possibly the continued discussion is addressing
this? I haven't tried to read it all yet.

>From dmesg:

PCI: Using configuration type 1
PCI: Using MMCONFIG at e0000000
ACPI: Subsystem revision 20050902
BUG: swapper/1: spin-unlock irq flags assymetry?

Call Trace:<ffffffff80400d19>{_spin_unlock_irqrestore+89}
<ffffffff802694d6>{acpi_ev_create_gpe_block+642}
       <ffffffff80263116>{acpi_os_wait_semaphore+135}
<ffffffff80269682>{acpi_ev_gpe_initialize+109}
       <ffffffff80266cac>{acpi_ev_initialize_events+151}
<ffffffff802790a2>{acpi_enable_subsystem+69}
       <ffffffff806086de>{acpi_init+86} <ffffffff80604cda>{init_bio+266}
       <ffffffff8010b25a>{init+506} <ffffffff8010ed16>{child_rip+8}
       <ffffffff8010b060>{init+0} <ffffffff8010ed0e>{child_rip+0}

---------------------------
| preempt count: 00000000 ]
| 0-level deep critical section nesting:
----------------------------------------

WARNING: swapper/1 changed soft IRQ-flags.

Call Trace:<ffffffff8015336a>{local_irq_enable+26}
<ffffffff80400d25>{_spin_unlock_irqrestore+101}
       <ffffffff802694d6>{acpi_ev_create_gpe_block+642}
<ffffffff80263116>{acpi_os_wait_semaphore+135}
       <ffffffff80269682>{acpi_ev_gpe_initialize+109}
<ffffffff80266cac>{acpi_ev_initialize_events+151}
       <ffffffff802790a2>{acpi_enable_subsystem+69}
<ffffffff806086de>{acpi_init+86}
       <ffffffff80604cda>{init_bio+266} <ffffffff8010b25a>{init+506}
       <ffffffff8010ed16>{child_rip+8} <ffffffff8010b060>{init+0}
       <ffffffff8010ed0e>{child_rip+0}
---------------------------
| preempt count: 00000000 ]
| 0-level deep critical section nesting:
----------------------------------------

ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Transparent bridge - 0000:00:09.0

mark@lightning ~ $ uname -a
Linux lightning 2.6.14-rc3-rt9 #1 SMP PREEMPT Wed Oct 5 09:16:16 PDT
2005 x86_64 AMD Athlon(tm) 64 Processor 3000+ AuthenticAMD GNU/Linux
mark@lightning ~ $

   The previous -rt7 kernel, even with this message, has been the best
one I've tested so far on this machine, at least for my work load.
I'll test -rt9 more starting now and will watch this thread for any
instructions or requests.

   If you want or need my current config file let me know.

Cheers,
Mark
