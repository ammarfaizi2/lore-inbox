Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266760AbTAIOnl>; Thu, 9 Jan 2003 09:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266761AbTAIOnl>; Thu, 9 Jan 2003 09:43:41 -0500
Received: from mail.t-intra.de ([62.156.147.75]:5565 "EHLO mailc0910.dte2k.de")
	by vger.kernel.org with ESMTP id <S266760AbTAIOni>;
	Thu, 9 Jan 2003 09:43:38 -0500
Date: Thu, 9 Jan 2003 17:50:32 +0100 (CET)
From: Chrissie <x.chrissie.x@t-online.de>
To: mdharm-usb@one-eyed-alien.net, <linux-kernel@vger.kernel.org>,
       <sjr@debian.org>, <eyesee@gmx.net>, <anti@webhome.de>,
       <thomas.hechelhammer@t-online.de>
Subject: Oops with usb-mass-storage
Message-ID: <Pine.LNX.4.50.0301091702070.958-100000@balearen.x-tra-designs>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 09 Jan 2003 14:52:20.0318 (UTC) FILETIME=[B5FD6FE0:01C2B7EE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I bought the digital still camera Praktica DC21. It is one of the
cheaper models with usb-storage emulation. Under win98, the camera works
well and appears as an additional drive in explorer, after i had the
drive-INF-file installed. The camera is a sony-based oem-version, i found
out. You can look for addidional Informations of the camera at
www.praktica.de.

I thought, it should be possible to use every usb mass storage device with
compact flash card under linux. But the first time i plugged in the camera
onto the usb-port, i could not even think about mounting it.

The device identifies as following:
chrissie@balearen:~$ cat /proc/bus/usb/devices
T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB UHCI Root Hub
S:  SerialNumber=d400
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  4 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=084d ProdID=0011 Rev= 1.10
S:  Manufacturer=
S:  Product=DC2MEGA
C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=06 Prot=50 Driver=usb-storage
E:  Ad=81(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=05(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms

I added the device in unusual_devs.h.

// added by chrissie
UNUSUAL_DEV (0x084d, 0x0011, 0x0001, 0x9999,
                "Praktika D2MEGA",
                "Digital Camera",
                US_SC_SCSI, US_PR_BULK, NULL,
                US_FL_MODE_XLATE ),

Then i compiled and installed the modules.

I am using Debian Linux 3.0r1, with an kernel 2.4.20, self-compiled.
chrissie@balearen:~$ uname -a
Linux balearen 2.4.20 #8 Thu Jan 9 15:55:10 CET 2003 i686 unknown

Now, i get the following output in dmesg after switching the camera on:
hub.c: connect-debounce failed, port 2 disabled
hub.c: new USB device 00:07.2-2, assigned address 2
scsi1 : SCSI emulation for USB Mass Storage devices
  Vendor:           Model:                   Rev:
  Type:   Direct-Access                      ANSI SCSI revision: 02
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 2

Looks quite good, i think.

chrissie@balearen:~$ cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: LITEON   Model: CD-ROM LTN301    Rev: ML35
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor:          Model: CD-R/RW RW7120A  Rev: 1.10
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: DSC      Model: Card Reader      Rev:  .
  Type:   Direct-Access                    ANSI SCSI revision: 02

The device now seems to be recogniced, and the usb-storage-to-scsi seems
to work as well.

I was very happy so far. But when i enter the following:

root@balearen:~# mount /dev/sda1 /mnt -t vfat

i get an kernel oops after following additional output to the console

usb-uhci: interrupt, status 3, frame #1976
          interrupt, status 2, frame #1259

a ps -ax at another console at this time tells me, that the sd_mod is in
the state initializing.

The console now hangs for a short time, and the following kernel oops is
as follows:
usb.c: usb disconnect on device 00:07.2-2 adress 3
Unable to handle kernel NULL pointer dereference at virtual address
0000000c
printing eip
c01261d8
*pde=00000000
Oops: 0000
CPU: 0
EIP: 0010:[<c01261d8>] Not tainted
Eflags: 0001002
eax: 00b00000 ebx: 00000093 ecx: 00000000 edx: c100001c
esi: 00000000 edi: 00000206 ebp: ce13be00 esp: c9c39de0
ds: 0018 es:0018 ss:0018

Process usb.agent (pid:1010, stackpage=c9c39000)

Stack 00000000 ce9348c0 00000000 ce13be00 c01d2b23 00000693 ce13be00
ce9348c0
      00000000 ce13be00 ce13be00 d0838e50 c1338860 ce13be00 c01d202c
ce13be00
      ce13be00 00000000 d083977c ce13be00 c133887c c1338860 00000000
00000000

Call trace: [<c01d2b23>] [<d0838e50>] [<c01d202c>] [<d0839852>]
            [<c0107e8d>] [<c0107ff6>] [<c010a1d8>] [<c011f09b>]
[<c010eb64>]
            [<c010ea04>] [<c011992c>] [<c011a904>] [<c0106cc4>]

Code: 2b 59 0c 89 d8 31 d2 f7 76 18 89 c3 86 41 14 89 44 99 18 89

<0> Kernel panic: Aiee, killing interrupt handler!
    In interrupt handler: not syncing

Additionally, a LED at the keyboard is flashing.
Now, the system is dead and i have to do a hardware-reset.

Now, some additional system information:
(if interesting for you)
balearen:~# gcc --version
2.95.4
balearen:~# lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo
PRO133x] (rev 44)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo
MVP3/Pro133x AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C596 ISA [Mobile South]
(rev 12)
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 08)
00:07.3 Host bridge: VIA Technologies, Inc. VT82C596 Power Management (rev
20)
00:0a.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro (rev
5c)
00:0c.0 Ethernet controller: 3Com Corporation 3c900 Combo [Boomerang]
00:0e.0 Ethernet controller: D-Link System Inc Sundance Ethernet
00:10.0 Communication controller: Conexant HSF 56k Data/Fax/Voice Modem
(rev 01)

The processor i am using is a Celeron Coppermine 733 MHz overcloced to
1100 MHz,


Well, to come to an end:
I am really interested to get this camera to work under Linux.

Can you tell me, what to do any further? I am at the end from my sight, so
far.


Matthew Dharm: i can send the camera to you for a period of time, if you
are interested.

Thanks in advance for any help!

Christian Braeunlich (chrissie)
x.chrissie.x@t-online.de


