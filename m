Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130340AbQKPRGm>; Thu, 16 Nov 2000 12:06:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130371AbQKPRGW>; Thu, 16 Nov 2000 12:06:22 -0500
Received: from ext.lri.fr ([129.175.15.4]:4267 "EHLO ext.lri.fr")
	by vger.kernel.org with ESMTP id <S130340AbQKPRGW>;
	Thu, 16 Nov 2000 12:06:22 -0500
From: "Benjamin Monate <Benjamin Monate" <Benjamin.Monate@lri.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-ID: <14868.3329.775330.576681@sun-demons>
Date: Thu, 16 Nov 2000 17:36:17 +0100 (MET)
To: linux-kernel@vger.kernel.org
Subject: Strange lockup of the timer with 2.4.0-test10 SMP (and older)
X-Mailer: VM 6.62 under Emacs 20.7.1
Reply-To: Benjamin.Monate@lri.fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After some non deterministic amount of time (less than 2 hours)
every application that rely on time get locked.
If a do a 'cat /proc/interrupts' I can see that the timer and NMI
interrupts counter don't increase any more.
My base configuration is : Asus CUR-DLS Bi PIII 933MHz, 2GB RDRAM
~ > uname -a
Linux pc8-118 2.4.0-test10 #1 SMP Thu Nov 16 13:18:57 CET 2000 i686unknown
 ~ > cat /proc/interrupts 
           CPU0       CPU1       
  0:     143295     143298    IO-APIC-edge  timer  <<< This one is stuck
  1:       3867       3275    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  8:          0          1    IO-APIC-edge  rtc
 12:      46469      51592    IO-APIC-edge  PS/2 Mouse
 13:          0          0          XT-PIC  fpu
 17:         11         16   IO-APIC-level  aic7xxx
 20:      14764      14294   IO-APIC-level  eth0
 24:       1917       1855   IO-APIC-level  sym53c8xx
 25:         15         15   IO-APIC-level  sym53c8xx
NMI:     286482     286482 < < < < stuck 
LOC:     286422     286420 < < < < stuck 
ERR:          0

Nothing in syslogs indicates a panic nor an oops. The nmi watchdog is
activated and reports nothing.

The problem will not occur if nosmp is passed to the kernel.
The problem occurs aswell if I use a 2.2.17 kernel.

What does not work: 
- X becomes non functional
- reboot will not reboot and will emit a infinite beep on the internal
speaker
- sleep 1 is endless but interruptible with C-c
- Magic SysRq will not synchronize nor umount filesystems
- date will not increase
What works:
- network and all related services
- shell (becomes slugish from time to time)
- console login
- hwclock is increasing correctly.

Here are the first boot messages from dmsg:
 0    0   0   0    1    1    59
 08 003 03  0    0    0   0   0    1    1    61
 09 003 03  1    1    0   1   0    1    1    69
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 003 03  0    0    0   0   0    1    1    71
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00

IO APIC #1......
.... register #00: 01000000
.......    : physical APIC id: 01
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : IO APIC version: 0011
.... register #02: 03000000
.......     : arbitration: 03
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 003 03  1    1    0   1   0    1    1    79
 01 003 03  1    1    0   1   0    1    1    81
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  1    0    0   0   0    0    0    00
 04 003 03  1    1    0   1   0    1    1    89
 05 000 00  1    0    0   0   0    0    0    00
 06 000 00  1    0    0   0   0    0    0    00
 07 000 00  1    0    0   0   0    0    0    00
 08 003 03  1    1    0   1   0    1    1    91
 09 003 03  1    1    0   1   0    1    1    99
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 2
IRQ1 -> 1
IRQ3 -> 3
IRQ4 -> 4
IRQ6 -> 6
IRQ7 -> 7
IRQ8 -> 8
IRQ9 -> 9
IRQ12 -> 12
IRQ16 -> 0
IRQ17 -> 1
IRQ20 -> 4
IRQ24 -> 8
IRQ25 -> 9
.................................... done.
calibrating APIC timer ...
..... CPU clock speed is 933.5232 MHz.
..... host bus clock speed is 133.3603 MHz.
cpu: 0, clocks: 1333603, slice: 444534
CPU0<T0:1333600,T1:889056,D:10,S:444534,C:1333603>
cpu: 1, clocks: 1333603, slice: 444534
CPU1<T0:1333600,T1:444528,D:4,S:444534,C:1333603>
checking TSC synchronization across CPUs: passed.
Setting commenced=1, go go go
PCI: PCI BIOS revision 2.10 entry at 0xf0aa0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: ServerWorks host bridge: secondary bus 00
PCI: ServerWorks host bridge: secondary bus 01
PCI: Using IRQ router default [1166/0200] at 00:0f.0
PCI->APIC IRQ transform: (B1,I5,P0) -> 24
PCI->APIC IRQ transform: (B1,I5,P1) -> 25
PCI->APIC IRQ transform: (B0,I2,P0) -> 20
PCI->APIC IRQ transform: (B0,I3,P0) -> 16
PCI->APIC IRQ transform: (B0,I4,P0) -> 17
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
P6 Microcode Update Driver v1.07
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
NTFS version 000607
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10d
Software Watchdog Timer: 0.05, timer margin: 60 sec
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.33 $ 2000/05/24 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
eth0: OEM i82557/i82558 10/100 Ethernet, 00:E0:18:02:5E:D5, IRQ 20.
  Board assembly 668081-002, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
  Receiver lock-up workaround activated.
SCSI subsystem driver Revision: 1.00
(scsi0) <Adaptec AIC-7850 SCSI host adapter> found at PCI 0/4/0
(scsi0) Narrow Channel, SCSI ID=7, 3/255 SCBs
(scsi0) Downloading sequencer code... 415 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.1/5.2.0
       <Adaptec AIC-7850 SCSI host adapter>
(scsi0:0:4:0) Synchronous at 10.0 Mbyte/sec, offset 15.
  Vendor: PIONEER   Model: DVD-ROM DVD-304   Rev: 1.03
  Type:   CD-ROM                             ANSI SCSI revision: 02
sym53c8xx: at PCI bus 1, device 5, function 0
sym53c8xx: 53c896 detected with Symbios NVRAM
sym53c8xx: at PCI bus 1, device 5, function 1
sym53c8xx: 53c896 detected with Symbios NVRAM
sym53c896-0: rev 0x7 on pci bus 1 device 5 function 0 irq 24
sym53c896-0: Symbios format NVRAM, ID 7, Fast-40, Parity Checking
sym53c896-0: initial SCNTL3/DMODE/DCNTL/CTEST3/4/5 = (hex) 07/4e/a0/01/00/24
sym53c896-0: final   SCNTL3/DMODE/DCNTL/CTEST3/4/5 = (hex) 07/4e/80/01/08/24
sym53c896-0: on-chip RAM at 0xf7000000
sym53c896-0: resetting, command processing suspended for 2 seconds
sym53c896-0: restart (scsi reset).
sym53c896-0: enabling clock multiplier
sym53c896-0: handling phase mismatch from SCRIPTS.
sym53c896-0: Downloading SCSI SCRIPTS.
sym53c896-1: rev 0x7 on pci bus 1 device 5 function 1 irq 25
sym53c896-1: Symbios format NVRAM, ID 7, Fast-40, Parity Checking
sym53c896-1: initial SCNTL3/DMODE/DCNTL/CTEST3/4/5 = (hex) 07/4e/a0/01/00/24
sym53c896-1: final   SCNTL3/DMODE/DCNTL/CTEST3/4/5 = (hex) 07/4e/80/01/08/24
sym53c896-1: on-chip RAM at 0xf6000000
sym53c896-1: resetting, command processing suspended for 2 seconds
sym53c896-1: restart (scsi reset).
sym53c896-1: enabling clock multiplier
sym53c896-1: handling phase mismatch from SCRIPTS.
sym53c896-1: Downloading SCSI SCRIPTS.
scsi1 : sym53c8xx - version 1.6b
scsi2 : sym53c8xx - version 1.6b
sym53c896-0: command processing resumed
  Vendor: IBM       Model: DDYS-T18350N      Rev: S93E
  Type:   Direct-Access                      ANSI SCSI revision: 03
sym53c896-1: command processing resumed
sym53c896-0-<0,0>: tagged command queue depth set to 4
Detected scsi disk sda at scsi1, channel 0, id 0, lun 0
sym53c896-0-<0,0>: wide msgout: 1-2-3-1.
sym53c896-0-<0,0>: wide msgin: 1-2-3-1.
sym53c896-0-<0,0>: wide: wide=1 chg=0.
sym53c896-0-<0,*>: WIDE SCSI (16 bit) enabled.
sym53c896-0-<0,0>: wide msgout: 1-2-3-1.
sym53c896-0-<0,0>: wide msgin: 1-2-3-1.
sym53c896-0-<0,0>: wide: wide=1 chg=0.
sym53c896-0-<0,0>: sync msgout: 1-3-1-a-1f.
sym53c896-0-<0,0>: sync msg in: 1-3-1-a-1f.
sym53c896-0-<0,0>: sync: per=10 scntl3=0x90 scntl4=0x0 ofs=31 fak=0 chg=0.
sym53c896-0-<0,*>: FAST-40 WIDE SCSI 80.0 MB/s (25 ns, offset 31)
SCSI device sda: 35843670 512-byte hdwr sectors (18352 MB)
Partition check:
 sda: sda1 sda2 sda3 sda4
Detected scsi CD-ROM sr0 at scsi0, channel 0, id 4, lun 0
sr0: scsi3-mmc drive: 0x/0x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.11
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 16384 buckets, 128Kbytes
TCP: Hash tables configured (established 131072 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kmem_create: Forcing size word alignment - nfs_fh
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 200k freed

Thank you in advance for your help.

-- 
| Benjamin Monate         | mailto:Benjamin.Monate@lri.fr |
| LRI - Bât. 490       
| Université de Paris-Sud
| F-91405 ORSAY Cedex    

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
