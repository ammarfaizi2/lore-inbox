Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317385AbSIATeW>; Sun, 1 Sep 2002 15:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317392AbSIATeW>; Sun, 1 Sep 2002 15:34:22 -0400
Received: from mail.libertysurf.net ([213.36.80.91]:43812 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S317385AbSIATeV> convert rfc822-to-8bit; Sun, 1 Sep 2002 15:34:21 -0400
Date: Sun, 1 Sep 2002 23:19:08 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: groudier@localhost.my.domain
To: Terry Barnaby <terry@beam.ltd.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux kernel lockup with BVM SCSI controller on MCPN765 PPC
 board
In-Reply-To: <3D6F4A3A.50806@beam.ltd.uk>
Message-ID: <20020901225240.W6132-100000@localhost.my.domain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 30 Aug 2002, Terry Barnaby wrote:

> Hi,
>
> We have a major problem with using a BVM SCSI controller on a Motorola
> MCPN765 PowerPC Compact PCI Motherboard. When the SCSI driver module is
> loaded and starts to perform SCSI device interrogation the system will
> completely lock up.
> It appears that the hardware is locked up, the kernel locks up during
> a low level serial console print routine (serial_console_write). No interrupts
> occur (we have even disabled interrupts in the serial_console_write routine
> to make sure).
> The BVM SCSI controller is based on the LSI53C1010-66 chip and we are using the
> sym53c8xx_2 SCSI driver (although the same problem occurs with the
> sym53c8xx SCSI driver.
> We are using MontaVista Linux 2.1 with the 2.4.17 kernel.
>
> Using this SCSI controller board with a Motorola MCP750 PowerPC motherboard
> works fine. One of the differences between the Motherboards is that the
> MCPN765 has a 66MHz/64bit PCI bus while the MCP750 has a 33MHz/32bit PCI bus.
> The MCPN765 uses a Hawk ASIC for Memory/PCI bus control.
>
> We have been attempting to debug the driver to find the cause but have been
> hitting brick walls. The system appears to lock up when the SCSI board
> is performing a DataIn phase under the control of its on-board SCRIPTS processor.
>
> As the system has completely locked up we have not been able to find the cause.
> Any information on possible causes or ideas on how to proceed would be most
> appreciated.

The software driver hasn't any handle on the actual differences between
the BUS that leads to failure and the one that allows success:

1) The PCI clock is full hardware dependant. There is nothing software can
   change here.

2) Same for the PCI BUS path. A 64 bit PCI BUS just allows to transfer 64
   bit of data per BUS cycle but a 32 bit PCI BUS can only transfer 32 bit
   per PCI cycle.

3) Both PCI BUSes width allows 64 bit memory addressing.

As we know, PCI device drivers relies on kernel generic PCI driver that
provides configuration access and DMA address translation services. The
kernel PCI related code uses machine-dependent and bridge-dependant
methods. So, IMO, there is far more places than just the driver code that
are involved in the failure you report (including the related pieces of
hardware).

I would suggest you to check the following at first:

1) Give a look at the PCI configuration space of the chip (or report it).
   For example, a base address that doesn't fit in 32 bit is very
   uncommon. Etc...

2) Configure the driver for 32 bit DMA (DMA MODE = 0). This will ensure
   that all DMA addresses will fit in 32 bit and that no PCI dual cycle
   will occur on behalf of the 1033-66 chip.

 Gérard.

