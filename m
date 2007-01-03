Return-Path: <linux-kernel-owner+w=401wt.eu-S1753974AbXACCzY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753974AbXACCzY (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 21:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753961AbXACCzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 21:55:23 -0500
Received: from mail0.lsil.com ([147.145.40.20]:39459 "EHLO mail0.lsil.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753952AbXACCzW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 21:55:22 -0500
X-Greylist: delayed 1065 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Jan 2007 21:55:22 EST
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Patch] scsi: megaraid_{mm,mbox}: init fix for kdump
Date: Tue, 2 Jan 2007 19:37:25 -0700
Message-ID: <0631C836DBF79F42B5A60C8C8D4E822985CB89@NAMAIL2.ad.lsil.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Patch] scsi: megaraid_{mm,mbox}: init fix for kdump
Thread-Index: AccrkzKuKiBZsxGcRD6ibk19cfLVGwDTNSpQ
From: "Patro, Sumant" <Sumant.Patro@lsi.com>
To: "Randy Dunlap" <rdunlap@xenotime.net>
Cc: <James.Bottomley@SteelEye.com>, <akpm@osdl.org>,
       <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       "Kolli, Neela" <Neela.Kolli@lsi.com>, "Yang, Bo" <Bo.Yang@lsi.com>
X-OriginalArrivalTime: 03 Jan 2007 02:37:26.0837 (UTC) FILETIME=[1B446E50:01C72EE0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for the review. 
I will resubmit the patch.

Regards,

Sumant

-----Original Message-----
From: Randy Dunlap [mailto:rdunlap@xenotime.net] 
Sent: Friday, December 29, 2006 1:38 PM
To: Patro, Sumant
Cc: James.Bottomley@SteelEye.com; akpm@osdl.org;
linux-scsi@vger.kernel.org; linux-kernel@vger.kernel.org; Kolli, Neela;
Yang, Bo; Patro, Sumant
Subject: Re: [Patch] scsi: megaraid_{mm,mbox}: init fix for kdump

On Fri, 29 Dec 2006 08:02:17 -0800 Sumant Patro wrote:

See Documentation/SubmittingPatches:
Please include output of "diffstat -p1 -w70" so that we can easily see
the scope of the changes.

and see Documentation/CodingStyle for comments below:


> diff -uprN linux-2.6.orig/drivers/scsi/megaraid/megaraid_mbox.c 
> linux-2.6.new/drivers/scsi/megaraid/megaraid_mbox.c
> --- linux-2.6.orig/drivers/scsi/megaraid/megaraid_mbox.c 2006-12-28 
> 09:56:04.000000000 -0800
> +++ linux-2.6.new/drivers/scsi/megaraid/megaraid_mbox.c 2006-12-29 
> +++ 05:31:48.000000000 -0800
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
>  	// Set the DMA mask to 64-bit. All supported controllers as
capable 
> of @@ -3380,6 +3388,86 @@ megaraid_mbox_flush_cache(adapter_t *ada
>  
>  
>  /**
> + * megaraid_mbox_fire_sync_cmd - fire the sync cmd
> + * @param adapter	: soft state for the controller
> + */
> +static int
> +megaraid_mbox_fire_sync_cmd(adapter_t *adapter) {
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

Don't use // comment style.  Also, for multi-line comments in Linux,
please use this preferred style:

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
