Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265198AbTA2IOP>; Wed, 29 Jan 2003 03:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265276AbTA2IOP>; Wed, 29 Jan 2003 03:14:15 -0500
Received: from AMarseille-201-1-4-213.abo.wanadoo.fr ([217.128.74.213]:1648
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S265198AbTA2IOM>; Wed, 29 Jan 2003 03:14:12 -0500
Subject: Re: 2.4.21-pre3 kernel crash
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org,
       Larry Sendlosky <Larry.Sendlosky@storigen.com>
In-Reply-To: <20030128220607.GF31566@suse.de>
References: <7BFCE5F1EF28D64198522688F5449D5A03C0FA@xchangeserver2.storigen.com>
	 <20030128220607.GF31566@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1043828587.537.25.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 29 Jan 2003 09:23:50 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-01-28 at 23:06, Jens Axboe wrote:
> On Tue, Jan 28 2003, Larry Sendlosky wrote:
> > I was glad to see the physical page support in 2.4.20.
> > (and also noticed that the current BK tree clobbered it
> > on a patch set from Alan).
> > 
> > One question, 
> > 
> > +		lastdataend = bh_phys(bh) + bh->b_size;
> > 
> > bh_phys(x) uses bh->b_page. Does it make a difference
> > if bh->b_page is zero? What if someone combines virt and phys
> > buffer addresses in bh list?
> 
> Yes good catch! New version attached.

That's interesting. I wasn't awaye you could have a request
containing such a "mixed" set of bh without valid pages.
Actually, I though b_page was always valid. Looking at
other drivers (typically the the csiss.c driver), it also
unconditionally use b_page & bh_phys(). So either we are
looking at a false problem, or that driver need fixing as
well.

Now assuming that mix can happen, I don't like the fact that
your new version will use lastdataend to compare against both
physical and virtual addresses.

While I agree they should usually not collide (as those virtual
addresses are supposed to be grok-able by pci_map_* they are
in the linear mapping while the physical ones will typically
be smaller than c0000000), there is still some risk of
collision especially with HIGHMEM, or did I miss something ?

Maybe the solution is to have an additional variable indicating
if the last bh was virtual or physical, and reset lastdataend
to ~0 when the current one is different... 

Ben.

> ===== drivers/ide/ide-dma.c 1.7 vs edited =====
> --- 1.7/drivers/ide/ide-dma.c	Wed Nov 20 18:46:24 2002
> +++ edited/drivers/ide/ide-dma.c	Tue Jan 28 23:04:32 2003
> @@ -249,6 +249,7 @@
>  {
>  	struct buffer_head *bh;
>  	struct scatterlist *sg = hwif->sg_table;
> +	unsigned long lastdataend = ~0UL;
>  	int nents = 0;
>  
>  	if (hwif->sg_dma_active)
> @@ -256,24 +257,42 @@
>  
>  	bh = rq->bh;
>  	do {
> -		unsigned char *virt_addr = bh->b_data;
> -		unsigned int size = bh->b_size;
> +		int contig = 0;
> +
> +		if (bh->b_page) {
> +			if (bh_phys(bh) == lastdataend)
> +				contig = 1;
> +		} else {
> +			if ((unsigned long) bh->b_data == lastdataend)
> +				contig = 1;
> +		}
> +
> +		if (contig) {
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
> +
> +		if (bh->b_page) {
> +			sg[nents].page = bh->b_page;
> +			sg[nents].offset = bh_offset(bh);
> +			lastdataend = bh_phys(bh) + bh->b_size;
> +		} else {
> +			if ((unsigned long) bh->b_data < PAGE_SIZE)
> +				BUG();
> +
> +			sg[nents].address = bh->b_data;
> +			lastdataend = (unsigned long) bh->b_data + bh->b_size;
> +		}
> +
> +		sg[nents].length = bh->b_size;
>  		nents++;
> -	} while (bh != NULL);
> +	} while ((bh = bh->b_reqnext) != NULL);
>  
>  	if(nents == 0)
>  		BUG();
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>
