Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932306AbVLDTaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbVLDTaL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 14:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbVLDTaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 14:30:11 -0500
Received: from mail.dvmed.net ([216.237.124.58]:27522 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932306AbVLDTaJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 14:30:09 -0500
Message-ID: <439343BC.902@pobox.com>
Date: Sun, 04 Dec 2005 14:30:04 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Ethan Chen <thanatoz@ucla.edu>,
       Carlos Pardo <Carlos.Pardo@siliconimage.com>
Subject: Re: [PATCH] sata_sil: improved interrupt handling
References: <20051203054127.GA11208@havoc.gtf.org> <439319ED.8050303@gmail.com>
In-Reply-To: <439319ED.8050303@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Tejun Heo wrote: > Hi, Jeff. > > Jeff Garzik wrote: >
	>> Just committed the following to the 'sii-irq' branch of
	libata-dev.git, >> and verified it on an Adaptec 1210SA (3112). >> >>
	Haven't decided whether I will push it upstream or not, but I think I
	>> will. It does a bit better job of handling handling errors, and
	should >> be more efficient (less CPU usage) than the standard ATA
	interrupt >> handler as well. >> >> For users seeing sata_sil problems,
	this may make them happy. >> > > This patch doesn't make any difference
	on my sil3114 controller. I'll > write about it in the m15w thread.
	[...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> Hi, Jeff.
> 
> Jeff Garzik wrote:
> 
>> Just committed the following to the 'sii-irq' branch of libata-dev.git,
>> and verified it on an Adaptec 1210SA (3112).
>>
>> Haven't decided whether I will push it upstream or not, but I think I
>> will.  It does a bit better job of handling handling errors, and should
>> be more efficient (less CPU usage) than the standard ATA interrupt
>> handler as well.
>>
>> For users seeing sata_sil problems, this may make them happy.
>>
> 
> This patch doesn't make any difference on my sil3114 controller.  I'll 
> write about it in the m15w thread.

"doesn't make any difference" I will interpret to mean there are no 
regressions.


> Also, this patch doesn't implement proper handling of PIO protocols and 
> thus breaks ALL branch.

PIO should work fine, modulo the obvious changes for ATA_FLAG_NOINTR 
disappearance.


> It seems to me that the changes made by the new interrupt handler is not 
> very sil3112 specific.  Is there any reason this change is sil3112 
> specific?

There is nothing 3112-specific about this new code.


>> commit b6abf7755a79383f0e5f108d23a0394f156c54c1
>> Author: Jeff Garzik <jgarzik@pobox.com>
>> Date:   Sat Dec 3 00:30:57 2005 -0500
>>
>>     [libata sata_sil] improved interrupt handling
>>
>>  drivers/scsi/sata_sil.c |  118 
>> +++++++++++++++++++++++++++++++++++++++++++++++-
>>  1 files changed, 117 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
>> index 3609186..37398a5 100644
>> --- a/drivers/scsi/sata_sil.c
>> +++ b/drivers/scsi/sata_sil.c
>> @@ -85,6 +85,7 @@ static void sil_dev_config(struct ata_po
>>  static u32 sil_scr_read (struct ata_port *ap, unsigned int sc_reg);
>>  static void sil_scr_write (struct ata_port *ap, unsigned int sc_reg, 
>> u32 val);
>>  static void sil_post_set_mode (struct ata_port *ap);
>> +static irqreturn_t sil_irq (int irq, void *dev_instance, struct 
>> pt_regs *regs);
>>  
>>  
>>  static const struct pci_device_id sil_pci_tbl[] = {
>> @@ -167,7 +168,7 @@ static const struct ata_port_operations      
>> .qc_prep        = ata_qc_prep,
>>      .qc_issue        = ata_qc_issue_prot,
>>      .eng_timeout        = ata_eng_timeout,
>> -    .irq_handler        = ata_interrupt,
>> +    .irq_handler        = sil_irq,
>>      .irq_clear        = ata_bmdma_irq_clear,
>>      .scr_read        = sil_scr_read,
>>      .scr_write        = sil_scr_write,
>> @@ -233,6 +234,121 @@ MODULE_DEVICE_TABLE(pci, sil_pci_tbl);
>>  MODULE_VERSION(DRV_VERSION);
>>  
>>  
>> +static inline void sil_port_irq(struct ata_port *ap, void __iomem *mmio,
>> +                u8 dma_stat, u8 dma_stat_mask)
>> +{
>> +    struct ata_queued_cmd *qc = NULL;
>> +    unsigned int err_mask = AC_ERR_OTHER;
>> +    int complete = 1;
>> +    u8 dev_stat;
>> +
>> +    /* Exit now, if port or port's irqs are disabled */
>> +    if (ap->flags & (ATA_FLAG_PORT_DISABLED | ATA_FLAG_NOINTR)) {
>> +        complete = 0;
>> +        goto out;
>> +    }
> 
> 
> Hmmm... By performing this test here, we end up reading bmdma status 
> registers of all ports everytime an interrupt occurs.  Is this to 
> prevent screaming IRQ problem?

That's the preferred way to handle interrupts on this hardware.  Normal 
ATA is broken due to the lack of a way to ask "did I receive an 
interrupt?" without unduly affecting state.  311x, like AHCI, sata_sil24 
and other hardware, provides a method to easily determine if a PCI 
interrupt is owned by the hardware or not.

The code should eliminate all screaming interrupt problems, yes.

As an aside, 3114 should use a single 32-bit read of the Interrupt 
Summary register, rather than the four separate 8-bit reads that this 
code does.

	Jeff


