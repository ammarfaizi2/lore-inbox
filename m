Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263152AbTHJLbx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 07:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262385AbTHJLbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 07:31:53 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:57106 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263152AbTHJLbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 07:31:50 -0400
Date: Sun, 10 Aug 2003 12:31:48 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "YOSHIFUJI Hideaki / ?$B5HF#1QL@?(B" <yoshfuji@linux-ipv6.org>
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9] convert drivers/scsi to virt_to_pageoff()
Message-ID: <20030810123148.A10435@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"YOSHIFUJI Hideaki / ?$B5HF#1QL@?(B" <yoshfuji@linux-ipv6.org>,
	davem@redhat.com, linux-kernel@vger.kernel.org
References: <20030810013041.679ddc4c.davem@redhat.com> <20030810090556.GY31810@waste.org> <20030810020444.48cb740b.davem@redhat.com> <20030810.201009.77128484.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030810.201009.77128484.yoshfuji@linux-ipv6.org>; from yoshfuji@linux-ipv6.org on Sun, Aug 10, 2003 at 08:10:09PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 10, 2003 at 08:10:09PM +0900, YOSHIFUJI Hideaki / ?$B5HF#1QL@?(B wrote:
> [7/9] convert drivers/scsi to virt_to_pageoff().
>  
> Index: linux-2.6/drivers/scsi/3w-xxxx.c
> ===================================================================
> RCS file: /home/cvs/linux-2.5/drivers/scsi/3w-xxxx.c,v
> retrieving revision 1.34
> diff -u -r1.34 3w-xxxx.c
> --- linux-2.6/drivers/scsi/3w-xxxx.c	17 Jul 2003 17:43:53 -0000	1.34
> +++ linux-2.6/drivers/scsi/3w-xxxx.c	10 Aug 2003 09:30:32 -0000
> @@ -2112,7 +2112,7 @@
>  	if (cmd->request_bufflen == 0)
>  		return 0;
>  
> -	mapping = pci_map_page(pdev, virt_to_page(cmd->request_buffer), ((unsigned long)cmd->request_buffer & ~PAGE_MASK), cmd->request_bufflen, dma_dir);
> +	mapping = pci_map_page(pdev, virt_to_page(cmd->request_buffer), virt_to_pageoff(cmd->request_buffer), cmd->request_bufflen, dma_dir);

You probably want to use pci_map_single here instead..

> --- linux-2.6/drivers/scsi/megaraid.c	17 Jul 2003 17:43:53 -0000	1.43
> +++ linux-2.6/drivers/scsi/megaraid.c	10 Aug 2003 09:30:32 -0000
> @@ -2275,8 +2275,7 @@
>  	if( !cmd->use_sg ) {
>  
>  		page = virt_to_page(cmd->request_buffer);
> -
> -		offset = ((unsigned long)cmd->request_buffer & ~PAGE_MASK);
> +		offset = virt_to_pageoff(cmd->request_buffer);

Dito.

> --- linux-2.6/drivers/scsi/qlogicfc.c	17 Jul 2003 17:43:53 -0000	1.34
> +++ linux-2.6/drivers/scsi/qlogicfc.c	10 Aug 2003 09:30:32 -0000
> @@ -1283,8 +1283,7 @@
>  		}
>  	} else if (Cmnd->request_bufflen && Cmnd->sc_data_direction != PCI_DMA_NONE) {
>  		struct page *page = virt_to_page(Cmnd->request_buffer);
> -		unsigned long offset = ((unsigned long)Cmnd->request_buffer &
> -					~PAGE_MASK);
> +		unsigned long offset = virt_to_pageoff(Cmnd->request_buffer);
>  		dma_addr_t busaddr = pci_map_page(hostdata->pci_dev,
>  						  page, offset,
>  						  Cmnd->request_bufflen,

Dito.

> @@ -1927,8 +1926,7 @@
>  	 */
>  	busaddr = pci_map_page(hostdata->pci_dev,
>  			       virt_to_page(&hostdata->control_block),
> -			       ((unsigned long) &hostdata->control_block &
> -				~PAGE_MASK),
> +			       virt_to_pageoff(&hostdata->control_block),
>  			       sizeof(hostdata->control_block),
>  			       PCI_DMA_BIDIRECTIONAL);

Dito.

> --- linux-2.6/drivers/scsi/sym53c8xx.c	18 Jul 2003 16:56:15 -0000	1.39
> +++ linux-2.6/drivers/scsi/sym53c8xx.c	10 Aug 2003 09:30:33 -0000
> @@ -1162,8 +1162,7 @@
>  
>  	mapping = pci_map_page(pdev,
>  			       virt_to_page(cmd->request_buffer),
> -			       ((unsigned long)cmd->request_buffer &
> -				~PAGE_MASK),
> +			       virt_to_pageoff(cmd->request_buffer),

Dito.

> --- linux-2.6/drivers/scsi/arm/scsi.h	19 May 2003 17:48:30 -0000	1.2
> +++ linux-2.6/drivers/scsi/arm/scsi.h	10 Aug 2003 09:30:33 -0000
> @@ -23,7 +23,7 @@
>  	BUG_ON(bufs + 1 > max);
>  
>  	sg->page   = virt_to_page(SCp->ptr);
> -	sg->offset = ((unsigned int)SCp->ptr) & ~PAGE_MASK;
> +	sg->offset = virt_to_pageoff(SCp->ptr);
>  	sg->length = SCp->this_residual;

Dito.

