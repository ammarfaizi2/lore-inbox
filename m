Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129557AbQLATBB>; Fri, 1 Dec 2000 14:01:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130003AbQLATAv>; Fri, 1 Dec 2000 14:00:51 -0500
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:51470 "HELO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with SMTP
	id <S129557AbQLATAo>; Fri, 1 Dec 2000 14:00:44 -0500
Date: Fri, 1 Dec 2000 13:30:10 -0500 (EST)
From: Phillip Ezolt <ezolt@perf.zko.dec.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Andrea Arcangeli <andrea@suse.de>, rth@twiddle.net,
        Jay.Estabrook@compaq.com, linux-kernel@vger.kernel.org,
        wcarr@perf.zko.dec.com
Subject: Re: Alpha SCSI error on 2.4.0-test11
In-Reply-To: <20001201145619.A553@jurassic.park.msu.ru>
Message-ID: <Pine.OSF.3.96.1001201132729.32335G-100000@perf.zko.dec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan,

I have tried test12-pre3 with and without your patch, it fails in the same
way. 

The Qlogic SCSI controller continues to fail if we have >1 gig in the machine.
(But works fine without it.)

Any ideas? (Or patches that I can test... ;-) ) 

Thanks,
--Phil

Compaq:  High Performance Server Division/Benchmark Performance Engineering 
---------------- Alpha, The Fastest Processor on Earth --------------------
Phillip.Ezolt@compaq.com        |C|O|M|P|A|Q|        ezolt@perf.zko.dec.com
------------------- See the results at www.spec.org -----------------------

On Fri, 1 Dec 2000, Ivan Kokshaysky wrote:

> On Thu, Nov 30, 2000 at 11:37:42PM +0100, Andrea Arcangeli wrote:
> > test12-pre2 crashes at boot on my DS20. This patch workaround the problem
> > but I would be _very_ surprised if this is the right fix :) It's obviously not
> > meant for inclusion.
> ...
> > -			struct resource_list *ln = list->next;
> > +			struct resource_list *ln;
> >  
> > +			if (!list)
> > +				return;
> > +			ln = list->next;
> 
> Argh. I believe that crash could happen only if some broken device has
> empty I/O or memory range and IORESOURCE_[IO,MEM] bit set.
> 
> Andrea, could you try this?
> 
> Ivan.
> 
> --- linux/drivers/pci/setup-res.c~	Thu Nov 30 12:14:31 2000
> +++ linux/drivers/pci/setup-res.c	Fri Dec  1 13:49:34 2000
> @@ -136,6 +136,7 @@ pdev_sort_resources(struct pci_dev *dev,
>  	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
>  		struct resource *r;
>  		struct resource_list *list, *tmp;
> +		unsigned long r_size;
>  
>  		/* PCI-PCI bridges may have I/O ports or
>  		   memory on the primary bus */
> @@ -144,7 +145,9 @@ pdev_sort_resources(struct pci_dev *dev,
>  			continue;
>  
>  		r = &dev->resource[i];
> -		if (!(r->flags & type_mask) || r->parent)
> +		r_size = r->end - r->start;
> +		
> +		if (!(r->flags & type_mask) || !r_size || r->parent)
>  			continue;
>  		for (list = head; ; list = list->next) {
>  			unsigned long size = 0;
> @@ -152,7 +155,7 @@ pdev_sort_resources(struct pci_dev *dev,
>  
>  			if (ln)
>  				size = ln->res->end - ln->res->start;
> -			if (r->end - r->start > size) {
> +			if (r_size > size) {
>  				tmp = kmalloc(sizeof(*tmp), GFP_KERNEL);
>  				tmp->next = ln;
>  				tmp->res = r;
> 
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
