Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265238AbSJRRmN>; Fri, 18 Oct 2002 13:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265277AbSJRRl5>; Fri, 18 Oct 2002 13:41:57 -0400
Received: from camus.noos.net ([212.198.2.70]:31076 "EHLO smtp.noos.fr")
	by vger.kernel.org with ESMTP id <S265238AbSJRRkF>;
	Fri, 18 Oct 2002 13:40:05 -0400
Date: Fri, 18 Oct 2002 19:45:53 +0200
From: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
To: David Brownell <david-b@pacbell.net>
Cc: greg@kroah.com, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] 2.5.42-ac1, 2.5.42, 2.5.41 boot hang with CONFIG_USB_DEBUG=n
Message-ID: <20021018174553.GA1271@rousalka.noos.fr>
References: <20021013172557.GA890@rousalka.noos.fr> <3DAAF67F.1080504@pacbell.net> <20021014212000.GA1002@rousalka.noos.fr> <3DAC4BE8.6080109@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3DAC4BE8.6080109@pacbell.net>; from david-b@pacbell.net on mar, oct 15, 2002 at 19:10:00 +0200
X-Mailer: Balsa 2.0.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002.10.15 19:10 David Brownell wrote:

>>     I don't know if it's important, but I had to enable usb keyboard 
>> legacy mode in the bios to have keyboard support in the bootloader 
>> stage. I had a bad feeling about the option though, a good bios is a 
>> lean bios.
> 
> Unless your boot loader has a small USB stack, leave that emulation
> enabled in the bios.  Linux will disable it when you bring up USB.
> 
> But it'd be worth seeing if there were any problems with that.  In 
> fact,
> in drivers/usb/host/ohci-hcd.c there is one dbg() that could affect
> init timing.  Experiment:  leave all debug messages off, but change
> the first dbg() call in hc_reset() into an err() call.  Does that make
> things better?

The answer is yes.

I've been testing like mad, with 2.5.42 then 2.5.43, with original gcc 
then new gcc in rawhide ; I dumped the ps/2 mouse and serial io I went 
all-usb (keyboard and mouse on usb hub, smartmedia combo reader 
directly on usb port) in the hope it would help produce clear-cut 
results.

I also did a memtest86 run to see if perhaps 2.5 poke in some bad ram 
location while 2.4 didn't. Clean run, it seems my dimms are ok.

I feel changing dbg() in err() is a bit worse than full 
CONFIG_USB_DEBUG=y. It certainly did hang more often at boot than with  
CONFIG_USB_DEBUG=y. However :
* with err() I get about 50% boot chance
* with err() I've never so far booted with a useless keyboard (sole 
times I booted with unchanged kernel and CONFIG_USB_DEBUG=n keyboard 
was dead)
* when it hangs with err() the takeover message is printed (never was 
before on hang)

Sometimes after  2.5.43 is booted switching to the console freezes the 
usb mouse. Don't know if it's related to the boot hang, but 
chain-restarting gpm will more often result into an oops than a 
recovered mouse. However I've just found that re-pluging it instead of 
restarting gpm unfreezes the mouse cursor.

Anyway, here is full dmesg output on a  2.5.43 kernel with err and 
CONFIG_USB_DEBUG=n, after it did manage to boot, lost mouse, tried to 
recover it via gpm then  replugging it :

Linux version 2.5.43-rous4 (root@rousalka) (gcc version 3.2 20021015 
(Red Hat Linux 8.0 3.2-10)) #1 Fri Oct 18 18:55:59 CEST 2002
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
  BIOS-e820: 000000000fff0000 - 000000000fff3000 (ACPI NVS)
  BIOS-e820: 000000000fff3000 - 0000000010000000 (ACPI data)
  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65520
   DMA zone: 4096 pages
   Normal zone: 61424 pages
   HighMem zone: 0 pages
Building zonelist for node : 0
Kernel command line: ro root=/dev/hdc1
No local APIC present or hardware disabled
Initializing CPU#0
Detected 549.008 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 1081.34 BogoMIPS
Memory: 255320k/262080k available (1987k kernel code, 6376k reserved, 
624k data, 124k init, 0k highmem)
Security Scaffold v1.0.0 initialized
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: Before vendor init, caps: 0081f9ff c0c1f9ff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: After vendor init, caps: 0081f9ff c0c1f9ff 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Machine check exception polling timer started.
CPU:     After generic, caps: 0081f9ff c0c1f9ff 00000000 00000000
CPU:             Common caps: 0081f9ff c0c1f9ff 00000000 00000000
CPU: AMD-K7(tm) Processor stepping 02
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
PCI: Using configuration type 1
adding '' to cpu class interfaces
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Starting kswapd
BIO: pool of 256 setup, 15Kb (60 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
aio_setup: sizeof(struct page) = 40
VFS: Disk quotas vdquot_6.5.1
Journalled Block Device driver loaded
udf: registering filesystem
Capability LSM initialized
matroxfb: Matrox G400 (AGP) detected
MTRR: setting reg 1
matroxfb: MTRR's turned on
matroxfb: 640x480x32bpp (virtual: 640x6552)
matroxfb: framebuffer at 0xDE000000, mapped to 0xd0812000, size 33554432
Console: switching to colour frame buffer device 80x30
fb0: MATROX VGA frame buffer device
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.11
Non-volatile memory driver v1.2
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: Detected AMD Irongate chipset
agpgart: AGP aperture is 32M @ 0xdc000000
[drm] AGP 0.99 on AMD Irongate @ 0xdc000000 32MB
MTRR: setting reg 2
[drm] Initialized mga 3.0.2 20010321 on minor 0
block request queues:
  128 requests per read queue
  128 requests per write queue
  8 requests per batch
  enter congestion at 31
  exit congestion at 33
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker
   http://www.scyld.com/network/ne2k-pci.html
eth0: RealTek RTL-8029 found at 0xe800, IRQ 11, 52:54:00:EB:D1:C6.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with 
idebus=xx
AMD7409: IDE controller at PCI slot 00:07.1
AMD7409: chipset revision 3
AMD7409: not 100% native mode: will probe irqs later
AMD7409: disabling single-word DMA support (revision < C4)
     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: IBM-DJNA-371350, ATA DISK drive
hdb: TOSHIBA DVD-ROM SD-M1302, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: MAXTOR 6L080J4, ATA DISK drive
hdd: YAMAHA CRW2100E, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 26520480 sectors (13578 MB) w/1966KiB Cache, CHS=1650/255/63, 
UDMA(33)
  hda: hda1 hda2 < hda5 hda6 >
hdc: host protected area => 1
hdc: 156355584 sectors (80054 MB) w/1819KiB Cache, CHS=155114/16/63, 
UDMA(66)
  hdc: hdc1 hdc2
hdb: ATAPI 40X DVD-ROM drive, 256kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
end_request: I/O error, dev 03:40, sector 0
end_request: I/O error, dev 03:40, sector 0
end_request: I/O error, dev 16:40, sector 0
hdd: ATAPI 40X CD-ROM CD-R/RW drive, 8192kB Cache, UDMA(25)
end_request: I/O error, dev 16:40, sector 0
end_request: I/O error, dev 16:40, sector 0
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
matroxfb_crtc2: secondary head of fb0 was registered as fb1
drivers/usb/core/hcd-pci.c: ohci-hcd @ 00:07.4, Advanced Micro Devices 
[AMD] AMD-756 [Viper] USB
drivers/usb/core/hcd-pci.c: irq 12, pci mem d282c000
drivers/usb/core/hcd.c: new USB bus registered, assigned bus number 1
drivers/usb/host/ohci-pci.c: 00:07.4: AMD756 erratum 4 workaround
drivers/usb/host/ohci-hcd.c: USB HC TakeOver from SMM
drivers/usb/core/hub.c: USB hub found at 0
drivers/usb/core/hub.c: 4 ports detected
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
register interface 'mouse' with class 'input
mice: PS/2 mouse device common for all mice
input: PC Speaker
Advanced Linux Sound Architecture Driver Version 0.9.0rc3 (Mon Oct 14 
16:41:26 2002 UTC).
request_module[snd-card-0]: not ready
request_module[snd-card-1]: not ready
request_module[snd-card-2]: not ready
request_module[snd-card-3]: not ready
request_module[snd-card-4]: not ready
request_module[snd-card-5]: not ready
request_module[snd-card-6]: not ready
request_module[snd-card-7]: not ready
specify snd_port
ALSA device list:
   #0: Ensoniq AudioPCI ES1371 at 0xe400, irq 10
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
ip_conntrack version 2.1 (2047 buckets, 16376 max) - 296 bytes per 
conntrack
ip_tables: (C) 2000-2002 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 124k freed
drivers/usb/core/hub.c: Cannot enable port 2 of hub 0, disabling port.
drivers/usb/core/hub.c: Maybe the USB cable is bad?
drivers/usb/core/hub.c: new USB device 00:07.4-4, assigned address 2
  70 00 0C 00 00 00 00 0B 00 00 00 00 60 CB 00 00 00 00
scsi1 : SCSI emulation for USB Mass Storage devices
   Vendor:           Model:                   Rev:
   Type:   Direct-Access                      ANSI SCSI revision: 02
   Vendor: SCM Micr  Model: eUSB SmartMedia   Rev: 0208
   Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
Attached scsi removable disk sdb at scsi1, channel 0, id 0, lun 1
SCSI device sda: drive cache: write through
sda : sector size 0 reported, assuming 512.
SCSI device sda: 1 512-byte hdwr sectors (0 MB)
  sda: unknown partition table
sdb : MODE SENSE failed.
sdb : status = 0, message = 00, host = 7, driver = 00
sdb : sense not available.
sdb : assuming drive cache: write through
usb_stor_clear_halt() WORKED!
usb_stor_clear_halt() WORKED!
sddr09: could not read card info
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 2
drivers/usb/core/hub.c: new USB device 00:07.4-2, assigned address 3
drivers/usb/core/hub.c: USB hub found at 2
drivers/usb/core/hub.c: 4 ports detected
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide1(22,1), internal journal
Adding 262072k swap on /dev/hdc2.  Priority:-1 extents:1
Adding 265032k swap on /dev/hda6.  Priority:-2 extents:1
drivers/usb/core/hub.c: new USB device 00:07.4-2.3, assigned address 4
input: USB HID v1.10 Mouse [Logitech USB Mouse] on usb-00:07.4-2.3
drivers/usb/core/hub.c: new USB device 00:07.4-2.4, assigned address 5
input: USB HID v1.00 Keyboard [046a:0001] on usb-00:07.4-2.4
drivers/usb/host/ohci-q.c: 00:07.4 bad entry  f9791c1
drivers/usb/host/ohci-q.c: 00:07.4 bad entry afb7b7e1
drivers/usb/host/ohci-q.c: 00:07.4 bad entry ffffffe1
usbfs: process 1125 (lsusb) did not claim interface 0 before use
usbfs: process 1125 (lsusb) did not claim interface 0 before use
usbfs: USBDEVFS_CONTROL failed dev 3 rqt 128 rq 6 len 256 ret -32
usbfs: USBDEVFS_CONTROL failed dev 3 rqt 128 rq 6 len 256 ret -32
drivers/usb/host/ohci-q.c: 00:07.4 bad entry 5fb7d1e1
drivers/usb/host/ohci-q.c: 00:07.4 bad entry ffffffe1
drivers/usb/host/ohci-q.c: 00:07.4 bad entry 5fb7d1e1
drivers/usb/host/ohci-q.c: 00:07.4 bad entry ffffffe1
drivers/usb/core/usb.c: USB disconnect on device 4
drivers/usb/core/hub.c: new USB device 00:07.4-2.3, assigned address 6
input: USB HID v1.10 Mouse [Logitech USB Mouse] on usb-00:07.4-2.3


The « drivers/usb/host/ohci-q.c: 00:07.4 bad entry » are triggerred 
by gpm failing to restart.

And in case you need it, here is the new lsusb output :

Bus 001 Device 006: ID 046d:c001 Logitech Inc. N48/M-BB48 [FirstMouse 
Plus]
Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               1.10
   bDeviceClass            0 Interface
   bDeviceSubClass         0
   bDeviceProtocol         0
   bMaxPacketSize0         8
   idVendor           0x046d Logitech Inc.
   idProduct          0xc001 N48/M-BB48 [FirstMouse Plus]
   bcdDevice            4.10
   iManufacturer           1 Logitech
   iProduct                2 USB Mouse
   iSerial                 0
   bNumConfigurations      1
   Configuration Descriptor:
     bLength                 9
     bDescriptorType         2
     wTotalLength           34
     bNumInterfaces          1
     bConfigurationValue     1
     iConfiguration          0
     bmAttributes         0xa0
       Remote Wakeup
     MaxPower               50mA
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        0
       bAlternateSetting       0
       bNumEndpoints           1
       bInterfaceClass         3 Human Interface Devices
       bInterfaceSubClass      1 Boot Interface Subclass
       bInterfaceProtocol      2 Mouse
       iInterface              0
         HID Device Descriptor:
           bLength                 9
           bDescriptorType        33
           bcdHID               1.10
           bCountryCode            0
           bNumDescriptors         1
           bDescriptorType        34 Report
           wDescriptorLength      68
cannot get report descriptor
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x81  EP 1 IN
         bmAttributes            3
           Transfer Type            Interrupt
           Synch Type               none
         wMaxPacketSize          4
         bInterval              10
   Language IDs: (length=4)
      0409 English(US)

Bus 001 Device 005: ID 046a:0001 Cherry Mikroschalter GmbH My3000 
Keyboard
Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               1.00
   bDeviceClass            0 Interface
   bDeviceSubClass         0
   bDeviceProtocol         0
   bMaxPacketSize0         8
   idVendor           0x046a Cherry Mikroschalter GmbH
   idProduct          0x0001 My3000 Keyboard
   bcdDevice            9.08
   iManufacturer           0
   iProduct                0
   iSerial                 0
   bNumConfigurations      1
   Configuration Descriptor:
     bLength                 9
     bDescriptorType         2
     wTotalLength           34
     bNumInterfaces          1
     bConfigurationValue     1
     iConfiguration          0
     bmAttributes         0xa0
       Remote Wakeup
     MaxPower              100mA
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        0
       bAlternateSetting       0
       bNumEndpoints           1
       bInterfaceClass         3 Human Interface Devices
       bInterfaceSubClass      1 Boot Interface Subclass
       bInterfaceProtocol      1 Keyboard
       iInterface              0
         HID Device Descriptor:
           bLength                 9
           bDescriptorType        33
           bcdHID               1.00
           bCountryCode            0
           bNumDescriptors         1
           bDescriptorType        34 Report
           wDescriptorLength      63
cannot get report descriptor
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x81  EP 1 IN
         bmAttributes            3
           Transfer Type            Interrupt
           Synch Type               none
         wMaxPacketSize          8
         bInterval              12
   Language IDs: (length=4)
      0009 English(English)

Bus 001 Device 003: ID 0409:0058 NEC Systems
cannot get string descriptor 1, error = Broken pipe(32)
cannot get string descriptor 2, error = Broken pipe(32)
Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               2.00
   bDeviceClass            9 Hub
   bDeviceSubClass         0
   bDeviceProtocol         0
   bMaxPacketSize0        64
   idVendor           0x0409 NEC Systems
   idProduct          0x0058
   bcdDevice            1.00
   iManufacturer           1
   iProduct                2
   iSerial                 0
   bNumConfigurations      1
   Configuration Descriptor:
     bLength                 9
     bDescriptorType         2
     wTotalLength           25
     bNumInterfaces          1
     bConfigurationValue     1
     iConfiguration          0
     bmAttributes         0xe0
       Self Powered
       Remote Wakeup
     MaxPower              100mA
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        0
       bAlternateSetting       0
       bNumEndpoints           1
       bInterfaceClass         9 Hub
       bInterfaceSubClass      0
       bInterfaceProtocol      0
       iInterface              0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x81  EP 1 IN
         bmAttributes            3
           Transfer Type            Interrupt
           Synch Type               none
         wMaxPacketSize          1
         bInterval             255
   Language IDs: (length=4)
      0409 English(US)

Bus 001 Device 002: ID 04e6:0005 Shuttle Technology Inc.
Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               1.10
   bDeviceClass            0 Interface
   bDeviceSubClass         0
   bDeviceProtocol         0
   bMaxPacketSize0        16
   idVendor           0x04e6 Shuttle Technology Inc.
   idProduct          0x0005
   bcdDevice            2.08
   iManufacturer           1 SCM Microsystems Inc.
   iProduct                2 eUSB SmartMedia / CompactFlash Adapter
   iSerial                 0
   bNumConfigurations      1
   Configuration Descriptor:
     bLength                 9
     bDescriptorType         2
     wTotalLength           39
     bNumInterfaces          1
     bConfigurationValue     1
     iConfiguration          3
     bmAttributes         0x80
     MaxPower              100mA
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        0
       bAlternateSetting       0
       bNumEndpoints           3
       bInterfaceClass       255 Vendor Specific Class
       bInterfaceSubClass      1
       bInterfaceProtocol      1
       iInterface              4 CBC Interface
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x01  EP 1 OUT
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               none
         wMaxPacketSize         64
         bInterval               0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x82  EP 2 IN
         bmAttributes            2
           Transfer Type            Bulk
           Synch Type               none
         wMaxPacketSize         64
         bInterval               0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x83  EP 3 IN
         bmAttributes            3
           Transfer Type            Interrupt
           Synch Type               none
         wMaxPacketSize          2
         bInterval              32
   Language IDs: (length=4)
      0409 English(US)

Bus 001 Device 001: ID 0000:0000 Virtual Hub
Device Descriptor:
   bLength                18
   bDescriptorType         1
   bcdUSB               1.10
   bDeviceClass            9 Hub
   bDeviceSubClass         0
   bDeviceProtocol         0
   bMaxPacketSize0         8
   idVendor           0x0000 Virtual
   idProduct          0x0000 Hub
   bcdDevice            2.05
   iManufacturer           3 Linux 2.5.43-rous4 ohci-hcd
   iProduct                2 Advanced Micro Devices [AMD] AMD-756 
[Viper] USB
   iSerial                 1 00:07.4
   bNumConfigurations      1
   Configuration Descriptor:
     bLength                 9
     bDescriptorType         2
     wTotalLength           25
     bNumInterfaces          1
     bConfigurationValue     1
     iConfiguration          0
     bmAttributes         0x40
       Self Powered
     MaxPower                0mA
     Interface Descriptor:
       bLength                 9
       bDescriptorType         4
       bInterfaceNumber        0
       bAlternateSetting       0
       bNumEndpoints           1
       bInterfaceClass         9 Hub
       bInterfaceSubClass      0
       bInterfaceProtocol      0
       iInterface              0
       Endpoint Descriptor:
         bLength                 7
         bDescriptorType         5
         bEndpointAddress     0x81  EP 1 IN
         bmAttributes            3
           Transfer Type            Interrupt
           Synch Type               none
         wMaxPacketSize          2
         bInterval             255
   Language IDs: (length=4)
      0409 English(US)

RH 8  2.4.18-kernel still runs like a charm.

I hope this can give you a hint to what problem is :(

Regards,

--
Nicolas Mailhot
