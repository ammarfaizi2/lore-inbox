Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279290AbRJWGPy>; Tue, 23 Oct 2001 02:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279273AbRJWGPe>; Tue, 23 Oct 2001 02:15:34 -0400
Received: from mail1.amc.com.au ([203.15.175.2]:12292 "HELO mail1.amc.com.au")
	by vger.kernel.org with SMTP id <S279272AbRJWGPW>;
	Tue, 23 Oct 2001 02:15:22 -0400
Message-Id: <5.1.0.14.0.20011023154226.00a20ba0@mail.amc.localnet>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 23 Oct 2001 16:15:52 +1000
To: linux-kernel@vger.kernel.org
From: Stuart Young <sgy@amc.com.au>
Subject: SiS/Trident 4DWave sound driver oops
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This kernel oops is totally reproducible (on every occasion) in 2.4.9, 
2.4.10, and 2.4.12. I have not tried earlier kernels in the 2.4 series, but 
have tried 2.2.19pre17 (will explain other SiS Chipset funny business in 
another message). All kernels were compiled while the machine was running 
2.2.19pre17.

The machine in question is a Clevo lp200t SiS630S "all-in-one" machine.
( http://www.clevo.com.tw/products/lp200t.asp - has some specs online ). 
The SiS630S chipset contains an SiS7018, so the driver is correct. Machine 
in question has a very 'sparse' BIOS, so there is little in the way I can 
configure or change.

lspci shows the following:
  00:00.0 Host bridge: Silicon Integrated Systems [SiS] 630 Host (rev 31)
  00:00.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0)
  00:01.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
  00:01.1 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 
10/100 Ethernet (rev 82)
  00:01.2 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07)
  00:01.3 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07)
  00:01.4 Multimedia audio controller: Silicon Integrated Systems [SiS] SiS 
PCI Audio Accelerator (rev 02)
  00:01.6 Modem: Silicon Integrated Systems [SiS]: Unknown device 7013 (rev a0)
  00:02.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP
  00:0c.0 CardBus bridge: Texas Instruments PCI1420
  00:0c.1 CardBus bridge: Texas Instruments PCI1420
  00:0d.0 FireWire (IEEE 1394): Texas Instruments: Unknown device 8020
  01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] 
SiS630 GUI Accelerator+3D (rev 31)

Taken from /proc/pci - the two devices that share the same IRQ.

   Bus  0, device  12, function  1:
     CardBus bridge: Texas Instruments PCI1420 (#2) (rev 0).
       IRQ 5.

   Bus  0, device   1, function  4:
     Multimedia audio controller: Silicon Integrated Systems [SiS] SiS PCI 
Audio
Accelerator (rev 2).
       IRQ 5.
       Master Capable.  Latency=128.  Min Gnt=2.Max Lat=24.
       I/O at 0x1000 [0x10ff].
       Non-prefetchable 32 bit memory at 0x34003000 [0x34003fff].

The Yenta driver (afaik) is using the Cardbus, and the cardbus interface 
works fine.

Loading the driver (eg: 'modprobe trident') results in the oops, and the 
driver itself stuck in initializing (as reported using lsmod). Trying to 
remove the driver fails, and system has to be rebooted (usually by manually 
sync'ing disks, mounting R/O, and then rebooting, all using Alt-SysRq 
methods, otherwise it hangs trying to bring down ethernet, which is an SiS900).

Output taken from syslog kernel debug output, contact me if you need 
more/different output.

  kernel: Trident 4DWave/SiS 7018/ALi 5451,Tvia CyberPro 5050 PCI Audio, 
version 0.14.9c, 10:46:08 Oct 23 2001
  kernel: PCI: Found IRQ 5 for device 00:01.4
  kernel: PCI: Sharing IRQ 5 with 00:0c.1
  kernel: trident: SiS 7018 PCI Audio found at IO 0x1000, IRQ 5
  kernel: ac97_codec: AC97  codec, id: 0x0000:0x0000 (Unknown)
  kernel: Unable to handle kernel NULL pointer dereference at virtual 
address 00000000
  kernel:  printing eip:
  kernel: cf828db6
  kernel: *pde = 00000000
  kernel: Oops: 0000
  kernel: CPU:    0
  kernel: EIP:    0010:[<cf828db6>]    Not tainted
  kernel: EFLAGS: 00010297
  kernel: eax: 00000000   ebx: cef2e680   ecx: 02000040   edx: 00001044
  kernel: esi: 000001f8   edi: 0000002a   ebp: 00000000   esp: cdce9e6c
  kernel: ds: 0018   es: 0018   ss: 0018
  kernel: Process modprobe (pid: 225, stackpage=cdce9000)
  kernel: Stack: cef2e680 000001f8 0000002a cf828d1c cef2e680 cf829fc0 
cf829cad 00000000
  kernel:        00000000 cf829faa 02000000 00000000 cef2e680 ce610000 
00000000 00000000
  kernel:        cf830d7c cef2e680 cf832040 cefe1c00 ce610000 00000000 
cef2e680 cf83120c
  kernel: Call Trace: [<cf828d1c>] [<cf829fc0>] [<cf829cad>] [<cf829faa>] 
[<cf830d7c>]
  kernel:    [<cf832040>] [<cf83120c>] [<cf83126b>] [<cf83208c>] 
[<cf832220>] [pci_announce_device+54/84]
  kernel:    [<cf83208c>] [<cf832220>] [pci_register_driver+72/96] 
[<cf832220>] [<cf83145b>] [<cf832220>]
  kernel:    [<cf831d60>] [sys_init_module+1285/1448] [<cf82c060>] 
[system_call+51/56]
  kernel:
  kernel: Code: 83 38 00 74 08 53 8b 00 ff d0 83 c4 04 31 ff ba 20 a3 82 cf

AMC Enterprises P/L    - Stuart Young
First Floor            - Network and Systems Admin
3 Chesterville Rd      - sgy@amc.com.au
Cheltenham Vic 3192    - Ph:  (03) 9584-2700
http://www.amc.com.au/ - Fax: (03) 9584-2755

