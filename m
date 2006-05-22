Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbWEVV1l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbWEVV1l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 17:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWEVV1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 17:27:40 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:23772 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751204AbWEVV1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 17:27:39 -0400
Subject: Re: 2.6.16-rt22/23 kernels hanging after registering IO schedulers
From: Steven Rostedt <rostedt@goodmis.org>
To: Mark Knecht <markknecht@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Clark Williams <williams@redhat.com>,
       Robert Crocombe <rwcrocombe@raytheon.com>
In-Reply-To: <5bdc1c8b0605211410ld978047x3c4ad37ec79f5e8c@mail.gmail.com>
References: <5bdc1c8b0605191022l7114707fjd6b3cdcfe68b97c7@mail.gmail.com>
	 <Pine.LNX.4.58.0605211321400.28717@gandalf.stny.rr.com>
	 <5bdc1c8b0605211410ld978047x3c4ad37ec79f5e8c@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 22 May 2006 17:27:17 -0400
Message-Id: <1148333237.4997.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-05-21 at 14:10 -0700, Mark Knecht wrote:

> Hi Steve,
>    It's good to hear from you and great if you can take a look at
> this. I did some more ground work and now feel bad that I didn't
> report back much earlier. It appears that the problems have started
> with the very first revision of 2.6.16-rt support. I am currently
> writing you from 2.6.16 from kernel.org which booted fine. However
> 2.6.16-rt1 fails the same way as all the later kernels that I tried
> with a hang right after registering the schedulers.

You're getting farther than I am.  My system crashes in init_8259A right
in the unlocking of the i8259A_lock.  It takes an exception in the
local_irq_restore of the raw_spin_unlock_irqrestore.  I tried unlocking
the lock and locking it again at the beginning of the function, and that
seems to work fine.  But this function didn't change between the
previous versions that do work.  So I think something is very wacky
going on someplace else.

Unfortunately, I'm very behind in the work that I get paid for, so I
really don't have any more time to look into this.  Especially since my
main developing machine happens to be my x86_64.

Hopefully, Ingo can find something, or I catch up and can work on this
again.

-- Steve

Here's my dump:

...
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 80000000 (gap: 7ff00000:60100000)
Real-Time Preemption Support (C) 2004-2006 Ingo Molnar
Built 1 zonelists
Kernel command line: root=/dev/md0 ro console=ttyS0,115200 console=tty0
nmi_watm
Initializing CPU#0
WARNING: experimental RCU implementation.
PANIC: early exception rip 10 error ffffffff8034d270 cr2 f0aeaa

Call Trace:
       <ffffffff8034d270>{_raw_spin_unlock_irqrestore+32}
       <ffffffff80111582>{init_8259A+226}
       <ffffffff8093a935>{init_ISA_irqs+21}
       <ffffffff8093a9a2>{init_IRQ+18}
       <ffffffff809327f5>{start_kernel+213}
       <ffffffff80932293>{_sinittext+659}
RIP 0x10

> 
>    To try finding a place where the problem started I also tried
> 2.6.15-rt21 which was the last 2.6.15-rt kernel in the pro-audio
> overlay. That kernel works fine also so it seems to be something right
> at the beginning of the 2.6.16 series.
> 
>    If this could possibly be something in my .config files let me know
> and I'll try making changes directed by you or Ingo there.
> 
>    I hope this info might help you get to the problem a little more quickly.
> 
> Cheers,
> Mark

