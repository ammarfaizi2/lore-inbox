Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316821AbSGZEwa>; Fri, 26 Jul 2002 00:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316823AbSGZEv6>; Fri, 26 Jul 2002 00:51:58 -0400
Received: from [195.63.194.11] ([195.63.194.11]:65029 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316822AbSGZEug>; Fri, 26 Jul 2002 00:50:36 -0400
Message-ID: <3D409A9F.4090706@evision.ag>
Date: Fri, 26 Jul 2002 02:41:03 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Vojtech Pavlik <vojtech@suse.cz>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
Subject: Re: PCI config locking (WAS Re: [RFC/CFT] cmd640 irqlocking fixes)2
References: <20020725133918.37@192.168.4.1> <20020725141811.29565@192.168.4.1>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
>>Martin this patch should do the job. It uses the correct pci_config_lock
>>
>>>and it also adds the 2.4 probe safety checks for deciding which pci
>>>modes to use.
>>
>>Hrm... pci_config_lock is specific to arch/i386 it seems (and is even
>>a static in 2.4.19rc3). That is no good as this isn't the only
>>driver to do config access from interrupts, so at least PPC is
>>broken in this regard.
>>
>>Wouldn't it make sense to generalize it and implement it on all archs ?
>>
>>(That is move extern declaration of it to linux/pci.h, definition to
>>drivers/pci/pci.c, and so on...)
>>
>>I'd rather have a per-host lock, but on the other hand, the host bus
>>mecanism is still quite arch-specific, thus making difficult to use
>>a per-host lock in drivers, at least in 2.4
> 
> 
> Ok, fixing my own crap...
> 
> So there seem to be a problem with your patch: pci_config_lock appears
> to be an x86-only thing that lives deep inside arch/i386/xxx/pci-pc.c
> (xxx beeing kernel or pci)
> 
> On the other hand, there is already such a lock provided by
> drivers/pci/access.c (pci_lock). You should probably fix your patch
> to use that one. (and eventually get rid of the pci_config_lock
> in x86, provided I didn't miss something else). But does anybody
> but x86 uses CMD640 ? :)

I agree on the pci_lock item.
And yes CMD640 chips where quite common on Sparcs about 4-6 years ago.
I think some Alpha based systems used them too... but I'm not sure.
Regarding the locking issue. I think the best place to
put it would be just before call down to the corresonding low level
functions in the generic IDE layer. We may "overlock" a bit here -
But who cares?  This is by no way a time critical operation.


