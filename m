Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262482AbVESMo3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262482AbVESMo3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 08:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262479AbVESMo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 08:44:29 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:35717 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S262477AbVESMoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 08:44:10 -0400
Message-ID: <428C89F8.50803@jp.fujitsu.com>
Date: Thu, 19 May 2005 21:43:36 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Adam Belay <ambx1@neo.rr.com>, greg@kroah.org, pavel@ucw.cz,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [patch] properly stop devices before poweroff
References: <20050421111346.GA21421@elf.ucw.cz>	<20050429061825.36f98cc0.akpm@osdl.org>	<42752954.5050600@jp.fujitsu.com>	<20050501221637.GE3951@neo.rr.com> <20050516005639.274d13d1.akpm@osdl.org>
In-Reply-To: <20050516005639.274d13d1.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I don't think the problem (hang up) is ia64 specific because
it is reproduced on my i386 box. The problem (hang up) seems
to occur on the machine that has Fusion MPT SCSI host adapter.
'SYNCHRONIZE_CACHE' command to MPT SCSI seems to never return
at device_shutdown() time.

Thanks,
Kenji Kaneshige


Andrew Morton wrote:
> Adam Belay <ambx1@neo.rr.com> wrote:
> 
>>On Mon, May 02, 2005 at 04:09:08AM +0900, Kenji Kaneshige wrote:
>>
>>>Hi,
>>>
>>>Andrew Morton wrote:
>>>
>>>>Pavel Machek <pavel@ucw.cz> wrote:
>>>>
>>>>
>>>>>Without this patch, Linux provokes emergency disk shutdowns and
>>>>>similar nastiness. It was in SuSE kernels for some time, IIRC.
>>>>>
>>>>
>>>>
>>>>With this patch when running `halt -p' my ia64 Tiger (using
>>>>tiger_defconfig) gets a stream of badnesses in iosapic_unregister_intr()
>>>>and then hangs up.
> 
> 
> A little reminder that this bug remains unfixed...
> 
> 
>>>>Unfortunately it all seems to happen after the serial port has been
>>>>disabled because nothing comes out.  I set the console to a squitty font
>>>>and took a piccy.  See
>>>>http://www.zip.com.au/~akpm/linux/patches/stuff/dsc02505.jpg
>>>>
>>>>I guess it's an ia64 problem.  I'll leave the patch in -mm for now.
>>>>
>>>
>>>I guess the stream of badness was occured as follows:
>>>
>>>   pcibios_disable_device() for ia64 assumes that pci_enable_device()
>>>   and pci_disable_device() are balanced. But with 'properly stop
>>>   devices before power off' patch, pci_disable_device() becomes to be
>>>   called twice for e1000 device at halt time, through reboot_notifier_list
>>>   callback and through device_suspend(). As a result, 
>>>   iosapic_unregister_intr()
>>>   was called for already unregistered gsi and then stream of badness
>>>   was displayed.
>>>
>>>I think the following patch will remove this stream of badness. I'm
>>>sorry but I have not checked if the stream of badness is actually
>>>removed because I'm on vacation and I can't look at my display
>>>(I'm working via remote console). Could you try this patch?
>>>
>>>By the way, I don't think this stream of badness is related to hang up,
>>>because the problem (hang up) was reproduced even on my test kernel that
>>>doesn't call pcibios_disable_device().
>>>
>>>Thanks,
>>>Kenji Kaneshige
>>>---
>>>
>>>
>>>There might be some cases that pci_disable_device() is called even if
>>>the device is already disabled. In this case, pcibios_disable_device()
>>>should not call acpi_pci_irq_disable() for the device.
>>>
>>>Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
>>>
>>Although this would solve the problem, it may or may not be the right thing to
>>do.  The bug is not in pci_disable_device(), it's in the fact that we're
>>calling pci_disable_device() twice.  Whether pci_disable_device() should ignore
>>this or create an error is an implementation decision.  It might make sense to
>>have it print a warning. Greg, what are your thoughts?
>>
>>What's important is that we don't want to suspend the device twice (in this
>>case suspend and reboot_notifier).
>>
>>Thanks,
>>Adam
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-ia64" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ia64" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

