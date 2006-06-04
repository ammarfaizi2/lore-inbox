Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932309AbWFDXPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbWFDXPm (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 19:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932310AbWFDXPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 19:15:42 -0400
Received: from smtp.ono.com ([62.42.230.12]:36168 "EHLO resmta03.ono.com")
	by vger.kernel.org with ESMTP id S932309AbWFDXPl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 19:15:41 -0400
Date: Mon, 5 Jun 2006 01:15:31 +0200
From: "J.A. =?UTF-8?B?TWFnYWxsw7Nu?=" <jamagallon@ono.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm3
Message-ID: <20060605011531.0bfe67db@werewolf.auna.net>
In-Reply-To: <20060603232004.68c4e1e3.akpm@osdl.org>
References: <20060603232004.68c4e1e3.akpm@osdl.org>
X-Mailer: Sylpheed-Claws 2.2.0cvs79 (GTK+ 2.9.1; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Jun 2006 23:20:04 -0700, Andrew Morton <akpm@osdl.org> wrote:

> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm3/
> 
> - Lots of PCI and USB updates
> 
> - The various lock validator, stack backtracing and IRQ management problems
>   are converging, but we're not quite there yet.
> 

Got this on boot. Looks like another locking bug in firewire:

ACPI: PCI Interrupt 0000:03:03.0[A] -> GSI 20 (level, low) -> IRQ 20
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[20]  MMIO=[ec024000-ec0247ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
stopped custom tracer.

============================
[ BUG: illegal lock usage! ]
----------------------------
illegal {hardirq-on-W} -> {in-hardirq-R} usage.
idle/0 [HC1[1]:SC1[0]:HE0:SE0] takes:
 (hl_irqs_lock){--+.}, at: [<f8835cb9>] highlevel_host_reset+0x11/0x5b [ieee1394]
{hardirq-on-W} state was registered at:
  [<c0133fe4>] lockdep_acquire+0x4d/0x63
  [<c02f3421>] _write_lock+0x2e/0x3b
  [<f88365ab>] hpsb_register_highlevel+0xac/0xea [ieee1394]
  [<f8836d6a>] init_csr+0x28/0x3f [ieee1394]
  [<f880617d>] 0xf880617d
  [<c01398df>] sys_init_module+0x12a/0x1b7b
  [<c02f3b2d>] sysenter_past_esp+0x56/0x8d
irq event stamp: 258193
hardirqs last  enabled at (258192): [<c011fab5>] __do_softirq+0x67/0xf7
hardirqs last disabled at (258193): [<c0102eb7>] common_interrupt+0x1b/0x2c
softirqs last  enabled at (258186): [<c011fb34>] __do_softirq+0xe6/0xf7
softirqs last disabled at (258191): [<c0104cec>] do_softirq+0x5a/0xc9

other info that might help us debug this:
no locks held by idle/0.

stack backtrace:
 [<c01034ba>] show_trace+0x12/0x14
 [<c0103b8d>] dump_stack+0x19/0x1b
 [<c0132025>] print_usage_bug+0x20b/0x215
 [<c01329cc>] mark_lock+0x4fa/0x5b4
 [<c0133399>] __lockdep_acquire+0x310/0xbc0
 [<c0133fe4>] lockdep_acquire+0x4d/0x63
 [<c02f3153>] _read_lock+0x2e/0x3b
 [<f8835cb9>] highlevel_host_reset+0x11/0x5b [ieee1394]
 [<f8833867>] hpsb_selfid_complete+0x286/0x307 [ieee1394]
 [<f884ec30>] ohci_irq_handler+0x6c9/0x995 [ohci1394]
 [<c013d3a2>] handle_IRQ_event+0x2e/0x63
 [<c013e4c3>] handle_fasteoi_irq+0x6b/0xac
 [<c0104dc7>] do_IRQ+0x6c/0xa5
 =======================
 [<c0102ec1>] common_interrupt+0x25/0x2c
 [<c0104cec>] do_softirq+0x5a/0xc9
 =======================
 [<c011fb90>] irq_exit+0x4b/0x4d
 [<c0104dce>] do_IRQ+0x73/0xa5
 [<c0102ec1>] common_interrupt+0x25/0x2c
 [<c010164e>] cpu_idle+0x63/0x80
 [<c0100599>] rest_init+0x33/0x3a
 [<c03d97af>] start_kernel+0x339/0x3aa
 [<c0100210>] 0xc0100210
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00e018000063814f]

--
J.A. Magallon <jamagallon()ono!com>     \               Software is like sex:
                                         \         It's better when it's free
Mandriva Linux release 2007.0 (Cooker) for i586
Linux 2.6.16-jam18 (gcc 4.1.1 20060518 (prerelease)) #2 SMP PREEMPT Mon
