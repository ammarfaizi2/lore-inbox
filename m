Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263937AbUFCLnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263937AbUFCLnt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 07:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263942AbUFCLnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 07:43:49 -0400
Received: from chaos.analogic.com ([204.178.40.224]:52096 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263937AbUFCLnp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 07:43:45 -0400
Date: Thu, 3 Jun 2004 07:42:56 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Stuart Young <cef-lkml@optusnet.com.au>
cc: linux-kernel@vger.kernel.org,
       Markus Lidel <Markus.Lidel@shadowconnect.com>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Problem with ioremap which returns NULL in 2.6 kernel
In-Reply-To: <200406031241.27669.cef-lkml@optusnet.com.au>
Message-ID: <Pine.LNX.4.53.0406030735460.3377@chaos>
References: <40BC788A.3020103@shadowconnect.com> <40BDF1AC.7070209@shadowconnect.com>
 <Pine.LNX.4.53.0406021144280.559@chaos> <200406031241.27669.cef-lkml@optusnet.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jun 2004, Stuart Young wrote:

> On Thu, 3 Jun 2004 01:45, Richard B. Johnson wrote:
> > I asked for the output of `cat /proc/pci` . Unless I get that
> > information, I can't find the length of the allocation.
>
> Is there no way to to get this information out of lspci (eg: lspci -vv)? This
> is particularly annoying since /proc/pci is depreciated. I know a number of
> people who simply don't bother turning it on anymore. If there is information
> in /proc/pci that isn't available through lspci somehow, then I'd call that a
> nasty regression, which needs to be fixed.
>
> Are you sure on this Richard? (No disrespect intended, just want to confirm
> things).
>
> --
>  Stuart Young (aka Cef)
>  cef-lkml@optusnet.com.au is for LKML and related email only
>

Well.. Here is `cat /proc/pci`


Script started on Thu Jun  3 07:38:33 2004
quark:/home/johnson[1] cat /proc/pci
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel Corp. 430VX - 82437VX TVX [Triton VX] (rev 2).
      Master Capable.  Latency=24.
  Bus  0, device   7, function  0:
    ISA bridge: Intel Corp. 82371SB PIIX3 ISA [Natoma/Triton II] (rev 1).
  Bus  0, device   7, function  1:
    IDE interface: Intel Corp. 82371SB PIIX3 IDE [Natoma/Triton II] (rev 0).
      Master Capable.  Latency=16.
      I/O at 0xffa0 [0xffaf].
  Bus  0, device  13, function  0:
    SCSI storage controller: BusLogic BT-946C (BA80C30) [MultiMaster 10] (rev 8).
      IRQ 10.
      Master Capable.  Latency=24.  Min Gnt=8.Max Lat=8.
      I/O at 0xfff4 [0xfff7].
      Non-prefetchable 32 bit memory at 0xffbef000 [0xffbeffff].
  Bus  0, device  14, function  0:
    VGA compatible controller: S3 Inc. 86c325 [ViRGE] (rev 6).
      IRQ 11.
      Master Capable.  Latency=24.  Min Gnt=4.Max Lat=255.
      Non-prefetchable 32 bit memory at 0xf8000000 [0xfbffffff].
  Bus  0, device  16, function  0:
    Ethernet controller: 3Com Corporation 3c905 100BaseTX [Boomerang] (rev 0).
      IRQ 9.
      Master Capable.  Latency=24.  Min Gnt=3.Max Lat=8.
      I/O at 0xff00 [0xff3f].


Now lspci 'interprets' stuff. The interpretation may not be correct.
For instance, you think that your device wants 64 Megabytes. This is,
like, unheard of except for screen controllers and they are basically
broken because 64 megabytes can't be accessed at any one time. Large
allocations should be paged, but a page register costs a nickel
in the FPGA so vendors being cheap, cheap, grab a lot of your
address-space.

quark:/home/johnson[2] /sbin/lspci -v
00:00.0 Host bridge: Intel Corp. 430VX - 82437VX TVX [Triton VX] (rev 02)
	Flags: bus master, medium devsel, latency 24

00:07.0 ISA bridge: Intel Corp. 82371SB PIIX3 ISA [Natoma/Triton II] (rev 01)
	Flags: bus master, medium devsel, latency 0

00:07.1 IDE interface: Intel Corp. 82371SB PIIX3 IDE [Natoma/Triton II] (prog-if 80 [Master])
	Flags: medium devsel
	I/O ports at ffa0 [size=16]

00:0d.0 SCSI storage controller: BusLogic BT-946C (BA80C30) [MultiMaster 10] (rev 08)
	Subsystem: BusLogic BT-946C (BA80C30) [MultiMaster 10]
	Flags: bus master, fast devsel, latency 24, IRQ 10
	I/O ports at fff4 [size=4]
	Memory at ffbef000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=32K]

00:0e.0 VGA compatible controller: S3 Inc. 86c325 [ViRGE] (rev 06) (prog-if 00 [VGA])
	Flags: bus master, VGA palette snoop, medium devsel, latency 24, IRQ 11
	Memory at f8000000 (32-bit, non-prefetchable) [size=64M]
	Expansion ROM at <unassigned> [disabled] [size=64K]

00:10.0 Ethernet controller: 3Com Corporation 3c905 100BaseTX [Boomerang]
	Flags: bus master, medium devsel, latency 24, IRQ 9
	I/O ports at ff00 [size=64]
	Expansion ROM at <unassigned> [disabled] [size=64K]

quark:/home/johnson[3] exit
Script done on Thu Jun  3 07:39:00 2004


Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


