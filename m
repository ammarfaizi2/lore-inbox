Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268051AbUHKNNb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268051AbUHKNNb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 09:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268056AbUHKNNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 09:13:31 -0400
Received: from mta8.srv.hcvlny.cv.net ([167.206.5.75]:56004 "EHLO
	mta8.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S268051AbUHKNNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 09:13:23 -0400
Date: Wed, 11 Aug 2004 09:13:22 -0400
From: Nathan Bryant <nbryant@optonline.net>
Subject: Re: [PATCH] SCSI midlayer power management
In-reply-to: <20040811080935.GA26098@elf.ucw.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: "'James Bottomley'" <James.Bottomley@steeleye.com>,
       Linux SCSI Reflector <linux-scsi@vger.kernel.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>, jgarzik@pobox.com
Message-id: <411A1B72.1010302@optonline.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
References: <4119611D.60401@optonline.net> <20040811080935.GA26098@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

>Hi!
>
>  
>
>>This proposed patch implements enough power-management support within
>>the SCSI midlayer to get ACPI S3 working on my system. Changes as follows:
>>
>>* Add generic_scsi_{suspend,resume} methods to scsi.c
>>* Add suspend and resume callbacks to the scsi_driver structure, and
>>implement those callbacks in sd.c
>>* In sd.c, we call sd_shutdown on suspend, in order to synchronize the
>>write-back cache.
>>* In sd.c, we call sd_rescan from sd_resume in order to ensure that
>>drives have spun up and avoid passing not ready errors back to the block
>>layer.
>>* In generic_scsi_suspend, we call scsi_device_quiesce before calling
>>the scsi_driver suspend callback. We resume from quiesce state in
>>reverse order in generic_scsi_resume.
>>
>>ACPI S1 and S4/swsusp are untested, but I think there should be no
>>regressions with S1. To do S1 properly, we probably need to tell the
>>drive to spin down, and I don't know what the SCSI command is for
>>that... For S4, the call to scsi_device_quiesce might pose a problem for
>>the subsequent state dump to disk. But I'm not sure swsusp ever worked
>>for SCSI.
>>    
>>
>
>swsusp will then resume disk and write the image, that should not be a
>problem. Is it guaranteed that after generic_scsi_suspend() no DMA is
>going on?
>  
>
No. Remember that DMA works differently under SCSI than it does under 
IDE. SCSI DMA is a host controller feature, whereas under IDE it is 
enabled/disabled at the drive level and the drives have special 
knowledge of DMA. Since generic_scsi_suspend() is the device level 
suspend routine, it is called before the host controller's suspend 
routine, (due to depth first traversal of device tree), which is 
responsible for disabling the PCI slot. Only after the host controller 
is suspended will there be no DMA, but if your real question is "can I 
generically control a SCSI disk with PIO for software suspend" then the 
answer is NO. For purposes of not suspending the drivers, I haven't 
looked into how swsusp would see which host adapter owns which drive, 
but some of the required information seems to be present in sysfs.

Now, I don't know how disabling DMA is supposed to behave under SATA. 
There may be something extra we have to do that isn't really standard 
SCSI... SATA is a weird beast and if somebody is using libata it seems 
it might not be possible to use PIO, since enhanced mode might have to 
be enabled at the BIOS. But I don't know this stuff, ask jgarzik.

>Anyway, you should try swsusp, preferably on some IDE notebook first
>and prefereably -mm one, to get feel how it works. It should be
>possible/easy to make it work with SCSI...
>  
>
Does it depend on IDE PIO for some reason? Perhaps related to writing 
out a consistent memory image? I'm not sure if I'm motivated to do 
anything about that ;)

>>This might help SATA drives, too, but I seem to remember that the SATA
>>layer doesn't properly emulate the SYNCHRONIZE_CACHE command.
>>
>>Comments, anybody? Can this be applied upstream? I think it's a step in
>>the right direction.
>>    
>>
>
>Looks good to me.
>								Pavel
>  
>
Thanks.
Nathan
