Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE455C433EF
	for <io-uring@archiver.kernel.org>; Sat, 18 Sep 2021 06:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA79B60235
	for <io-uring@archiver.kernel.org>; Sat, 18 Sep 2021 06:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236712AbhIRGNO (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sat, 18 Sep 2021 02:13:14 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:44929 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229476AbhIRGNO (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sat, 18 Sep 2021 02:13:14 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=haoxu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UolL.lb_1631945508;
Received: from B-25KNML85-0107.local(mailfrom:haoxu@linux.alibaba.com fp:SMTPD_---0UolL.lb_1631945508)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 18 Sep 2021 14:11:49 +0800
Subject: Re: [PATCH 5/5] io_uring: leverage completion cache for poll requests
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, Joseph Qi <joseph.qi@linux.alibaba.com>
References: <20210917193820.224671-1-haoxu@linux.alibaba.com>
 <20210917193820.224671-6-haoxu@linux.alibaba.com>
 <fe379c0c-0eeb-6412-ffd7-69be2746745f@gmail.com>
From:   Hao Xu <haoxu@linux.alibaba.com>
Message-ID: <2ab8efb5-7927-cf1a-a1af-f4955f7d94f6@linux.alibaba.com>
Date:   Sat, 18 Sep 2021 14:11:48 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <fe379c0c-0eeb-6412-ffd7-69be2746745f@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

在 2021/9/18 上午4:39, Pavel Begunkov 写道:
> On 9/17/21 8:38 PM, Hao Xu wrote:
>> Leverage completion cache to handle completions of poll requests in a
>> batch.
>> Good thing is we save compl_nr - 1 completion_lock and
>> io_cqring_ev_posted.
>> Bad thing is compl_nr extra ifs in flush_completion.
> 
> It does something really wrong breaking all abstractions, we can't go
> with this. Can we have one of those below?
> - __io_req_complete(issue_flags), forwarding issue_flags from above
> - or maybe io_req_task_complete(), if we're in tw
Make sense. we may need to remove io_clean_op logic in
io_req_complete_state(), multishot reqs shouldn't do it, and it's ok for
normal reqs since we do it later in __io_submit_flush_completions->
io_req_free_batch->io_dismantle_req->io_clean_op, correct me if I'm
wrong.
I'll send another version later.

> 
> In any case, I'd recommend sending it separately from fixes.
> 

