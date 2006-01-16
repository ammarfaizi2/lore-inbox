Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbWAPNLf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbWAPNLf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 08:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbWAPNLf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 08:11:35 -0500
Received: from tornado.reub.net ([202.89.145.182]:48345 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S1750744AbWAPNLe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 08:11:34 -0500
Message-ID: <43CB9B84.2060107@reub.net>
Date: Tue, 17 Jan 2006 02:11:32 +1300
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 1.6a1 (Windows/20060114)
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, gregkh@suse.de, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org
Subject: Re: [GIT PATCH] PCI patches for 2.6.15 - retry
References: <20060109203711.GA25023@kroah.com>	 <Pine.LNX.4.64.0601091557480.5588@g5.osdl.org>	 <20060109164410.3304a0f6.akpm@osdl.org>	 <1136857742.14532.0.camel@localhost.localdomain>	 <20060109174941.41b617f6.akpm@osdl.org>  <43C5D34B.1090903@reub.net> <1137066145.17090.20.camel@localhost.localdomain> <43C6C331.1030602@pobox.com>
In-Reply-To: <43C6C331.1030602@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/01/2006 9:59 a.m., Jeff Garzik wrote:
> Alan Cox wrote:
>> On Iau, 2006-01-12 at 16:55 +1300, Reuben Farrelly wrote:
>>
>>> ata1: SATA max UDMA/133 cmd 0x0 ctl 0x2 bmdma 0x0 irq 0
>>> ata2: SATA max UDMA/133 cmd 0x0 ctl 0x2 bmdma 0x8 irq 0
>>> Unable to handle kernel NULL pointer dereference at virtual address 
>>> 00000000
>>
>>
>> That is the critical bit. The SATA ports have no PCI resources assigned
>> for bus mastering (BAR 4). libata should have driven the device PIO in
>> this case but the resource should have been assigned.
> 
> Agreed.  This appears to be BIOS assigning bad values to SATA hardware.
> 
> However, libata should recognize this and not attempt to iomap or drive 
> the hardware, in that case, rather than oops.
> 
>     Jeff

Some testing tonight has shown up a bit more about where this regression crept in.

Below the table reads release on left hand side, and the result of a given 
reboot on  the right hand side after the dash.  I had to do so many reboots to 
be sure that the bug was there or not - as you can see from the -mm1 test it 
doesn't always show up.

2.6.15 - OK OK OK OK OK
2.6.15-git1 - OK OK OK OK OK OK OK OK
2.6.15-git2 - OK
2.6.15-git6 - OK OK OK OK OK OK OK OK
2.6.15-git12 - OK OK OK OK OK OK OK

2.6.15-rc5-mm3 - OK OK OK(but oopsed in usb) OK OK(but oopsed in usb)
    Those oopses in USB were only seen in this release so looks likely whatever
    was causing them was fixed soon after.
2.6.15-mm1 - OK OK OOPSED OOPSED OOPSED all in ATA
2.6.15-mm2 + mm3 - [known to OOPS on this bug frequently but not tested in this 
round]
2.6.15-mm4 - OOPSED OK OOPSED TIMEOUT TIMEOUT OOPS OK
2.6.15-mm1 with no git-acpi.patch - TIMEOUT TIMEOUT OOPSED TIMEOUT OK

OK means the system booted up to single user mode without issue, TIMEOUT means 
that the controllers were assigned IRQ 50 and then failed to find any ATA disks 
and OOPSED means that he SATA ports were not assigned IRQs at all and hence the 
system oopsed out like this:

ahci: probe of 0000:00:1f.2 failed with error -12
ata1: SATA max UDMA/133 cmd 0x0 ctl 0x2 bmdma 0x0 irq 0
ata2: SATA max UDMA/133 cmd 0x0 ctl 0x2 bmdma 0x8 irq 0
Unable to handle kernel NULL pointer dereference at virtual address 00000000
  printing eip:
c023c873
*pde = 00000000
Oops: 0000 [#1]
<plus a trace and a whole lot more>

Full output on http://www.reub.net/files/kernel/outstanding-kernel-bugs.txt (as
usual)

In summary the good news is that 2.6.15-git12 (which is the latest linus tree)
is GOOD and does not seem to exhibit this problem.  Not a single -git release 
crapped out.  It seems some regression was introduced into 2.6.15-mm1 which has 
been carried forward through to -mm4 so far though but never pushed to Linus.
I guess it also suggests that it's not a hardware or bios issue given the sheer 
number of successful reboots in a row, and I think reverting the git-acpi.patch 
suggests that ACPI is not the cause of it, at least in this instance.  But 
that's about as far as I have gotten.

45 reboots later I'm finishing for tonight, but before I go back and hit it with
git bisect to narrow it down any further, Andrew/Jeff does this make it any 
easier to pinpoint, and/or do you have any preliminary patches to test or ideas 
as to what other subsystems could be involved?

Thanks,
Reuben



