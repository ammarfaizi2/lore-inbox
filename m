Return-Path: <linux-kernel-owner+w=401wt.eu-S965341AbXATSRn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965341AbXATSRn (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 13:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965345AbXATSRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 13:17:43 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:44664 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965341AbXATSRl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 13:17:41 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=lj9Fu//j3lDWg1WcIiVGgDijx/5KTvhl+m0Ix6DsT6mRnzqHpai43uwHrRt6PoahTjH5xNT1VNWBKfZdbVV5foeFNFaqxNFckzvJgSv0FgDxhzKahRZAh/4RX343ZsRZA12i6XVpVowiiHinJYFVjCj3Tw4P3/XgrE9BiSEQrrc=
Message-ID: <45B25DB7.8050903@gmail.com>
Date: Sat, 20 Jan 2007 19:21:43 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/15] ide: disable DMA in ->ide_dma_check for "no IORDY"
 case
References: <20070119003058.14846.43637.sendpatchset@localhost.localdomain>	 <20070119003154.14846.87217.sendpatchset@localhost.localdomain>	 <45B0F12B.3000202@ru.mvista.com>	 <58cb370e0701191047h524434eobdb9d86ed614bc71@mail.gmail.com>	 <45B117D4.7050406@gmail.com> <45B11D8D.8070105@ru.mvista.com>	 <58cb370e0701191200i10119313i4aacae9c504a02e4@mail.gmail.com>	 <45B13B8D.2020402@gmail.com> <45B24CBA.8080900@ru.mvista.com> <58cb370e0701200947p578f4d74g1fee511ded6c9a77@mail.gmail.com>
In-Reply-To: <58cb370e0701200947p578f4d74g1fee511ded6c9a77@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
>>>>>  I've looked thru the code, and found more issues with the PIO fallback
>>>>> there. Will try to cook up patches for at least some drivers...
> 
>>>> Great, if possible please base them on top of the IDE tree...
> 
>>>   Erm, I had doubts about it (having in mind that all that code is more of a
>>> cleanups than fixes). Maybe it'd be a good idea to separate the fix and
>>> cleanup series somehow...
> 
>> I generally tend do cleanups as a groundwork for the real fixes and separate
>> cleanups and fixes to have good base for dealing with regressions.  Often all
>> changes (cleanups/fixes) could be included in one patch but then I would have
>> had harsh times when debugging the regressions.  It matters a lot if you hit
>> an unknown (or known but the documentation is covered by NDA) hardware bug
>> - you can concentrate on a small patch changing the way in which hardware is
>> accessed instead of that big patch moving code around etc.
> 
>> Also the thing is that the same bugs are propagated over many drivers so doing
>> cleanups which merge code before fixing the bug makes sense.  We can then fix
>> the damn bug once and for all and not worry about somebody copy-n-pasting
>> the bug from the yet-to-be-fixed driver (i.e. in the next patch IDE update
>> there will be patch to check return value of ->speedproc in ide_tune_dma(),
>> without ide-fix-dma-mask/ide-max-dma-mode/ide-tune-dma-helper patches
>> I would have to go over all drivers to fix this bug and still there won't
>> be a guarantee that same bug wouldn't be introduced in some new driver).
> 
>> The other advantage of doing cleanups is that code becomes cleaner/simpler
>> which matters a lot for this codebase, i.e. ide-dma-off-void.patch exposed
>> (yet to be fixed) bug in set_using_dma() (->ide_dma_off_quietly always returns
>> 0 which is passed by ->ide_dma_check to set_using_dma() which incorrectly
>> then calls ->ide_dma_on).
> 
>    Well, this seems a newly intruduced bug.

The old code is so convulted that it is hard to see it w/o cleanup. :)

->ide_dma_check implementations often do

		return hwif->ide_dma_off_quietly(drive);

so the return value of ide_dma_off_quietly() (which is always 0) is passed to

			if (HWIF(drive)->ide_dma_check(drive)) return -EIO;

in ide.c:set_using_dma() -> as a result the next line is executed

			if (HWIF(drive)->ide_dma_on(drive)) return -EIO;

>    It's all fine but goes somewhat against Linus' policy as far as I
> understnad it: fixes are merged all the time while cleanups (along with new
> code) are merged mostly duting the merge window.
> 
>> Moreover I don't find the current tree to be more of cleanups than fixes,
>> here is the analysis of current series file:
> 
>    Maybe I slightly exaggerated, being impressed by the volume of your recent
> changes. :-)
>    But still...
> 
>> #
>> # IDE patches from 2.6.20-rc3-mm1
>> #
>> toshiba-tc86c001-ide-driver-take-2.patch
>> toshiba-tc86c001-ide-driver-take-2-fix.patch
>> toshiba-tc86c001-ide-driver-take-2-fix-2.patch
>>       -- new driver
> 
>     I'd count that as cleanup, since it's definitely not fix. ;-)
> 
>> hpt3xx-rework-rate-filtering.patch
>> hpt3xx-rework-rate-filtering-tidy.patch
>> hpt3xx-print-the-real-chip-name-at-startup.patch
>> hpt3xx-switch-to-using-pci_get_slot.patch
>> hpt3xx-cache-channels-mcr-address.patch
>> hpt3x7-merge-speedproc-handlers.patch
>> hpt370-clean-up-dma-timeout-handling.patch
>> hpt3xx-init-code-rewrite.patch
>> piix-fix-82371mx-enablebits.patch
>> piix-tuneproc-fixes-cleanups.patch
>> slc90e66-carry-over-fixes-from-piix-driver.patch
>> hpt36x-pci-clock-detection-fix.patch
>> jmicron-warning-fix.patch
>>       -- fixes (but most have cleanups mixed in)
> 
>    Yeah, but not that those came in from the -mm tree.
> 
>> pdc202xx_new-remove-useless-code.patch
>> pdc202xx_-remove-check_in_drive_lists-abomination.patch
>>       -- cleanups
>> #
>> # IDE patches applied by Andrew (2.6.20-rc4-mm1)
>> #
>> atiixpc-remove-unused-code.patch
>>       -- cleanup
>> atiixpc-sb600-ide-only-has-one-channel.patch
>> atiixpc-add-cable-detection-support-for-ati-ide.patch
>> ide-generic-jmicron-has-its-own-drivers-now.patch
>>       -- fixes
> 
>    Same about these 3.
> 
>> ide-maintainers-entry.patch
>>       -- n/a
>> #
>> # IT8213
>> #
>> it8213-ide-driver.patch
>> it8213-ide-driver-update.patch
>>       -- new driver
>> #
>> # patches posted on Jan 11 2007
>> #
>> ia64-pci_get_legacy_ide_irq.patch
>> ide-pci-init-tags.patch
>>       -- fixes
>> pdc202xx_old-dead-code.patch
>> au1xxx-dead-code.patch
>> ide-pio-blacklisted.patch
>> ide-no-dsc-flag.patch
>> trm290-dma-ifdefs.patch
>> ide-pci-device-tables.patch
>> ide-dev-openers.patch
>> hpt366-init-dma.patch
>> cs5530-cleanup.patch
>> svwks-cleanup.patch
>> sis5513-config-xfer-rate.patch
>> ide-set-xfer-rate.patch
>> ide-use-fast-pio-v2.patch
>> ide-io-cleanup.patch
>>       -- cleanups
>> #
>> # Delkin CardBus CF driver (Mark Lord <mlord@pobox.com>)
>> #
>> delkin_cb-ide-driver.patch
>>       -- new driver
>> #
>> # IDE ACPI support (Hannes Reinecke <hare@suse.de>)
>> #
>> ide-acpi-support.patch
>>       -- new functionality (fixes PM on some machines)
>> #
>> # ide-pnp exit fix (Tejun Heo <htejun@gmail.com>)
>> #
>> ide-pnp-exit-fix.patch
>>       -- fix
>> #
>> # VIA IDE update (Josepch Chan <josephchan@via.com.tw>)
>> #
>> via-ide-update.patch
>>       -- fix
> 
>    I'd put fixes before the rewrites and new code...

OK, I'll shuffle the patches.

[ + I want to put it to Linus ASAP ]

>> #
>> # patches posted on 18 Jan 2007
>> #
>> it8213-ide-driver-update-fixes.patch
>>       -- fix
> 
>    Well, this is a fix to the newly added driver, so may go anywhere
> after it...

OK.

>> ide-mmio-flag.patch
>>       -- cleanup
>> hpt34x-tune-chipset-fix.patch
>>       -- fix
>> ide-fix-pio-fallback.patch
>>       -- fix
> 
>    Those 2 are seem more of a cleanup to me...

They fix real but quite hard to hit bugs.
I'll put them at the end of the fixes series.

>> piix-cleanup.patch
>>       -- cleanup
>> ide-dma-check-disable-dma-fix.patch
>> sgiioc4-ide-dma-check-fix.patch
>>       -- fixes
> 
>    This one also seems more of a cleanup...

ditto

>> ide-set-dma-helper.patch
>> ide-dma-off-void.patch
>> ide-dma-host-on-void.patch
>> ide-fix-dma-masks.patch
>> ide-max-dma-mode.patch
>> ide-tune-dma-helper.patch
>>       -- cleanups
> 
>    Would make sense to keep those last in the tail of queue because of the
> amount of changes they introduce.  Possibly even IDE subsystem wide cleanups

They are at the end already - no problem here. :)

> after the driver specific cleanups, although this is arguable...

Yep, makes sense.

>> So it looks more like 50-50 with majority of fixes coming from you :)
> 
>> However I understand that for some applications (stable distro etc) fixes
>> only tree would be more desired
> 
>    Yeah, I'm really not eager to pull in the ton of cleanups for a couple of
> fixes which won't apply otherwise (or have to rebase the fixes because of that).
> 
>> and if somebody would like to maintain such tree I'm all for it. :)
> 
>    Well, we have the -mm tree. :-)
> 
>    I certainly have no time/bandwidth to spend on maintaining a tree, at
> least for the moment being.
> 
>> OTOH getting patches against vanilla or -mm is perfectly fine with me
> 
>    Thanks. Will send further patches to you only, not Andrew (with the notice
> of the kernel they should apply to).

OK, thanks.

>> and if you would like me to shuffle ordering of the patches (but without
>> need of rewritting them) it also OK
> 
>    Erm, no talking about the rewrite but that way you may have to rebase
> cleanups on top of fixes.  This seems unavoidble though due to the way the
> kernel patch acceptance process is working, as far as I understand it...

I'll change the ordering of the patches based on your suggestions
and generally try to keep such order of fixes first and cleanups later.

With systematic and frequent syncing with mainstream keeping this order
should be even less of problem.

>>>>>> Index: b/drivers/ide/pci/cmd64x.c
>>>>>> ===================================================================
>>>>>> --- a/drivers/ide/pci/cmd64x.c
>>>>>> +++ b/drivers/ide/pci/cmd64x.c
>>>>>> @@ -479,12 +479,10 @@ static int cmd64x_config_drive_for_dma (
>>>>>>     if (ide_use_dma(drive) && config_chipset_for_dma(drive))
>>>>>>             return hwif->ide_dma_on(drive);
>>>>>>
>>>>>> -     if (ide_use_fast_pio(drive)) {
>>>>>> +     if (ide_use_fast_pio(drive))
>>>>>>             config_chipset_for_pio(drive, 1);
> 
>>>>>  This function will always set PIO mode 4. Mess.
> 
>>>> Yep.
> 
>>>   I'm going to send the patch for both this and siimage.c...
> 
>> OK
> 
>    Not sure if I'll be able to find a card to test it soon though (I prefer
> to test my stuff before submitting, even the simple changes :-).

Please send it anyway.

Thanks,
Bart
