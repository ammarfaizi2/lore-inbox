Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264539AbTLQTqh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 14:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264542AbTLQTqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 14:46:37 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:32712 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S264539AbTLQTqc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 14:46:32 -0500
Date: Wed, 17 Dec 2003 19:46:06 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Claas Langbehn <claas@rootdir.de>
Cc: linux-kernel@vger.kernel.org, andre@linux-ide.org, chb@muc.de
Subject: Re: [2.6.0-test11] VIA IDE DMA problems with sleeping harddisk
Message-ID: <20031217184606.GA20168@ucw.cz>
References: <20031216143808.GA11517@rootdir.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031216143808.GA11517@rootdir.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 16, 2003 at 03:38:08PM +0100, Claas Langbehn wrote:
> Hello,
> 
> 
> I have got two harddiscs in my system (hda, hdb) and an CD-R/W writer as
> hdc. Both harddiscs are UDMA-100 drives. First of all, it is strange
> that the drives are only set to a transfer rate of 88.8 MB/s and not
> to 100MB/s (see below).

This is normal. UDMA/133 chipsets often don't support 100MB/sec, because
it's not possible with a 266 MHz clock, so instead you get 88.8MB/sec,
which is the closest lower value achievable.

> hdb is sleeping most of the time (hdparm -S), but when I need the drive,
> it does not spin up fast enough, so that the kernel messages say:
> 
>     Dec 16 15:13:14 kernel: hdb: dma_timer_expiry: dma status == 0x61
>     Dec 16 15:13:24 kernel: hdb: DMA timeout error
>     Dec 16 15:13:24 kernel: hdb: dma timeout error: status=0xd0 { Busy }
>     Dec 16 15:13:24 kernel: 
>     Dec 16 15:13:24 kernel: hda: DMA disabled
>     Dec 16 15:13:24 kernel: hdb: DMA disabled
>     Dec 16 15:13:25 kernel: ide0: reset: success
> 
> In /proc/ide/via i see, that hda is using PIO now:
> 
>     -------------------drive0----drive1----drive2----drive3-----
>     Transfer Mode:        PIO      UDMA      UDMA       PIO
>     Address Setup:      120ns     120ns     120ns     120ns
>     Cmd Active:          90ns      90ns      90ns      90ns
>     Cmd Recovery:        30ns      30ns      30ns      30ns
>     Data Active:         90ns      90ns      90ns     330ns
>     Data Recovery:       30ns      30ns      30ns     270ns
>     Cycle Time:         120ns      22ns      60ns     600ns
>     Transfer Rate:   16.6MB/s  88.8MB/s  33.3MB/s   3.3MB/s
> 
> When I re-enable DMA afterwards the messages say:
> 
> Dec 16 15:13:49 zoo kernel: blk: queue dfde1200, I/O limit 4095Mb (mask
> 0xffffffff)
> 
> 
> 
> - How do I increase the dma_timer_expiry so that DMA will 
>   not be disabled so fast? 
>   
> - Why does the kernel say "hdb: DMA disabled" but /proc/ide/via says
>   that DMA was only disabled on hda?
>   Is it a bug or is it enabled again without telling me?

DMA is enabled in the chipset but not used by the driver.

>   
> - Which workaround should be considered?
> 
> 
> 
> Regards, Claas
> 
> 
> 
> # cat /proc/ide/via   (with DMA enabled)
> 
>     ----------VIA BusMastering IDE Configuration----------------
>     Driver Version:                     3.38
>     South Bridge:                       VIA vt8235
>     Revision:                           ISA 0x0 IDE 0x6
>     Highest DMA rate:                   UDMA133
>     BM-DMA base:                        0xdc00
>     PCI clock:                          33.3MHz
>     Master Read  Cycle IRDY:            0ws
>     Master Write Cycle IRDY:            0ws
>     BM IDE Status Register Read Retry:  yes
>     Max DRDY Pulse Width:               No limit
>     -----------------------Primary IDE-------Secondary IDE------
>     Read DMA FIFO flush:          yes                 yes
>     End Sector FIFO flush:         no                  no
>     Prefetch Buffer:              yes                 yes
>     Post Write Buffer:            yes                 yes
>     Enabled:                      yes                 yes
>     Simplex only:                  no                  no
>     Cable Type:                   80w                 80w
>     -------------------drive0----drive1----drive2----drive3-----
>     Transfer Mode:       UDMA      UDMA      UDMA       PIO
>     Address Setup:      120ns     120ns     120ns     120ns
>     Cmd Active:          90ns      90ns      90ns      90ns
>     Cmd Recovery:        30ns      30ns      30ns      30ns
>     Data Active:         90ns      90ns      90ns     330ns
>     Data Recovery:       30ns      30ns      30ns     270ns
>     Cycle Time:          22ns      22ns      60ns     600ns
>     Transfer Rate:   88.8MB/s  88.8MB/s  33.3MB/s   3.3MB/s
> 
> # uname -a
>     Linux zoo 2.6.0-test11 #3 Mon Dec 1 19:57:51 CET 2003 i686 GNU/Linux
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
