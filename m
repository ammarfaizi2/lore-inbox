Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318247AbSHBFtV>; Fri, 2 Aug 2002 01:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318277AbSHBFtV>; Fri, 2 Aug 2002 01:49:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41999 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318247AbSHBFtU>;
	Fri, 2 Aug 2002 01:49:20 -0400
Message-ID: <3D4A205A.8EBFF53A@zip.com.au>
Date: Thu, 01 Aug 2002 23:02:02 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-ventures.com>,
       Alexander Viro <viro@math.psu.edu>, lkml <linux-kernel@vger.kernel.org>
Subject: IDE hang, partition strangeness
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seems that the partitioning code in 2.5.30 is sending illegal LBAs
to the IDE driver, which responds by hanging the box:

#0  __lock_page (page=0xc1994ff0) at /usr/src/25/include/asm/bitops.h:136
#1  0xc012ca43 in lock_page (page=0xc3ff1960) at filemap.c:692
#2  0xc012dba9 in read_cache_page (mapping=0xc2f6a144, index=20010815, filler=0xc01428c0 <blkdev_readpage>, 
    data=0x0) at filemap.c:1756
#3  0xc0162d16 in read_dev_sector (bdev=0xc2f0ef20, n=160086527, p=0xc3fd7d60) at check.c:539
#4  0xc0166bae in read_lba (bdev=0xc2f0ef20, lba=160086528, buffer=0xc2f6d200 "", count=512) at efi.c:205
#5  0xc0166ccf in alloc_read_gpt_header (bdev=0xc2f0ef20, lba=160086527) at efi.c:277
#6  0xc0166d2b in is_gpt_valid (bdev=0xc2f0ef20, lba=160086527, gpt=0xc3fd7e08, ptes=0xc3fd7e0c) at efi.c:305
#7  0xc0167189 in find_valid_gpt (bdev=0xc2f0ef20, gpt=0xc3fd7e3c, ptes=0xc3fd7e40) at efi.c:500
#8  0xc01673f8 in efi_partition (state=0xc2f0a000, bdev=0xc2f0ef20) at efi.c:606
#9  0xc0162b17 in check_partition (hd=0xc2fb34e0, dev={value = 8448}) at check.c:362
#10 0xc0162ccf in grok_partitions (dev={value = 8448}, size=160086528) at check.c:530
#11 0xc020b974 in ata_revalidate (i_rdev={value = 8448}) at main.c:291
#12 0xc0213aaf in idedisk_attach (drive=0xc0386d1c) at ide-disk.c:1489
#13 0xc020c09f in subdriver_match (channel=0xc0386bf0, ops=0xc0300de0) at main.c:568
#14 0xc020c41a in register_ata_driver (driver=0xc0300de0) at main.c:1135
#15 0xc031d6ed in idedisk_init () at ide-disk.c:1499
#16 0xc031bc24 in ata_module_init () at main.c:1425
#17 0xc031bd37 in init_ata () at main.c:1465
#18 0xc030c879 in do_initcalls () at main.c:483
#19 0xc030c8ba in do_basic_setup () at main.c:534
#20 0xc0105095 in init (unused=0x0) at main.c:561

IO was started against the page but completion was never signalled.

Note the lba of 160086528 and the pagecache index of 20010815.
The kernel reports the disk as having a capacity of 160086528
sectors, so it looks like the EFI partition code is reading a
nonexistent sector, and the IDE driver just silently swallowed the
request.

Possibly, EFI has always done that and simply coped with the IO
error which IDE isn't sending any more.

Patching 2.4.19-rc5 with hpt374 support (why is that still not in
there?) hung the same way, oddly.

Disabling EFI partitioning gets further:

(gdb) bt
#0  __lock_page (page=0xc1994ff0) at /usr/src/25/include/asm/bitops.h:136
#1  0xc012ca43 in lock_page (page=0xc3ff2960) at filemap.c:692
#2  0xc012dba9 in read_cache_page (mapping=0xc2f6b144, index=7, filler=0xc01428c0 <blkdev_readpage>, data=0x0)
    at filemap.c:1756
#3  0xc0162d16 in read_dev_sector (bdev=0xc2f07f20, n=63, p=0xc3fd9e40) at check.c:539
#4  0xc0165dcb in parse_extended (state=0xc2f00000, bdev=0xc2f07f20, first_sector=63, first_size=48243132)
    at msdos.c:106
#5  0xc0166555 in msdos_partition (state=0xc2f00000, bdev=0xc2f07f20) at msdos.c:433
#6  0xc0162b17 in check_partition (hd=0xc2fb54e0, dev={value = 8448}) at check.c:362
#7  0xc0162ccf in grok_partitions (dev={value = 8448}, size=160086528) at check.c:530
#8  0xc020ae14 in ata_revalidate (i_rdev={value = 8448}) at main.c:291
#9  0xc0212f4f in idedisk_attach (drive=0xc0384d1c) at ide-disk.c:1489
#10 0xc020b53f in subdriver_match (channel=0xc0384bf0, ops=0xc02ffce0) at main.c:568
#11 0xc020b8ba in register_ata_driver (driver=0xc02ffce0) at main.c:1135
#12 0xc031b58d in idedisk_init () at ide-disk.c:1499
#13 0xc0319ac4 in ata_module_init () at main.c:1425
#14 0xc0319bd7 in init_ata () at main.c:1465
#15 0xc030a879 in do_initcalls () at main.c:483
#16 0xc030a8ba in do_basic_setup () at main.c:534
#17 0xc0105095 in init (unused=0x0) at main.c:561

Last thing it said was "hde1 <"

Disabling hpt366 support altogether gets the thing to boot.  The IDE
driver seems to cope with the Maxtor 96147H6 on PIIX4 OK.  But not
the HPT374, which is using 48-bit LBA addressing and UDMA5 to drive
the attached Maxtor 4D080K4 disks.
