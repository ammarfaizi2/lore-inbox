Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbVCaI1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbVCaI1Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 03:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbVCaI1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 03:27:24 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42392 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261186AbVCaI06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 03:26:58 -0500
Message-ID: <424BB443.1070508@pobox.com>
Date: Thu, 31 Mar 2005 03:26:43 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Yum Rayan <yum.rayan@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Reduce stack usage in time.c
References: <df35dfeb05033023463a986df4@mail.gmail.com>
In-Reply-To: <df35dfeb05033023463a986df4@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yum Rayan wrote:
> Attempt to reduce stack usage in time.c (linux-2.6.12-rc1-mm3). Stack
> usage was noted using checkstack.pl. Specifically:
> 
> Before patch
> ------------
> sys_adjtimex - 128
> 
> After patch
> -----------
> sys_adjtimex - none (register usage only)
> 
> Signed-off-by: Yum Rayan <yum.rayan@gmail.com>
> 
> --- a/kernel/time.c	2005-03-25 22:11:06.000000000 -0800
> +++ b/kernel/time.c	2005-03-30 16:59:51.000000000 -0800
> @@ -413,17 +413,27 @@
>  
>  asmlinkage long sys_adjtimex(struct timex __user *txc_p)
>  {
> -	struct timex txc;		/* Local copy of parameter */
> -	int ret;
> +	struct timex *txc;		/* Local copy of parameter */
> +	int retval;
> +
> +	txc = kmalloc(sizeof(struct timex), GFP_KERNEL);
> +	if (!txc)
> +		return -ENOMEM;
>  
>  	/* Copy the user data space into the kernel copy
>  	 * structure. But bear in mind that the structures
>  	 * may change
>  	 */
> -	if(copy_from_user(&txc, txc_p, sizeof(struct timex)))
> -		return -EFAULT;
> -	ret = do_adjtimex(&txc);
> -	return copy_to_user(txc_p, &txc, sizeof(struct timex)) ? -EFAULT : ret;
> +	if(copy_from_user(txc, txc_p, sizeof(struct timex))) {
> +		retval = -EFAULT;
> +		goto free_txc;
> +	}
> +	retval = do_adjtimex(txc);
> +	if (copy_to_user(txc_p, txc, sizeof(struct timex)))
> +		retval = -EFAULT;
> +free_txc:

It seems quite unhealthy to add a kmalloc(,GFP_KERNEL) allocation into a 
time-sensitive function.

	Jeff



