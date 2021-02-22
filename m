Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9FEC433DB
	for <io-uring@archiver.kernel.org>; Mon, 22 Feb 2021 07:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9A0964EB4
	for <io-uring@archiver.kernel.org>; Mon, 22 Feb 2021 07:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhBVHMy (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 22 Feb 2021 02:12:54 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:53666 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229947AbhBVHMx (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 22 Feb 2021 02:12:53 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UPBmH-E_1613977928;
Received: from B-D1K7ML85-0059.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0UPBmH-E_1613977928)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 22 Feb 2021 15:12:09 +0800
Subject: Re: [PATCH] block: fix potential IO hang when turning off io_poll
To:     Jeffle Xu <jefflexu@linux.alibaba.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, io-uring@vger.kernel.org
References: <20210222065452.21897-1-jefflexu@linux.alibaba.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <c44800f0-8f88-55e5-adae-ce920a15069a@linux.alibaba.com>
Date:   Mon, 22 Feb 2021 15:12:08 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210222065452.21897-1-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org



On 2/22/21 2:54 PM, Jeffle Xu wrote:
> QUEUE_FLAG_POLL flag will be cleared when turning off 'io_poll', while
> at that moment there may be IOs stuck in hw queue uncompleted. The
> following polling routine won't help reap these IOs, since blk_poll()
> will return immediately because of cleared QUEUE_FLAG_POLL flag. Thus
> these IOs will hang until they finnaly time out. The hang out can be
> observed by 'fio --engine=io_uring iodepth=1', while turning off
> 'io_poll' at the same time.
> 
> To fix this, freeze and flush the request queue first when turning off
> 'io_poll'.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  block/blk-sysfs.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index b513f1683af0..10d74741c002 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -430,8 +430,11 @@ static ssize_t queue_poll_store(struct request_queue *q, const char *page,
>  
>  	if (poll_on)
>  		blk_queue_flag_set(QUEUE_FLAG_POLL, q);
> -	else
> +	else {
> +		blk_mq_freeze_queue(q);
>  		blk_queue_flag_clear(QUEUE_FLAG_POLL, q);
> +		blk_mq_unfreeze_queue(q);
> +	}
>  
>  	return ret;
>  }
> 

Better to place brace to 'if' as well.

Thanks,
Joseph


