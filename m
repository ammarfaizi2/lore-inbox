Return-Path: <SRS0=tf6j=5Y=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A26C2D0EA
	for <io-uring@archiver.kernel.org>; Wed,  8 Apr 2020 05:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A7AD20730
	for <io-uring@archiver.kernel.org>; Wed,  8 Apr 2020 05:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgDHFnR (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 8 Apr 2020 01:43:17 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:36731 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725879AbgDHFnR (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 8 Apr 2020 01:43:17 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=xiaoguang.wang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0TuxsxJ5_1586324591;
Received: from 30.5.115.28(mailfrom:xiaoguang.wang@linux.alibaba.com fp:SMTPD_---0TuxsxJ5_1586324591)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 08 Apr 2020 13:43:12 +0800
Subject: Re: [PATCH] io_uring:IORING_SETUP_SQPOLL don't need to enter
 io_cqring_wait
To:     wu860403@gmail.com, io-uring@vger.kernel.org
Cc:     Liming Wu <19092205@suning.com>
References: <1586249075-14649-1-git-send-email-wu860403@gmail.com>
From:   Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Message-ID: <e8494d6e-ebb4-ce34-ba88-e6cd507ee939@linux.alibaba.com>
Date:   Wed, 8 Apr 2020 13:43:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1586249075-14649-1-git-send-email-wu860403@gmail.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

hi,

> From: Liming Wu <19092205@suning.com>
> 
> When SETUP_IOPOLL and SETUP_SQPOLL are both enabled, app don't
> need to enter io_cqring_wait too. If I misunderstand, please give
> me some advise.
> 
> Signed-off-by Liming Wu <19092205@suning.com>
> ---
>   io_uring.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/io_uring.c b/io_uring.c
> index b12d33b..36e884f 100644
> --- a/io_uring.c
> +++ b/io_uring.c
> @@ -7418,11 +7418,12 @@ SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
>   		 * polling again, they can rely on io_sq_thread to do polling
>   		 * work, which can reduce cpu usage and uring_lock contention.
>   		 */
> -		if (ctx->flags & IORING_SETUP_IOPOLL &&
> -		    !(ctx->flags & IORING_SETUP_SQPOLL)) {
> -			ret = io_iopoll_check(ctx, &nr_events, min_complete);
> -		} else {
> -			ret = io_cqring_wait(ctx, min_complete, sig, sigsz);
> +		if (!(ctx->flags & IORING_SETUP_SQPOLL)) {
> +		    if (ctx->flags & IORING_SETUP_IOPOLL) {
> +		    	ret = io_iopoll_check(ctx, &nr_events, min_complete);
> +		    } else {
> +		    	ret = io_cqring_wait(ctx, min_complete, sig, sigsz);
> +		    }
>   		}Indeed I had checked your patch yesterday, and also did not understand why you have
above modifications. For your codes, if IORING_SETUP_SQPOLL is enabed, we'll do
nothing for IORING_ENTER_GETEVENTS, I think it's not correct.

In patch's commit message, I think you should explain more why you make such
changes, what's the benefit? You can have a look at my previous patch:
     io_uring: io_uring_enter(2) don't poll while SETUP_IOPOLL|SETUP_SQPOLL enabled

Finally, seems like that your patch did't pass checkpatch.pl, you should checkpatch
before sending patches:)

Regards,
Xiaoguang Wang

>   	}
>   
> 
