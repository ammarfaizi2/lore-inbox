Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268325AbUHKXw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268325AbUHKXw4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 19:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268414AbUHKXpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 19:45:09 -0400
Received: from omx1-ext.SGI.COM ([192.48.179.11]:46052 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S268352AbUHKX2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 19:28:45 -0400
From: Pat Gefre <pfg@sgi.com>
Message-Id: <200408112327.i7BNRb5w163586@fsgi900.americas.sgi.com>
Subject: Re: Altix I/O code reorganization - 6 of 21
To: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       hch@infradead.org
Date: Wed, 11 Aug 2004 18:27:37 -0500 (CDT)
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 002-pci-fixups:
>    you're adding tons of non-standard SAL calls for who knows what.  In
>    fact this pretty much looks like you're just moving the existing crappy
>    code into the prom so the bad Linux guys can't complain about it anymore.
>    Please switch to the standard ACPI PCI probing mechanism all other IA64
>    machines support and you can get rid of all that.
>    You're duplicating the kernel's PCI to PCI bridge support, with the normal
>    IA64 pci code it would just work..
> 

2 additional SAL calls were added.  This SAL call multiplexes 
into 10 different calls inside of Prom:

Platform Specific IO Chipset Error Handling:
        PCIIO_CALL_ERROR_INTERRUPT - Handle IO Platform Specific Error Processing.

Platform Specific Virtual Channel Reallocation:
        PCIIO_CALL_RRB_ALLOC - Allocate Read Request Buffers.

Platform Specific Hot Plug Support:
        PCIIO_CALL_SLOT_ENABLE - Hot Plug to support Slot Power Up.
        PCIIO_CALL_SLOT_DISABLE - Hot Plug to support Slot Power Down.

Platform Specific PCI Fixup at Linux Boot Time:
        PCIIO_CALL_GET_HUBDEV_INFO - Retrieve HUBIO chipset info.
        PCIIO_CALL_GET_PCIBUS_INFO - Retrieve PCI Bus Info.
        PCIIO_CALL_GET_PCIDEV_INFO,- Retrieve Platform specific PCE Device Info
        PCIIO_CALL_GET_WIDGET_DMAFLUSH_LIST - Retrieve Workaround DMA Flush Info.

Platform Specific Interrupt Allocation/Deallocation for smp_affinity() support:
	XTALK_CALL_INTR_ALLOC - Initialize IO Chipset Interrupt Registers.
	XTALK_CALL_INTR_FREE - Free IO Chipset Interrupt Registers.

As you can see these SAL calls replaces a lot of config and init code that 
we use to have in the Linux Kernel.  You can probably see that these information 
cannot be carried by ACPI Tables.

Can all these information be replaced by ACPI Tables - currently no.  In the 
future, very good possibility that we will be able to use more of the ACPI tables, 
but, looking at the information needed, the ACPI Tables, and the differences 
in our IO Chipset, we will probably still require some very Platform specific 
SAL calls.

Eventhough, we live within the arch/ia64, our IO Chipsets are definitely not 
anything close to every other arch/ia64 platforms.

The excellent news is that, now that our Prom is probing, and configuring 
every devices in the system, we will be able to send as much information as 
possible via ACPI.  That would naturally be our next step forward.

None of these SAL calls are in the performance path.

What PPB code in the Linux kernel are you commenting on?




For the new code see:

ftp://oss.sgi.com/projects/sn2/sn2-update/002-pci-fixup

