Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265940AbUF2S65@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265940AbUF2S65 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 14:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265922AbUF2S65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 14:58:57 -0400
Received: from magic.adaptec.com ([216.52.22.17]:19388 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S265958AbUF2SxT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 14:53:19 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: PATCH: Further aacraid work
Date: Tue, 29 Jun 2004 14:53:14 -0400
Message-ID: <547AF3BD0F3F0B4CBDC379BAC7E4189FF1D6BA@otce2k03.adaptec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PATCH: Further aacraid work
Thread-Index: AcReBx+n28HZRvukSFuyJioQxoDfKwAAokhw
From: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
To: "Mark Haverkamp" <markh@osdl.org>, "Byron Stanoszek" <gandalf@winds.org>
Cc: "Alan Cox" <alan@redhat.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "linux-scsi" <linux-scsi@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I believe this nails the problem too.

However, there is a corner case condition lurking on this (See my
currently unanswered email "error recovery and command completion" on
linux-scsi) where I try to deal with completing a command while error
recovery is triggered. Scsi_done will return doing *nothing* effectively
loosing the command completion.

MarkH, I had talked to you about he addition of the scsi_add_timer
before calling scsi_done to address this condition. I do not believe
this to be the (Reliable and/or performance oriented) solution.

Sincerely -- Mark Salyzyn

-----Original Message-----
From: linux-scsi-owner@vger.kernel.org
[mailto:linux-scsi-owner@vger.kernel.org] On Behalf Of Mark Haverkamp
Sent: Tuesday, June 29, 2004 2:27 PM
To: Byron Stanoszek
Cc: Alan Cox; linux-kernel; linux-scsi
Subject: Re: PATCH: Further aacraid work

On Tue, 2004-06-29 at 10:48, Byron Stanoszek wrote:
> On Wed, 16 Jun 2004, Alan Cox wrote:
> 
> > I've been going through Mark's changes with a fine toothcomb and
this merges
> > most of them. Its tested on 64bit SMP hardware and seems to be fine.
There
> > are a couple of Mark's changes I've left out for now but there isnt
really
> > an easy way to break down the changes further.
> >
> > This fixes a whole host of problems including random hangs under
high load
> >
> >
> > diff -u --new-file --recursive --exclude-from /usr/src/exclude
linux-2.6.7/drivers/scsi/aacraid/aacraid.h
2.6.7-ac/drivers/scsi/aacraid/aacraid.h
> ...etc
> 
> Alan, with your patch against Linux 2.6.7 (SMP + Preempt kernel),
aacraid still
> hangs under heavy load.
> 
> The system locks up with a message like:
> 
> aacraid: Host adapter reset request. SCSI hang?
> 
> And there is no OOPS, but after about 30 seconds the SCSI device is
> disconnected from the bus and ReiserFS complains about I/O problems. I
can
> reproduce the problem repeatedly with a simple rsync.
> 
> Do you have any additional patches I could test out to help you solve
this
> problem?
> 
> Thanks,
>   -Byron

I'm not sure that this explains your problem, but I think that the reset
handler had a bug fix reverted in the patch.  If while scanning for
active commands, and there are none on the current device, but there are
active ones on subsequent devices, the error handler will exit too
soon.  All devices need to be checked and have no active commands before
exiting.  Here is a patch that fixes this.

===== drivers/scsi/aacraid/linit.c 1.31 vs edited =====
--- 1.31/drivers/scsi/aacraid/linit.c	2004-06-18 13:19:24 -07:00
+++ edited/drivers/scsi/aacraid/linit.c	2004-06-29 11:22:58 -07:00
@@ -409,13 +409,15 @@
 				}
 			}
 			spin_unlock_irqrestore(&dev->list_lock, flags);
+			if (active)
+				break;
 
-			/*
-			 * We can exit If all the commands are complete
-			 */
-			if (active == 0)
-				return SUCCESS;
 		}
+		/*
+		 * We can exit If all the commands are complete
+		 */
+		if (active == 0)
+			return SUCCESS;
 		spin_unlock_irq(host->host_lock);
 		scsi_sleep(HZ);
 		spin_lock_irq(host->host_lock);

> 
> 
> 
> Linux version 2.6.7 (gcc version 3.4.0) #3 SMP Tue Jun 29 13:23:58 EDT
2004
> BIOS-provided physical RAM map:
>   BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
>   BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
>   BIOS-e820: 0000000000100000 - 000000000fffe000 (usable)
>   BIOS-e820: 000000000fffe000 - 0000000010000000 (reserved)
>   BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
>   BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
>   BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
> 255MB LOWMEM available.
> found SMP MP-table at 000fe710
> On node 0 totalpages: 65534
>    DMA zone: 4096 pages, LIFO batch:1
>    Normal zone: 61438 pages, LIFO batch:14
>    HighMem zone: 0 pages, LIFO batch:1
> DMI 2.3 present.
> ACPI disabled because your bios is from 2000 and too old
> You can enable it with acpi=force
> Dell PowerEdge 2400 series board detected. Selecting BIOS-method for
reboots.
> Intel MultiProcessor Specification v1.4
>      Virtual Wire compatibility mode.
> OEM ID: DELL     Product ID: POWEREDGE 9B APIC at: 0xFEE00000
> Processor #1 6:8 APIC version 17
> Processor #0 6:8 APIC version 17
> I/O APIC #2 Version 17 at 0xFEC00000.
> I/O APIC #3 Version 17 at 0xFEC01000.
> Enabling APIC mode:  Flat.  Using 2 I/O APICs
> Processors: 2
> Built 1 zonelists
> Kernel command line: auto BOOT_IMAGE=linux ro root=801
> Initializing CPU#0
> PID hash table entries: 1024 (order 10: 8192 bytes)
> Detected 731.418 MHz processor.
> Using tsc for high-res timesource
> Console: colour VGA+ 80x25
> Memory: 255968k/262136k available (2242k kernel code, 5436k reserved,
630k data, 188k init, 0k highmem)
> Checking if this processor honours the WP bit even in supervisor
mode... Ok.
> Calibrating delay loop... 1441.79 BogoMIPS
> Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
> Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
> Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> CPU:     After generic identify, caps: 0383fbff 00000000 00000000
00000000
> CPU:     After vendor identify, caps: 0383fbff 00000000 00000000
00000000
> CPU: L1 I cache: 16K, L1 D cache: 16K
> CPU: L2 cache: 256K
> CPU:     After all inits, caps: 0383fbff 00000000 00000000 00000040
> Enabling fast FPU save and restore... done.
> Enabling unmasked SIMD FPU exception support... done.
> Checking 'hlt' instruction... OK.
> CPU0: Intel Pentium III (Coppermine) stepping 03
> per-CPU timeslice cutoff: 731.56 usecs.
> task migration cache decay timeout: 1 msecs.
> enabled ExtINT on CPU#0
> ESR value before enabling vector: 00000040
> ESR value after enabling vector: 00000000
> Booting processor 1/0 eip 2000
> Initializing CPU#1
> masked ExtINT on CPU#1
> ESR value before enabling vector: 00000000
> ESR value after enabling vector: 00000000
> Calibrating delay loop... 1458.17 BogoMIPS
> CPU:     After generic identify, caps: 0383fbff 00000000 00000000
00000000
> CPU:     After vendor identify, caps: 0383fbff 00000000 00000000
00000000
> CPU: L1 I cache: 16K, L1 D cache: 16K
> CPU: L2 cache: 256K
> CPU:     After all inits, caps: 0383fbff 00000000 00000000 00000040
> CPU1: Intel Pentium III (Coppermine) stepping 03
> Total of 2 processors activated (2899.96 BogoMIPS).
> ENABLING IO-APIC IRQs
> Setting 2 in the phys_id_present_map
> ...changing IO-APIC physical APIC ID to 2 ... ok.
> Setting 3 in the phys_id_present_map
> ...changing IO-APIC physical APIC ID to 3 ... ok.
> init IO_APIC IRQs
>   IO-APIC (apicid-pin) 2-0, 2-2, 2-5, 2-10, 2-11, 2-13, 2-14 not
connected.
> ..TIMER: vector=0x31 pin1=-1 pin2=0
> ...trying to set up timer (IRQ0) through the 8259A ... 
> ..... (found pin 0) ...works.
> number of MP IRQ sources: 40.
> number of IO-APIC #2 registers: 16.
> number of IO-APIC #3 registers: 16.
> testing the IO APIC.......................
> IO APIC #2......
> .... register #00: 02000000
> .......    : physical APIC id: 02
> .......    : Delivery Type: 0
> .......    : LTS          : 0
> .... register #01: 000F0011
> .......     : max redirection entries: 000F
> .......     : PRQ implemented: 0
> .......     : IO APIC version: 0011
> .... register #02: 00000000
> .......     : arbitration: 00
> .... IRQ redirection table:
>   NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
>   00 001 01  0    0    0   0   0    1    1    31
>   01 001 01  0    0    0   0   0    1    1    39
>   02 000 00  1    0    0   0   0    0    0    00
>   03 001 01  0    0    0   0   0    1    1    41
>   04 001 01  0    0    0   0   0    1    1    49
>   05 000 00  1    0    0   0   0    0    0    00
>   06 001 01  0    0    0   0   0    1    1    51
>   07 001 01  0    0    0   0   0    1    1    59
>   08 001 01  0    0    0   0   0    1    1    61
>   09 001 01  0    0    0   0   0    1    1    69
>   0a 000 00  1    0    0   0   0    0    0    00
>   0b 000 00  1    0    0   0   0    0    0    00
>   0c 001 01  0    0    0   0   0    1    1    71
>   0d 000 00  1    0    0   0   0    0    0    00
>   0e 000 00  1    0    0   0   0    0    0    00
>   0f 001 01  0    0    0   0   0    1    1    79
> IO APIC #3......
> .... register #00: 03000000
> .......    : physical APIC id: 03
> .......    : Delivery Type: 0
> .......    : LTS          : 0
> .... register #01: 000F0011
> .......     : max redirection entries: 000F
> .......     : PRQ implemented: 0
> .......     : IO APIC version: 0011
> .... register #02: 0D000000
> .......     : arbitration: 0D
> .... IRQ redirection table:
>   NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
>   00 001 01  1    1    0   1   0    1    1    81
>   01 001 01  1    1    0   1   0    1    1    89
>   02 001 01  1    1    0   1   0    1    1    91
>   03 001 01  1    1    0   1   0    1    1    99
>   04 001 01  1    1    0   1   0    1    1    A1
>   05 001 01  1    1    0   1   0    1    1    A9
>   06 001 01  1    1    0   1   0    1    1    B1
>   07 001 01  1    1    0   1   0    1    1    B9
>   08 001 01  1    1    0   1   0    1    1    C1
>   09 001 01  1    1    0   1   0    1    1    C9
>   0a 001 01  1    1    0   1   0    1    1    D1
>   0b 001 01  1    1    0   1   0    1    1    D9
>   0c 001 01  1    1    0   1   0    1    1    E1
>   0d 001 01  1    1    0   1   0    1    1    E9
>   0e 001 01  1    1    0   1   0    1    1    32
>   0f 001 01  1    1    0   1   0    1    1    3A
> IRQ to pin mappings:
> IRQ0 -> 0:0
> IRQ1 -> 0:1
> IRQ3 -> 0:3
> IRQ4 -> 0:4
> IRQ6 -> 0:6
> IRQ7 -> 0:7
> IRQ8 -> 0:8
> IRQ9 -> 0:9
> IRQ12 -> 0:12
> IRQ15 -> 0:15
> IRQ16 -> 1:0
> IRQ17 -> 1:1
> IRQ18 -> 1:2
> IRQ19 -> 1:3
> IRQ20 -> 1:4
> IRQ21 -> 1:5
> IRQ22 -> 1:6
> IRQ23 -> 1:7
> IRQ24 -> 1:8
> IRQ25 -> 1:9
> IRQ26 -> 1:10
> IRQ27 -> 1:11
> IRQ28 -> 1:12
> IRQ29 -> 1:13
> IRQ30 -> 1:14
> IRQ31 -> 1:15
> .................................... done.
> Using local APIC timer interrupts.
> calibrating APIC timer ...
> ..... CPU clock speed is 730.0846 MHz.
> ..... host bus clock speed is 132.0880 MHz.
> checking TSC synchronization across 2 CPUs: passed.
> Brought up 2 CPUs
> CPU0:  online
>   domain 0: span 3
>    groups: 1 2
> CPU1:  online
>   domain 0: span 3
>    groups: 2 1
> NET: Registered protocol family 16
> PCI: Using configuration type 1
> mtrr: v2.0 (20020519)
> SCSI subsystem initialized
> usbcore: registered new driver usbfs
> usbcore: registered new driver hub
> PCI: Probing PCI hardware
> PCI: Probing PCI hardware (bus 00)
> PCI: Discovered primary peer bus 02 [IRQ]
> PCI: Using IRQ router ServerWorks [1166/0200] at 0000:00:0f.0
> PCI->APIC IRQ transform: (B0,I2,P0) -> 31
> PCI->APIC IRQ transform: (B0,I8,P0) -> 16
> PCI->APIC IRQ transform: (B1,I6,P0) -> 30
> PCI->APIC IRQ transform: (B2,I6,P0) -> 28
> Starting balanced_irq
> Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
> udf: registering filesystem
> lp: driver loaded but no devices found
> Real Time Clock Driver v1.12
> Linux agpgart interface v0.100 (c) Dave Jones
> Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing
disabled
> ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
> parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
> parport0: irq 7 detected
> lp0: using parport0 (polling).
> Using anticipatory io scheduler
> Floppy drive(s): fd0 is 1.44M
> FDC 0 is a National Semiconductor PC87306
> loop: loaded (max 8 devices)
> eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://www.scyld.com/network/eepro100.html
> eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V.
Savochkin <saw@saw.sw.com.sg> and others
> eth0: 0000:00:08.0, 00:B0:D0:78:4F:6A, IRQ 16.
>    Receiver lock-up bug exists -- enabling work-around.
>    Board assembly 07195d-000, Physical connectors present: RJ45
>    Primary interface chip i82555 PHY #1.
>    General self-test: passed.
>    Serial sub-system self-test: passed.
>    Internal registers self-test: passed.
>    ROM checksum self-test: passed (0x04f4518b).
>    Receiver lock-up workaround activated.
> eth1: OEM i82557/i82558 10/100 Ethernet, 00:D0:B7:D4:F1:45, IRQ 28.
>    Board assembly a08922-001, Physical connectors present: RJ45
>    Primary interface chip i82555 PHY #1.
>    General self-test: passed.
>    Serial sub-system self-test: passed.
>    Internal registers self-test: passed.
>    ROM checksum self-test: passed (0x04f4518b).
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
> scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
>          <Adaptec aic7880 Ultra SCSI adapter>
>          aic7880: Ultra Single Channel A, SCSI Id=7, 16/253 SCBs
> 
> (scsi0:A:5): 20.000MB/s transfers (20.000MHz, offset 15)
>    Vendor: NEC       Model: CD-ROM DRIVE:466  Rev: 1.06
>    Type:   CD-ROM                             ANSI SCSI revision: 02
> Red Hat/Adaptec aacraid driver (1.1.2-lk2 Jun 28 2004)
> AAC0: kernel 2.1.4 build 2939
> AAC0: monitor 2.1.4 build 2939
> AAC0: bios 2.1.0 build 2939
> AAC0: serial 58801d0fafaf001
> scsi1 : percraid
>    Vendor: DELL      Model: PERCRAID RAID5    Rev: V1.0
>    Type:   Direct-Access                      ANSI SCSI revision: 02
> st: Version 20040403, fixed bufsize 32768, s/g segs 256
> SCSI device sda: 106633728 512-byte hdwr sectors (54596 MB)
> sda: Write Protect is off
> sda: Mode Sense: 03 00 00 00
> SCSI device sda: drive cache: write through
>   sda: sda1 sda2
> Attached scsi removable disk sda at scsi1, channel 0, id 0, lun 0
> sr0: scsi3-mmc drive: 17x/40x cd/rw xa/form2 cdda tray
> Uniform CD-ROM driver Revision: 3.20
> Attached scsi CD-ROM sr0 at scsi0, channel 0, id 5, lun 0
> USB Universal Host Controller Interface driver v2.2
> usbcore: registered new driver usblp
> drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
> usbcore: registered new driver usbhid
> drivers/usb/input/hid-core.c: v2.0:USB HID core driver
> mice: PS/2 mouse device common for all mice
> input: PC Speaker
> serio: i8042 AUX port at 0x60,0x64 irq 12
> input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
> serio: i8042 KBD port at 0x60,0x64 irq 1
> input: AT Translated Set 2 keyboard on isa0060/serio0
> NET: Registered protocol family 2
> IP: routing cache hash table of 2048 buckets, 16Kbytes
> TCP: Hash tables configured (established 16384 bind 16384)
> NET: Registered protocol family 1
> NET: Registered protocol family 17
> ReiserFS: sda1: found reiserfs format "3.6" with standard journal
> ReiserFS: sda1: using ordered data mode
> ReiserFS: sda1: journal params: device sda1, size 8192, journal first
block 18, max trans len 1024, max batch 900, max commit age 30, max
trans age 30
> ReiserFS: sda1: checking transaction log (sda1)
> ReiserFS: sda1: Using r5 hash to sort names
> VFS: Mounted root (reiserfs filesystem) readonly.
> Freeing unused kernel memory: 188k freed
> Adding 257032k swap on /dev/sda2.  Priority:-1 extents:1
> 
> 
> 
> 
> 
> 
> #
> # Automatically generated make config: don't edit
> #
> CONFIG_X86=y
> CONFIG_MMU=y
> CONFIG_UID16=y
> CONFIG_GENERIC_ISA_DMA=y
> 
> #
> # Code maturity level options
> #
> CONFIG_EXPERIMENTAL=y
> # CONFIG_CLEAN_COMPILE is not set
> CONFIG_STANDALONE=y
> CONFIG_BROKEN=y
> CONFIG_BROKEN_ON_SMP=y
> 
> #
> # General setup
> #
> CONFIG_SWAP=y
> CONFIG_SYSVIPC=y
> # CONFIG_POSIX_MQUEUE is not set
> # CONFIG_BSD_PROCESS_ACCT is not set
> CONFIG_SYSCTL=y
> # CONFIG_AUDIT is not set
> CONFIG_LOG_BUF_SHIFT=14
> # CONFIG_HOTPLUG is not set
> # CONFIG_IKCONFIG is not set
> CONFIG_EMBEDDED=y
> CONFIG_KALLSYMS=y
> CONFIG_FUTEX=y
> # CONFIG_EPOLL is not set
> # CONFIG_IOSCHED_NOOP is not set
> CONFIG_IOSCHED_AS=y
> # CONFIG_IOSCHED_DEADLINE is not set
> # CONFIG_IOSCHED_CFQ is not set
> # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
> 
> #
> # Loadable module support
> #
> CONFIG_MODULES=y
> CONFIG_MODULE_UNLOAD=y
> # CONFIG_MODULE_FORCE_UNLOAD is not set
> CONFIG_OBSOLETE_MODPARM=y
> CONFIG_MODVERSIONS=y
> # CONFIG_KMOD is not set
> 
> #
> # Processor type and features
> #
> CONFIG_X86_PC=y
> # CONFIG_X86_ELAN is not set
> # CONFIG_X86_VOYAGER is not set
> # CONFIG_X86_NUMAQ is not set
> # CONFIG_X86_SUMMIT is not set
> # CONFIG_X86_BIGSMP is not set
> # CONFIG_X86_VISWS is not set
> # CONFIG_X86_GENERICARCH is not set
> # CONFIG_X86_ES7000 is not set
> # CONFIG_M386 is not set
> # CONFIG_M486 is not set
> # CONFIG_M586 is not set
> # CONFIG_M586TSC is not set
> # CONFIG_M586MMX is not set
> # CONFIG_M686 is not set
> # CONFIG_MPENTIUMII is not set
> CONFIG_MPENTIUMIII=y
> # CONFIG_MPENTIUMM is not set
> # CONFIG_MPENTIUM4 is not set
> # CONFIG_MK6 is not set
> # CONFIG_MK7 is not set
> # CONFIG_MK8 is not set
> # CONFIG_MCRUSOE is not set
> # CONFIG_MWINCHIPC6 is not set
> # CONFIG_MWINCHIP2 is not set
> # CONFIG_MWINCHIP3D is not set
> # CONFIG_MCYRIXIII is not set
> # CONFIG_MVIAC3_2 is not set
> # CONFIG_X86_GENERIC is not set
> CONFIG_X86_CMPXCHG=y
> CONFIG_X86_XADD=y
> CONFIG_X86_L1_CACHE_SHIFT=5
> CONFIG_RWSEM_XCHGADD_ALGORITHM=y
> CONFIG_X86_WP_WORKS_OK=y
> CONFIG_X86_INVLPG=y
> CONFIG_X86_BSWAP=y
> CONFIG_X86_POPAD_OK=y
> CONFIG_X86_GOOD_APIC=y
> CONFIG_X86_INTEL_USERCOPY=y
> CONFIG_X86_USE_PPRO_CHECKSUM=y
> # CONFIG_HPET_TIMER is not set
> # CONFIG_HPET_EMULATE_RTC is not set
> # CONFIG_SMP is not set
> # CONFIG_PREEMPT is not set
> # CONFIG_X86_UP_APIC is not set
> CONFIG_X86_TSC=y
> # CONFIG_X86_MCE is not set
> # CONFIG_TOSHIBA is not set
> # CONFIG_I8K is not set
> # CONFIG_MICROCODE is not set
> # CONFIG_X86_MSR is not set
> # CONFIG_X86_CPUID is not set
> 
> #
> # Firmware Drivers
> #
> # CONFIG_EDD is not set
> CONFIG_NOHIGHMEM=y
> # CONFIG_HIGHMEM4G is not set
> # CONFIG_HIGHMEM64G is not set
> # CONFIG_MATH_EMULATION is not set
> CONFIG_MTRR=y
> CONFIG_REGPARM=y
> 
> #
> # Power management options (ACPI, APM)
> #
> # CONFIG_PM is not set
> 
> #
> # ACPI (Advanced Configuration and Power Interface) Support
> #
> # CONFIG_ACPI is not set
> 
> #
> # CPU Frequency scaling
> #
> # CONFIG_CPU_FREQ is not set
> 
> #
> # Bus options (PCI, PCMCIA, EISA, MCA, ISA)
> #
> CONFIG_PCI=y
> # CONFIG_PCI_GOBIOS is not set
> # CONFIG_PCI_GOMMCONFIG is not set
> CONFIG_PCI_GODIRECT=y
> # CONFIG_PCI_GOANY is not set
> CONFIG_PCI_DIRECT=y
> # CONFIG_PCI_LEGACY_PROC is not set
> # CONFIG_PCI_NAMES is not set
> # CONFIG_ISA is not set
> # CONFIG_MCA is not set
> # CONFIG_SCx200 is not set
> 
> #
> # Executable file formats
> #
> CONFIG_BINFMT_ELF=y
> # CONFIG_BINFMT_AOUT is not set
> # CONFIG_BINFMT_MISC is not set
> 
> #
> # Device Drivers
> #
> 
> #
> # Generic Driver Options
> #
> 
> #
> # Memory Technology Devices (MTD)
> #
> # CONFIG_MTD is not set
> 
> #
> # Parallel port support
> #
> CONFIG_PARPORT=y
> CONFIG_PARPORT_PC=y
> CONFIG_PARPORT_PC_CML1=y
> # CONFIG_PARPORT_SERIAL is not set
> # CONFIG_PARPORT_PC_FIFO is not set
> # CONFIG_PARPORT_PC_SUPERIO is not set
> # CONFIG_PARPORT_OTHER is not set
> CONFIG_PARPORT_1284=y
> 
> #
> # Plug and Play support
> #
> 
> #
> # Block devices
> #
> CONFIG_BLK_DEV_FD=y
> # CONFIG_PARIDE is not set
> # CONFIG_BLK_CPQ_DA is not set
> # CONFIG_BLK_CPQ_CISS_DA is not set
> # CONFIG_BLK_DEV_DAC960 is not set
> # CONFIG_BLK_DEV_UMEM is not set
> CONFIG_BLK_DEV_LOOP=y
> # CONFIG_BLK_DEV_CRYPTOLOOP is not set
> # CONFIG_BLK_DEV_NBD is not set
> # CONFIG_BLK_DEV_CARMEL is not set
> # CONFIG_BLK_DEV_RAM is not set
> # CONFIG_LBD is not set
> 
> #
> # ATA/ATAPI/MFM/RLL support
> #
> CONFIG_IDE=y
> CONFIG_BLK_DEV_IDE=y
> 
> #
> # Please see Documentation/ide.txt for help/info on IDE drives
> #
> # CONFIG_BLK_DEV_HD_IDE is not set
> CONFIG_BLK_DEV_IDEDISK=y
> # CONFIG_IDEDISK_MULTI_MODE is not set
> CONFIG_BLK_DEV_IDECD=y
> # CONFIG_BLK_DEV_IDETAPE is not set
> # CONFIG_BLK_DEV_IDEFLOPPY is not set
> # CONFIG_BLK_DEV_IDESCSI is not set
> # CONFIG_IDE_TASK_IOCTL is not set
> CONFIG_IDE_TASKFILE_IO=y
> 
> #
> # IDE chipset support/bugfixes
> #
> # CONFIG_IDE_GENERIC is not set
> # CONFIG_BLK_DEV_CMD640 is not set
> CONFIG_BLK_DEV_IDEPCI=y
> CONFIG_IDEPCI_SHARE_IRQ=y
> # CONFIG_BLK_DEV_OFFBOARD is not set
> # CONFIG_BLK_DEV_GENERIC is not set
> # CONFIG_BLK_DEV_OPTI621 is not set
> # CONFIG_BLK_DEV_RZ1000 is not set
> CONFIG_BLK_DEV_IDEDMA_PCI=y
> # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
> CONFIG_IDEDMA_PCI_AUTO=y
> # CONFIG_IDEDMA_ONLYDISK is not set
> CONFIG_BLK_DEV_ADMA=y
> # CONFIG_BLK_DEV_AEC62XX is not set
> # CONFIG_BLK_DEV_ALI15X3 is not set
> # CONFIG_BLK_DEV_AMD74XX is not set
> # CONFIG_BLK_DEV_ATIIXP is not set
> # CONFIG_BLK_DEV_CMD64X is not set
> # CONFIG_BLK_DEV_TRIFLEX is not set
> # CONFIG_BLK_DEV_CY82C693 is not set
> # CONFIG_BLK_DEV_CS5520 is not set
> # CONFIG_BLK_DEV_CS5530 is not set
> # CONFIG_BLK_DEV_HPT34X is not set
> # CONFIG_BLK_DEV_HPT366 is not set
> # CONFIG_BLK_DEV_SC1200 is not set
> CONFIG_BLK_DEV_PIIX=y
> # CONFIG_BLK_DEV_NS87415 is not set
> # CONFIG_BLK_DEV_PDC202XX_OLD is not set
> # CONFIG_BLK_DEV_PDC202XX_NEW is not set
> # CONFIG_BLK_DEV_SVWKS is not set
> # CONFIG_BLK_DEV_SIIMAGE is not set
> # CONFIG_BLK_DEV_SIS5513 is not set
> # CONFIG_BLK_DEV_SLC90E66 is not set
> # CONFIG_BLK_DEV_TRM290 is not set
> # CONFIG_BLK_DEV_VIA82CXXX is not set
> # CONFIG_IDE_ARM is not set
> CONFIG_BLK_DEV_IDEDMA=y
> # CONFIG_IDEDMA_IVB is not set
> CONFIG_IDEDMA_AUTO=y
> # CONFIG_BLK_DEV_HD is not set
> 
> #
> # SCSI device support
> #
> CONFIG_SCSI=y
> # CONFIG_SCSI_PROC_FS is not set
> 
> #
> # SCSI support type (disk, tape, CD-ROM)
> #
> CONFIG_BLK_DEV_SD=y
> CONFIG_CHR_DEV_ST=y
> # CONFIG_CHR_DEV_OSST is not set
> CONFIG_BLK_DEV_SR=y
> # CONFIG_BLK_DEV_SR_VENDOR is not set
> # CONFIG_CHR_DEV_SG is not set
> 
> #
> # Some SCSI devices (e.g. CD jukebox) support multiple LUNs
> #
> # CONFIG_SCSI_MULTI_LUN is not set
> # CONFIG_SCSI_CONSTANTS is not set
> # CONFIG_SCSI_LOGGING is not set
> 
> #
> # SCSI Transport Attributes
> #
> # CONFIG_SCSI_SPI_ATTRS is not set
> # CONFIG_SCSI_FC_ATTRS is not set
> 
> #
> # SCSI low-level drivers
> #
> # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
> # CONFIG_SCSI_ACARD is not set
> CONFIG_SCSI_AACRAID=y
> CONFIG_SCSI_AIC7XXX=y
> CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
> CONFIG_AIC7XXX_RESET_DELAY_MS=15000
> # CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
> CONFIG_AIC7XXX_DEBUG_ENABLE=y
> CONFIG_AIC7XXX_DEBUG_MASK=0
> CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
> # CONFIG_SCSI_AIC7XXX_OLD is not set
> # CONFIG_SCSI_AIC79XX is not set
> # CONFIG_SCSI_DPT_I2O is not set
> # CONFIG_SCSI_ADVANSYS is not set
> CONFIG_SCSI_MEGARAID=y
> # CONFIG_SCSI_SATA is not set
> # CONFIG_SCSI_BUSLOGIC is not set
> # CONFIG_SCSI_CPQFCTS is not set
> # CONFIG_SCSI_DMX3191D is not set
> # CONFIG_SCSI_EATA is not set
> # CONFIG_SCSI_EATA_PIO is not set
> # CONFIG_SCSI_FUTURE_DOMAIN is not set
> # CONFIG_SCSI_GDTH is not set
> # CONFIG_SCSI_IPS is not set
> # CONFIG_SCSI_INITIO is not set
> # CONFIG_SCSI_INIA100 is not set
> # CONFIG_SCSI_PPA is not set
> # CONFIG_SCSI_IMM is not set
> # CONFIG_SCSI_SYM53C8XX_2 is not set
> # CONFIG_SCSI_IPR is not set
> # CONFIG_SCSI_PCI2000 is not set
> # CONFIG_SCSI_PCI2220I is not set
> # CONFIG_SCSI_QLOGIC_ISP is not set
> # CONFIG_SCSI_QLOGIC_FC is not set
> # CONFIG_SCSI_QLOGIC_1280 is not set
> CONFIG_SCSI_QLA2XXX=y
> # CONFIG_SCSI_QLA21XX is not set
> # CONFIG_SCSI_QLA22XX is not set
> # CONFIG_SCSI_QLA2300 is not set
> # CONFIG_SCSI_QLA2322 is not set
> # CONFIG_SCSI_QLA6312 is not set
> # CONFIG_SCSI_QLA6322 is not set
> # CONFIG_SCSI_DC395x is not set
> # CONFIG_SCSI_DC390T is not set
> # CONFIG_SCSI_NSP32 is not set
> # CONFIG_SCSI_DEBUG is not set
> 
> #
> # Multi-device support (RAID and LVM)
> #
> # CONFIG_MD is not set
> 
> #
> # Fusion MPT device support
> #
> # CONFIG_FUSION is not set
> 
> #
> # IEEE 1394 (FireWire) support
> #
> # CONFIG_IEEE1394 is not set
> 
> #
> # I2O device support
> #
> # CONFIG_I2O is not set
> 
> #
> # Networking support
> #
> CONFIG_NET=y
> 
> #
> # Networking options
> #
> CONFIG_PACKET=y
> CONFIG_PACKET_MMAP=y
> # CONFIG_NETLINK_DEV is not set
> CONFIG_UNIX=y
> # CONFIG_NET_KEY is not set
> CONFIG_INET=y
> # CONFIG_IP_MULTICAST is not set
> # CONFIG_IP_ADVANCED_ROUTER is not set
> # CONFIG_IP_PNP is not set
> # CONFIG_NET_IPIP is not set
> # CONFIG_NET_IPGRE is not set
> # CONFIG_ARPD is not set
> # CONFIG_SYN_COOKIES is not set
> # CONFIG_INET_AH is not set
> # CONFIG_INET_ESP is not set
> # CONFIG_INET_IPCOMP is not set
> # CONFIG_IPV6 is not set
> # CONFIG_NETFILTER is not set
> 
> #
> # SCTP Configuration (EXPERIMENTAL)
> #
> # CONFIG_IP_SCTP is not set
> # CONFIG_ATM is not set
> # CONFIG_BRIDGE is not set
> # CONFIG_VLAN_8021Q is not set
> # CONFIG_DECNET is not set
> # CONFIG_LLC2 is not set
> # CONFIG_IPX is not set
> # CONFIG_ATALK is not set
> # CONFIG_X25 is not set
> # CONFIG_LAPB is not set
> # CONFIG_NET_DIVERT is not set
> # CONFIG_ECONET is not set
> # CONFIG_WAN_ROUTER is not set
> # CONFIG_NET_FASTROUTE is not set
> # CONFIG_NET_HW_FLOWCONTROL is not set
> 
> #
> # QoS and/or fair queueing
> #
> # CONFIG_NET_SCHED is not set
> 
> #
> # Network testing
> #
> # CONFIG_NET_PKTGEN is not set
> # CONFIG_NETPOLL is not set
> # CONFIG_NET_POLL_CONTROLLER is not set
> # CONFIG_HAMRADIO is not set
> # CONFIG_IRDA is not set
> # CONFIG_BT is not set
> CONFIG_NETDEVICES=y
> # CONFIG_DUMMY is not set
> # CONFIG_BONDING is not set
> # CONFIG_EQUALIZER is not set
> # CONFIG_TUN is not set
> 
> #
> # ARCnet devices
> #
> # CONFIG_ARCNET is not set
> 
> #
> # Ethernet (10 or 100Mbit)
> #
> CONFIG_NET_ETHERNET=y
> CONFIG_MII=y
> # CONFIG_HAPPYMEAL is not set
> # CONFIG_SUNGEM is not set
> CONFIG_NET_VENDOR_3COM=y
> CONFIG_VORTEX=y
> # CONFIG_TYPHOON is not set
> 
> #
> # Tulip family network device support
> #
> # CONFIG_NET_TULIP is not set
> # CONFIG_HP100 is not set
> CONFIG_NET_PCI=y
> # CONFIG_PCNET32 is not set
> # CONFIG_AMD8111_ETH is not set
> # CONFIG_ADAPTEC_STARFIRE is not set
> # CONFIG_B44 is not set
> # CONFIG_FORCEDETH is not set
> # CONFIG_DGRS is not set
> CONFIG_EEPRO100=y
> # CONFIG_EEPRO100_PIO is not set
> # CONFIG_E100 is not set
> # CONFIG_FEALNX is not set
> # CONFIG_NATSEMI is not set
> # CONFIG_NE2K_PCI is not set
> # CONFIG_8139CP is not set
> # CONFIG_8139TOO is not set
> # CONFIG_SIS900 is not set
> # CONFIG_EPIC100 is not set
> # CONFIG_SUNDANCE is not set
> # CONFIG_TLAN is not set
> # CONFIG_VIA_RHINE is not set
> 
> #
> # Ethernet (1000 Mbit)
> #
> # CONFIG_ACENIC is not set
> # CONFIG_DL2K is not set
> # CONFIG_E1000 is not set
> # CONFIG_NS83820 is not set
> # CONFIG_HAMACHI is not set
> # CONFIG_YELLOWFIN is not set
> # CONFIG_R8169 is not set
> # CONFIG_SK98LIN is not set
> # CONFIG_TIGON3 is not set
> 
> #
> # Ethernet (10000 Mbit)
> #
> # CONFIG_IXGB is not set
> # CONFIG_S2IO is not set
> 
> #
> # Token Ring devices
> #
> # CONFIG_TR is not set
> 
> #
> # Wireless LAN (non-hamradio)
> #
> # CONFIG_NET_RADIO is not set
> 
> #
> # Wan interfaces
> #
> # CONFIG_WAN is not set
> # CONFIG_FDDI is not set
> # CONFIG_HIPPI is not set
> # CONFIG_PLIP is not set
> # CONFIG_PPP is not set
> # CONFIG_SLIP is not set
> # CONFIG_NET_FC is not set
> # CONFIG_SHAPER is not set
> # CONFIG_NETCONSOLE is not set
> 
> #
> # ISDN subsystem
> #
> # CONFIG_ISDN is not set
> 
> #
> # Telephony Support
> #
> # CONFIG_PHONE is not set
> 
> #
> # Input device support
> #
> CONFIG_INPUT=y
> 
> #
> # Userland interfaces
> #
> CONFIG_INPUT_MOUSEDEV=y
> CONFIG_INPUT_MOUSEDEV_PSAUX=y
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> # CONFIG_INPUT_JOYDEV is not set
> # CONFIG_INPUT_TSDEV is not set
> # CONFIG_INPUT_EVDEV is not set
> # CONFIG_INPUT_EVBUG is not set
> 
> #
> # Input I/O drivers
> #
> # CONFIG_GAMEPORT is not set
> CONFIG_SOUND_GAMEPORT=y
> CONFIG_SERIO=y
> CONFIG_SERIO_I8042=y
> # CONFIG_SERIO_SERPORT is not set
> # CONFIG_SERIO_CT82C710 is not set
> # CONFIG_SERIO_PARKBD is not set
> # CONFIG_SERIO_PCIPS2 is not set
> 
> #
> # Input Device Drivers
> #
> CONFIG_INPUT_KEYBOARD=y
> CONFIG_KEYBOARD_ATKBD=y
> # CONFIG_KEYBOARD_SUNKBD is not set
> # CONFIG_KEYBOARD_LKKBD is not set
> # CONFIG_KEYBOARD_XTKBD is not set
> # CONFIG_KEYBOARD_NEWTON is not set
> CONFIG_INPUT_MOUSE=y
> CONFIG_MOUSE_PS2=y
> # CONFIG_MOUSE_SERIAL is not set
> # CONFIG_MOUSE_VSXXXAA is not set
> # CONFIG_INPUT_JOYSTICK is not set
> # CONFIG_INPUT_TOUCHSCREEN is not set
> CONFIG_INPUT_MISC=y
> CONFIG_INPUT_PCSPKR=y
> # CONFIG_INPUT_UINPUT is not set
> 
> #
> # Character devices
> #
> CONFIG_VT=y
> CONFIG_VT_CONSOLE=y
> CONFIG_HW_CONSOLE=y
> # CONFIG_SERIAL_NONSTANDARD is not set
> 
> #
> # Serial drivers
> #
> CONFIG_SERIAL_8250=y
> # CONFIG_SERIAL_8250_CONSOLE is not set
> CONFIG_SERIAL_8250_NR_UARTS=4
> # CONFIG_SERIAL_8250_EXTENDED is not set
> 
> #
> # Non-8250 serial port support
> #
> CONFIG_SERIAL_CORE=y
> CONFIG_UNIX98_PTYS=y
> # CONFIG_LEGACY_PTYS is not set
> CONFIG_PRINTER=y
> # CONFIG_LP_CONSOLE is not set
> # CONFIG_PPDEV is not set
> # CONFIG_TIPAR is not set
> # CONFIG_QIC02_TAPE is not set
> 
> #
> # IPMI
> #
> # CONFIG_IPMI_HANDLER is not set
> 
> #
> # Watchdog Cards
> #
> # CONFIG_WATCHDOG is not set
> # CONFIG_HW_RANDOM is not set
> # CONFIG_NVRAM is not set
> CONFIG_RTC=y
> # CONFIG_DTLK is not set
> # CONFIG_R3964 is not set
> # CONFIG_APPLICOM is not set
> # CONFIG_SONYPI is not set
> 
> #
> # Ftape, the floppy tape device driver
> #
> # CONFIG_FTAPE is not set
> CONFIG_AGP=y
> # CONFIG_AGP_ALI is not set
> # CONFIG_AGP_ATI is not set
> # CONFIG_AGP_AMD is not set
> # CONFIG_AGP_AMD64 is not set
> CONFIG_AGP_INTEL=y
> # CONFIG_AGP_INTEL_MCH is not set
> # CONFIG_AGP_NVIDIA is not set
> # CONFIG_AGP_SIS is not set
> # CONFIG_AGP_SWORKS is not set
> # CONFIG_AGP_VIA is not set
> # CONFIG_AGP_EFFICEON is not set
> # CONFIG_DRM is not set
> # CONFIG_MWAVE is not set
> # CONFIG_RAW_DRIVER is not set
> # CONFIG_HANGCHECK_TIMER is not set
> 
> #
> # I2C support
> #
> # CONFIG_I2C is not set
> 
> #
> # Misc devices
> #
> # CONFIG_IBM_ASM is not set
> 
> #
> # Multimedia devices
> #
> # CONFIG_VIDEO_DEV is not set
> 
> #
> # Digital Video Broadcasting Devices
> #
> # CONFIG_DVB is not set
> 
> #
> # Graphics support
> #
> # CONFIG_FB is not set
> # CONFIG_VIDEO_SELECT is not set
> 
> #
> # Console display driver support
> #
> CONFIG_VGA_CONSOLE=y
> # CONFIG_MDA_CONSOLE is not set
> CONFIG_DUMMY_CONSOLE=y
> 
> #
> # Sound
> #
> # CONFIG_SOUND is not set
> 
> #
> # USB support
> #
> CONFIG_USB=y
> # CONFIG_USB_DEBUG is not set
> 
> #
> # Miscellaneous USB options
> #
> CONFIG_USB_DEVICEFS=y
> # CONFIG_USB_BANDWIDTH is not set
> # CONFIG_USB_DYNAMIC_MINORS is not set
> 
> #
> # USB Host Controller Drivers
> #
> # CONFIG_USB_EHCI_HCD is not set
> # CONFIG_USB_OHCI_HCD is not set
> CONFIG_USB_UHCI_HCD=y
> 
> #
> # USB Device Class drivers
> #
> # CONFIG_USB_BLUETOOTH_TTY is not set
> # CONFIG_USB_ACM is not set
> CONFIG_USB_PRINTER=y
> # CONFIG_USB_STORAGE is not set
> 
> #
> # USB Human Interface Devices (HID)
> #
> CONFIG_USB_HID=y
> CONFIG_USB_HIDINPUT=y
> # CONFIG_HID_FF is not set
> # CONFIG_USB_HIDDEV is not set
> # CONFIG_USB_AIPTEK is not set
> # CONFIG_USB_WACOM is not set
> # CONFIG_USB_KBTAB is not set
> # CONFIG_USB_POWERMATE is not set
> # CONFIG_USB_MTOUCH is not set
> # CONFIG_USB_EGALAX is not set
> # CONFIG_USB_XPAD is not set
> # CONFIG_USB_ATI_REMOTE is not set
> 
> #
> # USB Imaging devices
> #
> # CONFIG_USB_MDC800 is not set
> # CONFIG_USB_MICROTEK is not set
> # CONFIG_USB_HPUSBSCSI is not set
> 
> #
> # USB Multimedia devices
> #
> # CONFIG_USB_DABUSB is not set
> 
> #
> # Video4Linux support is needed for USB Multimedia device support
> #
> 
> #
> # USB Network adaptors
> #
> # CONFIG_USB_CATC is not set
> # CONFIG_USB_KAWETH is not set
> # CONFIG_USB_PEGASUS is not set
> # CONFIG_USB_RTL8150 is not set
> # CONFIG_USB_USBNET is not set
> 
> #
> # USB port drivers
> #
> # CONFIG_USB_USS720 is not set
> 
> #
> # USB Serial Converter support
> #
> # CONFIG_USB_SERIAL is not set
> 
> #
> # USB Miscellaneous drivers
> #
> # CONFIG_USB_EMI62 is not set
> # CONFIG_USB_EMI26 is not set
> # CONFIG_USB_TIGL is not set
> # CONFIG_USB_AUERSWALD is not set
> # CONFIG_USB_RIO500 is not set
> # CONFIG_USB_LEGOTOWER is not set
> # CONFIG_USB_LCD is not set
> # CONFIG_USB_LED is not set
> # CONFIG_USB_CYTHERM is not set
> # CONFIG_USB_PHIDGETSERVO is not set
> # CONFIG_USB_TEST is not set
> 
> #
> # USB Gadget Support
> #
> # CONFIG_USB_GADGET is not set
> 
> #
> # File systems
> #
> CONFIG_EXT2_FS=y
> # CONFIG_EXT2_FS_XATTR is not set
> # CONFIG_EXT3_FS is not set
> # CONFIG_JBD is not set
> CONFIG_REISERFS_FS=y
> # CONFIG_REISERFS_CHECK is not set
> # CONFIG_REISERFS_PROC_INFO is not set
> # CONFIG_REISERFS_FS_XATTR is not set
> # CONFIG_JFS_FS is not set
> # CONFIG_XFS_FS is not set
> # CONFIG_MINIX_FS is not set
> # CONFIG_ROMFS_FS is not set
> # CONFIG_QUOTA is not set
> # CONFIG_AUTOFS_FS is not set
> # CONFIG_AUTOFS4_FS is not set
> 
> #
> # CD-ROM/DVD Filesystems
> #
> CONFIG_ISO9660_FS=y
> CONFIG_JOLIET=y
> CONFIG_ZISOFS=y
> CONFIG_ZISOFS_FS=y
> CONFIG_UDF_FS=y
> 
> #
> # DOS/FAT/NT Filesystems
> #
> CONFIG_FAT_FS=y
> # CONFIG_MSDOS_FS is not set
> CONFIG_VFAT_FS=y
> # CONFIG_NTFS_FS is not set
> 
> #
> # Pseudo filesystems
> #
> CONFIG_PROC_FS=y
> CONFIG_PROC_KCORE=y
> CONFIG_SYSFS=y
> # CONFIG_DEVFS_FS is not set
> # CONFIG_DEVPTS_FS_XATTR is not set
> # CONFIG_TMPFS is not set
> # CONFIG_HUGETLBFS is not set
> # CONFIG_HUGETLB_PAGE is not set
> CONFIG_RAMFS=y
> 
> #
> # Miscellaneous filesystems
> #
> # CONFIG_ADFS_FS is not set
> # CONFIG_AFFS_FS is not set
> # CONFIG_HFS_FS is not set
> # CONFIG_HFSPLUS_FS is not set
> # CONFIG_BEFS_FS is not set
> # CONFIG_BFS_FS is not set
> # CONFIG_EFS_FS is not set
> # CONFIG_CRAMFS is not set
> # CONFIG_VXFS_FS is not set
> # CONFIG_HPFS_FS is not set
> # CONFIG_QNX4FS_FS is not set
> # CONFIG_SYSV_FS is not set
> # CONFIG_UFS_FS is not set
> 
> #
> # Network File Systems
> #
> CONFIG_NFS_FS=y
> CONFIG_NFS_V3=y
> # CONFIG_NFS_V4 is not set
> # CONFIG_NFS_DIRECTIO is not set
> CONFIG_NFSD=y
> CONFIG_NFSD_V3=y
> # CONFIG_NFSD_V4 is not set
> # CONFIG_NFSD_TCP is not set
> CONFIG_LOCKD=y
> CONFIG_LOCKD_V4=y
> CONFIG_EXPORTFS=y
> CONFIG_SUNRPC=y
> # CONFIG_RPCSEC_GSS_KRB5 is not set
> # CONFIG_SMB_FS is not set
> # CONFIG_CIFS is not set
> # CONFIG_NCP_FS is not set
> # CONFIG_CODA_FS is not set
> # CONFIG_AFS_FS is not set
> 
> #
> # Partition Types
> #
> # CONFIG_PARTITION_ADVANCED is not set
> CONFIG_MSDOS_PARTITION=y
> 
> #
> # Native Language Support
> #
> CONFIG_NLS=y
> CONFIG_NLS_DEFAULT="iso8859-1"
> # CONFIG_NLS_CODEPAGE_437 is not set
> # CONFIG_NLS_CODEPAGE_737 is not set
> # CONFIG_NLS_CODEPAGE_775 is not set
> # CONFIG_NLS_CODEPAGE_850 is not set
> # CONFIG_NLS_CODEPAGE_852 is not set
> # CONFIG_NLS_CODEPAGE_855 is not set
> # CONFIG_NLS_CODEPAGE_857 is not set
> # CONFIG_NLS_CODEPAGE_860 is not set
> # CONFIG_NLS_CODEPAGE_861 is not set
> # CONFIG_NLS_CODEPAGE_862 is not set
> # CONFIG_NLS_CODEPAGE_863 is not set
> # CONFIG_NLS_CODEPAGE_864 is not set
> # CONFIG_NLS_CODEPAGE_865 is not set
> # CONFIG_NLS_CODEPAGE_866 is not set
> # CONFIG_NLS_CODEPAGE_869 is not set
> # CONFIG_NLS_CODEPAGE_936 is not set
> # CONFIG_NLS_CODEPAGE_950 is not set
> # CONFIG_NLS_CODEPAGE_932 is not set
> # CONFIG_NLS_CODEPAGE_949 is not set
> # CONFIG_NLS_CODEPAGE_874 is not set
> # CONFIG_NLS_ISO8859_8 is not set
> # CONFIG_NLS_CODEPAGE_1250 is not set
> # CONFIG_NLS_CODEPAGE_1251 is not set
> # CONFIG_NLS_ISO8859_1 is not set
> # CONFIG_NLS_ISO8859_2 is not set
> # CONFIG_NLS_ISO8859_3 is not set
> # CONFIG_NLS_ISO8859_4 is not set
> # CONFIG_NLS_ISO8859_5 is not set
> # CONFIG_NLS_ISO8859_6 is not set
> # CONFIG_NLS_ISO8859_7 is not set
> # CONFIG_NLS_ISO8859_9 is not set
> # CONFIG_NLS_ISO8859_13 is not set
> # CONFIG_NLS_ISO8859_14 is not set
> # CONFIG_NLS_ISO8859_15 is not set
> # CONFIG_NLS_KOI8_R is not set
> # CONFIG_NLS_KOI8_U is not set
> # CONFIG_NLS_UTF8 is not set
> 
> #
> # Profiling support
> #
> # CONFIG_PROFILING is not set
> 
> #
> # Kernel hacking
> #
> # CONFIG_DEBUG_KERNEL is not set
> # CONFIG_EARLY_PRINTK is not set
> # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
> # CONFIG_FRAME_POINTER is not set
> # CONFIG_4KSTACKS is not set
> 
> #
> # Security options
> #
> # CONFIG_SECURITY is not set
> 
> #
> # Cryptographic options
> #
> # CONFIG_CRYPTO is not set
> 
> #
> # Library routines
> #
> # CONFIG_CRC32 is not set
> # CONFIG_LIBCRC32C is not set
> CONFIG_ZLIB_INFLATE=y
> CONFIG_X86_BIOS_REBOOT=y
> CONFIG_X86_STD_RESOURCES=y
> 
> --
> Byron Stanoszek                         Ph: (330) 644-3059
> Systems Programmer                      Fax: (330) 644-8110
> Commercial Timesharing Inc.             Email: byron@comtime.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-scsi"
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
Mark Haverkamp <markh@osdl.org>

-
To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
