Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161145AbWGNQKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161145AbWGNQKE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 12:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161147AbWGNQKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 12:10:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29356 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161145AbWGNQKC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 12:10:02 -0400
Date: Fri, 14 Jul 2006 09:09:55 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Edgar Hucek <hostmaster@ed-soft.at>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>,
       akpm@osdl.org
Subject: Re: [PATCH 1/1] Fix boot on efi 32 bit Machines [try #4]
In-Reply-To: <44B73791.9080601@ed-soft.at>
Message-ID: <Pine.LNX.4.64.0607140901200.5623@g5.osdl.org>
References: <44A04F5F.8030405@ed-soft.at> <Pine.LNX.4.64.0606261430430.3927@g5.osdl.org>
 <44A0CCEA.7030309@ed-soft.at> <Pine.LNX.4.64.0606262318341.3927@g5.osdl.org>
 <44A304C1.2050304@zytor.com> <m1ac7r9a9n.fsf@ebiederm.dsl.xmission.com>
 <44A8058D.3030905@zytor.com> <m11wt3983j.fsf@ebiederm.dsl.xmission.com>
 <44AB8878.7010203@ed-soft.at> <m1lkr83v73.fsf@ebiederm.dsl.xmission.com>
 <44B6BF2F.6030401@ed-soft.at> <Pine.LNX.4.64.0607131507220.5623@g5.osdl.org>
 <44B73791.9080601@ed-soft.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 14 Jul 2006, Edgar Hucek wrote:
>
> This is the memory map from the efi shell :

Ok, it really looks like EFI is broken. You said that "ACPI_MCFG table
returns e0000000", ie we should find the config space thing there, yet:

> [ snip snip ... ]
> ACPI_recl  000000007EEEF000-000000007EEFEFFF  0000000000000010 000000000000000F
> RT_data    000000007EEFF000-000000007EEFFFFF  0000000000000001 800000000000000F
> MemMapIO   00000000E00F8000-00000000E00F8FFF  0000000000000001 8000000000000000
> MemMapIO   00000000FED1C000-00000000FED1FFFF  0000000000000004 8000000000000000
> MemMapIO   00000000FFFB0000-00000000FFFDFFFF  0000000000000030 8000000000000000

It clearly wasn't there..

However, it looks like your conversion is a bit buggy:

> This is the converted memory map :
> 
> [ snip snip .. ]
>  BIOS-EFI: 000000007eeef000 - 000000007eeff000 (ACPI data)
>  BIOS-EFI: 00000000e00f8000 - 00000000e00f9000 (reserved)
>  BIOS-EFI: 00000000fed1c000 - 00000000fed20000 (reserved)
>  BIOS-EFI: 00000000fffb0000 - 00000000fffe0000 (reserved)

The above is missing the "RT_data" thing (which was there in your input):

	mem31: type=6, attr=0x800000000000000f, range=[0x000000007eeff000-0x000000007ef00000) (0MB)

> This is the funktion i used for converting :
> 
>                 case EFI_RESERVED_TYPE:
>                 case EFI_MEMORY_MAPPED_IO:
>                 case EFI_MEMORY_MAPPED_IO_PORT_SPACE:
>                 case EFI_UNUSABLE_MEMORY:
>                         add_memory_region(md->phys_addr, md->num_pages << EFI_PAGE_SHIFT, E820_RESERVED);
>                         break;

I think that should be a "default:", to make sure that you don't have any 
memory region types that get ignored. Because it looks like you missed the 
EFI_RUNTIME_SERVICES_CODE/EFI_RUNTIME_SERVICES_DATA ones at a minimum (an 
dmaybe others - I didn't check).

Anyway, that won't fix your bug, and yes, it sounds like you should add a 
PCI_PROBE_FORCE_MMCFG flag (and then do the proper MMIO region reservation 
to make sure that we don't allocate over it when allocating PCI 
resources).

Looks good otherwise.

		Linus
