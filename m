Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751448AbVJKKdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbVJKKdh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 06:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbVJKKdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 06:33:37 -0400
Received: from prosun.first.fraunhofer.de ([194.95.168.2]:42945 "EHLO
	prosun.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1751448AbVJKKdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 06:33:37 -0400
Subject: Re: ide_wait_not_busy oops still with 2.6.14-rc3 (Re: 1GHz pbook
	15", linux 2.6.14-rc2 oops on resume)
From: Soeren Sonnenburg <kernel@nn7.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1128982002.17365.163.camel@gaston>
References: <1128323544.4602.5.camel@localhost>
	 <pan.2005.10.06.19.19.22.673915@nn7.de>  <1128720351.17365.48.camel@gaston>
	 <1128948118.23434.13.camel@localhost>  <1128982002.17365.163.camel@gaston>
Content-Type: text/plain
Date: Tue, 11 Oct 2005 12:33:27 +0200
Message-Id: <1129026807.21318.15.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-11 at 08:06 +1000, Benjamin Herrenschmidt wrote:
> > ok, here is the complete one:
> > 
> > BUG: soft lockup detected on CPU#0!
> 
> Gack, the soft lockup thing. Can you disable that ? If you do so, does
> it crashes instead of oopsing or just "pauses" for a little while on
> wakeup ? The problem is that ide_do_request does a synchronous wait for
> the drive to get out of busy state which can take a while with some
> optical drives on wakeup. It might be possible to allow scheduling
> there, I have to look at it. In the meantime, disable the lockup
> detector (CONFIG_DETECT_SOFTLOCKUP) and tell me if that's enough.

Hmmhh, I already compiled 2.6.14-rc4 but did not disable
soft-lockup-ing, should I still do it - the oops looks better as it is
not followed by a ATAPI reset anymore:

eth0: Link is up at 1000 Mbps, full-duplex.
eth0: Pause is enabled (rxfifo: 10240 off: 7168 on: 5632)
BUG: soft lockup detected on CPU#0!
NIP: C0006FCC LR: C02BAD1C SP: EE60DBF0 REGS: ee60db40 TRAP: 0901    Not tainted
MSR: 0200b032 EE: 1 PR: 0 FP: 1 ME: 1 IR/DR: 11
TASK = c128b870[3312] 'pbbuttonsd' THREAD: ee60c000
Last syscall: 54 
GPR00: 00000080 EE60DBF0 C128B870 00079C96 000088B8 00000000 00000000 C05A6A50 
GPR08: C05A6538 EE60DCC8 00100000 00140040 22004282 
NIP [c0006fcc] __delay+0xc/0x14
LR [c02bad1c] ide_wait_not_busy+0x4c/0xc0
Call trace:
 [c02b918c] ide_do_request+0x74c/0xa00
 [c02b9500] ide_do_drive_cmd+0xc0/0x190
 [c02b5c80] generic_ide_resume+0x80/0xa0
 [c0292cec] resume_device+0x6c/0x140
 [c0292f8c] dpm_resume+0xfc/0x1a0
 [c0293068] device_resume+0x38/0xa0
 [c05418cc] pmac_wakeup_devices+0xbc/0xe0
 [c0542adc] pmu_ioctl+0x58c/0x9b0
 [c008def4] do_ioctl+0x84/0x90
 [c008df8c] vfs_ioctl+0x8c/0x450
 [c008e3e4] sys_ioctl+0x94/0xb0
 [c0004820] ret_from_syscall+0x0/0x44
hdc: Enabling MultiWord DMA 2

> Ben.

Soeren

> > NIP: C0006FCC LR: C02BC32C SP: EDEF5C00 REGS: edef5b50 TRAP: 0901    Not tainted
> > MSR: 0200b032 EE: 1 PR: 0 FP: 1 ME: 1 IR/DR: 11
> > TASK = ef894780[3425] 'pbbuttonsd' THREAD: edef4000
> > Last syscall: 54 
> > GPR00: 00000080 EDEF5C00 EF894780 00079C96 000088B8 00000000 00000000 C05A8A50 
> > GPR08: C05A8538 EDEF5CC8 00100000 00140040 22004222 
> > NIP [c0006fcc] __delay+0xc/0x14
> > LR [c02bc32c] ide_wait_not_busy+0x4c/0xc0
> > Call trace:
> >  [c02ba670] ide_do_request+0x5b0/0x990
> >  [c02bab10] ide_do_drive_cmd+0xc0/0x190
> >  [c02b72d0] generic_ide_resume+0x80/0xa0
> >  [c0294260] resume_device+0x70/0x150
> >  [c0294510] dpm_resume+0x100/0x1a0
> >  [c02945ec] device_resume+0x3c/0xa0
> >  [c05438cc] pmac_wakeup_devices+0xbc/0xe0
> >  [c0544adc] pmu_ioctl+0x58c/0x9b0
> >  [c008e344] do_ioctl+0x84/0x90
> >  [c008e3dc] vfs_ioctl+0x8c/0x450
> >  [c008e834] sys_ioctl+0x94/0xb0
> >  [c0004820] ret_from_syscall+0x0/0x44
> > hdc: Enabling MultiWord DMA 2
> > adb: starting probe task...
> > adb devices: [2]: 2 c4 [3]: 3 1 [7]: 7 1f
> > ADB keyboard at 2, handler 1
> > ADB mouse at 3, handler set to 4 (trackpad)
> > adb: finished probe task...
> > agpgart: Putting AGP V2 device at 0000:00:0b.0 into 4x mode
> > agpgart: Putting AGP V2 device at 0000:00:10.0 into 4x mode
> > [drm] Loading R200 Microcode
> > hdc: irq timeout: status=0xc0 { Busy }
> > ide: failed opcode was: unknown
> > hdc: DMA disabled
> > eth0: Link is up at 1000 Mbps, full-duplex.
> > eth0: Pause is enabled (rxfifo: 10240 off: 7168 on: 5632)
> > hdc: ATAPI reset complete
> > 
> > > You haven't put the complete oops, what is the trap number ? Does it
> > > help adding a delay in the wakeup code in drivers/ide/ppc/pmac.c ? Also,
> > 
> > are you talking about increasing this delay 
> > #define IDE_WAKEUP_DELAY    (1*HZ) or sth. to pmac_ide_do_resume() ?
> > 
> > > is the problem present without preempt ?
> > 
> > Currently it is:
> > Preemption Model (Voluntary Kernel Preemption (Desktop))
> > 
> > I will try.
> > Soeren
> 
-- 
Sometimes, there's a moment as you're waking, when you become aware of
the real world around you, but you're still dreaming.

