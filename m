Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262645AbTELU2J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 16:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262656AbTELU2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 16:28:09 -0400
Received: from smtp-101-monday.nerim.net ([62.4.16.101]:33541 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S262645AbTELU2D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 16:28:03 -0400
From: "STK" <stk@nerim.net>
To: "'Jos Hulzink'" <josh@stack.nl>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
Cc: "'Zwane Mwaikambo'" <zwane@linuxpower.ca>
Subject: RE: [RFC] How to fix MPS 1.4 + ACPI behaviour ?
Date: Mon, 12 May 2003 22:40:35 +0200
Message-ID: <000c01c318c6$c0804990$0200a8c0@QUASARLAND>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
In-Reply-To: <200305122135.53751.josh@stack.nl>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2727.1300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

If no Multiple APIC Description Table (MADT) is described, in this case
the _PIC method can be used to tell the bios to return the right table
(PIC or APIC routing table).

In this case, if the MPS table describes matches the ACPI APIC table
(this is the case, because the ACPI APIC table is built from the MPS
table), you do not need to remap all IRQs.

I am really new in Kernel so I can't help you too much, but I can help
you on ACPI (I worked 5 years in Bios).

Hope it helps,

Yann

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Jos Hulzink
Sent: lundi 12 mai 2003 21:36
To: linux-kernel
Cc: Zwane Mwaikambo
Subject: [RFC] How to fix MPS 1.4 + ACPI behaviour ?


Hi,

(kernel: 2.5.69)

The conclusion of bug 699 is that some / all i386 SMP systems that use
MPS 1.4 
(and higher ? or all MPS versions ?), should boot with the "pci=noacpi" 
parameter to prevent IRQ problems.

What exactly happens: The MPS 1.4 interpreter causes PCI IRQs to be
remapped 
to IRQ 16 and higher, which is the desired behaviour. The ACPI
interpreter 
comes in and finds no MADT table, for the Multiprocessor info is stored
as 
MPS table. No MADT table, so ACPI sets up the APIC in PIC mode (which I 
wonder wether correct, but ok). As a result, the kernels pci_dev table
tells 
us that the IRQs have not been remapped (i.e. all values less than 16),
while 
the IRQs are actually mapped above 16. 

All drivers of PCI cards claim the wrong IRQ line, and the end of story
is 
timeouts while waiting for an IRQ that never comes.

Remark: I think it is strange, that the kernel actually says: "ACPI:
Using PIC 
for interrupt routing", but it doesn't set up the PIC correctly
(otherwise 
the APIC rerouting table would be reset or something).

Now, my big question his: how to fix this. It is possible to have some
code in 
the kernel that does the same as "pci=noacpi", but what and where do I
have 
to do the check, with what condition ?

1) In the ACPI code, when MADT is not present ? Problem here is that the
MPS 
parser comes after the ACPI parser, so it isn't known yet that the MPS
table 
is present.

2) In the MPS parser ? As soon as an I/O APIC is detected by MPS, tell
ACPI 
not to touch the APIC ? You get acpi related code in non-acpi procedures

then...

3) Somewhere else ? How early in the kernel boot process should this
option be 
set ?

And an additional question: is "pci=noapic" the correct way to fix this
? It 
runs fine here, but maybe we should only touch the IRQ related part ? If
so, 
how to do that ?

Please shoot... I found the problem, but this doesn't mean I understand
the 
kernel :)

Jos
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in the body of a message to majordomo@vger.kernel.org More majordomo
info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


