Return-Path: <linux-kernel-owner+w=401wt.eu-S964786AbXASSOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbXASSOL (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 13:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbXASSOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 13:14:11 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:49940 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964786AbXASSOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 13:14:09 -0500
Message-ID: <45B10A6D.7030500@sgi.com>
Date: Fri, 19 Jan 2007 12:14:05 -0600
From: Michael Reed <mdr@sgi.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20060911)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] optimize o_direct on block device - v3
References: <000101c7198d$9a9fde40$ff0da8c0@amr.corp.intel.com>	<45A68E55.10601@sgi.com> <20070111112901.28085adf.akpm@osdl.org>
In-Reply-To: <20070111112901.28085adf.akpm@osdl.org>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Thanks again for finding the fix to the problem I reported.
Can you tell me when I might expect this fix to show up in
2.6.20-rc?

Thanks,
 Mike


Andrew Morton wrote:
> On Thu, 11 Jan 2007 13:21:57 -0600
> Michael Reed <mdr@sgi.com> wrote:
> 
>> Testing on my ia64 system reveals that this patch introduces a
>> data integrity error for direct i/o to a block device.  Device
>> errors which result in i/o failure do not propagate to the
>> process issuing direct i/o to the device.
>>
>> This can be reproduced by doing writes to a fibre channel block
>> device and then disabling the switch port connecting the host
>> adapter to the switch.
>>
> 
> Does this fix it?
> 
> <thwaps Ken>
> <thwaps compiler>
> <adds new entry to Documentation/SubmitChecklist>
> 
> diff -puN fs/block_dev.c~a fs/block_dev.c
> --- a/fs/block_dev.c~a
> +++ a/fs/block_dev.c
> @@ -146,7 +146,7 @@ static int blk_end_aio(struct bio *bio, 
>  		iocb->ki_nbytes = -EIO;
>  
>  	if (atomic_dec_and_test(bio_count)) {
> -		if (iocb->ki_nbytes < 0)
> +		if ((long)iocb->ki_nbytes < 0)
>  			aio_complete(iocb, iocb->ki_nbytes, 0);
>  		else
>  			aio_complete(iocb, iocb->ki_left, 0);
> _
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

