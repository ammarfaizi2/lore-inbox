Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268307AbUHKWyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268307AbUHKWyE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 18:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268305AbUHKWwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 18:52:09 -0400
Received: from mta2.srv.hcvlny.cv.net ([167.206.5.68]:26920 "EHLO
	mta2.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S268299AbUHKWtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 18:49:16 -0400
Date: Wed, 11 Aug 2004 18:48:44 -0400
From: Nathan Bryant <nbryant@optonline.net>
Subject: Re: [PATCH] SCSI midlayer power management
In-reply-to: <1092262602.3553.14.camel@laptop.cunninghams>
To: ncunningham@linuxmail.org
Cc: Pavel Machek <pavel@ucw.cz>,
       "'James Bottomley'" <James.Bottomley@steeleye.com>,
       Linux SCSI Reflector <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jgarzik@pobox.com
Message-id: <411AA24C.6050303@optonline.net>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
References: <4119611D.60401@optonline.net> <20040811080935.GA26098@elf.ucw.cz>
 <411A1B72.1010302@optonline.net> <1092262602.3553.14.camel@laptop.cunninghams>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham wrote:

>Hi.
>
>On Wed, 2004-08-11 at 23:13, Nathan Bryant wrote:
>  
>
>>>>ACPI S1 and S4/swsusp are untested, but I think there should be no
>>>>regressions with S1. To do S1 properly, we probably need to tell the
>>>>drive to spin down, and I don't know what the SCSI command is for
>>>>that... For S4, the call to scsi_device_quiesce might pose a problem for
>>>>the subsequent state dump to disk. But I'm not sure swsusp ever worked
>>>>for SCSI.
>>>>        
>>>>
>
>I tried it on an OSDL machine and could suspend (suspend 2), but only
>resume as far as copying back the original kernel. The problem then
>looked to me like it was request ids not matching what the drive was
>expecting (but I'm ignorant of scsi, so might be completely wrong
>there).
>  
>
I saw "no match for command buffer" interrupt storms when I was fixing 
up aic7xxx for S3. The problem was due to not reprogramming the address 
of our SCB's on resume. Needed to tell the card the base address for all 
the DMA structures.

Just to speculate about what would be required for swsusp: you probably 
need to be using a SCSI LLD that properly implements pci suspend/resume, 
which implies you need to make sure the card's DMA state machine is 
flushed and idle before suspend completes. I've got a patch that fixes 
this much up for aic7xxx. And my other midlayer-level patch may also 
help... What happens during resume is interesting. I think maybe the 
problem is not what the drive is expecting, but what the card's state 
engine is expecting when it tries to map commands to command buffers in 
DMA space.  Maybe you need to suspend the LLD from the context of the 
kernel that is doing the image load, and then resume from the context of 
the kernel that was just loaded.

Sounds like this is why Pavel is asking about DMA. So he'll need to 
manage calling the host adapter's suspend callbacks, not just 
generic_scsi_suspend. DMA base addresses are likely to change when you 
load the new kernel image

>>answer is NO. For purposes of not suspending the drivers, I haven't 
>>looked into how swsusp would see which host adapter owns which drive, 
>>but some of the required information seems to be present in sysfs.
>>    
>>
>
>With my 'device tree' code, I'm getting the struct dev of the device
>we're using via the struct block_device in the swap_info struct.
>  
>
Right, though you also need to get the host adapter's struct device, if 
you're not already doing so, that is. Many IDE host drivers don't bother 
with suspend/resume callbacks at the pci_driver level, but SCSI needs 
callbacks because the BIOS usually doesn't handle things for us.

Nathan
