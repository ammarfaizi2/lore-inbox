Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262789AbTA0US2>; Mon, 27 Jan 2003 15:18:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262796AbTA0US2>; Mon, 27 Jan 2003 15:18:28 -0500
Received: from pc-80-192-208-23-mo.blueyonder.co.uk ([80.192.208.23]:51648
	"EHLO efix.biz") by vger.kernel.org with ESMTP id <S262789AbTA0US0>;
	Mon, 27 Jan 2003 15:18:26 -0500
Subject: Re: 2.4.21-pre3 kernel crash
From: Edward Tandi <ed@efix.biz>
To: Jens Axboe <axboe@suse.de>
Cc: Martin MOKREJ? <mmokrejs@natur.cuni.cz>, Ross Biro <rossb@google.com>,
       Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20030127192327.GD889@suse.de>
References: <Pine.OSF.4.51.0301271632230.49659@tao.natur.cuni.cz>
	 <3E356403.9010805@google.com>
	 <Pine.OSF.4.51.0301271813230.57372@tao.natur.cuni.cz>
	 <20030127192327.GD889@suse.de>
Content-Type: text/plain
Organization: 
Message-Id: <1043699262.2696.7.camel@wires.home.biz>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 27 Jan 2003 20:27:43 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI It works!

Thanks, I actually reported high-memory and DMA problems on the
13th-15th of Jan (under the title of Linux 2.4.21-pre3-ac3 and KT400)
but I thought it was VIA specific. I knew it was only time before a
fix...

The VIA audio issue is still there though ;-)

Ed-T.

On Mon, 2003-01-27 at 19:23, Jens Axboe wrote:
> On Mon, Jan 27 2003, Martin MOKREJ? wrote:
> > On Mon, 27 Jan 2003, Ross Biro wrote:
> > 
> > > This looks like the same problem I ran into with IDE and highmem not
> > > getting along.  Try compiling your kernel with out highmem enabled and
> > > see what happenes.
> > 
> > Yes, that "fixes" it. Any "better solution"? ;-)
> > 
> > > >Trace; c024dfc1 <ide_build_sglist+181/1a0>
> > > >Trace; c024e1b4 <ide_build_dmatable+54/1a0>
> > > >Trace; c024e6df <__ide_dma_read+3f/150>
> 
> Someone completely lost the highmem capable scatterlist setup, *boggle*.
> This should fix it.
> 
> ===== drivers/ide/ide-dma.c 1.7 vs edited =====
> --- 1.7/drivers/ide/ide-dma.c	Wed Nov 20 18:46:24 2002
> +++ edited/drivers/ide/ide-dma.c	Mon Jan 27 20:22:06 2003
> @@ -249,6 +249,7 @@
>  {
>  	struct buffer_head *bh;
>  	struct scatterlist *sg = hwif->sg_table;
> +	unsigned long lastdataend = ~0UL;
>  	int nents = 0;
>  
>  	if (hwif->sg_dma_active)
> @@ -256,22 +257,28 @@
>  
>  	bh = rq->bh;
>  	do {
> -		unsigned char *virt_addr = bh->b_data;
> -		unsigned int size = bh->b_size;
> +		if (bh_phys(bh) == lastdataend) {
> +			sg[nents - 1].length += bh->b_size;
> +			lastdataend += bh->b_size;
> +			continue;
> +		}
>  
>  		if (nents >= PRD_ENTRIES)
>  			return 0;
>  
> -		while ((bh = bh->b_reqnext) != NULL) {
> -			if ((virt_addr + size) != (unsigned char *) bh->b_data)
> -				break;
> -			size += bh->b_size;
> -		}
>  		memset(&sg[nents], 0, sizeof(*sg));
> -		sg[nents].address = virt_addr;
> -		sg[nents].length = size;
> -		if(size == 0)
> -			BUG();
> +		if (bh->b_page) {
> +			sg[nents].page = bh->b_page;
> +			sg[nents].offset = bh_offset(bh);
> +		} else {
> +			if (((unsigned long) bh->b_data) < PAGE_SIZE)
> +				BUG();
> +
> +			sg[nents].address = bh->b_data;
> +		}
> +
> +		sg[nents].length = bh->b_size;
> +		lastdataend = bh_phys(bh) + bh->b_size;
>  		nents++;
>  	} while (bh != NULL);
>  

