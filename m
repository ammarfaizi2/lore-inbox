Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269713AbTGJXnw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 19:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269719AbTGJXnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 19:43:52 -0400
Received: from fw-az.mvista.com ([65.200.49.158]:60147 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S269713AbTGJXnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 19:43:40 -0400
Message-ID: <3F0DFD70.6000908@mvista.com>
Date: Thu, 10 Jul 2003 16:57:36 -0700
From: Steven Dake <sdake@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Samuel Flory <sflory@rackable.com>,
       Chad Kitching <CKitching@powerlandcomputers.com>,
       linux-kernel@vger.kernel.org, andre@linux-ide.org
Subject: Re: IDE/Promise 20276 FastTrack RAID Doesn't work in 2.4.21, patchattached
 to fix
References: <Pine.SOL.4.30.0307110102220.6781-100000@mion.elka.pw.edu.pl>
In-Reply-To: <Pine.SOL.4.30.0307110102220.6781-100000@mion.elka.pw.edu.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Bartlomiej Zolnierkiewicz wrote:

>It shouldn't matter.
>
>Look at the code in setup-pci.c:
>
>                ide_pci_enablebit_t *e = &(d->enablebits[port]);
>
>If CONFIG_PDC202XX_FORCE=y d->enablebits will be { 0x00, 0x00, 0x00 }
>for both ports, now look at drivers/ide/setup-pci.c:
>
>                /*
>                 * If this is a Promise FakeRaid controller,
>                 * the 2nd controller will be marked as
>                 * disabled while it is actually there and enabled
>                 * by the bios for raid purposes.
>                 * Skip the normal "is it enabled" test for those.
>                 */
>                if (((d->vendor == PCI_VENDOR_ID_PROMISE) &&
>                     ((d->device == PCI_DEVICE_ID_PROMISE_20262) ||
>                      (d->device == PCI_DEVICE_ID_PROMISE_20265))) &&
>                    (secondpdc++==1) && (port==1))
>                        goto controller_ok;
>
>                if (e->reg && (pci_read_config_byte(dev, e->reg, &tmp) ||
>                    (tmp & e->mask) != e->val))
>                        continue;       /* port not enabled */
>
>controller_ok:
>
>So if e = { 0x00, 0x00, 0x00 } test above (for enabled port) should fail,
>no need for your patch.
>
>Can you put printks inside this code to see what are values
>of e->reg, e->mask and e->val?
>  
>
Your right, I tried printks of those values, and they are all zero.  Now 
with fasttrack special feature enabled, my kernel boots without the PDC 
patch I sent earlier.  After I reconfigured the kernel in my previous 
tests, the kernel build system must not have build the source files a new.

Thanks for all the help.

And atleast we got the help in the kernel config straightened out:)
-steve

>On Thu, 10 Jul 2003, Samuel Flory wrote:
>  
>
>  
>
>>Steven Dake wrote:
>>
>>    
>>
>>>Even with special fasttrack feature enabled, my disk devices on the
>>>PDC20276 is not found.  There is code in pci-setup.c which blocks
>>>other PDC controllers, why not the 20276?  Is that code for some other
>>>purpose, or orthagonal to the force option?
>>>      
>>>
>>  The comments would seem to indicate that this is only needed if you
>>have a second controller.  Which leads me to wonder what if I have 3 or
>>4 pdc controllers.
>>
>>        for (port = 0; port <= 1; ++port) {
>>                ide_pci_enablebit_t *e = &(d->enablebits[port]);
>>
>>                /*
>>                 * If this is a Promise FakeRaid controller,
>>                 * the 2nd controller will be marked as
>>                 * disabled while it is actually there and enabled
>>                 * by the bios for raid purposes.
>>                 * Skip the normal "is it enabled" test for those.
>>                 */
>>                if (((d->vendor == PCI_VENDOR_ID_PROMISE) &&
>>                     ((d->device == PCI_DEVICE_ID_PROMISE_20262) ||
>>                      (d->device == PCI_DEVICE_ID_PROMISE_20265))) &&
>>                    (secondpdc++==1) && (port==1))
>>                        goto controller_ok;
>>    
>>
>
>I think this workaround was added before "Special FastTrack Feature"
>option. Andre?
>--
>Bartlomiej
>
>
>
>
>  
>

