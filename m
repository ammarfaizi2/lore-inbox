Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313093AbSDQSjS>; Wed, 17 Apr 2002 14:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313138AbSDQSjR>; Wed, 17 Apr 2002 14:39:17 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:40455
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S313093AbSDQSjQ>; Wed, 17 Apr 2002 14:39:16 -0400
Date: Wed, 17 Apr 2002 11:38:27 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Baldur Norddahl <bbn-linux-kernel@clansoft.dk>
cc: linux-kernel@vger.kernel.org
Subject: Re: IDE/raid performance
In-Reply-To: <20020417125838.GA27648@dark.x.dtu.dk>
Message-ID: <Pine.LNX.4.10.10204171130590.12780-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



case ide_dma_test_irq:  /* returns 1 if dma irq issued, 0 otherwise */
        dma_stat = IN_BYTE(dma_base+2);
        if (newchip)
                return (dma_stat & 4) == 4;

        sc1d = IN_BYTE(high_16 + 0x001d);
                if (HWIF(drive)->channel) {
                        if ((sc1d & 0x50) == 0x50) goto somebody_else;
                        else if ((sc1d & 0x40) == 0x40)
                                return (dma_stat & 4) == 4;
                } else {
                        if ((sc1d & 0x05) == 0x05) goto somebody_else;
                        else if ((sc1d & 0x04) == 0x04)
                                return (dma_stat & 4) == 4;
                }
somebody_else:
        return (dma_stat & 4) == 4;     /* return 1 if INTR asserted */

Please note the old chips have an interrupt parser and owner ship.
The new chips do not have this feature reported.

Once you hit high load/io the cards/driver get confused.
Who owns the interrupt as retruned and expect more reports dma_intr error
35 to show up.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Wed, 17 Apr 2002, Baldur Norddahl wrote:

> Hi,
> 
> I have been doing some simple benchmarks on my IDE system. It got 12 disks
> and a system disk. The 12 disks are organized in two raids like this:
> 
> Personalities : [raid5] 
> read_ahead 1024 sectors
> md1 : active raid5 hds1[0] hdo1[1] hdk1[2] hdg1[3]
>       480238656 blocks level 5, 32k chunk, algorithm 0 [4/4] [UUUU]
>       
> md0 : active raid5 hdt1[6] hdq1[1] hdp1[7] hdm1[0] hdl1[2] hdi1[4] hdh1[3] hde1[5]
>       547054144 blocks level 5, 4k chunk, algorithm 0 [8/8] [UUUUUUUU]
>       
> unused devices: <none>
> 
> The md0 raid is eight 80 GB Western Digital disks. The md1 raid is four 160
> GB Maxtor disks.
> 
> I am using two Promise Technology ultradma133 TX2 controllers and two
> Promise Technologu ultradma100 TX2 controllers. The two ultradma133
> controllers are on a 66 MHz PCI bus, while the two ultradma100 controllers
> are on a 33 MHz PCI bus.
> 
> An example of a test run is:
> 
> echo Testing hdo1, hds1 and hdk1
> time dd if=/dev/hdo1 of=/dev/null bs=1M count=1k &
> time dd if=/dev/hds1 of=/dev/null bs=1M count=1k &
> time dd if=/dev/hdk1 of=/dev/null bs=1M count=1k &
> wait
> 
> I am then watching the progress in another window with vmstat 1. I copied
> typical lines for each test below. What interrest me is the "bi" column for
> the transfer rate. Ad the "id" column as an indicator of how much CPU is being
> spend.
> 
> This test is done on a SMP system with kernel 2.4.18 with IDE patches.
> 
>    procs                      memory    swap          io     system         cpu
>  r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
> 
> hdt:
>  0  1  0  26096   6600 159888 599004   0   0 34432     0  709  1690   1  10  88
> 
> hdt and hdg:
>  0  2  1  26096   6428  70736 687496   0   0 64768     0 1167  2931   1  25  74
> 
> hdt, hdg and hdp:
>  0  3  0  26092   7832  42632 712712   0   0 75620     0 1383  3242   7  33  60
> 
> hdt, hdg, hdp and hdm:
>  0  4  0  26092   6400  42464 713044   0   0 74376     0 1374  3289   0  30  70
> 
> hdt, hdg, hdp, hdm and hdl:
>  0  5  0  26092   6196  42412 712188   0   0 107008   696 2000  4397   5  43  51
> 
> hdt, hdg, hdp, hdm, hdl and hdi:
>  2  4  1  26172   5480  42184 713432   0   0 137104     0 2137  4602   5  75  20
> 
> hdt, hdg, hdp, hdm, hdl, hdi and hdh:
>  5  2  1  27324   5020  35268 737336   0 108 144640   108 2177  2271   0  99   0
> 
> hdt, hdg, hdp, hdm, hdl, hdi, hdh and hde:
>  4  4  1  27324   5420  35572 735752   0   0 143796     0 2102  2180   1  99   0
> 
> hdo:
>  0  1  0  27324   7032  55732 666408   0   0 36352     0  710  1796   0  12  87
> 
> hdo and hds:
>  0  2  1  27324   6516  40012 691588   0   0 72576     0 1264  3311   0  24  75
> 
> hdo, hds and hdk:
>  0  3  0  27316   6012  40048 692088   0   0 108944   484 1970  4523   0  50  50
> 
> hdo, hds, hdk and hdg:
>  4  0  1  27316   5552  40080 694124   0   0 134572     0 2252  4825   1  70  29
> 
> md0:
>  1  0  0  27324  13460  38104 692140   0   0 76676     0 4639  2611   4  74  22
> 
> md1:
>  0  1  0  27316  10224  40340 697780   0   0 69504     0 1893  3892   1  55  44
> 
> md0 and md1:
>  2  1  1  27316   7188  40224 675200   0   0 81470   164 3935  2389   9  77  14
> 
> It is clear that the 33 MHz PCI bus maxes out at 75 MB/s. Is there a reason
> it doesn't reach 132 MB/s?
> 
> Second, why are the md devices so slow? I would have expected it to reach
> 130+ MB/s on both md0 and md1. It even has spare CPU time to do it with.
> 
> Another issue is when the system is under heavy load this often happens:
> 
> hdq: dma_intr: bad DMA status (dma_stat=35)
> hdq: dma_intr: status=0x50 { DriveReady SeekComplete }
> hdq: dma_intr: bad DMA status (dma_stat=35)
> hdq: dma_intr: status=0x50 { DriveReady SeekComplete }
> hdt: dma_intr: bad DMA status (dma_stat=75)
> hdt: dma_intr: status=0x50 { DriveReady SeekComplete }
> hdq: dma_intr: bad DMA status (dma_stat=35)
> hdq: dma_intr: status=0x50 { DriveReady SeekComplete }
> hdq: dma_intr: bad DMA status (dma_stat=35)
> hdq: dma_intr: status=0x50 { DriveReady SeekComplete }
> hdq: dma_intr: bad DMA status (dma_stat=35)
> hdq: dma_intr: status=0x50 { DriveReady SeekComplete }
> hdq: dma_intr: bad DMA status (dma_stat=35)
> hdq: dma_intr: status=0x50 { DriveReady SeekComplete }
> hdq: timeout waiting for DMA
> PDC202XX: Primary channel reset.
> ide_dmaproc: chipset supported ide_dma_timeout func only: 14
> hdq: dma_intr: bad DMA status (dma_stat=35)
> hdq: dma_intr: status=0x50 { DriveReady SeekComplete }
> hdq: timeout waiting for DMA
> PDC202XX: Primary channel reset.
> ide_dmaproc: chipset supported ide_dma_timeout func only: 14
> etc.
> 
> It did not happen during the test above though.
> 
> Baldur
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

