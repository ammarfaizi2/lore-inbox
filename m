Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262528AbTELTSx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 15:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262530AbTELTSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 15:18:53 -0400
Received: from amsfep16-int.chello.nl ([213.46.243.26]:24622 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S262528AbTELTSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 15:18:52 -0400
From: Jos Hulzink <josh@stack.nl>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [RFC] How to fix MPS 1.4 + ACPI behaviour ?
Date: Mon, 12 May 2003 21:35:53 +0200
User-Agent: KMail/1.5
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305122135.53751.josh@stack.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

(kernel: 2.5.69)

The conclusion of bug 699 is that some / all i386 SMP systems that use MPS 1.4 
(and higher ? or all MPS versions ?), should boot with the "pci=noacpi" 
parameter to prevent IRQ problems.

What exactly happens: The MPS 1.4 interpreter causes PCI IRQs to be remapped 
to IRQ 16 and higher, which is the desired behaviour. The ACPI interpreter 
comes in and finds no MADT table, for the Multiprocessor info is stored as 
MPS table. No MADT table, so ACPI sets up the APIC in PIC mode (which I 
wonder wether correct, but ok). As a result, the kernels pci_dev table tells 
us that the IRQs have not been remapped (i.e. all values less than 16), while 
the IRQs are actually mapped above 16. 

All drivers of PCI cards claim the wrong IRQ line, and the end of story is 
timeouts while waiting for an IRQ that never comes.

Remark: I think it is strange, that the kernel actually says: "ACPI: Using PIC 
for interrupt routing", but it doesn't set up the PIC correctly (otherwise 
the APIC rerouting table would be reset or something).

Now, my big question his: how to fix this. It is possible to have some code in 
the kernel that does the same as "pci=noacpi", but what and where do I have 
to do the check, with what condition ?

1) In the ACPI code, when MADT is not present ? Problem here is that the MPS 
parser comes after the ACPI parser, so it isn't known yet that the MPS table 
is present.

2) In the MPS parser ? As soon as an I/O APIC is detected by MPS, tell ACPI 
not to touch the APIC ? You get acpi related code in non-acpi procedures 
then...

3) Somewhere else ? How early in the kernel boot process should this option be 
set ?

And an additional question: is "pci=noapic" the correct way to fix this ? It 
runs fine here, but maybe we should only touch the IRQ related part ? If so, 
how to do that ?

Please shoot... I found the problem, but this doesn't mean I understand the 
kernel :)

Jos
