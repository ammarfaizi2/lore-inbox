Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262081AbUJZGeb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbUJZGeb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 02:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262098AbUJZGeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 02:34:31 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:57830 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262081AbUJZGeJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 02:34:09 -0400
Date: Tue, 26 Oct 2004 08:33:25 +0200
From: Jens Axboe <axboe@suse.de>
To: Peter Osterlund <petero2@telia.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix incorrect Mt Rainier detection
Message-ID: <20041026063324.GA8306@suse.de>
References: <m3wtxeijjk.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3wtxeijjk.fsf@telia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25 2004, Peter Osterlund wrote:
> cdrom_is_mrw() can incorrectly think that a drive is Mt Rainier
> capable, because if forgets to check if the "GET CONFIGURATION"
> command returns the MRW feature number.  According to the MMC spec,
> the drive shall return all feature numbers >= the starting feature
> number, so even if the drive doesn't support Mt Rainier, it can return
> some data that makes cdrom_is_mrw() incorrectly think the drive is MRW
> capable.
> 
> This problem stops me from mounting DVD+RW discs in R/W mode on my
> laptop, because it makes cdrom_open_write() call
> cdrom_mrw_open_write() which fails because the drive isn't really MRW
> capable.
> 
> The fix is to make sure the returned feature number is the correct one
> for Mt Rainier.
> 
> Signed-off-by: Peter Osterlund <petero2@telia.com>

Acked-by: Jens Axboe <axboe@suse.de>

> ---
> 
>  linux-petero/drivers/cdrom/cdrom.c |    2 ++
>  1 files changed, 2 insertions(+)
> 
> diff -puN drivers/cdrom/cdrom.c~mrw-fix drivers/cdrom/cdrom.c
> --- linux/drivers/cdrom/cdrom.c~mrw-fix	2004-10-25 22:43:15.711347640 +0200
> +++ linux-petero/drivers/cdrom/cdrom.c	2004-10-25 22:43:15.716346880 +0200
> @@ -546,6 +546,8 @@ int cdrom_is_mrw(struct cdrom_device_inf
>  		return ret;
>  
>  	mfd = (struct mrw_feature_desc *)&buffer[sizeof(struct feature_header)];
> +	if (be16_to_cpu(mfd->feature_code) != CDF_MRW)
> +		return 1;
>  	*write = mfd->write;
>  
>  	if ((ret = cdrom_mrw_probe_pc(cdi))) {
> _
> 
> -- 
> Peter Osterlund - petero2@telia.com
> http://w1.894.telia.com/~u89404340
> 

-- 
Jens Axboe

