Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161253AbWGNEYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161253AbWGNEYJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 00:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161255AbWGNEYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 00:24:08 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:64696 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1161253AbWGNEYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 00:24:07 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Linus Torvalds <torvalds@osdl.org>
Cc: Edgar Hucek <hostmaster@ed-soft.at>, "H. Peter Anvin" <hpa@zytor.com>,
       LKML <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: [PATCH 1/1] Fix boot on efi 32 bit Machines [try #4]
References: <44A04F5F.8030405@ed-soft.at>
	<Pine.LNX.4.64.0606261430430.3927@g5.osdl.org>
	<44A0CCEA.7030309@ed-soft.at>
	<Pine.LNX.4.64.0606262318341.3927@g5.osdl.org>
	<44A304C1.2050304@zytor.com>
	<m1ac7r9a9n.fsf@ebiederm.dsl.xmission.com>
	<44A8058D.3030905@zytor.com>
	<m11wt3983j.fsf@ebiederm.dsl.xmission.com>
	<44AB8878.7010203@ed-soft.at>
	<m1lkr83v73.fsf@ebiederm.dsl.xmission.com>
	<44B6BF2F.6030401@ed-soft.at>
	<Pine.LNX.4.64.0607131507220.5623@g5.osdl.org>
Date: Thu, 13 Jul 2006 22:23:15 -0600
In-Reply-To: <Pine.LNX.4.64.0607131507220.5623@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 13 Jul 2006 15:15:21 -0700 (PDT)")
Message-ID: <m1lkqwyfv0.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Thu, 13 Jul 2006, Edgar Hucek wrote:
>>
>> I converted the efi memory map to use the e820 table.
>> While converting i discovered why the kernel would allways
>> fail to boot through efi on Intel Macs without a proper fix.
>
> Ok, can you show what the converted and the original map looks like?
>
>> From kernel 2.6.16 to kernel 2.6.17 a new check is made.
>> File arch/i386/pci/mmconfig.c -> funktion pci_mmcfg_init -> check
> e820_all_mapped
>> The courios thing is that this check will always fail on the
>> Intel Macs booted through efi. Parsing of the ACPI_MCFG table
>> returns e0000000 for the start. But this location is
>> not in the memory map which the efi firmware have :
>> BIOS-EFI: 00000000e00f8000 - 00000000e00f9000 (reserved)
>
> It _sounds_ like you may not have converted all the EFI types 
> (EFI_UNUSABLE_MEMORY?), but regardless, I think it would be fine to have 
> perhaps a "PCI_FORCE_MMCONF" flag that avoided that sanity check, and then 
> you could have some code (either the EFI code _or_ some DMI code) that 
> sets it for the Intel Macs.
>
> Note that the check in pci_mmcfg_init() shouldn't be some EFI hack itself, 
> it would be a real flag for the PCI subsystem, independently of EFI (I can 
> see it being useful for a kernel command line option, even), and the only 
> EFI connection would be that perhaps the EFI code ends up setting that 
> flag (especially if there is some EFI command for doing this).
>
> Btw, if you do do this, I think we should make sure that the MMCONFIG base 
> address is reserved in the PCI MMIO resource structures (which we don't do 
> now, I think - part of the whole point of verifying that it's marked as 
> E820_RESERVED is exactly the fact that otherwise we migth have problems 
> with PCI MMIO resource allocations allocating a regular PCI resource over 
> the MMCONFIG space..)

While we are thinking about this I have a stupid question.
Currently if a memory mapped region does not fall in a standard PCI
bar we insist it must be E820 reserved.  However if we E820 reserve
the memory of a standard pci bar it becomes unusable.

Is this really the behavior that we intend?

It gets confusing that E820 reserved gets double duty as memory
the BIOS is using and MMIO space that is mapped by a non-standard bar.

Eric
