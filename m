Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751460AbWHaBOe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbWHaBOe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 21:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbWHaBOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 21:14:34 -0400
Received: from sccrmhc15.comcast.net ([204.127.200.85]:47251 "EHLO
	sccrmhc15.comcast.net") by vger.kernel.org with ESMTP
	id S1751460AbWHaBOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 21:14:33 -0400
Date: Wed, 30 Aug 2006 18:14:30 -0700
From: Chris Spiegel <linuxml@happyjack.org>
To: linux-kernel@vger.kernel.org
Subject: SCSI CDROM issue in kernels >= 2.6.14-rc3
Message-ID: <20060831011430.GA2934@midgard.spiegels>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(please CC replies)

A while back I started noticing problems with KDE's CD handling.
Accompanying the problems (interminable waiting while it reads the CD
being the main one) were kernel messages as follows:

(scsi1:A:5:0): No or incomplete CDB sent to device.
scsi1: Issued Channel A Bus Reset. 1 SCBs aborted
sr 1:0:5:0: SCSI error: return code = 0x70000

This happens on kernels 2.6.14-rc3 and above, but not -rc1.  I'm not
sure about -rc2 because of compile errors.

After digging through KDE's source, I've condensed the offending code to
a program that exhibits the behavior:

#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <linux/cdrom.h>

static int wm_scsi(int fd, unsigned char *cdb, int cdblen,
                   void *retbuf, int retbuflen, int getreply)
{
  struct cdrom_generic_command cdc = { 0 };
  struct request_sense sense = { 0 };
  int capability;

  capability = ioctl(fd, CDROM_GET_CAPABILITY);

  if(!(capability & CDC_GENERIC_PACKET)) exit(1);

  memcpy(cdc.cmd, cdb, cdblen);

  cdc.buffer = retbuf;
  cdc.buflen = retbuflen;
  cdc.stat = 0;
  cdc.sense = &sense;
  cdc.data_direction = getreply ? CGC_DATA_READ : CGC_DATA_WRITE;

  return ioctl(fd, CDROM_SEND_PACKET, &cdc);
}

static int sendscsi(int fd, void *buf,
                    unsigned int len, int dir,
                    unsigned char a0, unsigned char a1,
                    unsigned char a2, unsigned char a3,
                    unsigned char a4, unsigned char a5,
                    unsigned char a6, unsigned char a7,
                    unsigned char a8, unsigned char a9,
                    unsigned char a10, unsigned char a11)

{
  int cdblen = 0;
  unsigned char cdb[12] = { 0 };

  cdb[0] = a0;
  cdb[1] = a1;
  cdb[2] = a2;
  cdb[3] = a3;
  cdb[4] = a4;
  cdb[5] = a5;

  switch((a0 >> 5) & 7)
  {
    case 0:
      cdblen = 6;
      break;
    case 5:
      cdb[10] = a10;
      cdb[11] = a11;
      cdblen = 12;
    case 1: case 2: case 6:
      cdb[6] = a6;
      cdb[7] = a7;
      cdb[8] = a8;
      cdb[9] = a9;
      if(cdblen == 0) cdblen = 10;
      break;
    default:
      exit(2);
  }

  return wm_scsi(fd, cdb, cdblen, buf, len, dir);
}

int main(void)
{
  int fd;
  char buf[36] = { 0 };

  fd = open("/dev/sr0", O_RDONLY | O_NONBLOCK);
  if(fd == -1) exit(3);

  sendscsi(fd, buf, sizeof buf, 1, GPCMD_INQUIRY,
      0, 0, 0, 36, 0, 0, 0, 0, 0, 0, 0);

  return 0;
}

Now, the error message about an incomplete CDB does seem to indicate a
program error, not a kernel error.  However, this same program works
fine on 2.6.13 so I would like to verify where, exactly, the problem
lies.

This might be related to the issue mentioned in
http://www.ussg.iu.edu/hypermail/linux/kernel/0510.3/1001.html

My SCSI controller is an Adaptec AIC-7902 U320 (onboard) and my DVD
DRIVE is Pioneer DVD-305S.  Here's my dmesg output for completeness:

Linux version 2.6.14-rc3 (root@(none)) (gcc version 3.4.6) #7 SMP PREEMPT Wed Aug 30 12:38:27 PDT 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009b400 (usable)
 BIOS-e820: 000000000009b400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d2000 - 00000000000d4000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff70000 (usable)
 BIOS-e820: 000000001ff70000 - 000000001ff78000 (ACPI data)
 BIOS-e820: 000000001ff78000 - 000000001ff80000 (ACPI NVS)
 BIOS-e820: 000000001ff80000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000f64d0
On node 0 totalpages: 130928
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126832 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
DMI present.
ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f6460
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x1ff73ff2
ACPI: FADT (v001 INTEL  PLACER   0x06040000 PTL  0x00000008) @ 0x1ff77e78
ACPI: MADT (v001 PTLTD  	 APIC   0x06040000  LTP 0x00000000) @ 0x1ff77eec
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x1ff77f88
ACPI: SPCR (v001 PTLTD  $UCRTBL$ 0x06040000 PTL  0x00000001) @ 0x1ff77fb0
ACPI: DSDT (v001  INTEL   PLACER 0x06040000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x06] enabled)
Processor #6 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x07] enabled)
Processor #7 15:2 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x03] address[0xfec80000] gsi_base[24])
IOAPIC[1]: apic_id 3, version 32, address 0xfec80000, GSI 24-47
ACPI: IOAPIC (id[0x04] address[0xfec80100] gsi_base[48])
IOAPIC[2]: apic_id 4, version 32, address 0xfec80100, GSI 48-71
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 3 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 30000000 (gap: 20000000:dec00000)
Built 1 zonelists
Kernel command line: init=/bin/sh vga=0x030c
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
mapped IOAPIC to ffffb000 (fec80000)
mapped IOAPIC to ffffa000 (fec80100)
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 2399.748 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 132x60
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 513836k/523712k available (2964k kernel code, 9316k reserved, 848k data, 240k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 4801.97 BogoMIPS (lpj=2400986)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
mtrr: v2.0 (20020519)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Xeon(TM) CPU 2.40GHz stepping 07
Booting processor 1/1 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 4798.00 BogoMIPS (lpj=2399000)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Xeon(TM) CPU 2.40GHz stepping 07
Booting processor 2/6 eip 2000
Initializing CPU#2
Calibrating delay using timer specific routine.. 4798.12 BogoMIPS (lpj=2399064)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 3
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#2.
CPU2: Intel P4/Xeon Extended MCE MSRs (12) available
CPU2: Thermal monitoring enabled
CPU2: Intel(R) Xeon(TM) CPU 2.40GHz stepping 07
Booting processor 3/7 eip 2000
Initializing CPU#3
Calibrating delay using timer specific routine.. 4798.05 BogoMIPS (lpj=2399028)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 3
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#3.
CPU3: Intel P4/Xeon Extended MCE MSRs (12) available
CPU3: Thermal monitoring enabled
CPU3: Intel(R) Xeon(TM) CPU 2.40GHz stepping 07
Total of 4 processors activated (19196.15 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
checking TSC synchronization across 4 CPUs: passed.
softlockup thread 0 started up.
softlockup thread 1 started up.
softlockup thread 2 started up.
Brought up 4 CPUs
softlockup thread 3 started up.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd8f5, last bus=5
PCI: Using configuration type 1
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:05:02.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 10 11 14 15) *5
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 10 *11 14 15)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.ICH4._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HLB_.P64A._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HLB_.P64B._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:02:1d.0
  IO window: 3000-3fff
  MEM window: f0200000-f02fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:02:1f.0
  IO window: 4000-5fff
  MEM window: f0300000-f03fffff
  PREFETCH window: 30000000-301fffff
PCI: Bridge: 0000:00:02.0
  IO window: 3000-5fff
  MEM window: f0100000-f03fffff
  PREFETCH window: 30000000-301fffff
PCI: Bridge: 0000:00:1e.0
  IO window: 6000-6fff
  MEM window: f0400000-f0ffffff
  PREFETCH window: f2000000-f2ffffff
PCI: Setting latency timer of device 0000:00:1e.0 to 64
Simple Boot Flag at 0x36 set to 0x1
Machine check exception polling timer started.
SGI XFS with ACLs, no debug enabled
Initializing Cryptographic API
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: CPU0 (power states: C1[C1])
ACPI: CPU2 (power states: C1[C1])
ACPI: CPU1 (power states: C1[C1])
ACPI: CPU3 (power states: C1[C1])
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
hw_random hardware driver 1.0.0 loaded
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP(,...)]
parport0: irq 7 detected
lp0: using parport0 (polling).
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 16
ICH4: chipset revision 2
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x24a0-0x24a7, BIOS settings: hda:pio, hdb:DMA
    ide1: BM-DMA at 0x24a8-0x24af, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hdb: IC35L180AVV207-1, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: IC35L180AVV207-1, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
hdb: max request size: 1024KiB
hdb: 361882080 sectors (185283 MB) w/7965KiB Cache, CHS=22526/255/63, UDMA(100)
hdb: cache flushes supported
 hdb: hdb1
hdc: max request size: 1024KiB
hdc: 361882080 sectors (185283 MB) w/7965KiB Cache, CHS=22526/255/63, UDMA(100)
hdc: cache flushes supported
 hdc: hdc1
ACPI: PCI Interrupt 0000:04:03.0[A] -> GSI 32 (level, low) -> IRQ 17
scsi0 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 1.3.11
        <Adaptec AIC7902 Ultra320 SCSI adapter>
        aic7902: Ultra320 Wide Channel A, SCSI Id=7, PCI 33 or 66Mhz, 512 SCBs

 target0:0:0: asynchronous.
  Vendor: IBM       Model: DRVS09V           Rev: 0370
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
 target0:0:0: Beginning Domain Validation
 target0:0:0: wide asynchronous.
 target0:0:0: Domain Validation skipping write tests
 target0:0:0: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 15)
 target0:0:0: Ending Domain Validation
 target0:0:6: asynchronous.
  Vendor: IBMAS400  Model: DFHSS1W           Rev: 4I4I
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi0:A:6:0: Tagged Queuing enabled.  Depth 32
 target0:0:6: Beginning Domain Validation
 target0:0:6: wide asynchronous.
 target0:0:6: Domain Validation skipping write tests
 target0:0:6: FAST-10 WIDE SCSI 20.0 MB/s ST (100 ns, offset 15)
 target0:0:6: Ending Domain Validation
ACPI: PCI Interrupt 0000:04:03.1[B] -> GSI 33 (level, low) -> IRQ 18
scsi1 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 1.3.11
        <Adaptec AIC7902 Ultra320 SCSI adapter>
        aic7902: Ultra320 Wide Channel B, SCSI Id=7, PCI 33 or 66Mhz, 512 SCBs

  Vendor: PIONEER   Model: DVD-ROM DVD-305   Rev: 1.03
  Type:   CD-ROM                             ANSI SCSI revision: 02
 target1:0:5: asynchronous.
 target1:0:5: Beginning Domain Validation
 target1:0:5: Domain Validation skipping write tests
 target1:0:5: FAST-20 SCSI 20.0 MB/s ST (50 ns, offset 16)
 target1:0:5: Ending Domain Validation
SCSI device sda: 17928698 512-byte hdwr sectors (9179 MB)
SCSI device sda: drive cache: write through
SCSI device sda: 17928698 512-byte hdwr sectors (9179 MB)
SCSI device sda: drive cache: write through
 sda: sda1 sda2 sda3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 2199878 512-byte hdwr sectors (1126 MB)
SCSI device sdb: drive cache: write through
SCSI device sdb: 2199878 512-byte hdwr sectors (1126 MB)
SCSI device sdb: drive cache: write through
 sdb: sdb1 sdb2 sdb3
Attached scsi disk sdb at scsi0, channel 0, id 6, lun 0
sr0: scsi3-mmc drive: 16x/40x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
Attached scsi CD-ROM sr0 at scsi1, channel 0, id 5, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi0, channel 0, id 6, lun 0,  type 0
Attached scsi generic sg2 at scsi1, channel 0, id 5, lun 0,  type 5
mice: PS/2 mouse device common for all mice
input: PC Speaker
i2c /dev entries driver
md: raid1 personality registered as nr 3
md: md driver 0.90.2 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 3.39
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
Advanced Linux Sound Architecture Driver Version 1.0.10rc1 (Mon Sep 12 08:13:09 2005 UTC).
ACPI: PCI Interrupt 0000:05:01.0[A] -> GSI 16 (level, low) -> IRQ 19
ALSA device list:
  #0: SBLive! Value [CT4670] (rev.5, serial:0x201102) at 0x6000, irq 19
NET: Registered protocol family 2
IP route cache hash table entries: 8192 (order: 3, 32768 bytes)
TCP established hash table entries: 32768 (order: 7, 524288 bytes)
TCP bind hash table entries: 32768 (order: 6, 393216 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
TCP reno registered
ip_conntrack version 2.3 (4091 buckets, 32728 max) - 220 bytes per conntrack
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
p4-clockmod: P4/Xeon(TM) CPU On-Demand Clock Modulation available
Starting balanced_irq
Using IPI Shortcut mode
md: Autodetecting RAID arrays.
input: AT Translated Set 2 keyboard on isa0060/serio0
md: autorun ...
md: considering hdc1 ...
md:  adding hdc1 ...
md:  adding hdb1 ...
md: created md0
md: bind<hdb1>
md: bind<hdc1>
md: running: <hdc1><hdb1>
raid1: raid set md0 active with 2 out of 2 mirrors
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 240k freed
EXT3 FS on sda3, internal journal
(scsi1:A:5:0): No or incomplete CDB sent to device.
scsi1: Issued Channel A Bus Reset. 1 SCBs aborted
(scsi1:A:5:0): No or incomplete CDB sent to device.
scsi1: Issued Channel A Bus Reset. 1 SCBs aborted
(scsi1:A:5:0): No or incomplete CDB sent to device.
scsi1: Issued Channel A Bus Reset. 1 SCBs aborted
sr 1:0:5:0: SCSI error: return code = 0x70000
