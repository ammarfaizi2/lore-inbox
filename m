Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317312AbSICP6N>; Tue, 3 Sep 2002 11:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318798AbSICP52>; Tue, 3 Sep 2002 11:57:28 -0400
Received: from portal.beam.ltd.uk ([62.49.82.227]:9363 "EHLO beam.beamnet")
	by vger.kernel.org with ESMTP id <S317312AbSICP5O>;
	Tue, 3 Sep 2002 11:57:14 -0400
Message-ID: <3D74DCE8.20905@beam.ltd.uk>
Date: Tue, 03 Sep 2002 17:01:44 +0100
From: Terry Barnaby <terry@beam.ltd.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux kernel lockup with BVM SCSI controller on MCPN765 PPC board
References: <20020901225240.W6132-100000@localhost.my.domain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gérard,

We have finaly tracked the problem down with Motorola.
There is a major hardware problem with the Hawk-2 ASIC used as the main
PCI/Memory bridge on the MCPN765 board that causes a hardware lockup with
the BVM SCSI controller and probably other devices as well.
The problem is related to null byte enables.
There is no software work around, however the Hawk-3 chip fixes the problem.

Thanks for looking at this.

Terry

Gérard Roudier wrote:
> On Fri, 30 Aug 2002, Terry Barnaby wrote:
> 
> 
>>Hi,
>>
>>We have a major problem with using a BVM SCSI controller on a Motorola
>>MCPN765 PowerPC Compact PCI Motherboard. When the SCSI driver module is
>>loaded and starts to perform SCSI device interrogation the system will
>>completely lock up.
>>It appears that the hardware is locked up, the kernel locks up during
>>a low level serial console print routine (serial_console_write). No interrupts
>>occur (we have even disabled interrupts in the serial_console_write routine
>>to make sure).
>>The BVM SCSI controller is based on the LSI53C1010-66 chip and we are using the
>>sym53c8xx_2 SCSI driver (although the same problem occurs with the
>>sym53c8xx SCSI driver.
>>We are using MontaVista Linux 2.1 with the 2.4.17 kernel.
>>
>>Using this SCSI controller board with a Motorola MCP750 PowerPC motherboard
>>works fine. One of the differences between the Motherboards is that the
>>MCPN765 has a 66MHz/64bit PCI bus while the MCP750 has a 33MHz/32bit PCI bus.
>>The MCPN765 uses a Hawk ASIC for Memory/PCI bus control.
>>
>>We have been attempting to debug the driver to find the cause but have been
>>hitting brick walls. The system appears to lock up when the SCSI board
>>is performing a DataIn phase under the control of its on-board SCRIPTS processor.
>>
>>As the system has completely locked up we have not been able to find the cause.
>>Any information on possible causes or ideas on how to proceed would be most
>>appreciated.
> 
> 
> The software driver hasn't any handle on the actual differences between
> the BUS that leads to failure and the one that allows success:
> 
> 1) The PCI clock is full hardware dependant. There is nothing software can
>    change here.
> 
> 2) Same for the PCI BUS path. A 64 bit PCI BUS just allows to transfer 64
>    bit of data per BUS cycle but a 32 bit PCI BUS can only transfer 32 bit
>    per PCI cycle.
> 
> 3) Both PCI BUSes width allows 64 bit memory addressing.
> 
> As we know, PCI device drivers relies on kernel generic PCI driver that
> provides configuration access and DMA address translation services. The
> kernel PCI related code uses machine-dependent and bridge-dependant
> methods. So, IMO, there is far more places than just the driver code that
> are involved in the failure you report (including the related pieces of
> hardware).
> 
> I would suggest you to check the following at first:
> 
> 1) Give a look at the PCI configuration space of the chip (or report it).
>    For example, a base address that doesn't fit in 32 bit is very
>    uncommon. Etc...
> 
> 2) Configure the driver for 32 bit DMA (DMA MODE = 0). This will ensure
>    that all DMA addresses will fit in 32 bit and that no PCI dual cycle
>    will occur on behalf of the 1033-66 chip.
> 
>  Gérard.
> 


-- 
   Dr Terry Barnaby                     BEAM Ltd
   Phone: +44 1454 324512               Northavon Business Center, Dean Rd
   Fax:   +44 1454 313172               Yate, Bristol, BS37 5NH, UK
   Email: terry@beam.ltd.uk             Web: www.beam.ltd.uk
   BEAM for: Visually Impaired X-Terminals, Parallel Processing, Software Dev
                          "Tandems are twice the fun !"

