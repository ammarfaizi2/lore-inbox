Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130072AbRAOUYE>; Mon, 15 Jan 2001 15:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130870AbRAOUXy>; Mon, 15 Jan 2001 15:23:54 -0500
Received: from chaos.analogic.com ([204.178.40.224]:53122 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S130072AbRAOUXj>; Mon, 15 Jan 2001 15:23:39 -0500
Date: Mon, 15 Jan 2001 15:22:58 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Jack Hammer <jhammer@us.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Slot Number Question
In-Reply-To: <OF164CE1E4.54391C01-ON852569D5.0067049B@raleigh.ibm.com>
Message-ID: <Pine.LNX.3.95.1010115145101.2779A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jan 2001, Jack Hammer wrote:

> My adapter configuration utility needs to instruct the user which physical
> adapter needs attention ( when there may be multiple adapters in the system
> ).    My question is :  How do I determine the ( machine ) slot number of a
> PCI adapter ?
> 
> In BIOS and other OS's this may be doneby examining the system's  PCI
> Routing Tables.    I don't think I can get to those from Linux.
> 
> PCI Devices are defined by  BUS,  DEVICE, and FUNCTION.    In Linux there
> is a function ( defined in pci.h near the end of the file ) called   "
> PCI_SLOT( devfn ) "   but from what I can see this returns what PCI calls
> the device.   PCI device is not the machine's slot number.   This function
> even uses the encoded byte which is named  devfn  ( I assume from PCI
> device and PCI function ) ,   but this function treats it as slot and
> function.
> 
> Any help is appreciated.  Thanks in advance.

According to the PCI Specifications, there is no such item as the 'slot'
if what you refer to is the physical socket on a bus. The hardware
vendor is free to put any 'device number' in any such slot as long
as it is unique.

This is done by asserting the target's IDSEL line when the target <15:11>
bits are qualified. Both the PC BIOS and Linux may 'remember' these
bits and Linux used to display these bits as:

PCI devices found:
  Bus  0, device   0, function  0:
    Class 0600: PCI device 8086:7190 (rev 2).
      Master Capable.  Latency=64.  
      Prefetchable 32 bit memory at 0xe6000000 [0xe7ffffff].
  Bus  0, device   1, function  0:
    Class 0604: PCI device 8086:7191 (rev 2).
      Master Capable.  Latency=64.  Min Gnt=128.
  Bus  0, device   4, function  0:

... the 'device' shown in /proc/pci.  However, there are new problems
relating to changes made in 2.4.0, which now provides incorrect
information in /proc/pci:


    Class 0601: PCI device 8086:7110 (rev 2).
  Bus  0, device   4, function  1:
    Class 0101: PCI device 8086:7111 (rev 1).
      Master Capable.  Latency=32.  
      I/O at 0xd800 [0xd80f].
  Bus  0, device   4, function  2:
    Class 0c03: PCI device 8086:7112 (rev 1).
      IRQ 12.
      Master Capable.  Latency=32.  
      I/O at 0xd400 [0xd41f].
  Bus  0, device   4, function  3:

Note I have 3 device #4 showing in my /proc/pci file, which of course
is impossible. The meaning of 'device' seems to have been changed so one
now has to include the function number as well???!! All of the device 4
listed above refer to the exact same device. It's the PIIX4 PCI/ISA
bridge.

In my case, the correct PCI devices are shown as:

Device      Vendor                    Type
   0   Intel Corporation              440BX/ZX - 82443BX/ZX Host bridge  
       I/O memory : 0xe6000000->0xe7fffff7
   1   Intel Corporation              440BX/ZX - 82443BX/ZX AGP bridge   
       I/O memory : 0x40010100->0x470101ff
       I/O memory : 0x22a0d0e0->0x1fffdfef
       I/O memory : 0xe5e0e5f0->0xe5efe5ff
       I/O memory : 0xe5f0e600->0xe5ffe60f
   4   Intel Corporation              82371AB PIIX4 ISA                  
   9   S3 Inc.                        86c968 [Vision 968 VRAM] rev 0     
       IRQ 12 Pin 1
       I/O memory : 0x14000000->0x15ffffff
  11   3Com Corporation               3c905B 100BaseTX [Cyclone]         
       IRQ 10 Pin 1
       I/O  ports : 0xd000->0xd07e
       I/O memory : 0xe1800000->0xe180007f
  12   BusLogic                       BT-946C (BA80C30), [MultiMaster 10]
       IRQ 11 Pin 1
       I/O  ports : 0xb800->0xb802
       I/O memory : 0xe1000000->0xe1000fff

This is obtained from a program that simply scans the PCI bus in the
manner shown on page 345 of the PCI System Architecture, fourth edition,
MindShare, Inc., ISBN 0-201-30974-2.

In any case, there is no way to correlate the device number with a
PC connector slot just as there is no way to find out which of the
4 INT lines go to these connectors. The BIOS vendor only knows for
sure, and since BIOSes are not updated as often as boards, even the
BIOS is often incorrect.

I suggest you put a flashing LED on the board that needs attention.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
