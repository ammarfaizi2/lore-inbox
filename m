Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261968AbVEEAIy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261968AbVEEAIy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 20:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbVEEAIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 20:08:54 -0400
Received: from gate.crashing.org ([63.228.1.57]:17093 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261968AbVEEAIu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 20:08:50 -0400
Subject: Re: Oops in snd-powermac on powerbook 3400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Keenan Pepper <keenanpepper@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <42784801.7080105@gmail.com>
References: <42784801.7080105@gmail.com>
Content-Type: text/plain
Date: Thu, 05 May 2005 10:06:36 +1000
Message-Id: <1115251597.7567.163.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-03 at 23:56 -0400, Keenan Pepper wrote:
> My Powerbook 3400 I got on Ebay for $100 works great with linux, except 
> that the sound driver which worked in 2.6.8 now oopses on modprobe in 
> both 2.6.12-rc3 and 2.6.12-rc3-mm2. The oops looks like this:
> 
> Oops: kernel access of bad area, sig: 11 [#1]
> PREEMPT
> NIP: C62CC038 LR: C6238BCC SP: C4133E70 REGS: c4133dc0 TRAP: 0300    Not 
> tainted
> MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
> DAR: 00000138, DSISR: 20000000
> TASK = c45de0f0[350] 'modprobe' THREAD: c4132000
> Last syscall: 128
> GPR00: 00000000 C4133E70 C45DE0F0 000000D0 C476AC90 00000021 00000000 
> 00000001
> GPR08: C028F4ED 00000048 FFFFFFEB 00000061 33003553 1001E284 10017070 
> 00000001
> GPR16: 00000000 00000000 00000000 00000000 00000000 100013A4 1001DF18 
> 1001E088
> GPR24: 00000000 C476AE00 00000000 C4133EE8 00000021 00000220 C476AC90 
> 00000000
> NIP [c62cc038] snd_pmac_dbdma_alloc+0x38/0x104 [snd_powermac]
> LR [c6238bcc] snd_pmac_new+0x8c/0x484 [snd_powermac]
> Call trace:
>   [c6238bcc] snd_pmac_new+0x8c/0x484 [snd_powermac]
>   [c6238048] snd_pmac_probe+0x48/0x320 [snd_powermac]
>   [c6238330] alsa_card_pmac_init+0x10/0x2c [snd_powermac]
>   [c003b4e4] sys_init_module+0x264/0x394
>   [c0004060] ret_from_syscall+0x0/0x44

Can you edit sound/ppc/pmac.c, and add that to snd_pmac_dbdma_alloc():

	unsigned int rsize = sizeof(struct dbdma_cmd) * (size + 1);

+	BUG_ON(chip->pdev == NULL);
+
	rec->space = dma_alloc_coherent(&chip->pdev->dev, rsize,
					&rec->dma_base, GFP_KERNEL);

And tell me if you hit the BUG() ?

if it does, can you have a look at what happens in that bit of code in
snd_pmac_detect() :

	if (macio == NULL)
		printk(KERN_WARNING "snd-powermac: can't locate macio !\n");
	else {
		struct pci_dev *pdev = NULL;

		for_each_pci_dev(pdev) {
			struct device_node *np = pci_device_to_OF_node(pdev);
			if (np && np == macio->of_node) {
				chip->pdev = pdev;
				break;
			}
		}
	}

Does it actuall fail to find a suitable pdev ?

Thanks,
Ben.


