Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbWG0Oob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbWG0Oob (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 10:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750705AbWG0Ooa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 10:44:30 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:54283 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750780AbWG0Oo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 10:44:29 -0400
Date: Thu, 27 Jul 2006 15:44:20 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: Arjan Van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Nicolas Pitre <nico@cam.org>
Subject: lockdep: fix smc91x
Message-ID: <20060727144420.GB5178@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Arjan Van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
	Nicolas Pitre <nico@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When booting using root-nfs, I'm seeing (independently) two lockdep dumps
in the smc91x driver.  The patch below fixes both.  Both dumps look like
real locking issues.

Nico - please review and ack if you think the patch is correct.

Dump 1:

Sending DHCP requests .
=================================
[ INFO: inconsistent lock state ]
---------------------------------
inconsistent {hardirq-on-W} -> {in-hardirq-W} usage.
swapper/0 [HC1[1]:SC0[0]:HE0:SE1] takes:
 (&lp->lock){+-..}, at: [<c0134cf8>] smc_interrupt+0x24/0x740
{hardirq-on-W} state was registered at:
  [<c005d0fc>] lock_acquire+0x80/0x94
  [<c01e0f70>] _spin_lock+0x30/0x40
  [<c01342bc>] smc_reset+0x2c/0x140
  [<c0135d74>] smc_drv_probe+0x288/0x720
  [<c0131b84>] platform_drv_probe+0x20/0x24
  [<c012fbc8>] driver_probe_device+0x8c/0xd4
  [<c012fd48>] __driver_attach+0x88/0xe8
  [<c012f000>] bus_for_each_dev+0x50/0x84
  [<c012fdc8>] driver_attach+0x20/0x28
  [<c012f5b8>] bus_add_driver+0x6c/0x138
  [<c01302a0>] driver_register+0x90/0xa0
  [<c0131c84>] platform_driver_register+0x6c/0x88
  [<c0015fe4>] smc_init+0x14/0x1c
  [<c002019c>] init+0x140/0x318
  [<c00423b8>] do_exit+0x0/0x83c
irq event stamp: 19510
hardirqs last  enabled at (19509): [<c0021aa4>] default_idle+0x40/0x4c
hardirqs last disabled at (19510): [<c0020a68>] __irq_svc+0x28/0xc0
softirqs last  enabled at (19504): [<c00454b8>] __do_softirq+0xf4/0x10c
softirqs last disabled at (19495): [<c0045798>] irq_exit+0x54/0x5c

other info that might help us debug this:
no locks held by swapper/0.

stack backtrace:
[<c0024ed0>] (dump_stack+0x0/0x14) from [<c005b258>] (print_usage_bug+0x19c/0x1f0)
[<c005b0bc>] (print_usage_bug+0x0/0x1f0) from [<c005b3a0>] (mark_lock+0xf4/0x5b8)
[<c005b2ac>] (mark_lock+0x0/0x5b8) from [<c005c358>] (__lock_acquire+0x50c/0xdd4)
 r8 = C021F520  r7 = C021F7DC  r6 = 00000000  r5 = C02B11F4
 r4 = 00000000
[<c005be4c>] (__lock_acquire+0x0/0xdd4) from [<c005d0fc>] (lock_acquire+0x80/0x94)
[<c005d07c>] (lock_acquire+0x0/0x94) from [<c01e0f70>] (_spin_lock+0x30/0x40)
[<c01e0f40>] (_spin_lock+0x0/0x40) from [<c0134cf8>] (smc_interrupt+0x24/0x740)
 r4 = C06EFB20
[<c0134cd4>] (smc_interrupt+0x0/0x740) from [<c0065878>] (handle_IRQ_event+0x34/0x6c)
[<c0065844>] (handle_IRQ_event+0x0/0x6c) from [<c0066af4>] (handle_level_irq+0xe8/0x158)
 r8 = C021BF48  r7 = C021D124  r6 = C06EFB20  r5 = 00000029
 r4 = C021D100
[<c0066a0c>] (handle_level_irq+0x0/0x158) from [<c00217f0>] (asm_do_IRQ+0x54/0x64)
 r8 = C001A680  r7 = 00008000  r6 = 00000029  r5 = F1100100
 r4 = C021D100
[<c002179c>] (asm_do_IRQ+0x0/0x64) from [<c0020a68>] (__irq_svc+0x28/0xc0)
 r4 = FFFFFFFF
[<c0021a64>] (default_idle+0x0/0x4c) from [<c0021b18>] (cpu_idle+0x68/0x88)
 r4 = C0021A64
[<c0021ab0>] (cpu_idle+0x0/0x88) from [<c0020028>] (__init_end+0x28/0x30)
 r5 = C0274DB4  r4 = C03AC520
[<c0020000>] (__init_end+0x0/0x30) from [<c0008aa0>] (start_kernel+0x270/0x2dc)
[<c0008830>] (start_kernel+0x0/0x2dc) from [<00008078>] (0x8078)
 r8 = 0001A078  r7 = C03C0328  r6 = C0220984  r5 = C0275240
 r4 = 00C5387D
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1

Dump 2:

Sending DHCP requests .
=================================
[ INFO: inconsistent lock state ]
---------------------------------
inconsistent {hardirq-on-W} -> {in-hardirq-W} usage.
swapper/0 [HC1[1]:SC0[0]:HE0:SE1] takes:
 (&lp->lock){+-..}, at: [<c0134cf8>] smc_interrupt+0x24/0x740
{hardirq-on-W} state was registered at:
  [<c005d0fc>] lock_acquire+0x80/0x94
  [<c01e0f70>] _spin_lock+0x30/0x40
  [<c0134474>] smc_shutdown+0x20/0x74
  [<c0135f74>] smc_drv_probe+0x488/0x720
  [<c0131b84>] platform_drv_probe+0x20/0x24
  [<c012fbc8>] driver_probe_device+0x8c/0xd4
  [<c012fd48>] __driver_attach+0x88/0xe8
  [<c012f000>] bus_for_each_dev+0x50/0x84
  [<c012fdc8>] driver_attach+0x20/0x28
  [<c012f5b8>] bus_add_driver+0x6c/0x138
  [<c01302a0>] driver_register+0x90/0xa0
  [<c0131c84>] platform_driver_register+0x6c/0x88
  [<c0015fe4>] smc_init+0x14/0x1c
  [<c002019c>] init+0x140/0x318
  [<c00423b8>] do_exit+0x0/0x83c
irq event stamp: 19304
hardirqs last  enabled at (19303): [<c0021aa4>] default_idle+0x40/0x4c
hardirqs last disabled at (19304): [<c0020a68>] __irq_svc+0x28/0xc0
softirqs last  enabled at (19298): [<c00454b8>] __do_softirq+0xf4/0x10c
softirqs last disabled at (19289): [<c0045798>] irq_exit+0x54/0x5c

other info that might help us debug this:
no locks held by swapper/0.

stack backtrace:
[<c0024ed0>] (dump_stack+0x0/0x14) from [<c005b258>] (print_usage_bug+0x19c/0x1f0)
[<c005b0bc>] (print_usage_bug+0x0/0x1f0) from [<c005b3a0>] (mark_lock+0xf4/0x5b8)
[<c005b2ac>] (mark_lock+0x0/0x5b8) from [<c005c358>] (__lock_acquire+0x50c/0xdd4)
 r8 = C021F520  r7 = C021F7DC  r6 = 00000000  r5 = C02B11F4
 r4 = 00000000
[<c005be4c>] (__lock_acquire+0x0/0xdd4) from [<c005d0fc>] (lock_acquire+0x80/0x94)
[<c005d07c>] (lock_acquire+0x0/0x94) from [<c01e0f70>] (_spin_lock+0x30/0x40)
[<c01e0f40>] (_spin_lock+0x0/0x40) from [<c0134cf8>] (smc_interrupt+0x24/0x740)
 r4 = C06EFB20
[<c0134cd4>] (smc_interrupt+0x0/0x740) from [<c0065878>] (handle_IRQ_event+0x34/0x6c)
[<c0065844>] (handle_IRQ_event+0x0/0x6c) from [<c0066af4>] (handle_level_irq+0xe8/0x158)
 r8 = C021BF48  r7 = C021D124  r6 = C06EFB20  r5 = 00000029
 r4 = C021D100
[<c0066a0c>] (handle_level_irq+0x0/0x158) from [<c00217f0>] (asm_do_IRQ+0x54/0x64)
 r8 = C001A680  r7 = 00008000  r6 = 00000029  r5 = F1100100
 r4 = C021D100
[<c002179c>] (asm_do_IRQ+0x0/0x64) from [<c0020a68>] (__irq_svc+0x28/0xc0)
 r4 = FFFFFFFF
[<c0021a64>] (default_idle+0x0/0x4c) from [<c0021b18>] (cpu_idle+0x68/0x88)
 r4 = C0021A64
[<c0021ab0>] (cpu_idle+0x0/0x88) from [<c0020028>] (__init_end+0x28/0x30)
 r5 = C0274DB4  r4 = C03AC520
[<c0020000>] (__init_end+0x0/0x30) from [<c0008aa0>] (start_kernel+0x270/0x2dc)
[<c0008830>] (start_kernel+0x0/0x2dc) from [<00008078>] (0x8078)
 r8 = 0001A078  r7 = C03C0328  r6 = C0220984  r5 = C0275240
 r4 = 00C5387D

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

diff --git a/drivers/net/smc91x.c b/drivers/net/smc91x.c
index 3d8dcb6..cf62373 100644
--- a/drivers/net/smc91x.c
+++ b/drivers/net/smc91x.c
@@ -321,12 +321,12 @@ static void smc_reset(struct net_device 
 	DBG(2, "%s: %s\n", dev->name, __FUNCTION__);
 
 	/* Disable all interrupts, block TX tasklet */
-	spin_lock(&lp->lock);
+	spin_lock_irq(&lp->lock);
 	SMC_SELECT_BANK(2);
 	SMC_SET_INT_MASK(0);
 	pending_skb = lp->pending_tx_skb;
 	lp->pending_tx_skb = NULL;
-	spin_unlock(&lp->lock);
+	spin_unlock_irq(&lp->lock);
 
 	/* free any pending tx skb */
 	if (pending_skb) {
@@ -448,12 +448,12 @@ static void smc_shutdown(struct net_devi
 	DBG(2, "%s: %s\n", CARDNAME, __FUNCTION__);
 
 	/* no more interrupts for me */
-	spin_lock(&lp->lock);
+	spin_lock_irq(&lp->lock);
 	SMC_SELECT_BANK(2);
 	SMC_SET_INT_MASK(0);
 	pending_skb = lp->pending_tx_skb;
 	lp->pending_tx_skb = NULL;
-	spin_unlock(&lp->lock);
+	spin_unlock_irq(&lp->lock);
 	if (pending_skb)
 		dev_kfree_skb(pending_skb);
 


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
