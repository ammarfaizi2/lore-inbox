Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265351AbRFVUid>; Fri, 22 Jun 2001 16:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265387AbRFVUiX>; Fri, 22 Jun 2001 16:38:23 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:45318 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S265351AbRFVUiL>; Fri, 22 Jun 2001 16:38:11 -0400
Date: Fri, 22 Jun 2001 17:21:06 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Rasmus Andersen <rasmus@jaquet.dk>
Cc: dwmw2@redhat.com, mtd@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cleanup in drivers/mtd/ftl.c (245-ac16)
Message-ID: <20010622172106.B3614@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Rasmus Andersen <rasmus@jaquet.dk>, dwmw2@redhat.com,
	mtd@infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20010622222931.C842@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20010622222931.C842@jaquet.dk>; from rasmus@jaquet.dk on Fri, Jun 22, 2001 at 10:29:31PM +0200
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rasmus,

	I've fixed this ones and its already in 2.4.6-pre5, please take a
look and see if something is missing.

- Arnaldo

Em Fri, Jun 22, 2001 at 10:29:31PM +0200, Rasmus Andersen escreveu:
> Hi.
> 
> The patch below adds one instance of vmalloc return code checking
> and a number of error path resource release cleanups in build_maps. 
> It is against 245-ac16.
> 
> (The vmalloc non-check was reported by the Stanford team a
> while back.)
> 
> 
> --- linux-245-ac16-clean/drivers/mtd/ftl.c	Sun May 27 22:15:23 2001
> +++ linux-245-ac16/drivers/mtd/ftl.c	Fri Jun 22 22:24:09 2001
> @@ -313,6 +313,7 @@
>      ssize_t retval;
>      loff_t offset;
>  
> +    ret = -1;
>      /* Set up erase unit maps */
>      part->DataUnits = le16_to_cpu(part->header.NumEraseUnits) -
>  	part->header.NumTransferUnits;
> @@ -324,7 +325,8 @@
>      part->XferInfo =
>  	kmalloc(part->header.NumTransferUnits * sizeof(struct xfer_info_t),
>  		GFP_KERNEL);
> -    if (!part->XferInfo) return -1;
> +    if (!part->XferInfo) 
> +	    goto err_free_EUInfo;
>  
>      xvalid = xtrans = 0;
>      for (i = 0; i < le16_to_cpu(part->header.NumEraseUnits); i++) {
> @@ -334,8 +336,9 @@
>  			      (unsigned char *)&header);
>  	
>  	if (ret) 
> -	    return ret;
> +	    goto err_free_XferInfo;
>  
> +	ret = -1;
>  	/* Is this a transfer partition? */
>  	hdr_ok = (strcmp(header.DataOrgTuple+3, "FTL100") == 0);
>  	if (hdr_ok && (le16_to_cpu(header.LogicalEUN) < part->DataUnits) &&
> @@ -348,7 +351,7 @@
>  	    if (xtrans == part->header.NumTransferUnits) {
>  		printk(KERN_NOTICE "ftl_cs: format error: too many "
>  		       "transfer units!\n");
> -		return -1;
> +		goto err_free_XferInfo;
>  	    }
>  	    if (hdr_ok && (le16_to_cpu(header.LogicalEUN) == 0xffff)) {
>  		part->XferInfo[xtrans].state = XFER_PREPARED;
> @@ -369,18 +372,21 @@
>  	(xvalid+xtrans != le16_to_cpu(header.NumEraseUnits))) {
>  	printk(KERN_NOTICE "ftl_cs: format error: erase units "
>  	       "don't add up!\n");
> -	return -1;
> +	goto err_free_XferInfo;
>      }
>      
>      /* Set up virtual page map */
>      blocks = le32_to_cpu(header.FormattedSize) >> header.BlockSize;
>      part->VirtualBlockMap = vmalloc(blocks * sizeof(u_int32_t));
> +    if (!part->VirtualBlockMap)
> +	    goto err_free_XferInfo;
>      memset(part->VirtualBlockMap, 0xff, blocks * sizeof(u_int32_t));
>      part->BlocksPerUnit = (1 << header.EraseUnitSize) >> header.BlockSize;
>  
>      part->bam_cache = kmalloc(part->BlocksPerUnit * sizeof(u_int32_t),
>  			      GFP_KERNEL);
> -    if (!part->bam_cache) return -1;
> +    if (!part->bam_cache) 
> +	    goto err_free_VirtualBlockMap;
>  
>      part->bam_index = 0xffff;
>      part->FreeTotal = 0;
> @@ -395,7 +401,7 @@
>  			      (unsigned char *)part->bam_cache);
>  	
>  	if (ret) 
> -	    return ret;
> +	    goto err_free_bam_cache;
>  
>  	for (j = 0; j < part->BlocksPerUnit; j++) {
>  	    if (BLOCK_FREE(le32_to_cpu(part->bam_cache[j]))) {
> @@ -411,7 +417,17 @@
>      }
>      
>      return 0;
> -    
> +
> +err_free_bam_cache:
> +    kfree(part->bam_cache);
> +err_free_VirtualBlockMap:
> +    vfree(part->VirtualBlockMap);
> +err_free_XferInfo:
> +    kfree(part->XferInfo);
> +err_free_EUInfo:
> +    kfree(part->EUNInfo);
> +    printk(KERN_ERR "ftl_cs: Out of memory.");
> +    return ret;
>  } /* build_maps */
>  
>  /*======================================================================
> 
> -- 
> Regards,
>         Rasmus(rasmus@jaquet.dk)
> 
> Open Source. Closed Minds. We are Slashdot. 
>   --Anonymous Coward
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 


                        - Arnaldo
