Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264287AbUCPRlw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 12:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264258AbUCPRim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 12:38:42 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8145 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264246AbUCPRhZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 12:37:25 -0500
Message-ID: <40573B48.8090400@pobox.com>
Date: Tue, 16 Mar 2004 12:37:12 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mike.miller@hp.com
CC: axboe@suse.de, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: cpqarray patches for 2.6 [4 of 5]
References: <20040316164642.GE21377@beardog.cca.cpqcorp.net>
In-Reply-To: <20040316164642.GE21377@beardog.cca.cpqcorp.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mikem@beardog.cca.cpqcorp.net wrote:
> This is patch 4 of 5 for cpqarray. Please apply in order.
> 
> Thanks,
> mikem
> -------------------------------------------------------------------------------
>    - Change to use pci APIs (change from 2.4.18 to 2.4.19)
>      PS: This also includes eisa detection fix during initialization
>      which was missing from 2.4.19 but fixed in 2.4.25


While I like this patch a lot, there is one tiny bug I spotted, and one 
question:


> +	/* sendcmd will turn off interrupt, and send the flush...
> +	 * To write all data in the battery backed cache to disks
> +	 * no data returned, but don't want to send NULL to sendcmd */
> +	if( sendcmd(FLUSH_CACHE, i, buff, 4, 0, 0, 0))
> +	{
> +		printk(KERN_WARNING "Unable to flush cache on controller %d\n",
> +				i);
> +	}
> +	free_irq(hba[i]->intr, hba[i]);
> +	iounmap(hba[i]->vaddr);
> +	unregister_blkdev(COMPAQ_SMART2_MAJOR+i, hba[i]->devname);
> +	del_timer(&hba[i]->timer);

should this be del_timer_sync()?


> +	remove_proc_entry(hba[i]->devname, proc_array);
> +	pci_free_consistent(hba[i]->pci_dev,
> +			NR_CMDS * sizeof(cmdlist_t), (hba[i]->cmd_pool),
>  			hba[i]->cmd_pool_dhandle);
> -		kfree(hba[i]->cmd_pool_bits);
> +	kfree(hba[i]->cmd_pool_bits);
> +	for(j = 0; j < NWD; j++) {
> +		if (ida_gendisk[i][j]->flags & GENHD_FL_UP)
> +			del_gendisk(ida_gendisk[i][j]);
> +		devfs_remove("ida/c%dd%d",i,j);
> +		put_disk(ida_gendisk[i][j]);
> +	}
> +	blk_cleanup_queue(hba[i]->queue);
> +	release_io_mem(hba[i]);
> +	free_hba(i);
> +}
>  

> +	hba[i]->access.set_intr_mask(hba[i], 0);
> +	if (request_irq(hba[i]->intr, do_ida_intr,
> +		SA_INTERRUPT|SA_SHIRQ, hba[i]->devname, hba[i]))
> +	{
> +		printk(KERN_ERR "cpqarray: Unable to get irq %d for %s\n", 
>  				hba[i]->intr, hba[i]->devname);

Even though this line of code existed in the driver prior to your patch, 
  this highlights a bug:  SA_SHIRQ should really only be passed to 
request_irq() when the device is a PCI device.  If it's an EISA device, 
that really shouldn't be present.

I am also curious why SA_INTERRUPT is needed.  EISA requirement?

This patch gets my ACK otherwise...  I'm glad somebody did this.

	Jeff



