Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261335AbULMXfR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbULMXfR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 18:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbULMXfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 18:35:16 -0500
Received: from smtp2.Stanford.EDU ([171.67.16.125]:58591 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S261335AbULMXfA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 18:35:00 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-12
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, Rui Nuno Capela <rncbc@rncbc.org>,
       LKML <linux-kernel@vger.kernel.org>, Lee Revell <rlrevell@joe-job.com>,
       Mark Johnson <Mark_H_Johnson@RAYTHEON.COM>,
       "K.R. Foley" <kr@cybsft.com>, Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>, emann@mrv.com,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
In-Reply-To: <1102768203.3480.6.camel@localhost.localdomain>
References: <32950.192.168.1.5.1102529664.squirrel@192.168.1.5>
	 <1102532625.25841.327.camel@localhost.localdomain>
	 <32788.192.168.1.5.1102541960.squirrel@192.168.1.5>
	 <1102543904.25841.356.camel@localhost.localdomain>
	 <20041209093211.GC14516@elte.hu> <20041209131317.GA31573@elte.hu>
	 <1102602829.25841.393.camel@localhost.localdomain>
	 <1102619992.3882.9.camel@localhost.localdomain>
	 <20041209221021.GF14194@elte.hu>
	 <1102659089.3236.11.camel@localhost.localdomain>
	 <20041210111105.GB6855@elte.hu>
	 <1102731973.3228.8.camel@localhost.localdomain>
	 <1102750669.32041.8.camel@cmn37.stanford.edu>
	 <1102768203.3480.6.camel@localhost.localdomain>
Content-Type: text/plain
Organization: 
Message-Id: <1102980859.10968.691.camel@cmn37.stanford.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 13 Dec 2004 15:34:19 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-12-11 at 04:30, Steven Rostedt wrote:
> On Fri, 2004-12-10 at 23:37 -0800, Fernando Lopez-Lezcano wrote:
> > Can't wait to try the patch, I don't have CONFI_PCI_MSI defined in the
> > configurations I use. I've had problems with a network card (R8169
> > driver) for a while (I think I reported it), the interrupts were being
> > ignored. Hopefully the same problem...
>
> You may have the same problem but the patch I sent won't solve it.  My
> patch only is a problem if you have CONFIG_PCI_MSI defined. But I'm sure
> there exists other instances that threading hardirqs might not work
> properly with other configurations. Send me your .config, and if I get
> time I'll take a look. (also your /proc/cpuinfo might help).
> 
> Before you send this, make sure that it is the hardirqs that's the
> problem. Switch to PREEMPT_DESKTOP and make sure hardirqs are not
> threaded.

[The following is all done booting into 0.7.32-19, interrupt scheduling
and priorities unchanged from the defaults]

I'm using PREEMPT_DESKTOP. I don't know how to force the kernel to not
thread hardirqs. What I did (maybe the same thing?) is to boot single
user, then turn off /proc/sys/kernel/hardirq_preempt, and then start the
network. It works (the network). And then I tried the same thing with
hardirq_preempt=1 and still worked when booting single user... :-(

So, these are the interrupts after booting single user:
           CPU0       
  0:      36426    IO-APIC-edge  timer  0/35956
  1:        143    IO-APIC-edge  i8042  0/143
  4:          0    IO-APIC-edge  KGDB-stub  0/0
  8:          1    IO-APIC-edge  rtc  0/1
  9:          0   IO-APIC-level  acpi  0/0
 12:        100    IO-APIC-edge  i8042  0/100
 14:         26    IO-APIC-edge  ide0  1/24
 17:         59   IO-APIC-level  libata, libata  0/59
 20:       1462   IO-APIC-level  libata  0/1462
 21:          0   IO-APIC-level  ehci_hcd, uhci_hcd, uhci_hcd, uhci_hcd,
uhci_hcd  0/0
NMI:       7544 
LOC:      36254 
ERR:          0
MIS:          0

Here's the extra one I have after I start the network

 16:          7   IO-APIC-level  eth0  0/7

(network works). I then telinit 3, no changes in interrupts (except for
the count numbers), network continues working. 

I then telinit 5 and the network dies. This is the added interrupt:

 11:          0    IO-APIC-edge  radeon@PCI:1:0:0  0/0

I tried repeating the whole thing but going through all the services in
the transition from level 3 to level 5 one by one, and nothing happened
to the network so it must be X. I then rebooted into single user,
started the network and loaded the radeon kernel module alone and the
network was not affected. 

So, this is what I get in dmesg when I go into level 5:

NET: Registered protocol family 10
Disabled Privacy Extensions on device c03e0ec0(lo)
IPv6 over IPv4 tunneling driver
divert: not allocating divert_blk for non-ethernet device sit0
eth0: no IPv6 routers present
[drm] Initialized radeon 1.11.0 20020828 on minor 0:
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V3 device at 0000:01:00.0 into 4x mode
[drm] Loading R200 Microcode
irq 16: nobody cared!
 [<c01041e3>] dump_stack+0x23/0x30 (20)
 [<c014d480>] __report_bad_irq+0x30/0xa0 (24)
 [<c014d590>] note_interrupt+0x70/0xb0 (32)
 [<c014d30c>] do_hardirq+0x13c/0x150 (40)
 [<c014d399>] do_irqd+0x79/0xb0 (32)
 [<c013bf7a>] kthread+0xaa/0xb0 (48)
 [<c0101335>] kernel_thread_helper+0x5/0x10 (153411604)
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c014d2aa>] .... do_hardirq+0xda/0x150
.....[<c014d399>] ..   ( <= do_irqd+0x79/0xb0)
.. [<c014045d>] .... print_traces+0x1d/0x60
.....[<c01041e3>] ..   ( <= dump_stack+0x23/0x30)
 
handlers:
[<f88e3f00>] (rtl8169_interrupt+0x0/0x1a0 [r8169])
Disabling IRQ #16

Anything else I could test?

> If the problem goes away, then this may be your problem. If
> it does not, I'm afraid that it's something else, and you don't need to
> send me anything.

Let me know if you still want the .config...
-- Fernando


