Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750903AbWIUHT7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbWIUHT7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 03:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750910AbWIUHT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 03:19:59 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:49836 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750902AbWIUHT6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 03:19:58 -0400
Date: Thu, 21 Sep 2006 00:20:17 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Om Narasimhan <om.turyx@gmail.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org
Subject: Re: [KJ] kmalloc to kzalloc patches for drivers/block [sane version]
Message-ID: <20060921072017.GA27798@us.ibm.com>
References: <6b4e42d10609202311t47038692x5627f51d69f28209@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b4e42d10609202311t47038692x5627f51d69f28209@mail.gmail.com>
X-Operating-System: Linux 2.6.18-rc6 (x86_64)
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.09.2006 [23:11:25 -0700], Om Narasimhan wrote:
> This patch changes the kmalloc() calls followed by memset(,0,) to kzalloc.
> 
>     cciss.c : Changed the kmalloc/memset pair to kzalloc
>     cpqarray.c : km2zalloc conversion and code size reduction by
> changing multiple cleanup calls and returns of the function
> getgeometry() by adding a label.
>     loop.c : km2zalloc converion
> 
> 
> Signed off by Om Narasimhan <om.turyx@gmail.com>

This is not the canonical format, per SubmittingPatches. It should be:

Signed-off-by: Random J Developer <random@developer.example.org>

>  drivers/block/cciss.c    |    4 +--
>  drivers/block/cpqarray.c |   72 +++++++++++++++-------------------------------
>  drivers/block/loop.c     |    4 +--
>  3 files changed, 25 insertions(+), 55 deletions(-)

Your diffstat should have indicated to you that this should be split up
better. Please (re-)read SubmittingPatches. *One* logical change per
patch, most importantly.

> 
> diff --git a/drivers/block/cciss.c b/drivers/block/cciss.c
> index 2cd3391..a800a69 100644
> --- a/drivers/block/cciss.c
> +++ b/drivers/block/cciss.c
> @@ -900,7 +900,7 @@ #if 0				/* 'buf_size' member is 16-bits
>  				return -EINVAL;
>  #endif
>  			if (iocommand.buf_size > 0) {
> -				buff = kmalloc(iocommand.buf_size, GFP_KERNEL);
> +				buff = kzalloc(iocommand.buf_size, GFP_KERNEL);
>  				if (buff == NULL)
>  					return -EFAULT;
>  			}
> @@ -911,8 +911,6 @@ #endif
>  					kfree(buff);
>  					return -EFAULT;
>  				}
> -			} else {
> -				memset(buff, 0, iocommand.buf_size);
>  			}
>  			if ((c = cmd_alloc(host, 0)) == NULL) {
>  				kfree(buff);

This changes performance potentially, no? The memset before was
conditional upon (iocommand.Request.Type.Direction == XFER_WRITE) and
now the memory will always be zero'd.

> diff --git a/drivers/block/cpqarray.c b/drivers/block/cpqarray.c
> index 78082ed..8a697c7 100644
> --- a/drivers/block/cpqarray.c
> +++ b/drivers/block/cpqarray.c
> @@ -1642,58 +1639,46 @@ static void start_fwbk(int ctlr)
>      It is used only at init time.
>  *****************************************************************/
>  static void getgeometry(int ctlr)
> -{				
> -	id_log_drv_t *id_ldrive;
> -	id_ctlr_t *id_ctlr_buf;
> -	sense_log_drv_stat_t *id_lstatus_buf;
> -	config_t *sense_config_buf;
> +{

Unrelated whitespace change.

> +	id_log_drv_t *id_ldrive = NULL;
> +	id_ctlr_t *id_ctlr_buf = NULL;
> +	sense_log_drv_stat_t *id_lstatus_buf = NULL;
> +	config_t *sense_config_buf = NULL;

Why initialize if you're going to immediately assign the return of
kzalloc()?

>  	unsigned int log_unit, log_index;
>  	int ret_code, size;
> -	drv_info_t *drv;
> +	drv_info_t *drv = NULL;

What does this do? Seems unnecessary and unrelated.

<snip>

> -		kfree(id_ctlr_buf);
> -		kfree(id_ldrive);
>  		printk( KERN_ERR "cpqarray:  out of memory.\n");
> -		return;
> +		goto end;

All of this rearrangement needs to be a separate patch.

Thanks,
Nish

-- 
Nishanth Aravamudan <nacc@us.ibm.com>
IBM Linux Technology Center
