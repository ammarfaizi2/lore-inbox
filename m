Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263238AbUCPR3n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 12:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264210AbUCPR1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 12:27:00 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:49157 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264163AbUCPRSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 12:18:52 -0500
Date: Tue, 16 Mar 2004 17:17:20 +0000
From: Christoph Hellwig <hch@infradead.org>
To: mike.miller@hp.com
Cc: axboe@suse.de, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: cpqarray patches for 2.6 [4 of 5]
Message-ID: <20040316171720.A2710@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, mike.miller@hp.com,
	axboe@suse.de, akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20040316164642.GE21377@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040316164642.GE21377@beardog.cca.cpqcorp.net>; from mikem@beardog.cca.cpqcorp.net on Tue, Mar 16, 2004 at 10:46:42AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2004 at 10:46:42AM -0600, mikem@beardog.cca.cpqcorp.net wrote:
> +int cpqarray_init_step2(void);

Why is this non-static?

>  static int cpqarray_pci_init(ctlr_info_t *c, struct pci_dev *pdev);
>  static void *remap_pci_mem(ulong base, ulong size);
>  static int cpqarray_eisa_detect(void);
> @@ -119,6 +147,9 @@ static void start_fwbk(int ctlr);
>  static cmdlist_t * cmd_alloc(ctlr_info_t *h, int get_from_pool);
>  static void cmd_free(ctlr_info_t *h, cmdlist_t *c, int got_from_pool);
>  
> +static void free_hba(int i);

Argg.  Not holding back this patch, but could you please fix cpqarray
to pass around objects instead of indices?  That's how 90% of the drivers
work, it makes the code more redable and removes global arrays that limit
the max number of devices supported.

> +/* This is a bit of a hack, 
> + * necessary to support both eisa and pci
> + */
> +int __init cpqarray_init(void)
>  {
> -	int i, j;
> -	char buff[4]; 
> +	if(cpqarray_init_step2() == 0) 	/* all the block dev num already used */
> +		return -ENODEV;		/* or no controllers were found */
> +	return 0;
> +}

Why can't cpqarray_init_step2 be inlined in cpqarray_init directly?
Why is cpqarray_init non-static?
And what's the issue with EISA and PCI?  If you converted the driver
to the proper device-model based EISA probing API supporting both should
be really easy.

> +	del_timer(&hba[i]->timer);

You probably want a del_timer_sync here.

> +		if (ida_gendisk[i][j]->flags & GENHD_FL_UP)
> +			del_gendisk(ida_gendisk[i][j]);

How can the gendisk be non up?

> +	if (pci_get_drvdata(pdev) == NULL) {
> +		printk( KERN_ERR "cpqarray: Unable to remove device \n");
> +		return;
>  	}

Rather silly check.  if pci_get_drvdata(pdev) returns NULL the pci code
would be really badly hosed in which case a panic because of a NULL pointer
dereference is probably the best thing to keep the box from corrupting even
more data.

