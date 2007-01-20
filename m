Return-Path: <linux-kernel-owner+w=401wt.eu-S965333AbXATRpc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965333AbXATRpc (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 12:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965339AbXATRpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 12:45:32 -0500
Received: from 1wt.eu ([62.212.114.60]:2079 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965333AbXATRpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 12:45:31 -0500
Date: Sat, 20 Jan 2007 18:45:04 +0100
From: Willy Tarreau <w@1wt.eu>
To: Ismail =?iso-8859-1?Q?D=F6nmez?= <ismail@pardus.org.tr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Abysmal disk performance, how to debug?
Message-ID: <20070120174503.GZ24090@1wt.eu>
References: <200701201920.54620.ismail@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200701201920.54620.ismail@pardus.org.tr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Jan 20, 2007 at 07:20:53PM +0200, Ismail Dönmez wrote:
> Hi all,
> 
> I own a Sony Vaio VGN-FS285B and disk performance to say at least is very very 
> slow. Writing 1 GB data makes the laptop unresponsive. Here is some data 
> identifying the drive. Hope someone can tell me how to debug and find out 
> whats the problem.
> 
> FWIW since 2.6.16 the problem is same and I didn't test with 2.4 kernels. Here 
> is some data. And I tested with xfs & ext3. Both slow slow disk writes.
> 
> vaio cartman # hdparm /dev/hda
> 
> /dev/hda:
>  multcount    = 16 (on)
>  IO_support   =  1 (32-bit)
>  unmaskirq    =  1 (on)
>  using_dma    =  1 (on)
>  keepsettings =  0 (off)
>  readonly     =  0 (off)
>  readahead    = 256 (on)
>  geometry     = 65535/16/63, sectors = 156301488, start = 0
> vaio cartman # hdparm -i /dev/hda
> 
> /dev/hda:
> 
>  Model=FUJITSU MHV2080AT, FwRev=00000096, SerialNo=NS56T58270LE
>  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
>  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=0
>  BuffType=DualPortCache, BuffSize=8192kB, MaxMultSect=16, MultSect=16
>  CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=156301488
>  IORDY=yes, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
>  PIO modes:  pio0 pio1 pio2 pio3 pio4
>  DMA modes:  mdma0 mdma1 mdma2
>  UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5 udma3 udma4 *udma5
>  AdvancedPM=yes: mode=0x80 (128) WriteCache=enabled
>  Drive conforms to: ATA/ATAPI-6 T13 1410D revision 3a:  ATA/ATAPI-2 
> ATA/ATAPI-3 ATA/ATAPI-4 ATA/ATAPI-5 ATA/ATAPI-6
> 
>  * signifies the current active mode
> 
> 
> vaio cartman # hdparm -tT /dev/hda
> 
> /dev/hda:
>  Timing cached reads:   1576 MB in  2.00 seconds = 788.18 MB/sec
>  Timing buffered disk reads:   74 MB in  3.01 seconds =  24.55 MB/sec
> 
> 
> [~]> time dd if=/dev/zero of=/tmp/1GB bs=1M count=1024
> 1024+0 records in
> 1024+0 records out
> 1073741824 bytes (1,1 GB) copied, 77,2809 s, 13,9 MB/s
> 
> real    1m17.482s
> user    0m0.003s
> sys     0m2.350s

That's not bad at all ! I suspect that if your system becomes unresponsive,
it's because real writes start when the cache is full. And if you fill
512 MB of RAM with data that you then need to flush on disk at 14 MB/s, it
can take about 40 seconds during which it might be difficult to do anything.

Try lowering the cache flush starting point to about 10 MB if you want
(2% of 512 MB) :

# echo 2 >/proc/sys/vm/dirty_ratio
# echo 2 >/proc/sys/vm/dirty_background_ratio

I see nothing wrong in your measures nor messages.

Regards,
Willy

