Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262776AbTELVRL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 17:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262783AbTELVRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 17:17:11 -0400
Received: from smtp-101-monday.nerim.net ([62.4.16.101]:1551 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S262776AbTELVRE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 17:17:04 -0400
From: "STK" <stk@nerim.net>
To: "'Jos Hulzink'" <josh@stack.nl>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
Cc: "'Zwane Mwaikambo'" <zwane@linuxpower.ca>
Subject: RE: [RFC] How to fix MPS 1.4 + ACPI behaviour ?
Date: Mon, 12 May 2003 23:29:35 +0200
Message-ID: <000b01c318cd$992f92e0$0200a8c0@QUASARLAND>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
In-Reply-To: <200305122250.32897.josh@stack.nl>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2727.1300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


For me the linux kernel should invoke the _PIC method with the right
parameter.

Look at the specification Section 

<< ================ Start ================
5.8.1 _PIC Method
The \_PIC optional method is to report to the BIOS the current interrupt
model used by the OS. This
control method returns nothing. The argument passed into the method
signifies the interrupt model OSPM
has chosen, PIC mode, APIC mode, or SAPIC mode. Notice that calling this
method is optional for OSPM.
If the method is never called, the BIOS must assume PIC mode. It is
important that the BIOS save the value
passed in by OSPM for later use during wake operations.
_PIC(x):
_PIC(0) => PIC Mode
_PIC(1) => APIC Mode
_PIC(2) => SAPIC Mode
_PIC(3-n) => Reserved

==================== End ====================>

==> No MADT table, so ACPI sets up the APIC in PIC mode (which I wonder
wether correct, but ok)
For me the kernel should invoke the _PIC method with the right
parameter, in this case the ACPI module will receive the right table
during the _PRT

Bios ASL code:
                Method(_PRT)
                {
                If(\PICF) <== internal variable set by _PIC
                {   
                	==> Returning APIC Mode
                	Return(APIC)
                }
                Else 
                {
                	==> Returning PIC Mode
                	Return(PICM)
                }
			}

Regards,

Yann


-----Original Message-----
From: Jos Hulzink [mailto:josh@stack.nl] 
Sent: lundi 12 mai 2003 22:51
To: STK; 'linux-kernel'
Cc: 'Zwane Mwaikambo'
Subject: Re: [RFC] How to fix MPS 1.4 + ACPI behaviour ?


On Monday 12 May 2003 22:40, STK wrote:
> Hi,
>
> If no Multiple APIC Description Table (MADT) is described, in this
> case the _PIC method can be used to tell the bios to return the right 
> table (PIC or APIC routing table).
>
> In this case, if the MPS table describes matches the ACPI APIC table
> (this is the case, because the ACPI APIC table is built from the MPS 
> table), you do not need to remap all IRQs.

So, it's more or less a bug in the ACPI code that should do some things
when 
no MADT is dectected ? Or do I understand you wrong ?

Jos


