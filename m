Return-Path: <SRS0=yVW0=AT=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6FFC433DF
	for <io-uring@archiver.kernel.org>; Wed,  8 Jul 2020 15:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E67D0206DF
	for <io-uring@archiver.kernel.org>; Wed,  8 Jul 2020 15:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730118AbgGHPkM (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 8 Jul 2020 11:40:12 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:43727 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729022AbgGHPkM (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 8 Jul 2020 11:40:12 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07425;MF=xiaoguang.wang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0U27yzx8_1594222799;
Received: from 192.168.124.22(mailfrom:xiaoguang.wang@linux.alibaba.com fp:SMTPD_---0U27yzx8_1594222799)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 08 Jul 2020 23:40:00 +0800
Subject: Re: [PATCH] io_uring: export cq overflow status to userspace
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, joseph.qi@linux.alibaba.com
References: <c4e40cba-4171-a253-8813-ca833c8ce575@linux.alibaba.com>
 <D59FC4AE-8D3B-44F4-A6AA-91722D97E202@kernel.dk>
 <83a3a0eb-8dea-20ad-ffc5-619226b47998@linux.alibaba.com>
 <f2cad5fb-7daf-611e-91dd-81d3eb268d26@kernel.dk>
From:   Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Message-ID: <54ce9903-4016-5b30-2fe9-397da9161bfe@linux.alibaba.com>
Date:   Wed, 8 Jul 2020 23:39:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f2cad5fb-7daf-611e-91dd-81d3eb268d26@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

hi,

> On 7/7/20 11:29 PM, Xiaoguang Wang wrote:
>> I modify above test program a bit:
>> #include <errno.h>
>> #include <stdio.h>
>> #include <unistd.h>
>> #include <stdlib.h>
>> #include <string.h>
>> #include <fcntl.h>
>> #include <assert.h>
>>
>> #include "liburing.h"
>>
>> static void test_cq_overflow(struct io_uring *ring)
>> {
>>           struct io_uring_cqe *cqe;
>>           struct io_uring_sqe *sqe;
>>           int issued = 0;
>>           int ret = 0;
>>           int i;
>>
>>           for (i = 0; i < 33; i++) {
>>                   sqe = io_uring_get_sqe(ring);
>>                   if (!sqe) {
>>                           fprintf(stderr, "get sqe failed\n");
>>                           break;;
>>                   }
>>                   ret = io_uring_submit(ring);
>>                   if (ret <= 0) {
>>                           if (ret != -EBUSY)
>>                                   fprintf(stderr, "sqe submit failed: %d\n", ret);
>>                           break;
>>                   }
>>                   issued++;
>>           }
>>
>>           printf("issued requests: %d\n", issued);
>>
>>           while (issued) {
>>                   ret = io_uring_peek_cqe(ring, &cqe);
>>                   if (ret) {
>>                           if (ret != -EAGAIN) {
>>                                   fprintf(stderr, "peek completion failed: %s\n",
>>                                           strerror(ret));
>>                                   break;
>>                           }
>>                           printf("left requets: %d %d\n", issued, IO_URING_READ_ONCE(*ring->sq.kflags));
>>                           continue;
>>                   }
>>                   io_uring_cqe_seen(ring, cqe);
>>                   issued--;
>>                   printf("left requets: %d\n", issued);
>>           }
>> }
>>
>> int main(int argc, char *argv[])
>> {
>>           int ret;
>>           struct io_uring ring;
>>
>>           ret = io_uring_queue_init(16, &ring, 0);
>>           if (ret) {
>>                   fprintf(stderr, "ring setup failed: %d\n", ret);
>>                   return 1;
>>           }
>>
>>           test_cq_overflow(&ring);
>>           return 0;
>> }
>>
>> Though with your patches applied, we still can not peek the last cqe.
>> This test program will only issue 33 sqes, so it won't get EBUSY error.
> 
> How about we make this even simpler, then - make the
> IORING_SQ_CQ_OVERFLOW actually track the state, rather than when we fail
> on submission. The liburing change would be the same, the kernel side
> would then look like the below.
> 
> 
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 4c9a494c9f9f..01981926cdf4 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -1342,6 +1342,7 @@ static bool io_cqring_overflow_flush(struct io_ring_ctx *ctx, bool force)
>   	if (cqe) {
>   		clear_bit(0, &ctx->sq_check_overflow);
>   		clear_bit(0, &ctx->cq_check_overflow);
> +		ctx->rings->sq_flags &= ~IORING_SQ_CQ_OVERFLOW;
>   	}
>   	spin_unlock_irqrestore(&ctx->completion_lock, flags);
>   	io_cqring_ev_posted(ctx);
> @@ -1379,6 +1380,7 @@ static void __io_cqring_fill_event(struct io_kiocb *req, long res, long cflags)
>   		if (list_empty(&ctx->cq_overflow_list)) {
>   			set_bit(0, &ctx->sq_check_overflow);
>   			set_bit(0, &ctx->cq_check_overflow);
> +			ctx->rings->sq_flags |= IORING_SQ_CQ_OVERFLOW;
>   		}
>   		req->flags |= REQ_F_OVERFLOW;
>   		refcount_inc(&req->refs);
> @@ -6375,9 +6377,9 @@ static int io_sq_thread(void *data)
>   			}
>   
>   			/* Tell userspace we may need a wakeup call */
> +			spin_lock_irq(&ctx->completion_lock);
>   			ctx->rings->sq_flags |= IORING_SQ_NEED_WAKEUP;
> -			/* make sure to read SQ tail after writing flags */
> -			smp_mb();
> +			spin_unlock_irq(&ctx->completion_lock);
>   
>   			to_submit = io_sqring_entries(ctx);
>   			if (!to_submit || ret == -EBUSY) {
> @@ -6400,7 +6402,9 @@ static int io_sq_thread(void *data)
>   			}
>   			finish_wait(&ctx->sqo_wait, &wait);
>   
> +			spin_lock_irq(&ctx->completion_lock);
>   			ctx->rings->sq_flags &= ~IORING_SQ_NEED_WAKEUP;
> +			spin_unlock_irq(&ctx->completion_lock);
>   		}
>   
>   		mutex_lock(&ctx->uring_lock);
> diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
> index 8d033961cb78..91953b543125 100644
> --- a/include/uapi/linux/io_uring.h
> +++ b/include/uapi/linux/io_uring.h
> @@ -198,6 +198,7 @@ struct io_sqring_offsets {
>    * sq_ring->flags
>    */
>   #define IORING_SQ_NEED_WAKEUP	(1U << 0) /* needs io_uring_enter wakeup */
> +#define IORING_SQ_CQ_OVERFLOW	(1U << 1) /* app needs to enter kernel */
>   
>   struct io_cqring_offsets {
>   	__u32 head;
> 
Looks good, I think it'll work now.
I'll test and send patches soon, thanks.

Regards,
Xiaoguang Wang

