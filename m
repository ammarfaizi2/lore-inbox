Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264523AbTDXXlM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 19:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264503AbTDXXjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 19:39:06 -0400
Received: from kathmandu.sun.com ([192.18.98.36]:27020 "EHLO kathmandu.sun.com")
	by vger.kernel.org with ESMTP id S264501AbTDXXid (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 19:38:33 -0400
Message-ID: <3EA878A9.40106@sun.com>
Date: Thu, 24 Apr 2003 16:52:09 -0700
From: Duncan Laurie <duncan@sun.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: problem with Serverworks CSB5 IDE
References: <20030423212713.GD21689@puck.ch> <1051136469.2062.108.camel@dhcp22.swansea.linux.org.uk> <20030423232909.GE21689@puck.ch> <20030423232909.GE21689@puck.ch> <20030424080023.GG21689@puck.ch> <20030424080023.GG21689@puck.ch> <3EA85C5C.7060402@sun.com>
In-Reply-To: <3EA85C5C.7060402@sun.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Duncan Laurie wrote:
> Olivier Bornet wrote:
> 
>> Hi all,
>>
>> I reply to myself, after having test this solution.
>>
>>
>>> At this time, I have compiled and installed a 2.4.20-ac2 + some cobalt
>>> patches. Is the bug also fixed in 2.4.20-ac2, or must I rebuild the
>>> 2.4.20 with the check commented out ?
>>
>>
>>
>> The 2.4.20-ac2 patched kernel help a little : the system don't crash
>> anymore. But the disk is marked as defective, and is removed from the
>> raid1 metadevice.
>>
>> One other problem with the -ac2 is the speed for the rebuild : it seems
>> to be 2 times slower than with the Ducan patch. (about 2 hours instead
>> of 1 hour).
>>
>> So, my solution is to use the patch from Ducan. I hope it (or a
>> derivative form of it) will be included in the next kernel releases.
>>
>> Good day, and thanks all for the help.
>>
> 
> Here is a 2.4.21-rc1 version of the patch, with a few modificaions
> due to the changes in IDE..
> 
> Actually UDMA mode detection is not working at all for CSB5 in
> 2.4.21-rc1 because svwks_revision variable is set in __init function
> so was reading as 0 in svwks_ratemask().  This made it think UDMA

Oops, this analysis is wrong..  The svwks_revision variable is set
in the init_chipset_svwks() function, which doesn't appear to ever
get called because dev->irq==0.  The init_chipset function is also
responsible for the call to ide_pci_register_host_proc(), so since
it isn't being called there is no /proc/ide/svwks.

I think for Serverworks IDE you will never get a valid dev->irq out
of the pci config register, so maybe should there still be a call to
d->init_chipset in this block from drivers/ide/setup-pci.c:

   } else if (!pciirq) {
       if (noisy)
           printk(KERN_WARNING "%s: bad irq (%d): will probe later\n",
                  d->name, pciirq);
       pciirq = 0;
   }

-duncan

