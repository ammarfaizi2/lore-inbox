Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750869AbWBJSi6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbWBJSi6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 13:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750864AbWBJSi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 13:38:58 -0500
Received: from mail.astral.ro ([193.230.240.11]:15515 "EHLO mail.astral.ro")
	by vger.kernel.org with ESMTP id S1750863AbWBJSi5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 13:38:57 -0500
Message-ID: <43ECDDC7.50200@astral.ro>
Date: Fri, 10 Feb 2006 20:39:03 +0200
From: Imre Gergely <imre.gergely@astral.ro>
Organization: Astral Telecom SA
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Erik Mouw <erik@harddisk-recovery.com>, linux-kernel@vger.kernel.org
Subject: Re: disabling libata
References: <43EC97C6.10607@astral.ro>	 <20060210141130.GE28676@harddisk-recovery.com> <43ECA035.5040302@astral.ro>	 <20060210142224.GF28676@harddisk-recovery.com> <43ECB91E.6060109@astral.ro> <1139592347.12521.18.camel@localhost.localdomain>
In-Reply-To: <1139592347.12521.18.camel@localhost.localdomain>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan Cox wrote:
> On Gwe, 2006-02-10 at 18:02 +0200, Imre Gergely wrote:
>> maybe it's just me... but it looks like if as SCSI device the whole thing is
>> slower than with IDE. i haven't tested it yet, but as sda the system load is
>> very high, i did some tests with dd, and the CPU usage is always at 98-100%.
> 
> 
> Not expected behaviour. Can you provide hardware info and boot up
> messages please.
> 
> 

AMD Sempron 2600+, 512MB

00:09.0 IDE interface: nVidia Corporation MCP2A IDE (rev a3)
00:0b.0 IDE interface: nVidia Corporation nForce2 Serial ATA Controller (rev a3)

...
ata1: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xC800 irq 11
ata2: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xC808 irq 11
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3468 86:3c01 87:4003 88:407f
ata1: dev 0 ATA, max UDMA/133, 312579695 sectors: lba48
nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device removed
ata1: dev 0 configured for UDMA/133
scsi0 : sata_nv
ata2: no device found (phy stat 00000000)
scsi1 : sata_nv
  Vendor: ATA       Model: ST3160023AS       Rev: 3.01
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 312579695 512-byte hdwr sectors (160041 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 312579695 512-byte hdwr sectors (160041 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
kjournald starting.  Commit interval 5 seconds
...

[root@imi ~]# hdparm -tT /dev/sda

/dev/sda:
 Timing cached reads:   1652 MB in  2.00 seconds = 825.95 MB/sec
HDIO_DRIVE_CMD(null) (wait for flush complete) failed: Inappropriate ioctl for
device
 Timing buffered disk reads:  146 MB in  3.00 seconds =  48.60 MB/sec
HDIO_DRIVE_CMD(null) (wait for flush complete) failed: Inappropriate ioctl for
device

[root@imi stuff]# hdparm /dev/sda

/dev/sda:
 IO_support   =  0 (default 16-bit)
 readonly     =  0 (off)
 readahead    = 256 (on)
 geometry     = 19457/255/63, sectors = 160040803840, start = 0

[root@imi stuff]# cat /sys/block/sda/queue/scheduler
noop anticipatory deadline [cfq]

(but i tried all schedulers, didn't see any big improvements)

i tried to create an 1gb file like this:

[root@imi stuff]# time dd if=/dev/zero of=./1gbfile bs=512k count=2048
2048+0 records in
2048+0 records out

real    1m6.086s
user    0m0.012s
sys     0m5.920s

vmstat output lookes like this:


[root@imi ~]# vmstat 1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0    112  94208   1416  96616    0    0   762   427  933  3359 15  4 69 12
 2  3    112   5076    808 180052    0    0    28 71260  768  3001  3 55 42  0
 0  3    112   7060    820 178608    0    0     8 20500  632  2596  1  5  0 94
 4  3    112   9292    820 178612    0    0     4     0  606  2695  1  1  0 98
 0  2    112   6340    876 181740    0    0    16 22440  608  2689  1 49  0 50
 0  2    112   5964    888 179848    0    0    20 54188  589  2761  5 25  0 70
 0  2    112   7580    904 179900    0    0    40     0  583  2603  1  1  0 98
 1  3    112   4956    932 182972    0    0    40 27404  622  2635  3 16  0 81
 0  6    112   4952    952 182772    0    0    28  4000  664  2775  1 26  0 73

i read somewhere about some tests, SATA vs IDE, and they were talking about a
constant 10-13% CPU usage, nothing more.


