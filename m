Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261737AbVDCNkT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261737AbVDCNkT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 09:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261738AbVDCNkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 09:40:19 -0400
Received: from smtpout19.mailhost.ntl.com ([212.250.162.19]:41345 "EHLO
	mta13-winn.mailhost.ntl.com") by vger.kernel.org with ESMTP
	id S261737AbVDCNkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 09:40:06 -0400
Message-ID: <424FF235.2090505@gentoo.org>
Date: Sun, 03 Apr 2005 14:40:05 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Baumann <waste.manager@gmx.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       habraken@yahoo.com, greg@kroah.com, aniel.ritz@gmx.ch
Subject: Re: [Bug] invalid mac address after rebooting (kernel 2.6.11.5)
References: <20050323122423.GA24316@faui00u.informatik.uni-erlangen.de> <20050323185225.11097185.akpm@osdl.org> <20050324110102.GA30711@faui00u.informatik.uni-erlangen.de>
In-Reply-To: <20050324110102.GA30711@faui00u.informatik.uni-erlangen.de>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Baumann wrote:
> On Wed, Mar 23, 2005 at 06:52:25PM -0800, Andrew Morton wrote:
> 
>>Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de> wrote:
>>
>>>
>>>I'm hitting an annoying bug in kernel 2.6.11.5
>>>
>>>Every time I _reboot_ (warmstart) my pc my two network cards won't get
>>>recognized any longer.
>>>
>>>Following error message appears on my screen:
>>>
>>>PCI: Enabling device 0000:00:0b.0 (0000 -> 0003)
>>>ACPI: PCI interrupt 0000:00:0b.0[A] -> GSI 19 (level, low) -> IRQ 19
>>>3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
>>>0000:00:0b.0: 3Com PCI 3c905B Cyclone 100baseTx at 0x1000. Vers LK1.1.19
>>>PCI: Setting latency timer of device 0000:00:0b.0 to 64
>>>*** EEPROM MAC address is invalid.
>>>3c59x: vortex_probe1 fails.  Returns -22
>>>3c59x: probe of 0000:00:0b.0 failed with error -22
>>>PCI: Enabling device 0000:00:0d.0 (0000 -> 0003)
>>>ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 19 (level, low) -> IRQ 19
>>>0000:00:0d.0: 3Com PCI 3c905B Cyclone 100baseTx at 0x1080. Vers LK1.1.19
>>>PCI: Setting latency timer of device 0000:00:0d.0 to 64
>>>*** EEPROM MAC address is invalid.
>>>3c59x: vortex_probe1 fails.  Returns -22
>>>3c59x: probe of 0000:00:0d.0 failed with error -22
>>>
>>>This doesn't happen with older kernels (especially with 2.6.10) and so
>>>I've done a binary search and narrowed it down to 2.6.11-rc5 where it
>>>first hits me.
>>>
>>>My config, lspci output and the dmesg output of the working and non-working
>>>version can be found at [1]
>>>
>>>Feel free to ask if any information is missing or if I am supposed to try
>>>a patch.
>>
>>Thanks for doing the bsearch - it helps.
>>
>>There were no driver changes between 2.6.11-rc4 and 2.6.11-rc5.
>>
>>The only PCI change I see is
>>
>>--- drivers/pci/pci.c   22 Jan 2005 03:20:37 -0000      1.71
>>+++ drivers/pci/pci.c   24 Feb 2005 18:02:37 -0000      1.72
>>@@ -268,7 +268,7 @@
>>                return -EIO; 
>> 
>>        pci_read_config_word(dev,pm + PCI_PM_PMC,&pmc);
>>-       if ((pmc & PCI_PM_CAP_VER_MASK) != 2) {
>>+       if ((pmc & PCI_PM_CAP_VER_MASK) > 2) {
>>                printk(KERN_DEBUG
>>                       "PCI: %s has unsupported PM cap regs version (%u)\n",
>>                       dev->slot_name, pmc & PCI_PM_CAP_VER_MASK);
>>
>>and you're not getting that message (are you?)
>>
> 
> 
> Reverting the above patch solved it.

A gentoo user also reported this, but according to the bug report, this 
happens on every bootup (as opposed to only every warm boot)

http://bugs.gentoo.org/87142

I asked him to try reverting the patch shown above and that helped his 
situation too.

What's next towards getting this fixed for real?

Daniel
