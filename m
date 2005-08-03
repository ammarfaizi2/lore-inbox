Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262038AbVHCEJQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262038AbVHCEJQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 00:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262039AbVHCEJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 00:09:16 -0400
Received: from mail.dvmed.net ([216.237.124.58]:37866 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262015AbVHCEJO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 00:09:14 -0400
Message-ID: <42F04361.4020001@pobox.com>
Date: Wed, 03 Aug 2005 00:09:05 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Edward Falk <efalk@google.com>
CC: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Carlos Pardo <Carlos.Pardo@siliconimage.com>
Subject: Re: [PATCH linux-2.6.13-rc3] SATA: rewritten sil24 driver
References: <20050728013622.GA14026@htj.dyndns.org> <42E93FB9.6090800@pobox.com> <20050730081734.GA14242@htj.dyndns.org> <42EFFA05.8010003@google.com>
In-Reply-To: <42EFFA05.8010003@google.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Edward Falk wrote:
> Hi Tejun; I'm the guy at Google working on SATA drivers (port 
> multipliers right now).  As soon as I can (next week perhaps, I'll start 
> looking at the driver you wrote.  From what I can see, it looks quite good.
> 
> 
> 
>>>> +
>>>> +static u8 sil24_check_status(struct ata_port *ap)
>>>> +{
>>>> +    return ATA_DRDY;
>>>> +}
>>>> +
>>>> +static u8 sil24_check_err(struct ata_port *ap)
>>>> +{
>>>> +    return 0;
>>>> +}
>>>
>>>
>>> For these two functions, we need to grab the values for these 
>>> registers from the D2H Register FIS.  These should not be constant 
>>> values, they are used in probing.
>>>
>>
>>  Sadly I don't know where the values are.  The original driver seems
>> to assume that taskfile registers are overlayed with PORT_PRB, but
>> they are not.  Values are bogus there.  Again, in need of hardware
>> docs here.
> 
> 
> The original driver is broken.  Taskfile registers have to be read back 
> from the returned FIS block after a command completion.

Correct.


> Hmmmm, perhaps libata should provide an ata_fis_to_tf() function that 
> examines a FIS block, confirms that it's a device-to-host type FIS, and 
> read the taskfile registers back out.

Such as ata_tf_from_fis() in libata-core.c? :)


>>  The original rewritten sil24 driver against NCQ helpers had simple
>> status register emulation using normal/error completion interrupt.  I
>> don't know why I stripped that while converting the driver over
>> vanilla libata (sorry).  I'll restore it.  It's not good, but it
>> correctly indicates error on error.
> 
> 
> It's still better than what we have.
> 
> 
> 
>>>> +static void sil24_phy_reset(struct ata_port *ap)
>>>> +{
>>>> +    __sata_phy_reset(ap);
>>>> +    /*
>>>> +     * No ATAPI yet.  Just unconditionally indicate ATA device.
>>>> +     * If ATAPI device is attached, it will fail ATA_CMD_ID_ATA
>>>> +     * and libata core will ignore the device.
>>>> +     */
>>>> +    if (!(ap->flags & ATA_FLAG_PORT_DISABLED))
>>>> +        ap->device[0].class = ATA_DEV_ATA;
>>>> +}
>>>
>>>
>>> We need to use the standard probing code to figure this out. 
>>> ata_dev_classify(), etc.
>>>
>>
>>
>>  Again, the problem here is that I don't know how to access the
>> signature values after reset.
> 
> 
> Again, you would need to fetch them from the returned FIS structure. 

Correct.


>>>> +static void sil24_irq_clear(struct ata_port *ap)
>>>> +{
>>>> +    /* unused */
>>>> +}
>>>
>>>
>>> we need to fill this in.
> 
> 
> I think this will work (adapted from sil_interrupt():
> 
> static void sil_irq_clear(struct ata_port *ap)
> {
>         struct sil_port_priv *pp = ap->private_data;
>         struct Port_Registers *port_base = pp->pregs;
>     unsigned long port_int;
> 
>     port_int  = readl((void *)&port_base->IntStatus);
>     writel(port_int, &port_base->IntStatus);
> }
> 
> I'm assuming that this entry point is expected to clear all interrupts, no?

Correct.


>>>> +    /* Max ~100ms */
>>>> +    for (cnt = 0; cnt < 1000; cnt++) {
>>>> +        udelay(100);
>>>> +        tmp = readl(port + PORT_CTRL_STAT);
>>>> +        if (!(tmp & PORT_CS_DEV_RST))
>>>> +            break;
>>>> +    }
>>>
>>>
>>> Use mdelay.  We should be able to sleep here?
>>>
>>> Either way, we want to avoid long delays like this.
> 
> 
> Does mdelay() sleep?  I thought it just called udelay().

mdelay() does not sleep.


> At any rate, I think 100ms is only the worst-case delay.
> 
> Is it safe to call msleep() at boot time?

Yes.


>>>> +    /* GPIO off */
>>>> +    writel(0, host_base + HOST_FLASH_CMD);
>>>> +
>>>> +    /* Mask interrupts during initialization */
>>>> +    writel(0, host_base + HOST_CTRL);
>>>
>>>
>>> add a readl() to flush this write out to the PCI bus ("PCI posting")
>>>
>>
>>
>>  Sure.  And, out of curiosity, isn't sync unnecessary unless we're
>> gonna perform some kind of timed waiting following it?  We don't have
>> any timing requirement after above interrupt masking, do we?
> 
> 
> 
> I think we're ok here; the code reads PORT_CTRL_STAT a few lines down; 
> that will flush the write.  I don't think there's a race condition 
> involved.

No race condition.  Typically there is often a mistaken assumption that

	writel(...)
	udelay(...)

will accomplish the desired effect.  Due to posted writes, the write may 
be posted to the PCI device after some delay, such that, the udelay() 
and the posted write execute concurrently, skewing the desired timing 
effect.


> OK, a couple of questions of my own:
> 
> Any documentation on NCQ helpers or other related kernel code?
> 
> What's the proper way to implement very long delays.  I want to 
> implement staggered disk spinup in my port multiplier code.  Would 
> mdelay(5000) be terribly anti-social?  I'm guessing yes, but then, how 

Yes :)  msleep(5000) is far less anti-social, but still yucky...


> do I ensure that no process tries to access the disk until I've spun it up?

The probe code is typically serialized, to prevent problems like this. 
Specifically, you'll have to be aware of when libata adds devices to the 
SCSI layer.


> Port multiplier spec says that the GSCR[2] register indicates how many 
> ports the port multiplier supports.  On my 5-port device, this register 
> reads back as six.  Are they counting the control port, or is this 
> device defective?

Good question!  ;-)


> What causes a disk to spin up?  Is it the COMRESET?  Soft reset?  In 
> either case, it sounds like I need to spin up a drive just to detect it. 
>  Not optimal.

It depends.  COMRESET or power management can do it.  This stuff is 
documented in the SATA docs.  This is more on the device end than the 
host end, but in general you must be aware of
* host controller power state(s)
* SATA bus power state(s)
* SATA device power state(s)

	Jeff


