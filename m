Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264382AbTICWun (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 18:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264406AbTICWum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 18:50:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:52143 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264382AbTICWu0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 18:50:26 -0400
Date: Wed, 3 Sep 2003 15:33:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: mike.miller@hp.com
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: cciss error handling patch for 2.6.0-test4
Message-Id: <20030903153332.2a5f03e7.akpm@osdl.org>
In-Reply-To: <20030903223347.GA11071@beardog.cca.cpqcorp.net>
References: <20030903223347.GA11071@beardog.cca.cpqcorp.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mike.miller@hp.com wrote:
>
> This patch was built & tested using 2.6.0-test4. It _hopefully_ cleans up the error handling in cciss_init_one().
> Please consider this for inclusion in the 2.6.0 kernel.
> 
> Thanks,
> mikem
> ------------------------------------------------------------------------------
> diff -burN lx260test4-p1/drivers/block/cciss.c lx260test4/drivers/block/cciss.c
> --- lx260test4-p1/drivers/block/cciss.c	2003-08-26 13:09:45.000000000 -0500
> +++ lx260test4/drivers/block/cciss.c	2003-08-26 14:01:12.000000000 -0500
> @@ -2447,11 +2447,8 @@
>  	if( i < 0 ) 
>  		return (-1);
>  	if (cciss_pci_init(hba[i], pdev) != 0)
> -	{
> -		release_io_mem(hba[i]);
> -		free_hba(i);
> -		return (-1);
> -	}
> +		goto clean1;
> +	
>  	sprintf(hba[i]->devname, "cciss%d", i);
>  	hba[i]->ctlr = i;
>  	hba[i]->pdev = pdev;
> @@ -2463,28 +2460,23 @@
>  		printk("cciss: not using DAC cycles\n");
>  	else {
>  		printk("cciss: no suitable DMA available\n");
> -		free_hba(i);
> -		return -ENODEV;
> +		goto clean0;
>  	}

But that change propagates an existing bug: a missing release_iomem().
This additional change is needed.

diff -puN drivers/block/cciss.c~cciss-error-handling-cleanup-fix drivers/block/cciss.c
--- 25/drivers/block/cciss.c~cciss-error-handling-cleanup-fix	Wed Sep  3 15:31:30 2003
+++ 25-akpm/drivers/block/cciss.c	Wed Sep  3 15:31:40 2003
@@ -2460,7 +2460,7 @@ static int __init cciss_init_one(struct 
 		printk("cciss: not using DAC cycles\n");
 	else {
 		printk("cciss: no suitable DMA available\n");
-		goto clean0;
+		goto clean1;
 	}
 
 	if (register_blkdev(COMPAQ_CISS_MAJOR+i, hba[i]->devname)) {
@@ -2568,7 +2568,6 @@ clean2:
 	unregister_blkdev(COMPAQ_CISS_MAJOR+i, hba[i]->devname);
 clean1:
 	release_io_mem(hba[i]);
-clean0:
 	free_hba(i);
 	return(-1);
 }

_

