Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261899AbVHBW4i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbVHBW4i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 18:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbVHBW4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 18:56:34 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:47629 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S261875AbVHBW4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 18:56:33 -0400
Message-ID: <42EFFA05.8010003@google.com>
Date: Tue, 02 Aug 2005 15:56:05 -0700
From: Edward Falk <efalk@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050519 Red Hat/1.7.8-0.90.1gg1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Carlos Pardo <Carlos.Pardo@siliconimage.com>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH linux-2.6.13-rc3] SATA: rewritten sil24 driver
References: <20050728013622.GA14026@htj.dyndns.org> <42E93FB9.6090800@pobox.com> <20050730081734.GA14242@htj.dyndns.org>
In-Reply-To: <20050730081734.GA14242@htj.dyndns.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun; I'm the guy at Google working on SATA drivers (port 
multipliers right now).  As soon as I can (next week perhaps, I'll start 
looking at the driver you wrote.  From what I can see, it looks quite good.



>>>+
>>>+static u8 sil24_check_status(struct ata_port *ap)
>>>+{
>>>+	return ATA_DRDY;
>>>+}
>>>+
>>>+static u8 sil24_check_err(struct ata_port *ap)
>>>+{
>>>+	return 0;
>>>+}
>>
>>For these two functions, we need to grab the values for these registers 
>>from the D2H Register FIS.  These should not be constant values, they 
>>are used in probing.
>>
> 
>  Sadly I don't know where the values are.  The original driver seems
> to assume that taskfile registers are overlayed with PORT_PRB, but
> they are not.  Values are bogus there.  Again, in need of hardware
> docs here.

The original driver is broken.  Taskfile registers have to be read back 
from the returned FIS block after a command completion.

Hmmmm, perhaps libata should provide an ata_fis_to_tf() function that 
examines a FIS block, confirms that it's a device-to-host type FIS, and 
read the taskfile registers back out.



> 
>  The original rewritten sil24 driver against NCQ helpers had simple
> status register emulation using normal/error completion interrupt.  I
> don't know why I stripped that while converting the driver over
> vanilla libata (sorry).  I'll restore it.  It's not good, but it
> correctly indicates error on error.

It's still better than what we have.



>>>+static void sil24_phy_reset(struct ata_port *ap)
>>>+{
>>>+	__sata_phy_reset(ap);
>>>+	/*
>>>+	 * No ATAPI yet.  Just unconditionally indicate ATA device.
>>>+	 * If ATAPI device is attached, it will fail ATA_CMD_ID_ATA
>>>+	 * and libata core will ignore the device.
>>>+	 */
>>>+	if (!(ap->flags & ATA_FLAG_PORT_DISABLED))
>>>+		ap->device[0].class = ATA_DEV_ATA;
>>>+}
>>
>>We need to use the standard probing code to figure this out. 
>>ata_dev_classify(), etc.
>>
> 
> 
>  Again, the problem here is that I don't know how to access the
> signature values after reset.

Again, you would need to fetch them from the returned FIS structure. 
Here's a code fragment derived from SiI's issue_soft_reset() function:

	struct Port_Registers *port_base = yadayada;
	struct sil_port_priv *pp = ap->private_data;
	struct Port_Registers *PR;	/* in memory */
	dma_addr_t paddr = pp->pc_dma; /* physical address base */

	PR = (struct Port_Registers *) (&pp->pc->mregs);
	port_base = yadayada;
	slot = 0;
	slotp = &PR->Slot[slot];
	memset(&slotp->Prb, 0, sizeof(slotp->Prb));
	slotp->Prb.Control = 0x80;		/* soft reset */
	slotp->Prb.FisType == 0;
	writel(paddr, &port_base->CmdActivate[slot].s.ActiveLow);
	if (!sil_wait_for_completion(port_base)) {
		/* timeout or error */
		return ATA_DEV_NONE;
	} else {
		/* Examine slot for taskfile registers */
		slotp = port_base->Slot[slot];
		if (slotp->Prb.FisType != 0x34 &&
		    slotp->Prb.FisType != 0x5F) {
			/* WTF?  Wrong FIS Type */
			return ATA_DEV_NONE;
		}
		if (slotp->Prb.CylLow == 0 &&
		    slotp->Prb.CylHigh == 0)
			return ATA_DEV_ATA;
		if (slotp->Prb.CylLow == 0x14 &&
		    slotp->Prb.CylHigh == 0xEB)
			return ATA_DEV_ATAPI;
		if (slotp->Prb.CylLow == 0x69 &&
		    slotp->Prb.CylHigh == 0x96)
			return ATA_DEV_PORT_MULTIPLIER;
		printk(KERN_WARN "unknown ATA device signature %x.%x\n",
			slotp->Prb.CylLow, slotp->Prb.CylHigh);
		return ATA_DEV_NONE;
	}
	


>>>+static void sil24_irq_clear(struct ata_port *ap)
>>>+{
>>>+	/* unused */
>>>+}
>>
>>we need to fill this in.

I think this will work (adapted from sil_interrupt():

static void sil_irq_clear(struct ata_port *ap)
{
         struct sil_port_priv *pp = ap->private_data;
         struct Port_Registers *port_base = pp->pregs;
	unsigned long port_int;

	port_int  = readl((void *)&port_base->IntStatus);
	writel(port_int, &port_base->IntStatus);
}

I'm assuming that this entry point is expected to clear all interrupts, no?



>>>+	/* Max ~100ms */
>>>+	for (cnt = 0; cnt < 1000; cnt++) {
>>>+		udelay(100);
>>>+		tmp = readl(port + PORT_CTRL_STAT);
>>>+		if (!(tmp & PORT_CS_DEV_RST))
>>>+			break;
>>>+	}
>>
>>Use mdelay.  We should be able to sleep here?
>>
>>Either way, we want to avoid long delays like this.

Does mdelay() sleep?  I thought it just called udelay().

At any rate, I think 100ms is only the worst-case delay.

Is it safe to call msleep() at boot time?




>>>+	/* GPIO off */
>>>+	writel(0, host_base + HOST_FLASH_CMD);
>>>+
>>>+	/* Mask interrupts during initialization */
>>>+	writel(0, host_base + HOST_CTRL);
>>
>>add a readl() to flush this write out to the PCI bus ("PCI posting")
>>
> 
> 
>  Sure.  And, out of curiosity, isn't sync unnecessary unless we're
> gonna perform some kind of timed waiting following it?  We don't have
> any timing requirement after above interrupt masking, do we?


I think we're ok here; the code reads PORT_CTRL_STAT a few lines down; 
that will flush the write.  I don't think there's a race condition involved.





OK, a couple of questions of my own:

Any documentation on NCQ helpers or other related kernel code?

What's the proper way to implement very long delays.  I want to 
implement staggered disk spinup in my port multiplier code.  Would 
mdelay(5000) be terribly anti-social?  I'm guessing yes, but then, how 
do I ensure that no process tries to access the disk until I've spun it up?

Port multiplier spec says that the GSCR[2] register indicates how many 
ports the port multiplier supports.  On my 5-port device, this register 
reads back as six.  Are they counting the control port, or is this 
device defective?

What causes a disk to spin up?  Is it the COMRESET?  Soft reset?  In 
either case, it sounds like I need to spin up a drive just to detect it. 
  Not optimal.

	-ed falk
