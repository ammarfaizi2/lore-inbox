Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261168AbULDVh7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbULDVh7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 16:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbULDVh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 16:37:59 -0500
Received: from sycorax.lbl.gov ([128.3.5.196]:37581 "EHLO sycorax.lbl.gov")
	by vger.kernel.org with ESMTP id S261168AbULDVhl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 16:37:41 -0500
To: Martin Josefsson <gandalf@wlug.westbo.se>
Cc: Ari Pollak <aripollak@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.10-rc3
References: <Pine.LNX.4.58.0412031611460.22796@ppc970.osdl.org>
	<pan.2004.12.04.09.06.09.707940@nn7.de>
	<87oeha6lj1.fsf@sycorax.lbl.gov> <cosrt1$j67$1@sea.gmane.org>
	<87eki66jx8.fsf@sycorax.lbl.gov>
	<1102195032.1560.58.camel@tux.rsn.bth.se>
From: Alex Romosan <romosan@sycorax.lbl.gov>
Date: Sat, 04 Dec 2004 13:37:35 -0800
In-Reply-To: <1102195032.1560.58.camel@tux.rsn.bth.se> (message from Martin
 Josefsson on Sat, 04 Dec 2004 22:17:12 +0100)
Message-ID: <877jnxago0.fsf@sycorax.lbl.gov>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Josefsson <gandalf@wlug.westbo.se> writes:

> This has been discussed in an earlier thread, I was hoping the ALSA
> people would submit the patch but that hasn't happened.
> I'll submit it in a separate mail.
>
> Try the patch below, it should fix the problem.
>
> --- linux/sound/core/init.c	8 Nov 2004 11:37:08 -0000	1.48
> +++ linux/sound/core/init.c	12 Nov 2004 13:56:32 -0000
> @@ -782,12 +782,15 @@<br>
>  int snd_card_pci_suspend(struct pci_dev *dev, u32 state)
>  {
>  	snd_card_t *card = pci_get_drvdata(dev);
> +	int err;
>  	if (! card || ! card->pm_suspend)
>  		return 0;
>  	if (card->power_state == SNDRV_CTL_POWER_D3hot)
>  		return 0;
>  	/* FIXME: correct state value? */
> -	return card->pm_suspend(card, 0);
> +	err = card->pm_suspend(card, 0);
> +	pci_save_state(dev);
> +	return err;
>  }
>
>  int snd_card_pci_resume(struct pci_dev *dev)

thank you. the laptop wakes up now but i get the following when it
resumes (this is the output from dmesg):

Back to C!
Warning: CPU frequency is 1600000, cpufreq assumed 600000 kHz.
MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
Bank 1: f200000000000115
PCI: Setting latency timer of device 0000:00:1d.0 to 64
PCI: Setting latency timer of device 0000:00:1d.1 to 64
PCI: Setting latency timer of device 0000:00:1d.2 to 64
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 restarted, EHCI 1.00, driver 26 Oct 2004
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 6 (level, low) -> IRQ 6
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:1f.5 to 64
ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 4 (level, low) -> IRQ 4
psmouse.c: TouchPad at isa0060/serio1/input0 lost sync at byte 1
scheduling while atomic: sleepbtn.sh/0x00000001/3201
 [<c0103557>] dump_stack+0x17/0x20
 [<c030e4e2>] schedule+0x522/0x530
 [<c030e97b>] schedule_timeout+0x5b/0xb0
 [<c011fbaf>] msleep+0x2f/0x40
 [<e1079387>] ehci_hub_resume+0xd7/0x1c0 [ehci_hcd]
 [<e10cce6a>] hcd_hub_resume+0x1a/0x20 [usbcore]
 [<e10c9ff2>] usb_resume_device+0xa2/0xc0 [usbcore]
 [<c022c50a>] resume_device+0x1a/0x20
 [<c022c5b7>] dpm_resume+0xa7/0xb0
 [<c022c5d4>] device_resume+0x14/0x30
 [<c012f27b>] suspend_finish+0xb/0x30
 [<c012f2ed>] enter_state+0x4d/0x70
 [<c01f6bd6>] acpi_suspend+0x3d/0x4b
 [<c01f6cbb>] acpi_system_write_sleep+0x64/0x76
 [<c014e042>] vfs_write+0xa2/0x100
 [<c014e151>] sys_write+0x41/0x70
 [<c0102ffb>] syscall_call+0x7/0xb
Restarting tasks... done
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
[drm] Loading R200 Microcode

not sure if this means anything bad or not... i use acpi.

--alex--

-- 
| I believe the moment is at hand when, by a paranoiac and active |
|  advance of the mind, it will be possible (simultaneously with  |
|  automatism and other passive states) to systematize confusion  |
|  and thus to help to discredit completely the world of reality. |
