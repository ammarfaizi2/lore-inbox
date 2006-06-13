Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751137AbWFMOLe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbWFMOLe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 10:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbWFMOLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 10:11:34 -0400
Received: from rtsoft2.corbina.net ([85.21.88.2]:3735 "HELO mail.dev.rtsoft.ru")
	by vger.kernel.org with SMTP id S1751137AbWFMOLe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 10:11:34 -0400
Message-ID: <448EC74F.30104@ru.mvista.com>
Date: Tue, 13 Jun 2006 18:10:23 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Steve Fox <drfickle@us.ibm.com>,
       pbadari@gmail.com
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc6-mm2
References: <20060609214024.2f7dd72c.akpm@osdl.org>	<pan.2006.06.12.22.09.47.855327@us.ibm.com> <20060613065443.7f302319.akpm@osdl.org>
In-Reply-To: <20060613065443.7f302319.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Andrew Morton wrote:
> On Mon, 12 Jun 2006 17:09:52 -0500
> Steve Fox <drfickle@us.ibm.com> wrote:

>>On Fri, 09 Jun 2006 21:40:24 -0700, Andrew Morton wrote:

>>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc6/2.6.17-rc6-mm2/

>>Boot fails on a ppc64 machine.
>>
>>[snip]
>>Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
>>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
>>AMD8111: IDE controller at PCI slot 0000:00:04.1
>>AMD8111: chipset revision 3
>>AMD8111: 0000:00:04.1 (rev 03) UDMA133 controller
>>AMD8111: 100% native mode on irq 32
>>    ide0: BM-DMA at 0x7c00-0x7c07<3>AMD8111: -- Error, unable to allocate DMA table.
>>    ide1: BM-DMA at 0x7c08-0x7c0f<3>AMD8111: -- Error, unable to allocate DMA table.
>>hda: TOSHIBA MK4019GAXB, ATA DISK drive
>>Unable to handle kernel paging request for data at address 0x00000000
>>Faulting instruction address: 0xc000000000301240
>>cpu 0x1: Vector: 300 (Data Access) at [c000000002a13600]
>>    pc: c000000000301240: .ide_config_drive_speed+0x228/0x624
>>    lr: c0000000002f6c34: .amd_set_drive+0x7c/0x538
>>    sp: c000000002a13880
>>   msr: 8000000000009032
>>   dar: 0
>> dsisr: 40000000
>>  current = 0xc00000000ffd6820
>>  paca    = 0xc000000000590080
>>    pid   = 1, comm = idle

> Thanks.   Reverting the below might fix it.

    Frankly speaking, I don't see how that can be possible. I haven't touched 
any *real* checks in ide_allocate_dma_engine(), so it should fail regardless 
of my patch. I'd rather supposed that pci_alloc_consistent() had failed...

> From: Sergei Shtylylov <sshtylyov@ru.mvista.com>

> Release the DMA engine for the custom mapping IDE drivers also (for
> example, siimage.c does allocate it in both I/O-mapped and custom-mapped
> modes).  Remove useless code from the error path of
> ide_allocate_dma_engine().

> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---

>  drivers/ide/ide-dma.c |   16 +++++++---------
>  1 files changed, 7 insertions(+), 9 deletions(-)

> diff -puN drivers/ide/ide-dma.c~ide-always-release-dma-engine drivers/ide/ide-dma.c
> --- devel/drivers/ide/ide-dma.c~ide-always-release-dma-engine	2006-05-11 15:19:36.000000000 -0700
> +++ devel-akpm/drivers/ide/ide-dma.c	2006-05-11 15:19:36.000000000 -0700
> @@ -808,15 +808,14 @@ static int ide_release_iomio_dma(ide_hwi
>  /*
>   * Needed for allowing full modular support of ide-driver
>   */
> -int ide_release_dma (ide_hwif_t *hwif)
> +int ide_release_dma(ide_hwif_t *hwif)
>  {
> +	ide_release_dma_engine(hwif);
> +
>  	if (hwif->mmio == 2)
>  		return 1;
> -	if (hwif->chipset == ide_etrax100)
> -		return 1;
> -
> -	ide_release_dma_engine(hwif);
> -	return ide_release_iomio_dma(hwif);
> +	else
> +		return ide_release_iomio_dma(hwif);
>  }
>  
>  static int ide_allocate_dma_engine(ide_hwif_t *hwif)
> @@ -828,10 +827,9 @@ static int ide_allocate_dma_engine(ide_h
>  	if (hwif->dmatable_cpu)
>  		return 0;
>  
> -	printk(KERN_ERR "%s: -- Error, unable to allocate%s DMA table(s).\n",
> -			hwif->cds->name, !hwif->dmatable_cpu ? " CPU" : "");
> +	printk(KERN_ERR "%s: -- Error, unable to allocate DMA table.\n",
> +	       hwif->cds->name);
>  
> -	ide_release_dma_engine(hwif);
>  	return 1;
>  }

MBR, Sergei
