Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751285AbVJJWJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbVJJWJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 18:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbVJJWJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 18:09:59 -0400
Received: from gate.crashing.org ([63.228.1.57]:19587 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751285AbVJJWJ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 18:09:58 -0400
Subject: Re: ide_wait_not_busy oops still with 2.6.14-rc3 (Re: 1GHz pbook
	15", linux 2.6.14-rc2 oops on resume)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1128948118.23434.13.camel@localhost>
References: <1128323544.4602.5.camel@localhost>
	 <pan.2005.10.06.19.19.22.673915@nn7.de>  <1128720351.17365.48.camel@gaston>
	 <1128948118.23434.13.camel@localhost>
Content-Type: text/plain
Date: Tue, 11 Oct 2005 08:06:42 +1000
Message-Id: <1128982002.17365.163.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> ok, here is the complete one:
> 
> BUG: soft lockup detected on CPU#0!

Gack, the soft lockup thing. Can you disable that ? If you do so, does
it crashes instead of oopsing or just "pauses" for a little while on
wakeup ? The problem is that ide_do_request does a synchronous wait for
the drive to get out of busy state which can take a while with some
optical drives on wakeup. It might be possible to allow scheduling
there, I have to look at it. In the meantime, disable the lockup
detector (CONFIG_DETECT_SOFTLOCKUP) and tell me if that's enough.

Ben.

> NIP: C0006FCC LR: C02BC32C SP: EDEF5C00 REGS: edef5b50 TRAP: 0901    Not tainted
> MSR: 0200b032 EE: 1 PR: 0 FP: 1 ME: 1 IR/DR: 11
> TASK = ef894780[3425] 'pbbuttonsd' THREAD: edef4000
> Last syscall: 54 
> GPR00: 00000080 EDEF5C00 EF894780 00079C96 000088B8 00000000 00000000 C05A8A50 
> GPR08: C05A8538 EDEF5CC8 00100000 00140040 22004222 
> NIP [c0006fcc] __delay+0xc/0x14
> LR [c02bc32c] ide_wait_not_busy+0x4c/0xc0
> Call trace:
>  [c02ba670] ide_do_request+0x5b0/0x990
>  [c02bab10] ide_do_drive_cmd+0xc0/0x190
>  [c02b72d0] generic_ide_resume+0x80/0xa0
>  [c0294260] resume_device+0x70/0x150
>  [c0294510] dpm_resume+0x100/0x1a0
>  [c02945ec] device_resume+0x3c/0xa0
>  [c05438cc] pmac_wakeup_devices+0xbc/0xe0
>  [c0544adc] pmu_ioctl+0x58c/0x9b0
>  [c008e344] do_ioctl+0x84/0x90
>  [c008e3dc] vfs_ioctl+0x8c/0x450
>  [c008e834] sys_ioctl+0x94/0xb0
>  [c0004820] ret_from_syscall+0x0/0x44
> hdc: Enabling MultiWord DMA 2
> adb: starting probe task...
> adb devices: [2]: 2 c4 [3]: 3 1 [7]: 7 1f
> ADB keyboard at 2, handler 1
> ADB mouse at 3, handler set to 4 (trackpad)
> adb: finished probe task...
> agpgart: Putting AGP V2 device at 0000:00:0b.0 into 4x mode
> agpgart: Putting AGP V2 device at 0000:00:10.0 into 4x mode
> [drm] Loading R200 Microcode
> hdc: irq timeout: status=0xc0 { Busy }
> ide: failed opcode was: unknown
> hdc: DMA disabled
> eth0: Link is up at 1000 Mbps, full-duplex.
> eth0: Pause is enabled (rxfifo: 10240 off: 7168 on: 5632)
> hdc: ATAPI reset complete
> 
> > You haven't put the complete oops, what is the trap number ? Does it
> > help adding a delay in the wakeup code in drivers/ide/ppc/pmac.c ? Also,
> 
> are you talking about increasing this delay 
> #define IDE_WAKEUP_DELAY    (1*HZ) or sth. to pmac_ide_do_resume() ?
> 
> > is the problem present without preempt ?
> 
> Currently it is:
> Preemption Model (Voluntary Kernel Preemption (Desktop))
> 
> I will try.
> Soeren

