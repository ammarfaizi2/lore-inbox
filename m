Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D03C433DB
	for <io-uring@archiver.kernel.org>; Tue, 16 Mar 2021 02:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D35C365057
	for <io-uring@archiver.kernel.org>; Tue, 16 Mar 2021 02:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbhCPCla (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 15 Mar 2021 22:41:30 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:56187 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231214AbhCPClM (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 15 Mar 2021 22:41:12 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=haoxu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0US4Vh1x_1615862469;
Received: from B-25KNML85-0107.local(mailfrom:haoxu@linux.alibaba.com fp:SMTPD_---0US4Vh1x_1615862469)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 16 Mar 2021 10:41:10 +0800
Subject: Re: [PATCH] io_uring: don't iterate ctx list to update sq_thread_idle
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, Joseph Qi <joseph.qi@linux.alibaba.com>
References: <1615798614-1044-1-git-send-email-haoxu@linux.alibaba.com>
 <4caf1b47-56fd-85d8-87d0-ab7d43ac2914@gmail.com>
From:   Hao Xu <haoxu@linux.alibaba.com>
Message-ID: <f6833283-ccb2-2bb8-e987-575919f96e3b@linux.alibaba.com>
Date:   Tue, 16 Mar 2021 10:41:09 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <4caf1b47-56fd-85d8-87d0-ab7d43ac2914@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

在 2021/3/15 下午6:49, Pavel Begunkov 写道:
> On 15/03/2021 08:56, Hao Xu wrote:
>> sqd->sq_thread_idle can be updated by a simple max(), rather than
>> iterating the whole ctx list to get the max one.
> 
> I left it as a more fool proof option. Do you have a performance issue
> with it? E.g. dozens rings sharing a single SQPOLL and constantly adding
> new ones.
Currently no performance cases, just happen to see this and make
the code change.
> 
>>
>> Signed-off-by: Hao Xu <haoxu@linux.alibaba.com>
>> ---
>>   fs/io_uring.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>> index a4bce17af506..17697b9890e3 100644
>> --- a/fs/io_uring.c
>> +++ b/fs/io_uring.c
>> @@ -7871,7 +7871,7 @@ static int io_sq_offload_create(struct io_ring_ctx *ctx,
>>   			ret = -ENXIO;
>>   		} else {
>>   			list_add(&ctx->sqd_list, &sqd->ctx_list);
>> -			io_sqd_update_thread_idle(sqd);
>> +			sqd->sq_thread_idle = max(sqd->sq_thread_idle, ctx->sq_thread_idle);
>>   		}
>>   		io_sq_thread_unpark(sqd);
>>   
>>
> 

