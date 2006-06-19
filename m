Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932319AbWFSIV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbWFSIV6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 04:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbWFSIV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 04:21:58 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:49083 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S932319AbWFSIV4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 04:21:56 -0400
Date: Mon, 19 Jun 2006 10:21:54 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: linux-kernel@vger.kernel.org
Cc: hal@lists.freedesktop.org, Greg KH <gregkh@suse.de>
Subject: USB/hal: USB open() broken? (USB CD burner underruns, USB HDD hard resets)
Message-ID: <20060619082154.GA17129@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm having severe issues with cdrecord aborting with "buffer underrun"
message, *always*. Problem nailed, see below.

AMD Athlon @1200 512MB
Debian testing
Linux 2.6.17-rc6-mm2 (newest, testing on 2.6.16ish and 2.6.15ish didn't
make a difference)
cdrecord 4:2.01+01a03-3 (newest)
hal 0.5.7-2 (newest)
libhal-storage1 0.5.7-1 (newest)
libhal1 0.5.7-1 (newest)

burner:
  Vendor: HL-DT-ST  Model: DVDRAM GSA-4160B  Rev: A306
  Type:   CD-ROM                             ANSI SCSI revision: 00
via:
Bus 001 Device 005: ID 0402:5621 ALi Corp. USB 2.0 Storage Device
(that's the "HL-DT-ST" external case ID string given above)
on USB 2.0 connector:
0000:00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)

# lsmod (USB-related only)
sd_mod                 18560  2
sg                     31772  0
sr_mod                 16164  0
usb_storage            71880  1
scsi_mod              132876  4 sd_mod,sg,sr_mod,usb_storage
uhci_hcd               23948  0
ehci_hcd               29964  0
usbcore               130844  4 usb_storage,uhci_hcd,ehci_hcd

# cat /proc/interrupts
           CPU0
  0:   14492818   IO-APIC-edge     timer
  1:      14298   IO-APIC-edge     i8042
  6:          3   IO-APIC-edge     floppy
  8:          4   IO-APIC-edge     rtc
  9:          0   IO-APIC-fasteoi  acpi
 12:     247193   IO-APIC-edge     i8042
 14:     172079   IO-APIC-edge     ide0
 16:     741075   IO-APIC-fasteoi  radeon@pci:0000:01:00.0
 19:     128123   IO-APIC-fasteoi  ehci_hcd:usb1, uhci_hcd:usb2, uhci_hcd:usb3,
uhci_hcd:usb4
 20:       7235   IO-APIC-fasteoi  au8830, eth1
 21:          2   IO-APIC-fasteoi  ohci1394
 22:      13029   IO-APIC-fasteoi  Aztech AZF3328 (PCI168), au8820
 23:          0   IO-APIC-fasteoi  VIA8233
NMI:          0
LOC:   14494370
ERR:          0
MIS:          0



There's a /usr/lib/hal/hald-addon-storage running for this CD device:

nanosleep({2, 0}, {2, 0})               = 0 <2.000965>
open("/dev/scsi/host2/bus0/target0/lun0/cd", O_RDONLY|O_NONBLOCK|O_EXCL|O_LARGEFILE) = 4 <0.002021>
ioctl(4, CDROM_DRIVE_STATUS, 0x7fffffff) = 4 <0.001811>
ioctl(4, CDROM_MEDIA_CHANGED, 0x7fffffff) = 0 <0.006341>
ioctl(4, SG_IO, 0xbfdbc0c8)             = 0 <0.002186>
close(4)                                = 0 <0.001087>
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0 <0.000016>
rt_sigaction(SIGCHLD, NULL, {SIG_DFL}, 8) = 0 <0.000015>
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0 <0.000015>
nanosleep({2, 0},  <unfinished ...>




It has a 2 second polling loop, and this is *exactly* the delay until
cdrecord bombs with an "underrun" message:



Script started on Mo 26 Jun 2006 13:10:04 CEST
# cdrecord -speed=4 -dummy dev=2,0,0 -eject - v ubuntu-6.06-desktop-i386.iso
cdrecord: No write mode specified.
cdrecord: Asuming -tao mode.
cdrecord: Future versions of cdrecord may have different drive dependent defaults.
cdrecord: Continuing in 5 seconds...
Cdrecord-Clone 2.01.01a03 (i686-pc-linux-gnu) Copyright (C) 1995-2005 Joerg Schilling
NOTE: this version of cdrecord is an inofficial (modified) release of cdrecord
      and thus may have bugs that are not present in the original version.
      Please send bug reports and support requests to <cdrtools@packages.debian.org>.
      The original author should not be bothered with problems of this version.

cdrecord: Warning: Running on Linux-2.6.17-rc6-mm2
cdrecord: There are unsettled issues with Linux-2.5 and newer.
cdrecord: If you have unexpected problems, please try Linux-2.4 or Solaris.
TOC Type: 1 = CD-ROM
scsidev: '2,0,0'
scsibus: 2 target: 0 lun: 0
Linux sg driver version: 3.5.33
Using libscg version 'ubuntu-0.8ubuntu1'.
cdrecord: Warning: using inofficial version of libscg (ubuntu-0.8ubuntu1 '@(#)scsitransp.c	1.91 04/06/17 Copyright 1988,1995,2000-2004 J. Schilling').
SCSI buffer size: 64512
atapi: 1
Device type    : Removable CD-ROM
Version        : 0
Response Format: 2
Capabilities   : 
Vendor_info    : 'HL-DT-ST'
Identifikation : 'DVDRAM GSA-4160B'
Revision       : 'A306'
Device seems to be: Generic mmc2 DVD-R/DVD-RW.
Current: 0x000A
Profile: 0x0012 
Profile: 0x0011 
Profile: 0x0014 
Profile: 0x0013 
Profile: 0x001A 
Profile: 0x001B 
Profile: 0x002B 
Profile: 0x0010 
Profile: 0x0009 
Profile: 0x000A (current)
Profile: 0x0008 
Profile: 0x0002 
cdrecord: This version of cdrecord does not include DVD-R/DVD-RW support code.
cdrecord: See /usr/share/doc/cdrecord/README.DVD.Debian for details on DVD support.
Using generic SCSI-3/mmc   CD-R/CD-RW driver (mmc_cdr).
Driver flags   : MMC-3 SWABAUDIO BURNFREE 
Supported modes: TAO PACKET SAO SAO/R96P SAO/R96R RAW/R16 RAW/R96P RAW/R96R
Drive buf size : 1053696 = 1029 KB
Drive DMA Speed: 11837 kB/s 67x CD 8x DVD
FIFO size      : 4194304 = 4096 KB
Track 01: data   697 MB        
Total size:      801 MB (79:23.98) = 357299 sectors
Lout start:      801 MB (79:25/74) = 357299 sectors
Current Secsize: 2048
ATIP info from disk:
  Indicated writing power: 3
  Reference speed: 6
  Is not unrestricted
  Is erasable
  Disk sub type: High speed Rewritable (CAV) media (1)
  ATIP start of lead in:  -11700 (97:26/00)
  ATIP start of lead out: 359849 (79:59/74)
  1T speed low:  4 1T speed high: 10
  2T speed low:  4 2T speed high:  0 (reserved val  6)
  power mult factor: 1 5
  recommended erase/write power: 5
  A1 values: 24 1A D8
  A2 values: 26 B2 4A
Disk type:    Phase change
Manuf. index: 5
Manufacturer: FORNET INTERNATIONAL PTE LTD.
Blocks total: 359849 Blocks current: 359849 Blocks remaining: 2550
Starting to write CD/DVD at speed 8 in dummy TAO mode for single session.
Last chance to quit, starting dummy write in 9 seconds.   8 seconds.   7 seconds.   6 seconds.   5 seconds.   4 seconds.   3 seconds.   2 seconds.   1 seconds.   0 seconds. Operation starts.
Waiting for reader process to fill input buffer ... input buffer ready.
BURN-Free is OFF.
Starting new track at sector: 0
Track 01:    0 of  697 MB written.Track 01:    1 of  697 MB written (fifo 100%) [buf  98%]   2.5x.cdrecord: Input/output error. write_g1: scsi sendcmd: no error
CDB:  2A 00 00 00 02 2E 00 00 1F 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: 70 00 05 00 00 00 00 10 2A 30 06 90 21 02 00 00
Sense Key: 0x5 Illegal Request, Segment 0
Sense Code: 0x21 Qual 0x02 (invalid address for write) Fru 0x0
Sense flags: Blk 0 (not valid) 
resid: 63488
cmd finished after 0.004s timeout 40s

write track data: error after 1142784 bytes
cdrecord: The current problem looks like a buffer underrun.
cdrecord: Try to use 'driveropts=burnfree'.
cdrecord: Make sure that you are root, enable DMA and check your HW/OS set up.
Writing  time:   10.479s
Average write speed 457.0x.
Min drive buffer fill was 98%
Fixating...
WARNING: Some drives don't like fixation in dummy mode.
Fixating time:   33.828s
cdrecord: fifo had 82 puts and 19 gets.
cdrecord: fifo was 0 times empty and 7 times full, min fill was 90%.
# 
Script done on Mo 26 Jun 2006 13:11:17 CEST


Killing the SCSI /usr/lib/hal/hald-addon-storage (after killing its hald-runner
supervisor parent) lets (non-simulation) burning of a whole CD proceed
properly...


However running a simple test program as a different non-root user:

#define __USE_LARGEFILE64

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>

/* argh, still not defined... manually! */
# define O_LARGEFILE    0100000


int main () {
        int fd;

        fd = open("/dev/scsi/host2/bus0/target0/lun0/cd", O_RDONLY|O_NONBLOCK|O_EXCL|O_LARGEFILE);
        printf("fd is %d\n", fd);
        close(fd);
        return 0;
}

kills concurrent cdrecord burning (by root) on the spot.

Note that this still happens if I omit O_NONBLOCK, even though this yields
me an invalid fd (-1)!.
Any other flag combination (even 0) does the same.
Thus it's clearly caused by open() handling itself.


Perfect DoS, if you ask me (but OTOH on many distro setups there probably
won't be user access permissions for this device by default).

This might still be on the borders of tolerable under normal working
conditions, but the fact that hald does an open() polling loop on it
renders it catastrophic.


Note that I also had severe issues with a chinese "Cenda 201" USB OTG 40GB HDD
device, I got USB bus reset every couple seconds, resulting in an audible
drive head-park reset each time:

May 29 02:05:23 andi kernel: ehci_hcd 0000:00:10.3: qh deb16080 (#00) state 4
May 29 02:05:24 andi kernel: usb 4-2: reset high speed USB device using ehci_hcd and address 2
May 29 02:05:56 andi last message repeated 17 times
May 29 02:06:57 andi last message repeated 32 times
May 29 02:07:35 andi last message repeated 20 times
May 29 02:07:37 andi kernel: ehci_hcd 0000:00:10.3: qh deb16200 (#00) state 4
May 29 02:07:37 andi kernel: usb 4-2: reset high speed USB device using ehci_hcd and address 2
May 29 02:07:43 andi last message repeated 3 times


Now that I found this I'd *bet* that this was exactly the same
problem there (caused by HAL polling the device file).


I cannot quite believe that such a severe issue hasn't been noticed
and fixed immediately by whichever person out there.
Possibly this is a VIA-only (oh no, not again... ;) problem?
(either USB controller chip or southbridge or so).

0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333 AGP]
0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80)
0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80)
0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80)
0000:00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
0000:00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 50)


I don't think hal can do much about hald-addon-storage to prevent a simple
open() from distorting a running device operation, so I'd tend to think
that this is a kernel issue (perhaps in the USB host controller drivers).


Thanks,

Andreas Mohr
