Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030514AbVIJCAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030514AbVIJCAG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 22:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030516AbVIJCAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 22:00:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26498 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030514AbVIJCAD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 22:00:03 -0400
Date: Fri, 9 Sep 2005 18:59:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: mikem@beardog.cca.cpqcorp.ne
Cc: mike.miller@hp.com, axboe@suse.de, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH 3/8] cciss: new disk register/deregister routines
Message-Id: <20050909185925.2ae69954.akpm@osdl.org>
In-Reply-To: <20050909220435.GC4616@beardog.cca.cpqcorp.net>
References: <20050909220435.GC4616@beardog.cca.cpqcorp.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mike.miller@hp.com wrote:
>
> Patch 3 of 8
> This patch removes a couple of functions dealing  with configuration and
> replaces them with new functions. This implementation fixes some bugs
> associated with the ACUXE. It also allows a logical volume to be removed
> from the middle without deleting all volumes behind it.
> If a user has 5 logical volumes and decides he wants to reconfigure volume
> number 3, he can now do that without removing volumes 4 & 5 first. This
> code has been tested in our labs against all application software.
> Please consider this for inclusion.
> 
> ...
>
> +static void cciss_update_drive_info(int ctlr, int drv_index)
> +  {
> +	ctlr_info_t *h = hba[ctlr];
> +	struct gendisk *disk;
> +	ReadCapdata_struct *size_buff = NULL;
> +	InquiryData_struct *inq_buff = NULL;
> +	unsigned int block_size;
> +	unsigned int total_size;
> +	unsigned long flags = 0;
> +	int ret = 0;
> +
> +	/* if the disk already exists then deregister it before proceeding*/
> +	if (h->drv[drv_index].raid_level != -1){
> +		spin_lock_irqsave(CCISS_LOCK(h->ctlr), flags);
> +		h->drv[drv_index].busy_configuring = 1;
> +		spin_unlock_irqrestore(CCISS_LOCK(h->ctlr), flags);

I always get worried when I see a spinlock around a simple assignment like
this - it often doesn't make a lot of sense and can indicate that
something's wrong.

> ...
> +
> +	/* Get information about the disk and modify the driver sturcture */
> +	size_buff = kmalloc(sizeof( ReadCapdata_struct), GFP_KERNEL);
> +        if (size_buff == NULL)
> +		goto mem_msg;
> +	inq_buff = kmalloc(sizeof( InquiryData_struct), GFP_KERNEL);
> +       	if (inq_buff == NULL)
> +		goto mem_msg;

Indenting went wrong.

urgh, maybe it just looks wrong because someone's being inserting spaces
instead of tabs.

> +		ld_buff = kmalloc(sizeof(ReportLunData_struct), GFP_KERNEL);
> +		if (ld_buff == NULL)
> +			goto mem_msg;
> +		memset(ld_buff, 0, sizeof(ReportLunData_struct));

We have kzalloc() now.

>  	/* make sure logical volume is NOT is use */
> -	if( drv->usage_count > 1) {
> -		spin_unlock_irqrestore(CCISS_LOCK(ctlr), flags);
> +	if(clear_all || (h->gendisk[0] == disk)) {
> +                if (drv->usage_count > 1)
>                  return -EBUSY;

Again, it looks wrong but is probably OK due to broken tab key.

Do you want the code to go in like this or do you want to clean it up?
