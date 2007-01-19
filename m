Return-Path: <linux-kernel-owner+w=401wt.eu-S964925AbXASVjs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964925AbXASVjs (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 16:39:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964932AbXASVjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 16:39:46 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:32126 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964925AbXASVjp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 16:39:45 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Qc8MqwKwkAsccKSA7tXgSCqvQaq6P3q683KwHe2iQgFszMYiUIIHPGc/aOU6aw9rTKQLbt8HJpPfyS/6u7HDEPqtzFPT7diiFVTelwxbFrgu5U/levNlZKTXtXVdLPta329UomcdYgQdwtGjp0p2NAVnCMHaID3LjdTuSUUZ4tc=
Message-ID: <45B13B8D.2020402@gmail.com>
Date: Fri, 19 Jan 2007 22:43:41 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/15] ide: disable DMA in ->ide_dma_check for "no IORDY"
 case
References: <20070119003058.14846.43637.sendpatchset@localhost.localdomain>	 <20070119003154.14846.87217.sendpatchset@localhost.localdomain>	 <45B0F12B.3000202@ru.mvista.com>	 <58cb370e0701191047h524434eobdb9d86ed614bc71@mail.gmail.com>	 <45B117D4.7050406@gmail.com> <45B11D8D.8070105@ru.mvista.com> <58cb370e0701191200i10119313i4aacae9c504a02e4@mail.gmail.com>
In-Reply-To: <58cb370e0701191200i10119313i4aacae9c504a02e4@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
>>>> [PATCH] ide: disable DMA in ->ide_dma_check for "no IORDY" case
> 
>>>   I've looked thru the code, and found more issues with the PIO fallback
>>> there. Will try to cook up patches for at least some drivers...
> 
>> Great, if possible please base them on top of the IDE tree...
> 
>    Erm, I had doubts about it (having in mind that all that code is more of a
> cleanups than fixes). Maybe it'd be a good idea to separate the fix and
> cleanup series somehow...

I generally tend do cleanups as a groundwork for the real fixes and separate
cleanups and fixes to have good base for dealing with regressions.  Often all
changes (cleanups/fixes) could be included in one patch but then I would have
had harsh times when debugging the regressions.  It matters a lot if you hit
an unknown (or known but the documentation is covered by NDA) hardware bug
- you can concentrate on a small patch changing the way in which hardware is
accessed instead of that big patch moving code around etc.

Also the thing is that the same bugs are propagated over many drivers so doing
cleanups which merge code before fixing the bug makes sense.  We can then fix
the damn bug once and for all and not worry about somebody copy-n-pasting
the bug from the yet-to-be-fixed driver (i.e. in the next patch IDE update
there will be patch to check return value of ->speedproc in ide_tune_dma(),
without ide-fix-dma-mask/ide-max-dma-mode/ide-tune-dma-helper patches
I would have to go over all drivers to fix this bug and still there won't
be a guarantee that same bug wouldn't be introduced in some new driver).

The other advantage of doing cleanups is that code becomes cleaner/simpler
which matters a lot for this codebase, i.e. ide-dma-off-void.patch exposed
(yet to be fixed) bug in set_using_dma() (->ide_dma_off_quietly always returns
0 which is passed by ->ide_dma_check to set_using_dma() which incorrectly
then calls ->ide_dma_on).

Moreover I don't find the current tree to be more of cleanups than fixes,
here is the analysis of current series file:

#
# -pata extraversion
#
pata-extraversion.patch
	-- n/a
#
# IDE patches from 2.6.20-rc3-mm1
#
toshiba-tc86c001-ide-driver-take-2.patch
toshiba-tc86c001-ide-driver-take-2-fix.patch
toshiba-tc86c001-ide-driver-take-2-fix-2.patch
	-- new driver
hpt3xx-rework-rate-filtering.patch
hpt3xx-rework-rate-filtering-tidy.patch
hpt3xx-print-the-real-chip-name-at-startup.patch
hpt3xx-switch-to-using-pci_get_slot.patch
hpt3xx-cache-channels-mcr-address.patch
hpt3x7-merge-speedproc-handlers.patch
hpt370-clean-up-dma-timeout-handling.patch
hpt3xx-init-code-rewrite.patch
piix-fix-82371mx-enablebits.patch
piix-tuneproc-fixes-cleanups.patch
slc90e66-carry-over-fixes-from-piix-driver.patch
hpt36x-pci-clock-detection-fix.patch
jmicron-warning-fix.patch
	-- fixes (but most have cleanups mixed in)
pdc202xx_new-remove-useless-code.patch
pdc202xx_-remove-check_in_drive_lists-abomination.patch
	-- cleanups
#
# IDE patches applied by Andrew (2.6.20-rc4-mm1)
#
atiixpc-remove-unused-code.patch
	-- cleanup
atiixpc-sb600-ide-only-has-one-channel.patch
atiixpc-add-cable-detection-support-for-ati-ide.patch
ide-generic-jmicron-has-its-own-drivers-now.patch
	-- fixes
ide-maintainers-entry.patch
	-- n/a
#
# IT8213
#
it8213-ide-driver.patch
it8213-ide-driver-update.patch
	-- new driver
#
# patches posted on Jan 11 2007
#
ia64-pci_get_legacy_ide_irq.patch
ide-pci-init-tags.patch
	-- fixes
pdc202xx_old-dead-code.patch
au1xxx-dead-code.patch
ide-pio-blacklisted.patch
ide-no-dsc-flag.patch
trm290-dma-ifdefs.patch
ide-pci-device-tables.patch
ide-dev-openers.patch
hpt366-init-dma.patch
cs5530-cleanup.patch
svwks-cleanup.patch
sis5513-config-xfer-rate.patch
ide-set-xfer-rate.patch
ide-use-fast-pio-v2.patch
ide-io-cleanup.patch
	-- cleanups
#
# Delkin CardBus CF driver (Mark Lord <mlord@pobox.com>)
#
delkin_cb-ide-driver.patch
	-- new driver
#
# IDE ACPI support (Hannes Reinecke <hare@suse.de>)
#
ide-acpi-support.patch
	-- new functionality (fixes PM on some machines)
#
# ide-pnp exit fix (Tejun Heo <htejun@gmail.com>)
#
ide-pnp-exit-fix.patch
	-- fix
#
# VIA IDE update (Josepch Chan <josephchan@via.com.tw>)
#
via-ide-update.patch
	-- fix
#
# patches posted on 18 Jan 2007
#
it8213-ide-driver-update-fixes.patch
	-- fix
ide-mmio-flag.patch
	-- cleanup
hpt34x-tune-chipset-fix.patch
	-- fix
ide-fix-pio-fallback.patch
	-- fix
piix-cleanup.patch
	-- cleanup
ide-dma-check-disable-dma-fix.patch
sgiioc4-ide-dma-check-fix.patch
	-- fixes
ide-set-dma-helper.patch
ide-dma-off-void.patch
ide-dma-host-on-void.patch
ide-fix-dma-masks.patch
ide-max-dma-mode.patch
ide-tune-dma-helper.patch
	-- cleanups

So it looks more like 50-50 with majority of fixes coming from you :)

However I understand that for some applications (stable distro etc) fixes
only tree would be more desired and if somebody would like to maintain
such tree I'm all for it. :)

OTOH getting patches against vanilla or -mm is perfectly fine with me
and if you would like me to shuffle ordering of the patches (but without
need of rewritting them) it also OK

>>>> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
>>>> Index: b/drivers/ide/pci/aec62xx.c
>>>> ===================================================================
>>>> --- a/drivers/ide/pci/aec62xx.c
>>>> +++ b/drivers/ide/pci/aec62xx.c
>>>> @@ -214,12 +214,10 @@ static int aec62xx_config_drive_xfer_rat
>>>>      if (ide_use_dma(drive) && config_chipset_for_dma(drive))
>>>>              return hwif->ide_dma_on(drive);
>>>>
>>>> -     if (ide_use_fast_pio(drive)) {
>>>> +     if (ide_use_fast_pio(drive))
>>>>              aec62xx_tune_drive(drive, 5);
>>>
>>>   This function looks like it's working (thouugh having the wrong
>>> limit of
>>> PIO5 on auto-tuning) but is unnecassary complex.
> 
>> Yes, it seems that there are actually two bugs here:
>> * the maximum allowed PIO mode should be PIO4 not PIO5
>> * for auto-tuning ("pio" == 255) it incorrectly sets PIO0
>>   (255 fails to the default case in the switch statement)
> 
>    Yeah, you if you pass 255, it won't work (so, drive->autotune must be
> broken). But the driver itself have the wrong idea of 5 meaning auto-tune, so
> fallback should still work.

Yep.

>>>   Heh, the driver is certainly a rip-off form hpt366.c. What a doubtful
>>> example they have chosen... :-)
> 
>> hehe
> 
>    The driver's authorship explains it all. :-)
> 
>>>> Index: b/drivers/ide/pci/atiixp.c
>>>> ===================================================================
>>>> --- a/drivers/ide/pci/atiixp.c
>>>> +++ b/drivers/ide/pci/atiixp.c
>>>> @@ -264,10 +264,9 @@ static int atiixp_dma_check(ide_drive_t
>>>>              tspeed = ide_get_best_pio_mode(drive, 255, 5, NULL);
>>>>              speed = atiixp_dma_2_pio(XFER_PIO_0 + tspeed) +
>>>> XFER_PIO_0;
> 
>>>   It's simply stupid to convert PIO mode to PIO mode. The whole idea is
>>> doubtful as well..
> 
>> It is side-effect of basing atiixp on piix driver.  Fixing it will allow PIO1
>> to be used (good) because atiixp_dma_2_pio() always downgrades PIO1 to PIO0
>> (leftover from piix - on Intel chipsets same timings are used for PIO0/1).
> 
>>>>              hwif->speedproc(drive, speed);
> 
>>>   Well, well, the tuneproc() method can't ahndle auto-tunuing here
>>> (255)...
> 
>> Yes, definitely a bug.
> 
>    Ugh... don't expect patches form me soon though. My first priority is the
> drivers that we support here...

OK, added at the end of my TODO (just in case)

>>> And it also doesn't set up drive's own speed. The code seem to be another
>>> rip-off from piix.c, repeating all its mistakes... :-)
> 
>> :)
> 
>>>> Index: b/drivers/ide/pci/cmd64x.c
>>>> ===================================================================
>>>> --- a/drivers/ide/pci/cmd64x.c
>>>> +++ b/drivers/ide/pci/cmd64x.c
>>>> @@ -479,12 +479,10 @@ static int cmd64x_config_drive_for_dma (
>>>>      if (ide_use_dma(drive) && config_chipset_for_dma(drive))
>>>>              return hwif->ide_dma_on(drive);
>>>>
>>>> -     if (ide_use_fast_pio(drive)) {
>>>> +     if (ide_use_fast_pio(drive))
>>>>              config_chipset_for_pio(drive, 1);
> 
>>>   This function will always set PIO mode 4. Mess.
> 
>> Yep.
> 
>    I'm going to send the patch for both this and siimage.c...

OK

>>>> Index: b/drivers/ide/pci/cs5535.c
>>>> ===================================================================
>>>> --- a/drivers/ide/pci/cs5535.c
>>>> +++ b/drivers/ide/pci/cs5535.c
>>>> @@ -206,10 +206,9 @@ static int cs5535_dma_check(ide_drive_t
>>>>      if (ide_use_fast_pio(drive)) {
>>>>              speed = ide_get_best_pio_mode(drive, 255, 4, NULL);
>>>>              cs5535_set_drive(drive, speed);
> 
>>>   Could be folded into tuneproc() method call.
> 
>> Using ->tuneproc() will also set the PIO mode on the drive
>> which is not done currently...
> 
>    Hm, ide_config_drive_speed() is called by both tuneproc() method and
> cs5535_set_drive(), so I saw no issue there...

indeed

>>>> Index: b/drivers/ide/pci/sis5513.c
>>>> ===================================================================
>>>> --- a/drivers/ide/pci/sis5513.c
>>>> +++ b/drivers/ide/pci/sis5513.c
>>>> @@ -678,12 +678,10 @@ static int sis5513_config_xfer_rate(ide_
>>>>      if (ide_use_dma(drive) && config_chipset_for_dma(drive))
>>>>              return hwif->ide_dma_on(drive);
> 
>>>> -     if (ide_use_fast_pio(drive)) {
>>>> +     if (ide_use_fast_pio(drive))
>>>>              sis5513_tune_drive(drive, 5);
> 
>>>    Ugh, PIO fallback effectively always tries to set mode 4 here (thanks
>>> it's not 5). Mess.
> 
>> Yep, but it seems to be even more complicated since config_art_rwp_pio()
>> is a mess^2 - chipset is programmed to the best PIO mode while the
>> device is set to PIO4... *sigh*...
> 
>    Sorry, this one is low prio for me... :-)

OK

Bart

