Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965660AbWKNNdt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965660AbWKNNdt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 08:33:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965663AbWKNNdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 08:33:49 -0500
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:32441 "EHLO
	mtaout01-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S965660AbWKNNds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 08:33:48 -0500
To: Jeff Garzik <jeff@garzik.org>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       htejun@gmail.com, jim.kardach@intel.com, ak@suse.de
Subject: Re: AHCI power saving
X-Home-Page: http://john.fremlin.org
From: John Fremlin <not@just.any.name>
In-Reply-To: <45589008.1080001@garzik.org> (Jeff Garzik's message of "Mon, 13 Nov 2006 10:32:24 -0500")
References: <87k639u55l.fsf-genuine-vii@john.fremlin.org>
	<20061009215221.GC30702@elf.ucw.cz>
	<87ods6loe8.fsf-genuine-vii@john.fremlin.org>
	<20061025070920.GG5851@elf.ucw.cz>
	<87y7r3xlif.fsf-genuine-vii@john.fremlin.org>
	<20061026204655.GA1767@elf.ucw.cz>
	<87slgv6ccz.fsf-genuine-vii@john.fremlin.org>
	<20061112183614.GA5081@ucw.cz>
	<87hcx3adcd.fsf-genuine-vii@john.fremlin.org>
	<20061113142219.GA2703@elf.ucw.cz> <45589008.1080001@garzik.org>
X-Hashcash: 1:18:061114:jeff@garzik.org::iounanu+896QSduy:001CGC
X-Hashcash: 1:18:061114:pavel@ucw.cz::kDrKrvE1TPA28hUH:000001PAB
X-Hashcash: 1:18:061114:linux-kernel@vger.kernel.org::D4cMAPEcw2VyygTQ:0000000000000000000000000000000003PRQ
X-Hashcash: 1:18:061114:htejun@gmail.com::31JRqzdcUAzrKncL:00KYY
X-Hashcash: 1:18:061114:jim.kardach@intel.com::ehOjNwGO7FS+AFea:00000000000000000000000000000000000000002adS
X-Hashcash: 1:18:061114:ak@suse.de::7xJxQSPF2FA33gv/:00000000BDo
Date: Tue, 14 Nov 2006 13:33:14 +0000
Message-ID: <87slgmrw4l.fsf-genuine-vii@john.fremlin.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jeff@garzik.org> writes:

> Pavel Machek wrote:
>> --- a/drivers/ata/ahci.c
>> +++ b/drivers/ata/ahci.c
>> @@ -148,6 +148,8 @@ enum {
>>  				  PORT_IRQ_PIOS_FIS | PORT_IRQ_D2H_REG_FIS,
>>   	/* PORT_CMD bits */
>> +	PORT_CMD_ALPE		= (1 << 27), /* Aggressive Link Power Management Enable */
>> +	PORT_CMD_ASP		= (1 << 26), /* Aggressive entrance to Slumber or Partial power management states */
>>  	PORT_CMD_ATAPI		= (1 << 24), /* Device is ATAPI */
>>  	PORT_CMD_LIST_ON	= (1 << 15), /* cmd list DMA engine running */
>>  	PORT_CMD_FIS_ON		= (1 << 14), /* FIS DMA engine running */
>> @@ -486,7 +488,7 @@ static void ahci_power_up(void __iomem *
>>  	}
>>   	/* wake up link */
>> -	writel(cmd | PORT_CMD_ICC_ACTIVE, port_mmio + PORT_CMD);
>> +	writel(cmd | PORT_CMD_ICC_ACTIVE | PORT_CMD_ALPE | PORT_CMD_ASP, port_mmio + PORT_CMD);
>
>
> Therein lies a key problem.  Turning on all of AHCI's aggressive
> power management features DOES save a lot of power.  But at the same
> time, it shortens the life of your hard drive, particularly hard
> drives that are really PATA, but have a PATA<->SATA bridge glued on
> the drive to enable connection to SATA controllers.

Are you sure? I thought that these bits will only affect the SATA
communication between the chipset on the motherboard and the chipset
on the drive and are not related to the drive's spinning at all.

Please note that the patch is incorrect because not all AHCI chipsets
support these PM features. It would probably be best to make it
optional: it might slow down drive access, but does certainly save the
environment a little.

