Return-Path: <linux-kernel-owner+w=401wt.eu-S965345AbXATSlV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965345AbXATSlV (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 13:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965344AbXATSlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 13:41:21 -0500
Received: from homer.mvista.com ([63.81.120.155]:23478 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S965339AbXATSlU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 13:41:20 -0500
Message-ID: <45B2624E.4030900@ru.mvista.com>
Date: Sat, 20 Jan 2007 21:41:18 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/15] ide: disable DMA in ->ide_dma_check for "no IORDY"
 case
References: <20070119003058.14846.43637.sendpatchset@localhost.localdomain>	 <20070119003154.14846.87217.sendpatchset@localhost.localdomain>	 <45B0F12B.3000202@ru.mvista.com>	 <58cb370e0701191047h524434eobdb9d86ed614bc71@mail.gmail.com>	 <45B117D4.7050406@gmail.com> <45B11D8D.8070105@ru.mvista.com>	 <58cb370e0701191200i10119313i4aacae9c504a02e4@mail.gmail.com>	 <45B13B8D.2020402@gmail.com> <45B24CBA.8080900@ru.mvista.com> <58cb370e0701200947p578f4d74g1fee511ded6c9a77@mail.gmail.com> <45B25DB7.8050903@gmail.com>
In-Reply-To: <45B25DB7.8050903@gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>>The other advantage of doing cleanups is that code becomes cleaner/simpler
>>>which matters a lot for this codebase, i.e. ide-dma-off-void.patch exposed
>>>(yet to be fixed) bug in set_using_dma() (->ide_dma_off_quietly always returns
>>>0 which is passed by ->ide_dma_check to set_using_dma() which incorrectly
>>>then calls ->ide_dma_on).

>>   Well, this seems a newly intruduced bug.

> The old code is so convulted that it is hard to see it w/o cleanup. :)

> ->ide_dma_check implementations often do

> 		return hwif->ide_dma_off_quietly(drive);

> so the return value of ide_dma_off_quietly() (which is always 0) is passed to

> 			if (HWIF(drive)->ide_dma_check(drive)) return -EIO;

> in ide.c:set_using_dma() -> as a result the next line is executed

> 			if (HWIF(drive)->ide_dma_on(drive)) return -EIO;

    Ah, indeed! Nice. :-)

>>   It's all fine but goes somewhat against Linus' policy as far as I
>>understnad it: fixes are merged all the time while cleanups (along with new
>>code) are merged mostly duting the merge window.

>>>Moreover I don't find the current tree to be more of cleanups than fixes,
>>>here is the analysis of current series file:

>>   Maybe I slightly exaggerated, being impressed by the volume of your recent
>>changes. :-)
>>   But still...

>>>#
>>># IDE patches from 2.6.20-rc3-mm1
>>>#
>>>toshiba-tc86c001-ide-driver-take-2.patch
>>>toshiba-tc86c001-ide-driver-take-2-fix.patch
>>>toshiba-tc86c001-ide-driver-take-2-fix-2.patch
>>>      -- new driver

>>    I'd count that as cleanup, since it's definitely not fix. ;-)

>>>hpt3xx-rework-rate-filtering.patch
>>>hpt3xx-rework-rate-filtering-tidy.patch
>>>hpt3xx-print-the-real-chip-name-at-startup.patch
>>>hpt3xx-switch-to-using-pci_get_slot.patch
>>>hpt3xx-cache-channels-mcr-address.patch
>>>hpt3x7-merge-speedproc-handlers.patch
>>>hpt370-clean-up-dma-timeout-handling.patch
>>>hpt3xx-init-code-rewrite.patch
>>>piix-fix-82371mx-enablebits.patch
>>>piix-tuneproc-fixes-cleanups.patch
>>>slc90e66-carry-over-fixes-from-piix-driver.patch
>>>hpt36x-pci-clock-detection-fix.patch
>>>jmicron-warning-fix.patch
>>>      -- fixes (but most have cleanups mixed in)

>>   Yeah, but not that those came in from the -mm tree.

    Oops, "not that" didn't make sense here :-)

>>>ide-mmio-flag.patch
>>>      -- cleanup
>>>hpt34x-tune-chipset-fix.patch
>>>      -- fix
>>>ide-fix-pio-fallback.patch
>>>      -- fix

>>   Those 2 are seem more of a cleanup to me...

> They fix real but quite hard to hit bugs.
> I'll put them at the end of the fixes series.

    Well, most of the recent fixes were for such issues.  Nobody had screamed 
about them, it took a code review to find them. :-)

>>>ide-set-dma-helper.patch
>>>ide-dma-off-void.patch
>>>ide-dma-host-on-void.patch
>>>ide-fix-dma-masks.patch
>>>ide-max-dma-mode.patch
>>>ide-tune-dma-helper.patch
>>>      -- cleanups

>>   Would make sense to keep those last in the tail of queue because of the
>>amount of changes they introduce.  Possibly even IDE subsystem wide cleanups

> They are at the end already - no problem here. :)

    I meant "in the future"...

>>>and if you would like me to shuffle ordering of the patches (but without
>>>need of rewritting them) it also OK

>>   Erm, no talking about the rewrite but that way you may have to rebase
>>cleanups on top of fixes.  This seems unavoidble though due to the way the
>>kernel patch acceptance process is working, as far as I understand it...

> I'll change the ordering of the patches based on your suggestions
> and generally try to keep such order of fixes first and cleanups later.

    Thanks. :-)

>>>>>>>Index: b/drivers/ide/pci/cmd64x.c
>>>>>>>===================================================================
>>>>>>>--- a/drivers/ide/pci/cmd64x.c
>>>>>>>+++ b/drivers/ide/pci/cmd64x.c
>>>>>>>@@ -479,12 +479,10 @@ static int cmd64x_config_drive_for_dma (
>>>>>>>    if (ide_use_dma(drive) && config_chipset_for_dma(drive))
>>>>>>>            return hwif->ide_dma_on(drive);

>>>>>>>-     if (ide_use_fast_pio(drive)) {
>>>>>>>+     if (ide_use_fast_pio(drive))
>>>>>>>            config_chipset_for_pio(drive, 1);

>>>>>> This function will always set PIO mode 4. Mess.

>>>>>Yep.

>>>>  I'm going to send the patch for both this and siimage.c...

>>>OK

>>   Not sure if I'll be able to find a card to test it soon though (I prefer
>>to test my stuff before submitting, even the simple changes :-).

> Please send it anyway.

    Ugh, this one is more tough than pdc202xx_old.c -- since tuneproc() is 
also borken (doesn't set drive's own transfer mode).
    And... I looked into speedproc() handler, then into PCI0646U datasheet for 
reference and was really terrified: the code for SW/DW DMA setup us utter 
nonsense!  It writes to some reserved bits of BMIDE status reg. instead of 
doinf the real setup, and twiddles the drive 0/1 DMA capable bit which nobody 
asks it to do... Really messy mess. :-(

> Thanks,
> Bart

WBR, Sergei
