Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbTIBVVH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 17:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbTIBVVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 17:21:07 -0400
Received: from mail.dubki.ru ([80.240.116.2]:27917 "EHLO mail.dubki.ru")
	by vger.kernel.org with ESMTP id S261230AbTIBVU5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 17:20:57 -0400
From: "Nikita V. Youshchenko" <yoush@cs.msu.su>
To: linux-kernel@vger.kernel.org
Subject: Strange situation while writing CDR from iso file on tmpfs
Date: Wed, 3 Sep 2003 01:20:54 +0400
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200309030120.54112@sercond.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Today I faced an interesting situation while trying to copy iso image from 
one CDR to another. This may be a bug in the kernel.

First I grabbed the iso image to a file in /tmp, which is tmpfs on my 
system.
Then I tried to write it using cdrecord at speed 24, and got an i/o error 
that looked like buffer underrun.
I insered another disk and repeated write attempt. And got i/o error again 
almost at the same byte offset (459716608 first time, 459399168 second 
time).
Then I turned off DMA for CD recorder (hdparm -d0 /dev/hdc) and tried 
again. DMA really was turned off, because CPU load meter on my desktop 
started to show high CPU usage in system mode. But again, I got i/o error 
almost at that offset.

I was able to write the image only after I copied it from tmpfs to my home 
directory on reiserfs (file was copied without any errors).

No other activity was performed on the computer at the same time. Just KDE 
desktop was running.

Computer on which it happened has only 256M of RAM, and iso file size was 
about 700M. So large parts of the file in tmpfs actually resided in swap.
It seems that several times it took tmpfs unacceptably long to deliver 
same part of the file to the reading process. Since it was the same part 
of the file, I thought that these particular blocks (located on 
particular blocks of the swap partition) could trigger some situation 
when tmpfs misbehaves.

In past I also had some i/o errors when writing CDRs from tmpfs at high 
speed, but those were much less deterministic.

I realize that the above information is poor to locate a bug (if there is 
one). So it will be OK if this mail will be just ignored. But if I can 
help, I will provide any needed technical information or run tests (I 
can't break dozens of CDRs, but a few is ok).
Please CC: to my e-mail since I am not on the list.

nikita@bliss:~> uname -a
Linux bliss 2.4.21-rc2 #1 óÂÔ íÁÊ 17 11:34:01 MSD 2003 i686 GNU/Linux

<it is a laptop; kernel has ACPI, cpufreq and cd-packet-writing patches 
applied>

nikita@bliss:~> cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 1
model name      : Intel(R) Celeron(R) CPU 1.70GHz
stepping        : 3
cpu MHz         : 1561.922
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 3119.51

nikita@bliss:~> dmesg | grep hd
Kernel command line: auto BOOT_IMAGE=Linux-2.4.21rc2 ro root=302 
hdc=ide-scsi
ide_setup: hdc=ide-scsi
    ide0: BM-DMA at 0xbc90-0xbc97, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xbc98-0xbc9f, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N040ATCS04-0, ATA DISK drive
hdc: SONY CD-RW/DVD-ROM CRX820E, ATAPI CD/DVD-ROM drive
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 78140160 sectors (40008 MB) w/1768KiB Cache, CHS=4864/255/63, 
UDMA(100)
hdc: attached ide-scsi driver.

Cdrecord 2.01a16 (i686-pc-linux-gnu) Copyright (C) 1995-2003 Jörg 
Schilling

cdrecord command line was:
cdrecord dev=0,0,0 -v driveropts=burnfree speed=24 x.iso

cdrecord error was:
cdrecord: Input/output error. write_g1: scsi sendcmd: no error
CDB:  2A 00 00 03 6C D7 00 00 1F 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: F1 00 03 00 03 5C B7 12 00 00 00 00 0C 00 00 00
Sense Key: 0x3 Medium Error, deferred error, Segment 0
Sense Code: 0x0C Qual 0x00 (write error) Fru 0x0
Sense flags: Blk 220343 (valid)
cmd finished after 8.998s timeout 40s

write track data: error after 459716608 bytes

