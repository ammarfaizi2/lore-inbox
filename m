Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129047AbRBGRT4>; Wed, 7 Feb 2001 12:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129031AbRBGRTr>; Wed, 7 Feb 2001 12:19:47 -0500
Received: from open.hands.com ([195.224.53.39]:23045 "HELO open.hands.com")
	by vger.kernel.org with SMTP id <S129026AbRBGRTA>;
	Wed, 7 Feb 2001 12:19:00 -0500
Date: Wed, 7 Feb 2001 17:18:51 +0000
From: Charles Briscoe-Smith <cpbs@debian.org>
To: linux-kernel@vger.kernel.org
Cc: Charles Briscoe-Smith <cpbs@debian.org>
Subject: PCMCIA-related IDE problems on GA-7ZX motherboard
Message-ID: <20010207171851.A10152@hands.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[Please CC me on any replies; I'm not subscribed to linux-kernel.]

I'm having problems related to using a pcmcia bridge on a desktop PC.
The machine used to contain a TMC TI5-VG+ motherboard with a 400Mhz K6-II.
With the TMC motherboard, everything worked worked fine.  When I upgraded
the machine to a Gigabyte GA-7ZX with 800Mhz Athlon, the CD-writer and
LS-120 floppy on the secondary IDE channel stopped working.  By fiddling
around with the kernel configuration, I've finally narrowed it down to
the PC card drivers; the machine contains a Chase-AT "Duo" ISA-to-PCMCIA
bridge.

What appears to happen is this.  I boot the system:

root@munkustrap:~# cat /proc/cmdline 
BOOT_IMAGE=test ro root=301 BOOT_FILE=/vmlinuz.test hdc=ide-scsi single
root@munkustrap:~# cat /proc/version 
Linux version 2.4.0 (root@munkustrap) (gcc version 2.95.2 20000313 (Debian GNU/Linux)) #1 Tue Jan 16 20:11:06 GMT 2001

I've tried several other kernel versions; some 2.2 series, some 2.4.0-test
series, and also 2.4.1.  They all give the same result.  Logging in in
single-user mode, I can access the CD-ROM drive okay:

root@munkustrap:~# cdir
sr0: CDROM not ready.  Make sure there is a disc in the drive.
nodisc

Then I load the core module:

root@munkustrap:~# insmod /lib/modules/2.4.0/kernel/drivers/pcmcia/pcmcia_core.o
Linux PCMCIA Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
root@munkustrap:~# cdir
sr0: CDROM not ready.  Make sure there is a disc in the drive.
nodisc

At this stage, the CD still works fine.  Then I insert the i82365 module:

root@munkustrap:~# insmod /lib/modules/2.4.0/kernel/drivers/pcmcia/i82365.o poll_interval=100 irq_list=5
Intel PCIC probe: 
  Cirrus PD672x ISA-to-PCMCIA at port 0x3e0 ofs 0x00, 2 sockets
    host opts [0]: [ring] [65/6/0] [1/15/0]
    host opts [1]: [ring] [65/6/0] [1/15/0]
    ISA irqs (default) = 5 polling interval = 1000 ms
charles@munkustrap:~$ cdir
scsi : aborting command due to timeout : pid 0, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
hdc: lost interrupt
scsi : aborting command due to timeout : pid 0, scsi0, channel 0, id 0, lun 0 Request Sense 00 00 00 40 00 
SCSI host 0 abort (pid 0) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
hdc: lost interrupt
(and lots more of the same...)

I've tried with and without poll_interval, and with various irq_lists
("12,13", "10", "5").  All give the same result.  The same happens with
the floppy, /dev/hdd.  /dev/hda is fine, though.

So, it seems that inserting the i82365 module interferes with the
interrupt being used for the secondary IDE channel on the GA-7ZX board,
but doesn't interfere with the secondary IDE channel on the TI5-VG+.

Does anyone know what's going on here?  Can anyone suggest a fix or
a workaround?  (Unloading the pcmcia modules does NOT cause hdc and hdd
to start working, unfortunately.  I have to reboot to get them working
again.)  Failing that, can anyone suggest how I might try to develop a
fix or a workaround?

Some more system details, in case they're of use:

root@munkustrap:~# cat /proc/interrupts      
           CPU0       
  0:      98584          XT-PIC  timer
  1:        241          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  7:          1          XT-PIC  parport0
  8:          1          XT-PIC  rtc
  9:       2330          XT-PIC  usb-uhci, usb-uhci, eth0
 12:          2          XT-PIC  PS/2 Mouse
 14:       3444          XT-PIC  ide0
 15:         80          XT-PIC  ide1
NMI:          0 
ERR:          0

(Also, I know that irqs 3 and 4 are in use by the serial ports.  I think
the rest are free.)

root@munkustrap:~# cat /proc/iomem      
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000ec000-000effff : reserved
000f0000-000fffff : System ROM
00100000-07feffff : System RAM
  00100000-00201681 : Kernel code
  00201682-00266067 : Kernel data
07ff0000-07ff7fff : ACPI Tables
07ff8000-07ffffff : ACPI Non-volatile Storage
ddc00000-dfcfffff : PCI Bus #01
  de000000-deffffff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
    de000000-deffffff : atyfb
dfe00000-dfefffff : PCI Bus #01
  dfeff000-dfefffff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
e0000000-e3ffffff : VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
ffff0000-ffffffff : reserved
root@munkustrap:~# cat /proc/ioports 
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(set)
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03e0-03e1 : i82365
03f6-03f6 : ide0
03f8-03ff : serial(set)
0400-040f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
0778-077a : parport0
0800-08ff : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
0c00-0c7f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
0cf8-0cff : PCI conf1
9000-afff : PCI Bus #01
  a800-a8ff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
cc00-cc1f : Realtek Semiconductor Co., Ltd. RTL-8029(AS)
  cc00-cc1f : ne2k-pci
d000-d03f : Ensoniq ES1371 [AudioPCI-97]
d400-d41f : VIA Technologies, Inc. UHCI USB
  d400-d41f : usb-uhci
d800-d81f : VIA Technologies, Inc. UHCI USB (#2)
  d800-d81f : usb-uhci
ffa0-ffaf : VIA Technologies, Inc. Bus Master IDE
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1
root@munkustrap:~# cat /proc/pci     
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 2).
      Master Capable.  Latency=8.  
      Prefetchable 32 bit memory at 0xe0000000 [0xe3ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (rev 0).
      Master Capable.  No bursts.  Min Gnt=8.
  Bus  0, device   7, function  0:
    ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 34).
  Bus  0, device   7, function  1:
    IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 16).
      Master Capable.  Latency=32.  
      I/O at 0xffa0 [0xffaf].
  Bus  0, device   7, function  3:
    USB Controller: VIA Technologies, Inc. UHCI USB (#2) (rev 16).
      IRQ 9.
      Master Capable.  Latency=64.  
      I/O at 0xd800 [0xd81f].
  Bus  0, device   7, function  2:
    USB Controller: VIA Technologies, Inc. UHCI USB (rev 16).
      IRQ 9.
      Master Capable.  Latency=64.  
      I/O at 0xd400 [0xd41f].
  Bus  0, device   7, function  4:
    SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 48).
  Bus  0, device  14, function  0:
    Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 7).
      IRQ 10.
      Master Capable.  Latency=64.  Min Gnt=12.Max Lat=128.
      I/O at 0xd000 [0xd03f].
  Bus  0, device  15, function  0:
    Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS) (rev 0).
      IRQ 9.
      I/O at 0xcc00 [0xcc1f].
  Bus  1, device   0, function  0:
    VGA compatible controller: ATI Technologies Inc 3D Rage Pro AGP 1X/2X (rev 92).
      IRQ 11.
      Master Capable.  Latency=64.  Min Gnt=8.
      Prefetchable 32 bit memory at 0xde000000 [0xdeffffff].
      I/O at 0xa800 [0xa8ff].
      Non-prefetchable 32 bit memory at 0xdfeff000 [0xdfefffff].

Thanks for any help.

-- 
The currently .sig-less Charles Briscoe-Smith
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
