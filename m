Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945915AbWBOMfv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945915AbWBOMfv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 07:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945918AbWBOMfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 07:35:51 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:19618 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1945915AbWBOMfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 07:35:50 -0500
Message-ID: <43F31F7E.4050705@jp.fujitsu.com>
Date: Wed, 15 Feb 2006 21:33:02 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, greg@kroah.com
Subject: Re: [RFC][PATCH 1/4] PCI legacy I/O port free driver - Introduce
 pci_set_bar_mask*()
References: <43F172BA.1020405@jp.fujitsu.com> <43F17379.8010900@jp.fujitsu.com> <20060214210744.3a7a756a.akpm@osdl.org> <43F2C44C.7080806@jp.fujitsu.com> <20060215090732.GA15898@flint.arm.linux.org.uk>
In-Reply-To: <20060215090732.GA15898@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Wed, Feb 15, 2006 at 03:03:56PM +0900, Kenji Kaneshige wrote:
> 
>>Andrew Morton wrote:
>>
>>>Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com> wrote:
>>>
>>>
>>>>This patch introduces a new interface pci_select_resource() for PCI
>>>>device drivers to tell kernel what resources they want to use.
>>>
>>>
>>>It'd be nice if we didn't need to introduce any new API functions for this.
>>>If we could just do:
>>>
>>>struct pci_something pci_something_table[] = {
>>>	...
>>>	{
>>>		...
>>>		.dont_allocate_io_space = 1,
>>>		...
>>>	},
>>>	...
>>>};
>>>
>>>within each driver which wants it.
>>>
>>>But I can't think of a suitable per-device-id structure with which we can
>>>do that :(
>>>
>>>
>>
>>My another idea was to use pci quirks. In this approach, we don't
>>need to introduce any new API. But I gave up this idea because it
>>looked abuse of pci quirks.
>>
>>Anyway, I try to think about new ideas we don't need to introduce
>>any new API.
> 
> 
> What about pci_enable_device_bars() ?
> 

Yes, it's one option (In fact, my first idea was using it),
though we need to move the following lines into
pci_enable_device_bars() from pci_enable_device().

        pci_fixup_device(pci_fixup_enable, dev);
        dev->is_enabled = 1;

Actually, IIRC, there are one or two existing drivers using it.
In addition to pci_enable_device_bars(), we can use
pci_request_region() for requesting each region instead of using
pci_request_regions().

The reason I didn't use this option was I thought we would need
bigger changes to drivers if we use pci_enable_devie_bars() and
pci_request_region(). For example, if we use pci_request_region()
for requesting the specific regions and if an error occurs
while doing that, we need to release only the regions we succeeded
in requesting. I think this is a little bit troublesome for driver
writers. In adition, though this is my personal opinion, only one
API to enable devices (e.g. pci_enable_device()) looks nice to me.
Anyway, I think it would be nice if we can solve the problem by
as small changes as possible to the existing drivers.
How do you think?

Thanks,
Kenji Kaneshige
