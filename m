Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751059AbVLEGg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbVLEGg3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 01:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbVLEGg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 01:36:28 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:63935 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750969AbVLEGg1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 01:36:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=JAeH4qcCMAgdv3uC6RUjDR61VVfA/LFbH8L+Pypi+8fk1YQTrXrLjuoPLynfgpZyImwJza9kEjKfUgOj7XJkgT8Sk/vSNr1kbnaFt901Af0NafCJP4qXjpfep4Xiw7fGyasQcYnmArygSjXGK5zyZo14iWRNI2ouZhU7M1Nn+/c=
Message-ID: <4393DFE5.1020409@gmail.com>
Date: Mon, 05 Dec 2005 15:36:21 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Ethan Chen <thanatoz@ucla.edu>,
       Carlos Pardo <Carlos.Pardo@siliconimage.com>
Subject: Re: [PATCH] sata_sil: improved interrupt handling
References: <20051203054127.GA11208@havoc.gtf.org> <439319ED.8050303@gmail.com> <439343BC.902@pobox.com>
In-Reply-To: <439343BC.902@pobox.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
> 
>> Hi, Jeff.
>>
>> Jeff Garzik wrote:
>>
>>> Just committed the following to the 'sii-irq' branch of libata-dev.git,
>>> and verified it on an Adaptec 1210SA (3112).
>>>
>>> Haven't decided whether I will push it upstream or not, but I think I
>>> will.  It does a bit better job of handling handling errors, and should
>>> be more efficient (less CPU usage) than the standard ATA interrupt
>>> handler as well.
>>>
>>> For users seeing sata_sil problems, this may make them happy.
>>>
>>
>> This patch doesn't make any difference on my sil3114 controller.  I'll 
>> write about it in the m15w thread.
> 
> 
> "doesn't make any difference" I will interpret to mean there are no 
> regressions.
> 

I wasn't clear enough.  I meant that the change did not fix the 
seemlingly-m15w problems on 3114.

> 
>> Also, this patch doesn't implement proper handling of PIO protocols 
>> and thus breaks ALL branch.
> 
> 
> PIO should work fine, modulo the obvious changes for ATA_FLAG_NOINTR 
> disappearance.
> 

I took out ATA_FLAG_NOINTR test from sata_sil in the latest ALL branch 
and tested it.  It fails to read IDENTIFY data.  Actually, there is no 
code to read PIO data.  It should be done in the interrupt handler but 
sil_port_irq doesn't do it.

scsi3 : sata_sil
ata4: SATA link up 1.5 Gbps (SStatus 113)
ata4: dev 0 cfg 49:0000 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 
88:0000
ata4: no dma
ata4: dev 0 not supported, ignoring
scsi4 : sata_sil
ata5: SATA link up 1.5 Gbps (SStatus 113)
ata5: dev 0 cfg 49:0000 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 
88:0000
ata5: no dma
ata5: dev 0 not supported, ignoring
scsi5 : sata_sil
ata6: SATA link up 1.5 Gbps (SStatus 113)
ata6: dev 0 cfg 49:0000 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 
88:0000
ata6: no dma
ata6: dev 0 not supported, ignoring
scsi6 : sata_sil

> 
>> It seems to me that the changes made by the new interrupt handler is 
>> not very sil3112 specific.  Is there any reason this change is sil3112 
>> specific?
> 
> 
> There is nothing 3112-specific about this new code.
> 
> 
>>> commit b6abf7755a79383f0e5f108d23a0394f156c54c1
>>> Author: Jeff Garzik <jgarzik@pobox.com>
>>> Date:   Sat Dec 3 00:30:57 2005 -0500
>>>
>>>     [libata sata_sil] improved interrupt handling
>>>
>>>  drivers/scsi/sata_sil.c |  118 
>>> +++++++++++++++++++++++++++++++++++++++++++++++-
>>>  1 files changed, 117 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
>>> index 3609186..37398a5 100644
>>> --- a/drivers/scsi/sata_sil.c
>>> +++ b/drivers/scsi/sata_sil.c
>>> @@ -85,6 +85,7 @@ static void sil_dev_config(struct ata_po
>>>  static u32 sil_scr_read (struct ata_port *ap, unsigned int sc_reg);
>>>  static void sil_scr_write (struct ata_port *ap, unsigned int sc_reg, 
>>> u32 val);
>>>  static void sil_post_set_mode (struct ata_port *ap);
>>> +static irqreturn_t sil_irq (int irq, void *dev_instance, struct 
>>> pt_regs *regs);
>>>  
>>>  
>>>  static const struct pci_device_id sil_pci_tbl[] = {
>>> @@ -167,7 +168,7 @@ static const struct ata_port_operations      
>>> .qc_prep        = ata_qc_prep,
>>>      .qc_issue        = ata_qc_issue_prot,
>>>      .eng_timeout        = ata_eng_timeout,
>>> -    .irq_handler        = ata_interrupt,
>>> +    .irq_handler        = sil_irq,
>>>      .irq_clear        = ata_bmdma_irq_clear,
>>>      .scr_read        = sil_scr_read,
>>>      .scr_write        = sil_scr_write,
>>> @@ -233,6 +234,121 @@ MODULE_DEVICE_TABLE(pci, sil_pci_tbl);
>>>  MODULE_VERSION(DRV_VERSION);
>>>  
>>>  
>>> +static inline void sil_port_irq(struct ata_port *ap, void __iomem 
>>> *mmio,
>>> +                u8 dma_stat, u8 dma_stat_mask)
>>> +{
>>> +    struct ata_queued_cmd *qc = NULL;
>>> +    unsigned int err_mask = AC_ERR_OTHER;
>>> +    int complete = 1;
>>> +    u8 dev_stat;
>>> +
>>> +    /* Exit now, if port or port's irqs are disabled */
>>> +    if (ap->flags & (ATA_FLAG_PORT_DISABLED | ATA_FLAG_NOINTR)) {
>>> +        complete = 0;
>>> +        goto out;
>>> +    }
>>
>>
>>
>> Hmmm... By performing this test here, we end up reading bmdma status 
>> registers of all ports everytime an interrupt occurs.  Is this to 
>> prevent screaming IRQ problem?
> 
> 
> That's the preferred way to handle interrupts on this hardware.  Normal 
> ATA is broken due to the lack of a way to ask "did I receive an 
> interrupt?" without unduly affecting state.  311x, like AHCI, sata_sil24 
> and other hardware, provides a method to easily determine if a PCI 
> interrupt is owned by the hardware or not.
> 

Ah... I see.  Section 7.4 of sii3112 manual says that

Wait until an IDE channel interrupt (bit 11 in the IDEx Task File Timing 
+ Configuration + Status register is set).

Where the register is at BAR5 + 0xA0 and bit 11 is

• Bit [11]: Interrupt Status (R) – IDE0 Interrupt Status. This bit set 
indicates that an interrupt is pending on IDE0. This bit provides 
real-time status of the IDE0 interrupt pin.

And, section 6.7.1 (PCI bus master - IDE0 register) says

• Bit [18]: IDE0 DMA Comp (R/W1C) – IDE0 DMA Completion Interrupt. 
During write DMA operation, This bit set indicates that the IDE0 
interrupt has been asserted and all data has been written to system 
memory. During Read DMA, This bit set indicates that the IDE0 interrupt 
has been asserted. This bit must be W1C by software when set during DMA 
operation (bit 0 is set). During normal operation, this bit reflects 
IDE0 interrupt line.

So, the last sentence means that while on DMA command is in progress, 
bit 18 of the PCI bus master is identical to bit 11 of the conf/status 
register.  Right?

Yeap, I agree that this is a good change although it hurts a little bit 
that it causes a few extra PCI transactions.

Also, it seems a little bit weird that the code enters interrupt 
handling even for ports which don't have ATA_DMA_INTR set, although I 
don't think the current code would bogusly finish commands due to the 
ATA_BUSY check.  Is this intentional?

> The code should eliminate all screaming interrupt problems, yes.
> 
> As an aside, 3114 should use a single 32-bit read of the Interrupt 
> Summary register, rather than the four separate 8-bit reads that this 
> code does.

That sounds cool.

-- 
tejun
