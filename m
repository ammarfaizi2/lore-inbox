Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282127AbRKWMfh>; Fri, 23 Nov 2001 07:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282128AbRKWMfS>; Fri, 23 Nov 2001 07:35:18 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:15688 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S282127AbRKWMfK>; Fri, 23 Nov 2001 07:35:10 -0500
Date: Fri, 23 Nov 2001 14:35:02 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: linux-kernel@vger.kernel.org
Cc: thockin@sun.com, jfr@viasys.com, andre@linux-ide.org
Subject: HPT370 on 2.2.20+ide-patch
Message-ID: <20011123143502.D4809@niksula.cs.hut.fi>
In-Reply-To: <2173081930.1006455144@[195.224.237.69]> <20011122210503.B4809@niksula.cs.hut.fi> <20011122215424.C4809@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011122215424.C4809@niksula.cs.hut.fi>; from vherva@niksula.hut.fi on Thu, Nov 22, 2001 at 09:54:24PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2001 at 09:54:24PM +0200, you [Ville Herva] claimed:
> 
> Ummh. I'm doing successive runs for /dev/md0 GB at a time, and it seems to
> get corrupted in the middle:
> 
> #!/usr/bin/perl
> for ($i = 0; $i < 75; $i++)
> {
>    $block = 1024**2;
>    $count = 1024;
>    $| = 1;
>    print "At $i GB\n";
>    
>    system "(dd if=/dev/md0 bs=$block count=$count skip=".($i*$count).
>           "| md5sum) 2>&1";
> }
> 
> diff -c on (modified) output:
> 
> *** 5,11 ****
>   At 4 GB 131e2916f3155f7c6df63fe2257e0350  -
>   At 5 GB 502be9c039744eb761f89ada152a1745  -
>   At 6 GB 07012ffe77ad7d6565f2e9576f1cf91e  -
> ! At 7 GB ffa5545ee518d3a7724831012d3e4c44  -
>   At 8 GB eec233bf66d33fc81bfa895b022c4b04  -
>   At 9 GB c62e78b9401f91199ce558242faf5da5  -
>   At 10 GB f41d004b63c2481245320c28b9366b08  -
> --- 5,11 ----
>   At 4 GB 131e2916f3155f7c6df63fe2257e0350  -
>   At 5 GB 502be9c039744eb761f89ada152a1745  -
>   At 6 GB 07012ffe77ad7d6565f2e9576f1cf91e  -
> ! At 7 GB 4bbbaeefe786c760e342342f6a85ad4e  -
>   At 8 GB eec233bf66d33fc81bfa895b022c4b04  -
>   At 9 GB c62e78b9401f91199ce558242faf5da5  -
>   At 10 GB f41d004b63c2481245320c28b9366b08  -
> (... still running)

Ok, after 5 runs, it turned out that the error is always at 7GB or 47GB. hde
or hdg never fail when run separately (in parallel or not). This is propably
an IDE problem anyhow, since:

Nov 22 16:50:31 linux kernel: hde: dma_intr: status=0x51 { DriveReady SeekComplete Error } 
Nov 22 16:50:31 linux kernel: hde: dma_intr: error=0x84 { DriveStatusError BadCRC } 
Nov 22 22:47:11 linux kernel: hde: dma_intr: status=0x51 { DriveReady SeekComplete Error } 
Nov 22 22:47:11 linux kernel: hde: dma_intr: error=0x84 { DriveStatusError BadCRC } 
Nov 23 02:48:30 linux kernel: hdg: 24 bytes in FIFO 
Nov 23 02:48:30 linux kernel: hdg: ide_dma_timeout: Lets do it again!stat = 0x58 , dma_stat = 0x20 
Nov 23 02:48:30 linux kernel: hdg: DMA disabled 
Nov 23 02:48:30 linux kernel: hdg: timeout waiting for DMA 
Nov 23 02:48:30 linux kernel: hdg: 0 bytes in FIFO 
Nov 23 02:48:30 linux kernel: hdg: ide_dma_timeout: Lets do it again!stat = 0x80, dma_stat = 0x20 
Nov 23 02:48:30 linux kernel: hdg: DMA disabled 
Nov 23 02:48:30 linux kernel: hdg: irq timeout: status=0x80 { Busy } 
Nov 23 02:48:30 linux kernel: hdg: DMA disabled 
Nov 23 02:48:30 linux kernel: hdg: ide_set_handler: handler not null; old=c017fd

(This was with 2.2.20+IDE 05042001 + Tim Hockin's hpt366.c patch). 

It went back to 2.2.18pre19 and the md5sum of md0 are consistent. I saw a
couple of BadCRC errors, however.

I'm trying again with 2.2.20/IDE 05042001/no hpt patch/slightly older
bios/UDMA33 instead of UDMA66. (Just _too_ many variables... Phew.)

The controller is HPT370A (KT7A-RAID) and drives(hde,hdg) are IBM-DPTA-373420
(32.5GB).



-- v --

v@iki.fi
