Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284644AbRLUPoD>; Fri, 21 Dec 2001 10:44:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284653AbRLUPny>; Fri, 21 Dec 2001 10:43:54 -0500
Received: from firewall.esrf.fr ([193.49.43.1]:19337 "HELO out.esrf.fr")
	by vger.kernel.org with SMTP id <S284644AbRLUPnp>;
	Fri, 21 Dec 2001 10:43:45 -0500
From: Franc Sever <sever@esrf.fr>
Message-Id: <200112211543.QAA14053@pollux.esrf.fr>
Subject: Driver problem in version 2.4.4
To: linux-kernel@vger.kernel.org
Date: Fri, 21 Dec 2001 16:43:31 MET
Cc: maftoul@esrf.fr
X-Mailer: Elm [revision: 212.5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I wrote a driver for the counter-timer card made by 
colleagues in electronics group at ESRF.

The driver works fine for the Linux kernel version 
2.2.10 in the following setup:
The PC with Intel CPU running Linux kernel 2.2.10 is connected
via fast link MXI3 (National Instruments) to the Compact
PCI crate in which is our counter-timer card. 

It also works fine for the Linux kernel version 2.2.14 in
the following setup:
Instead of using MXI3 link I use CPU card (CP 302 card of 
PEP company with Intel processor inside) in the Compact PCI
crate and compile and link driver module on this CPU.

In the same setup (i.e. with PEP CPU card CP 302 in the CompactPCI
crate) but with the Suse Linux 7.2 kernel version 2.4.4 the driver
seems to not be able to do any operation on the card. The
BIOS sees well the card so it is seen in /proc/pci:

  Bus  2, device  13, function  0:
    Class ff00: PCI device 10e8:4750 (rev 0).
      IRQ 1.
      I/O at 0x1000 [0x103f].
      I/O at 0x1400 [0x14ff].
      I/O at 0x1800 [0x18ff]. 

If I do lspci -v I see:

02:0d.0 Class ff00: Applied Micro Circuits Corporation S5930 [Matchmaker]
        Flags: fast devsel, IRQ 1
        I/O ports at 1000 [disabled] [size=64]
        I/O ports at 1400 [disabled] [size=256]
        I/O ports at 1800 [disabled] [size=256] 

The field [disabled] disappear when I load the driver which in 
init_module() calls pci_enable_device(). 

In the driver I see the correct configuration space related information
as is seen in /proc/pci or with lspci -v, but when I want to reset the
card and then load Xilinx FPGA, it seems that no action happens in the
hardware but also no error is reported. I do not know what could be wrong.
It is all OK in /proc/modules, /proc/devices, /proc/ioports etc. 

Driver is written so that 2.2 and 2.4 parts are well 
separated by #ifdef LINUX_VERSION_CODE.... The changes that
I did for 2.4 with respect to 2.2 are the following:
- in file_operations table I use for 2.4 as first
  entry THIS MODULE and then only necessary entries
  (open, close, ioctl) and no null entries like in 2.2 
- to search for our device = to scan the PCI devices
  I use macro pci_for_each_device()
- When our device is found I do pci_enable_device(), 
  which returns 0 = OK.
- to get the base address for each I/O space (our card
  has only 3 I/O spaces and no MEMORY spaces), I use
  pci_resource_start(dev,i) where i=[0,5], to get type
  of each space (although I know they are all I/O) I
  use pci_resource_flags(dev,i) & IORESOURCE_IO.
- For each of 3 I/O spaces I do request_region() call.
- I checked also the command register of the AMCC chip
  (we use AMCC S5933 as PCI interface) and I saw that 
  IO cycles are enabled.

It seems like the addresses would be wrong since in the 
first command (which resets the card), if I read first 
the relevant register in AMCC operation registers group
I get the value 0xffffffff, although some bits should
be cleared. I also cannot load FPGA which must be done
before any other registers can be addressed.
I x-checked the base addresses by also getting them in the
"old" way with pci_get_config_dword() and masking with
PCI_BASE_ADDRESS_IO_MASK. I got the same values as with
pci_resource_start(dev, i).

Then I also looked at the file /var/log/boot.msg and the
PCI related part gives suspicious message: 
Cannot allocate resource region 0 of device 02:0d.0!!!!
although then it says:
got res[1000:103f] for resource 0 of PCI device 10e8:4750.

Here is more lines from /var/log/boot.msg:

<4>PCI: PCI BIOS revision 2.10 entry at 0xfb100, last bus=2
<4>PCI: Using configuration type 1
<4>PCI: Probing PCI hardware
<3>Unknown bridge resource 0: assuming transparent
<3>Unknown bridge resource 2: assuming transparent
<3>Unknown bridge resource 0: assuming transparent
<3>Unknown bridge resource 1: assuming transparent
<3>Unknown bridge resource 2: assuming transparent
<6>PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
<3>PCI: Cannot allocate resource region 0 of device 02:0d.0
<4>  got res[1000:103f] for resource 0 of PCI device 10e8:4750
<4>  got res[1400:14ff] for resource 1 of PCI device 10e8:4750
<4>  got res[1800:18ff] for resource 2 of PCI device 10e8:4750
<6>Limiting direct PCI/PCI transfers.           

What is also strange is that with Linux 2.2.14 the IRQ line 
seen was 15, while with the kernel version 2.4.4 I get line 1
which is already reserved for the keyboard and so I get error
resource busy when doing request_irq().

So I really do not know what could be wrong. Can you give
me some hint?

Franc Sever

***************************************************************************
Franc Sever                    Tel: (+33) 4 76 88 25 22
ESRF/Computing Services        Fax: (+33) 4 76 88 24 27
6, rue Jules Horowitz          E-mail: sever@esrf.fr
B.P. 220
F-38043 GRENOBLE CEDEX
FRANCE
***************************************************************************
