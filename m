Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318642AbSHBGn2>; Fri, 2 Aug 2002 02:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318704AbSHBGn2>; Fri, 2 Aug 2002 02:43:28 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36625 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318642AbSHBGn1>;
	Fri, 2 Aug 2002 02:43:27 -0400
Message-ID: <3D4A2D0A.8FEF9C2A@zip.com.au>
Date: Thu, 01 Aug 2002 23:56:10 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-ventures.com>,
       Alexander Viro <viro@math.psu.edu>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: IDE hang, partition strangeness
References: <3D4A205A.8EBFF53A@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> Seems that the partitioning code in 2.5.30 is sending illegal LBAs
> to the IDE driver, which responds by hanging the box:

I misread this backtrace:

> #0  __lock_page (page=0xc1994ff0) at /usr/src/25/include/asm/bitops.h:136
> #1  0xc012ca43 in lock_page (page=0xc3ff1960) at filemap.c:692
> #2  0xc012dba9 in read_cache_page (mapping=0xc2f6a144, index=20010815, filler=0xc01428c0 <blkdev_readpage>,
>     data=0x0) at filemap.c:1756
> #3  0xc0162d16 in read_dev_sector (bdev=0xc2f0ef20, n=160086527, p=0xc3fd7d60) at check.c:539
> #4  0xc0166bae in read_lba (bdev=0xc2f0ef20, lba=160086528, buffer=0xc2f6d200 "", count=512) at efi.c:205
> #5  0xc0166ccf in alloc_read_gpt_header (bdev=0xc2f0ef20, lba=160086527) at efi.c:277

_this_ is the lba. 160086527.  It is the very last sector on the disk.

block_read_full_page() has issued a read request for the 4k block
at index 20010815, which is LBA 160086520.  So the device driver
is being asked to read exactly the final eight blocks on the device.

The partitioning code seems to be OK.  There seems to be a problem
reading end-of-disk.
