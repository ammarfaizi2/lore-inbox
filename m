Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268237AbUILSOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268237AbUILSOp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 14:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268764AbUILSOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 14:14:45 -0400
Received: from zork.zork.net ([64.81.246.102]:60898 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S268237AbUILSOi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 14:14:38 -0400
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: jgarzik@pobox.com, akpm@osdl.org, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm4: r8169: irq 16: nobody cared!/TX Timeout
References: <6upt4s4cro.fsf@zork.zork.net>
	<20040912110614.GA20942@electric-eye.fr.zoreil.com>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: Francois Romieu <romieu@fr.zoreil.com>, jgarzik@pobox.com,
	akpm@osdl.org, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Date: Sun, 12 Sep 2004 19:14:28 +0100
In-Reply-To: <20040912110614.GA20942@electric-eye.fr.zoreil.com> (Francois
	Romieu's message of "Sun, 12 Sep 2004 13:06:15 +0200")
Message-ID: <6u8ybf2w3f.fsf@zork.zork.net>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: sneakums@zork.net
X-SA-Exim-Scanned: No (on zork.zork.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu <romieu@fr.zoreil.com> writes:

> Sean Neakums <sneakums@zork.net> :
> [r8169 irq delivery/Tx timeout issue]
>> I downed and upped the interface and it started working again.
>
> There is a gross error in the 2.6.9-rc1-mm4 version of the r8169 driver
> which could be related to your bug.
>
> A few patches have been posted on netdev amongst which the first should
> make things better (see [PATCH 2.6.9-rc1-mm4 x/4] on netdev the 10 of
> september 2004)
>
> Can you apply the patch below on top of 2.6.9-rc1-mm4 and report
> if it makes things better:
> http://www.fr.zoreil.com/linux/kernel/2.6.x/2.6.9-rc1-mm4/r8169/r8169-130.patch

Running 2.6.9-rc1-mm4 with the above patch.

I'm a bit unsure of the timing, but at some point I got this either
before or during the transfer I set up to get some Tx activity, a
repeated wget of a 35M file.

irq 10: nobody cared!
 [__report_bad_irq+36/144] __report_bad_irq+0x24/0x90
 [note_interrupt+146/352] note_interrupt+0x92/0x160
 [do_IRQ+354/416] do_IRQ+0x162/0x1a0
 [common_interrupt+24/32] common_interrupt+0x18/0x20
 [default_idle+0/64] default_idle+0x0/0x40
 [default_idle+44/64] default_idle+0x2c/0x40
 [cpu_idle+52/80] cpu_idle+0x34/0x50
 [start_kernel+347/384] start_kernel+0x15b/0x180
 [unknown_bootoption+0/368] unknown_bootoption+0x0/0x170
handlers:
[usb_hcd_irq+0/112] (usb_hcd_irq+0x0/0x70)
[usb_hcd_irq+0/112] (usb_hcd_irq+0x0/0x70)
Disabling IRQ #10

I killed the transfer and started X, getting this immediately:

irq 16: nobody cared!
 [__report_bad_irq+36/144] __report_bad_irq+0x24/0x90
 [note_interrupt+146/352] note_interrupt+0x92/0x160
 [do_IRQ+354/416] do_IRQ+0x162/0x1a0
 [common_interrupt+24/32] common_interrupt+0x18/0x20
 [default_idle+0/64] default_idle+0x0/0x40
 [default_idle+44/64] default_idle+0x2c/0x40
 [cpu_idle+52/80] cpu_idle+0x34/0x50
handlers:
[rtl8169_interrupt+0/464] (rtl8169_interrupt+0x0/0x1d0)
Disabling IRQ #16

This also happened during the originally-reported incident, which I
forgot to mention.  Both times, downing and then upping the interface
resulted in what seemed like a solid hang, although possibly it was
just X.

I rebooted and started X again, and again got the above.  If I boot
with acpi=noirq, I don't get that message upon starting X.  Here's
/proc/interrupts before and after starting X, without passing
acpi=noirq:

           CPU0       CPU1       
  0:      18810      52561    IO-APIC-edge  timer
  1:        142          8    IO-APIC-edge  i8042
  5:          0          0   IO-APIC-level  acpi
  8:          2          2    IO-APIC-edge  rtc
 10:       3651       3367   IO-APIC-level  uhci_hcd, uhci_hcd
 11:          0          0   IO-APIC-level  VIA686A
 14:          2         13    IO-APIC-edge  ide0
 16:         10          8   IO-APIC-level  eth2
 17:         12          7   IO-APIC-level  eth1
 19:       2989       2564   IO-APIC-level  aic7xxx
NMI:          0          0 
LOC:      71037      71036 
ERR:          0
MIS:          0

           CPU0       CPU1       
  0:      42718      64701    IO-APIC-edge  timer
  1:        247         33    IO-APIC-edge  i8042
  5:          0          0   IO-APIC-level  acpi
  8:          2          2    IO-APIC-edge  rtc
 10:       4928       3367   IO-APIC-level  uhci_hcd, uhci_hcd
 11:          0          0   IO-APIC-level  VIA686A, radeon@PCI:1:0:0
 14:          2         13    IO-APIC-edge  ide0
 16:         10      99990   IO-APIC-level  eth2
 17:         30          7   IO-APIC-level  eth1
 19:       3927       2564   IO-APIC-level  aic7xxx
NMI:          0          0 
LOC:     107084     107083 
ERR:          0
MIS:          0


I don't know if this is significant, but with acpi=noirq,
/proc/interrupts looks like this:


           CPU0       CPU1       
  0:     196902      25653    IO-APIC-edge  timer
  1:         64       1189    IO-APIC-edge  i8042
  2:          0          0          XT-PIC  cascade
  5:          0          0    IO-APIC-edge  acpi
  8:          2          2    IO-APIC-edge  rtc
  9:         93          4   IO-APIC-level  eth1
 10:       2438       4609   IO-APIC-level  aic7xxx, uhci_hcd, uhci_hcd
 11:         10      15775   IO-APIC-level  eth2, radeon@PCI:1:0:0
 12:          0          0   IO-APIC-level  VIA686A
 14:         10          5    IO-APIC-edge  ide0
NMI:          0          0 
LOC:     222226     222225 
ERR:          0
MIS:          0

eth2 being the 8169.

Unfortunately after tonight I won't have access to this machine until
Friday evening.  I'll grab the netdev patchset and try those next.
