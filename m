Return-Path: <linux-kernel-owner+w=401wt.eu-S965115AbWL2VtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965115AbWL2VtU (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 16:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965168AbWL2VtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 16:49:20 -0500
Received: from xenotime.net ([66.160.160.81]:37743 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965115AbWL2VtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 16:49:19 -0500
Date: Fri, 29 Dec 2006 13:37:41 -0800
From: Randy Dunlap <rdunlap@xenotime.net>
To: Sumant Patro <sumantp@lsil.com>
Cc: James.Bottomley@SteelEye.com, akpm@osdl.org, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, neela.kolli@lsi.com, bo.yang@lsi.com,
       sumant.patro@lsi.com
Subject: Re: [Patch] scsi: megaraid_{mm,mbox}: init fix for kdump
Message-Id: <20061229133741.441a5933.rdunlap@xenotime.net>
In-Reply-To: <1167408137.4154.8.camel@dumbo>
References: <1167408137.4154.8.camel@dumbo>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Dec 2006 08:02:17 -0800 Sumant Patro wrote:

See Documentation/SubmittingPatches:
Please include output of "diffstat -p1 -w70" so that we can easily see
the scope of the changes.

and see Documentation/CodingStyle for comments below:


> diff -uprN linux-2.6.orig/drivers/scsi/megaraid/megaraid_mbox.c linux-2.6.new/drivers/scsi/megaraid/megaraid_mbox.c
> --- linux-2.6.orig/drivers/scsi/megaraid/megaraid_mbox.c 2006-12-28 09:56:04.000000000 -0800
> +++ linux-2.6.new/drivers/scsi/megaraid/megaraid_mbox.c 2006-12-29 05:31:48.000000000 -0800
> @@ -779,6 +780,22 @@ megaraid_init_mbox(adapter_t *adapter)
>  		goto out_release_regions;
>  	}
>  
> +	// initialize the mutual exclusion lock for the mailbox
> +	spin_lock_init(&raid_dev->mailbox_lock);

Linux uses /*...*/ C89-style comments, not // C99 comments.

> +	// allocate memory required for commands
> +	if (megaraid_alloc_cmd_packets(adapter) != 0) {
> +		goto out_iounmap;
> +	}
> +
> +	/*
> +	 * Issue SYNC cmd to flush the pending cmds in the adapter
> +	 * and initialize its internal state
> +	 */
> +
> +	if (megaraid_mbox_fire_sync_cmd(adapter))
> +		con_log(CL_ANN, ("megaraid: sync cmd failed\n"));
> +

>  	// Product info
>  	if (megaraid_mbox_product_info(adapter) != 0) {
> -		goto out_alloc_cmds;
> +		goto out_free_irq;

Don't uses {} braces around 1-statement "blocks".

> @@ -875,7 +883,7 @@ megaraid_init_mbox(adapter_t *adapter)
>  	 * accessed
>  	 */
>  	if (megaraid_sysfs_alloc_resources(adapter) != 0) {
> -		goto out_alloc_cmds;
> +		goto out_free_irq;

Ditto.

>  	}
>  
>  	// Set the DMA mask to 64-bit. All supported controllers as capable of
> @@ -3380,6 +3388,86 @@ megaraid_mbox_flush_cache(adapter_t *ada
>  
>  
>  /**
> + * megaraid_mbox_fire_sync_cmd - fire the sync cmd
> + * @param adapter	: soft state for the controller
> + */
> +static int
> +megaraid_mbox_fire_sync_cmd(adapter_t *adapter)
> +{
> +	mbox_t	*mbox;
> +	uint8_t	raw_mbox[sizeof(mbox_t)];
> +	mraid_device_t	*raid_dev = ADAP2RAIDDEV(adapter);
> +	mbox64_t *mbox64;
> +	uint8_t	status = 0;
> +	int i;
> +	uint32_t dword;
> +
> +	mbox = (mbox_t *)raw_mbox;
> +
> +	memset((caddr_t)raw_mbox, 0, sizeof(mbox_t));
> +
> +	raw_mbox[0] = 0xFF;
> +
> +	mbox64	= raid_dev->mbox64;
> +	mbox	= raid_dev->mbox;
> +
> +	/*
> +	 * Wait until mailbox is free
> +	 */
> +	if (megaraid_busywait_mbox(raid_dev) != 0) {
> +		status = 1;
> +		goto blocked_mailbox;
> +	}
> +
> +	/*
> +	 * Copy mailbox data into host structure
> +	 */
> +	memcpy((caddr_t)mbox, (caddr_t)raw_mbox, 16);
> +	mbox->cmdid		= 0xFE;
> +	mbox->busy		= 1;
> +	mbox->poll		= 0;
> +	mbox->ack		= 0;
> +	mbox->numstatus		= 0;
> +	mbox->status		= 0;
> +
> +	wmb();
> +	WRINDOOR(raid_dev, raid_dev->mbox_dma | 0x1);
> +
> +	// wait for maximum 1 min for status to post.
> +	// If the Firmware SUPPORTS the ABOVE COMMAND,
> +	// mbox->cmd will be set to 0
> +	// else
> +	// the firmware will reject the command with
> +	// mbox->numstatus set to 1

Don't use // comment style.  Also, for multi-line comments
in Linux, please use this preferred style:

	/*
	 * This is the preferred style for multi-line
	 * comments in the Linux kernel source code.
	 * Please use it consistently.
	 *
	 * Description:  A column of asterisks on the left side,
	 * with beginning and ending almost-blank lines.
	 */

Thanks.
---
~Randy
