Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030470AbVKIAa5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030470AbVKIAa5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 19:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030469AbVKIAa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 19:30:57 -0500
Received: from tornado.reub.net ([202.89.145.182]:41184 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S1030422AbVKIAa4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 19:30:56 -0500
Message-ID: <4371433D.3080402@reub.net>
Date: Wed, 09 Nov 2005 13:30:53 +1300
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 1.6a1 (Windows/20051107)
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: Andrew Morton <akpm@osdl.org>, neilb@suse.de, linux-kernel@vger.kernel.org,
       Alan Stern <stern@rowland.harvard.edu>, linux-scsi@vger.kernel.org
Subject: Re: 2.6.14-mm1
References: <20051106182447.5f571a46.akpm@osdl.org>	 <436F2452.9020207@reub.net> <20051107020905.69c0b6dc.akpm@osdl.org>	 <17263.11214.992300.34384@cse.unsw.edu.au>	 <20051107023723.5cf63393.akpm@osdl.org> <436F3020.1040209@reub.net>	 <20051107105257.333248c0.akpm@osdl.org> <1131459667.3270.8.camel@mulgrave>
In-Reply-To: <1131459667.3270.8.camel@mulgrave>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi,

On 9/11/2005 3:21 a.m., James Bottomley wrote:
> On Mon, 2005-11-07 at 10:52 -0800, Andrew Morton wrote:
>> sd_issue_flush() has been altered to run scsi_disk_get_from_dev(), which
>> takes a semaphore.  It does this from within spinlock and, as we see here,
>> from within softirq.
>>
>> Methinks the people who developed and tested that patch forgot to enable
>> CONFIG_PREEMPT, CONFIG_DEBUG_KERNEL, CONFIG_DEBUG_SLAB,
>> CONFIG_DEBUG_SPINLOCK and CONFIG_DEBUG_SPINLOCK_SLEEP.
> 
> Actually, I do too (as far as I can on non-x86).  I assume you also need
> a filesystem that excites this, though.
> 
> Try the attached: We can probably rely on the block device having opened
> the sd device, so there should already be a reference held on the
> scsi_disk ... well that's my theory and I'm sticking to it.
> 
> James
> 
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -769,20 +769,16 @@ static void sd_end_flush(request_queue_t
>  static int sd_prepare_flush(request_queue_t *q, struct request *rq)
>  {
>  	struct scsi_device *sdev = q->queuedata;
> -	struct scsi_disk *sdkp = scsi_disk_get_from_dev(&sdev->sdev_gendev);
> -	int ret = 0;
> +	struct scsi_disk *sdkp = dev_get_drvdata(&sdev->sdev_gendev);
>  
> -	if (sdkp) {
> -		if (sdkp->WCE) {
> -			memset(rq->cmd, 0, sizeof(rq->cmd));
> -			rq->flags |= REQ_BLOCK_PC | REQ_SOFTBARRIER;
> -			rq->timeout = SD_TIMEOUT;
> -			rq->cmd[0] = SYNCHRONIZE_CACHE;
> -			ret = 1;
> -		}
> -		scsi_disk_put(sdkp);
> -	}
> -	return ret;
> +	if (!sdkp || !sdkp->WCE)
> +		return 0;
> +
> +	memset(rq->cmd, 0, sizeof(rq->cmd));
> +	rq->flags |= REQ_BLOCK_PC | REQ_SOFTBARRIER;
> +	rq->timeout = SD_TIMEOUT;
> +	rq->cmd[0] = SYNCHRONIZE_CACHE;
> +	return 1;
>  }
>  
>  static void sd_rescan(struct device *dev)

Yup, with that patch it all works now.  Thanks James!

FWIW, the filesystem on the raid md's is a reiserfs (reiserfs v3 that is).

reuben

