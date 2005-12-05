Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932505AbVLESg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932505AbVLESg6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 13:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932504AbVLESg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 13:36:58 -0500
Received: from mail.dvmed.net ([216.237.124.58]:2188 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932498AbVLESg5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 13:36:57 -0500
Message-ID: <439488C5.6070309@pobox.com>
Date: Mon, 05 Dec 2005 13:36:53 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Ethan Chen <thanatoz@ucla.edu>,
       Carlos Pardo <Carlos.Pardo@siliconimage.com>
Subject: Re: [PATCH] sata_sil: improved interrupt handling
References: <20051203054127.GA11208@havoc.gtf.org> <439319ED.8050303@gmail.com> <439343BC.902@pobox.com> <4393DFE5.1020409@gmail.com>
In-Reply-To: <4393DFE5.1020409@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Tejun Heo wrote: > Jeff Garzik wrote: > >> Tejun Heo
	wrote: >> >>> Hi, Jeff. >>> >>> Jeff Garzik wrote: >>> >>>> Just
	committed the following to the 'sii-irq' branch of libata-dev.git, >>>>
	and verified it on an Adaptec 1210SA (3112). >>>> >>>> Haven't decided
	whether I will push it upstream or not, but I think I >>>> will. It
	does a bit better job of handling handling errors, and should >>>> be
	more efficient (less CPU usage) than the standard ATA interrupt >>>>
	handler as well. >>>> >>>> For users seeing sata_sil problems, this may
	make them happy. >>>> >>> >>> This patch doesn't make any difference on
	my sil3114 controller. >>> I'll write about it in the m15w thread. >>
	>> >> >> "doesn't make any difference" I will interpret to mean there
	are no >> regressions. >> > > I wasn't clear enough. I meant that the
	change did not fix the > seemlingly-m15w problems on 3114. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> Jeff Garzik wrote:
> 
>> Tejun Heo wrote:
>>
>>> Hi, Jeff.
>>>
>>> Jeff Garzik wrote:
>>>
>>>> Just committed the following to the 'sii-irq' branch of libata-dev.git,
>>>> and verified it on an Adaptec 1210SA (3112).
>>>>
>>>> Haven't decided whether I will push it upstream or not, but I think I
>>>> will.  It does a bit better job of handling handling errors, and should
>>>> be more efficient (less CPU usage) than the standard ATA interrupt
>>>> handler as well.
>>>>
>>>> For users seeing sata_sil problems, this may make them happy.
>>>>
>>>
>>> This patch doesn't make any difference on my sil3114 controller.  
>>> I'll write about it in the m15w thread.
>>
>>
>>
>> "doesn't make any difference" I will interpret to mean there are no 
>> regressions.
>>
> 
> I wasn't clear enough.  I meant that the change did not fix the 
> seemlingly-m15w problems on 3114.

That's expected.  3114 should work (or not) as before.


>>> Also, this patch doesn't implement proper handling of PIO protocols 
>>> and thus breaks ALL branch.
>>
>>
>>
>> PIO should work fine, modulo the obvious changes for ATA_FLAG_NOINTR 
>> disappearance.
>>
> 
> I took out ATA_FLAG_NOINTR test from sata_sil in the latest ALL branch 
> and tested it.  It fails to read IDENTIFY data.  Actually, there is no 
> code to read PIO data.  It should be done in the interrupt handler but 
> sil_port_irq doesn't do it.

Correct.  sata_sil only works against upstream 2.6.x, not 
libata-dev.git#ALL.

The next step is to support PIO-via-DMA, but supporting the updates in 
the irq-pio branch may also be a good next-step.


>> That's the preferred way to handle interrupts on this hardware.  
>> Normal ATA is broken due to the lack of a way to ask "did I receive an 
>> interrupt?" without unduly affecting state.  311x, like AHCI, 
>> sata_sil24 and other hardware, provides a method to easily determine 
>> if a PCI interrupt is owned by the hardware or not.
>>
> 
> Ah... I see.  Section 7.4 of sii3112 manual says that
> 
> Wait until an IDE channel interrupt (bit 11 in the IDEx Task File Timing 
> + Configuration + Status register is set).
> 
> Where the register is at BAR5 + 0xA0 and bit 11 is
> 
> • Bit [11]: Interrupt Status (R) – IDE0 Interrupt Status. This bit set 
> indicates that an interrupt is pending on IDE0. This bit provides 
> real-time status of the IDE0 interrupt pin.
> 
> And, section 6.7.1 (PCI bus master - IDE0 register) says
> 
> • Bit [18]: IDE0 DMA Comp (R/W1C) – IDE0 DMA Completion Interrupt. 
> During write DMA operation, This bit set indicates that the IDE0 
> interrupt has been asserted and all data has been written to system 
> memory. During Read DMA, This bit set indicates that the IDE0 interrupt 
> has been asserted. This bit must be W1C by software when set during DMA 
> operation (bit 0 is set). During normal operation, this bit reflects 
> IDE0 interrupt line.
> 
> So, the last sentence means that while on DMA command is in progress, 
> bit 18 of the PCI bus master is identical to bit 11 of the conf/status 
> register.  Right?

Not quite.  When the operation is DMA, the 8-bit bmdma status reflects 
the DMA operation.  When the operation is not DMA, the status reflects 
the IDE interrupt line.


> Yeap, I agree that this is a good change although it hurts a little bit 
> that it causes a few extra PCI transactions.

What, for the non-existent ports?

Further code should be added to disable the interrupts for the disabled 
ports, then we can skip the check.


> Also, it seems a little bit weird that the code enters interrupt 
> handling even for ports which don't have ATA_DMA_INTR set, although I 
> don't think the current code would bogusly finish commands due to the 
> ATA_BUSY check.  Is this intentional?

dma_stat_mask==0 check needs to be added, for non-DMA commands.  That's 
about it.

	Jeff


