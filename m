Return-Path: <linux-kernel-owner+w=401wt.eu-S936851AbWLKPzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936851AbWLKPzT (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 10:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936850AbWLKPzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 10:55:19 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:47036 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936815AbWLKPzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 10:55:17 -0500
Message-ID: <457D7F5C.8040609@pobox.com>
Date: Mon, 11 Dec 2006 10:55:08 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: Arnd Bergmann <arnd.bergmann@de.ibm.com>, linux-ide@vger.kernel.org,
       linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libata: don't initialize sg in ata_exec_internal() if
 DMA_NONE
References: <200612081914.41810.arnd.bergmann@de.ibm.com> <20061211140258.GB18947@htj.dyndns.org>
In-Reply-To: <20061211140258.GB18947@htj.dyndns.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> Calling sg_init_one() with NULL buf causes oops on certain
> configurations.  Don't initialize sg in ata_exec_internal() if
> DMA_NONE and make the function complain if @buf is NULL when dma_dir
> isn't DMA_NONE.  While at it, fix comment.
> 
> The problem is discovered and initial patch was submitted by Arnd
> Bergmann.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>
> ---
> 
> Hello, Arnd Bergmann.
> 
> Thanks for spotting and fixing this but ata_exec_internal_nodma() is
> almost identical to ata_do_simple_cmd() and ata_exec_internal() itself
> needs fixing anyway.  This patch just fixes ata_exec_internal().  I'll
> follow up with conversion to ata_do_simple_cmd().
> 
> Thanks.
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 011c0a8..70e02e9 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -1332,7 +1332,7 @@ unsigned ata_exec_internal_sg(struct ata_device *dev,
>  }
>  
>  /**
> - *	ata_exec_internal_sg - execute libata internal command
> + *	ata_exec_internal - execute libata internal command
>   *	@dev: Device to which the command is sent
>   *	@tf: Taskfile registers for the command and the result
>   *	@cdb: CDB for packet command
> @@ -1354,10 +1354,15 @@ unsigned ata_exec_internal(struct ata_device *dev,
>  			   int dma_dir, void *buf, unsigned int buflen)
>  {
>  	struct scatterlist sg;
> +	unsigned int n_elem = 0;
>  
> -	sg_init_one(&sg, buf, buflen);
> +	if (dma_dir != DMA_NONE) {
> +		WARN_ON(!buf);
> +		sg_init_one(&sg, buf, buflen);
> +		n_elem++;
> +	}
>  
> -	return ata_exec_internal_sg(dev, tf, cdb, dma_dir, &sg, 1);
> +	return ata_exec_internal_sg(dev, tf, cdb, dma_dir, &sg, n_elem);

ACK, if you conditionally replace "&sg" with NULL.  That's the safer 
choice, as it guarantees (via an oops) that the user will not be 
touching sg, if dma_dir==DMA_NONE.

	Jeff



