Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946011AbWBCWGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946011AbWBCWGl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 17:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946008AbWBCWGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 17:06:41 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:24997 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1946007AbWBCWGk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 17:06:40 -0500
Message-ID: <43E3D3EC.3040006@us.ibm.com>
Date: Fri, 03 Feb 2006 16:06:36 -0600
From: Brian King <brking@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: James Bottomley <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] ipr: don't doublefree pages from scatterlist
References: <Pine.LNX.4.63.0512271807130.4955@kai.makisara.local> <20060104172727.GA320@tau.solarneutrino.net> <Pine.LNX.4.63.0601042334310.5087@kai.makisara.local> <20060105201249.GB1795@tau.solarneutrino.net> <Pine.LNX.4.64.0601051312380.3169@g5.osdl.org> <20060109033149.GC283@tau.solarneutrino.net> <Pine.LNX.4.64.0601082000450.3169@g5.osdl.org> <Pine.LNX.4.61.0601090933160.7632@goblin.wat.veritas.com> <20060109185350.GG283@tau.solarneutrino.net> <Pine.LNX.4.61.0601091922550.15426@goblin.wat.veritas.com> <20060118001252.GB821@tau.solarneutrino.net> <Pine.LNX.4.61.0601181556050.9110@goblin.wat.veritas.com> <Pine.LNX.4.61.0602031842290.14065@goblin.wat.veritas.com> <Pine.LNX.4.61.0602031953400.14829@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0602031953400.14829@goblin.wat.veritas.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> On some architectures, mapping the scatterlist may coalesce entries:
> if that coalesced list is then used for freeing the pages afterwards,
> there's a danger that pages may be doubly freed (and others leaked).

I don't understand why this is necessary... Comparing the bug you fixed
in st with ipr's usage of scatterlists, there is a bit of a difference.
st is dealing with user pages and calling page_cache_release to release
the pages, and I can begin to understand why there might be a problem
in that code. page_cache_release looks at the pages themselves to figure
out how many compound pages there are. This could certainly result in
double free's occurring.

Looking at ipr, however, it is simply doing alloc_pages
and __free_pages. __free_pages passes in the page allocation order, so
I don't think I would have the double free problem.

As I understand it, pci_map_sg only modifies the dma_address and dma_length
fields when things get coalesced. If it were to coalese pages by
turning them into compound pages then I would agree that ipr might have
a problem, but I don't think this to be the case...


Brian

> 
> Fix Power RAID's ipr_free_ucode_buffer by freeing from a separate array
> beyond the scatterlist.
> 
> Signed-off-by: Hugh Dickins <hugh@veritas.com>
> ---
> Warning: untested!
> 
>  drivers/scsi/ipr.c |   12 ++++++++++--
>  1 files changed, 10 insertions(+), 2 deletions(-)
> 
> --- 2.6.16-rc2/drivers/scsi/ipr.c	2006-02-03 09:32:24.000000000 +0000
> +++ linux/drivers/scsi/ipr.c	2006-02-03 09:59:37.000000000 +0000
> @@ -2538,6 +2538,7 @@ static struct ipr_sglist *ipr_alloc_ucod
>  	int sg_size, order, bsize_elem, num_elem, i, j;
>  	struct ipr_sglist *sglist;
>  	struct scatterlist *scatterlist;
> +	struct page **sg_pages;
>  	struct page *page;
>  
>  	/* Get the minimum size per scatter/gather element */
> @@ -2557,7 +2558,8 @@ static struct ipr_sglist *ipr_alloc_ucod
>  
>  	/* Allocate a scatter/gather list for the DMA */
>  	sglist = kzalloc(sizeof(struct ipr_sglist) +
> -			 (sizeof(struct scatterlist) * (num_elem - 1)),
> +			 (sizeof(struct scatterlist) * (num_elem - 1)) +
> +			 (sizeof(struct page *) * num_elem),
>  			 GFP_KERNEL);
>  
>  	if (sglist == NULL) {
> @@ -2566,6 +2568,8 @@ static struct ipr_sglist *ipr_alloc_ucod
>  	}
>  
>  	scatterlist = sglist->scatterlist;
> +	/* Save pages to be freed in array beyond scatterlist */
> +	sg_pages = (struct page **) (scatterlist + num_elem);
>  
>  	sglist->order = order;
>  	sglist->num_sg = num_elem;
> @@ -2584,6 +2588,7 @@ static struct ipr_sglist *ipr_alloc_ucod
>  		}
>  
>  		scatterlist[i].page = page;
> +		sg_pages[i] = page;
>  	}
>  
>  	return sglist;
> @@ -2601,10 +2606,13 @@ static struct ipr_sglist *ipr_alloc_ucod
>   **/
>  static void ipr_free_ucode_buffer(struct ipr_sglist *sglist)
>  {
> +	struct page **sg_pages;
>  	int i;
>  
> +	/* Scatterlist entries may have been coalesced: free saved pagelist */
> +	sg_pages = (struct page **) (sglist->scatterlist + sglist->num_sg);
>  	for (i = 0; i < sglist->num_sg; i++)
> -		__free_pages(sglist->scatterlist[i].page, sglist->order);
> +		__free_pages(sg_pages[i], sglist->order);
>  
>  	kfree(sglist);
>  }
> 


-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center
