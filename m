Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261350AbVBGFDI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbVBGFDI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 00:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbVBGFDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 00:03:07 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:23128 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261350AbVBGFC4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 00:02:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=N69wAYaRoJAWU+gwlZ10PA3Aata/6GeOiS7RGcZnxqgiC5WXohG6QB7YbwYjb3KLdwWvoUNKwdmFoK67sS6PMeVKXgxa3jlLq3QzmSEB9LGAN1Btku7xta+RBc2WU9LT3BTUi9Scxrouv5ynlqPyNP7OwmABmordnsIVXuFt/uo=
Message-ID: <4206F679.8060309@gmail.com>
Date: Mon, 07 Feb 2005 14:02:49 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0 (X11/20050118)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Tejun Heo <tj@home-tj.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2 08/09] ide: map ide_cmd_ioctl() to ide_taskfile_ioctl()
References: <20050205021502.GA17767@htj.dyndns.org>	 <20050205021557.6A692132705@htj.dyndns.org> <58cb370e050206104674386588@mail.gmail.com>
In-Reply-To: <58cb370e050206104674386588@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> I have not fully reviewed it yet but I've noticed two things...
> 
> 
>>@@ -648,11 +648,11 @@ u8 eighty_ninty_three (ide_drive_t *driv
>>
>> EXPORT_SYMBOL(eighty_ninty_three);
>>
>>-int ide_ata66_check (ide_drive_t *drive, ide_task_t *args)
>>+int ide_ata66_check(ide_drive_t *drive, task_ioreg_t *regs)
>> {
>>-       if ((args->tfRegister[IDE_COMMAND_OFFSET] == WIN_SETFEATURES) &&
>>-           (args->tfRegister[IDE_SECTOR_OFFSET] > XFER_UDMA_2) &&
>>-           (args->tfRegister[IDE_FEATURE_OFFSET] == SETFEATURES_XFER)) {
>>+       if (regs[IDE_COMMAND_OFFSET] == WIN_SETFEATURES &&
>>+           regs[IDE_SECTOR_OFFSET] > XFER_UDMA_2 &&
>>+           regs[IDE_FEATURE_OFFSET] == SETFEATURES_XFER) {
>> #ifndef CONFIG_IDEDMA_IVB
>>                if ((drive->id->hw_config & 0x6000) == 0) {
>> #else /* !CONFIG_IDEDMA_IVB */
> 
> 
> What is the rationale for this change?
> ide_task_t is available in ide_cmd_ioctl().
> 

  Sorry, it was for the previous map to ide_taskfile_ioctl() 
implementation, where ide_cmd_ioctl() didn't have ide_task_t.  I'll 
restore it.  Also, I've forgot to update the description of this patch. 
  I'll fix that too.

> 
>>@@ -678,11 +678,11 @@ int ide_ata66_check (ide_drive_t *drive,
>>  * 1 : Safe to update drive->id DMA registers.
>>  * 0 : OOPs not allowed.
>>  */
>>-int set_transfer (ide_drive_t *drive, ide_task_t *args)
>>+int set_transfer(ide_drive_t *drive, task_ioreg_t *regs)
>> {
>>-       if ((args->tfRegister[IDE_COMMAND_OFFSET] == WIN_SETFEATURES) &&
>>-           (args->tfRegister[IDE_SECTOR_OFFSET] >= XFER_SW_DMA_0) &&
>>-           (args->tfRegister[IDE_FEATURE_OFFSET] == SETFEATURES_XFER) &&
>>+       if (regs[IDE_COMMAND_OFFSET] == WIN_SETFEATURES &&
>>+           regs[IDE_SECTOR_OFFSET] >= XFER_SW_DMA_0 &&
>>+           regs[IDE_FEATURE_OFFSET] == SETFEATURES_XFER &&
>>            (drive->id->dma_ultra ||
>>             drive->id->dma_mword ||
>>             drive->id->dma_1word))
> 
> 
> ditto
> 

  ditto. :-)

> 
>>+       io_32bit = drive->io_32bit;
>>+       drive->io_32bit = 0;    /* racy */
>>+       ret = ide_diag_taskfile(drive, &task, in_size, buf);
>>+       drive->io_32bit = io_32bit;
> 
> 
> It wasn't racy before this patch.  I know that it is like that
> in ide_taskfile_ioctl() but it is not an excuse for propagating
> the bug.  It can be easily fixed if you use drive_cmd_intr()
> instead of task_in_intr() as task->handler.

  Fixing the race condition in taskfile ioctl was on my to-do list, so I 
was thinking unifying the problem wouldn't be bad such that it can be 
fixed together later (soon).  I think I can make a patch to fix taskfile 
ioctl first and then submit this patch again without the race.

  Thanks.

-- 
tejun

