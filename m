Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263303AbTEMIhT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 04:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263319AbTEMIhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 04:37:19 -0400
Received: from amsfep15-int.chello.nl ([213.46.243.28]:42543 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S263303AbTEMIhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 04:37:17 -0400
From: Jos Hulzink <josh@stack.nl>
To: "STK" <stk@nerim.net>, "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] How to fix MPS 1.4 + ACPI behaviour ?
Date: Tue, 13 May 2003 10:54:25 +0200
User-Agent: KMail/1.5
Cc: "'Zwane Mwaikambo'" <zwane@linuxpower.ca>
References: <000b01c318cd$992f92e0$0200a8c0@QUASARLAND>
In-Reply-To: <000b01c318cd$992f92e0$0200a8c0@QUASARLAND>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305131054.25846.josh@stack.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As you can see below, current ACPI implementation concludes it has to use the 
PIC, before it finds the PRT. No occurences of PRT in dmesg before this one.

vvvv
ACPI: Using PIC for interrupt routing
^^^^
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
vvvv
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
^^^^

Jos

On Monday 12 May 2003 23:29, STK wrote:
> For me the linux kernel should invoke the _PIC method with the right
> parameter.
>
> Look at the specification Section
>
> << ================ Start ================
> 5.8.1 _PIC Method
> The \_PIC optional method is to report to the BIOS the current interrupt
> model used by the OS. This
> control method returns nothing. The argument passed into the method
> signifies the interrupt model OSPM
> has chosen, PIC mode, APIC mode, or SAPIC mode. Notice that calling this
> method is optional for OSPM.
> If the method is never called, the BIOS must assume PIC mode. It is
> important that the BIOS save the value
> passed in by OSPM for later use during wake operations.
> _PIC(x):
> _PIC(0) => PIC Mode
> _PIC(1) => APIC Mode
> _PIC(2) => SAPIC Mode
> _PIC(3-n) => Reserved
>
> ==================== End ====================>
>
> ==> No MADT table, so ACPI sets up the APIC in PIC mode (which I wonder
> wether correct, but ok)
> For me the kernel should invoke the _PIC method with the right
> parameter, in this case the ACPI module will receive the right table
> during the _PRT
>
> Bios ASL code:
>                 Method(_PRT)
>                 {
>                 If(\PICF) <== internal variable set by _PIC
>                 {
>                 	==> Returning APIC Mode
>                 	Return(APIC)
>                 }
>                 Else
>                 {
>                 	==> Returning PIC Mode
>                 	Return(PICM)
>                 }
> 			}
>
> Regards,
>
> Yann
>
>
> -----Original Message-----
> From: Jos Hulzink [mailto:josh@stack.nl]
> Sent: lundi 12 mai 2003 22:51
> To: STK; 'linux-kernel'
> Cc: 'Zwane Mwaikambo'
> Subject: Re: [RFC] How to fix MPS 1.4 + ACPI behaviour ?
>
> On Monday 12 May 2003 22:40, STK wrote:
> > Hi,
> >
> > If no Multiple APIC Description Table (MADT) is described, in this
> > case the _PIC method can be used to tell the bios to return the right
> > table (PIC or APIC routing table).
> >
> > In this case, if the MPS table describes matches the ACPI APIC table
> > (this is the case, because the ACPI APIC table is built from the MPS
> > table), you do not need to remap all IRQs.
>
> So, it's more or less a bug in the ACPI code that should do some things
> when
> no MADT is dectected ? Or do I understand you wrong ?
>
> Jos

